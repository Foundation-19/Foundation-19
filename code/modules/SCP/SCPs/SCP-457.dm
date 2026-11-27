// SCP-457 — The Burning Man.
// Heat thresholds: type of flame rises with heat.
#define SCP457_HEAT_THRESHOLD_BASIC		30
#define SCP457_HEAT_THRESHOLD_INTENSE	60
#define SCP457_HEAT_THRESHOLD_BLUE		90
// Heat caps.
#define SCP457_MAX_HEAT				120
#define SCP457_HEAT_GENERATION_RATE	2	// passive heat per UpdateHeat tick
#define SCP457_HEAT_DECAY_RATE		1	// passive decay per tick
// Spawn-restriction minimums (playable SCP gating is handled by /datum/scp).
#define SCP457_DOOR_MELT_TIME		5 SECONDS
#define SCP457_BLAST_MELT_TIME		16 SECONDS

// Flame economy tuning. SSmobs fires every 2s and the spread loop is
// gated to once per 10s — the original chance/duration values combined
// into "flames basically never appear and do nothing when they do".
#define SCP457_FLAME_SPREAD_INTERVAL	6 SECONDS
#define SCP457_FLAME_TRAIL_CHANCE		40	// per spread tick, above basic heat
#define SCP457_FLAME_SPREAD_CHANCE		25	// per existing flame per tick
#define SCP457_FLAME_STARTING_HEAT		35	// spawns already past basic threshold

/mob/living/simple_animal/hostile/scp457
	name = "humanoid flame"
	desc = "A horrible band of fire, it somehow keeps a humanoid shape. The heat radiating from it is unnatural."
	icon = 'icons/SCP/scp-457.dmi'
	icon_state = "fireguy"
	icon_dead = "fireguy_dead"
	status_flags = NO_ANTAG

	health = 300
	maxHealth = 300

	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7

	can_pull_size = 0
	a_intent = "harm"
	can_be_buckled = FALSE
	// F19 simple_animal has no speed var; movement speed handled by move delay.

	maxbodytemp = INFINITY
	minbodytemp = 0

	//Config
	///Attack cooldown
	var/aflame_cooldown_time = 1.5 SECONDS
	///Door cooldown base
	var/door_cooldown_base = 5 SECONDS

	//Mechanical
	var/door_cooldow_track = 0
	var/aflame_cooldown_track = 0
	var/area/spawn_area

	// --- Heat economy (the core of the overhaul) ---
	var/current_heat = SCP457_FLAME_STARTING_HEAT
	var/max_heat = SCP457_MAX_HEAT
	var/last_heat_update = 0
	var/suppression_factor = 0 // 0..1 — how hard the environment is killing our heat

	// --- Living flames (children of 457's body) ---
	var/list/active_fires = list()
	var/max_active_fires = 12
	var/spread_cooldown_track = 0

	// --- Ability cooldowns ---
	var/fireball_cooldown = 0
	var/consume_fuel_cooldown = 0
	var/flame_dash_cooldown = 0
	var/heat_vent_cooldown = 0
	var/fire_wall_cooldown = 0

	// --- Breach & containment tracking ---
	var/fires_at_peak = 0
	var/breach_announced = FALSE

/mob/living/simple_animal/hostile/scp457/Initialize()
	SCP = new /datum/scp(
		src,
		"humanoid flame",
		SCP_EUCLID,
		"457",
		SCP_PLAYABLE
	)

	spawn_area = get_area(src)
	add_language(LANGUAGE_EAL, FALSE)
	add_language(LANGUAGE_SKRELLIAN, FALSE)
	add_language(LANGUAGE_GUTTER, FALSE)
	add_language(LANGUAGE_SIGN, FALSE)
	add_language(LANGUAGE_ENGLISH, TRUE)
	set_light(0.8, 0.3, 5, l_color = COLOR_ORANGE)
	grant_457_actions()

	return ..()

/mob/living/simple_animal/hostile/scp457/Destroy()
	CleanupFires()
	return ..()

// ===========================================================================
// LIFE — heat economy, fire spreading, suppression
// ===========================================================================

/mob/living/simple_animal/hostile/scp457/Life()
	. = ..()
	if(stat == DEAD)
		return
	ProcessHeat()
	ProcessFireSpreading()
	ProcessSuppression()
	ProcessVisuals()
	// Ambient absorption: passing over our own flames sustains us.
	if(prob(15))
		AbsorbOwnFires(1)

// ---------------------------------------------------------------------------
// Heat
// ---------------------------------------------------------------------------

/mob/living/simple_animal/hostile/scp457/proc/ProcessHeat()
	if(world.time < last_heat_update + 10 SECONDS)
		return
	last_heat_update = world.time
	// Fire grows when it has fuel (flames) to feed on; decays passively.
	if(active_fires.len)
		current_heat = min(max_heat, current_heat + 2)
	current_heat = max(0, current_heat - SCP457_HEAT_DECAY_RATE)
	// Suppression bleeds extra heat.
	if(suppression_factor > 0)
		current_heat = max(0, current_heat - round(suppression_factor * 4))
	// Starvation: at zero heat the flame gutters out (temporary death state
	// is handled by stat — dying at 0 heat is the loss condition).
	if(current_heat <= 0 && health > 0)
		adjustBruteLoss(5) // slowly gutter: health drain instead of instant death
		if(prob(20))
			to_chat(src, SPAN_WARNING("Your flames gutter and dim. Find fuel or you will be snuffed out!"))

/mob/living/simple_animal/hostile/scp457/proc/AddHeat(amount)
	current_heat = clamp(current_heat + amount, 0, max_heat)

/mob/living/simple_animal/hostile/scp457/proc/ConsumeHeat(amount)
	AddHeat(-amount)

/mob/living/simple_animal/hostile/scp457/proc/GetHeatPercentage()
	return (current_heat / max_heat) * 100

/mob/living/simple_animal/hostile/scp457/proc/GetFireType()
	if(current_heat <= SCP457_HEAT_THRESHOLD_BASIC)
		return "basic"
	else if(current_heat <= SCP457_HEAT_THRESHOLD_INTENSE)
		return "intense"
	else if(current_heat <= SCP457_HEAT_THRESHOLD_BLUE)
		return "blue"
	else
		return "white"

// ---------------------------------------------------------------------------
// Environment suppression — counterplay for security: flood, cold, space
// ---------------------------------------------------------------------------

/mob/living/simple_animal/hostile/scp457/proc/ProcessSuppression()
	var/turf/T = get_turf(src)
	if(!T || !istype(T, /turf))
		suppression_factor = 0
		return
	var/datum/gas_mixture/env = T.return_air()
	if(!env)
		// Vacuum/space: flames starve fast.
		suppression_factor = 1.0
		if(prob(10))
			to_chat(src, SPAN_DANGER("There is nothing here to burn! Your flames starve in the vacuum!"))
		return
	// Low oxygen or low temperature suppress fire.
	var/o2 = env.gas["oxygen"] ? env.gas["oxygen"] / env.total_moles : 0
	var/temp = env.temperature
	var/factor = 0
	if(o2 < 0.12)
		factor += 0.5
	if(temp < 150)
		factor += 0.5
	else if(temp < 250)
		factor += 0.2
	suppression_factor = clamp(factor, 0, 1)
	if(suppression_factor >= 1 && prob(10))
		to_chat(src, SPAN_DANGER("The air is too thin or too cold — your flames are being smothered!"))

// ---------------------------------------------------------------------------
// Visuals
// ---------------------------------------------------------------------------

/mob/living/simple_animal/hostile/scp457/proc/ProcessVisuals()
	// Color shifts with heat: orange -> red -> blue -> white.
	var/pct = GetHeatPercentage()
	switch(pct)
		if(0 to 25)
			color = "#FF6600"
			set_light(0.6, 0.3, 4, l_color = COLOR_ORANGE)
		if(25 to 50)
			color = "#FF3300"
			set_light(0.8, 0.4, 5, l_color = COLOR_ORANGE)
		if(50 to 75)
			color = "#5588FF"
			set_light(1.0, 0.5, 6, l_color = "#6699FF")
		if(75 to INFINITY)
			color = "#FFFFFF"
			// 1.3 was invalid (light_max_bright must be 0-1; the lighting
			// system CRASHed on every Life tick above the white tier).
			set_light(1.0, 0.6, 7, l_color = "#BBCCFF")

// ===========================================================================
// LIVING FLAMES — the spread mechanic
// ===========================================================================

/mob/living/simple_animal/hostile/scp457/proc/ProcessFireSpreading()
	if(world.time < spread_cooldown_track + SCP457_FLAME_SPREAD_INTERVAL)
		return
	spread_cooldown_track = world.time
	// Spread chance scales with heat; below basic threshold, no spread.
	if(current_heat <= SCP457_HEAT_THRESHOLD_BASIC)
		return
	var/spread_chance = (current_heat / max_heat) * 100
	// Trail: leave fire where we walk (above basic heat).
	var/turf/here = get_turf(src)
	if(here && !(locate(/obj/effect/scp457_fire) in here) && active_fires.len < max_active_fires)
		if(prob(SCP457_FLAME_TRAIL_CHANCE))
			CreateFireAtTurf(here)
	// Existing flames propagate.
	for(var/obj/effect/scp457_fire/fire in active_fires)
		if(!fire || QDELETED(fire) || !get_turf(fire))
			active_fires -= fire
			continue
		if(prob(max(SCP457_FLAME_SPREAD_CHANCE, spread_chance * 0.5)))
			AttemptFireSpread(fire)

/mob/living/simple_animal/hostile/scp457/proc/AttemptFireSpread(obj/effect/scp457_fire/source_fire)
	var/list/adjacent_turfs = list()
	for(var/turf/T in range(1, source_fire))
		if(CanSpreadToTurf(T))
			adjacent_turfs += T
	if(length(adjacent_turfs) && active_fires.len < max_active_fires)
		CreateFireAtTurf(pick(adjacent_turfs))
		ConsumeHeat(2)

/mob/living/simple_animal/hostile/scp457/proc/CanSpreadToTurf(turf/simulated/T)
	if(!T || T.density)
		return FALSE
	for(var/obj/structure/S in T)
		if(S.density)
			return FALSE
	// Closed machinery doors block too.
	for(var/obj/machinery/door/D in T)
		if(D.density)
			return FALSE
	if(istype(T, /turf/simulated) && T.wet)
		return FALSE
	if(locate(/obj/effect/scp457_fire) in T)
		return FALSE
	if(istype(T, /turf/simulated/open) || istype(T, /turf/unsimulated))
		// Open space turfs starve fire — no spreading into the void.
		return FALSE
	return TRUE

/mob/living/simple_animal/hostile/scp457/proc/CreateFireAtTurf(turf/T)
	if(!CanSpreadToTurf(T) || active_fires.len >= max_active_fires)
		return
	var/obj/effect/scp457_fire/new_fire = new(T)
	new_fire.fire_type = GetFireType()
	new_fire.owner = src
	new_fire.setup_fire_properties()
	active_fires += new_fire
	// Fire creation heats us (chain reaction) but large spreads cost heat.
	if(active_fires.len > 6)
		ConsumeHeat(1)
	// Breach check: fire escaping the chamber IS the breach.
	CheckFireBreach()

/mob/living/simple_animal/hostile/scp457/proc/CleanupFires()
	for(var/obj/effect/scp457_fire/fire in active_fires)
		if(fire)
			qdel(fire)
	active_fires.Cut()

/mob/living/simple_animal/hostile/scp457/proc/AbsorbOwnFires(range_val)
	var/absorbed = 0
	var/turf/T = get_turf(src)
	if(!T)
		return
	for(var/obj/hotspot/HS in range(range_val, T))
		AddHeat(2)
		qdel(HS)
		absorbed++
	for(var/mob/living/L in range(range_val, T))
		if(L == src)
			continue
		if(L.on_fire)
			var/stolen = L.fire_stacks
			AddHeat(max(1, stolen * 2))
			L.ExtinguishMob()
			absorbed++
	if(absorbed)
		visible_message(SPAN_DANGER("[src] absorbs nearby flames into itself!"))

// ---------------------------------------------------------------------------
// The breach path: fires escaping containment == breach, escalation by type
// ---------------------------------------------------------------------------

/mob/living/simple_animal/hostile/scp457/proc/CheckFireBreach()
	var/escaped = 0
	for(var/obj/effect/scp457_fire/fire in active_fires)
		var/area/A = get_area(fire)
		if(A && A != spawn_area)
			escaped++
	if(escaped >= 3 && !breach_announced)
		breach_announced = TRUE
		// Real breach: the research/containment system flags 457.
		if(SCP && SCP.research)
			SCP.research.set_containment_status(SCP_BREACHED)
		priority_announcement.Announce(
			"Automated thermal alarm: multiple fires detected outside the SCP-457 containment chamber. SCP-457 ([SCP ? SCP.classification : "Euclid"]) is no longer contained. All personnel are advised to exercise caution.",
			"SCP-457 Containment Breach Alert",
			'sounds/effects/siren.ogg'
		)
		log_game("SCP-457 BREACH via fire spread from [spawn_area ? spawn_area.name : "unknown"].")
	// Recontainment: no escaped flames = contained again.
	if(escaped == 0 && breach_announced)
		breach_announced = FALSE
		if(SCP && SCP.research && SCP.research.containment_status == SCP_BREACHED)
			SCP.research.set_containment_status(SCP_CONTAINED)
			priority_announcement.Announce(
				"All anomalous fires associated with SCP-457 have been extinguished. SCP-457 recontainment confirmed.",
				"SCP-457 Recontainment Confirmed"
			)

// Central rule for what 457 can and cannot burn. Used by both the melee
// attack path and the fuel-value path so nothing slips through either.
/mob/living/simple_animal/hostile/scp457/proc/can_burn_atom(atom/target)
	if(!target)
		return FALSE
	// Machinery everywhere is insulated (consoles, lathes, vents...).
	if(istype(target, /obj/machinery))
		return FALSE
	// Borosilicate (phoron) glass is rated for extreme temperatures.
	if(istype(target, /obj/structure/window/phoronreinforced) || istype(target, /obj/structure/window/phoronbasic))
		return FALSE
	// SCPs don't burn each other.
	if(target.SCP)
		return FALSE
	// Containment doors of our own chamber resist melting: the containment
	// design relies on him needing a door opened FOR him, not by him.
	if(get_area(target) == spawn_area && istype(target, /obj/machinery/door))
		return FALSE
	// Observation-room phoron-glass walls handled above; everything else in
	// the chamber (tables, chair, plants, closets, supplies) IS his starter
	// fuel — he builds heat from his chamber stock before breaking out.
	return TRUE

// ===========================================================================
// FUEL — eating the world
// ===========================================================================

/mob/living/simple_animal/hostile/scp457/proc/GetFuelValue(atom/target)
	if(!target)
		return 0
	// Central insulation gate: things that can't be burned return no fuel
	// (checked by ALL consume paths — melee, Consume Fuel button, corpse eat).
	if(!can_burn_atom(target))
		return 0
	// His own chamber's ash: scorched residue of previous iterations. Rich in
	// stored heat — the roundstart starter fuel.
	if(istype(target, /obj/effect/decal/cleanable/ash))
		return 4
	// Corpses: fresh meat burns. Ones 457 (or his fire) killed are pre-toasted
	// and burn hotter — testing SCP-457 feeds SCP-457.
	if(istype(target, /mob/living) && target:stat == DEAD)
		var/mob/living/M = target
		return M.on_fire ? 18 : 10
	var/fuel = 0
	if(istype(target, /obj/item/paper) || istype(target, /obj/item/book) || istype(target, /obj/item/photo))
		fuel = 3
	else if(istype(target, /obj/item/clothing))
		fuel = 5
	else if(istype(target, /obj/item/stack/material))
		var/obj/item/stack/material/M = target
		// Flammable materials have an ignition point set; stone/metal do not.
		var/material/mat = M.material
		if(mat && mat.ignition_point)
			fuel = 12
		else
			fuel = 1
	else if(istype(target, /obj/structure/table))
		fuel = 12
	else if(istype(target, /obj/structure/bed))
		fuel = 8
	else if(istype(target, /obj/item/reagent_containers/food/snacks))
		fuel = 4
	else if(istype(target, /obj/item/reagent_containers))
		var/obj/item/reagent_containers/RC = target
		if(RC.reagents && RC.reagents.has_reagent(/datum/reagent/fuel))
			fuel = 20
		else if(RC.reagents && RC.reagents.has_reagent(/datum/reagent/toxin/phoron))
			fuel = 35
		else if(RC.reagents && RC.reagents.total_volume > 0)
			fuel = 2
		else
			fuel = 1
	else if(istype(target, /obj/item/tank))
		fuel = 30
	else if(istype(target, /obj/structure/closet))
		fuel = 8
	else if(istype(target, /obj/structure/chair))
		fuel = 5
	else if(istype(target, /obj/machinery/light))
		fuel = 3
	else if(istype(target, /obj/item))
		var/obj/item/I = target
		if(I.w_class <= 2)
			fuel = 2
		else
			fuel = 1
	else if(istype(target, /obj/structure))
		fuel = 4
	return fuel

/mob/living/simple_animal/hostile/scp457/proc/ConsumeFlammable(atom/target)
	if(!target || istype(target, /obj/effect/scp457_fire))
		return FALSE
	var/fuel_value = GetFuelValue(target)
	if(fuel_value <= 0)
		to_chat(src, SPAN_WARNING("[target] has nothing worth consuming."))
		return FALSE
	var/consume_time = 2 SECONDS
	if(istype(target, /obj/item) && target:w_class >= 3)
		consume_time = 3 SECONDS
	if(istype(target, /mob/living))
		consume_time = 4 SECONDS // bodies take longer to render down
	visible_message(SPAN_DANGER("[src] reaches toward [target], flames licking hungrily!"))
	to_chat(src, SPAN_NOTICE("You begin consuming [target]..."))
	if(!do_after(src, consume_time, target))
		return FALSE
	if(QDELETED(target))
		return FALSE
	var/consumed_name = target.name
	// Phoron/fuel tanks explode when eaten.
	if(istype(target, /obj/item/tank))
		var/turf/T = get_turf(src)
		visible_message(SPAN_DANGER("[src] devours [consumed_name] — the pressurized fuel detonates!"))
		explosion(T, -1, 1, 2)
		AddHeat(30)
		qdel(target)
		return TRUE
	// Corpse consumption: gib to ash, log the feeding, reward heat + heal.
	if(istype(target, /mob/living))
		var/mob/living/M = target
		M.visible_message(SPAN_DANGER("[src] renders [M] down to scorched ash!"))
		new /obj/effect/decal/cleanable/ash(get_turf(M))
		M.gib()
		AddHeat(fuel_value)
		adjustBruteLoss(-fuel_value * 1.5)
		to_chat(src, SPAN_NOTICE("Consumed [consumed_name]. Heat: [current_heat]/[max_heat]"))
		log_game("SCP-457 consumed [M.name] at [get_area_name(src)] (+[fuel_value] heat).")
		// Research paper trail: the feeding is recorded as an interaction.
		if(SCP && SCP.research)
			SCP.research.add_research_points(round(fuel_value / 2), "457_fed")
			if(SSscp_persistence && SSscp_persistence.manager)
				var/datum/scp_instance/instance = SSscp_persistence.manager.get_instance("457")
				if(instance)
					instance.add_interaction_record("SCP-457", "Consumed a body: [M.name]")
		return TRUE
	AddHeat(fuel_value)
	adjustBruteLoss(-fuel_value * 1.5) // eating heals
	qdel(target)
	visible_message(SPAN_DANGER("[src] devours [consumed_name] in a burst of intensified flame!"))
	to_chat(src, SPAN_NOTICE("Consumed [consumed_name]. Heat: [current_heat]/[max_heat]"))
	return TRUE

// ===========================================================================
// ATTACKS
// ===========================================================================

/mob/living/simple_animal/hostile/scp457/UnarmedAttack(atom/A)
	if(A.SCP && A != src)
		to_chat(src, SPAN_WARNING(SPAN_ITALIC("That thing is not like the others. You know better than to mess with it.")))
		return
	if(((world.time - aflame_cooldown_track) < aflame_cooldown_time) && ishuman(A))
		to_chat(src, SPAN_WARNING("You can't attack yet."))
		return
	if(ishuman(A))
		var/mob/living/carbon/human/target = A
		if(target.stat == DEAD)
			// Consume the corpse for heat — dead fuel is still fuel.
			ConsumeFlammable(target)
			aflame_cooldown_track = world.time
			return
		if(target.weakened)
			var/damage_amount = clamp(target.health, 0, 25)
			target.adjust_fire_stacks(1)
			target.IgniteMob()
			target.apply_damage(damage_amount, BURN)
			adjustBruteLoss(-damage_amount)
			AddHeat(5)
			visible_message(SPAN_DANGER("[src] sets [A] alight!"))
		else
			visible_message(SPAN_DANGER("[src] burns [A]!"))
			target.Weaken(2)
			target.apply_damage(15, BURN)
			target.adjust_fire_stacks(2)
			target.IgniteMob()
			adjustBruteLoss(-15)
			AddHeat(3)
		aflame_cooldown_track = world.time
		return

	if(istype(A, /obj/machinery/door))
		OpenDoor(A)
		aflame_cooldown_track = world.time
		return

	if(istype(A, /obj) && A.can_damage_health(A.health_current, BURN))
		// Central insulation gate: chamber contents, machinery, and
		// borosilicate windows are all protected (see can_burn_atom).
		if(!can_burn_atom(A))
			to_chat(src, SPAN_NOTICE("[A] is too thermally insulated for you to damage."))
			return
		var/fuel = GetFuelValue(A)
		A.attack_generic(src, 50, "melts")
		AddHeat(max(1, fuel / 2))
		aflame_cooldown_track = world.time
	return

/mob/living/simple_animal/hostile/scp457/IAttack(atom/A)
	if((world.time - aflame_cooldown_track) < aflame_cooldown_time)
		return ATTACK_ON_COOLDOWN
	return ..()

/mob/living/simple_animal/hostile/scp457/do_attack(atom/A, turf/T)
	if(..())
		UnarmedAttack(A)

// Doors: melts controls. Blast doors outside the chamber take much longer.
/mob/living/simple_animal/hostile/scp457/proc/OpenDoor(obj/machinery/door/A)
	if((world.time - door_cooldow_track) < door_cooldown_base)
		to_chat(src, SPAN_NOTICE("You can't open that right now!"))
		return
	if(!istype(A))
		return
	if(!A.density)
		return
	if(!A.Adjacent(src))
		to_chat(src, SPAN_WARNING("\The [A] is too far away."))
		return
	var/open_time = SCP457_DOOR_MELT_TIME
	if(istype(A, /obj/machinery/door/blast))
		if(get_area(A) == spawn_area)
			to_chat(src, SPAN_WARNING("This blast door is too thermally protected, you cannot melt through it."))
			return
		open_time = SCP457_BLAST_MELT_TIME
	if(istype(A, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/AR = A
		if(AR.locked)
			open_time += 4 SECONDS
		if(AR.welded)
			open_time += 4 SECONDS
		if(AR.secured_wires)
			open_time += 4 SECONDS
	// High heat melts faster.
	if(current_heat >= SCP457_HEAT_THRESHOLD_BLUE)
		open_time *= 0.6
	A.visible_message(SPAN_WARNING("\The [src] begins to melt the control mechanisms on \the [A]!"))
	playsound(get_turf(A), 'sounds/machines/airlock_creaking.ogg', 35, 1)
	door_cooldow_track = world.time + open_time
	if(!do_after(src, open_time, A, bonus_percentage = 25))
		return
	if(istype(A, /obj/machinery/door/blast))
		var/obj/machinery/door/blast/DB = A
		DB.visible_message(SPAN_DANGER("\The [src] forcefully opens \the [DB]!"))
		DB.force_open()
		return
	if(istype(A, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/AR = A
		AR.unlock(TRUE)
		AR.welded = FALSE
	A.set_broken(TRUE)
	var/check = A.open(1)
	visible_message("\The [src] melts \the [A]'s controls[check ? ", and rips it open!" : ", and breaks it!"]")
	AddHeat(2)

// ===========================================================================
// REFORM — 457 always returns where there was fire
// ===========================================================================

/mob/living/simple_animal/hostile/scp457/death(gibbed, deathmessage, show_dead_message)
	// Leaves a last flame at the death spot: the seed of the reform.
	var/turf/T = get_turf(src)
	if(T && CanSpreadToTurf(T) && !gibbed)
		var/obj/effect/scp457_fire/seed = new(T)
		seed.fire_type = GetFireType()
		seed.owner = src
		seed.setup_fire_properties()
		// Drop every OLD flame first, then keep only the seed. The
		// previous order (assign list, CleanupFires, reassign) qdel'd
		// the seed itself and left a deleted ref in active_fires, so
		// the reform timer always fell back to the spawn room.
		var/list/old_fires = active_fires.Copy()
		active_fires = list(seed)
		for(var/obj/effect/scp457_fire/fire in old_fires)
			if(fire && fire != seed && !QDELETED(fire))
				qdel(fire)
	addtimer(CALLBACK(src, TYPE_PROC_REF(/mob/living/simple_animal/hostile/scp457, respawn)), 5 MINUTES)
	to_chat(src, SPAN_NOTICE(SPAN_BOLD("You will reform in five minutes, avoid leaving your body.")))
	return ..()

/mob/living/simple_animal/hostile/scp457/proc/respawn()
	// Reform at the strongest surviving fire — the flame always returns.
	var/turf/best_turf = null
	for(var/obj/effect/scp457_fire/fire in active_fires)
		if(!fire || QDELETED(fire))
			continue
		var/turf/T = get_turf(fire)
		if(T && !best_turf)
			best_turf = T
	if(!best_turf)
		best_turf = get_turf(spawn_area ? spawn_area : src)
	visible_message(SPAN_DANGER("One single flame grows and reforms into a humanoid shape!"))
	convertatom2type(src, /mob/living/simple_animal/hostile/scp457, force_mind = TRUE)
	// Reforming resets heat — a fresh fire must rebuild (starts past the
	// basic threshold so flames flow again immediately).
	current_heat = SCP457_FLAME_STARTING_HEAT
	active_fires = list()
	breach_announced = FALSE
	if(best_turf)
		forceMove(best_turf)

// ===========================================================================
// EXAMINE — cognitohazard flavor + SCP identification
// ===========================================================================

/mob/living/simple_animal/hostile/scp457/examine(mob/user, distance, infix, suffix)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.SCP)
			to_chat(user, SPAN_WARNING("This is SCP-457, a living flame that spreads and consumes."))
		else
			to_chat(user, SPAN_DANGER("A living flame that moves with purpose. The heat radiating from it is intense and unnatural."))
			if(H.sanity)
				H.sanity.on_scp_exposure("457", 5)

// ===========================================================================
// ===========================================================================
// ABILITIES — F19 action datum (AB_INNATE)
// ===========================================================================

/mob/living/simple_animal/hostile/scp457/proc/grant_457_actions()
	var/datum/action/scp457_fireball/FB = new(src)
	var/datum/action/scp457_consume/C = new(src)
	var/datum/action/scp457_dash/D = new(src)
	var/datum/action/scp457_vent/V = new(src)
	var/datum/action/scp457_firewall/W = new(src)
	FB.Grant(src)
	C.Grant(src)
	D.Grant(src)
	V.Grant(src)
	W.Grant(src)

// --- Fireball ---

/datum/action/scp457_fireball
	name = "Hurl Fireball"
	action_type = AB_INNATE
	button_icon = 'icons/hud/actions.dmi'
	button_icon_state = "fireball"

/datum/action/scp457_fireball/IsAvailable()
	var/mob/living/simple_animal/hostile/scp457/S = owner
	if(!istype(S) || S.stat == DEAD)
		return 0
	if(S.current_heat < 10 || world.time < S.fireball_cooldown)
		return 0
	return 1

/datum/action/scp457_fireball/Activate()
	var/mob/living/simple_animal/hostile/scp457/S = owner
	if(!istype(S) || S.current_heat < 10 || world.time < S.fireball_cooldown)
		return
	S.fireball_cooldown = world.time + 20 SECONDS
	var/list/targets = list()
	for(var/mob/living/L in view(7, S))
		if(L != S && L.stat != DEAD)
			targets += L
	if(!length(targets))
		to_chat(S, SPAN_WARNING("No targets in range!"))
		return
	var/mob/living/target = tgui_input_list(S, "Choose a target:", "Fireball", targets)
	if(!target || QDELETED(target))
		S.fireball_cooldown = 0
		return
	S.ConsumeHeat(10)
	var/damage = 25 + (S.current_heat / 4)
	target.visible_message(SPAN_DANGER("A fireball from [S] strikes [target]!"), SPAN_USERDANGER("A fireball hits you!"))
	target.apply_damage(damage, BURN)
	target.adjust_fire_stacks(3)
	target.IgniteMob()
	playsound(S, 'sounds/effects/explosion1.ogg', 60, 1)
	S.CreateFireAtTurf(get_turf(target))

// --- Consume Fuel ---

/datum/action/scp457_consume
	name = "Consume Fuel"
	action_type = AB_INNATE
	button_icon = 'icons/hud/actions.dmi'
	button_icon_state = "gib"

/datum/action/scp457_consume/IsAvailable()
	var/mob/living/simple_animal/hostile/scp457/S = owner
	if(!istype(S) || S.stat == DEAD)
		return 0
	return world.time >= S.consume_fuel_cooldown

/datum/action/scp457_consume/Activate()
	var/mob/living/simple_animal/hostile/scp457/S = owner
	if(!istype(S) || world.time < S.consume_fuel_cooldown)
		return
	S.consume_fuel_cooldown = world.time + 5 SECONDS
	var/list/fuel_targets = list()
	for(var/obj/item/I in range(1, S))
		if(S.GetFuelValue(I) > 0)
			fuel_targets += I
	for(var/obj/structure/St in range(1, S))
		if(S.GetFuelValue(St) > 0)
			fuel_targets += St
	// Ash piles and corpses are on the menu.
	for(var/obj/effect/decal/cleanable/ash/A in range(1, S))
		if(S.GetFuelValue(A) > 0)
			fuel_targets += A
	for(var/mob/living/M in range(1, S))
		if(M == S || M.stat != DEAD)
			continue
		if(S.GetFuelValue(M) > 0)
			fuel_targets += M
	if(!length(fuel_targets))
		to_chat(S, SPAN_WARNING("No flammable objects nearby!"))
		return
	var/atom/chosen = tgui_input_list(S, "Choose an object to consume:", "Consume Fuel", fuel_targets)
	if(!chosen || QDELETED(chosen))
		return
	S.ConsumeFlammable(chosen)

// --- Flame Dash ---

/datum/action/scp457_dash
	name = "Flame Dash"
	action_type = AB_INNATE
	button_icon = 'icons/hud/actions.dmi'
	button_icon_state = "gib"

/datum/action/scp457_dash/IsAvailable()
	var/mob/living/simple_animal/hostile/scp457/S = owner
	if(!istype(S) || S.stat == DEAD)
		return 0
	if(S.current_heat < 15 || world.time < S.flame_dash_cooldown)
		return 0
	return 1

/datum/action/scp457_dash/Activate()
	var/mob/living/simple_animal/hostile/scp457/S = owner
	if(!istype(S) || S.current_heat < 15 || world.time < S.flame_dash_cooldown)
		return
	S.flame_dash_cooldown = world.time + 25 SECONDS
	S.ConsumeHeat(15)
	S.visible_message(SPAN_DANGER("[S] erupts forward in a blazing dash!"))
	playsound(S, 'sounds/effects/explosion1.ogg', 60, 1)
	for(var/i in 1 to 4)
		var/turf/next = get_step(S, S.dir)
		// Fire can't pass through solid walls or dense obstacles.
		// NOTE: contains_dense_objects() excludes ATOM_FLAG_CHECKS_BORDER
		// atoms — and windows carry that flag, which let the dash slip
		// straight through 457's phoronreinforced windows. Check density
		// on every structure instead.
		if(!next || next.density)
			break
		var/blocked = FALSE
		for(var/atom/A in next)
			if(A.density && A != S)
				blocked = TRUE
				break
		if(blocked)
			break
		S.CreateFireAtTurf(get_turf(S))
		S.forceMove(next)
		for(var/mob/living/L in next)
			if(L == S || L.stat == DEAD)
				continue
			L.apply_damage(15, BURN)
			L.adjust_fire_stacks(2)
			L.IgniteMob()

// --- Heat Vent ---

/datum/action/scp457_vent
	name = "Heat Vent"
	action_type = AB_INNATE
	button_icon = 'icons/hud/actions.dmi'
	button_icon_state = "blink"

/datum/action/scp457_vent/IsAvailable()
	var/mob/living/simple_animal/hostile/scp457/S = owner
	if(!istype(S) || S.stat == DEAD)
		return 0
	if(S.current_heat < 20 || world.time < S.heat_vent_cooldown)
		return 0
	return 1

/datum/action/scp457_vent/Activate()
	var/mob/living/simple_animal/hostile/scp457/S = owner
	if(!istype(S) || S.current_heat < 20 || world.time < S.heat_vent_cooldown)
		return
	S.heat_vent_cooldown = world.time + 30 SECONDS
	S.ConsumeHeat(20)
	S.visible_message(SPAN_DANGER("[S] releases a wave of scorching heat!"))
	playsound(S, 'sounds/effects/explosion1.ogg', 80, 1)
	for(var/mob/living/L in range(3, S))
		if(L == S || L.stat == DEAD)
			continue
		L.apply_damage(20, BURN)
		L.adjust_fire_stacks(2)
		L.IgniteMob()
		var/turf/push_turf = get_step(get_turf(L), get_dir(S, L))
		if(push_turf && !push_turf.density)
			L.forceMove(push_turf)
		to_chat(L, SPAN_USERDANGER("A wave of searing heat pushes you back!"))

// --- Fire Wall ---

/datum/action/scp457_firewall
	name = "Fire Wall"
	action_type = AB_INNATE
	button_icon = 'icons/hud/actions.dmi'
	button_icon_state = "shield"

/datum/action/scp457_firewall/IsAvailable()
	var/mob/living/simple_animal/hostile/scp457/S = owner
	if(!istype(S) || S.stat == DEAD)
		return 0
	if(S.current_heat < 25 || world.time < S.fire_wall_cooldown)
		return 0
	return 1

/datum/action/scp457_firewall/Activate()
	var/mob/living/simple_animal/hostile/scp457/S = owner
	if(!istype(S) || S.current_heat < 25 || world.time < S.fire_wall_cooldown)
		return
	S.fire_wall_cooldown = world.time + 40 SECONDS
	S.ConsumeHeat(25)
	S.visible_message(SPAN_DANGER("[S] summons a ring of living flame!"))
	playsound(S, 'sounds/magic/fireball.ogg', 60, 1)
	for(var/turf/T in range(1, S))
		if(T != get_turf(S) && S.CanSpreadToTurf(T))
			S.CreateFireAtTurf(T)

// ===========================================================================
// STATUS TAB
// ===========================================================================

/mob/living/simple_animal/hostile/scp457/Stat()
	. = ..()
	if(statpanel("Game"))
		stat("Heat Level", "[current_heat]/[max_heat]")
		stat("Fire Type", GetFireType())
		stat("Active Fires", active_fires.len)
		stat("Suppression", "[round(suppression_factor * 100)]%")

// ===========================================================================
// LIVING FLAME — the fire objects
// ===========================================================================

/obj/effect/scp457_fire
	name = "living flame"
	desc = "A flame created by SCP-457. It moves with purpose."
	icon = 'icons/effects/fire.dmi'
	icon_state = "1"
	layer = 3
	anchored = TRUE
	light_max_bright = 0.5
	light_outer_range = 2
	light_color = COLOR_ORANGE
	var/fire_type = "basic"
	var/mob/living/simple_animal/hostile/scp457/owner
	var/fire_duration = 60 SECONDS
	var/creation_time = 0
	var/damage_tick = 0
	var/damage_interval = 1 SECONDS

/obj/effect/scp457_fire/Initialize()
	. = ..()
	creation_time = world.time
	START_PROCESSING(SSobj, src)
	setup_fire_properties()

/obj/effect/scp457_fire/Destroy()
	STOP_PROCESSING(SSobj, src)
	if(owner)
		owner.active_fires -= src
	return ..()

/obj/effect/scp457_fire/Process()
	if(world.time >= damage_tick + damage_interval)
		apply_damage()
		damage_tick = world.time
	if(world.time >= creation_time + fire_duration)
		qdel(src)

/obj/effect/scp457_fire/proc/setup_fire_properties()
	switch(fire_type)
		if("basic")
			icon_state = "1"
			fire_duration = 60 SECONDS
			light_color = COLOR_ORANGE
		if("intense")
			icon_state = "2"
			fire_duration = 120 SECONDS
			light_color = COLOR_ORANGE
		if("blue")
			icon_state = "3"
			fire_duration = 180 SECONDS
			light_color = "#6699FF"
		if("white")
			icon_state = "3"
			fire_duration = 300 SECONDS
			light_color = "#BBCCFF"

/obj/effect/scp457_fire/proc/apply_damage()
	// Burn mobs standing ON the flame (contact) — feedback matters: a
	// silent 5-damage tick was indistinguishable from nothing.
	for(var/mob/living/L in get_turf(src))
		if(L == owner || L.SCP || L.stat == DEAD)
			continue
		var/damage = get_damage_amount()
		L.apply_damage(damage, BURN)
		L.adjust_fire_stacks(1)
		if(L.IgniteMob())
			L.visible_message(SPAN_DANGER("[L] catches fire from the living flame!"), SPAN_USERDANGER("You are burned by the living flame!"))
	// Intense flames and up also scorch anyone standing NEXT to them.
	if(fire_type != "basic")
		for(var/mob/living/L in range(1, get_turf(src)))
			if(L == owner || L.SCP || L.stat == DEAD)
				continue
			L.adjust_fire_stacks(1)
			L.apply_damage(get_damage_amount() / 3, BURN)

/obj/effect/scp457_fire/proc/get_damage_amount()
	switch(fire_type)
		if("basic")
			return 5
		if("intense")
			return 15
		if("blue")
			return 30
		if("white")
			return 50
		else
			return 5

#undef SCP457_HEAT_THRESHOLD_BASIC
#undef SCP457_HEAT_THRESHOLD_INTENSE
#undef SCP457_HEAT_THRESHOLD_BLUE
#undef SCP457_MAX_HEAT
#undef SCP457_HEAT_GENERATION_RATE
#undef SCP457_HEAT_DECAY_RATE
#undef SCP457_DOOR_MELT_TIME
#undef SCP457_BLAST_MELT_TIME
#undef SCP457_FLAME_SPREAD_INTERVAL
#undef SCP457_FLAME_TRAIL_CHANCE
#undef SCP457_FLAME_SPREAD_CHANCE
#undef SCP457_FLAME_STARTING_HEAT

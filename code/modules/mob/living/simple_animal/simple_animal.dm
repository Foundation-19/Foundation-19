/mob/living/simple_animal
	name = "animal"
	icon = 'icons/mob/simple_animal/animal.dmi'
	health = 20
	maxHealth = 20
	universal_speak = FALSE

	mob_bump_flag = SIMPLE_ANIMAL
	mob_swap_flags = MONKEY|SLIME|SIMPLE_ANIMAL
	mob_push_flags = MONKEY|SLIME|SIMPLE_ANIMAL

	meat_type = /obj/item/reagent_containers/food/snacks/meat
	meat_amount = 3
	bone_material = MATERIAL_BONE_GENERIC
	bone_amount = 5
	skin_material = MATERIAL_SKIN_GENERIC
	skin_amount = 5

	var/show_stat_health = 1	//does the percentage health show in the stat panel for the mob

	var/icon_living = ""
	var/icon_dead = ""
	var/icon_gib = null	//We only try to show a gibbing animation if this exists.
	var/icon_rest = null			// The iconstate for resting, optional

	var/turns_per_move = 1
	var/turns_since_move = 0
	//Interaction
	var/response_help   = "tries to help"
	var/response_disarm = "tries to disarm"
	var/response_harm   = "tries to hurt"
	var/can_escape = FALSE // 'smart' simple animals such as human enemies, or things small, big, sharp or strong enough to power out of a net

	//Temperature effect
	var/minbodytemp = 250
	var/maxbodytemp = 350
	var/heat_damage_per_tick = 3	//amount of damage applied if animal's body temperature is higher than maxbodytemp
	var/cold_damage_per_tick = 2	//same as heat_damage_per_tick, only if the bodytemperature it's lower than minbodytemp
	var/fire_alert = 0

	var/min_oxy = 5					// Oxygen in moles, minimum, 0 is 'no minimum'
	var/max_oxy = 0					// Oxygen in moles, maximum, 0 is 'no maximum'
	var/min_tox = 0					// Phoron min
	var/max_tox = 1					// Phoron max
	var/min_co2 = 0					// CO2 min
	var/max_co2 = 5					// CO2 max
	var/min_n2 = 0					// N2 min
	var/max_n2 = 0					// N2 max
	var/unsuitable_atoms_damage = 2	// This damage is taken when atmos doesn't fit all the requirements above

	//Attack ranged settings
	var/projectiletype				// The projectiles I shoot
	var/projectilesound				// The sound I make when I do it
	var/projectile_accuracy = 0		// Accuracy modifier to add onto the bullet when its fired.
	var/projectile_dispersion = 0	// How many degrees to vary when I do it.
	/// Type of a casing to spawn alongside with projectile.
	var/casingtype
	/// If not 0, casing will self-delete after set amount of time in this variable
	var/casing_disappears = 0

	// Reloading settings, part of ranged code
	var/needs_reload = FALSE							// If TRUE, mob needs to reload occasionally
	var/reload_max = 1									// How many shots the mob gets before it has to reload, will not be used if needs_reload is FALSE
	var/reload_count = 0								// A counter to keep track of how many shots the mob has fired so far. Reloads when it hits reload_max.
	var/reload_time = 4 SECONDS							// How long it takes for a mob to reload. This is to buy a player a bit of time to run or fight.
	var/reload_sound = 'sounds/weapons/flipblade.ogg'	// What sound gets played when the mob successfully reloads. Defaults to the same sound as reloading guns. Can be null.

	//Hostility settings
	var/taser_kill = 1				// Is the mob weak to tasers

	//Mob melee settings
	var/list/attacktext = list("attacked") // "You are [attacktext] by the mob!"
	var/attack_sound = null				// Sound to play when I attack
	var/attack_armor_pen = 0			// How much armor pen this attack has.

	var/melee_attack_delay = 2			// If set, the mob will do a windup animation and can miss if the target moves out of the way.
	var/ranged_attack_delay = null
	var/special_attack_delay = null

	var/ranged_attack_cooldown = CLICK_CD_ATTACK

	//Mob interaction
	var/list/friends = list()		// Mobs on this list wont get attacked regardless of faction status.
	var/harm_intent_damage = 3		// How much an unarmed harm click does to this mob.
	/// The list of lootable objects to drop, with "/path = amount" structure
	var/list/loot_list = list()
	var/obj/item/card/id/myid// An ID card if they have one to give them access to stuff.

	//Movement things.
	var/movement_cooldown = 4			// Lower is faster.
	var/movement_sound = null			// If set, will play this sound when it moves on its own will.
	var/turn_sound = null				// If set, plays the sound when the mob's dir changes in most cases.
	var/movement_shake_radius = 0		// If set, moving will shake the camera of all living mobs within this radius slightly.
	var/aquatic_movement = 0			// If set, the mob will move through fluids with no hinderance.

	//Atmos effect - Yes, you can make creatures that require phoron or co2 to survive. N2O is a trace gas and handled separately, hence why it isn't here. It'd be hard to add it. Hard and me don't mix (Yes, yes make all the dick jokes you want with that.) - Errorage
	var/list/min_gas = list(GAS_OXYGEN = 5)
	var/list/max_gas = list(GAS_PHORON = 1, GAS_CO2 = 5)

	var/unsuitable_atmos_damage = 2	//This damage is taken when atmos doesn't fit all the requirements above

	//LETTING SIMPLE ANIMALS ATTACK? WHAT COULD GO WRONG. Defaults to zero so Ian can still be cuddly
	var/obj/item/natural_weapon/natural_weapon
	var/friendly = "nuzzles"
	var/environment_smash = 0
	var/resistance		  = 0	// Damage reduction
	var/armor_type = /datum/extension/armor
	var/list/natural_armor //what armor animal has
	var/flash_vulnerability = 1 // whether or not the mob can be flashed; 0 = no, 1 = yes, 2 = very yes

	var/can_pry = TRUE
	var/pry_time = 7 SECONDS //time it takes for mob to pry open a door
	var/pry_desc = "prying" //"X begins pry_desc the door!"

	//Special attacks
	var/special_attack_min_range = null		// The minimum distance required for an attempt to be made.
	var/special_attack_max_range = null		// The maximum for an attempt.
	var/special_attack_charges = null		// If set, special attacks will work off of a charge system, and won't be usable if all charges are expended. Good for grenades.
	var/special_attack_cooldown = null		// If set, special attacks will have a cooldown between uses.
	var/last_special_attack = null			// world.time when a special attack occured last, for cooldown calculations.

	//Damage resistances
	var/grab_resist = 0				// Chance for a grab attempt to fail. Note that this is not a true resist and is just a prob() of failure.
	var/list/armor = list(			// Values for normal getarmor() checks
				"melee" = 0,
				"bullet" = 0,
				"laser" = 0,
				"energy" = 0,
				"bomb" = 0,
				"bio" = 100,
				"rad" = 100
				)
	var/list/armor_soak = list(		// Values for getsoak() checks.
				"melee" = 0,
				"bullet" = 0,
				"laser" = 0,
				"energy" = 0,
				"bomb" = 0,
				"bio" = 0,
				"rad" = 0
				)

	// Protection against heat/cold/electric/water effects.
	// 0 is no protection, 1 is total protection. Negative numbers increase vulnerability.
	var/heat_resist = 0.0
	var/cold_resist = 0.0
	var/shock_resist = 0.0
	var/water_resist = 1.0
	var/poison_resist = 0.0
	var/thick_armor = FALSE // Stops injections and "injections".
	var/purge = 0					// Cult stuff.
	var/supernatural = FALSE		// Ditto.

	var/bleed_ticks = 0
	var/bleed_colour = COLOR_BLOOD_HUMAN
	var/can_bleed = TRUE

	// contained in a cage
	var/in_stasis = 0

	//for simple animals with abilities, mostly megafauna
	var/ability_cooldown
	var/time_last_used_ability

	//for simple animals that reflect damage when attacked in melee
	var/return_damage_min
	var/return_damage_max

	// For ranged bursts
	var/ranged_burst_count = 0
	var/ranged_burst_delay = 5

	// List of potential death sounds, if any
	var/list/death_sounds = list()

/mob/living/simple_animal/Initialize()
	. = ..()
	if(LAZYLEN(natural_armor))
		set_extension(src, armor_type, natural_armor)

/mob/living/simple_animal/Destroy()
	if(istype(natural_weapon))
		QDEL_NULL(natural_weapon)

	. = ..()

/mob/living/simple_animal/get_status_tab_items()
	.=..()
	if(show_stat_health)
		. += "Health: [round((health / maxHealth) * 100)]%"
	if(needs_reload)
		. += "Ammo: [max(0, reload_max - reload_count)]/[reload_max]"

/mob/living/simple_animal/death(gibbed, deathmessage = "dies!", show_dead_message)
	. = ..()
	if(!.)
		return
	drop_loot()
	if(QDELETED(src)) // Gibbed/dusted/otherwise gone
		return
	icon_state = icon_dead
	update_icon()
	density = FALSE
	adjustBruteLoss(maxHealth) //Make sure dey dead.
	walk_to(src,0)
	if(LAZYLEN(death_sounds))
		playsound(src, pick(death_sounds), 50, TRUE)

// Reset icon on revival
/mob/living/simple_animal/rejuvenate()
	var/was_dead = stat == DEAD
	. = ..()
	if(was_dead && stat != DEAD)
		icon_state = icon_living
		switch_from_dead_to_living_mob_list()
		set_stat(CONSCIOUS)
		set_density(initial(density))
		bleed_ticks = 0

/mob/living/simple_animal/proc/drop_loot()
	if(!LAZYLEN(loot_list))
		return
	for(var/drop in loot_list)
		for(var/i in 1 to max(1, loot_list[drop]))
			new drop(loc)

/mob/living/simple_animal/adjustBruteLoss(damage)
	..()
	updatehealth()

/mob/living/simple_animal/adjustFireLoss(damage)
	..()
	updatehealth()

/mob/living/simple_animal/adjustToxLoss(damage)
	..()
	updatehealth()

/mob/living/simple_animal/adjustOxyLoss(damage)
	..()
	updatehealth()

/mob/living/simple_animal/updatehealth()
	..()
	if(stat != DEAD && health <= 0)
		death()

/mob/living/simple_animal/say(message)
	var/verb = "says"
	if(speak_emote.len)
		verb = pick(speak_emote)

	message = sanitize(message)

	..(message, null, verb)

/mob/living/simple_animal/get_speech_ending(verb, ending)
	return verb

/mob/living/simple_animal/put_in_hands(obj/item/W) // No hands.
	W.forceMove(get_turf(src))
	return 1

// Harvest an animal's delicious byproducts
/mob/living/simple_animal/proc/harvest(mob/user, skill_level)
	var/actual_meat_amount = round(max(1,(meat_amount / 2) + skill_level / 2))
	user.visible_message(SPAN_DANGER("\The [user] chops up \the [src]!"))
	if(meat_type && actual_meat_amount > 0 && (stat == DEAD))
		for(var/i=0;i<actual_meat_amount;i++)
			var/obj/item/meat = new meat_type(get_turf(src))
			meat.SetName("[src.name] [meat.name]")
			if(can_bleed)
				var/obj/effect/decal/cleanable/blood/splatter/splat = new(get_turf(src))
				splat.basecolor = bleed_colour
				splat.update_icon()
			qdel(src)

/mob/living/simple_animal/proc/subtract_meat(mob/user)
	meat_amount--
	if(meat_amount <= 0)
		to_chat(user, SPAN_NOTICE("\The [src] carcass is ruined beyond use."))

/mob/living/simple_animal/bullet_impact_visuals(obj/item/projectile/P, def_zone)
	..()
	switch(get_bullet_impact_effect_type(def_zone))
		if(BULLET_IMPACT_MEAT)
			if(P.damtype == BRUTE)
				var/hit_dir = get_dir(P.starting, src)
				var/obj/effect/decal/cleanable/blood/B = blood_splatter(get_step(src, hit_dir), src, 1, hit_dir)
				B.icon_state = pick("dir_splatter_1","dir_splatter_2")
				B.basecolor = bleed_colour
				var/scale = min(1, round(mob_size / MOB_MEDIUM, 0.1))
				var/matrix/M = new()
				B.transform = M.Scale(scale)
				B.update_icon()

/mob/living/simple_animal/handle_fire()
	. = ..()

	var/burn_temperature = fire_burn_temperature()
	var/thermal_protection = get_heat_protection(burn_temperature)

	if (thermal_protection < 1 && bodytemperature < burn_temperature)
		bodytemperature += round(BODYTEMP_HEATING_MAX*(1-thermal_protection), 1)

	burn_temperature -= maxbodytemp

	if(burn_temperature < 1)
		return

	// At minimum level of fire stacks and default(350) max body temp it will deal ~5 damage per tick
	// At "absolute maximum" of around 100.000 burn_temperature it will deal ~80 damage per tick
	var/burn_damage = round(sqrt(burn_temperature) * 0.25)
	adjustBruteLoss(burn_damage)

/mob/living/simple_animal/update_fire()
	. = ..()
	overlays -= image("icon"='icons/mob/OnFire.dmi', "icon_state"="Generic_mob_burning")
	if(on_fire)
		overlays += image("icon"='icons/mob/OnFire.dmi', "icon_state"="Generic_mob_burning")

/mob/living/simple_animal/is_burnable()
	return heat_damage_per_tick

/mob/living/simple_animal/HandleLyingDensity()
	return // Density does not change from resting

/mob/living/simple_animal/proc/adjustBleedTicks(amount)
	if(!can_bleed)
		return

	if(amount > 0)
		bleed_ticks = max(bleed_ticks, amount)
	else
		bleed_ticks = max(bleed_ticks + amount, 0)

	bleed_ticks = round(bleed_ticks)

/mob/living/simple_animal/proc/handle_bleeding()
	bleed_ticks--
	adjustBruteLoss(1)

	var/obj/effect/decal/cleanable/blood/drip/drip = new(get_turf(src))
	drip.basecolor = bleed_colour
	drip.update_icon()

/mob/living/simple_animal/get_digestion_product()
	return /datum/reagent/nutriment

/mob/living/simple_animal/eyecheck()
	switch(flash_vulnerability)
		if(2 to INFINITY)
			return FLASH_PROTECTION_REDUCED
		if(1)
			return FLASH_PROTECTION_NONE
		if(0)
			return FLASH_PROTECTION_MAJOR
		else
			return FLASH_PROTECTION_MAJOR

/mob/living/simple_animal/DoMove(direction, mob/mover)
	var/turf/old_turf = get_turf(src)
	var/old_dir = dir
	. = ..()
	if(. & MOVEMENT_HANDLED)
		if(movement_shake_radius)
			for(var/mob/living/L in range(movement_shake_radius, src))
				shake_camera(L, 1, 1)
		if(turn_sound && dir != old_dir)
			playsound(src, turn_sound, 50, 1)
		else if(movement_sound && old_turf != get_turf(src)) // Playing both sounds at the same time generally sounds bad.
			PlayMovementSound()

/mob/living/simple_animal/proc/PlayMovementSound()
	playsound(src, movement_sound, 50, 1)

/mob/living/simple_animal/movement_delay()
	. = movement_cooldown

	// Turf related slowdown
	var/turf/T = get_turf(src)
	if(T?.movement_delay && !is_floating) // Flying mobs ignore turf-based slowdown. Aquatic mobs ignore water slowdown, and can gain bonus speed in it.
		. += T.movement_delay

	if(purge)//Purged creatures will move more slowly. The more time before their purge stops, the slower they'll move.
		if(. <= 0)
			. = 1
		. *= purge

/mob/living/simple_animal/get_inventory_slot(obj/item/I)
	return -1

/mob/living/simple_animal/proc/pry_door(mob/user, delay, obj/machinery/door/pesky_door)
	visible_message(SPAN_WARNING("\The [user] begins [pry_desc] at \the [pesky_door]!"))
	set_AI_busy(TRUE)
	if(do_after(user, delay, pesky_door, bonus_percentage = 25))
		pesky_door.open(1)
		ai_holder.prying = FALSE
		set_AI_busy(FALSE)
	else
		visible_message(SPAN_NOTICE("\The [user] is interrupted."))
		set_AI_busy(FALSE)

// Rough - Gibs
// Coarse - Gibs and spawns a random(50% - 80%) amount of its buchering results
/mob/living/simple_animal/Conversion914(mode = MODE_ONE_TO_ONE, mob/user = usr)
	switch(mode)
		if(MODE_ROUGH)
			gib()
			return null
		if(MODE_COARSE)
			var/turf/T = get_turf(src)
			var/list/return_items = list()
			if(meat_type && meat_amount)
				for(var/i = 1 to rand(round(meat_amount * 0.5), round(meat_amount * 0.8)))
					return_items += new meat_type(T)
			if(bone_material && bone_amount)
				var/bone_count = rand(round(bone_amount * 0.5), round(bone_amount * 0.8))
				var/material/M = SSmaterials.get_material_by_name(bone_material)
				return_items += new M.stack_type(T, bone_count, bone_material)
			if(skin_material && skin_amount)
				var/skin_count = rand(round(skin_amount * 0.5), round(skin_amount * 0.8))
				var/material/M = SSmaterials.get_material_by_name(skin_material)
				return_items += new M.stack_type(T, skin_count, skin_material)
			gib()
			return return_items
	return ..()

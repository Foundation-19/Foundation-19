
//// Zombie Defines

#define ANTAG_ZOMBIE "Zombie"

GLOBAL_LIST_INIT(zombie_species, list(\
	SPECIES_HUMAN, SPECIES_DIONA, SPECIES_UNATHI, SPECIES_VOX, SPECIES_VOX_ARMALIS,\
	SPECIES_SKRELL, SPECIES_PROMETHEAN, SPECIES_ALIEN, SPECIES_YEOSA, SPECIES_VATGROWN,\
	SPECIES_SPACER, SPECIES_TRITONIAN, SPECIES_GRAVWORLDER, SPECIES_MULE, SPECIES_MONKEY
))


//// Zombie Types


/datum/species/zombie
	name = "Zombie"
	name_plural = "Zombies"
	slowdown = 10
	blood_color = "#700f0f"
	death_message = "writhes and twitches before falling motionless."
	species_flags = SPECIES_FLAG_NO_PAIN | SPECIES_FLAG_NO_SCAN | SPECIES_FLAG_NO_DISEASE
	spawn_flags = SPECIES_IS_RESTRICTED
	brute_mod = 0.8
	burn_mod = 2 //Vulnerable to fire
	oxy_mod = 0
	stun_mod = 0.05
	weaken_mod = 0.05
	paralysis_mod = 0.2
	show_ssd = null //No SSD message so NPC logic can take over
	show_coma = null
	warning_low_pressure = 0
	hazard_low_pressure = 0
	body_temperature = null
	cold_level_1 = -1
	cold_level_2 = -1
	cold_level_3 = -1
	hidden_from_codex = TRUE
	has_fine_manipulation = FALSE
	unarmed_types = list(/datum/unarmed_attack/bite/sharp/zombie)
	move_intents = list(/decl/move_intent/creep)
	var/heal_rate = 1 // Regen.
	var/mob/living/carbon/human/target = null
	var/list/obstacles = list(
		/obj/structure/window,
		/obj/structure/closet,
		/obj/machinery/door/airlock,
		/obj/structure/table,
		/obj/structure/grille,
		/obj/structure/barricade,
		/obj/structure/wall_frame,
		/obj/structure/railing,
		/obj/structure/girder,
		/obj/structure/window/reinforced,
		/turf/simulated/wall,
		/obj/machinery/door/blast/shutters,
		/obj/machinery/door
	)

/datum/species/zombie/handle_post_spawn(mob/living/carbon/human/H)
	H.mutations |= MUTATION_CLUMSY
	H.mutations |= MUTATION_FERAL
	H.mutations |= MUTATION_XRAY
	H.mutations |= mNobreath //Byond doesn't like adding them all in one OR statement :(
	add_verb(H, /mob/living/carbon/proc/consume)
	H.move_intents = list(/decl/move_intent/creep) //Zooming days are over
	H.a_intent = "harm"
	H.move_intent = new /decl/move_intent/creep
	H.default_run_intent = H.move_intent
	H.default_walk_intent = H.move_intent

	H.set_sight(H.sight | SEE_MOBS | SEE_OBJS | SEE_TURFS) //X-Ray vis
	H.set_see_in_dark(8)
	H.set_see_invisible(SEE_INVISIBLE_LEVEL_TWO)

	H.languages = list()
	H.add_language(LANGUAGE_ZOMBIE)

	H.sleeping = 0
	H.resting = 0
	H.weakened = 0

	H.move_intent.move_delay = 6
	H.stat = CONSCIOUS
	..()

/datum/species/zombie/handle_environment_special(mob/living/carbon/human/H)
	if (H.stat == CONSCIOUS)
		if (prob(5))
			playsound(H.loc, 'sounds/hallucinations/far_noise.ogg', 15, 1)
		else if (prob(5))
			playsound(H.loc, 'sounds/hallucinations/veryfar_noise.ogg', 15, 1)
		else if (prob(5))
			playsound(H.loc, 'sounds/hallucinations/wail.ogg', 15, 1)

	for(var/obj/item/organ/I in H.internal_organs)
		if (I.damage > 0)
			I.damage = max(I.damage - heal_rate, 0)

	H.vessel.add_reagent(/datum/reagent/blood, min(heal_rate * 10, blood_volume - H.vessel.total_volume))

	if (H.getBruteLoss() || H.getFireLoss() || H.getOxyLoss() || H.getToxLoss())
		H.adjustBruteLoss(-heal_rate)
		H.adjustFireLoss(-heal_rate)
		H.adjustOxyLoss(-heal_rate)
		H.adjustToxLoss(-heal_rate)
		return TRUE

/datum/species/zombie/handle_death(mob/living/carbon/human/H)
	H.stat = DEAD //Gotta confirm death for some odd reason
	playsound(H, 'sounds/hallucinations/wail.ogg', 30, 1)
	handle_death_infection(H)
	return TRUE

/datum/species/zombie/proc/handle_death_infection(mob/living/carbon/human/H)
	var/list/victims = hearers(rand(1, 2), H)
	for(var/mob/living/carbon/human/M in victims)
		if (H == M || isspecies(M, SPECIES_ZOMBIE))
			continue
		if (!(M.species.name in GLOB.zombie_species) || isspecies(M,SPECIES_DIONA) || M.isSynthetic())
			continue
		if (M.wear_mask && (M.wear_mask.item_flags & ITEM_FLAG_AIRTIGHT)) // If they're protected by a mask
			continue
		else if (M.head && (M.head.item_flags & ITEM_FLAG_AIRTIGHT)) // If they're protected by a helmet
			continue

	if (H?.stat != CONSCIOUS)
		addtimer(CALLBACK(src, PROC_REF(handle_death_infection), H), 1 SECOND)

/datum/species/zombie/handle_npc(mob/living/carbon/human/H)
	H.resting = FALSE

	if (prob(5))
		H.custom_emote("wails!")
	else if (prob(5))
		H.custom_emote("groans!")
	if (H.restrained() && prob(8))
		H.custom_emote("thrashes and writhes!")

	if (H.restrained() || H.buckled())
		H.resist()
		return

	addtimer(CALLBACK(src, PROC_REF(handle_action), H), rand(10, 20))

/datum/species/zombie/proc/handle_action(mob/living/carbon/human/H)
	var/dist = 128
	for(var/mob/living/M in hearers(H, 15))
		if ((ishuman(M) || istype(M, /mob/living/exosuit)) && !isspecies(M, SPECIES_ZOMBIE) && !isspecies(M, SPECIES_DIONA)) //Don't attack fellow zombies, or diona
			if (istype(M, /mob/living/exosuit))
				var/mob/living/exosuit/MC = M
				if (!LAZYLEN(MC.pilots))
					continue //Don't attack empty mechs
			if (M.stat == DEAD && target)
				continue //Only eat corpses when no living (and able) targets are around
			var/D = get_dist(M, H)
			if (D <= dist * 0.5) //Must be significantly closer to change targets
				target = M //For closest target
				dist = D

	H.setClickCooldown(CLICK_CD_ATTACK*2)
	if (target)
		if (isspecies(target, SPECIES_ZOMBIE))
			target = null
			return

		if (!H.Adjacent(target))
			var/turf/dir = get_step_towards(H, target)
			for(var/type in obstacles) //Break obstacles
				var/obj/obstacle = locate(type) in dir
				if (obstacle)
					H.face_atom(obstacle)
					obstacle.attack_generic(H, 10, "smashes")
					break

			step_towards(H, target.loc)

		else
			if (!target.lying) //Subdue meals
				H.face_atom(target)

				if (!H.zone_sel)
					H.zone_sel = new /atom/movable/screen/zone_sel(null)
				H.zone_sel.selecting = BP_CHEST
				target.attack_hand(H)

			else //Eat said meals
				step_towards(H, target.loc) //Move over them
				if (H.Adjacent(target)) //Check we're still next to them
					H.consume()

		for(var/mob/living/M in hearers(H, 15))
			if (target == M) //If our target is still nearby
				return
		target = null //Target lost

	else
		if (!H.lying)
			if (prob(33) && isturf(H.loc) && !H.pulledby)
				H.SelfMove(pick(GLOB.cardinal))

/datum/unarmed_attack/bite/sharp/zombie
	attack_verb = list("slashed", "sunk their teeth into", "bit", "mauled")
	damage = 5

/datum/unarmed_attack/bite/sharp/zombie/is_usable(mob/living/carbon/human/user, mob/living/carbon/human/target, zone)
	. = ..()
	if (!.)
		return FALSE
	if (isspecies(target, SPECIES_ZOMBIE))
		to_chat(usr, SPAN_WARNING("They don't look very appetizing!"))
		return FALSE
	return TRUE

/datum/unarmed_attack/bite/sharp/zombie/apply_effects(mob/living/carbon/human/user, mob/living/carbon/human/target, attack_damage, zone)
	..()
	admin_attack_log(user, target, "Bit their victim.", "Was bitten.", "bit")
	if (!(target.species.name in GLOB.zombie_species) || isspecies(target, SPECIES_DIONA) || target.isSynthetic()) //No need to check infection for FBPs
		return
	target.adjustHalLoss(9) //To help bring down targets in voidsuits
	var/vuln = 1 - target.get_blocked_ratio(zone, TOX, damage_flags = DAM_BIO) //Are they protected from bites?
	if (vuln > 0.05)
		if (prob(vuln * 100)) //Protective infection chance
			if (prob(min(100 - target.get_blocked_ratio(zone, BRUTE) * 100, 100))) //General infection chance
				target.reagents.add_reagent(/datum/reagent/scp008, 5) //Infect 'em

//// Zombie Procs


/mob/living/carbon/human/proc/zombify()
	if (!(species.name in GLOB.zombie_species) || isspecies(src, SPECIES_DIONA) || isspecies(src, SPECIES_ZOMBIE) || isSynthetic())
		return

	if (mind)
		if (mind.special_role == ANTAG_ZOMBIE)
			return
		mind.special_role = ANTAG_ZOMBIE

	var/turf/T = get_turf(src)
	new /obj/effect/decal/cleanable/vomit(T)
	playsound(T, 'sounds/effects/splat.ogg', 20, 1)

	addtimer(CALLBACK(src, PROC_REF(transform_zombie)), 20)

/mob/living/carbon/human/proc/transform_zombie()
	adjust_jitter(30 SECONDS)
	adjustBruteLoss(100)
	sleep(150)

	if (QDELETED(src))
		return

	if (isspecies(src, SPECIES_ZOMBIE)) //Check again otherwise Consume can run this twice at once
		return

	rejuvenate()
	ChangeToHusk()
	visible_message(SPAN_DANGER("\The [src]'s skin decays before your very eyes!"), SPAN_DANGER("Your entire body is ripe with pain as it is consumed down to flesh and bones. You ... hunger. Not only for flesh, but to spread this gift. Use Abilities -> Consume to infect and feed upon your prey."))
	log_admin("[key_name(src)] has transformed into a zombie!")

	Weaken(4)
	set_dizzy(0)
	hallucination_power = 0
	hallucination_duration = 0
	if (should_have_organ(BP_HEART))
		vessel.add_reagent(/datum/reagent/blood, species.blood_volume - vessel.total_volume)
	for (var/obj/item/organ/organ in organs)
		organ.vital = 0
		if (!BP_IS_ROBOTIC(organ))
			organ.rejuvenate(1)
			organ.max_damage *= 2
			organ.min_broken_damage = Floor(organ.max_damage * 0.75)

	resuscitate()
	set_stat(CONSCIOUS)

	if (skillset && skillset.skill_list)
		skillset.skill_list = list()
		for(var/decl/hierarchy/skill/S in GLOB.skills) //Only want trained CQC and athletics
			skillset.skill_list[S.type] = SKILL_UNTRAINED
		skillset.skill_list[SKILL_HAULING] = SKILL_TRAINED
		skillset.skill_list[SKILL_COMBAT] = SKILL_TRAINED
		skillset.on_levels_change()

	species = all_species[SPECIES_ZOMBIE]
	species.handle_post_spawn(src)

	var/turf/T = get_turf(src)
	playsound(T, 'sounds/hallucinations/wail.ogg', 25, 1)


/mob/living/carbon/proc/consume()
	set name = "Consume"
	set desc = "Regain life and infect others by feeding upon them."
	set category = "Abilities"

	if (last_special > world.time)
		to_chat(src, SPAN_WARNING("You aren't ready to do that! Wait [round(last_special - world.time) / 10] seconds."))
		return

	var/mob/living/carbon/human/target
	var/list/victims = list()
	for (var/mob/living/carbon/human/L in get_turf(src))
		if (L != src && (L.lying || L.stat == DEAD))
			if (isspecies(L, SPECIES_ZOMBIE))
				to_chat(src, SPAN_WARNING("\The [L] isn't fresh anymore!"))
				continue
			if (!(L.species.name in GLOB.zombie_species) || isspecies(L, SPECIES_DIONA) || L.isSynthetic())
				to_chat(src, SPAN_WARNING("You'd break your teeth on \the [L]!"))
				continue
			victims += L

	if (!victims.len)
		to_chat(src, SPAN_WARNING("No valid targets nearby!"))
		return
	if (client)
		if (victims.len == 1) //No need to choose
			target = victims[1]
		else
			target = input("Who would you like to consume?") as null | anything in victims
	else //NPCs
		if (victims.len > 0)
			target = victims[1]

	if (!target)
		to_chat(src, SPAN_WARNING("You aren't on top of a victim!"))
		return
	if (get_turf(src) != get_turf(target) || !(target.lying || target.stat == DEAD))
		to_chat(src, SPAN_WARNING("You're no longer on top of \the [target]!"))
		return

	last_special = world.time + 5 SECONDS

	src.visible_message(SPAN_DANGER("\The [src] hunkers down over \the [target], tearing into their flesh."))
	playsound(loc, 'sounds/effects/wounds/bonebreak3.ogg', 20, 1)

	target.adjustHalLoss(50)

	if (do_after(src, 7 SECONDS, target, DO_DEFAULT, INCAPACITATION_KNOCKOUT, bonus_percentage = 25))
		admin_attack_log(src, target, "Consumed their victim.", "Was consumed.", "consumed")

		if (!target.lying && target.stat != DEAD) //Check victims are still prone
			return

		target.reagents.add_reagent(/datum/reagent/scp008, 35) //Just in case they haven't been infected already
		if (target.getBruteLoss() > target.maxHealth * 1.5)
			if (target.stat != DEAD)
				to_chat(src,SPAN_WARNING("You've scraped \the [target] down to the bones already!."))
				target.zombify()
			else
				to_chat(src,SPAN_DANGER("You shred and rip apart \the [target]'s remains!."))
				target.gib()
				playsound(loc, 'sounds/effects/splat.ogg', 40, 1)
			return

		to_chat(target,SPAN_DANGER("\The [src] scrapes your flesh from your bones!"))
		to_chat(src,SPAN_DANGER("You feed hungrily off \the [target]'s flesh."))

		if (isspecies(target, SPECIES_ZOMBIE)) //Just in case they turn whilst being eaten
			return

		target.apply_damage(rand(50, 60), BRUTE, BP_CHEST)
		target.adjustBruteLoss(20)
		target.update_surgery() //Update broken ribcage sprites etc.

		src.adjustBruteLoss(-5)
		src.adjustFireLoss(-15)
		src.adjustToxLoss(-5)
		src.adjustBrainLoss(-5)
		src.adjust_nutrition(40)

		playsound(loc, 'sounds/effects/splat.ogg', 20, 1)
		new /obj/effect/decal/cleanable/blood/splatter(get_turf(src), target.species.blood_color)
		if (target.getBruteLoss() > target.maxHealth*0.75)
			if (prob(50))
				gibs(get_turf(src), target.dna)
				src.visible_message(SPAN_DANGER("\The [src] tears out \the [target]'s insides!"))
	else
		src.visible_message(SPAN_WARNING("\The [src] leaves their meal for later."))


//// Zombie Atoms


/obj/item/reagent_containers/syringe/scp008
	name = "Syringe SCP-###"
	desc = "Contains a strange, crimson substance. The label appears to be partially scratched out."

/obj/item/reagent_containers/syringe/scp008/Initialize()
	..()
	reagents.add_reagent(/datum/reagent/scp008, 15)
	mode = SYRINGE_INJECT
	update_icon()

/mob/living/carbon/human/zombie/New(new_loc)
	..(new_loc, SPECIES_ZOMBIE)

	var/decl/cultural_info/culture = get_cultural_value(TAG_CULTURE)
	SetName(culture.get_random_name(gender))
	real_name = name

	var/decl/hierarchy/outfit/outfit = pick(
		/decl/hierarchy/outfit/zombie/lczcadet,\
		/decl/hierarchy/outfit/zombie/lczguard,\
		/decl/hierarchy/outfit/zombie/lczsergeant,\
		/decl/hierarchy/outfit/zombie/lczmedic,\
		/decl/hierarchy/outfit/zombie/lczriot,\
		/decl/hierarchy/outfit/zombie/lczrecontain,\
		/decl/hierarchy/outfit/zombie/juniorscientist,\
		/decl/hierarchy/outfit/zombie/scientist,\
		/decl/hierarchy/outfit/zombie/seniorscientist,\
		/decl/hierarchy/outfit/zombie/engineering,\
		/decl/hierarchy/outfit/zombie/medicaldoctor,\
		/decl/hierarchy/outfit/zombie/janitor,\
		/decl/hierarchy/outfit/zombie/officeworker,\
		/decl/hierarchy/outfit/zombie/classd\
	)
	outfit = outfit_by_type(outfit)
	outfit.equip(src, OUTFIT_ADJUSTMENT_SKIP_SURVIVAL_GEAR)

	ChangeToHusk()
	zombify()

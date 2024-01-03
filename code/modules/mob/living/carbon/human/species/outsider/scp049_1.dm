#define ANTAG_SCP049_1 "SCP-049-1"

/datum/species/scp049_1
	name = "SCP-049-1"
	name_plural = "SCP-049-1 Instances"
	slowdown = 15
	blood_color = "#622a37"
	flesh_color = "#442A37"
	death_message = "writhes and twitches before falling motionless."
	species_flags = SPECIES_FLAG_NO_PAIN | SPECIES_FLAG_NO_SCAN
	spawn_flags = SPECIES_IS_RESTRICTED
	brute_mod = 1
	burn_mod = 2.5 //Vulnerable to fire
	oxy_mod = 0
	stun_mod = 0.05
	weaken_mod = 0.05
	paralysis_mod = 0.2
	show_ssd = null
	show_coma = null
	warning_low_pressure = 0
	hazard_low_pressure = 0
	body_temperature = null
	cold_level_1 = -1
	cold_level_2 = -1
	cold_level_3 = -1
	hidden_from_codex = TRUE
	has_fine_manipulation = FALSE
	unarmed_types = list(/datum/unarmed_attack/bite/sharp/scp049_1)
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
		/turf/simulated/wall,
		/obj/machinery/door/blast/shutters,
		/obj/machinery/door
	)

/datum/species/scp049_1/handle_post_spawn(mob/living/carbon/human/H)
	H.mutations |= MUTATION_CLUMSY
	H.mutations |= MUTATION_FERAL
	H.mutations |= MUTATION_XRAY
	H.mutations |= mNobreath //Byond doesn't like adding them all in one OR statement :(

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
	H.add_language(LANGUAGE_PLAGUESPEAK_GLOBAL)

	H.sleeping = 0
	H.resting = 0
	H.weakened = 0

	H.move_intent.move_delay = 6
	H.stat = CONSCIOUS

	if (H.head)
		H.drop_from_inventory(H.head, get_turf(H)) //Remove helmet so headshots aren't impossible
	..()

/datum/species/scp049_1/handle_environment_special(mob/living/carbon/human/H)
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

	H.handle_regular_hud_updates()
	process_pestilence_hud(H)

/datum/species/scp049_1/handle_npc(mob/living/carbon/human/H)
	H.resting = FALSE

	if (prob(5))
		H.custom_emote("wails!")
	else if (prob(5))
		H.custom_emote("groans!")
	if (H.restrained() && prob(8))
		H.custom_emote("thrashes and writhes!")

	if (H.lying)
		walk(H, 0)
		return

	if (H.restrained() || H.buckled())
		H.resist()
		return

	addtimer(CALLBACK(src, .proc/handle_action, H), rand(10, 20))

/datum/species/scp049_1/proc/handle_action(mob/living/carbon/human/H)
	var/dist = 128
	for(var/mob/living/M in hearers(H, 15))
		if ((ishuman(M) || istype(M, /mob/living/exosuit)) && !isspecies(M, SPECIES_SCP049_1) && !isspecies(M, SPECIES_DIONA) && !isscp049(M)) //Don't attack fellow zombies, or diona
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
				H.setClickCooldown(DEFAULT_ATTACK_COOLDOWN*2)
	if (target)
		if (isspecies(target, SPECIES_SCP049_1))
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
			H.face_atom(target)

			if (!H.zone_sel)
				H.zone_sel = new /obj/screen/zone_sel(null)
			H.zone_sel.selecting = BP_CHEST
			target.attack_hand(H)

		for(var/mob/living/M in hearers(H, 15))
			if (target == M) //If our target is still nearby
				return
		target = null //Target lost

	else
		if (!H.lying)
			if (prob(33) && isturf(H.loc) && !H.pulledby)
				H.SelfMove(pick(GLOB.cardinal))

/datum/unarmed_attack/bite/sharp/scp049_1
	attack_verb = list("slashed", "sunk their teeth into", "bit", "mauled")
	damage = 3

/datum/unarmed_attack/bite/sharp/scp049_1/is_usable(mob/living/carbon/human/user, mob/living/carbon/human/target, zone)
	. = ..()
	if(!.)
		return FALSE
	if(isspecies(target, SPECIES_SCP049_1))
		to_chat(usr, SPAN_WARNING("They don't look very appetizing!"))
		return FALSE
	if(!target.humanStageHandler.getStage("Pestilence"))
		to_chat(usr, SPAN_WARNING("They are free from the pestilence!"))
		return FALSE
	return TRUE

/mob/living/carbon/human/proc/SCP049_cure()
	if (!(species.name in GLOB.zombie_species) || isspecies(src, SPECIES_DIONA) || isspecies(src, SPECIES_SCP049_1) || isSynthetic() || !humanStageHandler.getStage("Pestilence"))
		return

	if (mind)
		if (mind.special_role == ANTAG_SCP049_1)
			return
		mind.special_role = ANTAG_SCP049_1

	var/turf/T = get_turf(src)
	new /obj/effect/decal/cleanable/blood(T)
	playsound(T, 'sounds/effects/splat.ogg', 20, 1)

	var/SCP049_instance_count = 1
	for(var/mob/living/carbon/human/instance in GLOB.SCP_list)
		if(isspecies(instance, SPECIES_SCP049_1))
			SCP049_instance_count++

	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_EUCLID, //Obj Class
		"049-[SCP049_instance_count]", //Numerical Designation
		SCP_PLAYABLE
	)

	addtimer(CALLBACK(src, .proc/transform_049_1_instance), 2 SECONDS)

/mob/living/carbon/human/proc/transform_049_1_instance()
	visible_message(SPAN_DANGER(SPAN_BOLD("The lifeless corpse of [src] begins to convulse violently!")))
	humanStageHandler.setStage("Pestilence", 0)

	make_jittery(300)
	adjustBruteLoss(100)
	sleep(150)

	if (QDELETED(src))
		return

	if (isspecies(src, SPECIES_SCP049_1))
		return

	rejuvenate()
	ChangeToHusk()
	visible_message(SPAN_DANGER("\The [src]'s skin decays before your very eyes!"), SPAN_DANGER("You feel the last of your mind drift away... You must follow the one who cured you of your wretched disease."))
	log_admin("[key_name(src)] has transformed into an instance of 049-1!")

	Weaken(4)
	jitteriness = 0
	dizziness = 0
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

	species = all_species[SPECIES_SCP049_1]
	species.handle_post_spawn(src)

	var/turf/T = get_turf(src)
	playsound(T, 'sounds/hallucinations/wail.ogg', 25, 1)

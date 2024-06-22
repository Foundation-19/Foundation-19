#define ANTAG_SCP049_1 "SCP-049-1"

/datum/species/scp049_1
	name = "SCP-049-1"
	name_plural = "SCP-049-1 Instances"
	slowdown = 15
	blood_color = "#622a37"
	flesh_color = "#442A37"
	death_message = "writhes and twitches before falling motionless."
	species_flags = SPECIES_FLAG_NO_PAIN | SPECIES_FLAG_NO_SCAN | SPECIES_FLAG_NO_POISON | SPECIES_FLAG_NO_EMBED | SPECIES_FLAG_NO_DISEASE
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

	addtimer(CALLBACK(src, PROC_REF(handle_action), H), rand(10, 20))

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
				H.setClickCooldown(CLICK_CD_ATTACK*2)
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
				H.zone_sel = new /atom/movable/screen/zone_sel(null)
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

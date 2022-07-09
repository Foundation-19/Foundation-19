#define SPECIES_SCP049_1 "SCP-049-1"
#define ANTAG_SCP049_1 "SCP-049-1"

/datum/species/scp049_1
	name = SPECIES_049_1
	name_plural = "SCP-049-1s"
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
	inherent_verbs = list(/mob/living/carbon/proc/consume2)
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
	H.mutations |= mNobreath //Byond doesn't like adding them all in one OR statement :(
	H.move_intents = list(/decl/move_intent/creep) //Zooming days are over
	H.a_intent = "harm"
	H.move_intent = new /decl/move_intent/creep
	H.default_run_intent = H.move_intent
	H.default_walk_intent = H.move_intent

	H.set_sight(H.sight | SEE_MOBS | SEE_OBJS | SEE_TURFS) //X-Ray vis
	H.set_see_in_dark(8)
	H.set_see_invisible(SEE_INVISIBLE_LEVEL_TWO)

	H.move_intent.move_delay = 6

	return ..()

/datum/species/scp049_1/handle_environment_special(mob/living/carbon/human/H)
	if (H.stat == CONSCIOUS)
		if (prob(5))
			playsound(H.loc, 'sound/hallucinations/far_noise.ogg', 15, 1)
		else if (prob(5))
			playsound(H.loc, 'sound/hallucinations/veryfar_noise.ogg', 15, 1)
		else if (prob(5))
			playsound(H.loc, 'sound/hallucinations/wail.ogg', 15, 1)

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

/datum/species/scp049_1/proc/handle_action(mob/living/carbon/human/H)
	var/dist = 128
	for(var/mob/living/M in hearers(H, 15))
		if ((ishuman(M) || istype(M, /mob/living/exosuit)) && !isspecies(M, SPECIES_SCP049_1) && !isspecies(M, SPECIES_DIONA)) //Don't attack fellow zombies, or diona
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

			walk_to(H, target.loc, 1, H.move_intent.move_delay * 1.25)

		else
			if (!target.lying) //Subdue meals
				H.face_atom(target)

				if (!H.zone_sel)
					H.zone_sel = new /obj/screen/zone_sel(null)
				H.zone_sel.selecting = BP_CHEST
				target.attack_hand(H)

			else //Eat said meals
				walk_to(H, target.loc, 0, H.move_intent.move_delay * 2.5) //Move over them
				if (H.Adjacent(target)) //Check we're still next to them
					H.consume2()

		for(var/mob/living/M in hearers(H, 15))
			if (target == M) //If our target is still nearby
				return
		target = null //Target lost

	else
		if (!H.lying)
			walk(H, 0) //Clear walking
			if (prob(33) && isturf(H.loc) && !H.pulledby)
				H.SelfMove(pick(GLOB.cardinal))


/mob/living/carbon/proc/consume2()
	set name = "Consume"
	set desc = "Regain life by feeding upon them."
	set category = "SCP-049"

	if (last_special > world.time)
		to_chat(src, SPAN_WARNING("You aren't ready to do that! Wait [round(last_special - world.time) / 10] seconds."))
		return

	var/mob/living/carbon/human/target
	var/list/victims = list()
	for (var/mob/living/carbon/human/L in get_turf(src))
		if (L != src && (L.lying || L.stat == DEAD))
			if (isspecies(L, SPECIES_SCP049_1))
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
	playsound(loc, 'sound/effects/wounds/bonebreak3.ogg', 20, 1)

	target.adjustHalLoss(50)

	if (do_after(src, 5 SECONDS, target, DO_DEFAULT, INCAPACITATION_KNOCKOUT))
		admin_attack_log(src, target, "Consumed their victim.", "Was consumed.", "consumed")

		if (!target.lying && target.stat != DEAD) //Check victims are still prone
			return

		if (target.getBruteLoss() > target.maxHealth * 1.5)
			if (target.stat != DEAD)
				to_chat(src,SPAN_WARNING("You've scraped \the [target] down to the bones already!."))
			else
				to_chat(src,SPAN_DANGER("You shred and rip apart \the [target]'s remains!."))
				target.gib()
				playsound(loc, 'sound/effects/splat.ogg', 40, 1)
			return

		to_chat(target,SPAN_DANGER("\The [src] scrapes your flesh from your bones!"))
		to_chat(src,SPAN_DANGER("You feed hungrily off \the [target]'s flesh."))

		if (isspecies(target, SPECIES_SCP049_1)) //Just in case they turn whilst being eaten
			return

		target.apply_damage(rand(50, 60), BRUTE, BP_CHEST)
		target.adjustBruteLoss(20)
		target.update_surgery() //Update broken ribcage sprites etc.

		src.adjustBruteLoss(-5)
		src.adjustFireLoss(-15)
		src.adjustToxLoss(-5)
		src.adjustBrainLoss(-5)
		src.adjust_nutrition(40)

		playsound(loc, 'sound/effects/splat.ogg', 20, 1)
		new /obj/effect/decal/cleanable/blood/splatter(get_turf(src), target.species.blood_color)
		if (target.getBruteLoss() > target.maxHealth*0.75)
			if (prob(50))
				gibs(get_turf(src), target.dna)
				src.visible_message(SPAN_DANGER("\The [src] tears out \the [target]'s insides!"))
	else
		src.visible_message(SPAN_WARNING("\The [src] leaves their meal for later."))
/datum/unarmed_attack/bite/sharp/scp049_1
	attack_verb = list("slashed", "sunk their teeth into", "bit", "mauled")
	damage = 3

/datum/unarmed_attack/bite/sharp/scp049_1/is_usable(mob/living/carbon/human/user, mob/living/carbon/human/target, zone)
	. = ..()
	if (!.)
		return FALSE
	if (isspecies(target, SPECIES_SCP049_1))
		to_chat(usr, SPAN_WARNING("They don't look very appetizing!"))
		return FALSE
	return TRUE

/mob/living/carbon/human/proc/undead()
	if (!(species.name in GLOB.zombie_species) || isspecies(src, SPECIES_DIONA) || isspecies(src, SPECIES_SCP049_1) || isSynthetic())
		return

	if (mind)
		if (mind.special_role == ANTAG_SCP049_1)
			return
		mind.special_role = ANTAG_SCP049_1

	var/turf/T = get_turf(src)
	new /obj/effect/decal/cleanable/blood(T)
	playsound(T, 'sound/effects/splat.ogg', 20, 1)

	addtimer(CALLBACK(src, .proc/zumbie), 20)

/mob/living/carbon/human/proc/zumbie()
	make_jittery(300)
	adjustBruteLoss(100)
	sleep(150)

	if (QDELETED(src))
		return

	if (isspecies(src, SPECIES_SCP049_1)) //Check again otherwise Consume can run this twice at once
		return

	rejuvenate()
	ChangeToHusk()
	visible_message(SPAN_DANGER("\The [src]'s skin decays before your very eyes!"), SPAN_DANGER("Your entire body is ripe with pain as it is consumed down to flesh and bones. You ... hunger for flesh and bloods. Comply to your master."))
	log_admin("[key_name(src)] has transformed into a 049-1!")

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

	if (skillset && skillset.skill_list)
		skillset.skill_list = list()
		for(var/decl/hierarchy/skill/S in GLOB.skills) //Only want trained CQC and athletics
			skillset.skill_list[S.type] = SKILL_UNTRAINED
		skillset.skill_list[SKILL_HAULING] = SKILL_TRAINED
		skillset.skill_list[SKILL_COMBAT] = SKILL_TRAINED
		skillset.on_levels_change()

	set_species(SPECIES_049_1)
	sleeping = FALSE
	resting = FALSE
	weakened = FALSE
	set_stat(CONSCIOUS)
	add_language(LANGUAGE_SCP049_GLOBAL, TRUE)
	set_default_language(all_languages[LANGUAGE_SCP049_GLOBAL])
	var/turf/T = get_turf(src)
	playsound(T, 'sound/hallucinations/wail.ogg', 25, 1)

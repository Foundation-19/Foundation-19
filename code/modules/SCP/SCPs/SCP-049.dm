/mob/living/carbon/human/scp049
	name = "plague doctor"
	desc = "A mysterious plague doctor."
	icon = 'icons/SCP/scp-049.dmi'

	status_flags = NO_ANTAG | SPECIES_FLAG_NO_EMBED

	//Config

	///Emote cooldown
	var/emote_cooldown = 5 SECONDS
	///Door force open cooldown
	var/door_cooldown = 10 SECONDS
	///Base regen
	var/base_regen = 0.05
	///how much our regen is multiplied by for each instance of 049-1. (be careful this is exponential)
	var/regen_multiply = 1.5
	///Heal cooldown
	var/heal_cooldown = 2 SECONDS

	//Mechanical

	///Emote cooldown tracker
	var/emote_cooldown_track
	///Door cooldown tracker
	var/door_cooldown_track
	///Heal cooldown tracker
	var/heal_cooldown_track
	///Are we currently curing someone?
	var/curing = FALSE

/mob/living/carbon/human/scp049/Initialize(mapload, new_species = "SCP-049")
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"plague doctor", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_EUCLID, //Obj Class
		"049", //Numerical Designation
		SCP_PLAYABLE|SCP_ROLEPLAY
	)

	SCP.min_time = 10 MINUTES

	add_verb(src, list(
		/mob/living/carbon/human/scp049/verb/greetings,
		/mob/living/carbon/human/scp049/verb/yet_another_victim,
		/mob/living/carbon/human/scp049/verb/you_are_not_a_doctor,
		/mob/living/carbon/human/scp049/verb/I_sense_the_disease_in_you,
		/mob/living/carbon/human/scp049/verb/Im_here_to_cure_you,
		/mob/living/carbon/human/scp049/proc/cure_action,
	))

	init_049_skills()

/mob/living/carbon/human/scp049/proc/init_049_skills()
	skillset.skill_list = list()
	for(var/decl/hierarchy/skill/S in GLOB.skills)
		skillset.skill_list[S.type] = SKILL_UNTRAINED
	skillset.skill_list[SKILL_COOKING] = SKILL_TRAINED
	skillset.skill_list[SKILL_HAULING] = SKILL_MASTER
	skillset.skill_list[SKILL_COMBAT] = SKILL_EXPERIENCED
	skillset.skill_list[SKILL_ANATOMY] = SKILL_EXPERIENCED
	skillset.skill_list[SKILL_CHEMISTRY] = SKILL_BASIC
	skillset.skill_list[SKILL_MEDICAL] = SKILL_EXPERIENCED
	skillset.skill_list[SKILL_SCIENCE] = SKILL_EXPERIENCED
	skillset.on_levels_change()

/mob/living/carbon/human/scp049/Login()
	. = ..()
	if(client)
		add_language(LANGUAGE_ENGLISH)
		add_language(LANGUAGE_HUMAN_FRENCH)
		add_language(LANGUAGE_HUMAN_GERMAN)
		add_language(LANGUAGE_HUMAN_SPANISH)
		add_language(LANGUAGE_PLAGUESPEAK_GLOBAL)
		priority_announcement.Announce("Motion sensors triggered in the containment chamber of SCP-049, on-site security personnel are to investigate the issue.", "Motion Sensors", 'sounds/AI/049.ogg')
		if(!(MUTATION_XRAY in mutations))
			mutations.Add(MUTATION_XRAY)
			update_mutations()
			update_sight()

//Mechanics

/mob/living/carbon/human/scp049/proc/Attack_Voice_Line() //for when we're up to no good!
	var/voiceline = list('sounds/scp/voice/SCP049_1.ogg','sounds/scp/voice/SCP049_2.ogg','sounds/scp/voice/SCP049_3.ogg','sounds/scp/voice/SCP049_4.ogg','sounds/scp/voice/SCP049_5.ogg')
	playsound(src, pick(voiceline), 30)
	show_sound_effect(loc, src)

/mob/living/carbon/human/scp049/proc/openDoor(obj/machinery/door/A)
	if((world.time - door_cooldown_track) < door_cooldown)
		to_chat(src, SPAN_WARNING("You cant open another door just yet!"))
		return

	if(!istype(A))
		return

	if(!A.density)
		return

	if(!A.Adjacent(src))
		to_chat(src, SPAN_WARNING("\The [A] is too far away."))
		return

	if(istype(A, /obj/machinery/door/blast))
		to_chat(src, SPAN_WARNING("You cannot open blast doors."))
		return

	var/open_time = 8 SECONDS

	if(istype(A, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/AR = A
		if(AR.locked)
			open_time += 4 SECONDS
		if(AR.welded)
			open_time += 4 SECONDS
		if(AR.secured_wires)
			open_time += 4 SECONDS

	if(istype(A, /obj/machinery/door/airlock/highsecurity))
		open_time += 8 SECONDS

	A.visible_message(SPAN_WARNING("\The [src] begins to pry open \the [A]!"))
	playsound(get_turf(A), 'sounds/machines/airlock_creaking.ogg', 35, 1)
	door_cooldown_track = world.time + open_time // To avoid sound spam

	if(!do_after(src, open_time, A))
		return

	if(istype(A, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/AR = A
		AR.unlock(TRUE) // No more bolting in the SCPs and calling it a day
		AR.welded = FALSE

	A.set_broken(TRUE)
	A.do_animate("spark")
	var/check = A.open(1)
	visible_message("\The [src] slices \the [A]'s controls[check ? ", ripping it open!" : ", breaking it!"]")

/mob/living/carbon/human/scp049/proc/cure_action()
	set category = "SCP-049"
	set name = "Cure Victim"

	var/obj/item/grab/G = get_active_hand()
	if(!G)
		to_chat(src, SPAN_WARNING("We must take hold of a victim to cure their disease."))
		return

	if(!ishuman(G.affecting))
		to_chat(src, SPAN_WARNING("This is not human, and is therefore free from the disease."))
		return

	if(G.affecting.stat != DEAD)
		to_chat(src, SPAN_WARNING("The pestilence is much too strong in them. We must first stop their heart..."))
		return

	var/mob/living/carbon/human/target = G.affecting

	if(!target.humanStageHandler.getStage("Pestilence"))
		to_chat(src, SPAN_DANGER("They are not infected with the Pestilence."))
		return

	if(isspecies(target, SPECIES_SCP049_1))
		return

	curing = TRUE

	for(var/stage = 1, stage<=4, stage++)
		switch(stage)
			if(1)
				to_chat(src, SPAN_NOTICE("The disease has taken hold. We must work quickly..."))
				visible_message(SPAN_DANGER("[src] looms over [target]!"))
				target.adjustBruteLoss(25)
			if(2)
				to_chat(src, SPAN_NOTICE("You gather your tools."))
				visible_message(SPAN_WARNING("[src] draws a rolled set of surgical equipment from their bag!"))
				Attack_Voice_Line()
			if(3)
				to_chat(src, SPAN_NOTICE("You create your first incision."))
				visible_message(SPAN_DANGER("[src] begins slicing open [target] with a scalpel!"))
				to_chat(target, SPAN_DANGER("You feel a sharp stabbing pain as your life begins to wane."))
				new /obj/effect/decal/cleanable/blood/splatter(get_turf(target), target.species.blood_color)
			if(4)
				to_chat(src, SPAN_NOTICE("You spend a great deal of time expertly curing this victim's disease."))
				visible_message(SPAN_DANGER("[src] begins performing a horrifying procedure on [target]!"))

		if(!do_after(src, 15 SECONDS, target))
			to_chat(src, SPAN_WARNING("Our curing of [target] has been interrupted!"))
			curing = FALSE
			return

	target.SCP049_cure()
	to_chat(src, SPAN_NOTICE("You have cured [target]."))

	curing = FALSE

//Overrides

/mob/living/carbon/human/scp049/on_update_icon()
	if(lying || resting)
		var/matrix/M =  matrix()
		transform = M.Turn(90)
	else
		transform = null
	return

/mob/living/carbon/human/scp049/Life()
	. = ..()
	handle_regular_hud_updates()
	process_pestilence_hud(src)

	//Regen (The more zombies we have the more we heal)

	if((world.time - heal_cooldown_track) < heal_cooldown)
		return
	var/SCP049_1_instances_count = 0
	for(var/mob/living/carbon/human/H in GLOB.SCP_list)
		if(!isspecies(H, SPECIES_SCP049_1))
			continue
		if(H.stat != CONSCIOUS)
			continue
		SCP049_1_instances_count++

	var/heal_amount = -max((base_regen * (SCP049_1_instances_count * regen_multiply)), base_regen)
	adjustBruteLoss(heal_amount)

/mob/living/carbon/human/scp049/UnarmedAttack(atom/target as obj|mob)
	if(!istype(target))
		return

	if(istype(target, /obj/machinery/door))
		var/obj/machinery/door/D = target
		if(LAZYLEN(D.req_access))
			setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
			openDoor(target)
			return
		return ..()

	if(!ishuman(target) || isscp049(target))
		return ..()

	var/mob/living/carbon/human/HTarget = target

	if(isspecies(HTarget, SPECIES_SCP049_1))
		return ..()

	if(!HTarget.humanStageHandler.getStage("Pestilence"))
		to_chat(src, SPAN_DANGER("They are not infected with the Pestilence."))
		return

	if(HTarget.SCP)
		to_chat(src, SPAN_WARNING("This thing...it isnt normal...you cannot cure it."))
		return

	setClickCooldown(DEFAULT_ATTACK_COOLDOWN)

	switch(a_intent)
		if(I_HELP)
			to_chat(src, SPAN_NOTICE("You refrain from curing as your intent is set to help."))
			return ..()
		if(I_HURT)
			if(curing)
				return
			if(HTarget.stat == DEAD)
				to_chat(src, SPAN_NOTICE("They are ready for your cure."))
				return
			if(can_touch_bare_skin(HTarget))
				visible_message(SPAN_DANGER(SPAN_ITALIC("[src] reaches towards [target]!")))
				Attack_Voice_Line()
				HTarget.death(deathmessage = "suddenly becomes very still...", show_dead_message = "You have been killed by SCP-[SCP.designation]. Be patient as you may yet be cured...")
				return
			else
				visible_message(SPAN_WARNING(SPAN_ITALIC("[src] reaches towards [target], but fails to find any bare skin.")))
				to_chat(src, SPAN_WARNING("You must make contact with bare skin to kill!"))
				return
	return ..()

/mob/living/carbon/human/scp049/attack_hand(mob/living/carbon/human/M)
	if((!isspecies(M, SPECIES_SCP049_1) || M.a_intent == I_HELP) && (M != src))
		M.humanStageHandler.setStage("Pestilence", 1)

	if(isspecies(M, SPECIES_SCP049_1))
		to_chat(M, SPAN_DANGER(SPAN_BOLD("Do not attack your master!")))
		return

	return ..()

/mob/living/carbon/human/scp049/bullet_act(obj/item/projectile/P, def_zone)
	if(P.damage && !P.nodamage && ishuman(P.firer) && (P.firer != src))
		var/mob/living/carbon/human/H = P.firer
		H.humanStageHandler.setStage("Pestilence", 1)
	return ..()

/mob/living/carbon/human/scp049/attackby(obj/item/W, mob/user)
	if((W.force > 0) && ishuman(user) && (user != src))
		var/mob/living/carbon/human/H = user
		H.humanStageHandler.setStage("Pestilence", 1)
	return ..()

/mob/living/carbon/human/scp049/examinate(atom/A)
	. = ..()
	if(!ishuman(A))
		return
	var/mob/living/carbon/human/H = A
	if(H.humanStageHandler.getStage("Pestilence"))
		var/pest_message = pick("They reek of the disease.", "They need to be cured.", "The disease is strong in them.", "You sense the pestilence in them.")
		to_chat(src, "[SPAN_DANGER(SPAN_BOLD(pest_message))]")

//Util Overrides

/mob/living/carbon/human/scp049/IsAdvancedToolUser()
	return TRUE

/mob/living/carbon/human/scp049/update_icons()
	return

/mob/living/carbon/human/scp049/get_pressure_weakness()
	return 0

/mob/living/carbon/human/scp049/handle_breath()
	return 1

/mob/living/carbon/human/scp049/movement_delay()
	return 3.0

// Emotes

/mob/living/carbon/human/scp049/verb/greetings()
	set category = "SCP-049"
	set name = "Greetings"
	if(!can_special_emote())
		return
	playsound(src, 'sounds/scp/voice/SCP049_1.ogg', 30)
	show_sound_effect(loc, src)

/mob/living/carbon/human/scp049/verb/yet_another_victim()
	set category = "SCP-049"
	set name = "Yet another victim"
	if(!can_special_emote())
		return
	playsound(src, 'sounds/scp/voice/SCP049_2.ogg', 30)
	show_sound_effect(loc, src)

/mob/living/carbon/human/scp049/verb/you_are_not_a_doctor()
	set category = "SCP-049"
	set name = "You are not a doctor"
	if(!can_special_emote())
		return
	playsound(src, 'sounds/scp/voice/SCP049_3.ogg', 30)
	show_sound_effect(loc, src)

/mob/living/carbon/human/scp049/verb/I_sense_the_disease_in_you()
	set category = "SCP-049"
	set name = "I sense the disease in you"
	if(!can_special_emote())
		return
	playsound(src, 'sounds/scp/voice/SCP049_4.ogg', 30)
	show_sound_effect(loc, src)

/mob/living/carbon/human/scp049/verb/Im_here_to_cure_you()
	set category = "SCP-049"
	set name = "I'm here to cure you"
	if(!can_special_emote())
		return
	playsound(src, 'sounds/scp/voice/SCP049_5.ogg', 30)
	show_sound_effect(loc, src)

/mob/living/carbon/human/scp049/proc/can_special_emote()
	if((world.time - emote_cooldown_track) > emote_cooldown)
		emote_cooldown_track = world.time
		return TRUE
	return FALSE

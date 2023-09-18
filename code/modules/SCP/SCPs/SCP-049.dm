GLOBAL_LIST_EMPTY(scp049s)
GLOBAL_LIST_EMPTY(scp049_1s)

/mob/living/carbon/human/scp049
	desc = "A mysterious plague doctor."
	SCP = /datum/scp/scp_049
	icon = 'icons/SCP/scp-049.dmi'
	icon_state = null
	var/list/attempted_surgery_on = list()
	var/list/pestilence_images = list()
	var/mob/living/carbon/human/target = null
	var/next_emote = -1
	icon_state = ""
	var/contained = TRUE
	var/curing = FALSE //we doing gods work or nah?
	var/chasing_sound = FALSE
	var/anger = 0
	var/angry = FALSE
	status_flags = NO_ANTAG

/datum/scp/scp_049
	name = "SCP-049"
	designation = "049"
	classification = EUCLID

/mob/living/carbon/human/scp049/IsAdvancedToolUser()
	return TRUE

/mob/living/carbon/human/scp049/update_icons()
	return

/mob/living/carbon/human/scp049/on_update_icon()
	if (lying || resting)
		var/matrix/M =  matrix()
		transform = M.Turn(90)
	else
		transform = null
	return
/mob/living/carbon/human/scp049/New(new_loc, new_species)
	new_species = "SCP-049"
	return ..()

/mob/living/carbon/human/scp049/Initialize()
	// fix names
	fully_replace_character_name("SCP-049")

	GLOB.scp049s += src

	add_verb(src, list(
		/mob/living/carbon/human/proc/door_049,
		/mob/living/carbon/human/proc/SCP_049_talk,
		/mob/living/carbon/human/scp049/proc/greetings,
		/mob/living/carbon/human/scp049/proc/yet_another_victim,
		/mob/living/carbon/human/scp049/proc/you_are_not_a_doctor,
		/mob/living/carbon/human/scp049/proc/I_sense_the_disease_in_you,
		/mob/living/carbon/human/scp049/proc/Im_here_to_cure_you,
		/mob/living/carbon/human/scp049/proc/cure_action,
	))

	. = ..()

	init_049_skills()

/mob/living/carbon/human/scp049/Destroy()
	pestilence_images = null
	attempted_surgery_on = null
	target = null
	GLOB.scp049s -= src
	return ..()

/mob/living/carbon/human/scp049/proc/init_049_skills()
	skillset.skill_list = list()
	for(var/decl/hierarchy/skill/S in GLOB.skills)
		skillset.skill_list[S.type] = SKILL_UNTRAINED
	skillset.skill_list[SKILL_COOKING] = SKILL_TRAINED
	skillset.skill_list[SKILL_BOTANY] = SKILL_TRAINED
	skillset.skill_list[SKILL_HAULING] = SKILL_MASTER
	skillset.skill_list[SKILL_COMBAT] = SKILL_EXPERIENCED
	skillset.skill_list[SKILL_ANATOMY] = SKILL_EXPERIENCED
	skillset.skill_list[SKILL_CHEMISTRY] = SKILL_BASIC
	skillset.skill_list[SKILL_MEDICAL] = SKILL_EXPERIENCED
	skillset.skill_list[SKILL_SCIENCE] = SKILL_EXPERIENCED
	skillset.on_levels_change()

/mob/living/carbon/human/scp049/Life()
	. = ..()
	if(prob(50) && !contained)
		addtimer(CALLBACK(src, .proc/see_disease), 5 SECONDS) //only occasionally see the disease, less deadly. TODO: containment mechanics
	if(anger==100)
		angry = TRUE

/mob/living/carbon/human/scp049/Login()
	. = ..()
	if(client)
		add_language(LANGUAGE_ENGLISH)
		add_language(LANGUAGE_HUMAN_FRENCH)
		add_language(LANGUAGE_HUMAN_GERMAN)
		add_language(LANGUAGE_HUMAN_SPANISH)
		priority_announcement.Announce("Motion sensors triggered in the containment chamber of SCP-049, on-site security personnel are to investigate the issue.", "Motion Sensors", 'sounds/AI/049.ogg')
		if(!(MUTATION_XRAY in mutations))
			mutations.Add(MUTATION_XRAY)
			update_mutations()
			update_sight()
	if(target)
		target = null

/mob/living/carbon/human/scp049/Logout()
	. = ..()
	if(mind)
		mind = null
	if(target)
		target = null

/mob/living/carbon/human/scp049/proc/see_disease()
	if (client)
		client.images -= pestilence_images
		for (var/image in pestilence_images)
			qdel(image)
		pestilence_images.Cut()
		for(var/mob/living/carbon/human/H in view(15, src))
			if(H.pestilence)
				pestilence_images += image('icons/SCP/scp-049.dmi', H, "pestilence", MOB_LAYER+0.01)
		client.images |= pestilence_images
		if(!angry)
			anger += 5


/mob/living/carbon/human/scp049/proc/Attack_Voice_Line() //for when we're up to no good!
	var/voiceline = list('sounds/scp/voice/SCP049_1.ogg','sounds/scp/voice/SCP049_2.ogg','sounds/scp/voice/SCP049_3.ogg','sounds/scp/voice/SCP049_4.ogg','sounds/scp/voice/SCP049_5.ogg')
	playsound(src, pick(voiceline), 30)
	show_sound_effect(src.loc, src)

/mob/living/carbon/human/scp049/proc/SCP049_Chase_Music(mob/living/carbon/human/target)
	if(!target)
		chasing_sound = FALSE
		return
	chasing_sound = FALSE
	if(target.pestilence && !chasing_sound && !contained)
		chasing_sound = TRUE
		target.playsound_local(src, 'sounds/scp/chase/049_chase.ogg', 50, 0)
		addtimer(CALLBACK(src, .proc/SCP049_Chase_Music), 25 SECONDS)

/mob/living/carbon/human/scp049/proc/check_nearby()
	if(!target)
		curing = FALSE
		return FALSE
	if(target.Adjacent(src))
		return TRUE
	else
		curing = FALSE
		target = null
		return FALSE

/mob/living/carbon/human/scp049/proc/scp049_attack(mob/living/carbon/human/target)
	if(check_nearby() && !curing)
		if(isscp049_1(target))
			return
		if(!target.pestilence)
			to_chat(src, "<span class = 'danger'>They are not infected with the Pestilence.</span>")
			return
		if(curing)
			return

		visible_message("<span class = 'danger'><i>[src] reaches towards [target.real_name]!</i></span>")
		addtimer(CALLBACK(src, .proc/Attack_Voice_Line), 5 SECONDS)

		target.death()
		if(prob(75)) //do you feel lucky, punk?
			target.Stun(60)
			target.emote("collapse")
			cure_action()
		addtimer(CALLBACK(src, .proc/check_nearby), 2 SECONDS)

/mob/living/carbon/human/scp049/get_pressure_weakness()
	return 0

/mob/living/carbon/human/scp049/handle_breath()
	return 1

/mob/living/carbon/human/scp049/movement_delay()
	return 3.0

/mob/living/carbon/human/scp049/UnarmedAttack(mob/living/carbon/human/target)
	if(!isscp049(target) || isscp049_1(src) || src == target)
		return ..(target)
	setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
	if(!target.pestilence)
		to_chat(src, "<span class = 'danger'>They are not infected with the Pestilence.</span>")
		return
	if(isscp343(target))
		to_chat(src, SPAN_WARNING(" You refrain from curing god."))
		return
	switch(src.a_intent)
		if(I_HELP)
			to_chat(src, SPAN_WARNING("You refrain from curing as your intent is set to help."))
			return
		if(I_GRAB)
			scp049_attack(target)

/mob/living/carbon/human/scp049/attack_hand(mob/living/carbon/human/M)
	if (!isscp049_1(M) || M.a_intent == I_HELP)
		if (ishuman(M))
			var/mob/living/carbon/human/H = M
			if (H != src)
				target = H
				H.pestilence = TRUE
		return ..(M)

	if(isscp049_1(M))
		to_chat(M, "<span class = 'danger'><big>You cannot attack your master.</big></span>")
		return

/mob/living/carbon/human/scp049/bullet_act(obj/item/projectile/P, def_zone)
	if (getBruteLoss() + getFireLoss() + getToxLoss() + getCloneLoss() >= 200)
		return
	if (P.damage && !P.nodamage && ishuman(P.firer))
		var/mob/living/carbon/human/H = P.firer
		if (H != src)
			target = H
			H.pestilence = TRUE
	return ..(P, def_zone)

/mob/living/carbon/human/scp049/attackby(obj/item/W, mob/user)
	if(W.force > 0 && ishuman(user))
		var/mob/living/carbon/human/H = user
		if (H != src)
			H.pestilence = TRUE
	return ..(W, user)

/mob/living/carbon/human/proc/door_049(obj/machinery/door/A in filter_list(oview(1), /obj/machinery/door))
	set name = "Pry Open Airlock"
	set category = "SCP-049"


	if (istype(A, /obj/machinery/door/airlock/highsecurity))
		to_chat(src, SPAN_WARNING("\ You cannot open highsecurity doors."))
		return

	if (istype(A, /obj/machinery/door/blast/regular))
		to_chat(src, SPAN_WARNING("\ You cannot open blast doors."))
		return

	if(!istype(A) || incapacitated())
		return

	if(!A.Adjacent(src))
		to_chat(src, SPAN_WARNING("\The [A] is too far away."))
		return

	if(!A.density)
		return

	src.visible_message("\The [src] begins to pry open \the [A]!")

	if(!do_after(src,120,A))
		return

	if(!A.density)
		return

	A.do_animate("spark")
	do_after(10)
	A.set_broken(TRUE)
	var/check = A.open(1)
	src.visible_message("\The [src] slices \the [A]'s controls[check ? ", ripping it open!" : ", breaking it!"]")

// special channel that lets SCP-049 and SCP-049-1 communicate
/mob/living/carbon/human/proc/SCP_049_talk()
	set category = "SCP-049"
	set name = "Communicate"
	if (isscp049(src) || isscp049_1(src))
		var/say = sanitize(input(src, "Communicate what?") as text)
		for (var/M in GLOB.scp049s|GLOB.scp049_1s)
			to_chat(M,"<em><strong>[real_name]</strong>: [say]</em>")

// SCP-049 emotes
/mob/living/carbon/human/scp049/proc/greetings()
	set category = "SCP-049"
	set name = "Greetings"
	if (world.time >= next_emote)
		playsound(src, 'sounds/scp/voice/SCP049_1.ogg', 30)
		show_sound_effect(src.loc, src)
		next_emote = world.time + 10

/mob/living/carbon/human/scp049/proc/yet_another_victim()
	set category = "SCP-049"
	set name = "Yet another victim"
	if (world.time >= next_emote)
		playsound(src, 'sounds/scp/voice/SCP049_2.ogg', 30)
		show_sound_effect(src.loc, src)
		next_emote = world.time + 40

/mob/living/carbon/human/scp049/proc/you_are_not_a_doctor()
	set category = "SCP-049"
	set name = "You are not a doctor"
	if (world.time >= next_emote)
		playsound(src, 'sounds/scp/voice/SCP049_3.ogg', 30)
		show_sound_effect(src.loc, src)
		next_emote = world.time + 20

/mob/living/carbon/human/scp049/proc/I_sense_the_disease_in_you()
	set category = "SCP-049"
	set name = "I sense the disease in you"
	if (world.time >= next_emote)
		playsound(src, 'sounds/scp/voice/SCP049_4.ogg', 30)
		show_sound_effect(src.loc, src)
		next_emote = world.time + 20

/mob/living/carbon/human/scp049/proc/Im_here_to_cure_you()
	set category = "SCP-049"
	set name = "I'm here to cure you"
	if (world.time >= next_emote)
		playsound(src, 'sounds/scp/voice/SCP049_5.ogg', 30)
		show_sound_effect(src.loc, src)
		next_emote = world.time + 40

/mob/living/carbon/human/scp049/proc/cure_action()
	set category = "SCP-049"
	set name = "Cure Victim"


	//if(!G.affecting.pestilence)
	//	return
	curing = TRUE
	conversion_act(target)

/mob/living/carbon/human/scp049/proc/conversion_act(mob/living/carbon/human/target)
	if(client)
		var/obj/item/grab/G = src.get_active_hand()
		if(!G)
			to_chat(src, SPAN_WARNING("We must take hold of a victim to cure their disease."))
			return

		target = G.affecting

	if(!(istype(target, /mob/living/carbon/human)))
		to_chat(src, SPAN_WARNING("This is not human, and is therefore free from the disease."))
		return
	if(!target.pestilence)
		to_chat(src, "<span class = 'danger'>They are not infected with the Pestilence.</span>")
		return
	if(isscp049_1(target))
		return
	if(!(istype(target, /mob/living/carbon/human)))
		to_chat(src, SPAN_WARNING("This is not human, and is therefore free from the disease."))
		return

	for(var/stage = 1, stage<=4, stage++)
		switch(stage)
			if(1)
				to_chat(src, SPAN_NOTICE("The disease has taken hold. We must work quickly..."))
				src.visible_message(SPAN_DANGER("[src] looms over [target]!"))
				target.adjustBruteLoss(25)
			if(2)
				to_chat(src, SPAN_NOTICE("You gather your tools."))
				src.visible_message(SPAN_WARNING("[src] draws a rolled set of surgical equipment from their bag!"))
				Attack_Voice_Line()
			if(3)
				to_chat(src, SPAN_NOTICE("You create your first incision."))
				src.visible_message(SPAN_DANGER("[src] begins slicing open [target] with a scalpel!"))
				to_chat(target, SPAN_DANGER("You feel a sharp stabbing pain as your life begins to wane."))
				new /obj/effect/decal/cleanable/blood/splatter(get_turf(target), target.species.blood_color)
			if(4)
				to_chat(src, SPAN_NOTICE("You spend a great deal of time expertly curing this victim's disease."))
				src.visible_message(SPAN_DANGER("[src] begins performing a horrifying procedure on [target]!"))

		if(!do_after(src, 15 SECONDS, target))
			to_chat(src, SPAN_WARNING("Our curing of [target] has been interrupted!"))
			curing = FALSE
			return

	target.pre_scp049_name = target.name
	target.pre_scp049_real_name = target.real_name
	target.pre_scp049_species = target.species.name
	target.is_scp_instance = TRUE
	target.scp_049_instance = TRUE
	target.undead()
	target.visible_message("<span class = 'danger'><big>The lifeless corpse of [target.pre_scp049_name] begins to convulse violently!</big></span>")
	target.name = target.real_name
	target.rejuvenate()
	target.verbs += /mob/living/carbon/human/proc/SCP_049_talk
	GLOB.scp049_1s += target
	target.pestilence = FALSE
	to_chat(target, SPAN_DANGER("You feel the last of your mind drift away..."))
	to_chat(src, SPAN_NOTICE("You have cured [target]."))
	curing = FALSE

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
	return FALSE

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
	return  ..()

/mob/living/carbon/human/scp049/Initialize()
	..()
	add_language(LANGUAGE_ENGLISH, TRUE)
	add_language(LANGUAGE_HUMAN_FRENCH, TRUE)
	add_language(LANGUAGE_HUMAN_GERMAN, TRUE)
	add_language(LANGUAGE_HUMAN_SPANISH, TRUE)
	update_languages()
	// fix names
	fully_replace_character_name("SCP-049")

	GLOB.scp049s += src
	verbs += /mob/living/carbon/human/proc/SCP_049_talk
	verbs += /mob/living/carbon/human/proc/door_049

	// emotes
	verbs += list(
		/mob/living/carbon/human/scp049/proc/greetings,
		/mob/living/carbon/human/scp049/proc/yet_another_victim,
		/mob/living/carbon/human/scp049/proc/you_are_not_a_doctor,
		/mob/living/carbon/human/scp049/proc/I_sense_the_disease_in_you,
		/mob/living/carbon/human/scp049/proc/Im_here_to_cure_you,
		/mob/living/carbon/human/scp049/proc/cure_action
	)

/mob/living/carbon/human/scp049/Destroy()
	pestilence_images = null
	attempted_surgery_on = null
	target = null
	GLOB.scp049s -= src
	return ..()

/mob/living/carbon/human/scp049/Life()
	..()
	if(prob(50) && !contained)
		addtimer(CALLBACK(src, .proc/see_disease), 5 SECONDS) //only occasionally see the disease, less deadly. TODO: containment mechanics
	if(anger==100)
		angry = TRUE

/mob/living/carbon/human/scp049/Login()
	. = ..()
	if(client)
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
	var/voiceline = list('sound/scp/voice/SCP049_1.ogg','sound/scp/voice/SCP049_2.ogg','sound/scp/voice/SCP049_3.ogg','sound/scp/voice/SCP049_4.ogg','sound/scp/voice/SCP049_5.ogg')
	playsound(src, pick(voiceline), 30)

/mob/living/carbon/human/scp049/proc/getTarget()
	if(client)
		target = null
		return target
	if(MUTATION_XRAY in mutations) //dont let the ai see through walls
		mutations.Remove(MUTATION_XRAY)
		update_mutations()
		update_sight()
	if(target == src)
		target = null
		return target
	if(target && !(target in view(10, src))) //if they get away, they get away
		target = null
		return target
	if (!target || target.stat == DEAD)
		var/list/possible_targets = list()
		for(var/mob/living/carbon/human/L in view(10, src))
			if(!(istype(L, /mob/living/carbon/human/scp049)) && !(L.scp_049_instance))
				if(L.stat != DEAD)
					possible_targets += L
		CHECK_TICK
		var/attempts = 0
		while (++attempts <= 3)
			for (var/living in possible_targets)
				var/mob/living/L = living
				switch (attempts)
					if (1)
						// pick the best target, a human in our prefered age range
						if (ishuman(L))
							var/mob/living/carbon/human/H = L
							if (H.age >= 10 && H.age <= 25)
								target = H
								return target
					if (2)
						// pick any human target
						if (ishuman(L))
							target = L
							return target
					if (3)
						// pick any target
						target = L
						return target
	return target

/mob/living/carbon/human/scp049/proc/pursueTarget()
	if(client)
		return FALSE
	walk(src, null)
	addtimer(CALLBACK(src, .proc/getTarget), 3 SECONDS)

	if(!target)
		return FALSE

	//human nearby? well are they infected? if so make them regret it
	if(target.pestilence && !chasing_sound && !contained)
		chasing_sound = TRUE
		target.playsound_local(src, 'sound/scp/chase/049_chase.ogg', 50, 0)
		addtimer(CALLBACK(src, .proc/SCP049_Chase_Music), 23 SECONDS)
	//human nearby? wander up to them
	if (target && !(target in orange(1, src)))
		walk_to(src, target, 1,10,0.1)
		CHECK_TICK
		return TRUE

	walk(src, null)
	if(!target.pestilence)
		target = null
		return FALSE

	//below is the part where they're being chased with lethal intent and him running up to them is to do his good work
	SCP049_Chase_Music()

	if(check_nearby())
		to_chat(target, "<span class = 'danger'>You feel the life draining from your body! You can't move!</span>")
		scp049_attack(target)


	CHECK_TICK

	return TRUE

/mob/living/carbon/human/scp049/proc/SCP049_Chase_Music(mob/living/carbon/human/target)
	if(!target)
		chasing_sound = FALSE
		return
	chasing_sound = FALSE
	if(target.pestilence && !chasing_sound && !contained)
		chasing_sound = TRUE
		target.playsound_local(src, 'sound/scp/chase/049_chase.ogg', 50, 0)
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

/mob/living/carbon/human/scp049/proc/scp049_attack(var/mob/living/carbon/human/target)
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

		target.Weaken(10)
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
		to_chat(src, "<span class='warning'> You refrain from curing god.</span>")
		return
	switch(src.a_intent)
		if(I_HELP)
			to_chat(src, "<span class='warning'>You refrain from curing as your intent is set to help.</span>")
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

/mob/living/carbon/human/scp049/bullet_act(var/obj/item/projectile/P, var/def_zone)
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
		to_chat(src, "<span class='warning'>\ You cannot open highsecurity doors.</span>")
		return

	if (istype(A, /obj/machinery/door/blast/regular))
		to_chat(src, "<span class='warning'>\ You cannot open blast doors.</span>")
		return

	if(!istype(A) || incapacitated())
		return

	if(!A.Adjacent(src))
		to_chat(src, "<span class='warning'>\The [A] is too far away.</span>")
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
	A.stat |= BROKEN
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
		playsound(src, 'sound/scp/voice/SCP049_1.ogg', 30)
		next_emote = world.time + 10

/mob/living/carbon/human/scp049/proc/yet_another_victim()
	set category = "SCP-049"
	set name = "Yet another victim"
	if (world.time >= next_emote)
		playsound(src, 'sound/scp/voice/SCP049_2.ogg', 30)
		next_emote = world.time + 40

/mob/living/carbon/human/scp049/proc/you_are_not_a_doctor()
	set category = "SCP-049"
	set name = "You are not a doctor"
	if (world.time >= next_emote)
		playsound(src, 'sound/scp/voice/SCP049_3.ogg', 30)
		next_emote = world.time + 20

/mob/living/carbon/human/scp049/proc/I_sense_the_disease_in_you()
	set category = "SCP-049"
	set name = "I sense the disease in you"
	if (world.time >= next_emote)
		playsound(src, 'sound/scp/voice/SCP049_4.ogg', 30)
		next_emote = world.time + 20

/mob/living/carbon/human/scp049/proc/Im_here_to_cure_you()
	set category = "SCP-049"
	set name = "I'm here to cure you"
	if (world.time >= next_emote)
		playsound(src, 'sound/scp/voice/SCP049_5.ogg', 30)
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
			to_chat(src, "<span class='warning'>We must take hold of a victim to cure their disease.</span>")
			return

		target = G.affecting

	if(!(istype(target, /mob/living/carbon/human)))
		to_chat(src, "<span class='warning'>This is not human, and is therefore free from the disease.</span>")
		return
	if(!target.pestilence)
		to_chat(src, "<span class = 'danger'>They are not infected with the Pestilence.</span>")
		return
	if(isscp049_1(target))
		return
	if(!(istype(target, /mob/living/carbon/human)))
		to_chat(src, "<span class='warning'>This is not human, and is therefore free from the disease.</span>")
		return

	for(var/stage = 1, stage<=4, stage++)
		switch(stage)
			if(1)
				to_chat(src, "<span class='notice'>The disease has taken hold. We must work quickly...</span>")
				src.visible_message("<span class='danger'>[src] looms over [target]!</span>")
				target.adjustBruteLoss(25)
			if(2)
				to_chat(src, "<span class='notice'>You gather your tools.</span>")
				src.visible_message("<span class='warning'>[src] draws a rolled set of surgical equipment from their bag!</span>")
				Attack_Voice_Line()
			if(3)
				to_chat(src, "<span class='notice'>You create your first incision.</span>")
				src.visible_message("<span class='danger'>[src] begins slicing open [target] with a scalpel!</span>")
				to_chat(target, "<span class='danger'>You feel a sharp stabbing pain as your life begins to wane.</span>")
				new /obj/effect/decal/cleanable/blood/splatter(get_turf(target), target.species.blood_color)
			if(4)
				to_chat(src, "<span class='notice'>You spend a great deal of time expertly curing this victim's disease.</span>")
				src.visible_message("<span class='danger'>[src] begins performing a horrifying procedure on [target]!</span>")

		if(!do_after(src, 15 SECONDS, target))
			to_chat(src, "<span class='warning'>Our curing of [target] has been interrupted!</span>")
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
	to_chat(target, "<span class='danger'>You feel the last of your mind drift away...</span>")
	to_chat(src, "<span class='notice'>You have cured [target].</span>")
	curing = FALSE
	getTarget()

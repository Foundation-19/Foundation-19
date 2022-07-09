#define NEXT_EMOTE_TIME 5 SECONDS

GLOBAL_LIST_EMPTY(scp049s)
GLOBAL_LIST_EMPTY(scp049_1s)

/mob/living/carbon/human/scp049
	desc = "A mysterious plague doctor."
	SCP = /datum/scp/scp_049
	icon = 'icons/SCP/scp-049.dmi'
	icon_state = null
	var/list/pestilence_images = list()
	icon_state = ""
	var/contained = TRUE
	var/list/infected_players = list() // List of players infected with the pestillence
	var/emote_cooldown = 0 // How long before next emote

/datum/scp/scp_049
	name = "SCP-049"
	designation = "049"
	classification = EUCLID

/mob/living/carbon/human/scp049/update_icons()
	return

/mob/living/carbon/human/scp049/on_update_icon()
	if (lying || resting)
		var/matrix/M =  matrix()
		transform = M.Turn(90)
	else
		transform = null
	return

/mob/living/carbon/human/scp049/Initialize()
	..()
	add_language(LANGUAGE_ENGLISH)
	add_language(LANGUAGE_HUMAN_FRENCH)
	add_language(LANGUAGE_HUMAN_GERMAN)
	add_language(LANGUAGE_HUMAN_SPANISH)
	update_languages()
	// fix names
	fully_replace_character_name("SCP-049")

	set_species("SCP-049")
	GLOB.scp049s += src
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
	GLOB.scp049s -= src
	. = ..()

/mob/living/carbon/human/scp049/examininate(var/mob/living/carbon/human/target)
	. = ..()
	if(target in infected_players)
		to_chat(src, SPAN_DANGER("They are infected with the pestilence! I need to cure them."))

/mob/living/carbon/human/scp049/proc/is_valid_curing_target(var/mob/living/carbon/human/target)

/mob/living/carbon/human/scp049/Life()
	..()
	if(prob(15) && !contained)
		addtimer(CALLBACK(src, .proc/see_disease), 5 SECONDS) //only occasionally see the disease, less deadly. TODO: containment mechanics

/mob/living/carbon/human/scp049/Login()
	. = ..()
	if(client)
		if(!(MUTATION_XRAY in mutations))
			mutations.Add(MUTATION_XRAY)
			update_mutations()
			update_sight()

/mob/living/carbon/human/scp049/Logout()
	. = ..()
	if(mind)
		mind = null

/mob/living/carbon/human/scp049/proc/see_disease()
	for(var/mob/living/carbon/human/H in view(15, src))
		if(prob(5))
			infected_players += H
	if (client)
		client.images -= pestilence_images
		for (var/image in pestilence_images)
			qdel(image)
		pestilence_images.Cut()
		for(var/mob/living/carbon/human/H in view(15, src))
			if(H in infected_players)
				pestilence_images += image('icons/SCP/scp-049.dmi', H, "pestilence", MOB_LAYER+0.01)
		client.images |= pestilence_images

/mob/living/carbon/human/scp049/get_pressure_weakness()
	return 0

/mob/living/carbon/human/scp049/handle_breath()
	return 1

/mob/living/carbon/human/scp049/movement_delay()
	return 3.0

/mob/living/carbon/human/scp049/UnarmedAttack(mob/living/carbon/human/target)
	if(!isscp049(target) || isspecies(src, SPECIES_049_1) || src == target)
		return ..(target)
	setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
	if(isscp343(target))
		to_chat(src, "<span class='warning'> You refrain from curing god.</span>")
		return
	switch(a_intent)
		if(I_HELP)
			to_chat(src, "<span class='warning'>You refrain from curing as your intent is set to help.</span>")
			return
		if(I_GRAB)
			//scp049_attack(target)
			return

	if(isspecies(target, SPECIES_049_1))
		to_chat(target, SPAN_DANGER("They are already cured."))
		return

/mob/living/carbon/human/scp049/bullet_act(var/obj/item/projectile/P, var/def_zone)
	if (getBruteLoss() + getFireLoss() + getToxLoss() + getCloneLoss() >= 200)
		return
	return ..(P, def_zone)

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

// SCP-049 emotes
/mob/living/carbon/human/scp049/proc/greetings()
	set category = "SCP-049"
	set name = "Greetings"
	if (world.time >= emote_cooldown)
		playsound(src, 'sound/scp/voice/SCP049_1.ogg', 30)
		emote_cooldown = world.time + NEXT_EMOTE_TIME

/mob/living/carbon/human/scp049/proc/yet_another_victim()
	set category = "SCP-049"
	set name = "Yet another victim"
	if (world.time >= emote_cooldown)
		playsound(src, 'sound/scp/voice/SCP049_2.ogg', 30)
		emote_cooldown = world.time + NEXT_EMOTE_TIME

/mob/living/carbon/human/scp049/proc/you_are_not_a_doctor()
	set category = "SCP-049"
	set name = "You are not a doctor"
	if (world.time >= emote_cooldown)
		playsound(src, 'sound/scp/voice/SCP049_3.ogg', 30)

/mob/living/carbon/human/scp049/proc/I_sense_the_disease_in_you()
	set category = "SCP-049"
	set name = "I sense the disease in you"
	if (world.time >= emote_cooldown)
		playsound(src, 'sound/scp/voice/SCP049_4.ogg', 30)
		emote_cooldown = world.time + NEXT_EMOTE_TIME

/mob/living/carbon/human/scp049/proc/Im_here_to_cure_you()
	set category = "SCP-049"
	set name = "I'm here to cure you"
	if (world.time >= emote_cooldown)
		playsound(src, 'sound/scp/voice/SCP049_5.ogg', 30)
		emote_cooldown = world.time + NEXT_EMOTE_TIME

/mob/living/carbon/human/scp049/proc/cure_action()
	set category = "SCP-049"
	set name = "Cure Victim"

	conversion_act()

/mob/living/carbon/human/scp049/proc/conversion_act()
	var/mob/living/carbon/human/target
	if(client)
		var/obj/item/grab/G = src.get_active_hand()
		if(!G)
			to_chat(src, "<span class='warning'>We must take hold of a victim to cure their disease.</span>")
			return

		target = G.affecting

	if(!(istype(target, /mob/living/carbon/human)))
		to_chat(src, "<span class='warning'>This is not human, and is therefore free from the disease.</span>")
		return
	if(isspecies(target, SPECIES_049_1))
		to_chat(src, SPAN_WARNING("I've already cured them"))
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
				//Attack_Voice_Line()
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
			return

	target.visible_message("<span class = 'danger'><big>The lifeless corpse of [target.name] begins to convulse violently!</big></span>")
	GLOB.scp049_1s += target
	target.undead()
	infected_players -= target
	to_chat(target, "<span class='danger'>You feel the last of your mind drift away...</span>")
	to_chat(src, "<span class='notice'>You have cured [target].</span>")

#undef NEXT_EMOTE_TIME

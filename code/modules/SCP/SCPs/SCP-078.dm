/obj/structure/scp078
	name = "neon sign"
	desc = "A flickering neon sign. Its messages seem... provocative."
	icon = 'icons/obj/structures.dmi'
	icon_state = "neon_sign"
	anchored = TRUE
	density = TRUE
	var/active = TRUE
	var/compulsion_range = 5
	var/compulsion_strength = 1
	var/message_cooldown = 10 SECONDS
	var/last_message_time = 0
	var/list/taunting_messages = list(
		"DO IT.",
		"NO ONE WILL KNOW.",
		"WHAT'S THE WORST THAT COULD HAPPEN?",
		"YOU KNOW YOU WANT TO.",
		"EVERYONE ELSE IS DOING IT.",
		"JUST ONCE.",
		"WHO'S GOING TO STOP YOU?",
		"LIVE A LITTLE.",
		"DANGER IS EXCITING.",
		"TOUCH IT.",
		"GO AHEAD.",
		"YOU'RE NOT SCARED, ARE YOU?",
		"PROVE YOU'RE BRAVE."
	)

/obj/structure/scp078/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src,
		"neon sign",
		SCP_EUCLID,
		"078"
	)
	START_PROCESSING(SSobj, src)

/obj/structure/scp078/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/scp078/Process()
	if(!active)
		return
	if(prob(10) && (world.time > last_message_time + message_cooldown))
		var/msg = pick(taunting_messages)
		audible_message(SPAN_DANGER("\The [src] flickers: \"[msg]\""))
		last_message_time = world.time
	for(var/mob/living/carbon/human/H in range(compulsion_range, src))
		if(H.SCP || H.stat)
			continue
		apply_compulsion(H)

/obj/structure/scp078/proc/apply_compulsion(mob/living/carbon/human/H)
	var/dist = get_dist(H, src)
	if(dist > compulsion_range)
		return
	var/effect_strength = compulsion_strength * (1 - (dist / compulsion_range))
	if(!prob(effect_strength * 15))
		return
	switch(dist)
		if(1 to 2)
			if(prob(8))
				to_chat(H, SPAN_DANGER("You feel an overwhelming urge to do something reckless!"))
				H.adjust_confusion(3 SECONDS)
		if(3 to 5)
			if(prob(15))
				to_chat(H, SPAN_ITALIC("The sign's message seems aimed at you... You feel emboldened."))
				H.adjust_drugginess(2 SECONDS)

/obj/structure/scp078/attack_hand(mob/user)
	if(active)
		to_chat(user, SPAN_NOTICE("You deactivate \the [src]."))
		active = FALSE
		icon_state = "neon_sign_off"
		if(SCP && SCP.research)
			SCP.research.set_containment_status(SCP_CONTAINED)
	else
		to_chat(user, SPAN_NOTICE("You activate \the [src]. The neon flickers to life."))
		active = TRUE
		icon_state = "neon_sign"
		if(SCP && SCP.research)
			SCP.research.set_containment_status(SCP_BREACHED)

/obj/structure/scp078/attackby(obj/item/W, mob/user)
	if(iswirecutter(W) || isscrewdriver(W))
		to_chat(user, SPAN_NOTICE("You begin disconnecting \the [src]'s power supply..."))
		if(do_after(user, 5 SECONDS, src))
			active = FALSE
			icon_state = "neon_sign_off"
			to_chat(user, SPAN_NOTICE("You permanently disable \the [src]."))
			if(SCP && SCP.research)
				SCP.research.set_containment_status(SCP_CONTAINED)
		return
	. = ..()

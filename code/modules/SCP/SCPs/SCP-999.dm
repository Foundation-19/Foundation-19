GLOBAL_LIST_EMPTY(scp999s)

/datum/scp/scp_999
	name = "SCP-999"
	designation = "999"
	classification = SAFE

/mob/living/simple_animal/scp_999
	name = "SCP-999"
	desc = "A large, amorphous, gelatinous mass of translucent orange slime. It looks really happy."
	icon = 'icons/SCP/scp-999.dmi'
	icon_living = "SCP-999"
	icon_dead = "SCP-999_d"
	alpha = 200
	SCP = /datum/scp/scp_999
	maxHealth = 1500
	health = 1500
	hud_type = /datum/hud/slime
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7
	universal_speak = 1	// 999 can understand and speak every language, although his text gets altered
	speak_emote = list("blubbers", "glubs")

/mob/living/simple_animal/scp_999/Initialize()
	GLOB.scp999s += src
	return ..()

/mob/living/simple_animal/scp_999/handle_autohiss(message, datum/language/speaking)

	var/regex/words = new(@"(\S+)", "ig")

	var/end_char = copytext(message, length(message), length(message) + 1)
	if(end_char in list(".", "?", "!", "-", "~", ":"))
		return words.Replace(copytext(message, 1, length(message)), /mob/living/simple_animal/scp_999/proc/glubbify) + end_char
	else
		return words.Replace(message, /mob/living/simple_animal/scp_999/proc/glubbify)

/mob/living/simple_animal/scp_999/proc/glubbify(match)
	. = "gl"
	for(var/i = (max(0, length(match) - 3)), i > 0, i--)
		. += "u"
	. += "b"

/mob/living/simple_animal/scp_999/Destroy()
	GLOB.scp999s -= src
	return ..()

/mob/living/simple_animal/scp_999/update_icon()
	if(stat != DEAD && resting)
		icon_state = "SCP-999_rest"
	else if(stat == DEAD)
		icon_state = "SCP-999_d"
	else
		icon_state = "SCP-999"

/mob/living/simple_animal/scp_999/death()
	. = ..()
	update_icon()

/mob/living/simple_animal/scp_999/Life()
	. = ..()
	update_icon()

/mob/living/simple_animal/scp_999/UnarmedAttack(atom/a)
	if(ishuman(a))
		var/mob/living/carbon/human/H = a
		switch(a_intent)
			if(I_HELP)
				H.visible_message(SPAN_NOTICE("[src] gives [a] a big hug!"), SPAN_NOTICE("[src] hugs you, filling you with happiness!"))
				H.make_reagent(6, /datum/reagent/medicine/antidepressant/anomalous_happiness)
				H.emote(pick("laugh","giggle"))
			if(I_DISARM)
				H.visible_message(SPAN_WARNING("[src] begins to wrap around [a]'s legs!"), SPAN_WARNING("[src] begins wrapping around your legs!"))
				H.make_reagent(2, /datum/reagent/medicine/antidepressant/anomalous_happiness)
				H.emote(pick("laugh","giggle"))
				if(do_after(src, 15, H))
					playsound(loc, 'sound/misc/slip.ogg', 50, 1, -3)
					H.Weaken(6)
					H.Stun(3)
					visible_message(SPAN_WARNING("[src] wraps around [H]'s legs, tripping them!"))
//			if(I_GRAB)
			if(I_HURT)
				H.visible_message(SPAN_WARNING("[src] gives [a] a tickle attack!"), SPAN_WARNING("[src] gives you a tickle attack, filling you with happiness!"))
				H.make_reagent(10, /datum/reagent/medicine/antidepressant/anomalous_happiness)
				H.emote("laugh")
				H.Weaken(6)

/mob/living/scp999
	name = "orange slime"
	desc = "A large, amorphous, gelatinous mass of translucent orange slime. It looks really happy."
	icon = 'icons/SCP/scp-999.dmi'

	icon_state = "SCP-999"
	alpha = 200

	maxHealth = 1500
	health = 1500

	hud_type = /datum/hud/slime
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7
	universal_speak = 1	// 999 can understand and speak every language, although his text gets altered
	speak_emote = list("blubbers", "glubs")

/mob/living/scp999/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"orange slime", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_SAFE, //Obj Class
		"999", //Numerical Designation
		SCP_PLAYABLE|SCP_ROLEPLAY
	)

	SCP.min_time = 5 MINUTES

//Mechanics

/mob/living/scp999/proc/glubbify(match)
	. = "gl"
	for(var/i = (max(0, length(match) - 3)), i > 0, i--)
		. += "u"
	. += "b"

//Overrides

/mob/living/scp999/handle_autohiss(message, datum/language/speaking)

	var/regex/words = new(@"(\S+)", "ig")

	var/end_char = copytext(message, length(message), length(message) + 1)
	if(end_char in list(".", "?", "!", "-", "~", ":"))
		return words.Replace(copytext(message, 1, length(message)), TYPE_PROC_REF(/mob/living/scp999, glubbify)) + end_char
	else
		return words.Replace(message, TYPE_PROC_REF(/mob/living/scp999, glubbify))

/mob/living/scp999/update_icon()
	if(stat == DEAD)
		icon_state = "SCP-999_d"
	else if(resting || lying)
		icon_state = "SCP-999_rest"
	else
		icon_state = "SCP-999"

/mob/living/scp999/UnarmedAttack(atom/a)
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
				if(do_after(src, 1.5 SECONDS, H, bonus_percentage = 100))
					playsound(loc, 'sounds/misc/slip.ogg', 50, 1, -3)
					H.Weaken(6)
					H.Stun(3)
					visible_message(SPAN_WARNING("[src] wraps around [H]'s legs, tripping them!"))
			if(I_HURT)
				H.visible_message(SPAN_WARNING("[src] gives [a] a tickle attack!"), SPAN_WARNING("[src] gives you a tickle attack, filling you with happiness!"))
				H.make_reagent(10, /datum/reagent/medicine/antidepressant/anomalous_happiness)
				H.emote("laugh")
				H.Weaken(6)
	else
		return ..()

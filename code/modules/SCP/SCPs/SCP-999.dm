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
	universal_speak = 1
	speak_emote = list("blubbers", "glubs")

	var/spawn_area
	var/morale_aura_range = 5
	var/morale_buff_cooldown = 30 SECONDS
	var/last_morale_buff = 0
	var/calm_aura_range = 4
	var/calm_cooldown = 60 SECONDS
	var/last_calm_attempt = 0

/mob/living/scp999/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src,
		"orange slime",
		SCP_SAFE,
		"999",
		SCP_PLAYABLE|SCP_ROLEPLAY
	)

	SCP.min_time = 5 MINUTES
	spawn_area = get_area(src)

/mob/living/scp999/Life()
	. = ..()
	if(. && !stat)
		apply_morale_aura()
		try_calm_nearby_scp()

/mob/living/scp999/proc/apply_morale_aura()
	if(world.time < last_morale_buff + morale_buff_cooldown)
		return
	last_morale_buff = world.time
	for(var/mob/living/carbon/human/H in range(morale_aura_range, src))
		if(H.SCP)
			continue
		if(H.stat)
			continue
		H.adjust_hallucination(-5, 0)
		H.adjust_drugginess(-2 SECONDS)
		H.adjust_confusion(-2 SECONDS)
		H.adjust_dizzy_up_to(-5 SECONDS, 0)

/mob/living/scp999/proc/try_calm_nearby_scp()
	if(world.time < last_calm_attempt + calm_cooldown)
		return
	last_calm_attempt = world.time
	for(var/mob/living/M in range(calm_aura_range, src))
		if(!M.SCP || M == src)
			continue
		if(M.SCP.designation == "999")
			continue
		if(ismob(M) && M.SCP.research && M.SCP.research.containment_status == SCP_BREACHED)
			if(prob(10))
				visible_message(SPAN_NOTICE("[src] nuzzles against [M] soothingly!"))
				if(iscarbon(M))
					var/mob/living/carbon/LM = M
					LM.adjust_hallucination(-10, 0)
				if(isliving(M))
					var/mob/living/LL = M
					LL.Weaken(3)
					LL.visible_message(SPAN_NOTICE("[M] seems to calm down momentarily near [src]."))
				if(M.SCP.designation == "049" && ishuman(M))
					to_chat(M, SPAN_NOTICE("The Pestilence... it feels less pressing near this creature."))
				if(M.SCP.designation == "082")
					to_chat(M, SPAN_NOTICE("You feel... less hungry. For now."))

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

#define HUGGING 1
#define IMMOBILIZING 2
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
	var/mob/living/carbon/human/attached
	var/attached_mode = HUGGING
	var/last_effect
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7

/mob/living/simple_animal/scp_999/Initialize()
	GLOB.scp999s += src
	return ..()

/mob/living/simple_animal/scp_999/say(message, datum/language/speaking = null, whispering)
	to_chat(src,SPAN_NOTICE("You cannot speak."))
	return FALSE

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
	if(attached)
		if(QDELETED(attached) || !attached.loc)
			attached = null
			return
		forceMove(attached.loc)
		if(last_effect == null || ((last_effect + 1 MINUTE) <= world.time))
			last_effect = world.time

			if(attached_mode == IMMOBILIZING)
				playsound(loc, 'sound/misc/slip.ogg', 50, 1, -3)
				attached.Weaken(6)
				attached.Stun(3)
				visible_message(SPAN_WARNING("[src] wraps around [attached]'s legs, tripping them!"))

			attached.make_reagent(5, /datum/reagent/medicine/antidepressant/anomalous_happiness)
			attached.emote(pick("laugh","giggle"))

/mob/living/simple_animal/scp_999/UnarmedAttack(atom/a)
	if(ishuman(a))
		if(a_intent == I_HELP)
			attached_mode = HUGGING
			attached = a
			a.visible_message(SPAN_NOTICE("[src] begins to give [attached] a big hug!"), SPAN_NOTICE("[src] begins hugging you, filling you with happiness!"))
		else if(a_intent == I_HURT)
			attached_mode = IMMOBILIZING
			attached = a
			a.visible_message(SPAN_WARNING("[src] begins to wrap around [attached]!"), SPAN_WARNING("[src] begins wrapping around you, filling you with happiness!"))
		forceMove(get_turf(attached))

/mob/living/simple_animal/scp_999/Move(a,b,f)
	if(attached)
		if(attached_mode == HUGGING)
			to_chat(src, SPAN_NOTICE("You are hugging someone! Detach to move!"))
			return
		else
			if(prob(5))
				attached.Move(a,b,f)
			return
	return ..(a,b,f)

/mob/living/simple_animal/scp_999/verb/detach()
	set category = "SCP"
	set name = "Detach"
	if(attached)
		forceMove(get_turf(src))
		visible_message(SPAN_NOTICE("[src] detaches from [attached]!"))
		attached = null
	else
		to_chat(src, SPAN_NOTICE("<i>You aren't attached to anything!</i>"))

#undef IMMOBILIZING
#undef HUGGING

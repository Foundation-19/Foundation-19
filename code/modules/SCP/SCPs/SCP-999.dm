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
	var/mob/living/carbon/attached
	var/attached_mode = HUGGING
	var/list/last_healing = list()
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7

/mob/living/simple_animal/scp_999/Initialize()
	..()
	GLOB.scp999s += src

/mob/living/simple_animal/scp_999/say(var/message, var/datum/language/speaking = null, whispering)
	src << "<span class = 'notice'>You cannot speak.</span>"
	return 0

/mob/living/simple_animal/scp_999/Destroy()
	last_healing = null
	GLOB.scp999s -= src
	..()

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
		forceMove(attached.loc)
		if(last_healing[attached] == null || ((last_healing[attached] + 2 MINUTES) >= world.time))
			last_healing[attached] = world.time
			if(attached_mode == HUGGING)
				attached.adjustOxyLoss(-rand(20,30))
				attached.adjustToxLoss(-rand(20,30))
				attached.adjustBruteLoss(-rand(20,30))
				attached.adjustFireLoss(-rand(20, 30))
				attached.adjustHalLoss(-200)
				to_chat(attached, "<span class='notice'>You feel your wounds grow numb...</span>")
				attached.emote(pick("laugh","giggle","smile","grin"))
			else
				if(prob(20))
					attached.Stun(3)
					visible_message("<span class='warning'>[src] wraps around [attached]'s legs, immobilizing them!</span>")
					attached.emote(pick("laugh","giggle","smile","grin"))

/mob/living/simple_animal/scp_999/UnarmedAttack(atom/a)
	if(ishuman(a))
		if(a_intent == I_HELP)
			attached_mode = HUGGING
			attached = a
			a.visible_message("<span class='notice'>[src] begins to give [attached] a big hug!</span>", "<span class='notice'>[src] begins hugging you, filling you with happiness!</span>")
		else if(a_intent == I_HURT)
			attached_mode = IMMOBILIZING
			attached = a
			a.visible_message("<span class='warning'>[src] begins to wrap around [attached]!</span>", "<span class='warning'>[src] begins wrapping around you, filling you with happiness!</span>")
		forceMove(get_turf(attached))

/mob/living/simple_animal/scp_999/Move(a,b,f)
	if(attached)
		if(attached_mode == HUGGING)
			to_chat(src, "<span class='notice'>You are hugging someone! Detach to move!</span>")
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
		visible_message("<span class='notice'>[src] detaches from [attached]!</span>")
		attached = null
	else
		to_chat(src, "<span class='warning'><i>We aren't attached to anything!</i></span>")

#undef IMMOBILIZING
#undef HUGGING

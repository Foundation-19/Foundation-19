/mob/living/simple_animal/friendly/retaliate/scp066
	name = "ball of yarn"
	desc = "An amorphous red mass of braided yarn and ribbon."
	icon = 'icons/SCP/scp-066.dmi'

	icon_state = "066"
	icon_living = "066"
	icon_dead = "dead"
	response_help = "plays with"
	response_disarm = "gently pushes aside"
	response_harm = "kicks"

	maxHealth = 500
	health = 500

	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 3

	movement_sound = 'sounds/scp/066/Roll.ogg'

	ai_holder_type = /datum/ai_holder/simple_animal/retaliate/scp066
	say_list_type = /datum/say_list/scp066

	//Config

	///How long until we can do a regular emote
	var/emote_passive_cooldown = 10 SECONDS
	///How long until we can do a harmful emote
	var/emote_harmful_cooldown = 2 MINUTES

	//Mechanical

	var/emote_passive_track = 0
	var/emote_harmful_track = 0


/mob/living/simple_animal/friendly/retaliate/scp066/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"ball of yarn", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_EUCLID, //Obj Class
		"066", //Numerical Designation
		SCP_PLAYABLE|SCP_MEMETIC
	)

	SCP.memeticFlags = MAUDIBLE
	SCP.memetic_proc = TYPE_PROC_REF(/mob/living/simple_animal/friendly/retaliate/scp066, audibleEffect)
	SCP.memetic_sounds = list('sounds/scp/066/BeethovenLOUD.ogg')
	SCP.compInit()

	add_language(LANGUAGE_ENGLISH)

		// emotes
	add_verb(src, list(
		/mob/living/simple_animal/friendly/retaliate/scp066/proc/Eric,
		/mob/living/simple_animal/friendly/retaliate/scp066/proc/LoudNoise,
		/mob/living/simple_animal/friendly/retaliate/scp066/proc/Noise,
	))

//AI stuff

/datum/say_list/scp066
	speak = list("Eric?")
	speak_sounds = list('sounds/scp/066/Eric1.ogg' = 33, 'sounds/scp/066/Eric2.ogg' = 33, 'sounds/scp/066/Eric3.ogg' = 33)

	emote_hear = list("makes a strange sound.", "makes an odd noise.", "plays a strange tune.")
	emote_hear_sounds = list('sounds/scp/066/Notes1.ogg' = 16, 'sounds/scp/066/Notes2.ogg' = 16, 'sounds/scp/066/Notes3.ogg' = 16, 'sounds/scp/066/Notes4.ogg' = 16, 'sounds/scp/066/Notes5.ogg' = 16, 'sounds/scp/066/Notes6.ogg' = 16)

/datum/ai_holder/simple_animal/retaliate/scp066
	//Should be identical to parent simpleanimal
	var/emote_harmful_cooldown = 2 MINUTES
	var/emote_harmful_track = 0

	speak_chance = 2
	can_flee = TRUE
	violent_breakthrough = FALSE

/datum/ai_holder/simple_animal/retaliate/scp066/can_attack(atom/movable/the_target, vision_required)
	if((world.time - emote_harmful_track) > emote_harmful_cooldown)
		return ..(the_target, vision_required)
	else
		return ATTACK_ON_COOLDOWN

//Mechanics

/mob/living/simple_animal/friendly/retaliate/scp066/proc/audibleEffect(mob/living/carbon/human/target)
	target.Stun(4)
	target.adjust_confusion(10 SECONDS)
	target.ear_damage += rand(10, 20)
	target.ear_deaf = max(target.ear_deaf,15)
	shake_camera(target, 18, 5)

/mob/living/simple_animal/friendly/retaliate/scp066/proc/imitate(atom/movable/imitate_target as obj|mob)
	var/icon/I = new /icon(imitate_target.icon, imitate_target.icon_state)
	I.ColorTone("#891313")
	icon = I
	name = imitate_target.name
	desc = "It appears to be \a [imitate_target] made out of yarn..."

//Overrides

/mob/living/simple_animal/friendly/retaliate/scp066/UnarmedAttack(atom/A, proximity) //Allows 066 to imitate the look of objects.
	if(A == src)
		icon = new /icon(initial(icon), initial(icon_state))
		desc = initial(desc)
		name = SCP.name

	else if(isitem(A))
		var/obj/item/Itarget = A

		if(Itarget.w_class > ITEM_SIZE_NORMAL)
			to_chat(src, SPAN_WARNING("That is too big for you to imitate!"))
			return
		imitate(Itarget)

	else if(ismob(A) && !ishuman(A))
		var/mob/Imob = A

		if(Imob.mob_size > MOB_SMALL)
			to_chat(src, SPAN_WARNING("That is too big for you to imitate!"))
			return
		imitate(Imob)

	else
		to_chat(src, SPAN_WARNING("You cannot imitate [A]!"))

/mob/living/simple_animal/friendly/retaliate/scp066/attack_target(atom/A)
	LoudNoise()

/mob/living/simple_animal/friendly/retaliate/scp066/handle_autohiss(message, datum/language/L)
	if((world.time - emote_passive_track) > emote_passive_cooldown) //technically checked twice but this prevents the cooldown message form being spammed to 066's client.
		Eric()
	return "Eric?"

// SCP-066 emotes

/mob/living/simple_animal/friendly/retaliate/scp066/proc/Noise()
	set category = "SCP-066"
	set name = "Make a Noise"

	if ((world.time - emote_passive_track) > emote_passive_cooldown)
		var/sound = pick('sounds/scp/066/Notes1.ogg', 'sounds/scp/066/Notes2.ogg', 'sounds/scp/066/Notes3.ogg', 'sounds/scp/066/Notes4.ogg', 'sounds/scp/066/Notes5.ogg', 'sounds/scp/066/Notes6.ogg')
		playsound(src, sound, 25)
		show_sound_effect(loc, src)
		emote_passive_track = world.time
	else
		to_chat(usr, SPAN_WARNING("You are on cooldown!"))

/mob/living/simple_animal/friendly/retaliate/scp066/proc/Eric()
	set category = "SCP-066"
	set name = "Eric?"

	if ((world.time - emote_passive_track) > emote_passive_cooldown)
		var/sound = pick('sounds/scp/066/Eric1.ogg', 'sounds/scp/066/Eric2.ogg', 'sounds/scp/066/Eric3.ogg')
		playsound(src, sound, 25)
		show_sound_effect(loc, src)
		emote_passive_track = world.time
	else
		to_chat(usr, SPAN_WARNING("You are on cooldown!"))

/mob/living/simple_animal/friendly/retaliate/scp066/proc/LoudNoise()
	set category = "SCP-066"
	set name = "Deafening Noise"

	if ((world.time - emote_harmful_track) > emote_harmful_cooldown)
		playsound(src, 'sounds/scp/066/BeethovenLOUD.ogg', 40)
		show_sound_effect(loc, src)
		emote_harmful_track = world.time
		return TRUE
	else
		to_chat(usr, SPAN_WARNING("You are on cooldown!"))
		return FALSE

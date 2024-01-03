/obj/item/paper/scp012
	name = "On Mount Golgotha"
	icon = 'icons/SCP/scp-012.dmi'
	desc = "An old paper of handwritten sheet music, titled \"On Mount Golgotha\". The writing is in a conspicuous blood red."

	w_class = ITEM_SIZE_NO_CONTAINER
	show_title = FALSE

	//Config

	///How long for an effect to happen
	var/effect_cooldown = 5 SECONDS

	//Mechanical

	///Keeps track of the cooldown
	var/effect_cooldown_counter

	/* Looping sound related stuff, stolen from egor */
	var/looping_sound = 'sound/scp/012/012.ogg'
	var/looping_sound_volume = 50
	var/sound_id
	var/datum/sound_token/sound_token

/obj/item/paper/scp012/Initialize()
	START_PROCESSING(SSobj, src)

	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"On Mount Golgotha", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		EUCLID, //Obj Class
		"012", //Numerical Designation
		MEMETIC //Meta Flags, refer to code/_defines/SCP.dm
	)

	SCP.memeticFlags = MVISUAL|MAUDIBLE //Memetic flags determine required factors for a human to be affected
	SCP.memetic_proc = /obj/item/paper/scp012/proc/memetic_effect //proc to be called for the effect an affected individual should recieve
	SCP.memetic_sounds = list('sound/scp/012/012.ogg') //TODO port better sound hanedling because right now this bugs out with our shitty sound handeling because of how the loop sound function works
	SCP.compInit()

	sound_id = "[type]_[sequential_id(type)]"
	if(!sound_token)
		sound_token = GLOB.sound_player.PlayLoopingSound(src, sound_id, looping_sound, looping_sound_volume, 24, 3)

	return ..()

/obj/item/paper/scp012/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

//Mechanics

/obj/item/paper/scp012/proc/memetic_effect(mob/living/carbon/human/H)
	if(!H || H.stat == UNCONSCIOUS) //Unconscious individuals cant keep hurting themselves
		return
	if(get_dist(H, src) > 1)
		step_to(H, src)
		H.Stun(2)
	else if(((world.time - effect_cooldown_counter) > effect_cooldown) || abs((world.time - effect_cooldown_counter) - effect_cooldown) < 0.1 SECONDS) //Last part is so that this can run for all affected humans without worrying about cooldown
		H.Stun(60)
		if(prob(60) && H.getBruteLoss())
			H.visible_message(SPAN_WARNING("[H] smears [H.p_their()] blood on \"[name]\", writing musical notes..."))
		else if(prob(50))
			H.visible_message(SPAN_DANGER("[H] rips into [H.p_their()] own flesh and covers [H.p_their()] hands in blood!"))
			H.emote("scream")
			H.apply_damage(25, BRUTE, prob(50) ? BP_L_ARM : BP_R_ARM)
			H.drip(50)
		else if(prob(30))
			if(prob(50))
				H.visible_message(SPAN_NOTICE("[H] looks at the \"[name]\" and sighs dejectedly."))
				playsound(H, "sounds/voice/emotes/sigh_[gender2text(H.gender)].ogg", 100)
			else
				H.visible_message(SPAN_NOTICE("[H] looks at the \"[name]\" and cries."))
				playsound(H, "sounds/voice/emotes/[gender2text(H.gender)]_cry[pick(list("1","2"))].ogg", 100)
		effect_cooldown_counter = world.time

// Overrides

/obj/item/paper/scp012/Process()
	SCP.meme_comp.check_viewers()

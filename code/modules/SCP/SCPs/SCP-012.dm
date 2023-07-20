/obj/item/paper/scp012
	name = "SCP-012"
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

/obj/item/paper/scp012/Initialize()
	START_PROCESSING(SSobj, src)

	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"Weird Composition", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		EUCLID, //Obj Class
		"012", //Numerical Designation
		MEMETIC //Meta Flags, refer to code/_defines/SCP.dm
	)

	SCP.memeticFlags = MVISUAL //Memetic flags determine required factors for a human to be affected
	SCP.memetic_proc = /obj/item/paper/scp012/proc/memetic_effect //proc to be called for the effect an affected individual should recieve
	SCP.compInit()
	return ..()

/obj/item/paper/scp012/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/paper/scp012/Process()
	SCP.meme_comp.check_viewers()
	SCP.meme_comp.activate_memetic_effects()

/obj/item/paper/scp012/proc/memetic_effect(mob/living/carbon/human/H)
	if(!H || H.stat == UNCONSCIOUS) //Unconscious individuals cant keep hurting themselves
		return
	if(get_dist(H, src) > 1)
		step_to(H, src)
		H.Stun(60)
	else if(((world.time - effect_cooldown_counter) > effect_cooldown) || abs((world.time - effect_cooldown_counter) - effect_cooldown) < 0.1 SECONDS) //Last part is so that this can run for all affected humans without worrying about cooldown
		H.Stun(800)
		if(prob(60) && H.getBruteLoss())
			H.visible_message(SPAN_WARNING("[H] smears [H.p_their()] blood on the \"[name]\", writing musical notes..."))
		else if(prob(50))
			H.visible_message(SPAN_DANGER("[H] rips into [H.p_their()] own flesh and covers [H.p_their()] hands in blood!"))
			H.emote("scream")
			H.adjustBruteLoss(25)
			H.drip(50)
		else if(prob(30))
			if(prob(50))
				H.visible_message(SPAN_NOTICE("[H] looks at the \"[name]\" and sighs dejectedly."))
				playsound(H, "sounds/voice/emotes/sigh_[gender2text(H.gender)].ogg", 100)
			else
				H.visible_message(SPAN_NOTICE("[H] looks at the \"[name]\" and cries."))
				playsound(H, "sounds/voice/emotes/[gender2text(H.gender)]_cry[pick(1,2)].ogg", 100)
		effect_cooldown_counter = world.time

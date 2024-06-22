/obj/item/clothing/mask/smokable/cigarette/bluelady
	name = "'Blue Lady' cigarette"
	brand = "\improper Blue Lady"
	desc = "The words 'Blue Lady' are written on this deftly-rolled cigarette in blue ink."

	filling = list(/datum/reagent/medicine/fluff/tobacco = 1)
	hidden_from_codex = TRUE

	//Mechanical

	///Appearance Handler
	var/decl/appearance_handler/bl_handle = new /decl/appearance_handler()

	///Humans who have smoked 013, helps us prevent it from extinguishing if someone is still undergoing the effects
	var/list/weakref/affected

/obj/item/clothing/mask/smokable/cigarette/bluelady/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"'Blue Lady' cigarette", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_SAFE, //Obj Class
		"013", //Numerical Designation
	)

	LAZYINITLIST(affected)

//Mechanics

/obj/item/clothing/mask/smokable/cigarette/bluelady/proc/effect(mob/living/carbon/human/H)
	if(lit)
		if(H.humanStageHandler.createStage("BlueLady"))
			update_013_status(H)
			affected += weakref(H)

/obj/item/clothing/mask/smokable/cigarette/bluelady/proc/update_013_status(mob/living/carbon/human/H)
	H.humanStageHandler.adjustStage("BlueLady", 1)
	switch(H.humanStageHandler.getStage("BlueLady"))
		if(1)
			to_chat(H, SPAN_NOTICE("You can't remember what you did this morning, or the day before..."))
			addtimer(CALLBACK(src, PROC_REF(update_013_status), H), 2 MINUTES)
		if(2)
			to_chat(H, SPAN_NOTICE("You remember now, you were looking in the mirror as you painted your lips blue."))
			addtimer(CALLBACK(src, PROC_REF(update_013_status), H), 1 MINUTES)
			bl_handle.AddAltAppearance(H, get_bluelady_image(H), list(H))
		if(3)
			to_chat(H, SPAN_NOTICE("Briefly, she fades from your mind. You miss her already."))
			addtimer(CALLBACK(src, PROC_REF(update_013_status), H), 2 MINUTE)
			bl_handle.RemoveAltAppearance(H)
		if(4)
			to_chat(H, SPAN_NOTICE("You put the blue dress on, that's all you can recall. How did you get here?"))
			addtimer(CALLBACK(src, PROC_REF(update_013_status), H), 3 MINUTE)
			bl_handle.AddAltAppearance(H, get_bluelady_image(H), list(H))
		if(5)
			to_chat(H, SPAN_NOTICE("Who were you? You try to remember in more detail..."))
			addtimer(CALLBACK(src, PROC_REF(update_013_status), H), 1 MINUTE)
		if(6)
			to_chat(H, SPAN_NOTICE(SPAN_ITALIC("I can't live without her...")))
			addtimer(CALLBACK(src, PROC_REF(update_013_status), H), 55 SECONDS)
		if(7)
			addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, bluelady_message)), 10 SECONDS)
			affected -= weakref(H)
			if(!LAZYLEN(affected))
				extinguish()

/obj/item/clothing/mask/smokable/cigarette/bluelady/proc/get_bluelady_image(mob/living/carbon/human/H)
	var/image/I = image('icons/mob/human.dmi', H, "body_f_s")
	I.override = 1
	I.add_overlay(image('icons/mob/human_face.dmi', icon_state = "hair_emo2_s"))
	I.add_overlay(image('icons/mob/onmob/uniform.dmi', icon_state = "lady_in_blue_s"))
	I.add_overlay(image('icons/mob/onmob/mask.dmi', icon_state = "ccigon"))
	I.add_overlay(image('icons/mob/onmob/feet.dmi', icon_state = "heels"))

	return I

//Overrides

/obj/item/clothing/mask/smokable/cigarette/bluelady/light()
	. = ..()
	if(!ishuman(loc))
		return
	var/mob/living/carbon/human/H = loc
	if(H.get_inventory_slot(src) != slot_wear_mask)
		return
	effect(H)

/obj/item/clothing/mask/smokable/cigarette/bluelady/equipped(mob/user, slot)
	. = ..()
	if(slot != slot_wear_mask || !ishuman(user))
		return
	effect(user)

/obj/item/clothing/mask/smokable/cigarette/bluelady/smoke(amount)
	. = ..()
	smoketime += amount //Infite smoke time until 013 can complete its effects

//Human mechanics

/mob/living/carbon/human/proc/bluelady_message() //This is needed since once the cigarette goes out it is no longer an instance of 013 (and callbacks dont work)
	if(!humanStageHandler.getStage("BlueLady")) //shouldent happen, but if admins do some fuckery with stages mid game then this will account for it
		return
	if(prob(15))
		var/bl_message = pick("I miss her...", "Where did she go...", "You spot a glimpse of her in a nearby reflection...", "I know her I just can't remember...", "I love her... Where did she go?")
		to_chat(src, SPAN_NOTICE(SPAN_ITALIC(bl_message)))
	addtimer(CALLBACK(src, PROC_REF(bluelady_message)), 45 SECONDS)

//Cigarrete Pack

/obj/item/storage/fancy/cigarettes/bluelady
	name = "Pack of 'Blue Lady' cigarettes"
	icon_state = "BLpacket"
	desc = "A packet of six Blue Lady cigarettes. The SCP logo is stamped on the paper."

	startswith = list(/obj/item/clothing/mask/smokable/cigarette/bluelady = 6)


/decl/appearance_handler/bluelady
	var/static/list/appearances

/decl/appearance_handler/bluelady/proc/item_equipped(obj/item/item, mob/user, slot)
	if(!(slot == slot_wear_mask))
		return
	if(!ishuman(user))
		return
	if(!(istype(item, /obj/item/clothing/mask/smokable/cigarette/bluelady)))
		return
	if(user in appearance_sources)
		return

	var/mob/living/carbon/human/H = user
	if(!(istype(H.wear_mask, /obj/item/clothing/mask/smokable/cigarette/bluelady)))
		return


	var/image/I = get_image_from_bluelady(H)

	H.is_blue_lady = 1
	H.pre_scp013_name = H.name
	H.pre_scp013_real_name = H.real_name
	H.pre_scp013_species = H.species.name
	H.pre_scp013_gender = H.gender
	H.set_species("SCP-013-1")
	to_chat(H, SPAN_NOTICE("That cigarette was her favorite flavor."))
	addtimer(CALLBACK(to_chat(H, SPAN_NOTICE("You can't remember what she did this morning, or the day before..."))), 500 SECONDS)
	addtimer(CALLBACK(to_chat(H, SPAN_NOTICE("You remember now, looking in the mirror as you painted your lips blue."))), 1000 SECONDS)
	addtimer(CALLBACK(AddAltAppearance(H, I, GLOB.ghost_mob_list + H)), 1000 SECONDS)
	addtimer(CALLBACK(to_chat(H, SPAN_NOTICE("Briefly, she fades from your mind. You miss her already."))), 1300 SECONDS)
	addtimer(CALLBACK(RemoveAltAppearance(user)), 1300 SECONDS)
	addtimer(CALLBACK(to_chat(H, SPAN_NOTICE("You put the blue dress on, that's all you can recall. How did you get here?"))), 1500 SECONDS)
	addtimer(CALLBACK(AddAltAppearance(H, I, GLOB.ghost_mob_list + H)), 1500 SECONDS)
	addtimer(CALLBACK(H.real_name = "The Blue Lady"), 1500 SECONDS)
	addtimer(CALLBACK(to_chat(H, SPAN_NOTICE("Who were you? You try to remember in more detail..."))), 1500 SECONDS)
	addtimer(CALLBACK(to_chat(H, SPAN_NOTICE("You need to find out."))), 2100 SECONDS)

	if (H.gender == MALE)
		addtimer(CALLBACK(to_chat(H, SPAN_WARNING("Your body looks the way it should, but something still feels very wrong..."))), 3000 SECONDS)
		addtimer(CALLBACK(H.gender = FEMALE), 3000 SECONDS)

/decl/appearance_handler/bluelady/proc/item_removed(obj/item/item, mob/user)
	// // Blue Lady is forever.
	// if(istype(item, /obj/item/clothing/mask/smokable/cigarette/bluelady))
	// 	RemoveAltAppearance(user)

/decl/appearance_handler/bluelady/proc/get_image_from_bluelady(mob/living/carbon/human/H)
	var/image/I = image('icons/mob/human.dmi', icon_state = "body_f_s", loc = H)
	I.override = 1
	I.add_overlay(image(icon = 'icons/mob/human_face.dmi', icon_state = "hair_emo2_s"))
	I.add_overlay(image(icon = 'icons/mob/onmob/uniform.dmi', icon_state = "lady_in_blue_s"))
	I.add_overlay(image(icon = 'icons/mob/onmob/mask.dmi', icon_state = "ccigon"))
	I.add_overlay(image(icon = 'icons/mob/onmob/feet.dmi', icon_state = "heels"))
	return I

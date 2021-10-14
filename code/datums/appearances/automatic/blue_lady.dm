/decl/appearance_handler/bluelady
	var/static/list/appearances

/decl/appearance_handler/bluelady/proc/item_equipped(var/obj/item/item, var/mob/user, var/slot)
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
	to_chat(H, "<span class='notice'>That cigarette was her favorite flavor.</span>")
	spawn(500)
		to_chat(H, "<span class='notice'>You can't remember what she did this morning, or the day before...</span>")
	spawn(1000)
		to_chat(H, "<span class='notice'>You remember now, looking in the mirror as you painted your lips blue.</span>")
		AddAltAppearance(H, I, GLOB.ghost_mob_list + H)
	spawn(1300)
		to_chat(H, "<span class='notice'>Briefly, she fades from your mind. You miss her already.</span>")
		RemoveAltAppearance(user)
	spawn(1500)
		to_chat(H, "<span class='notice'>You put the blue dress on, that's all you can recall. How did you get here?</span>")
		AddAltAppearance(H, I, GLOB.ghost_mob_list + H) //you now look like the blue lady to yourself, also ghosts
		H.real_name = "The Blue Lady"
	spawn(2000)
		to_chat(H, "<span class='notice'>Who were you? You try to remember in more detail...</span>")
	spawn(2100)
		to_chat(H, "<span class='notice'>You need to find out.</span>")

	if (H.gender == MALE)
		spawn(3000)
			to_chat(H, "<span class='warning'>Your body looks the way it should, but something still feels very wrong...</span>")
			H.gender = FEMALE

/decl/appearance_handler/bluelady/proc/item_removed(var/obj/item/item, var/mob/user)
	// // Blue Lady is forever.
	// if(istype(item, /obj/item/clothing/mask/smokable/cigarette/bluelady))
	// 	RemoveAltAppearance(user)

/decl/appearance_handler/bluelady/proc/get_image_from_bluelady(var/mob/living/carbon/human/H)
	var/image/I = image('icons/mob/human.dmi', icon_state = "body_f_s", loc = H)
	I.override = 1
	I.overlays += image(icon = 'icons/mob/human_face.dmi', icon_state = "hair_emo2_s")
	I.overlays += image(icon = 'icons/mob/onmob/uniform.dmi', icon_state = "lady_in_blue_s")
	I.overlays += image(icon = 'icons/mob/onmob/mask.dmi', icon_state = "ccigon")
	I.overlays += image(icon = 'icons/mob/onmob/feet.dmi', icon_state = "heels")
	return I
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



	H.is_blue_lady = 1
	H.pre_scp013_name = H.name
	H.pre_scp013_real_name = H.real_name
	H.pre_scp013_species = H.species.name
	H.pre_scp013_gender = H.gender

	to_chat(H, "<span class='notice'>That cigarette was her favorite flavor.</span>")

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

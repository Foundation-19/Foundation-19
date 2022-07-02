/*
 * Site13 Supply
 */

/obj/structure/closet/secure_closet/logistics/officer
	name = "logistics officer's footlocker"
	req_access = list(access_mtflvl3)
	icon_state = "lolocked"
	icon_closed = "loclosed"
	icon_locked = "lolocked"
	icon_opened = "loopen"
	icon_off = "looff"

/obj/structure/closet/secure_closet/logistics/officer/WillContain()
	return list(
		/obj/item/clothing/gloves/thick,
		/obj/item/clothing/glasses/sunglasses,
		/obj/item/clothing/suit/storage/hazardvest,
		/obj/item/clothing/accessory/storage/brown_vest,
		/obj/item/weapon/storage/belt/utility/full,
		/obj/item/weapon/hand_labeler,
		/obj/item/weapon/clipboard,
		/obj/item/weapon/folder/yellow,
		/obj/item/weapon/packageWrap,
		/obj/item/device/flash,
		/obj/item/device/megaphone,
		/obj/item/device/binoculars,
		new /datum/atom_creator/weighted(list(/obj/item/weapon/storage/backpack = 75, /obj/item/weapon/storage/backpack/satchel/grey = 25)),
		new /datum/atom_creator/weighted(list(/obj/item/weapon/storage/backpack/messenger = 75, /obj/item/weapon/storage/backpack/dufflebag = 25)),
	)

/obj/structure/closet/secure_closet/logistics/specialist
	name = "logistics specialist's footlocker"
	req_access = list(access_mtflvl2)
	icon_state = "lslocked"
	icon_closed = "lsclosed"
	icon_locked = "lslocked"
	icon_opened = "lsopen"
	icon_off = "lsoff"

/obj/structure/closet/secure_closet/logistics/specialist/WillContain()
	return list(
		/obj/item/clothing/gloves/thick,
		/obj/item/clothing/suit/storage/hazardvest,
		/obj/item/clothing/accessory/storage/webbing_large,
		/obj/item/weapon/storage/belt/utility/atmostech,
		/obj/item/weapon/hand_labeler,
		/obj/item/weapon/clipboard,
		/obj/item/weapon/folder/yellow,
		/obj/item/weapon/packageWrap,
		/obj/item/weapon/marshalling_wand,
		/obj/item/weapon/marshalling_wand,
		new /datum/atom_creator/weighted(list(/obj/item/weapon/storage/backpack = 75, /obj/item/weapon/storage/backpack/satchel/grey = 25)),
		new /datum/atom_creator/weighted(list(/obj/item/weapon/storage/backpack/messenger = 75, /obj/item/weapon/storage/backpack/dufflebag = 25)),
	)

/*
 * Torch Supply
 */

/obj/structure/closet/secure_closet/decktech
	name = "deck technician's locker"
	req_access = list(access_cargo)
	icon_state = "securecargo1"

/obj/structure/closet/secure_closet/decktech/WillContain()
	return list(
		/obj/item/device/radio/headset/headset_cargo,
		/obj/item/clothing/gloves/thick,

		/obj/item/clothing/suit/storage/hazardvest,
		/obj/item/clothing/accessory/storage/webbing_large,
		/obj/item/storage/belt/utility/atmostech,
		/obj/item/hand_labeler,
		/obj/item/material/clipboard,
		/obj/item/folder/yellow,

		/obj/item/marshalling_wand,
		/obj/item/marshalling_wand,
		new /datum/atom_creator/weighted(list(/obj/item/storage/backpack = 75, /obj/item/storage/backpack/satchel/grey = 25)),
		new /datum/atom_creator/weighted(list(/obj/item/storage/backpack/messenger = 75, /obj/item/storage/backpack/dufflebag = 25))
	)

/obj/structure/closet/secure_closet/deckofficer
	name = "deck officer's locker"
	req_access = list(access_qm)
	icon_state = "secureqm1"

/obj/structure/closet/secure_closet/deckofficer/WillContain()
	return list(
		/obj/item/device/radio/headset/headset_cargo,
		/obj/item/clothing/gloves/thick,

		/obj/item/clothing/glasses/meson,
		/obj/item/clothing/glasses/sunglasses,
		/obj/item/clothing/suit/storage/hazardvest,
		/obj/item/clothing/accessory/storage/brown_vest,
		/obj/item/storage/belt/utility/full,
		/obj/item/hand_labeler,
		/obj/item/material/clipboard,
		/obj/item/folder/yellow,

		/obj/item/device/flash,
		/obj/item/device/megaphone,
		/obj/item/device/holowarrant,
		/obj/item/clothing/suit/armor/pcarrier/light/sol,
		/obj/item/device/binoculars,
		new /datum/atom_creator/weighted(list(/obj/item/storage/backpack = 75, /obj/item/storage/backpack/satchel/grey = 25)),
		new /datum/atom_creator/weighted(list(/obj/item/storage/backpack/messenger = 75, /obj/item/storage/backpack/dufflebag = 25))
	)

/obj/structure/closet/secure_closet/logistics/officer
	name = "logistics officer's footlocker"
	req_access = list(access_adminlvl2)
	icon_state = "lolocked"

/obj/structure/closet/secure_closet/logistics/officer/WillContain()
	return list(
		/obj/item/clothing/under/scp/utility/logistics/officer,
		/obj/item/device/radio/headset/headset_deckofficer,
		/obj/item/clothing/gloves/thick,
		/obj/item/clothing/glasses/meson,
		/obj/item/clothing/glasses/sunglasses,
		/obj/item/clothing/suit/storage/hazardvest,
		/obj/item/clothing/accessory/storage/brown_vest,
		/obj/item/storage/belt/utility/full,
		/obj/item/hand_labeler,
		/obj/item/material/clipboard,
		/obj/item/folder/yellow,

		/obj/item/device/flash,
		/obj/item/device/megaphone,
		/obj/item/device/binoculars,
		new /datum/atom_creator/weighted(list(/obj/item/storage/backpack = 75, /obj/item/storage/backpack/satchel/grey = 25)),
		new /datum/atom_creator/weighted(list(/obj/item/storage/backpack/messenger = 75, /obj/item/storage/backpack/dufflebag = 25))
	)

/obj/structure/closet/secure_closet/logistics/specialist
	name = "logistics specialist's footlocker"
	req_access = list(access_adminlvl1)
	icon_state = "lslocked"
/*
/obj/structure/closet/secure_closet/logistics/specialist/WillContain()
	return list(
		/obj/item/device/radio/headset/headset_cargo,
		/obj/item/clothing/gloves/thick,
		/obj/item/cartridge/quartermaster,
		/obj/item/clothing/suit/storage/hazardvest,
		/obj/item/clothing/accessory/storage/webbing_large,
		/obj/item/storage/belt/utility/atmostech,
		/obj/item/hand_labeler,
		/obj/item/material/clipboard,
		/obj/item/folder/yellow,
		/obj/item/packageWrap,
		/obj/item/marshalling_wand,
		/obj/item/marshalling_wand,
		new /datum/atom_creator/weighted(list(/obj/item/storage/backpack = 75, /obj/item/storage/backpack/satchel/grey = 25)),
		new /datum/atom_creator/weighted(list(/obj/item/storage/backpack/messenger = 75, /obj/item/storage/backpack/dufflebag = 25))
	)
*/

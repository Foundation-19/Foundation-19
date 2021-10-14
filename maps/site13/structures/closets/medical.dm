/*
 * Site13 Medical
 */

/obj/structure/closet/secure_closet/CMO/site13
	name = "chief medical officer's locker"
	req_access = list(access_mtflvl4)
	icon_state = "cmosecure1"
	icon_closed = "cmosecure"
	icon_locked = "cmosecure1"
	icon_opened = "cmosecureopen"
	icon_off = "cmosecureoff"

/obj/structure/closet/secure_closet/CMO/site13/WillContain()
	return list(
		/obj/item/clothing/under/rank/medical/scrubs/purple,
		/obj/item/clothing/suit/bio_suit/cmo,
		/obj/item/clothing/head/bio_hood/cmo,
		/obj/item/clothing/shoes/white,
		/obj/item/clothing/suit/storage/toggle/labcoat/cmo,
		/obj/item/clothing/suit/storage/toggle/labcoat/cmoalt,
		/obj/item/device/megaphone,
		/obj/item/weapon/reagent_containers/hypospray/vial,
		/obj/item/weapon/storage/fancy/vials,
		/obj/item/device/healthanalyzer,
		/obj/item/clothing/accessory/stethoscope,
		/obj/item/device/flashlight/pen,
		/obj/item/weapon/storage/firstaid/adv,
		/obj/item/weapon/storage/box/armband/med,
		new /datum/atom_creator/weighted(list(/obj/item/weapon/storage/backpack/medic, /obj/item/weapon/storage/backpack/satchel_med)),
		new /datum/atom_creator/weighted(list(/obj/item/weapon/storage/backpack/dufflebag/med, /obj/item/weapon/storage/backpack/messenger/med)),
	)

/obj/structure/closet/wardrobe/medic/site13
	name = "medical wardrobe"
	icon_state = "white"
	icon_closed = "white"

/obj/structure/closet/wardrobe/medic/site13/WillContain()
	return list(
		/obj/item/clothing/under/sterile = 2,
		RANDOM_SCRUBS = 4,
		/obj/item/clothing/suit/surgicalapron = 2,
		/obj/item/clothing/shoes/white = 2,
		/obj/item/clothing/suit/storage/toggle/labcoat = 2,
		/obj/item/clothing/mask/surgical = 2,
		/obj/item/clothing/under/rank/psych/turtleneck,
		/obj/item/clothing/under/rank/psych,
	)

/obj/structure/closet/secure_closet/virology/site13
	name = "virologist's locker"
	icon_state = "secureviro1"
	icon_closed = "secureviro"
	icon_locked = "secureviro1"
	icon_opened = "secureviroopen"
	icon_off = "securevirooff"
	req_access = list(access_mtflvl2)

/obj/structure/closet/secure_closet/virology/site13/WillContain()
	return list(
		/obj/item/weapon/storage/box/autoinjectors,
		/obj/item/weapon/storage/box/syringes,
		/obj/item/weapon/reagent_containers/dropper = 2,
		/obj/item/weapon/reagent_containers/glass/beaker = 2,
		/obj/item/weapon/reagent_containers/glass/bottle/inaprovaline,
		/obj/item/weapon/storage/pill_bottle/spaceacillin,
		/obj/item/weapon/reagent_containers/syringe/antiviral,
		/obj/item/weapon/reagent_containers/glass/bottle/antitoxin,
		/obj/item/weapon/storage/box/masks,
		/obj/item/weapon/storage/box/gloves,
		/obj/item/clothing/under/rank/virologist,
		/obj/item/clothing/shoes/white,
		/obj/item/clothing/suit/storage/toggle/labcoat/virologist,
		/obj/item/clothing/mask/surgical,
		/obj/item/device/healthanalyzer,
	)

/obj/structure/closet/secure_closet/medical/site13
	name = "medical locker"
	req_access = list(access_mtflvl2)
	icon_state = "securesenmed1"
	icon_closed = "securesenmed"
	icon_locked = "securesenmed1"
	icon_opened = "securesenmedopen"
	icon_off = "securesenmedoff"

/obj/structure/closet/secure_closet/medical/site13/WillContain()
	return list(
		/obj/item/clothing/under/rank/medical/scrubs/blue,
		/obj/item/clothing/suit/storage/toggle/labcoat,
		/obj/item/clothing/suit/surgicalapron,
		/obj/item/clothing/shoes/white,
		/obj/item/taperoll/medical,
		/obj/item/weapon/storage/belt/medical,
		/obj/item/clothing/mask/surgical,
		/obj/item/device/healthanalyzer,
		/obj/item/clothing/accessory/stethoscope,
		/obj/item/device/flashlight/pen,
		/obj/item/device/megaphone,
		/obj/item/weapon/storage/firstaid/adv,
		new /datum/atom_creator/weighted(list(/obj/item/weapon/storage/backpack/medic, /obj/item/weapon/storage/backpack/satchel_med)),
		new /datum/atom_creator/weighted(list(/obj/item/weapon/storage/backpack/dufflebag/med, /obj/item/weapon/storage/backpack/messenger/med)),
	)

/obj/structure/closet/secure_closet/chemical/site13
	name = "chemical closet"
	desc = "Store dangerous chemicals in here."
	icon_state = "medical1"
	icon_closed = "medical"
	icon_locked = "medical1"
	icon_opened = "medicalopen"
	icon_off = "medicaloff"
	req_access = list(access_mtflvl2)

/obj/structure/closet/secure_closet/chemical/site13/WillContain()
	return list(
		/obj/item/weapon/storage/box/pillbottles = 2,
		/obj/item/weapon/reagent_containers/glass/beaker/cryoxadone,
		/obj/random/medical = 12
	)

/obj/structure/closet/secure_closet/psychiatry/site13
	name = "Psychiatrist's locker"
	desc = "Everything you need to keep the lunatics at bay."
	icon_state = "securemed1"
	icon_closed = "securemed"
	icon_locked = "securemed1"
	icon_opened = "securemedopen"
	icon_off = "securemedoff"
	req_access = list(access_mtflvl2)

/obj/structure/closet/secure_closet/psychiatry/site13/WillContain()
	return list(
		/obj/item/clothing/suit/straight_jacket,
		/obj/item/weapon/reagent_containers/glass/bottle/stoxin,
		/obj/item/weapon/reagent_containers/syringe,
		/obj/item/weapon/storage/pill_bottle/citalopram,
		/obj/item/weapon/storage/pill_bottle/methylphenidate,
		/obj/item/weapon/storage/pill_bottle/paroxetine,
		/obj/item/clothing/under/rank/psych/turtleneck,
		/obj/item/clothing/under/rank/psych/turtleneck/sweater,
	)

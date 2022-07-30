#define RANDOM_SCRUBS new/datum/atom_creator/weighted(list( \
				list(/obj/item/clothing/under/rank/medical/scrubs, /obj/item/clothing/head/surgery), \
				list(/obj/item/clothing/under/rank/medical/scrubs/blue, /obj/item/clothing/head/surgery/blue), \
				list(/obj/item/clothing/under/rank/medical/scrubs/green, /obj/item/clothing/head/surgery/green), \
				list(/obj/item/clothing/under/rank/medical/scrubs/purple, /obj/item/clothing/head/surgery/purple), \
				list(/obj/item/clothing/under/rank/medical/scrubs/black, /obj/item/clothing/head/surgery/black), \
				list(/obj/item/clothing/under/rank/medical/scrubs/lilac, /obj/item/clothing/head/surgery/lilac), \
				list(/obj/item/clothing/under/rank/medical/scrubs/teal, /obj/item/clothing/head/surgery/teal), \
				list(/obj/item/clothing/under/rank/medical/scrubs/heliodor, /obj/item/clothing/head/surgery/heliodor), \
				list(/obj/item/clothing/under/rank/medical/scrubs/navyblue, /obj/item/clothing/head/surgery/navyblue)\
			) \
		)

/obj/structure/closet/secure_closet/medical1
	name = "medical equipment closet"
	desc = "Filled with medical junk."
	icon_state = "medical1"
	icon_closed = "medical"
	icon_locked = "medical1"
	icon_opened = "medicalopen"
	icon_off = "medicaloff"
	closet_appearance = /decl/closet_appearance/secure_closet/medical
	req_access = list(access_medicallvl2)

/obj/structure/closet/secure_closet/medical1/WillContain()
	return list(
		/obj/item/storage/box/autoinjectors,
		/obj/item/storage/box/syringes,
		/obj/item/reagent_containers/dropper = 2,
		/obj/item/reagent_containers/glass/beaker = 2,
		/obj/item/reagent_containers/glass/bottle/inaprovaline = 2,
		/obj/item/reagent_containers/glass/bottle/antitoxin = 2,
		/obj/random/firstaid,
		/obj/item/storage/box/masks,
		/obj/item/storage/box/gloves
	)

/obj/structure/closet/secure_closet/medical2
	name = "anesthetics closet"
	desc = "Used to knock people out."
	icon_state = "medical1"
	icon_closed = "medical"
	icon_locked = "medical1"
	icon_opened = "medicalopen"
	icon_off = "medicaloff"
	req_access = list(access_medicallvl3)

/obj/structure/closet/secure_closet/medical2/WillContain()
	return list(
		/obj/item/tank/anesthetic = 3,
		/obj/item/clothing/mask/breath/medical = 3
	)

/obj/structure/closet/secure_closet/medical3
	name = "medical doctor's locker"
	icon_state = "securemed1"
	icon_closed = "securemed"
	icon_locked = "securemed1"
	icon_opened = "securemedopen"
	icon_off = "securemedoff"
	req_access = list(access_medicallvl2)
	closet_appearance = /decl/closet_appearance/secure_closet/medical/alt

/obj/structure/closet/secure_closet/medical3/WillContain()
	return list(
		new/datum/atom_creator/weighted(list(/obj/item/storage/backpack/medic, /obj/item/storage/backpack/satchel/med)),
		new/datum/atom_creator/simple(/obj/item/storage/backpack/dufflebag/med, 50),
		/obj/item/clothing/under/rank/nursesuit,
		/obj/item/clothing/head/nursehat,
		/obj/item/clothing/under/rank/medical,
		/obj/item/clothing/under/rank/nurse,
		/obj/item/clothing/under/rank/orderly,
		/obj/item/clothing/suit/storage/toggle/labcoat,
		/obj/item/clothing/suit/storage/toggle/fr_jacket,
		/obj/item/clothing/shoes/white,
		/obj/item/device/radio/headset/headset_med,
		/obj/item/taperoll/medical,
		/obj/item/storage/belt/medical/emt,
		RANDOM_SCRUBS,
		RANDOM_SCRUBS
	)

/obj/structure/closet/secure_closet/paramedic
	name = "paramedic locker"
	desc = "Supplies for a first responder."
	icon_state = "medical1"
	icon_closed = "medical"
	icon_locked = "medical1"
	icon_opened = "medicalopen"
	icon_off = "medicaloff"
	req_access = list(access_medicallvl2)
	closet_appearance = /decl/closet_appearance/secure_closet/medical

/obj/structure/closet/secure_closet/paramedic/WillContain()
	return list(
	    /obj/item/storage/box/autoinjectors,
	    /obj/item/storage/box/syringes,
	    /obj/item/reagent_containers/glass/bottle/inaprovaline,
	    /obj/item/reagent_containers/glass/bottle/antitoxin,
	    /obj/item/storage/belt/medical/emt,
	    /obj/item/clothing/mask/gas,
	    /obj/item/clothing/suit/storage/toggle/fr_jacket,
	    /obj/item/clothing/suit/storage/toggle/labcoat,
	    /obj/item/device/radio/headset/headset_med,
	    /obj/item/device/flashlight,
	    /obj/item/tank/emergency/oxygen/engi,
	    /obj/item/clothing/glasses/hud/health,
	    /obj/item/device/scanner/health,
	    /obj/item/device/radio/off,
	    /obj/random/medical,
	    /obj/item/crowbar,
	    /obj/item/extinguisher/mini,
	    /obj/item/storage/box/freezer,
	    /obj/item/clothing/accessory/storage/white_vest,
	)

/obj/structure/closet/secure_closet/CMO
	name = "chief medical officer's locker"
	icon_state = "cmosecure1"
	icon_closed = "cmosecure"
	icon_locked = "cmosecure1"
	icon_opened = "cmosecureopen"
	icon_off = "cmosecureoff"
	req_access = list(access_medicallvl5)
	closet_appearance = /decl/closet_appearance/secure_closet/cmo

/obj/structure/closet/secure_closet/CMO/WillContain()
	return list(
		new/datum/atom_creator/weighted(list(/obj/item/storage/backpack/medic, /obj/item/storage/backpack/satchel/med)),
		new/datum/atom_creator/simple(/obj/item/storage/backpack/dufflebag/med, 50),
		/obj/item/clothing/suit/bio_suit/cmo,
		/obj/item/clothing/head/bio_hood/cmo,
		/obj/item/clothing/shoes/white,
		/obj/item/clothing/under/rank/chief_medical_officer,
		/obj/item/clothing/suit/storage/toggle/labcoat/cmo,
		/obj/item/clothing/suit/storage/toggle/labcoat/cmoalt,
		/obj/item/clothing/gloves/latex,
		/obj/item/clothing/shoes/brown,
		/obj/item/device/radio/headset/heads/cmo,
		/obj/item/device/flash,
		/obj/item/reagent_containers/hypospray/vial,
		RANDOM_SCRUBS
	)

/obj/structure/closet/secure_closet/chemical
	name = "chemical closet"
	desc = "Store dangerous chemicals in here."
	icon_state = "medical1"
	icon_closed = "medical"
	icon_locked = "medical1"
	icon_opened = "medicalopen"
	icon_off = "medicaloff"
	closet_appearance = /decl/closet_appearance/secure_closet/medical
	req_access = list(access_medicallvl2)

/obj/structure/closet/secure_closet/chemical/WillContain()
	return list(
		/obj/item/storage/box/pillbottles = 2,
		/obj/item/reagent_containers/glass/beaker/cryoxadone,
		/obj/random/medical = 12
	)

/obj/structure/closet/secure_closet/medical_wall
	name = "first aid closet"
	desc = "It's a secure wall-mounted storage unit for first aid supplies."
	icon_state = "medical_wall_locked"
	icon_closed = "medical_wall_unlocked"
	icon_locked = "medical_wall_locked"
	icon_opened = "medical_wall_open"
	icon_broken = "medical_wall_sparks"
	icon_off = "medical_wall_off"
	closet_appearance = /decl/closet_appearance/wall/medical
	anchored = TRUE
	density = FALSE
	wall_mounted = TRUE
	storage_types = CLOSET_STORAGE_ITEMS
	req_access = list(access_medicallvl2)

/obj/structure/closet/secure_closet/counselor
	name = "counselor's locker"
	closet_appearance = /decl/closet_appearance/secure_closet/medical
	req_access = list(access_medicallvl1)
	icon_state = "chaplainsecure1"
	icon_closed = "chaplainsecure"
	icon_locked = "chaplainsecure1"
	icon_opened = "chaplainsecureopen"
	icon_off = "chaplainsecureoff"

/obj/structure/closet/secure_closet/counselor/WillContain()
	return list(
		/obj/item/clothing/under/rank/psych,
		/obj/item/clothing/under/rank/psych/turtleneck,
		/obj/item/clothing/suit/storage/toggle/labcoat,
		/obj/item/clothing/shoes/white,
		/obj/item/storage/pill_bottle/citalopram,
		/obj/item/storage/pill_bottle/methylphenidate,
		/obj/item/material/clipboard,
		/obj/item/folder/white,
		/obj/item/device/taperecorder,
		/obj/item/device/tape/random = 3,
		/obj/item/device/camera,
		/obj/item/toy/therapy_blue,
		/obj/item/storage/belt/general
	)

/obj/structure/closet/secure_closet/virology
	name = "virologist's locker"
	icon_state = "secureviro1"
	icon_closed = "secureviro"
	icon_locked = "secureviro1"
	icon_opened = "secureviroopen"
	icon_off = "securevirooff"
	closet_appearance = /decl/closet_appearance/secure_closet/medical/virology

	req_access = list(access_medicallvl4)

/obj/structure/closet/secure_closet/virology/WillContain()
	return list(
		/obj/item/storage/box/autoinjectors,
		/obj/item/storage/box/syringes,
		/obj/item/reagent_containers/dropper = 2,
		/obj/item/reagent_containers/glass/beaker = 2,
		/obj/item/reagent_containers/glass/bottle/inaprovaline,
		/obj/item/storage/pill_bottle/spaceacillin,
		/obj/item/reagent_containers/syringe/antiviral,
		/obj/item/reagent_containers/glass/bottle/antitoxin,
		/obj/item/storage/box/masks,
		/obj/item/storage/box/gloves,
		/obj/item/clothing/under/rank/virologist,
		/obj/item/clothing/shoes/white,
		/obj/item/clothing/suit/storage/toggle/labcoat/virologist,
		/obj/item/clothing/mask/surgical,
		/obj/item/device/scanner/health,
		/obj/item/clothing/glasses/hud/health
	)

/obj/structure/closet/secure_closet/psychiatry
	name = "Psychiatrist's locker"
	desc = "Everything you need to keep the lunatics at bay."
	icon_state = "securemed1"
	icon_closed = "securemed"
	icon_locked = "securemed1"
	icon_opened = "securemedopen"
	icon_off = "securemedoff"
	closet_appearance = /decl/closet_appearance/secure_closet/medical/alt
	req_access = list(access_medicallvl1)

/obj/structure/closet/secure_closet/psychiatry/WillContain()
	return list(
		/obj/item/clothing/suit/straight_jacket,
		/obj/item/reagent_containers/glass/bottle/stoxin,
		/obj/item/reagent_containers/syringe,
		/obj/item/storage/pill_bottle/citalopram,
		/obj/item/storage/pill_bottle/methylphenidate,
		/obj/item/storage/pill_bottle/paroxetine,
		/obj/item/clothing/under/rank/psych/turtleneck,
		/obj/item/clothing/under/rank/psych
	)

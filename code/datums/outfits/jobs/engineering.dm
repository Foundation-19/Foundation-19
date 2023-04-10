/decl/hierarchy/outfit/job/engineering
	hierarchy_type = /decl/hierarchy/outfit/job/engineering
	belt = /obj/item/storage/belt/utility/full
	l_ear = /obj/item/device/radio/headset/headset_eng
	shoes = /obj/item/clothing/shoes/workboots
	pda_slot = slot_l_store
	flags = OUTFIT_FLAGS_JOB_DEFAULT | OUTFIT_EXTENDED_SURVIVAL

/decl/hierarchy/outfit/job/engineering/New()
	..()
	BACKPACK_OVERRIDE_ENGINEERING

/decl/hierarchy/outfit/job/engineering/engineer
	name = OUTFIT_JOB_NAME("Engineer")
	head = /obj/item/clothing/head/hardhat
	uniform = /obj/item/clothing/under/rank/engineer
	r_pocket = /obj/item/device/t_scanner
	id_types = list(/obj/item/card/id/engineering)
	pda_type = /obj/item/modular_computer/pda/engineering

/decl/hierarchy/outfit/job/engineering/engineer/void
	name = OUTFIT_JOB_NAME("Engineer - Voidsuit")
	head = /obj/item/clothing/head/helmet/space/void/engineering
	mask = /obj/item/clothing/mask/breath
	suit = /obj/item/clothing/suit/space/void/engineering

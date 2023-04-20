/decl/hierarchy/outfit/job/security
	hierarchy_type = /decl/hierarchy/outfit/job/security
	glasses = /obj/item/clothing/glasses/sunglasses/sechud
	l_ear = /obj/item/device/radio/headset/headset_sec
	gloves = /obj/item/clothing/gloves/thick
	shoes = /obj/item/clothing/shoes/jackboots
	backpack_contents = list(/obj/item/handcuffs = 1)

/decl/hierarchy/outfit/job/security/New()
	..()
	BACKPACK_OVERRIDE_SECURITY

/decl/hierarchy/outfit/job/security/hos
	name = OUTFIT_JOB_NAME("Head of security")
	l_ear = /obj/item/device/radio/headset/heads/hos
	uniform = /obj/item/clothing/under/rank/head_of_security
	id_type = /obj/item/card/id/security/head
	pda_type = /obj/item/modular_computer/pda/heads/hos
	backpack_contents = list(/obj/item/handcuffs = 1)

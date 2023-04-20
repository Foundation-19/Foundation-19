/decl/hierarchy/outfit/soviet_soldier
	name = "Soviet soldier"
	uniform = /obj/item/clothing/under/soviet
	shoes = /obj/item/clothing/shoes/combat
	head = /obj/item/clothing/head/ushanka
	gloves = /obj/item/clothing/gloves/thick/combat
	back = /obj/item/storage/backpack/satchel
	belt = /obj/item/gun/projectile/revolver

/decl/hierarchy/outfit/merchant
	name = "Merchant"
	shoes = /obj/item/clothing/shoes/black
	l_ear = /obj/item/device/radio/headset/merchant
	uniform = /obj/item/clothing/under/color/grey
	id_type = /obj/item/card/id/merchant
	pda_type = /obj/item/modular_computer/pda //cause I like the look
	id_pda_assignment = "Merchant"

/decl/hierarchy/outfit/clown
	name = "Clown"
	shoes = /obj/item/clothing/shoes/clown_shoes
	mask = /obj/item/clothing/mask/gas/clown_hat
	l_ear =  /obj/item/device/radio/headset
	uniform = /obj/item/clothing/under/rank/clown
	l_pocket = /obj/item/bikehorn
	flags = OUTFIT_HAS_BACKPACK|OUTFIT_RESET_EQUIPMENT

/decl/hierarchy/outfit/clown/New()
	..()
	backpack_overrides[/decl/backpack_outfit/backpack] = /obj/item/storage/backpack/clown

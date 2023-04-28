/decl/hierarchy/outfit/chaos
	uniform = /obj/item/clothing/under/scp/utility/chaos
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor/chaos
	head = /obj/item/clothing/head/helmet/scp/chaos
	mask = /obj/item/clothing/mask/balaclava/tactical
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/dutyboots
	r_hand = null
	l_hand = /obj/item/material/hatchet/tacknife
	l_ear = /obj/item/device/radio/headset/ert
	l_pocket = /obj/item/grenade/frag
	r_pocket = /obj/item/card/emag
	back = /obj/item/storage/backpack/rucksack/tan

	id_type = null
	hierarchy_type = /decl/hierarchy/outfit/chaos
	flags = OUTFIT_HAS_BACKPACK | OUTFIT_RESET_EQUIPMENT

/decl/hierarchy/outfit/chaos/soldier
	name = OUTFIT_JOB_NAME("Chaos Insurgency Soldier")
	suit_store = /obj/item/gun/projectile/automatic/scp/ak47
	belt = /obj/item/gun/projectile/automatic/machine_pistol
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/clothing/mask/gas = 1,/obj/item/ammo_magazine/scp/ak = 3,/obj/item/ammo_magazine/c45uzi = 2,/obj/item/grenade/smokebomb = 1)

/decl/hierarchy/outfit/chaos/heavy_soldier
	name = OUTFIT_JOB_NAME("Chaos Insurgency Heavy Soldier")
	suit_store = /obj/item/gun/projectile/automatic/scp/rpk
	belt = /obj/item/gun/projectile/shotgun/doublebarrel/sawn
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/ammo_magazine/scp/ak/big = 5,/obj/item/clothing/mask/gas = 1,/obj/item/grenade/frag = 1)

/decl/hierarchy/outfit/chaos/leader
	name = OUTFIT_JOB_NAME("Chaos Insurgency Squad Leader")
	head = /obj/item/clothing/head/beret/solgov/fleet/security
	suit_store = /obj/item/gun/projectile/revolver/mateba
	belt = /obj/item/material/sword/katana
	backpack_contents = list(/obj/item/storage/box/ifak = 1, /obj/item/grenade/smokebomb = 3)

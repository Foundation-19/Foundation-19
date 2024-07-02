/decl/hierarchy/outfit/goc
	uniform = /obj/item/clothing/under/rank/security/goc
	suit = /obj/item/clothing/suit/armor/goc
	suit_store = null
	head = /obj/item/clothing/head/helmet/scp/goc
	mask = /obj/item/clothing/mask/gas/goc
	shoes = /obj/item/clothing/shoes/dutyboots
	gloves = /obj/item/clothing/gloves/tactical/scp
	glasses = /obj/item/clothing/glasses/tacgoggles
	l_ear = /obj/item/device/radio/headset/ert
	id_type = /obj/item/card/id/physics
	back = /obj/item/storage/backpack/rucksack
	belt = /obj/item/storage/belt/holster/security/fullmilpistol

	id_type = /obj/item/card/id/physics
	hierarchy_type = /decl/hierarchy/outfit/goc
	flags = OUTFIT_RESET_EQUIPMENT

/decl/hierarchy/outfit/goc/trooper
	name = OUTFIT_JOB_NAME("UNGOC PHYSICS Trooper")
	r_hand = /obj/item/gun/projectile/automatic/scp/fnfal
	l_hand = /obj/item/grenade/frag
	l_pocket = /obj/item/ammo_magazine/scp
	r_pocket = /obj/item/card/emag
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/storage/box/handcuffs = 1,/obj/item/ammo_magazine/scp/fnfal=6)

/decl/hierarchy/outfit/goc/machinegunner
	name = OUTFIT_JOB_NAME("UNGOC PHYSICS Machinegunner") //I am heavy weapons guy
	head = /obj/item/clothing/head/helmet/scp/security/goc
	suit = /obj/item/clothing/suit/armor/goc/heavy
	r_hand = /obj/item/gun/projectile/automatic/l6_saw //and THIS... is my weapon
	l_hand = null
	l_pocket = /obj/item/grenade/frag
	r_pocket = /obj/item/card/emag
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/storage/box/handcuffs = 1, /obj/item/ammo_magazine/box/machinegun = 4)

/decl/hierarchy/outfit/goc/grenadier
	name = OUTFIT_JOB_NAME("UNGOC PHYSICS Grenadier")
	head = /obj/item/clothing/head/helmet/scp/security/goc
	suit = /obj/item/clothing/suit/armor/goc
	r_hand = /obj/item/gun/launcher/grenade/thumper // LEEEET'S DO IIIT
	l_hand = /obj/item/material/hatchet/tacknife
	l_pocket = /obj/item/plastique
	r_pocket = /obj/item/card/emag
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/storage/box/fragshells = 5,/obj/item/clothing/accessory/storage/bandolier = 1)

/decl/hierarchy/outfit/goc/pointman
	name = OUTFIT_JOB_NAME("UNGOC PHYSICS Pointman")
	head = /obj/item/clothing/head/helmet/scp/security/goc
	suit = /obj/item/clothing/suit/armor/goc/heavy
	r_hand = /obj/item/shield/riot/metal // BULLETS? WHAT BULLETS?
	l_hand = /obj/item/melee/baton/loaded
	l_pocket = /obj/item/grenade/flashbang
	r_pocket = /obj/item/card/emag
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/storage/box/handcuffs = 1,/obj/item/grenade/smokebomb = 2,/obj/item/grenade/flashbang/clusterbang = 1)

/decl/hierarchy/outfit/goc/leader
	name = OUTFIT_JOB_NAME("UNGOC PHYSICS Team Leader")
	head = /obj/item/clothing/head/beret/goc/lead
	suit = /obj/item/clothing/suit/armor/goc/heavy
	r_hand = /obj/item/gun/projectile/automatic/scp/ak742
	l_hand = /obj/item/material/hatchet/tacknife
	l_pocket = /obj/item/grenade/frag
	r_pocket = /obj/item/card/emag
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/storage/box/handcuffs = 1,/obj/item/ammo_magazine/scp/ak/big = 3)

/decl/hierarchy/outfit/goc/trooper/corpse
	name = OUTFIT_JOB_NAME("UNGOC PHYSICS Trooper Corpse")
	r_hand = null
	l_hand = null
	l_pocket = null
	r_pocket = null
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/storage/box/handcuffs = 1,/obj/item/ammo_magazine/scp/fnfal=6)

/decl/hierarchy/outfit/goc/machinegunner/corpse
	name = OUTFIT_JOB_NAME("UNGOC PHYSICS Machinegunner Corpse")
	head = /obj/item/clothing/head/helmet/scp/security/goc
	suit = /obj/item/clothing/suit/armor/goc/heavy
	r_hand = null
	l_hand = null
	l_pocket = null
	r_pocket = null
	backpack_contents = null

/decl/hierarchy/outfit/goc/grenadier/corpse
	name = OUTFIT_JOB_NAME("UNGOC PHYSICS Grenadier Corpse")
	head = /obj/item/clothing/head/helmet/scp/security/goc
	suit = /obj/item/clothing/suit/armor/goc
	r_hand = null
	l_hand = null
	l_pocket = null
	r_pocket = null
	backpack_contents = null

/decl/hierarchy/outfit/goc/leader/corpse
	name = OUTFIT_JOB_NAME("UNGOC PHYSICS Team Leader Corpse")
	head = /obj/item/clothing/head/beret/goc/lead
	suit = /obj/item/clothing/suit/armor/goc/heavy
	r_hand = null
	l_hand = null
	l_pocket = null
	r_pocket = null
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/storage/box/handcuffs = 1,/obj/item/ammo_magazine/scp/ak/big = 3)


/decl/hierarchy/outfit/goc/trooper/corpse/empty
	name = OUTFIT_JOB_NAME("UNGOC PHYSICS Trooper Corpse Empty")
	suit_store = null
	glasses = null
	l_ear = /obj/item/device/radio/headset
	id_type = null
	belt = null
	backpack_contents = null

/decl/hierarchy/outfit/chaos
	uniform = /obj/item/clothing/under/syndicate/chaos
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor/chaos
	head = /obj/item/clothing/head/helmet/scp/chaos
	mask = /obj/item/clothing/mask/gas/ci
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/ci
	shoes = /obj/item/clothing/shoes/tactical
	r_hand = null
	l_hand = /obj/item/material/hatchet/tacknife
	l_ear = /obj/item/device/radio/headset/ert
	l_pocket = /obj/item/grenade/frag
	r_pocket = /obj/item/card/emag
	back = /obj/item/storage/backpack/rucksack/ci

	id_type = /obj/item/card/id/chaos
	hierarchy_type = /decl/hierarchy/outfit/chaos
	flags = OUTFIT_RESET_EQUIPMENT

/decl/hierarchy/outfit/chaos/soldier
	name = OUTFIT_JOB_NAME("Chaos Insurgency Soldier")
	suit_store = /obj/item/gun/projectile/automatic/scp/ak47
	belt = /obj/item/storage/belt/ci
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/ammo_magazine/scp/ak = 3,/obj/item/ammo_magazine/scp/uzim9mm = 2,/obj/item/grenade/smokebomb = 1,/obj/item/gun/projectile/automatic/machine_pistol)

/decl/hierarchy/outfit/chaos/heavy_soldier
	name = OUTFIT_JOB_NAME("Chaos Insurgency Heavy Soldier")
	head = /obj/item/clothing/head/helmet/scp/security/chaos
	suit_store = /obj/item/gun/projectile/automatic/scp/rpk
	belt = /obj/item/storage/belt/ci/rig
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/ammo_magazine/scp/ak/big = 5,/obj/item/grenade/frag = 1,/obj/item/gun/projectile/shotgun/doublebarrel/sawn)

/decl/hierarchy/outfit/chaos/leader
	name = OUTFIT_JOB_NAME("Chaos Insurgency Squad Leader")
	head = /obj/item/clothing/head/helmet/scp/chaos/officer
	suit_store = /obj/item/gun/projectile/automatic/scp/ak47
	belt = /obj/item/storage/belt/ci/rig
	id_type = /obj/item/card/id/chaos/lead
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/ammo_magazine/scp/ak = 5,/obj/item/grenade/smokebomb = 1)

/decl/hierarchy/outfit/chaos/pilot
	name = OUTFIT_JOB_NAME("Chaos Insurgency Pilot")
	uniform = /obj/item/clothing/under/syndicate/chaos
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor/chaos/pilot
	head = /obj/item/clothing/head/helmet/scp/chaos/pilot
	mask = /obj/item/clothing/mask/gas/half
	glasses = null
	gloves = /obj/item/clothing/gloves/tactical/ci
	shoes = /obj/item/clothing/shoes/tactical
	r_hand = null
	l_hand = null
	l_ear = /obj/item/device/radio/headset
	l_pocket = null
	r_pocket = null
	back = null
	id_type = /obj/item/card/id/chaos
	backpack_contents = null

// CHAOS INSURGENCY CORPSES

/decl/hierarchy/outfit/chaos/soldier/corpse
	name = OUTFIT_JOB_NAME("Chaos Insurgency Soldier Corpse")
	suit_store = null
	l_hand = null
	l_ear = /obj/item/device/radio/headset
	l_pocket = null
	r_pocket = null
	belt = /obj/item/storage/belt/ci
	id_type = /obj/item/card/id/chaos
	backpack_contents = null

/decl/hierarchy/outfit/chaos/heavy_soldier/corpse
	name = OUTFIT_JOB_NAME("Chaos Insurgency Heavy Soldier Corpse")
	head = /obj/item/clothing/head/helmet/scp/security/chaos
	suit_store = null
	l_hand = null
	l_ear = /obj/item/device/radio/headset
	l_pocket = null
	r_pocket = null
	belt = /obj/item/storage/belt/ci/rig
	id_type = /obj/item/card/id/chaos
	backpack_contents = null

/decl/hierarchy/outfit/chaos/leader/corpse
	name = OUTFIT_JOB_NAME("Chaos Insurgency Squad Leader Corpse")
	head = /obj/item/clothing/head/helmet/scp/chaos/officer
	suit_store = null
	l_hand = null
	l_ear = /obj/item/device/radio/headset
	l_pocket = null
	r_pocket = null
	belt = /obj/item/storage/belt/ci/rig
	id_type = /obj/item/card/id/chaos/lead
	backpack_contents = null

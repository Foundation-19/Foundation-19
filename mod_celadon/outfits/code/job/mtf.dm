//## FROM: code\datums\outfits\jobs\mtf.dm ##

/decl/hierarchy/outfit/mtf/epsilon_11/agent
	name = OUTFIT_JOB_NAME("MTF Epsilon-11 Agent")
	uniform = /obj/item/clothing/under/ert/epsilon11
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor/MTFlight
	head = /obj/item/clothing/head/helmet/scp/lwh_helmet
	mask = /obj/item/clothing/mask/balaclava/tactical
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/jackboots
	suit_store = /obj/item/gun/projectile/automatic/scp/p90
	r_hand = /obj/item/crowbar/red
	l_hand = /obj/item/material/hatchet/tacknife
	l_pocket = /obj/item/grenade/flashbang
	r_pocket = /obj/item/grenade/flashbang
	id_type = /obj/item/card/id/mtf/ninetail
	belt = /obj/item/storage/belt/holster/security/fullmk9
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/plastique = 2,/obj/item/grenade/frag = 1,/obj/item/ammo_magazine/scp/p90_mag/ap = 5,/obj/item/ammo_magazine/c45m = 2,/obj/item/clothing/mask/gas = 1)

/decl/hierarchy/outfit/mtf/epsilon_11/breacher
	name = OUTFIT_JOB_NAME("MTF Epsilon-11 Breacher")
	uniform = /obj/item/clothing/under/ert/epsilon11
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor/MTFmedium
	head = /obj/item/clothing/head/helmet/scp/lwh_helmet
	mask = /obj/item/clothing/mask/balaclava/tactical
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/jackboots
	suit_store = /obj/item/gun/projectile/shotgun/pump/combat
	r_hand = /obj/item/crowbar/red
	l_hand = /obj/item/material/hatchet
	l_pocket = /obj/item/grenade/flashbang
	r_pocket = /obj/item/grenade/flashbang
	id_type = /obj/item/card/id/mtf/ninetail
	belt = /obj/item/storage/belt/holster/security/fullmk9
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/grenade/frag = 2,/obj/item/ammo_magazine/shotholder/shell = 6,/obj/item/clothing/accessory/storage/bandolier = 1,/obj/item/clothing/mask/gas = 1)

/decl/hierarchy/outfit/mtf/epsilon_11/leader
	name = OUTFIT_JOB_NAME("MTF Epsilon-11 Team Leader")
	uniform = /obj/item/clothing/under/ert/epsilon11
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor/MTFlight
	head = /obj/item/clothing/head/helmet/scp/lwh_helmet
	mask = /obj/item/clothing/mask/balaclava
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/jackboots
	suit_store = /obj/item/gun/projectile/automatic/scp/m16
	r_hand = /obj/item/storage/box/syndie_kit/spy
	l_hand = null
	l_pocket = /obj/item/grenade/smokebomb
	r_pocket = null
	id_type = /obj/item/card/id/mtf/ninetail
	belt = /obj/item/storage/belt/holster/security/fullmateba
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/grenade/frag = 1,/obj/item/crowbar/red = 1,/obj/item/ammo_magazine/scp/m16_mag = 3,/obj/item/ammo_magazine/c44 = 4,/obj/item/clothing/mask/gas = 1)

/decl/hierarchy/outfit/mtf/epsilon_11/medic
	name = OUTFIT_JOB_NAME("MTF Epsilon-11 Medic")
	uniform = /obj/item/clothing/under/ert/epsilon11
	suit = /obj/item/clothing/suit/armor/pcarrier/green/scp/mtf_epsilon
	head = /obj/item/clothing/head/helmet/ballistic
	mask = /obj/item/clothing/mask/balaclava
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/jackboots
	suit_store = /obj/item/gun/projectile/automatic/scp/p90
	r_hand = /obj/item/storage/firstaid/surgery
	l_hand = /obj/item/crowbar/red
	l_pocket = /obj/item/grenade/smokebomb
	r_pocket = null
	id_type = /obj/item/card/id/mtf/ninetail
	belt = /obj/item/defibrillator/compact/combat/loaded
	backpack_contents = list(/obj/item/ammo_magazine/scp/p90_mag/ap = 3,/obj/item/clothing/mask/gas = 1,/obj/item/reagent_containers/ivbag/blood/OMinus = 2,/obj/item/storage/pill_bottle/zoom = 1)

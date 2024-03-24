/decl/hierarchy/outfit/mtf
	l_ear = /obj/item/device/radio/headset/ert
	back = /obj/item/storage/backpack/rucksack

	id_type = /obj/item/card/id/mtf
	hierarchy_type = /decl/hierarchy/outfit/mtf
	flags = OUTFIT_HAS_BACKPACK | OUTFIT_RESET_EQUIPMENT

// Nine Tailed Fox
/decl/hierarchy/outfit/mtf/epsilon_11
	hierarchy_type = /decl/hierarchy/outfit/mtf/epsilon_11

/decl/hierarchy/outfit/mtf/epsilon_11/agent
	name = OUTFIT_JOB_NAME("MTF Epsilon-11 Agent")
	uniform = /obj/item/clothing/under/ert/epsilon11
	suit = /obj/item/clothing/suit/armor/pcarrier/green/scp/mtf_epsilon
	head = /obj/item/clothing/head/helmet/ballistic
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
	suit = /obj/item/clothing/suit/armor/pcarrier/green/scp/mtf_epsilon
	head = /obj/item/clothing/head/helmet/ballistic
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
	suit = /obj/item/clothing/suit/armor/pcarrier/green/scp/mtf_epsilon
	head = /obj/item/clothing/head/beret/mtf
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

/decl/hierarchy/outfit/mtf/eta_10 // See No Evil
	name = OUTFIT_JOB_NAME("MTF Eta-10 Operative")
	uniform = /obj/item/clothing/under/ert/eta10
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor/eta
	head = /obj/item/clothing/head/helmet/scp/eta
	mask = /obj/item/clothing/mask/balaclava/tactical
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/jackboots
	suit_store = /obj/item/gun/projectile/automatic/scp/p90
	r_hand = /obj/item/crowbar/red
	l_hand = /obj/item/material/hatchet/tacknife
	l_pocket = null
	r_pocket = /obj/item/ammo_magazine/scp
	belt = /obj/item/storage/belt/holster/security/fullmk9
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/plastique = 1,/obj/item/grenade/frag = 1,/obj/item/ammo_magazine/scp/p90_mag/ap = 5,/obj/item/clothing/mask/gas = 1)

/decl/hierarchy/outfit/mtf/beta_7 // Maz Hatters
	name = OUTFIT_JOB_NAME("MTF Beta-7 Operative")
	uniform = /obj/item/clothing/under/ert/beta7
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor/beta
	head = /obj/item/clothing/head/helmet/scp/beta
	mask = /obj/item/clothing/mask/balaclava/tactical
	glasses = /obj/item/clothing/glasses/sunglasses
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/jackboots
	suit_store = /obj/item/gun/projectile/automatic/scp/p90
	r_hand = /obj/item/crowbar/red
	l_hand = /obj/item/material/hatchet/tacknife
	l_pocket = null
	r_pocket = /obj/item/ammo_magazine/scp
	id_type = /obj/item/card/id/mtf/beta_7
	belt = /obj/item/storage/belt/holster/security/fullmk9
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/plastique = 1,/obj/item/ammo_magazine/scp/p90_mag/ap = 5,/obj/item/clothing/mask/gas = 1)

/decl/hierarchy/outfit/mtf/epsilon_9
	name = OUTFIT_JOB_NAME("MTF Epsilon-9 Operative")
	uniform = /obj/item/clothing/under/ert/epsilon9
	suit = null
	head = null
	mask = /obj/item/clothing/mask/balaclava
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/dutyboots
	suit_store = null
	r_hand = null
	l_hand = null
	l_pocket = /obj/item/grenade/smokebomb
	r_pocket = /obj/item/grenade/chem_grenade/incendiary
	id_type = /obj/item/card/id/mtf/epsilon
	belt = /obj/item/storage/belt/holster/security/tactical
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/grenade/frag = 1,/obj/item/crowbar/red = 1,/obj/item/clothing/mask/gas = 1)

/decl/hierarchy/outfit/mtf/nu_7 // Hammer Down
	name = OUTFIT_JOB_NAME("MTF Nu-7 Operative")
	uniform = /obj/item/clothing/under/ert/nu7
	suit = /obj/item/clothing/suit/armor/mtfheavy
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/helmet/mtfheavy
	gloves = /obj/item/clothing/gloves/thick/combat
	glasses = /obj/item/clothing/glasses/tacgoggles
	shoes = /obj/item/clothing/shoes/combat
	suit_store = null
	r_hand = /obj/item/gun/projectile/automatic/scp/m16
	l_hand = null
	l_pocket = /obj/item/grenade/frag
	r_pocket = /obj/item/grenade/flashbang/clusterbang //gods must be strong
	id_type = /obj/item/card/id/mtf/nu_7
	belt = /obj/item/storage/belt/holster/security/tactical
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/ammo_magazine/scp/m16_mag = 5, /obj/item/plastique = 2, /obj/item/grenade/frag = 1, /obj/item/crowbar/red = 1) //Actual util

/decl/hierarchy/outfit/mtf/alpha_1 // Red Right Hand
	name = OUTFIT_JOB_NAME("MTF Alpha-1 Operative")
	uniform = /obj/item/clothing/under/ert/alpha1
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor/alpha
	mask = /obj/item/clothing/mask/gas/alpha
	head = /obj/item/clothing/head/beret/mtf/alpha
	gloves = /obj/item/clothing/gloves/tactical/alpha
	glasses = /obj/item/clothing/glasses/night
	shoes = /obj/item/clothing/shoes/combat
	suit_store = null
	r_hand = /obj/item/gun/projectile/automatic/t12
	l_hand = null
	l_pocket = /obj/item/grenade/frag
	r_pocket = /obj/item/grenade/flashbang/clusterbang //gods must be strong
	id_type = /obj/item/card/id/mtf/alpha
	belt = /obj/item/storage/belt/holster/security/tactical
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/ammo_magazine/t12 = 5, /obj/item/plastique = 2, /obj/item/grenade/frag = 5, /obj/item/crowbar/red = 1) //Breach and clear.

/decl/hierarchy/outfit/mtf/omega1 // Laws Left Hand
	name = OUTFIT_JOB_NAME("MTF Omega-1 Enforcement")
	uniform = /obj/item/clothing/under/ert/omega1
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor/alpha
	mask = /obj/item/clothing/mask/gas/syndicate
	head = /obj/item/clothing/head/beret/mtf/omega
	gloves = /obj/item/clothing/gloves/thick/swat/lcz
	glasses = /obj/item/clothing/glasses/sunglasses/sechud
	shoes = /obj/item/clothing/shoes/combat
	suit_store = null
	r_hand = /obj/item/gun/projectile/automatic/scp/vector
	l_hand = null
	l_pocket = /obj/item/grenade/frag
	r_pocket = /obj/item/grenade/flashbang/clusterbang //gods must be strong
	id_type = /obj/item/card/id/mtf/omega
	belt = /obj/item/storage/belt/holster/security/fullrhino
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/ammo_magazine/scp/vectormag = 5, /obj/item/storage/box/handcuffs = 1, /obj/item/melee/baton/loaded = 1, /obj/item/crowbar/red = 1) //Breach and clear.

/decl/hierarchy/outfit/mtf/isd
	name = OUTFIT_JOB_NAME("Internal Security Department Field Uniform")
	uniform = /obj/item/clothing/under/rank/security/isd
	suit = null
	mask = null
	head = /obj/item/clothing/head/beret/isd
	gloves = /obj/item/clothing/gloves/tactical/scp
	glasses = /obj/item/clothing/glasses/sunglasses
	shoes = /obj/item/clothing/shoes/dutyboots
	suit_store = null
	r_hand = null
	l_hand = /obj/random/clipboard
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/ammo_magazine/machine_pistol
	id_type = /obj/item/card/id/mtf/isd
	belt = /obj/item/gun/projectile/automatic/machine_pistol
	back = /obj/item/storage/backpack/satchel/leather/black
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/crowbar/emergency_forcing_tool = 1,/obj/item/stamp/scp/o5rep = 1,/obj/item/melee/baton/loaded = 1,/obj/item/clothing/mask/gas/isd = 1)

/decl/hierarchy/outfit/mtf/isd/formal
	name = OUTFIT_JOB_NAME("Internal Security Department Formal Uniform")
	uniform = /obj/item/clothing/under/rank/security/isd/suit
	suit = /obj/item/clothing/suit/armor/vest/scp/isd
	head = /obj/item/clothing/head/beret/isd/fedora
	l_pocket = /obj/item/reagent_containers/spray/pepper
	belt = /obj/item/gun/energy/pulse_rifle/pistol

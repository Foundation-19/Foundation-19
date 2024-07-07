/decl/hierarchy/outfit/job/security/New()
	..()
	BACKPACK_OVERRIDE_SECURITY

/decl/hierarchy/outfit/job/command/cos
	name = OUTFIT_JOB_NAME("Guard Commander")
	uniform = /obj/item/clothing/under/rank/head_of_security/guardcom
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/card/id/gcseclvl5
	r_pocket = /obj/item/book/manual/scp/secsop
	l_ear = /obj/item/device/radio/headset/heads/cos
	suit = /obj/item/clothing/suit/armor/hos/coat
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list(/obj/item/clothing/head/helmet/scp/hczsecurityguard = 1)
	belt = /obj/item/storage/belt/holster/security/fullmateba
	glasses = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	head = /obj/item/clothing/head/beret/sec/guardcom
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/tactical/scp

/decl/hierarchy/outfit/job/security/hcz_zone_commander
	name = OUTFIT_JOB_NAME("HCZ Zone Lieutenant")
	uniform = /obj/item/clothing/under/rank/head_of_security/hcz
	glasses = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/card/id/zcseclvl4hcz
	l_ear = /obj/item/device/radio/headset/heads/cos
	suit = /obj/item/clothing/suit/armor/pcarrier/scp/tactical
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list(/obj/item/clothing/head/beret/sec = 1)
	belt = /obj/item/storage/belt/holster/security/fullmateba
	head = /obj/item/clothing/head/helmet/scp/hczsecurityguard
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/tactical/scp


/decl/hierarchy/outfit/job/security/lcz_zone_commander
	name = OUTFIT_JOB_NAME("LCZ Zone Lieutenant")
	uniform = /obj/item/clothing/under/rank/head_of_security/lcz
	glasses = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/card/id/zcseclvl4lcz
	l_ear = /obj/item/device/radio/headset/headset_sec_lcz/commander
	suit = /obj/item/clothing/suit/armor/vest/scp/lczcomm
	shoes = /obj/item/clothing/shoes/dutyboots
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list(/obj/item/handcuffs = 1)
	belt = /obj/item/storage/belt/holster/security/fullusp45
	head = /obj/item/clothing/head/helmet/scp/security/lczcom
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/thick/swat/lcz

/decl/hierarchy/outfit/job/security/ez_zone_commander
	name = OUTFIT_JOB_NAME("EZ Zone Supervisor")
	uniform = /obj/item/clothing/under/rank/head_of_security/ez
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/card/id/zcseclvl4ez
	l_ear = /obj/item/device/radio/headset/heads/cos
	suit = /obj/item/clothing/suit/armor/pcarrier/scp/medium
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list(/obj/item/clothing/head/beret/sec/corporate/hos = 1)
	belt = /obj/item/storage/belt/holster/security/fullrhino
	glasses = /obj/item/clothing/glasses/sunglasses/sechud
	head = /obj/item/clothing/head/helmet/scp/hczsecurityguard
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/tactical/scp

/decl/hierarchy/outfit/job/security/lcz_sergeant
	name = OUTFIT_JOB_NAME("LCZ Sergeant")
	uniform = /obj/item/clothing/under/rank/warden/lcz
	glasses = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/card/id/seclvl3lcz
	l_ear = /obj/item/device/radio/headset/headset_sec_lcz
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list(/obj/item/handcuffs = 1)
	belt = /obj/item/storage/belt/holster/security/fullmk9
	head = /obj/item/clothing/head/helmet/scp/security
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/thick/swat/lcz


/decl/hierarchy/outfit/job/security/hcz_sergeant
	name = OUTFIT_JOB_NAME("HCZ Sergeant")
	uniform = /obj/item/clothing/under/rank/warden/hcz
	glasses = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	suit = /obj/item/clothing/suit/armor/pcarrier/scp/tactical
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/card/id/seclvl3hcz
	l_ear = /obj/item/device/radio/headset/headset_sec_hcz
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list()
	belt = /obj/item/storage/belt/holster/security/fullusp45
	head = /obj/item/clothing/head/helmet/scp/hczsecurityguard
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/tactical/scp

/decl/hierarchy/outfit/job/security/ez_sergeant
	name = OUTFIT_JOB_NAME("EZ Senior Agent")
	uniform = /obj/item/clothing/under/rank/warden/ez
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/card/id/seclvl3ez
	l_ear = /obj/item/device/radio/headset/headset_sec_ecz
	l_pocket = /obj/item/book/manual/scp/secsop
	suit = /obj/item/clothing/suit/armor/pcarrier/scp/medium
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list()
	belt = /obj/item/storage/belt/holster/security/fullmk9
	glasses = /obj/item/clothing/glasses/sunglasses/sechud
	head = /obj/item/clothing/head/helmet/scp/hczsecurityguard
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/tactical/scp

/decl/hierarchy/outfit/job/security/ez_medic
	name = OUTFIT_JOB_NAME("EZ Combat Medic")
	uniform = /obj/item/clothing/under/rank/security/ez
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/card/id/seclvl3ez
	l_ear = /obj/item/device/radio/headset/headset_sec_ecz
	l_pocket = /obj/item/book/manual/scp/secsop
	suit = /obj/item/clothing/suit/armor/pcarrier/scp/medium
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list(/obj/item/storage/firstaid/adv = 1, /obj/item/storage/firstaid/stab = 1)
	belt = /obj/item/storage/belt/holster/security/fullmk9
	glasses = /obj/item/clothing/glasses/sunglasses/sechud
	head = /obj/item/clothing/head/helmet/scp/hczsecurityguard
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/latex/nitrile/armored

/decl/hierarchy/outfit/job/security/ez_guard
	name = OUTFIT_JOB_NAME("EZ Agent")
	uniform = /obj/item/clothing/under/rank/security/ez
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/card/id/seclvl3ez
	l_ear = /obj/item/device/radio/headset/headset_sec_ecz
	l_pocket = /obj/item/book/manual/scp/secsop
	suit = /obj/item/clothing/suit/armor/pcarrier/scp/medium
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list()
	belt = /obj/item/storage/belt/holster/security/fullmk9
	glasses = /obj/item/clothing/glasses/sunglasses/sechud
	head = /obj/item/clothing/head/helmet/scp/hczsecurityguard
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/tactical/scp

/decl/hierarchy/outfit/job/security/ez_sergeant_investigative
	name = OUTFIT_JOB_NAME("Investigation Officer")
	uniform = /obj/item/clothing/under/det/grey
	shoes = /obj/item/clothing/shoes/dress
	suit = /obj/item/clothing/suit/storage/det_trench/grey
	id_type = /obj/item/card/id/zcseclvl4ez
	l_ear = /obj/item/device/radio/headset/heads/cos
	belt = /obj/item/storage/belt/holster/security/fullrhino
	l_hand = /obj/item/storage/briefcase/crimekit
	glasses = /obj/item/clothing/glasses/sunglasses/sechud
	head = /obj/item/clothing/head/det/grey
	gloves = /obj/item/clothing/gloves/forensic
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list(/obj/item/clothing/head/helmet/scp/hczsecurityofficer = 1, /obj/item/clothing/suit/armor/pcarrier/scp/medium = 1)

/decl/hierarchy/outfit/job/security/ez_guard_investigative
	name = OUTFIT_JOB_NAME("Investigation Agent")
	uniform = /obj/item/clothing/under/det
	shoes = /obj/item/clothing/shoes/dress
	suit = /obj/item/clothing/suit/storage/det_trench
	id_type = /obj/item/card/id/zcseclvl4ez
	l_ear = /obj/item/device/radio/headset/heads/cos
	belt = /obj/item/storage/belt/holster/security/fullrhino
	l_hand = /obj/item/storage/briefcase/crimekit
	glasses = /obj/item/clothing/glasses/sunglasses/sechud
	head = /obj/item/clothing/head/det
	gloves = /obj/item/clothing/gloves/forensic
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list(/obj/item/clothing/head/helmet/scp/hczsecurityofficer = 1, /obj/item/clothing/suit/armor/pcarrier/scp/medium = 1)

/decl/hierarchy/outfit/job/security/lcz_guard
	name = OUTFIT_JOB_NAME("LCZ Guard")
	uniform = /obj/item/clothing/under/rank/security/lcz
	glasses = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/card/id/junseclvl2lcz
	l_ear = /obj/item/device/radio/headset/headset_sec_lcz
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list(/obj/item/handcuffs = 1)
	belt = /obj/item/storage/belt/holster/security/fullmk9
	head = /obj/item/clothing/head/helmet/scp/security
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/thick/swat/lcz

/decl/hierarchy/outfit/job/security/lcz_medic
	name = OUTFIT_JOB_NAME("LCZ Combat Medic")
	uniform = /obj/item/clothing/under/rank/security/lcz/medic
	glasses = /obj/item/clothing/glasses/hud/health/visor
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor/medic
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/card/id/seclvl2lczdivision
	l_ear = /obj/item/device/radio/headset/headset_sec_lcz/medic
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list(/obj/item/storage/firstaid/adv = 1, /obj/item/storage/firstaid/stab = 1)
	belt = /obj/item/storage/belt/holster/security/fullmk9
	head = /obj/item/clothing/head/helmet/scp/security/medic
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/latex/nitrile/armored

/decl/hierarchy/outfit/job/security/lcz_riot
	name = OUTFIT_JOB_NAME("LCZ Riot Control Unit")
	uniform = /obj/item/clothing/under/rank/security/lcz/riot
	glasses = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor/riot
	shoes = /obj/item/clothing/shoes/combat/lcz
	id_type = /obj/item/card/id/seclvl2lczdivision2
	l_ear = /obj/item/device/radio/headset/headset_sec_lcz
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list(/obj/item/handcuffs = 1)
	belt = /obj/item/storage/belt/holster/security/fullmk9
	head = /obj/item/clothing/head/helmet/scp/security/riot
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/thick/swat/lcz

/decl/hierarchy/outfit/job/security/lcz_recontain
	name = OUTFIT_JOB_NAME("LCZ Recontainment Unit")
	uniform = /obj/item/clothing/under/rank/security/lcz/recontain
	glasses = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor/recontain
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/card/id/seclvl3lczdivision3
	l_ear = /obj/item/device/radio/headset/headset_sec_lcz/recontain
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list(/obj/item/handcuffs = 1)
	belt = /obj/item/storage/belt/holster/security/fullmk9
	head = /obj/item/clothing/head/helmet/scp/security/recontain
	mask = /obj/item/clothing/mask/gas/security
	gloves = /obj/item/clothing/gloves/thick/swat/lcz

/decl/hierarchy/outfit/job/security/hcz_guard
	name = OUTFIT_JOB_NAME("HCZ Guard")
	uniform = /obj/item/clothing/under/rank/security/hcz
	glasses = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/card/id/junseclvl3hcz
	l_ear = /obj/item/device/radio/headset/headset_sec_hcz
	suit = /obj/item/clothing/suit/armor/pcarrier/scp/tactical
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list(/obj/item/handcuffs = 1)
	belt = /obj/item/storage/belt/holster/security/fullusp45
	head = /obj/item/clothing/head/helmet/scp/hczsecurityguard
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/tactical/scp

/decl/hierarchy/outfit/job/security/raisa_agent
	name = OUTFIT_JOB_NAME("RAISA Agent")
	uniform = /obj/item/clothing/under/rank/security/ez
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/card/id/seclvl3raisa
	l_ear = /obj/item/device/radio/headset/headset_sec_ecz
	l_pocket = /obj/item/book/manual/scp/secsop
	suit = /obj/item/clothing/suit/armor/pcarrier/scp/medium
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list()
	glasses = /obj/item/clothing/glasses/sunglasses/sechud
	belt = /obj/item/gun/energy/stunrevolver/taser
	gloves = /obj/item/clothing/gloves/tactical/scp

/decl/hierarchy/outfit/job/security/lcz_cadet
	name = OUTFIT_JOB_NAME("LCZ Cadet")
	uniform = /obj/item/clothing/under/rank/security/lcz/cadet
	glasses = /obj/item/clothing/glasses/sunglasses/sechud
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor/cadet
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/card/id/junseclvl1lcz
	l_ear = /obj/item/device/radio/headset/headset_sec_lcz
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list(/obj/item/handcuffs = 1)
	belt = /obj/item/storage/belt/holster/security/fullmk9
	gloves = /obj/item/clothing/gloves/tactical/scp

/decl/hierarchy/outfit/job/security/ez_probationary
	name = OUTFIT_JOB_NAME("EZ Probationary Agent")
	uniform = /obj/item/clothing/under/rank/security/ez
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/card/id/junseclvl1ez
	l_ear = /obj/item/device/radio/headset/headset_sec_ecz
	l_pocket = /obj/item/book/manual/scp/secsop
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor/cadet
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list()
	belt = /obj/item/storage/belt/holster/security/fullmk9
	glasses = /obj/item/clothing/glasses/sunglasses/sechud
	head = /obj/item/clothing/head/helmet/scp/security/cadet/hat
	gloves = /obj/item/clothing/gloves/tactical/scp

/decl/hierarchy/outfit/job/security/hcz_cadet
	name = OUTFIT_JOB_NAME("HCZ Private")
	uniform = /obj/item/clothing/under/rank/security/hcz
	glasses = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/card/id/junseclvl2hcz
	l_ear = /obj/item/device/radio/headset/headset_sec_hcz
	suit = /obj/item/clothing/suit/armor/pcarrier/scp/medium
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list()
	belt = /obj/item/storage/belt/holster/security/fullmk9
	head = /obj/item/clothing/head/helmet/scp/hczsecurityguard
	gloves = /obj/item/clothing/gloves/tactical/scp

/* Non-SCP security outfits */

/decl/hierarchy/outfit/job/security/officer
	name = "Security Officer"
	uniform = /obj/item/clothing/under/rank/security
	l_pocket = /obj/item/device/flash
	r_pocket = /obj/item/handcuffs
	id_type = /obj/item/card/id/security
	pda_type = /obj/item/modular_computer/pda/security

/decl/hierarchy/outfit/job/security/officer/armored
	name = "Security Officer - Armored"
	suit = /obj/item/clothing/suit/armor/vest/old/security
	head = /obj/item/clothing/head/helmet

/decl/hierarchy/outfit/job/security/officer/armored/riot
	name = "Security Officer - Riot Gear"
	suit = /obj/item/clothing/suit/armor/riot
	head = /obj/item/clothing/head/helmet/riot
	mask = /obj/item/clothing/mask/gas

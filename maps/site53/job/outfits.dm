//Job Outfits


//SITE DS90 OUTFITS
//Keeping them simple for now, just spawning with basic uniforms, and pretty much no gear. Gear instead goes in lockers. Keep this in mind if editing.
//Note: backpack items conflict with the built-in backpack selection

// SCP COMMAND OUTFITS

/decl/hierarchy/outfit/job/site90/crew/security/New()
	..()
	BACKPACK_OVERRIDE_SECURITY

/decl/hierarchy/outfit/job/ds90/medical/New()
	..()
	BACKPACK_OVERRIDE_MEDICAL

/decl/hierarchy/outfit/job/ds90/medical/chemist/New()
	..()
	BACKPACK_OVERRIDE_CHEMISTRY

/decl/hierarchy/outfit/job/ds90/crew/engineering/New()
	..()
	BACKPACK_OVERRIDE_ENGINEERING

/decl/hierarchy/outfit/job/site90/crew/command/New()
	..()
	BACKPACK_OVERRIDE_COMMAND

/decl/hierarchy/outfit/job/site90/crew/command/facilitydir
	name = OUTFIT_JOB_NAME("Facility Director")
	uniform = /obj/item/clothing/under/scp/suittie
	shoes = /obj/item/clothing/shoes/dress
	suit = /obj/item/clothing/suit/storage/toggle/suit/black
	id_types = list(/obj/item/card/id/adminlvl5)
	l_ear = /obj/item/device/radio/headset/heads/captain
	backpack_contents = list(/obj/item/ammo_magazine/scp/m1911 = 1)
	belt = /obj/item/gun/projectile/pistol/m1911
	l_hand = /obj/item/storage/briefcase/foundation/jerraman

/decl/hierarchy/outfit/job/site90/crew/command/headofhr
	name = OUTFIT_JOB_NAME("Head of Human Resources")
	uniform = /obj/item/clothing/under/scp/suittie
	shoes = /obj/item/clothing/shoes/dress
	suit = /obj/item/clothing/suit/storage/toggle/suit/black
	id_types = list(/obj/item/card/id/adminlvl4)
	l_ear = /obj/item/device/radio/headset/heads/hop

/decl/hierarchy/outfit/job/site90/crew/command/commsofficer
	name = OUTFIT_JOB_NAME("Communications Officer")
	uniform = /obj/item/clothing/under/scp/utility/communications/officer
	gloves = /obj/item/clothing/gloves/foundation_service
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/commslvl4)
	l_ear = /obj/item/device/radio/headset/heads/commsofficer




// END OF COMMAND OUTFITS
/decl/hierarchy/outfit/job/site90/crew/command/commstech
	name = OUTFIT_JOB_NAME("Communications Technician")
	uniform = /obj/item/clothing/under/solgov/utility/fleet
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/commslvl1)
	belt = /obj/item/storage/belt/utility/full
	l_ear = /obj/item/device/radio/headset/commsdispatcher


/decl/hierarchy/outfit/job/ds90/crew/command/chief_engineer
	name = OUTFIT_JOB_NAME("Chief Engineer")
	uniform = /obj/item/clothing/under/scp/utility/engineering
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl5eng)
	belt = /obj/item/storage/belt/utility/full
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/heads/ce

//Don't touch these yet, Working on em! - Kepler
// Cell Guards
/* CANDIDATE FOR REMOVAL.
/decl/hierarchy/outfit/job/site90/crew/security/cellguardlieutenant
	name = OUTFIT_JOB_NAME("Cell Warden")
	uniform = /obj/item/clothing/under/rank/security2
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl4
	l_ear = /obj/item/device/radio/headset/heads/cw

/decl/hierarchy/outfit/job/site90/crew/security/brigofficer
	name = OUTFIT_JOB_NAME("Cell Guard")
	uniform = /obj/item/clothing/under/rank/security2
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl2
	l_ear = /obj/item/device/radio/headset/headset_sec
	l_pocket = /obj/item/book/manual/scp/secsop
*/


// SECURITY OUTFITS
/decl/hierarchy/outfit/job/site90/crew/command/cos
	name = OUTFIT_JOB_NAME("Guard Commander")
	uniform = /obj/item/clothing/under/rank/head_of_security/corp
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/gcseclvl5)
	r_pocket = /obj/item/book/manual/scp/secsop
	l_ear = /obj/item/device/radio/headset/heads/cos
	suit = /obj/item/clothing/suit/armor/hos/jensen
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list(/obj/item/clothing/head/helmet/scp/hczsecurityguard = 1)
	belt = /obj/item/storage/belt/holster/security/fullmateba
	glasses = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	head = /obj/item/clothing/head/beret/solgov/marcom
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/tactical/scp


// ZONE COMMANDER OUTFITS.
/decl/hierarchy/outfit/job/site90/crew/security/ltofficerhcz
	name = OUTFIT_JOB_NAME("HCZ Zone Commander")
	uniform = /obj/item/clothing/under/scp/hcz/dark/armband
	glasses = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/zcseclvl4hcz)
	l_ear = /obj/item/device/radio/headset/heads/cos
	suit = /obj/item/clothing/suit/armor/pcarrier/scp/tactical
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list(/obj/item/clothing/head/beret/sec = 1)
	belt = /obj/item/storage/belt/holster/security/fullmk9
	head = /obj/item/clothing/head/helmet/scp/hczsecurityguard
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/tactical/scp


/decl/hierarchy/outfit/job/site90/crew/security/ltofficerlcz
	name = OUTFIT_JOB_NAME("LCZ Zone Commander")
	uniform = /obj/item/clothing/under/scp/lcz/armband
	glasses = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/zcseclvl3lcz)
	l_ear = /obj/item/device/radio/headset/heads/cos
	suit = /obj/item/clothing/suit/armor/vest/scp/russcom
	shoes = /obj/item/clothing/shoes/dutyboots
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list(/obj/item/handcuffs = 1)
	belt = /obj/item/storage/belt/holster/security/fullmk9
	head = /obj/item/clothing/head/helmet/scp/security
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/tactical/scp

/decl/hierarchy/outfit/job/site90/crew/security/ltofficerez
	name = OUTFIT_JOB_NAME("EZ Supervisor")
	uniform = /obj/item/clothing/under/rank/warden/corp
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/zcseclvl4ez)
	l_ear = /obj/item/device/radio/headset/heads/cos
	suit = /obj/item/clothing/suit/armor/pcarrier/scp/medium
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list(/obj/item/clothing/head/beret/sec/corporate/hos = 1)
	belt = /obj/item/storage/belt/holster/security/fullmk9
	glasses = /obj/item/clothing/glasses/sunglasses/sechud
	head = /obj/item/clothing/head/helmet/scp/hczsecurityguard
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/tactical/scp

// GUARD OUTFITS
/decl/hierarchy/outfit/job/site90/crew/security/ncoofficerlcz
	name = OUTFIT_JOB_NAME("LCZ Sergeant")
	uniform = /obj/item/clothing/under/scp/lcz/armband
	glasses = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl3lcz)
	l_ear = /obj/item/device/radio/headset/headset_sec_lcz
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list(/obj/item/handcuffs = 1)
	belt = /obj/item/storage/belt/holster/security/fullmk9
	head = /obj/item/clothing/head/helmet/scp/security
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/tactical/scp


/decl/hierarchy/outfit/job/site90/crew/security/ncoofficerhcz
	name = OUTFIT_JOB_NAME("HCZ Sergeant")
	uniform = /obj/item/clothing/under/scp/hcz/dark/armband
	glasses = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	suit = /obj/item/clothing/suit/armor/pcarrier/scp/tactical
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl3hcz)
	l_ear = /obj/item/device/radio/headset/headset_sec_hcz
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list()
	belt = /obj/item/storage/belt/holster/security/fullmk9
	head = /obj/item/clothing/head/helmet/scp/hczsecurityguard
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/tactical/scp

/decl/hierarchy/outfit/job/site90/crew/security/ncoofficerez
	name = OUTFIT_JOB_NAME("EZ Senior Agent")
	uniform = /obj/item/clothing/under/rank/security/corp
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl3ez)
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

/decl/hierarchy/outfit/job/site90/crew/security/medic
	name = OUTFIT_JOB_NAME("EZ Combat Medic")
	uniform = /obj/item/clothing/under/rank/security/corp
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl3ez)
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

/decl/hierarchy/outfit/job/site90/crew/security/enlistedofficerez
	name = OUTFIT_JOB_NAME("EZ Agent")
	uniform = /obj/item/clothing/under/rank/security/corp
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl3ez)
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

/decl/hierarchy/outfit/job/site90/crew/security/secauditorofficer
	name = OUTFIT_JOB_NAME("Investigation Officer")
	uniform = /obj/item/clothing/under/det/grey
	shoes = /obj/item/clothing/shoes/dress
	suit = /obj/item/clothing/suit/storage/det_trench/grey
	id_types = list(/obj/item/card/id/zcseclvl4ez)
	l_ear = /obj/item/device/radio/headset/heads/cos
	belt = /obj/item/storage/belt/holster/security/fullrhino
	l_hand = /obj/item/storage/briefcase/crimekit
	glasses = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	head = /obj/item/clothing/head/det/grey
	gloves = /obj/item/clothing/gloves/forensic
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list(/obj/item/clothing/head/helmet/scp/hczsecurityofficer = 1, /obj/item/clothing/suit/armor/pcarrier/scp/medium = 1)

/decl/hierarchy/outfit/job/site90/crew/security/secauditor
	name = OUTFIT_JOB_NAME("Investigation Agent")
	uniform = /obj/item/clothing/under/det
	shoes = /obj/item/clothing/shoes/dress
	suit = /obj/item/clothing/suit/storage/det_trench
	id_types = list(/obj/item/card/id/zcseclvl4ez)
	l_ear = /obj/item/device/radio/headset/heads/cos
	belt = /obj/item/storage/belt/holster/security/fullrhino
	l_hand = /obj/item/storage/briefcase/crimekit
	glasses = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	head = /obj/item/clothing/head/det
	gloves = /obj/item/clothing/gloves/forensic
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list(/obj/item/clothing/head/helmet/scp/hczsecurityofficer = 1, /obj/item/clothing/suit/armor/pcarrier/scp/medium = 1)

// JUNIOR GUARD OUTFITS
/decl/hierarchy/outfit/job/site90/crew/security/enlistedofficerlcz
	name = OUTFIT_JOB_NAME("LCZ Guard")
	uniform = /obj/item/clothing/under/scp/lcz
	glasses = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/junseclvl2lcz)
	l_ear = /obj/item/device/radio/headset/headset_sec_lcz
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list(/obj/item/handcuffs = 1)
	belt = /obj/item/storage/belt/holster/security/fullmk9
	head = /obj/item/clothing/head/helmet/scp/security
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/tactical/scp

/decl/hierarchy/outfit/job/site90/crew/security/enlistedofficerhcz
	name = OUTFIT_JOB_NAME("HCZ Guard")
	uniform = /obj/item/clothing/under/scp/hcz/dark
	glasses = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/junseclvl3hcz)
	l_ear = /obj/item/device/radio/headset/headset_sec_hcz
	suit = /obj/item/clothing/suit/armor/pcarrier/scp/tactical
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list()
	belt = /obj/item/storage/belt/holster/security/fullmk9
	head = /obj/item/clothing/head/helmet/scp/hczsecurityguard
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/tactical/scp

// SCIENCE OUTFITS
/decl/hierarchy/outfit/job/site90/crew/science/juniorscientist
	name = OUTFIT_JOB_NAME("Scientist Associate")
	uniform = /obj/item/clothing/under/scp/suittie
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/science
	shoes = /obj/item/clothing/shoes/laceup
	id_types = list(/obj/item/card/id/sciencelvl1)
	l_ear = /obj/item/device/radio/headset/headset_sci
	backpack_contents = list(/obj/item/clothing/accessory/tunic = 1)

/decl/hierarchy/outfit/job/site90/crew/science/scientist
	name = OUTFIT_JOB_NAME("Scientist")
	uniform = /obj/item/clothing/under/scp/suittie
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/science
	shoes = /obj/item/clothing/shoes/laceup
	id_types = list(/obj/item/card/id/sciencelvl2)
	l_ear = /obj/item/device/radio/headset/headset_sci
	l_pocket = /obj/item/book/manual/scp/scisop
	glasses = /obj/item/clothing/glasses/science
	backpack_contents = list(/obj/item/clothing/accessory/tunic = 1)

/decl/hierarchy/outfit/job/site90/crew/science/seniorroboticist
	name = OUTFIT_JOB_NAME("Senior Robotics Technician")
	uniform = /obj/item/clothing/under/solgov/utility/fleet/combat
	suit = /obj/item/clothing/suit/storage/toggle/highvis
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/sciencelvl4)
	gloves = /obj/item/clothing/gloves/insulated
	l_ear = /obj/item/device/radio/headset/headset_sci
	l_pocket = /obj/item/book/manual/scp/scisop
	belt = /obj/item/storage/belt/utility/full
	head =	/obj/item/clothing/head/welding

/decl/hierarchy/outfit/job/site90/crew/science/roboticist
	name = OUTFIT_JOB_NAME("Robotics Technician")
	uniform = /obj/item/clothing/under/solgov/utility/fleet/combat
	suit = /obj/item/clothing/suit/storage/toggle/highvis
	shoes = /obj/item/clothing/shoes/jackboots
	id_types = list(/obj/item/card/id/sciencelvl3)
	gloves = /obj/item/clothing/gloves/insulated
	l_ear = /obj/item/device/radio/headset/headset_sci
	l_pocket = /obj/item/book/manual/scp/scisop
	belt = /obj/item/storage/belt/utility/full
	head =	/obj/item/clothing/head/welding

/decl/hierarchy/outfit/job/site90/crew/science/juniorroboticist
	name = OUTFIT_JOB_NAME("Junior Robotics Technician")
	uniform = /obj/item/clothing/under/solgov/utility/fleet/combat
	suit = /obj/item/clothing/suit/storage/toggle/highvis
	shoes = /obj/item/clothing/shoes/black
	id_types = list(/obj/item/card/id/sciencelvl2)
	gloves = /obj/item/clothing/gloves/thick
	l_ear = /obj/item/device/radio/headset/headset_sci
	l_pocket = /obj/item/book/manual/scp/scisop
	belt = /obj/item/storage/belt/utility/full

/decl/hierarchy/outfit/job/site90/crew/science/seniorscientist
	name = OUTFIT_JOB_NAME("Senior Scientist")
	uniform = /obj/item/clothing/under/scp/suittie
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/science
	shoes = /obj/item/clothing/shoes/laceup
	id_types = list(/obj/item/card/id/sciencelvl4)
	gloves = /obj/item/clothing/gloves/latex/nitrile
	l_pocket = /obj/item/book/manual/scp/scisop
	l_ear = /obj/item/device/radio/headset/headset_sci
	glasses = /obj/item/clothing/glasses/science
	backpack_contents = list(/obj/item/clothing/accessory/tunic = 1)

/decl/hierarchy/outfit/job/site90/crew/science/researchdirector
	name = OUTFIT_JOB_NAME("Research Director")
	uniform = /obj/item/clothing/under/scp/suittie
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/rd
	shoes = /obj/item/clothing/shoes/laceup
	id_types = list(/obj/item/card/id/sciencelvl5)
	gloves = /obj/item/clothing/gloves/latex/nitrile
	l_ear = /obj/item/device/radio/headset/heads/rd
	l_pocket = /obj/item/book/manual/scp/scisop
	glasses = /obj/item/clothing/glasses/hud/science
	backpack_contents = list(/obj/item/clothing/accessory/tunic = 1)


// MISC OUTFITS
/decl/hierarchy/outfit/job/site90/crew/civ/classd
	name = OUTFIT_JOB_NAME("Class D")
	uniform = /obj/item/clothing/under/scp/dclass
	shoes = /obj/item/clothing/shoes/workboots
	l_ear = null
	l_pocket = /obj/item/paper/dclass_orientation
	id_types = list(/obj/item/card/id/classd)

/decl/hierarchy/outfit/job/site90/crew/civ/classd/post_equip(mob/living/carbon/human/H)
	..()
	if(prob(15))
		var/path = pick( /obj/item/wrench, /obj/item/screwdriver)
		H.equip_to_slot_or_store_or_drop(new path (H), slot_l_store)

/decl/hierarchy/outfit/job/site90/crew/civ/janitor
	name = OUTFIT_JOB_NAME("Janitor")
	uniform = /obj/item/clothing/under/rank/janitor
	shoes = /obj/item/clothing/shoes/workboots
	l_pocket = /obj/item/device/radio
	id_types = list(/obj/item/card/id/sciencelvl1)
	l_ear = /obj/item/device/radio/headset/headset_service

/decl/hierarchy/outfit/job/site90/crew/civ/chef
	name = OUTFIT_JOB_NAME("Chef")
	uniform = /obj/item/clothing/under/color/white
	shoes = /obj/item/clothing/shoes/white
	l_pocket = /obj/item/device/radio
	id_types = list(/obj/item/card/id/chef)
	l_ear = /obj/item/device/radio/headset/headset_service

/decl/hierarchy/outfit/job/site90/crew/civ/bartender
	name = OUTFIT_JOB_NAME("Bartender")
	uniform = /obj/item/clothing/under/suit_jacket/tan
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/device/radio
	id_types = list(/obj/item/card/id/bartender)
	l_ear = /obj/item/device/radio/headset/headset_service

/decl/hierarchy/outfit/job/site90/crew/civ/archivist
	name = OUTFIT_JOB_NAME("Archivist")
	uniform = /obj/item/clothing/under/suit_jacket/really_black
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/device/radio
	id_types = list(/obj/item/card/id/archivist)
	l_ear = /obj/item/device/radio/headset/headset_arch

/decl/hierarchy/outfit/job/site90/crew/civ/gocrep
	name = OUTFIT_JOB_NAME("Global Occult Coalition Representative")
	uniform = /obj/item/clothing/under/rank/head_of_security/navyblue
	suit = /obj/item/clothing/suit/security/navyhos
	head = /obj/item/clothing/head/beret/scp/goc
	shoes = /obj/item/clothing/shoes/combat
	glasses = /obj/item/clothing/glasses/sunglasses
	gloves = /obj/item/clothing/gloves/thick/combat
	l_pocket = /obj/item/device/radio
	id_types = list(/obj/item/card/id/adminlvl3)
	l_ear = /obj/item/device/radio/headset/heads/goc
	backpack_contents = list(/obj/item/ammo_magazine/scp/usp45 = 1)
	belt = /obj/item/gun/projectile/pistol/usp45

/decl/hierarchy/outfit/job/site90/crew/civ/uiu
	name = OUTFIT_JOB_NAME("Unusual Incidents Unit Relations Agent")
	uniform = /obj/item/clothing/under/suit_jacket/charcoal
	shoes = /obj/item/clothing/shoes/dress
	glasses = /obj/item/clothing/glasses/sunglasses
	gloves = /obj/item/clothing/gloves/thick/combat
	l_pocket = /obj/item/device/radio
	id_types = list(/obj/item/card/id/adminlvl3)
	l_ear = /obj/item/device/radio/headset/heads/uiu
	backpack_contents = list(/obj/item/ammo_magazine/scp/m1911 = 1)
	belt = /obj/item/gun/projectile/pistol/m1911

/decl/hierarchy/outfit/job/thirep
	name = OUTFIT_JOB_NAME("thirep")
	uniform = /obj/item/clothing/under/rank/chaplain
	l_hand = /obj/item/storage/bible
	id_types = list(/obj/item/card/id/adminlvl3)
	pda_type = /obj/item/modular_computer/pda/medical
	l_ear = /obj/item/device/radio/headset/heads/thi
	belt = /obj/item/gun/projectile/pistol/m1911
	backpack_contents = list(/obj/item/ammo_magazine/scp/m1911 = 1)

/decl/hierarchy/outfit/job/site90/crew/civ/MCDRep
	name = OUTFIT_JOB_NAME("Marshall, Carter, and Dark Corporate Liaison")
	uniform = /obj/item/clothing/under/suit_jacket/really_black
	shoes = /obj/item/clothing/shoes/laceup
	glasses = /obj/item/clothing/glasses/monocle
	l_pocket = /obj/item/device/radio
	id_types = list(/obj/item/card/id/adminlvl3)
	r_hand = /obj/item/storage/secure/briefcase/money
	l_hand = /obj/item/cane
	l_ear = /obj/item/device/radio/headset/heads/mcd
	backpack_contents = list(/obj/item/ammo_magazine/c45m = 1)
	belt = /obj/item/gun/projectile/silenced

/decl/hierarchy/outfit/job/site90/crew/civ/o5rep
	name = OUTFIT_JOB_NAME("O5 Representative")
	uniform = /obj/item/clothing/under/suit_jacket/really_black
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/device/radio
	id_types = list(/obj/item/card/id/adminlvl5)
	l_ear = /obj/item/device/radio/headset/heads/hop
	backpack_contents = list(/obj/item/ammo_magazine/scp/m1911 = 1)
	belt = /obj/item/gun/projectile/pistol/m1911

/decl/hierarchy/outfit/job/site90/crew/civ/tribunal
	name = OUTFIT_JOB_NAME("Tribunal Officer")
	uniform = /obj/item/clothing/under/lawyer/black
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/device/radio
	id_types = list(/obj/item/card/id/adminlvl5)
	l_ear = /obj/item/device/radio/headset/heads/hop
	backpack_contents = list(/obj/item/ammo_magazine/scp/m1911 = 1)
	belt = /obj/item/gun/projectile/pistol/m1911

// ENGINEERING STUFF
/decl/hierarchy/outfit/job/ds90/crew/engineering/juneng
	name = OUTFIT_JOB_NAME("Junior Engineer")
	uniform = /obj/item/clothing/under/solgov/utility/fleet/engineering
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl2eng)
	belt = /obj/item/storage/belt/utility/full
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_eng

/decl/hierarchy/outfit/job/ds90/crew/engineering/eng
	name = OUTFIT_JOB_NAME("Engineer")
	uniform = /obj/item/clothing/under/solgov/utility/fleet/engineering
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl3eng)
	belt = /obj/item/storage/belt/utility/full
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_eng

/decl/hierarchy/outfit/job/ds90/crew/engineering/seneng
	name = OUTFIT_JOB_NAME("Senior Engineer")
	uniform = /obj/item/clothing/under/solgov/utility/fleet/engineering
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl4eng)
	belt = /obj/item/storage/belt/utility/full
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/heads/ce

/decl/hierarchy/outfit/job/ds90/crew/engineering/conteng
	name = OUTFIT_JOB_NAME("Containment Engineer")
	uniform = /obj/item/clothing/under/solgov/utility/fleet/engineering
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl4eng)
	belt = /obj/item/storage/belt/utility/full
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/heads/ce


// BRIG OFFICER
/decl/hierarchy/outfit/job/torch/crew/security/brig_officer
	name = OUTFIT_JOB_NAME("Brig Officer")
	uniform = /obj/item/clothing/under/scp/lcz
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl2)
	l_ear = /obj/item/device/radio/headset/headset_com


// MEDICAL OUTFITS
/decl/hierarchy/outfit/job/ds90/crew/command/cmo
	name = OUTFIT_JOB_NAME("Chief Medical Officer")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/purple
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	shoes = /obj/item/clothing/shoes/white
	id_types = list(/obj/item/card/id/chiefmedicalofficer)
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/heads/cmo

/decl/hierarchy/outfit/job/ds90/medical/psychiatrist
	name = OUTFIT_JOB_NAME("Psychiatrist")
	uniform = /obj/item/clothing/under/suit_jacket/tan
	shoes = /obj/item/clothing/shoes/laceup
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	id_types = list(/obj/item/card/id/psychiatrist)
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_med

/decl/hierarchy/outfit/job/ds90/medical/chemist
	name = OUTFIT_JOB_NAME("Chemist")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/navyblue
	shoes = /obj/item/clothing/shoes/white
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	id_types = list(/obj/item/card/id/chemist)
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_med

/decl/hierarchy/outfit/job/ds90/medical/medicaldoctor
	name = OUTFIT_JOB_NAME("Medical Doctor")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/blue
	shoes = /obj/item/clothing/shoes/white
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	id_types = list(/obj/item/card/id/doctor)
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_med

/decl/hierarchy/outfit/job/ds90/medical/surgeon
	name = OUTFIT_JOB_NAME("Surgeon")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/green
	shoes = /obj/item/clothing/shoes/white
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	id_types = list(/obj/item/card/id/doctor)
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_med

/decl/hierarchy/outfit/job/ds90/medical/emt
	name = OUTFIT_JOB_NAME("Emergency Medical Technician")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/black
	shoes = /obj/item/clothing/shoes/white
	id_types = list(/obj/item/card/id/emt)
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_med


// LOGISTICS OUTFITS
/decl/hierarchy/outfit/job/site90/crew/command/logisticsofficer
	name = OUTFIT_JOB_NAME("Logistics Officer")
	uniform = /obj/item/clothing/under/solgov/utility/marine/tan
	gloves = /obj/item/clothing/gloves/thick
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/logoff)
	l_ear = /obj/item/device/radio/headset/headset_deckofficer

/decl/hierarchy/outfit/job/site90/crew/command/logisticspecialist
	name = OUTFIT_JOB_NAME("Logistics Specialist")
	uniform = /obj/item/clothing/under/solgov/utility/marine/tan
	gloves = /obj/item/clothing/gloves/thick
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/logspec)
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_cargo

// EVENT OUTFITS
/decl/hierarchy/outfit/job/site90/crew/command/event/mtfbasic
	name = OUTFIT_JOB_NAME("MTF Tactical Response Agent")
	uniform = /obj/item/clothing/under/ert
	suit = /obj/item/clothing/suit/armor/mtftactical
	head = /obj/item/clothing/head/helmet/mtftactical
	gloves = /obj/item/clothing/gloves/thick/swat
	shoes = /obj/item/clothing/shoes/swat
	id_types = list(/obj/item/card/id/mtf)
	l_ear = /obj/item/device/radio/headset/ert
	back = /obj/item/storage/backpack/satchel

/decl/hierarchy/outfit/job/site90/crew/command/event/mtf_epsilon1
	name = OUTFIT_JOB_NAME("MTF Epsilon-11 Basic")
	uniform = /obj/item/clothing/under/ert
	suit = /obj/item/clothing/suit/armor/pcarrier/green/scp/mtf_epsilon
	head = /obj/item/clothing/head/helmet/site53/guard/mtf_epsilon
	mask = /obj/item/clothing/mask/balaclava/tactical
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/jackboots
	id_types = list(/obj/item/card/id/mtf)
	suit_store = /obj/item/gun/projectile/automatic/scp/p90
	r_hand = /obj/item/crowbar/red
	l_hand = /obj/item/material/hatchet/tacknife
	l_pocket = /obj/item/grenade/flashbang
	r_pocket = /obj/item/grenade/flashbang
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/gun/projectile/silenced
	back = /obj/item/storage/backpack/rucksack
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/plastique = 2,/obj/item/grenade/frag = 1,/obj/item/ammo_magazine/scp/p90_mag/ap = 5,/obj/item/ammo_magazine/c45m = 2,/obj/item/clothing/mask/gas = 1)

/decl/hierarchy/outfit/job/site90/crew/command/event/mtf_epsilon2
	name = OUTFIT_JOB_NAME("MTF Epsilon-11 Breacher")
	uniform = /obj/item/clothing/under/ert
	suit = /obj/item/clothing/suit/armor/pcarrier/green/scp/mtf_epsilon
	head = /obj/item/clothing/head/helmet/site53/guard/mtf_epsilon
	mask = /obj/item/clothing/mask/balaclava/tactical
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/jackboots
	id_types = list(/obj/item/card/id/mtf)
	suit_store = /obj/item/gun/projectile/shotgun/pump/combat
	r_hand = /obj/item/crowbar/red
	l_hand = /obj/item/material/hatchet
	l_pocket = /obj/item/grenade/flashbang
	r_pocket = /obj/item/grenade/flashbang
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/gun/projectile/silenced
	back = /obj/item/storage/backpack/rucksack
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/grenade/frag = 2,/obj/item/ammo_magazine/shotholder/shell = 6,/obj/item/clothing/accessory/storage/bandolier = 1,/obj/item/clothing/mask/gas = 1)

/decl/hierarchy/outfit/job/site90/crew/command/event/mtf_epsilon3
	name = OUTFIT_JOB_NAME("MTF Epsilon-11 Team Leader")
	uniform = /obj/item/clothing/under/ert
	suit = /obj/item/clothing/suit/armor/pcarrier/green/scp/mtf_epsilon
	head = /obj/item/clothing/head/helmet/site53/guard/mtf_epsilon/leader
	mask = /obj/item/clothing/mask/balaclava
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/jackboots
	id_types = list(/obj/item/card/id/mtf)
	suit_store = /obj/item/gun/projectile/automatic/scp/m16
	r_hand = /obj/item/storage/box/syndie_kit/spy
	l_hand = null
	l_pocket = /obj/item/grenade/smokebomb
	r_pocket = null
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/storage/belt/holster/security/fullmateba
	back = /obj/item/storage/backpack/rucksack
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/grenade/frag = 1,/obj/item/crowbar/red = 1,/obj/item/ammo_magazine/scp/m16_mag = 3,/obj/item/ammo_magazine/c44 = 4,/obj/item/clothing/mask/gas = 1)

/decl/hierarchy/outfit/job/site90/crew/command/event/mtf_epsilon4
	name = OUTFIT_JOB_NAME("MTF Epsilon-11 Medic")
	uniform = /obj/item/clothing/under/ert
	suit = /obj/item/clothing/suit/armor/pcarrier/green/scp/mtf_epsilon
	head = /obj/item/clothing/head/helmet/site53/guard/mtf_epsilon/medic
	mask = /obj/item/clothing/mask/balaclava
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/jackboots
	id_types = list(/obj/item/card/id/mtf)
	suit_store = /obj/item/gun/projectile/automatic/scp/p90
	r_hand = /obj/item/storage/firstaid/surgery
	l_hand = /obj/item/crowbar/red
	l_pocket = /obj/item/grenade/smokebomb
	r_pocket = null
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/defibrillator/compact/combat/loaded
	back = /obj/item/storage/backpack/rucksack
	backpack_contents = list(/obj/item/ammo_magazine/scp/p90_mag/ap = 3,/obj/item/clothing/mask/gas = 1,/obj/item/reagent_containers/ivbag/blood/OMinus = 2,/obj/item/storage/pill_bottle/zoom = 1)

/decl/hierarchy/outfit/job/site90/crew/command/event/eta_soldier //See No Evil
	name = OUTFIT_JOB_NAME("MTF Eta-10 Agent Alpha")
	uniform = /obj/item/clothing/under/ert
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor/eta
	head = /obj/item/clothing/head/helmet/scp/eta
	mask = /obj/item/clothing/mask/balaclava/tactical
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/jackboots
	id_types = list(/obj/item/card/id/mtf)
	suit_store = /obj/item/gun/projectile/automatic/scp/p90
	r_hand = /obj/item/crowbar/red
	l_hand = /obj/item/material/hatchet/tacknife
	l_pocket = null
	r_pocket = /obj/item/ammo_magazine/scp
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/gun/projectile/pistol
	back = /obj/item/storage/backpack/rucksack
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/plastique = 1,/obj/item/grenade/frag = 1,/obj/item/ammo_magazine/scp/p90_mag/ap = 5,/obj/item/clothing/mask/gas = 1)

/decl/hierarchy/outfit/job/site90/crew/command/event/beta_soldier //Maz Hatters
	name = OUTFIT_JOB_NAME("MTF Beta-7 Agent Alpha")
	uniform = /obj/item/clothing/under/tactical
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor/beta
	head = /obj/item/clothing/head/helmet/scp/beta
	mask = /obj/item/clothing/mask/balaclava/tactical
	glasses = /obj/item/clothing/glasses/sunglasses
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/jackboots
	id_types = list(/obj/item/card/id/mtf)
	suit_store = /obj/item/gun/projectile/automatic/scp/p90
	r_hand = /obj/item/crowbar/red
	l_hand = /obj/item/material/hatchet/tacknife
	l_pocket = null
	r_pocket = /obj/item/ammo_magazine/scp
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/gun/projectile/pistol
	back = /obj/item/storage/backpack/rucksack
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/plastique = 1,/obj/item/ammo_magazine/scp/p90_mag/ap = 5,/obj/item/clothing/mask/gas = 1)

/decl/hierarchy/outfit/job/site90/crew/command/event/hammerdown //Generic army MTF
	name = OUTFIT_JOB_NAME("MTF Nu-7 Soldier")
	uniform = /obj/item/clothing/under/tactical
	suit = /obj/item/clothing/suit/armor/mtfheavy
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/helmet/mtfheavy
	gloves = /obj/item/clothing/gloves/thick/combat
	glasses = /obj/item/clothing/glasses/tacgoggles
	shoes = /obj/item/clothing/shoes/combat
	id_types = list(/obj/item/card/id/mtf)
	suit_store = null
	r_hand = /obj/item/gun/projectile/automatic/scp/m16
	l_hand = null
	l_pocket = /obj/item/grenade/frag
	r_pocket = /obj/item/grenade/flashbang/clusterbang //gods must be strong
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/storage/belt/holster/security/tactical
	back = /obj/item/storage/backpack/rucksack
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/ammo_magazine/scp/m16_mag = 5, /obj/item/plastique = 2, /obj/item/grenade/frag = 1, /obj/item/crowbar/red = 1) //Actual util

/decl/hierarchy/outfit/job/site90/crew/command/event/redrighthand //if this ever sees use, an admin really wants someone dead
	name = OUTFIT_JOB_NAME("MTF Alpha-1 Operative")
	uniform = /obj/item/clothing/under/scp/alpha
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor/alpha
	mask = /obj/item/clothing/mask/gas/alpha
	head = /obj/item/clothing/head/beret/scp/alpha
	gloves = /obj/item/clothing/gloves/tactical/alpha
	glasses = /obj/item/clothing/glasses/night
	shoes = /obj/item/clothing/shoes/combat
	id_types = list(/obj/item/card/id/mtf)
	suit_store = null
	r_hand = /obj/item/gun/projectile/automatic/t12
	l_hand = null
	l_pocket = /obj/item/grenade/frag
	r_pocket = /obj/item/grenade/flashbang/clusterbang //gods must be strong
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/storage/belt/holster/security/tactical
	back = /obj/item/storage/backpack/rucksack
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/ammo_magazine/t12 = 5, /obj/item/plastique = 2, /obj/item/grenade/frag = 5, /obj/item/crowbar/red = 1) //Breach and clear.

/decl/hierarchy/outfit/job/site90/crew/command/event/chaos_soldier
	name = OUTFIT_JOB_NAME("Chaos Insurgency Soldier")
	uniform = /obj/item/clothing/under/scp/utility/chaos
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor/chaos
	head = /obj/item/clothing/head/helmet/scp/chaos
	mask = /obj/item/clothing/mask/balaclava/tactical
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = null
	suit_store = /obj/item/gun/projectile/automatic/scp/ak47
	r_hand = null
	l_hand = /obj/item/material/hatchet/tacknife
	l_pocket = /obj/item/grenade/frag
	r_pocket = /obj/item/card/emag
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/gun/projectile/automatic/machine_pistol
	back = /obj/item/storage/backpack/rucksack/tan
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/clothing/mask/gas = 1,/obj/item/ammo_magazine/scp/ak = 3,/obj/item/ammo_magazine/c45uzi = 2,/obj/item/grenade/smokebomb = 1)

/decl/hierarchy/outfit/job/site90/crew/command/event/chaos_soldier_alt
	name = OUTFIT_JOB_NAME("Chaos Insurgency Heavy Soldier")
	uniform = /obj/item/clothing/under/scp/utility/chaos
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor/chaos
	head = /obj/item/clothing/head/helmet/scp/chaos
	mask = /obj/item/clothing/mask/balaclava/tactical
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = null
	suit_store = /obj/item/gun/projectile/automatic/scp/rpk
	r_hand = null
	l_hand = /obj/item/material/hatchet/tacknife
	l_pocket = /obj/item/grenade/frag
	r_pocket = /obj/item/card/emag
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/gun/projectile/shotgun/doublebarrel/sawn
	back = /obj/item/storage/backpack/rucksack/tan
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/ammo_magazine/scp/ak/big = 5,/obj/item/clothing/mask/gas = 1,/obj/item/grenade/frag = 1)

/decl/hierarchy/outfit/job/site90/crew/command/event/chaos_leader
	name = OUTFIT_JOB_NAME("Chaos Insurgency Squad Leader")
	uniform = /obj/item/clothing/under/scp/utility/chaos
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor/chaos
	head = /obj/item/clothing/head/beret/solgov/fleet/security
	mask = /obj/item/clothing/mask/balaclava/tactical
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = null
	suit_store = /obj/item/gun/projectile/revolver/mateba
	r_hand = null
	l_hand = /obj/item/material/hatchet/tacknife
	l_pocket = /obj/item/grenade/frag
	r_pocket = /obj/item/card/emag
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/material/sword/katana
	back = /obj/item/storage/backpack/rucksack/tan
	backpack_contents = list(/obj/item/storage/box/ifak = 1, /obj/item/grenade/smokebomb = 3)

/decl/hierarchy/outfit/job/site90/crew/command/event/ungoc
	name = OUTFIT_JOB_NAME("UNGOC PHYSICS Trooper")
	uniform = /obj/item/clothing/head/solgov/utility/marine/urban
	suit = /obj/item/clothing/suit/armor/goc
	head = /obj/item/clothing/head/helmet/scp/goc
	mask = /obj/item/clothing/mask/gas
	glasses = null
	gloves = /obj/item/clothing/gloves/thick/combat
	shoes = /obj/item/clothing/shoes/combat
	id_types = list(/obj/item/card/id/physics)
	suit_store = null
	r_hand = /obj/item/gun/projectile/automatic/scp/fnfal
	l_hand = /obj/item/grenade/frag
	l_pocket = /obj/item/ammo_magazine/scp
	r_pocket = /obj/item/card/emag
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/storage/belt/holster/security/fullmilpistol
	back = /obj/item/storage/backpack/rucksack/blue
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/storage/box/handcuffs = 1,/obj/item/ammo_magazine/scp/fnfal=6)

/decl/hierarchy/outfit/job/site90/crew/command/event/ungoc/gunner
	name = OUTFIT_JOB_NAME("UNGOC PHYSICS Machinegunner") //I am heavy weapons guy
	uniform = /obj/item/clothing/head/solgov/utility/marine/urban
	suit = /obj/item/clothing/suit/armor/goc
	head = /obj/item/clothing/head/helmet/scp/goc
	mask = /obj/item/clothing/mask/gas/half
	glasses = /obj/item/clothing/glasses/tacgoggles
	gloves = /obj/item/clothing/gloves/thick/combat
	shoes = /obj/item/clothing/shoes/combat
	id_types = list(/obj/item/card/id/physics)
	suit_store = null
	r_hand = /obj/item/gun/projectile/automatic/l6_saw //and THIS... is my weapon
	l_hand = null
	l_pocket = /obj/item/grenade/frag
	r_pocket = /obj/item/card/emag
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/storage/belt/holster/security/fullmilpistol
	back = /obj/item/storage/backpack/rucksack/blue
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/storage/box/handcuffs = 1, /obj/item/ammo_magazine/box/machinegun = 4)

/decl/hierarchy/outfit/job/site90/crew/command/event/ungoc/grenadier
	name = OUTFIT_JOB_NAME("UNGOC PHYSICS Grenadier")
	uniform = /obj/item/clothing/head/solgov/utility/marine/urban
	suit = /obj/item/clothing/suit/armor/goc
	head = /obj/item/clothing/head/helmet/scp/goc
	mask = /obj/item/clothing/mask/gas/half
	glasses = /obj/item/clothing/glasses/tacgoggles
	gloves = /obj/item/clothing/gloves/thick/combat
	shoes = /obj/item/clothing/shoes/combat
	id_types = list(/obj/item/card/id/physics)
	suit_store = null
	r_hand = /obj/item/gun/launcher/grenade/thumper // LEEEET'S DO IIIT
	l_hand = /obj/item/material/hatchet/tacknife
	l_pocket = /obj/item/plastique
	r_pocket = /obj/item/card/emag
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/storage/belt/holster/security/fullmilpistol
	back = /obj/item/storage/backpack/rucksack/blue
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/storage/box/fragshells = 5,/obj/item/clothing/accessory/storage/bandolier = 1)

/decl/hierarchy/outfit/job/site90/crew/command/event/ungoc/leader
	name = OUTFIT_JOB_NAME("UNGOC PHYSICS Team Leader")
	uniform = /obj/item/clothing/head/solgov/utility/marine/urban
	suit = /obj/item/clothing/suit/armor/goc
	mask = /obj/item/clothing/mask/gas/half
	head = /obj/item/clothing/head/helmet/scp/goc
	gloves = /obj/item/clothing/gloves/thick/combat
	glasses = /obj/item/clothing/glasses/tacgoggles
	shoes = /obj/item/clothing/shoes/combat
	id_types = list(/obj/item/card/id/physics)
	suit_store = null
	r_hand = /obj/item/gun/projectile/automatic/scp/ak742
	l_hand = /obj/item/material/hatchet/tacknife
	l_pocket = /obj/item/grenade/frag
	r_pocket = /obj/item/card/emag
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/storage/belt/holster/security/fullmilpistol
	back = /obj/item/storage/backpack/rucksack/blue
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/storage/box/handcuffs = 1,/obj/item/ammo_magazine/scp/ak/big = 3)

// FULLY GEARED (for zombies)

/decl/hierarchy/outfit/job/site90/crew/security/lczguard/geared
	name = OUTFIT_JOB_NAME("Junior Guard")
	uniform = /obj/item/clothing/under/scp/lcz
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor
	head = /obj/item/clothing/head/helmet/scp/security
	shoes = /obj/item/clothing/shoes/dutyboots
	belt = /obj/item/storage/belt/holster/security/tactical
	id_types = list(/obj/item/card/id/junseclvl2lcz)
	l_pocket = /obj/item/device/radio
	r_pocket = /obj/item/ammo_magazine/scp/p90_mag
	suit_store = /obj/item/gun/projectile/automatic/scp/p90
	l_hand = null
	r_hand = null

/decl/hierarchy/outfit/job/site90/crew/science/juniorscientist/geared
	name = OUTFIT_JOB_NAME("Scientist Associate")
	uniform = /obj/item/clothing/under/lawyer/bluesuit
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	shoes = /obj/item/clothing/shoes/laceup
	id_types = list(/obj/item/card/id/sciencelvl1)
	gloves = /obj/item/clothing/gloves/latex
	l_ear = /obj/item/device/radio/headset/headset_sci
	l_hand = null
	r_hand = null

/decl/hierarchy/outfit/job/site90/crew/science/scientist/geared
	name = OUTFIT_JOB_NAME("Scientist")
	uniform = /obj/item/clothing/under/lawyer/bluesuit
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/genetics
	shoes = /obj/item/clothing/shoes/laceup
	id_types = list(/obj/item/card/id/sciencelvl2)
	gloves = /obj/item/clothing/gloves/latex
	l_ear = /obj/item/device/radio/headset/headset_sci
	l_hand = null
	r_hand = null

/decl/hierarchy/outfit/job/ds90/medical/medicaldoctor/geared
	name = OUTFIT_JOB_NAME("Medical Doctor")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/blue
	shoes = /obj/item/clothing/shoes/white
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	id_types = list(/obj/item/card/id/doctor)
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_med
	l_hand = null
	r_hand = null

/decl/hierarchy/outfit/job/site90/crew/civ/classd/geared
	name = OUTFIT_JOB_NAME("Class D")
	uniform = /obj/item/clothing/under/scp/dclass
	shoes = /obj/item/clothing/shoes/workboots
	id_types = list(/obj/item/card/id/classd)
	l_ear = null
	l_hand = null
	r_hand = null


/decl/hierarchy/outfit/job/site90/crew/civ/officeworker
	name = OUTFIT_JOB_NAME("Office Worker")
	uniform = /obj/item/clothing/under/scp/suittie
	shoes = /obj/item/clothing/shoes/laceup
	id_types = list(/obj/item/card/id/officeworker)
	backpack_contents = list(/obj/item/paper_bin = 1,/obj/item/device/radio =1,/obj/item/pen = 1)
	l_ear = /obj/item/device/radio/headset/headset_service
	r_ear = /obj/item/pen
	l_pocket = /obj/item/material/clipboard
	r_pocket = /obj/item/folder
	l_hand = null
	r_hand = null

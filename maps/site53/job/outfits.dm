//Job Outfits


//SITE DS90 OUTFITS
//Keeping them simple for now, just spawning with basic uniforms, and pretty much no gear. Gear instead goes in lockers. Keep this in mind if editing.


// SCP COMMAND OUTFITS
/decl/hierarchy/outfit/job/site90/crew/command/facilitydir
	name = OUTFIT_JOB_NAME("Facility Director")
	uniform = /obj/item/clothing/under/scp/suittie
	shoes = /obj/item/clothing/shoes/dress
	suit = /obj/item/clothing/suit/storage/toggle/suit/black
	id_types = list(/obj/item/card/id/adminlvl5)
	l_ear = /obj/item/device/radio/headset/heads/captain
	back = /obj/item/storage/backpack/satchel/pocketbook
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
	back = /obj/item/storage/backpack/satchel/pocketbook

/decl/hierarchy/outfit/job/site90/crew/command/commsofficer
	name = OUTFIT_JOB_NAME("Communications Officer")
	uniform = /obj/item/clothing/under/scp/utility/communications/officer
	gloves = /obj/item/clothing/gloves/foundation_service
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/commslvl4)
	l_ear = /obj/item/device/radio/headset/heads/commsofficer
	back = /obj/item/storage/backpack/satchel/pocketbook




// END OF COMMAND OUTFITS
/decl/hierarchy/outfit/job/site90/crew/command/commstech
	name = OUTFIT_JOB_NAME("Communications Technician")
	uniform = /obj/item/clothing/under/scp/utility/communications/tech
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/commslvl1)
	belt = /obj/item/storage/belt/utility/full
	l_ear = /obj/item/device/radio/headset/commsdispatcher
	back = /obj/item/storage/backpack/satchel/pocketbook


/decl/hierarchy/outfit/job/ds90/crew/command/chief_engineer
	name = OUTFIT_JOB_NAME("Chief Engineer")
	uniform = /obj/item/clothing/under/scp/utility/engineering
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl5eng)
	belt = /obj/item/storage/belt/utility/full
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/heads/ce
	back = /obj/item/storage/backpack/industrial


// Cell Guards
/* CANDIDATE FOR REMOVAL.
/decl/hierarchy/outfit/job/site90/crew/security/cellguardlieutenant
	name = OUTFIT_JOB_NAME("Cell Warden")
	uniform = /obj/item/clothing/under/rank/security2
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl4
	l_ear = /obj/item/device/radio/headset/heads/cw
	back = null

/decl/hierarchy/outfit/job/site90/crew/security/brigofficer
	name = OUTFIT_JOB_NAME("Cell Guard")
	uniform = /obj/item/clothing/under/rank/security2
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl2
	l_ear = /obj/item/device/radio/headset/headset_sec
	l_pocket = /obj/item/book/manual/scp/secsop
	back = null
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
	back = /obj/item/storage/backpack/satchel/leather/black
	backpack_contents = list(/obj/item/clothing/head/helmet/scp/hczsecurityofficer = 1)
	belt = /obj/item/storage/belt/holster/security/fullmateba
	glasses = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	head = /obj/item/clothing/head/beret/solgov/marcom
	mask = /obj/item/clothing/mask/balaclava



// ZONE COMMANDER OUTFITS.
/decl/hierarchy/outfit/job/site90/crew/security/ltofficerhcz
	name = OUTFIT_JOB_NAME("HCZ Zone Commander")
	uniform = /obj/item/clothing/under/scpguardarmband
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/zcseclvl4hcz)
	l_ear = /obj/item/device/radio/headset/heads/cos
	suit = /obj/item/clothing/suit/armor/pcarrier/scp/tactical
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	back = /obj/item/storage/backpack/satchel/leather/black
	backpack_contents = list(/obj/item/clothing/head/beret/sec = 1)
	belt = /obj/item/storage/belt/holster/security/fullmk9
	glasses = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	head = /obj/item/clothing/head/helmet/scp/hczsecurityofficer
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/tactical/scp


/decl/hierarchy/outfit/job/site90/crew/security/ltofficerlcz
	name = OUTFIT_JOB_NAME("LCZ Zone Commander")
	flags = OUTFIT_RESET_EQUIPMENT
	uniform = /obj/item/clothing/under/scp/lczwhiteuniformarmband
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/zcseclvl3lcz)
	l_ear = /obj/item/device/radio/headset/heads/cos
	suit = /obj/item/clothing/suit/armor/vest/scp/russcom
	shoes = /obj/item/clothing/shoes/dutyboots
	l_pocket = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	r_pocket = /obj/item/melee/telebaton
	back = /obj/item/storage/backpack/satchel/leather/black
	backpack_contents = list(/obj/item/clothing/head/beret/sec/corporate/hos = 1, /obj/item/handcuffs = 1)
	belt = /obj/item/storage/belt/holster/security/fullmk9
	head = /obj/item/clothing/head/helmet/scp/security
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/tactical/scp

/decl/hierarchy/outfit/job/site90/crew/security/ltofficerez
	name = OUTFIT_JOB_NAME("EZ Senior Agent")
	uniform = /obj/item/clothing/under/rank/head_of_security/corp
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/zcseclvl4ez)
	l_ear = /obj/item/device/radio/headset/heads/cos
	suit = /obj/item/clothing/suit/armor/pcarrier/scp/medium
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	back = /obj/item/storage/backpack/satchel/leather/black
	backpack_contents = list(/obj/item/clothing/head/helmet/scp/hczsecurityofficer = 1)
	belt = /obj/item/storage/belt/holster/security/fullmk9
	glasses = /obj/item/clothing/glasses/eyepatch/hud/security
	head = /obj/item/clothing/head/beret/sec/corporate/hos
	mask = /obj/item/clothing/mask/balaclava


// GUARD OUTFITS
/decl/hierarchy/outfit/job/site90/crew/security/ncoofficerlcz
	name = OUTFIT_JOB_NAME("LCZ Guard")
	flags = OUTFIT_RESET_EQUIPMENT
	uniform = /obj/item/clothing/under/lczwhitejunioruniformarmband
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl3lcz)
	l_ear = /obj/item/device/radio/headset/headset_sec_lcz
	l_pocket = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	r_pocket = /obj/item/melee/telebaton
	back = /obj/item/storage/backpack/satchel/leather/black
	backpack_contents = list(/obj/item/clothing/head/beret/sec/corporate/warden = 1, /obj/item/handcuffs = 1)
	belt = /obj/item/storage/belt/holster/security/fullmk9
	glasses = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	head = /obj/item/clothing/head/helmet/scp/security
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/tactical/scp


/decl/hierarchy/outfit/job/site90/crew/security/ncoofficerhcz
	name = OUTFIT_JOB_NAME("HCZ Guard")
	uniform = /obj/item/clothing/under/scpguardarmband
	suit = /obj/item/clothing/suit/armor/pcarrier/scp/tactical
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl3hcz)
	l_ear = /obj/item/device/radio/headset/headset_sec_hcz
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	backpack_contents = list(/obj/item/clothing/head/beret/sec/corporate/warden = 1)
	belt = /obj/item/storage/belt/holster/security/fullmk9
	glasses = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	head = /obj/item/clothing/head/helmet/scp/hczsecurityguard
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/tactical/scp

/decl/hierarchy/outfit/job/site90/crew/security/ncoofficerez
	name = OUTFIT_JOB_NAME("EZ Agent")
	uniform = /obj/item/clothing/under/rank/warden/corp
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl3ez)
	l_ear = /obj/item/device/radio/headset/headset_sec_ecz
	l_pocket = /obj/item/book/manual/scp/secsop
	suit = /obj/item/clothing/suit/armor/pcarrier/scp/medium
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	back = /obj/item/storage/backpack/satchel/leather/black
	backpack_contents = list(/obj/item/clothing/head/helmet/scp/hczsecurityguard = 1)
	belt = /obj/item/storage/belt/holster/security/fullmk9
	glasses = /obj/item/clothing/glasses/eyepatch/hud/security
	head = /obj/item/clothing/head/beret/sec/corporate/warden
	mask = /obj/item/clothing/mask/balaclava

/decl/hierarchy/outfit/job/site90/crew/security/enlistedofficerez
	name = OUTFIT_JOB_NAME("EZ Junior Agent")
	uniform = /obj/item/clothing/under/rank/security/corp
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl3ez)
	l_ear = /obj/item/device/radio/headset/headset_sec_ecz
	l_pocket = /obj/item/book/manual/scp/secsop
	suit = /obj/item/clothing/suit/armor/pcarrier/scp/medium
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	back = /obj/item/storage/backpack/satchel/leather/black
	backpack_contents = list(/obj/item/clothing/head/helmet/scp/hczsecurityguard = 1)
	belt = /obj/item/storage/belt/holster/security/fullmk9
	glasses = /obj/item/clothing/glasses/eyepatch/hud/security
	head = /obj/item/clothing/head/beret/sec/corporate/officer
	mask = /obj/item/clothing/mask/balaclava

// JUNIOR GUARD OUTFITS
/decl/hierarchy/outfit/job/site90/crew/security/enlistedofficerlcz
	name = OUTFIT_JOB_NAME("LCZ Junior Guard")
	flags = OUTFIT_RESET_EQUIPMENT
	uniform = /obj/item/clothing/under/lczwhitejunioruniform
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/junseclvl2lcz)
	l_ear = /obj/item/device/radio/headset/headset_sec_lcz
	l_pocket = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	r_pocket = /obj/item/melee/telebaton
	back = /obj/item/storage/backpack/satchel/leather/black
	backpack_contents = list(/obj/item/clothing/head/beret/sec/corporate/officer = 1, /obj/item/handcuffs = 1)
	belt = /obj/item/storage/belt/holster/security/fullmk9
	glasses = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	head = /obj/item/clothing/head/helmet/scp/security
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/tactical/scp

/decl/hierarchy/outfit/job/site90/crew/security/enlistedofficerhcz
	name = OUTFIT_JOB_NAME("HCZ Junior Guard")
	uniform = /obj/item/clothing/under/scpguard
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/junseclvl3hcz)
	l_ear = /obj/item/device/radio/headset/headset_sec_hcz
	suit = /obj/item/clothing/suit/armor/pcarrier/scp/tactical
	l_pocket = /obj/item/handcuffs
	r_pocket = /obj/item/melee/telebaton
	back = /obj/item/storage/backpack/satchel/leather/black
	backpack_contents = list(/obj/item/clothing/head/beret/sec/corporate/officer = 1)
	belt = /obj/item/storage/belt/holster/security/fullmk9
	glasses = /obj/item/clothing/glasses/sunglasses/sechud/goggles
	head = /obj/item/clothing/head/helmet/scp/hczsecurityguard
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/tactical/scp

// SCIENCE OUTFITS
/decl/hierarchy/outfit/job/site90/crew/science/juniorscientist
	name = OUTFIT_JOB_NAME("Scientist Associate")
	uniform = /obj/item/clothing/under/scp/suittie
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	shoes = /obj/item/clothing/shoes/laceup
	id_types = list(/obj/item/card/id/sciencelvl1)
	gloves = /obj/item/clothing/gloves/latex
	l_ear = /obj/item/device/radio/headset/headset_sci
	back = /obj/item/storage/backpack/satchel

/decl/hierarchy/outfit/job/site90/crew/science/scientist
	name = OUTFIT_JOB_NAME("Scientist")
	uniform = /obj/item/clothing/under/scp/suittie
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/genetics
	shoes = /obj/item/clothing/shoes/laceup
	id_types = list(/obj/item/card/id/sciencelvl2)
	gloves = /obj/item/clothing/gloves/latex
	l_ear = /obj/item/device/radio/headset/headset_sci
	l_pocket = /obj/item/book/manual/scp/scisop

/decl/hierarchy/outfit/job/site90/crew/science/seniorscientist
	name = OUTFIT_JOB_NAME("Senior Scientist")
	uniform = /obj/item/clothing/under/scp/suittie
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/science
	shoes = /obj/item/clothing/shoes/laceup
	id_types = list(/obj/item/card/id/sciencelvl4)
	gloves = /obj/item/clothing/gloves/latex/nitrile
	l_pocket = /obj/item/book/manual/scp/scisop
	l_ear = /obj/item/device/radio/headset/headset_sci
	back = /obj/item/storage/backpack/satchel/pocketbook

/decl/hierarchy/outfit/job/site90/crew/science/researchdirector
	name = OUTFIT_JOB_NAME("Research Director")
	uniform = /obj/item/clothing/under/scp/suittie
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/rd
	shoes = /obj/item/clothing/shoes/laceup
	id_types = list(/obj/item/card/id/sciencelvl5)
	gloves = /obj/item/clothing/gloves/latex/nitrile
	l_ear = /obj/item/device/radio/headset/heads/rd
	l_pocket = /obj/item/book/manual/scp/scisop
	back = /obj/item/storage/backpack/satchel/pocketbook

/decl/hierarchy/outfit/job/site90/crew/science/thaumaturge
	name = OUTFIT_JOB_NAME("Thaumaturge")
	uniform = /obj/item/clothing/under/scp/suittie
	suit = /obj/item/clothing/suit/wizrobe
	shoes = /obj/item/clothing/shoes/laceup
	id_types = list(/obj/item/card/id/sciencelvl4)
	l_pocket = /obj/item/book/manual/scp/scisop
	l_ear = /obj/item/device/radio/headset/headset_sci
	backpack_contents = list(/obj/item/spellbook/student = 1)



// MISC OUTFITS
/decl/hierarchy/outfit/job/site90/crew/civ/classd
	name = OUTFIT_JOB_NAME("Class D")
	uniform = /obj/item/clothing/under/scp/dclass
	shoes = /obj/item/clothing/shoes/workboots
	l_ear = null
	back = null
	l_pocket = /obj/item/paper/dclass_orientation
	id_types = list(/obj/item/card/id/classd)

/decl/hierarchy/outfit/job/site90/crew/civ/classd/post_equip(var/mob/living/carbon/human/H)
	..()
	if(prob(15))
		var/path = pick( /obj/item/wrench, /obj/item/screwdriver)
		H.equip_to_slot_or_del(new path (H), slot_l_store)

/decl/hierarchy/outfit/job/site90/crew/civ/janitor
	name = OUTFIT_JOB_NAME("Janitor")
	uniform = /obj/item/clothing/under/rank/janitor
	shoes = /obj/item/clothing/shoes/workboots
	l_pocket = /obj/item/device/radio
	id_types = list(/obj/item/card/id/sciencelvl1)
	back = /obj/item/storage/backpack/satchel
	l_ear = /obj/item/device/radio/headset/headset_service

/decl/hierarchy/outfit/job/site90/crew/civ/chef
	name = OUTFIT_JOB_NAME("Chef")
	uniform = /obj/item/clothing/under/color/white
	shoes = /obj/item/clothing/shoes/white
	l_pocket = /obj/item/device/radio
	id_types = list(/obj/item/card/id/chef)
	back = /obj/item/storage/backpack/satchel
	l_ear = /obj/item/device/radio/headset/headset_service

/decl/hierarchy/outfit/job/site90/crew/civ/bartender
	name = OUTFIT_JOB_NAME("Bartender")
	uniform = /obj/item/clothing/under/suit_jacket/tan
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/device/radio
	id_types = list(/obj/item/card/id/bartender)
	l_ear = /obj/item/device/radio/headset/headset_service
	back = /obj/item/storage/backpack/satchel/pocketbook

/decl/hierarchy/outfit/job/site90/crew/civ/archivist
	name = OUTFIT_JOB_NAME("Archivist")
	uniform = /obj/item/clothing/under/suit_jacket/really_black
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/device/radio
	id_types = list(/obj/item/card/id/archivist)
	back = /obj/item/storage/backpack/satchel
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
	l_ear = /obj/item/device/radio/headset/heads/hos/goc
	back = /obj/item/storage/backpack/satchel/pocketbook
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
	l_ear = /obj/item/device/radio/headset/heads/hos/uiu
	back = /obj/item/storage/backpack/satchel/pocketbook
	backpack_contents = list(/obj/item/ammo_magazine/scp/m1911 = 1)
	belt = /obj/item/gun/projectile/pistol/m1911

/decl/hierarchy/outfit/job/site90/crew/civ/o5rep
	name = OUTFIT_JOB_NAME("O5 Representative")
	uniform = /obj/item/clothing/under/suit_jacket/really_black
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/device/radio
	id_types = list(/obj/item/card/id/adminlvl5)
	l_ear = /obj/item/device/radio/headset/heads/hop
	back = /obj/item/storage/backpack/satchel/pocketbook
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
	back = /obj/item/storage/backpack/industrial

/decl/hierarchy/outfit/job/ds90/crew/engineering/conteng
	name = OUTFIT_JOB_NAME("Containment Engineer")
	uniform = /obj/item/clothing/under/solgov/utility/fleet/engineering
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl4eng)
	belt = /obj/item/storage/belt/utility/full
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/heads/ce
	back = /obj/item/storage/backpack/industrial


// BRIG OFFICER
/decl/hierarchy/outfit/job/torch/crew/security/brig_officer
	name = OUTFIT_JOB_NAME("Brig Officer")
	uniform = /obj/item/clothing/under/scp/whiteuniform
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl2)
	l_ear = /obj/item/device/radio/headset/headset_com
	back = /obj/item/storage/backpack/satchel/


// MEDICAL OUTFITS
/decl/hierarchy/outfit/job/ds90/crew/command/cmo
	name = OUTFIT_JOB_NAME("Chief Medical Officer")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/purple
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	shoes = /obj/item/clothing/shoes/white
	id_types = list(/obj/item/card/id/chiefmedicalofficer)
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/heads/cmo
	back = /obj/item/storage/backpack/medic

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
	back = /obj/item/storage/backpack/medic

/decl/hierarchy/outfit/job/ds90/medical/medicaldoctor
	name = OUTFIT_JOB_NAME("Medical Doctor")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/blue
	shoes = /obj/item/clothing/shoes/white
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	id_types = list(/obj/item/card/id/doctor)
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_med
	back = /obj/item/storage/backpack/medic

/decl/hierarchy/outfit/job/ds90/medical/virologist
	name = OUTFIT_JOB_NAME("Virologist")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/teal
	shoes = /obj/item/clothing/shoes/white
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	id_types = list(/obj/item/card/id/virologist)
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_med
	back = /obj/item/storage/backpack/medic

/decl/hierarchy/outfit/job/ds90/medical/surgeon
	name = OUTFIT_JOB_NAME("Surgeon")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/green
	shoes = /obj/item/clothing/shoes/white
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	id_types = list(/obj/item/card/id/doctor)
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_med
	back = /obj/item/storage/backpack/satchel/pocketbook

/decl/hierarchy/outfit/job/ds90/medical/emt
	name = OUTFIT_JOB_NAME("Emergency Medical Technician")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/black
	shoes = /obj/item/clothing/shoes/white
	id_types = list(/obj/item/card/id/emt)
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_med
	back = /obj/item/storage/backpack/medic


// LOGISTICS OUTFITS
/decl/hierarchy/outfit/job/site90/crew/command/logisticsofficer
	name = OUTFIT_JOB_NAME("Logistics Officer")
	uniform = /obj/item/clothing/under/scp/utility/logistics/officer
	gloves = /obj/item/clothing/gloves/thick
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/logoff)
	l_ear = /obj/item/device/radio/headset/headset_deckofficer
	back = /obj/item/storage/backpack/satchel/pocketbook

/decl/hierarchy/outfit/job/site90/crew/command/logisticspecialist
	name = OUTFIT_JOB_NAME("Logistics Specialist")
	uniform = /obj/item/clothing/under/scp/utility/logistics
	gloves = /obj/item/clothing/gloves/thick
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/logspec)
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_cargo
	back = /obj/item/storage/backpack/satchel/pocketbook

/decl/hierarchy/outfit/job/site90/crew/command/event/mtf_epsilon1
	name = OUTFIT_JOB_NAME("MTF Epsilon-6 Agent Alpha")
	uniform = /obj/item/clothing/under/frontier
	suit = /obj/item/clothing/suit/armor/pcarrier/green/scp/mtf_epsilon
	head = /obj/item/clothing/head/helmet/site53/guard/mtf_epsilon
	mask = /obj/item/clothing/mask/balaclava/tactical
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/jackboots
	id_types = list(/obj/item/card/id/adminlvl5)
	suit_store = /obj/item/gun/projectile/automatic/scp/p90
	r_hand = /obj/item/crowbar/red
	l_hand = /obj/item/material/hatchet/tacknife
	l_pocket = /obj/item/grenade/flashbang
	r_pocket = /obj/item/grenade/flashbang
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/gun/projectile/silenced
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/plastique = 2,/obj/item/grenade/frag = 1,/obj/item/ammo_magazine/scp/p90_mag/ap = 5,/obj/item/ammo_magazine/c45m = 2,/obj/item/clothing/mask/gas = 1)

/decl/hierarchy/outfit/job/site90/crew/command/event/mtf_epsilon2
	name = OUTFIT_JOB_NAME("MTF Epsilon-6 Agent Bravo")
	uniform = /obj/item/clothing/under/det/grey
	suit = /obj/item/clothing/suit/armor/pcarrier/green/scp/mtf_epsilon
	head = /obj/item/clothing/head/helmet/site53/guard/mtf_epsilon
	mask = /obj/item/clothing/mask/balaclava/tactical
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/jackboots
	id_types = list(/obj/item/card/id/adminlvl5)
	suit_store = /obj/item/gun/projectile/shotgun/pump/combat
	r_hand = /obj/item/crowbar/red
	l_hand = /obj/item/material/hatchet
	l_pocket = /obj/item/grenade/flashbang
	r_pocket = /obj/item/grenade/flashbang
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/gun/projectile/silenced
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/grenade/frag = 2,/obj/item/ammo_magazine/c45m = 2,/obj/item/clothing/accessory/storage/bandolier = 1,/obj/item/clothing/mask/gas = 1)

/decl/hierarchy/outfit/job/site90/crew/command/event/mtf_epsilon3
	name = OUTFIT_JOB_NAME("MTF Epsilon-6 Agent Charlie")
	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/armor/pcarrier/green/scp/mtf_epsilon
	head = /obj/item/clothing/head/helmet/site53/guard/mtf_epsilon/leader
	mask = /obj/item/clothing/mask/balaclava
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/jackboots
	id_types = list(/obj/item/card/id/adminlvl5)
	suit_store = /obj/item/gun/projectile/automatic/scp/m16
	r_hand = /obj/item/storage/box/syndie_kit/spy
	l_hand = null
	l_pocket = /obj/item/grenade/smokebomb
	r_pocket = null
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/gun/projectile/revolver/webley/captain
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/grenade/frag = 1,/obj/item/crowbar/red = 1,/obj/item/ammo_magazine/scp/m16_mag = 3,/obj/item/ammo_magazine/c44 = 4,/obj/item/clothing/mask/gas = 1)

/decl/hierarchy/outfit/job/site90/crew/command/event/mtf_epsilon4
	name = OUTFIT_JOB_NAME("MTF Epsilon-6 Agent Delta")
	uniform = /obj/item/clothing/under/rank/psych/turtleneck/sweater
	suit = /obj/item/clothing/suit/armor/pcarrier/green/scp/mtf_epsilon
	head = /obj/item/clothing/head/helmet/site53/guard/mtf_epsilon/medic
	mask = /obj/item/clothing/mask/balaclava
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/jackboots
	id_types = list(/obj/item/card/id/adminlvl5)
	suit_store = /obj/item/gun/projectile/automatic/scp/p90
	r_hand = /obj/item/storage/firstaid/surgery
	l_hand = /obj/item/crowbar/red
	l_pocket = /obj/item/grenade/smokebomb
	r_pocket = null
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/defibrillator/compact/combat/loaded
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/ammo_magazine/scp/p90_mag/ap = 3,/obj/item/clothing/mask/gas = 1,/obj/item/reagent_containers/ivbag/blood/OMinus = 2,/obj/item/storage/pill_bottle/zoom = 1)

/decl/hierarchy/outfit/job/site90/crew/command/event/eta_soldier //See No Evil
	name = OUTFIT_JOB_NAME("MTF Eta-10 Agent Alpha")
	uniform = /obj/item/clothing/under/frontier
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor/eta
	head = /obj/item/clothing/head/helmet/scp/eta
	mask = /obj/item/clothing/mask/balaclava/tactical
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/jackboots
	id_types = list(/obj/item/card/id/adminlvl5)
	suit_store = /obj/item/gun/projectile/automatic/scp/p90
	r_hand = /obj/item/crowbar/red
	l_hand = /obj/item/material/hatchet/tacknife
	l_pocket = null
	r_pocket = /obj/item/ammo_magazine/scp
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/gun/projectile/pistol
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/plastique = 1,/obj/item/grenade/frag = 1,/obj/item/ammo_magazine/scp/p90_mag/ap = 5,/obj/item/clothing/mask/gas = 1)

/decl/hierarchy/outfit/job/site90/crew/command/event/beta_soldier //Maz Hatters
	name = OUTFIT_JOB_NAME("MTF Beta-7 Agent Alpha")
	uniform = /obj/item/clothing/under/frontier
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor/beta
	head = /obj/item/clothing/head/helmet/scp/beta
	mask = /obj/item/clothing/mask/balaclava/tactical
	glasses = /obj/item/clothing/glasses/sunglasses
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/jackboots
	id_types = list(/obj/item/card/id/adminlvl5)
	suit_store = /obj/item/gun/projectile/automatic/scp/p90
	r_hand = /obj/item/crowbar/red
	l_hand = /obj/item/material/hatchet/tacknife
	l_pocket = null
	r_pocket = /obj/item/ammo_magazine/scp
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/gun/projectile/pistol
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/plastique = 1,/obj/item/ammo_magazine/scp/p90_mag/ap = 5,/obj/item/clothing/mask/gas = 1)

/decl/hierarchy/outfit/job/site90/crew/command/event/chaos_soldier
	name = OUTFIT_JOB_NAME("Chaos Insurgency Soldier")
	uniform = /obj/item/clothing/under/scp/utility/chaos
//	suit = /obj/item/clothing/suit/armor/vest/scp/medarmorchaos -- armor doesnt exist
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
	back = /obj/item/storage/backpack/rucksack/green
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/clothing/mask/gas = 1,/obj/item/ammo_magazine/scp/ak = 3,/obj/item/ammo_magazine/c45uzi = 2,/obj/item/grenade/smokebomb = 1)

/decl/hierarchy/outfit/job/site90/crew/command/event/chaos_soldier_alt
	name = OUTFIT_JOB_NAME("Chaos Insurgency Heavy Soldier")
	uniform = /obj/item/clothing/under/scp/utility/chaos
//	suit = /obj/item/clothing/suit/armor/vest/scp/medarmorchaos
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
	back = /obj/item/storage/backpack/rucksack/green
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/ammo_magazine/scp/ak/big = 5,/obj/item/clothing/mask/gas = 1,/obj/item/grenade/frag = 1)

/decl/hierarchy/outfit/job/site90/crew/command/event/chaos_leader
	name = OUTFIT_JOB_NAME("Chaos Insurgency Squad Leader")
	uniform = /obj/item/clothing/under/scp/utility/chaos
//	suit = /obj/item/clothing/suit/armor/vest/scp/medarmorchaos
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
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/storage/box/ifak = 1, /obj/item/grenade/smokebomb = 3)

/decl/hierarchy/outfit/job/site90/crew/command/event/ungoc
	name = OUTFIT_JOB_NAME("UNGOC PHYSICS Trooper")
	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/storage/vest
	head = /obj/item/clothing/head/helmet/merc
	mask = /obj/item/clothing/mask/gas
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/thick/combat
	shoes = /obj/item/clothing/shoes/combat
	id_types = list(/obj/item/card/id/adminlvl4)
	suit_store = /obj/item/gun/projectile/automatic/scp/ak74
	r_hand = null
	l_hand = /obj/item/grenade/frag
	l_pocket = /obj/item/ammo_magazine/scp
	r_pocket = /obj/item/card/emag
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/gun/energy/stunrevolver/rifle
	back = /obj/item/storage/backpack/rucksack
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/storage/box/handcuffs = 1,/obj/item/ammo_magazine/scp/ak = 5,/obj/item/clothing/accessory/ubac/green = 1,/obj/item/clothing/accessory/armor/helmcover/blue/sol = 1)

/decl/hierarchy/outfit/job/site90/crew/command/event/ungoc/gunner
	name = OUTFIT_JOB_NAME("UNGOC PHYSICS Machinegunner")
	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/storage/vest
	head = /obj/item/clothing/head/helmet/merc
	mask = /obj/item/clothing/mask/gas
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/thick/combat
	shoes = /obj/item/clothing/shoes/combat
	id_types = list(/obj/item/card/id/adminlvl4)
	suit_store = /obj/item/gun/projectile/automatic/l6_saw
	r_hand = /obj/item/ammo_magazine/box/a556
	l_hand = /obj/item/ammo_magazine/box/a556
	l_pocket = /obj/item/grenade/frag
	r_pocket = /obj/item/card/emag
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/gun/energy/stunrevolver/rifle
	back = /obj/item/storage/backpack/rucksack
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/storage/box/handcuffs = 1,/obj/item/ammo_magazine/box/machinegun = 5,/obj/item/clothing/accessory/ubac/green = 1,/obj/item/clothing/accessory/armor/helmcover/blue/sol = 1)

/decl/hierarchy/outfit/job/site90/crew/command/event/ungoc/grenadier
	name = OUTFIT_JOB_NAME("UNGOC PHYSICS Grenadier")
	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/storage/vest
	head = /obj/item/clothing/head/helmet/merc
	mask = /obj/item/clothing/mask/gas
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/thick/combat
	shoes = /obj/item/clothing/shoes/combat
	id_types = list(/obj/item/card/id/adminlvl4)
	suit_store = /obj/item/gun/launcher/grenade // LEEEET'S DO IIIT
	r_hand = /obj/item/clothing/accessory/storage/bandolier
	l_hand = /obj/item/material/hatchet/tacknife
	l_pocket = /obj/item/plastique
	r_pocket = /obj/item/card/emag
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/storage/belt/holster/security/tactical
	back = /obj/item/storage/backpack/rucksack
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/storage/box/fragshells = 6,/obj/item/clothing/accessory/ubac/green = 1,/obj/item/clothing/accessory/armor/helmcover/blue/sol = 1)

/decl/hierarchy/outfit/job/site90/crew/command/event/ungoc/leader
	name = OUTFIT_JOB_NAME("UNGOC PHYSICS Team Leader")
	suit = /obj/item/clothing/suit/storage/vest
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/helmet/merc
	gloves = /obj/item/clothing/gloves/thick/combat
	glasses = /obj/item/clothing/glasses/thermal/plain/jensen
	shoes = /obj/item/clothing/shoes/combat
	id_types = list(/obj/item/card/id/adminlvl5)
	suit_store = /obj/item/gun/projectile/automatic/scp/ak742
	r_hand = null
	l_hand = /obj/item/material/hatchet/tacknife
	l_pocket = /obj/item/grenade/frag
	r_pocket = /obj/item/card/emag
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/gun/energy/stunrevolver/rifle
	back = /obj/item/storage/backpack/rucksack
	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/storage/box/handcuffs = 1,/obj/item/ammo_magazine/scp/ak/big = 5,/obj/item/clothing/accessory/ubac/green = 1,/obj/item/clothing/accessory/armor/helmcover/blue/sol = 1)

// FULLY GEARED (for zombies)

/decl/hierarchy/outfit/job/site90/crew/security/lczguard/geared
	name = OUTFIT_JOB_NAME("Junior Guard")
	uniform = /obj/item/clothing/under/scp/whiteuniform
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor
	head = /obj/item/clothing/head/helmet/scp/security
	back = null
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
	back = /obj/item/storage/backpack/satchel

/decl/hierarchy/outfit/job/site90/crew/science/scientist/geared
	name = OUTFIT_JOB_NAME("Scientist")
	uniform = /obj/item/clothing/under/lawyer/bluesuit
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/genetics
	shoes = /obj/item/clothing/shoes/laceup
	id_types = list(/obj/item/card/id/sciencelvl2)
	gloves = /obj/item/clothing/gloves/latex
	l_ear = /obj/item/device/radio/headset/headset_sci

/decl/hierarchy/outfit/job/ds90/medical/medicaldoctor/geared
	name = OUTFIT_JOB_NAME("Medical Doctor")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/blue
	shoes = /obj/item/clothing/shoes/white
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	id_types = list(/obj/item/card/id/doctor)
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_med
	back = /obj/item/storage/backpack/medic

/decl/hierarchy/outfit/job/site90/crew/civ/classd/geared
	name = OUTFIT_JOB_NAME("Class D")
	uniform = /obj/item/clothing/under/scp/dclass
	shoes = /obj/item/clothing/shoes/workboots
	belt = /obj/item/gun/projectile/pistol/mk9
	l_pocket = /obj/item/ammo_magazine/scp/mk9
	id_types = list(/obj/item/card/id/classd)
	l_ear = null
	back = null


/decl/hierarchy/outfit/job/site90/crew/civ/officeworker
	name = OUTFIT_JOB_NAME("Office Worker")
	uniform = /obj/item/clothing/under/scp/suittie
	shoes = /obj/item/clothing/shoes/laceup
	id_types = list(/obj/item/card/id/officeworker)
	back = /obj/item/storage/backpack/satchel/leather/black
	backpack_contents = list(/obj/item/paper_bin = 1,/obj/item/device/radio =1,/obj/item/pen = 1)
	l_ear = /obj/item/device/radio/headset/headset_service
	r_ear = /obj/item/pen
	l_pocket = /obj/item/material/clipboard
	r_pocket = /obj/item/folder


//Job Outfits


//SITE DS90 OUTFITS
//Keeping them simple for now, just spawning with basic uniforms, and pretty much no gear. Gear instead goes in lockers. Keep this in mind if editing.
/*

/decl/hierarchy/outfit/job/ds90/medical
	l_pocket = /obj/item/card/id/level_2

/decl/hierarchy/outfit/job/site90/crew/command
	l_pocket = /obj/item/card/id/level_5

/decl/hierarchy/outfit/job/site90/crew/security
	l_pocket = /obj/item/card/id/level_3

/decl/hierarchy/outfit/job/ds90/science
	l_pocket = /obj/item/card/id/level_2

/decl/hierarchy/outfit/job/ds90/civ
	l_pocket = /obj/item/card/id/level_1
*/


// SCP COMMAND OUTFITS
/decl/hierarchy/outfit/job/site90/crew/command/facilitydir
	name = OUTFIT_JOB_NAME("Facility Director")
	uniform = /obj/item/clothing/under/lawyer/bluesuit
	shoes = /obj/item/clothing/shoes/dress
	suit = /obj/item/clothing/suit/storage/toggle/suit/black
	id_types = list(/obj/item/card/id/adminlvl5)
	l_ear = /obj/item/device/radio/headset/heads/captain
	//	//back = /obj/item/storage/backpack/satchel  - test fix

/decl/hierarchy/outfit/job/site90/crew/command/headofhr
	name = OUTFIT_JOB_NAME("Head of Human Resources")
	uniform = /obj/item/clothing/under/lawyer/bluesuit
	shoes = /obj/item/clothing/shoes/dress
	suit = /obj/item/clothing/suit/storage/toggle/suit/black
	id_types = list(/obj/item/card/id/adminlvl4)
	l_ear = /obj/item/device/radio/headset/heads/hop
	//	//back = /obj/item/storage/backpack/satchel  - test fix/pocketbook

/decl/hierarchy/outfit/job/site90/crew/command/commsofficer
	name = OUTFIT_JOB_NAME("Communications Officer")
	uniform = /obj/item/clothing/under/scp/utility/communications/officer
	gloves = /obj/item/clothing/gloves/foundation_service
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/commslvl4)
	l_ear = /obj/item/device/radio/headset/heads/commsofficer
	//	//back = /obj/item/storage/backpack/satchel  - test fix/pocketbook

// END OF COMMAND OUTFITS

/decl/hierarchy/outfit/job/site90/crew/command/commstech
	name = OUTFIT_JOB_NAME("Communications Technician")
	uniform = /obj/item/clothing/under/scp/utility/communications/tech
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/commslvl1)
	belt = /obj/item/storage/belt/utility/full
	l_ear = /obj/item/device/radio/headset/commsdispatcher
	//	//back = /obj/item/storage/backpack/satchel  - test fix/pocketbook


/decl/hierarchy/outfit/job/ds90/crew/command/chief_engineer
	name = OUTFIT_JOB_NAME("Chief Engineer")
	uniform = /obj/item/clothing/under/scp/utility/engineering
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl4)
	belt = /obj/item/storage/belt/utility/full
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/heads/ce
		//back = /obj/item/storage/backpack/industrial


// Cell Guards
/* CANDIDATE FOR REMOVAL.
/decl/hierarchy/outfit/job/site90/crew/security/cellguardlieutenant
	name = OUTFIT_JOB_NAME("Cell Warden")
	uniform = /obj/item/clothing/under/rank/security2
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list( = /obj/item/card/id/seclvl4
	l_ear = /obj/item/device/radio/headset/heads/cw
		//back = null

/decl/hierarchy/outfit/job/site90/crew/security/brigofficer
	name = OUTFIT_JOB_NAME("Cell Guard")
	uniform = /obj/item/clothing/under/rank/security2
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list( = /obj/item/card/id/seclvl2
	l_ear = /obj/item/device/radio/headset/headset_sec
	l_pocket = /obj/item/book/manual/scp/secsop
		//back = null
*/
// SECURITY OUTFITS
/decl/hierarchy/outfit/job/site90/crew/command/cos
	name = OUTFIT_JOB_NAME("Guard Commander")
	uniform = /obj/item/clothing/under/scp/whiteuniform
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/gcseclvl5)
	r_pocket = /obj/item/book/manual/scp/secsop
	l_ear = /obj/item/device/radio/headset/heads/cos
	l_pocket = /obj/item/book/manual/scp/secsop
		//back = /obj/item/storage/backpack/dufflebag/sec

// ZONE COMMANDER OUTFITS.

/decl/hierarchy/outfit/job/site90/crew/security/ltofficerhcz
	name = OUTFIT_JOB_NAME("HCZ Zone Commander")
	uniform = /obj/item/clothing/under/scp/whiteuniform
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/zcseclvl4hcz)
	l_ear = /obj/item/device/radio/headset/headset_com
	l_pocket = /obj/item/book/manual/scp/secsop
		//back = /obj/item/storage/backpack/dufflebag/sec

/decl/hierarchy/outfit/job/site90/crew/security/ltofficerlcz
	name = OUTFIT_JOB_NAME("LCZ Zone Commander")
	uniform = /obj/item/clothing/under/scp/utility/security/zc
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/zcseclvl3lcz)
	l_ear = /obj/item/device/radio/headset/headset_com
	l_pocket = /obj/item/book/manual/scp/secsop
		//back = null


/decl/hierarchy/outfit/job/site90/crew/security/ltofficerez
	name = OUTFIT_JOB_NAME("EZ Senior Agent")
	uniform = /obj/item/clothing/under/scp/utility/security/zc
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/zcseclvl4ez)
	l_ear = /obj/item/device/radio/headset/headset_com
	l_pocket = /obj/item/book/manual/scp/secsop
		//back = null
// GUARD OUTFITS
/decl/hierarchy/outfit/job/site90/crew/security/ncoofficerlcz
	name = OUTFIT_JOB_NAME("LCZ Guard")
	uniform = /obj/item/clothing/under/scp/utility/security
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl2lcz)
	l_ear = /obj/item/device/radio/headset/headset_sec
	l_pocket = /obj/item/book/manual/scp/secsop
	r_pocket = /obj/item/card/id/level_4
		//back = null

/decl/hierarchy/outfit/job/site90/crew/security/ncoofficerhcz
	name = OUTFIT_JOB_NAME("HCZ Guard")
	uniform = /obj/item/clothing/under/scp/whiteuniform
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl3hcz)
	l_ear = /obj/item/device/radio/headset/headset_sec
	l_pocket = /obj/item/book/manual/scp/secsop
	//	//back = /obj/item/storage/backpack/satchel  - test fix

/decl/hierarchy/outfit/job/site90/crew/security/ncoofficerez
	name = OUTFIT_JOB_NAME("EZ Agent")
	uniform = /obj/item/clothing/under/scp/utility/security
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl3ez)
	l_ear = /obj/item/device/radio/headset/headset_sec
	l_pocket = /obj/item/book/manual/scp/secsop
		//back = null

/decl/hierarchy/outfit/job/site90/crew/security/enlistedofficerez
	name = OUTFIT_JOB_NAME("EZ Junior Agent")
	uniform = /obj/item/clothing/under/scp/utility/security
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/junseclvl2ez)
	l_ear = /obj/item/device/radio/headset/headset_sec
	l_pocket = /obj/item/book/manual/scp/secsop
		//back = null

// JUNIOR GUARD OUTFITS
/decl/hierarchy/outfit/job/site90/crew/security/enlistedofficerlcz
	name = OUTFIT_JOB_NAME("LCZ Junior Guard")
	uniform = /obj/item/clothing/under/scp/whiteuniform
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/junseclvl1)
	l_ear = /obj/item/device/radio/headset/headset_sec
	l_pocket = /obj/item/book/manual/scp/secsop
	//	//back = /obj/item/storage/backpack/satchel  - test fix

/decl/hierarchy/outfit/job/site90/crew/security/enlistedofficerhcz
	name = OUTFIT_JOB_NAME("HCZ Junior Guard")
	uniform = /obj/item/clothing/under/scp/utility/security
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/junseclvl3hcz)
	l_ear = /obj/item/device/radio/headset/headset_sec
	l_pocket = /obj/item/book/manual/scp/secsop
		//back = null
// SCIENCE OUTFITS

/decl/hierarchy/outfit/job/site90/crew/science/juniorscientist
	name = OUTFIT_JOB_NAME("Scientist Associate")
	uniform = /obj/item/clothing/under/lawyer/bluesuit
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	shoes = /obj/item/clothing/shoes/laceup
	id_types = list(/obj/item/card/id/sciencelvl1)
	gloves = /obj/item/clothing/gloves/latex
	l_ear = /obj/item/device/radio/headset/headset_sci
	//	//back = /obj/item/storage/backpack/satchel  - test fix

/decl/hierarchy/outfit/job/site90/crew/science/scientist
	name = OUTFIT_JOB_NAME("Scientist")
	uniform = /obj/item/clothing/under/lawyer/bluesuit
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/genetics
	shoes = /obj/item/clothing/shoes/laceup
	id_types = list(/obj/item/card/id/sciencelvl2)
	gloves = /obj/item/clothing/gloves/latex
	l_ear = /obj/item/device/radio/headset/headset_sci
	l_pocket = /obj/item/book/manual/scp/scisop

/decl/hierarchy/outfit/job/site90/crew/science/seniorscientist
	name = OUTFIT_JOB_NAME("Senior Scientist")
	uniform = /obj/item/clothing/under/lawyer/bluesuit
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/science
	shoes = /obj/item/clothing/shoes/laceup
	id_types = list(/obj/item/card/id/sciencelvl4)
	gloves = /obj/item/clothing/gloves/latex/nitrile
	l_pocket = /obj/item/book/manual/scp/scisop
	l_ear = /obj/item/device/radio/headset/headset_sci
	//	//back = /obj/item/storage/backpack/satchel  - test fix/pocketbook

/decl/hierarchy/outfit/job/site90/crew/science/researchdirector
	name = OUTFIT_JOB_NAME("Research Director")
	uniform = /obj/item/clothing/under/lawyer/bluesuit
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/rd
	shoes = /obj/item/clothing/shoes/laceup
	id_types = list(/obj/item/card/id/sciencelvl5)
	gloves = /obj/item/clothing/gloves/latex/nitrile
	l_ear = /obj/item/device/radio/headset/heads/rd
	l_pocket = /obj/item/book/manual/scp/scisop
	//	//back = /obj/item/storage/backpack/satchel  - test fix/pocketbook


// MISC OUTFITS

/decl/hierarchy/outfit/job/site90/crew/civ/classd
	name = OUTFIT_JOB_NAME("Class D")
	uniform = /obj/item/clothing/under/scp/dclass
	shoes = /obj/item/clothing/shoes/workboots
	l_ear = null
		//back = null
	l_pocket = /obj/item/paper/dclass_orientation

/decl/hierarchy/outfit/job/site90/crew/civ/classd/post_equip(var/mob/living/carbon/human/H)
	..()
	if(prob(15))
		var/path = pick(/obj/item/wrench, /obj/item/screwdriver)
		H.equip_to_slot_or_del(new path (H), slot_l_store)

/decl/hierarchy/outfit/job/site90/crew/civ/janitor
	name = OUTFIT_JOB_NAME("Janitor")
	uniform = /obj/item/clothing/under/rank/janitor
	shoes = /obj/item/clothing/shoes/workboots
	l_pocket = /obj/item/device/radio
	id_types = list(/obj/item/card/id/sciencelvl1)
	//	//back = /obj/item/storage/backpack/satchel  - test fix
	l_ear = /obj/item/device/radio/headset/headset_service

/decl/hierarchy/outfit/job/site90/crew/civ/chef
	name = OUTFIT_JOB_NAME("Chef")
	uniform = /obj/item/clothing/under/color/white
	shoes = /obj/item/clothing/shoes/white
	l_pocket = /obj/item/device/radio
	id_types = list(/obj/item/card/id/chef)
	//	//back = /obj/item/storage/backpack/satchel  - test fix
	l_ear = /obj/item/device/radio/headset/headset_service

/decl/hierarchy/outfit/job/site90/crew/civ/bartender
	name = OUTFIT_JOB_NAME("Bartender")
	uniform = /obj/item/clothing/under/suit_jacket/tan
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/device/radio
	id_types = list(/obj/item/card/id/bartender)
	l_ear = /obj/item/device/radio/headset/headset_service
	//	//back = /obj/item/storage/backpack/satchel  - test fix/pocketbook

/decl/hierarchy/outfit/job/site90/crew/civ/archivist
	name = OUTFIT_JOB_NAME("Archivist")
	uniform = /obj/item/clothing/under/suit_jacket/really_black
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/device/radio
	id_types = list(/obj/item/card/id/archivist)
	//	//back = /obj/item/storage/backpack/satchel  - test fix
	l_ear = /obj/item/device/radio/headset/headset_com

/decl/hierarchy/outfit/job/site90/crew/civ/o5rep
	name = OUTFIT_JOB_NAME("O5 Representative")
	uniform = /obj/item/clothing/under/suit_jacket/really_black
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/device/radio
	id_types = list(/obj/item/card/id/adminlvl5)
	l_ear = /obj/item/device/radio/headset/heads/hop
	//	//back = /obj/item/storage/backpack/satchel  - test fix/pocketbook

// ENGINEERING STUFF

/decl/hierarchy/outfit/job/ds90/crew/engineering/juneng
	name = OUTFIT_JOB_NAME("Junior Engineer")
	uniform = /obj/item/clothing/under/solgov/utility/fleet/engineering
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl2)
	belt = /obj/item/storage/belt/utility/full
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_eng

/decl/hierarchy/outfit/job/ds90/crew/engineering/eng
	name = OUTFIT_JOB_NAME("Engineer")
	uniform = /obj/item/clothing/under/solgov/utility/fleet/engineering
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl3)
	belt = /obj/item/storage/belt/utility/full
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_eng

/decl/hierarchy/outfit/job/ds90/crew/engineering/seneng
	name = OUTFIT_JOB_NAME("Senior Engineer")
	uniform = /obj/item/clothing/under/solgov/utility/fleet/engineering
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl4)
	belt = /obj/item/storage/belt/utility/full
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/heads/ce
		//back = /obj/item/storage/backpack/industrial

/decl/hierarchy/outfit/job/ds90/crew/engineering/conteng
	name = OUTFIT_JOB_NAME("Containment Engineer")
	uniform = /obj/item/clothing/under/solgov/utility/fleet/engineering
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl4)
	belt = /obj/item/storage/belt/utility/full
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/heads/ce
		//back = /obj/item/storage/backpack/industrial

// BRIG OFFICER
/decl/hierarchy/outfit/job/torch/crew/security/brig_officer
	name = OUTFIT_JOB_NAME("Brig Officer")
	uniform = /obj/item/clothing/under/scp/whiteuniform
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/seclvl2)
	l_ear = /obj/item/device/radio/headset/headset_com
	//	//back = /obj/item/storage/backpack/satchel  - test fix/

// MEDICAL OUTFITS

/decl/hierarchy/outfit/job/ds90/crew/command/cmo
	name = OUTFIT_JOB_NAME("Chief Medical Officer")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/purple
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	shoes = /obj/item/clothing/shoes/white
	id_types = list(/obj/item/card/id/chiefmedicalofficer)
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/heads/cmo
		//back = /obj/item/storage/backpack/medic

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
		//back = /obj/item/storage/backpack/medic

/decl/hierarchy/outfit/job/ds90/medical/medicaldoctor
	name = OUTFIT_JOB_NAME("Medical Doctor")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/blue
	shoes = /obj/item/clothing/shoes/white
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	id_types = list(/obj/item/card/id/doctor)
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_med
		//back = /obj/item/storage/backpack/medic

/decl/hierarchy/outfit/job/ds90/medical/virologist
	name = OUTFIT_JOB_NAME("Virologist")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/teal
	shoes = /obj/item/clothing/shoes/white
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	id_types = list(/obj/item/card/id/virologist)
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_med
		//back = /obj/item/storage/backpack/medic

/decl/hierarchy/outfit/job/ds90/medical/surgeon
	name = OUTFIT_JOB_NAME("Surgeon")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/green
	shoes = /obj/item/clothing/shoes/white
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	id_types = list(/obj/item/card/id/doctor)
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_med
	//	//back = /obj/item/storage/backpack/satchel  - test fix/pocketbook

/decl/hierarchy/outfit/job/ds90/medical/emt
	name = OUTFIT_JOB_NAME("Emergency Medical Technician")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/black
	shoes = /obj/item/clothing/shoes/white
	id_types = list(/obj/item/card/id/emt)
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_med
		//back = /obj/item/storage/backpack/medic


// LOGISTICS OUTFITS

/decl/hierarchy/outfit/job/site90/crew/command/logisticsofficer
	name = OUTFIT_JOB_NAME("Logistics Officer")
	uniform = /obj/item/clothing/under/scp/utility/logistics/officer
	gloves = /obj/item/clothing/gloves/thick
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/logoff)
	l_ear = /obj/item/device/radio/headset/headset_deckofficer
	//	//back = /obj/item/storage/backpack/satchel  - test fix/pocketbook

/decl/hierarchy/outfit/job/site90/crew/command/logisticspecialist
	name = OUTFIT_JOB_NAME("Logistics Specialist")
	uniform = /obj/item/clothing/under/scp/utility/logistics
	gloves = /obj/item/clothing/gloves/thick
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list(/obj/item/card/id/logspec)
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_cargo
	//	//back = /obj/item/storage/backpack/satchel  - test fix/pocketbook

/decl/hierarchy/outfit/job/site90/crew/command/event/mtf_epsilon1
	name = OUTFIT_JOB_NAME("MTF Epsilon-6 Agent Beta")
	uniform = /obj/item/clothing/under/frontier
//	suit = /obj/item/clothing/suit/armor/pcarrier/green/scp/mtf_epsilon
	head = /obj/item/clothing/head/helmet/site53/guard/mtf_epsilon
	mask = /obj/item/clothing/mask/balaclava/tactical
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/jackboots
//	id_types = list( = /obj/item/card/id/adminlvl5
	suit_store = /obj/item/gun/projectile/automatic/scp/p90
//	r_hand = /obj/item/crowbar/red
//	l_hand = /obj/item/material/hatchet/tacknife
//	l_pocket = /obj/item/grenade/flashbang
//	r_pocket = /obj/item/grenade/flashbang
	l_ear = /obj/item/device/radio/headset/ert
//	belt = /obj/item/gun/projectile/silenced
//	//	//back = /obj/item/storage/backpack/satchel  - test fix
//	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/plastique = 2,/obj/item/grenade/frag = 1,/obj/item/ammo_magazine/scp/p90_mag/ap = 5,/obj/item/ammo_magazine/c45m = 2,/obj/item/clothing/mask/gas = 1)

/decl/hierarchy/outfit/job/site90/crew/command/event/mtf_epsilon2
	name = OUTFIT_JOB_NAME("MTF Epsilon-6 Agent Gamma")
	uniform = /obj/item/clothing/under/det/grey
//	suit = /obj/item/clothing/suit/armor/pcarrier/green/scp/mtf_epsilon
	head = /obj/item/clothing/head/helmet/site53/guard/mtf_epsilon
	mask = /obj/item/clothing/mask/balaclava/tactical
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/jackboots
//	id_types = list( = /obj/item/card/id/adminlvl5
	suit_store = /obj/item/gun/projectile/shotgun/pump/combat
//	r_hand = /obj/item/crowbar/red
//	l_hand = /obj/item/material/hatchet
	l_pocket = /obj/item/grenade/flashbang
	r_pocket = /obj/item/grenade/flashbang
	l_ear = /obj/item/device/radio/headset/ert
//	belt = /obj/item/gun/projectile/silenced
	//	//back = /obj/item/storage/backpack/satchel  - test fix
//	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/grenade/frag = 2,/obj/item/storage/box/shotgunammo = 3,/obj/item/ammo_magazine/c45m = 2,/obj/item/clothing/accessory/storage/bandolier = 1,/obj/item/clothing/mask/gas = 1)

/decl/hierarchy/outfit/job/site90/crew/command/event/mtf_epsilon3
	name = OUTFIT_JOB_NAME("MTF Epsilon-6 Agent Alpha")
	uniform = /obj/item/clothing/under/syndicate/combat
//	suit = /obj/item/clothing/suit/armor/pcarrier/green/scp/mtf_epsilon
	head = /obj/item/clothing/head/helmet/site53/guard/mtf_epsilon/leader
	mask = /obj/item/clothing/mask/balaclava
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/jackboots
//	id_types = list( = /obj/item/card/id/adminlvl5
//	suit_store = /obj/item/gun/projectile/automatic/scp/m16
	r_hand = /obj/item/storage/box/syndie_kit/spy
	l_hand = null
	l_pocket = /obj/item/grenade/smokebomb
	r_pocket = null
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/gun/projectile/revolver/webley/captain
	//	//back = /obj/item/storage/backpack/satchel  - test fix
//	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/grenade/frag = 1,/obj/item/crowbar/red = 1,/obj/item/ammo_magazine/scp/m16_mag = 3,/obj/item/ammo_magazine/c44 = 4,/obj/item/clothing/mask/gas = 1)

/decl/hierarchy/outfit/job/site90/crew/command/event/mtf_epsilon4
	name = OUTFIT_JOB_NAME("MTF Epsilon-6 Agent Bravo")
	uniform = /obj/item/clothing/under/rank/psych/turtleneck/sweater
//	suit = /obj/item/clothing/suit/armor/pcarrier/green/scp/mtf_epsilon
	head = /obj/item/clothing/head/helmet/site53/guard/mtf_epsilon/medic
	mask = /obj/item/clothing/mask/balaclava
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/jackboots
//	id_types = list( = /obj/item/card/id/adminlvl5
//	suit_store = /obj/item/gun/projectile/automatic/scp/p90
	r_hand = /obj/item/storage/firstaid/surgery
	l_hand = /obj/item/crowbar/red
	l_pocket = /obj/item/grenade/smokebomb
	r_pocket = null
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/defibrillator/compact/combat/loaded
	//	//back = /obj/item/storage/backpack/satchel  - test fix
//	backpack_contents = list(/obj/item/ammo_magazine/scp/p90_mag/ap = 3,/obj/item/clothing/mask/gas = 1,/obj/item/storage/firstaid/combat/mtf = 1,/obj/item/reagent_containers/ivbag/blood/OMinus = 2,/obj/item/storage/pill_bottle/zoom = 1)

/decl/hierarchy/outfit/job/site90/crew/command/event/chaos_soldier
	name = OUTFIT_JOB_NAME("Chaos Insurgency Soldier")
	uniform = /obj/item/clothing/under/scp/utility/chaos
//	suit = /obj/item/clothing/suit/storage/vest/scp/medarmorchaos
//	head = /obj/item/clothing/head/helmet/scp/chaos
	mask = /obj/item/clothing/mask/balaclava/tactical
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/dutyboots
//	id_types = list( = null
//	suit_store = /obj/item/gun/projectile/automatic/scp/p90
	r_hand = null
//	l_hand = /obj/item/material/hatchet/tacknife
	l_pocket = /obj/item/grenade/frag
	r_pocket = /obj/item/grenade/flashbang
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/gun/projectile/automatic/machine_pistol
	//	//back = /obj/item/storage/backpack/satchel  - test fix
//	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/clothing/mask/gas = 1,/obj/item/ammo_magazine/scp/p90_mag/ap = 4,/obj/item/ammo_magazine/c45uzi = 2,/obj/item/grenade/smokebomb = 1)

/decl/hierarchy/outfit/job/site90/crew/command/event/chaos_soldier_alt
	name = OUTFIT_JOB_NAME("Chaos Insurgency Heavy Soldier")
	uniform = /obj/item/clothing/under/scp/utility/chaos
//	suit = /obj/item/clothing/suit/storage/vest/scp/medarmorchaos
//	head = /obj/item/clothing/head/helmet/scp/chaos
	mask = /obj/item/clothing/mask/balaclava/tactical
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list()
	suit_store = /obj/item/gun/projectile/automatic/l6_saw
//	r_hand = /obj/item/ammo_magazine/box/a556
//	l_hand = /obj/item/ammo_magazine/box/a556
	l_pocket = /obj/item/grenade/frag
	r_pocket = /obj/item/grenade/frag
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/gun/projectile/shotgun/doublebarrel/sawn
	//	//back = /obj/item/storage/backpack/satchel  - test fix
//	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/clothing/mask/gas = 1,/obj/item/storage/box/shotgunammo = 2,/obj/item/storage/firstaid/combat/mtf = 1,/obj/item/grenade/frag = 1)

/decl/hierarchy/outfit/job/site90/crew/command/event/chaos_leader
	name = OUTFIT_JOB_NAME("Chaos Insurgency Squad Leader")
	uniform = /obj/item/clothing/under/scp/utility/chaos
//	suit = /obj/item/clothing/suit/storage/vest/scp/medarmorchaos
	head = /obj/item/clothing/head/beret/solgov/fleet/security
	mask = /obj/item/clothing/mask/balaclava/tactical
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/tactical/scp
	shoes = /obj/item/clothing/shoes/dutyboots
	id_types = list()
//	suit_store = /obj/item/gun/projectile/revolver/donor
	r_hand = null
//	l_hand = /obj/item/material/hatchet/tacknife
	l_pocket = /obj/item/grenade/frag
	r_pocket = /obj/item/grenade/flashbang
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/material/sword/katana
	//	//back = /obj/item/storage/backpack/satchel  - test fix
//	backpack_contents = list(/obj/item/storage/box/ifak = 1,/obj/item/clothing/mask/gas = 1,/obj/item/ammo_magazine/a127 = 8,/obj/item/grenade/smokebomb = 3)




// FULLY GEARED (mostly for zombie's)

/decl/hierarchy/outfit/job/site90/crew/security/lczguardgear
	name = OUTFIT_JOB_NAME("Junior Guard")
	uniform = /obj/item/clothing/under/scp/whiteuniform
	suit = /obj/item/clothing/suit/armor/vest/scp/medarmor
	head = /obj/item/clothing/head/helmet/scp/security
		//back = null
	shoes = /obj/item/clothing/shoes/dutyboots
	belt = /obj/item/storage/belt/holster/security/tactical
	id_types = list(/obj/item/card/id/seclvl2lcz)
	l_pocket = /obj/item/device/radio
	r_pocket = /obj/item/ammo_magazine/scp/p90_mag
	suit_store = /obj/item/gun/projectile/automatic/scp/p90
	l_hand = null
	r_hand = null

/decl/hierarchy/outfit/job/site90/crew/science/juniorscientistgear
	name = OUTFIT_JOB_NAME("Scientist Associate")
	uniform = /obj/item/clothing/under/lawyer/bluesuit
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	shoes = /obj/item/clothing/shoes/laceup
	id_types = list(/obj/item/card/id/sciencelvl1)
	gloves = /obj/item/clothing/gloves/latex
	l_ear = /obj/item/device/radio/headset/headset_sci
	//	//back = /obj/item/storage/backpack/satchel  - test fix

/decl/hierarchy/outfit/job/site90/crew/science/scientistgear
	name = OUTFIT_JOB_NAME("Scientist")
	uniform = /obj/item/clothing/under/lawyer/bluesuit
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/genetics
	shoes = /obj/item/clothing/shoes/laceup
	id_types = list(/obj/item/card/id/sciencelvl2)
	gloves = /obj/item/clothing/gloves/latex
	l_ear = /obj/item/device/radio/headset/headset_sci

/decl/hierarchy/outfit/job/ds90/medical/medicaldoctorgear
	name = OUTFIT_JOB_NAME("Medical Doctor")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/blue
	shoes = /obj/item/clothing/shoes/white
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	id_types = list(/obj/item/card/id/doctor)
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/headset_med
		//back = /obj/item/storage/backpack/medic

/decl/hierarchy/outfit/job/site90/crew/civ/classdgear
	name = OUTFIT_JOB_NAME("Class D")
	uniform = /obj/item/clothing/under/scp/dclass
	shoes = /obj/item/clothing/shoes/workboots
	belt = /obj/item/gun/projectile/pistol/mk9
	l_pocket = /obj/item/ammo_magazine/scp/mk9
	l_ear = null
		//back = null

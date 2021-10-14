//Job Outfits


//SITE13 OUTFITS
//Keeping them simple for now, just spawning with basic uniforms, and pretty much no gear. Gear instead goes in lockers. Keep this in mind if editing.


// SCP COMMAND OUTFITS
/decl/hierarchy/outfit/job/site90/crew/command/facilitydir
	name = OUTFIT_JOB_NAME("Facility Director")
	uniform = /obj/item/clothing/under/suit_jacket/charcoal
	shoes = /obj/item/clothing/shoes/dress
	id_type = /obj/item/weapon/card/id/adminlvl5
	l_pocket = /obj/item/device/radio
	l_ear = null

/decl/hierarchy/outfit/job/site90/crew/command/headofhr
	name = OUTFIT_JOB_NAME("Head of Human Resources")
	uniform = /obj/item/clothing/under/suit_jacket/checkered
	shoes = /obj/item/clothing/shoes/dress
	id_type = /obj/item/weapon/card/id/adminlvl4
	l_pocket = /obj/item/device/radio
	l_ear = null

/decl/hierarchy/outfit/job/site90/crew/command/commsofficer
	name = OUTFIT_JOB_NAME("Communications Officer")
	uniform = /obj/item/clothing/under/scp/whiteuniform
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/seclvl4
	l_pocket = /obj/item/device/radio
	l_ear = null

/decl/hierarchy/outfit/job/ds90/crew/command/chief_engineer
	name = OUTFIT_JOB_NAME("Chief Engineer")
	uniform = /obj/item/clothing/under/hazard
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/seclvl4
	belt = /obj/item/weapon/storage/belt/utility/full
	l_pocket = /obj/item/device/radio
	l_ear = null


// SCP CELL GUARDS

/decl/hierarchy/outfit/job/site90/crew/security/cellguardlieutenant
	name = OUTFIT_JOB_NAME("Cell Guard Lieutenant")
	uniform = /obj/item/clothing/under/scp/whiteuniform
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/seclvl4
	l_pocket = /obj/item/device/radio
	l_ear = null

/decl/hierarchy/outfit/job/site90/crew/security/brigofficer
	name = OUTFIT_JOB_NAME("Cell Guard")
	uniform = /obj/item/clothing/under/scp/whiteuniform
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/seclvl2
	l_pocket = /obj/item/device/radio
	l_ear = null

// SECURITY OUTFITS

/decl/hierarchy/outfit/job/site90/crew/command/cos
	name = OUTFIT_JOB_NAME("Guard Commander")
	uniform = /obj/item/clothing/under/scp/whiteuniform
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/seclvl5
	l_pocket = /obj/item/device/radio
	l_ear = null

/decl/hierarchy/outfit/job/site90/crew/security/ltofficer
	name = OUTFIT_JOB_NAME("Guard Lieutenant")
	uniform = /obj/item/clothing/under/scp/whiteuniform
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/seclvl4
	l_pocket = /obj/item/device/radio
	l_ear = null

/decl/hierarchy/outfit/job/site90/crew/security/ncoofficer
	name = OUTFIT_JOB_NAME("Guard")
	uniform = /obj/item/clothing/under/scp/whiteuniform
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/seclvl2
	l_pocket = /obj/item/device/radio
	l_ear = null

/decl/hierarchy/outfit/job/site90/crew/security/enlistedofficer
	name = OUTFIT_JOB_NAME("Junior Guard")
	uniform = /obj/item/clothing/under/scp/whiteuniform
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/seclvl1
	l_pocket = /obj/item/device/radio
	l_ear = null

// SCIENCE OUTFITS

/decl/hierarchy/outfit/job/site90/crew/science/juniorscientist
	name = OUTFIT_JOB_NAME("Junior Scientist")
	uniform = /obj/item/clothing/under/suit_jacket/tan
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	shoes = /obj/item/clothing/shoes/laceup
	id_type = /obj/item/weapon/card/id/sciencelvl1
	l_pocket = /obj/item/device/radio
	l_ear = null

/decl/hierarchy/outfit/job/site90/crew/science/scientist
	name = OUTFIT_JOB_NAME("Scientist")
	uniform = /obj/item/clothing/under/suit_jacket/tan
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/science
	shoes = /obj/item/clothing/shoes/laceup
	id_type = /obj/item/weapon/card/id/sciencelvl2
	l_pocket = /obj/item/device/radio
	l_ear = null

/decl/hierarchy/outfit/job/site90/crew/science/seniorscientist
	name = OUTFIT_JOB_NAME("Senior Scientist")
	uniform = /obj/item/clothing/under/suit_jacket/tan
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/blue
	shoes = /obj/item/clothing/shoes/laceup
	id_type = /obj/item/weapon/card/id/sciencelvl4
	l_pocket = /obj/item/device/radio
	l_ear = null

/decl/hierarchy/outfit/job/site90/crew/science/researchdirector
	name = OUTFIT_JOB_NAME("Research Director")
	uniform = /obj/item/clothing/under/suit_jacket/burgundy
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/rd
	shoes = /obj/item/clothing/shoes/laceup
	id_type = /obj/item/weapon/card/id/sciencelvl5
	l_pocket = /obj/item/device/radio
	l_ear = null


// MISC OUTFITS

/decl/hierarchy/outfit/job/site90/crew/civ/classd
	name = OUTFIT_JOB_NAME("Class D")
	uniform = /obj/item/clothing/under/scp/dclass
	shoes = /obj/item/clothing/shoes/workboots
	l_ear = null
	back = null

/decl/hierarchy/outfit/job/site90/crew/civ/classd/post_equip(var/mob/living/carbon/human/H)
	..()
	if(prob(15))
		var/path = pick(/obj/item/weapon/material/kitchen/utensil/knife/boot, /obj/item/weapon/wrench, /obj/item/weapon/screwdriver)
		H.equip_to_slot_or_del(new path (H), slot_l_store)

/decl/hierarchy/outfit/job/site90/crew/civ/classdminer
	name = OUTFIT_JOB_NAME("Class D Miner")
	uniform = /obj/item/clothing/under/scp/dclass
	shoes = /obj/item/clothing/shoes/workboots
	suit = /obj/item/clothing/suit/space/syndicate/orange/dboi
	head = /obj/item/clothing/head/helmet/space/syndicate/orange/dboi
	l_ear = null
	back = null

/decl/hierarchy/outfit/job/site90/crew/security/ncoofficerequipped
	name = OUTFIT_JOB_NAME("Guard")
	uniform = /obj/item/clothing/under/scp/whiteuniform
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/seclvl2
	l_pocket = /obj/item/device/radio
	suit = /obj/item/clothing/suit/armor/vest/bgguard
	head = /obj/item/clothing/head/helmet/bgtactical
	l_ear = null

/decl/hierarchy/outfit/job/site90/crew/security/ltofficerequipped
	name = OUTFIT_JOB_NAME("Guard Lieutenant")
	uniform = /obj/item/clothing/under/scp/whiteuniform
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/seclvl4
	l_pocket = /obj/item/device/radio
	suit = /obj/item/clothing/suit/armor/vest/bgguard
	head = /obj/item/clothing/head/helmet/bgtactical
	l_ear = null

/decl/hierarchy/outfit/job/site90/crew/security/enlistedofficerequipped
	name = OUTFIT_JOB_NAME("Junior Guard")
	uniform = /obj/item/clothing/under/scp/whiteuniform
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/seclvl1
	l_pocket = /obj/item/device/radio
	suit = /obj/item/clothing/suit/armor/vest/bgguard
	head = /obj/item/clothing/head/helmet/bgtactical
	l_ear = null

/decl/hierarchy/outfit/job/site90/crew/civ/janitor
	name = OUTFIT_JOB_NAME("Janitor")
	uniform = /obj/item/clothing/under/scp/dclass
	suit = /obj/item/clothing/suit/apron/overalls
	shoes = /obj/item/clothing/shoes/workboots
	l_pocket = /obj/item/device/radio
	id_type = /obj/item/weapon/card/id/sciencelvl1
	l_ear = null

// ENGI OUTFITS

/decl/hierarchy/outfit/job/ds90/crew/engineering/juneng
	name = OUTFIT_JOB_NAME("Junior Engineer")
	uniform = /obj/item/clothing/under/hazard
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/seclvl2
	belt = /obj/item/weapon/storage/belt/utility/full
	l_pocket = /obj/item/device/radio
	l_ear = null

/decl/hierarchy/outfit/job/ds90/crew/engineering/eng
	name = OUTFIT_JOB_NAME("Engineer")
	uniform = /obj/item/clothing/under/hazard
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/seclvl3
	belt = /obj/item/weapon/storage/belt/utility/full
	l_pocket = /obj/item/device/radio
	l_ear = null

/decl/hierarchy/outfit/job/ds90/crew/engineering/seneng
	name = OUTFIT_JOB_NAME("Senior Engineer")
	uniform = /obj/item/clothing/under/hazard
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/seclvl4
	belt = /obj/item/weapon/storage/belt/utility/full
	l_pocket = /obj/item/device/radio
	l_ear = null

/decl/hierarchy/outfit/job/ds90/crew/engineering/conteng
	name = OUTFIT_JOB_NAME("Containment Engineer")
	uniform = /obj/item/clothing/under/hazard
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/seclvl4
	belt = /obj/item/weapon/storage/belt/utility/full
	l_pocket = /obj/item/device/radio
	l_ear = null

// MEDICAL OUTFITS

/decl/hierarchy/outfit/job/ds90/crew/command/cmo
	name = OUTFIT_JOB_NAME("Chief Medical Officer")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/purple
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/cmo
	shoes = /obj/item/clothing/shoes/white
	id_type = /obj/item/weapon/card/id/seclvl5
	l_pocket = /obj/item/device/radio
	l_ear = null

/decl/hierarchy/outfit/job/ds90/medical/psychiatrist
	name = OUTFIT_JOB_NAME("Psychiatrist")
	uniform = /obj/item/clothing/under/rank/psych/turtleneck
	shoes = /obj/item/clothing/shoes/laceup
	id_type = /obj/item/weapon/card/id/seclvl1
	l_pocket = /obj/item/device/radio
	l_ear = null

/decl/hierarchy/outfit/job/ds90/medical/chemist
	name = OUTFIT_JOB_NAME("Chemist")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/navyblue
	shoes = /obj/item/clothing/shoes/white
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	id_type = /obj/item/weapon/card/id/seclvl2
	l_pocket = /obj/item/device/radio
	l_ear = null

/decl/hierarchy/outfit/job/ds90/medical/medicaldoctor
	name = OUTFIT_JOB_NAME("Medical Doctor")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/blue
	shoes = /obj/item/clothing/shoes/white
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	id_type = /obj/item/weapon/card/id/seclvl2
	l_pocket = /obj/item/device/radio
	l_ear = null

/decl/hierarchy/outfit/job/ds90/medical/virologist
	name = OUTFIT_JOB_NAME("Virologist")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/teal
	shoes = /obj/item/clothing/shoes/white
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/virologist
	id_type = /obj/item/weapon/card/id/seclvl2
	l_pocket = /obj/item/device/radio
	l_ear = null

/decl/hierarchy/outfit/job/ds90/medical/surgeon
	name = OUTFIT_JOB_NAME("Surgeon")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/green
	shoes = /obj/item/clothing/shoes/white
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	id_type = /obj/item/weapon/card/id/seclvl2
	l_pocket = /obj/item/device/radio
	l_ear = null




// LOGISTICS OUTFITS

/decl/hierarchy/outfit/job/site90/crew/command/logisticsofficer
	name = OUTFIT_JOB_NAME("Logistics Officer")
	uniform = /obj/item/clothing/under/scp/greyuniform
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/seclvl3
	l_pocket = /obj/item/device/radio
	l_ear = null

/decl/hierarchy/outfit/job/site90/crew/command/logisticspecialist
	name = OUTFIT_JOB_NAME("Logistics Specialist")
	uniform = /obj/item/clothing/under/scp/greyuniform
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/seclvl2
	l_pocket = /obj/item/device/radio
	l_ear = null

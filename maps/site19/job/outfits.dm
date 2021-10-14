//Job Outfits


//SITE site19 OUTFITS
//Keeping them simple for now, just spawning with basic uniforms, and pretty much no gear. Gear instead goes in lockers. Keep this in mind if editing.


// SCP COMMAND OUTFITS
/decl/hierarchy/outfit/job/site19/crew/command/facilitydir
	name = OUTFIT_JOB_NAME("Facility Director")
	uniform = /obj/item/clothing/under/scp/suittie
	shoes = /obj/item/clothing/shoes/dress
	suit = /obj/item/clothing/suit/storage/toggle/suit/black
	id_type = /obj/item/weapon/card/id/adminlvl5
	l_ear = /obj/item/device/radio/headset/heads/captain
	back = null

/decl/hierarchy/outfit/job/site19/crew/command/headofhr
	name = OUTFIT_JOB_NAME("Head of Human Resources")
	uniform = /obj/item/clothing/under/scp/suittie
	shoes = /obj/item/clothing/shoes/dress
	suit = /obj/item/clothing/suit/storage/toggle/suit/black
	id_type = /obj/item/weapon/card/id/adminlvl4
	l_ear = /obj/item/device/radio/headset/heads/hop
	back = null

/decl/hierarchy/outfit/job/site19/crew/command/commsofficer
	name = OUTFIT_JOB_NAME("Communications Officer")
	uniform = /obj/item/clothing/under/scp/utility/communications/officer
	gloves = /obj/item/clothing/gloves/foundation_service
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/commslvl4
	l_ear = /obj/item/device/radio/headset/heads/commsofficer
	back = null

// END OF COMMAND OUTFITS

/decl/hierarchy/outfit/job/site19/crew/command/commstech
	name = OUTFIT_JOB_NAME("Communications Technician")
	uniform = /obj/item/clothing/under/scp/utility/communications/tech
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/commslvl1
	belt = /obj/item/weapon/storage/belt/utility/full
	l_ear = /obj/item/device/radio/headset/commsdispatcher


/decl/hierarchy/outfit/job/site19/crew/command/chief_engineer
	name = OUTFIT_JOB_NAME("Chief Engineer")
	uniform = /obj/item/clothing/under/scp/utility/engineering
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/seclvl4
	belt = /obj/item/weapon/storage/belt/utility/full
	l_pocket = /obj/item/device/radio
	l_ear = /obj/item/device/radio/headset/heads/ce
	back = null

// SECURITY OUTFITS
/decl/hierarchy/outfit/job/site19/crew/command/cos
	name = OUTFIT_JOB_NAME("Guard Commander")
	uniform = /obj/item/clothing/under/scp/utility/security/gc
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/gcseclvl5
	r_pocket = /obj/item/weapon/book/manual/scp/secsop
	l_ear = /obj/item/device/radio/headset/heads/cos
	l_pocket = /obj/item/weapon/book/manual/scp/secsop
	back = null

// ZONE COMMANDER OUTFITS.

/decl/hierarchy/outfit/job/site19/crew/security/ltofficerlcz
	name = OUTFIT_JOB_NAME("LCZ Zone Commander")
	uniform = /obj/item/clothing/under/scp/utility/security/zc
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/zcseclvl3lcz
	l_ear = /obj/item/device/radio/headset/headset_com
	l_pocket = /obj/item/weapon/book/manual/scp/secsop
	back = null


/decl/hierarchy/outfit/job/site19/crew/security/ltofficerhcz
	name = OUTFIT_JOB_NAME("HCZ Zone Commander")
	uniform = /obj/item/clothing/under/scp/utility/security/zc
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/zcseclvl4hcz
	l_ear = /obj/item/device/radio/headset/headset_com
	l_pocket = /obj/item/weapon/book/manual/scp/secsop
	back = null


/decl/hierarchy/outfit/job/site19/crew/security/ltofficerez
	name = OUTFIT_JOB_NAME("EZ Senior Agent")
	uniform = /obj/item/clothing/under/scp/utility/security/zc
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/zcseclvl4ez
	l_ear = /obj/item/device/radio/headset/headset_com
	l_pocket = /obj/item/weapon/book/manual/scp/secsop
	back = null

// GUARD OUTFITS
/decl/hierarchy/outfit/job/site19/crew/security/ncoofficerlcz
	name = OUTFIT_JOB_NAME("LCZ Guard")
	uniform = /obj/item/clothing/under/scp/utility/security
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/seclvl2lcz
	l_ear = /obj/item/device/radio/headset/headset_sec
	l_pocket = /obj/item/weapon/book/manual/scp/secsop
	back = null

/decl/hierarchy/outfit/job/site19/crew/security/ncoofficerhcz
	name = OUTFIT_JOB_NAME("HCZ Guard")
	uniform = /obj/item/clothing/under/scp/utility/security
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/seclvl3hcz
	l_ear = /obj/item/device/radio/headset/headset_sec
	l_pocket = /obj/item/weapon/book/manual/scp/secsop
	back = null

/decl/hierarchy/outfit/job/site19/crew/security/ncoofficerez
	name = OUTFIT_JOB_NAME("EZ Agent")
	uniform = /obj/item/clothing/under/scp/utility/security
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/seclvl3ez
	l_ear = /obj/item/device/radio/headset/headset_sec
	l_pocket = /obj/item/weapon/book/manual/scp/secsop
	back = null

// JUNIOR GUARD OUTFITS
/decl/hierarchy/outfit/job/site19/crew/security/enlistedofficerlcz
	name = OUTFIT_JOB_NAME("LCZ Junior Guard")
	uniform = /obj/item/clothing/under/scp/utility/security
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/junseclvl1
	l_ear = /obj/item/device/radio/headset/headset_sec
	l_pocket = /obj/item/weapon/book/manual/scp/secsop
	back = null

/decl/hierarchy/outfit/job/site19/crew/security/enlistedofficerhcz
	name = OUTFIT_JOB_NAME("HCZ Junior Guard")
	uniform = /obj/item/clothing/under/scp/utility/security
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/junseclvl3hcz
	l_ear = /obj/item/device/radio/headset/headset_sec
	l_pocket = /obj/item/weapon/book/manual/scp/secsop
	back = null

/decl/hierarchy/outfit/job/site19/crew/security/enlistedofficerez
	name = OUTFIT_JOB_NAME("EZ Junior Agent")
	uniform = /obj/item/clothing/under/scp/utility/security
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/junseclvl2ez
	l_ear = /obj/item/device/radio/headset/headset_sec
	l_pocket = /obj/item/weapon/book/manual/scp/secsop
	back = null

// SCIENCE OUTFITS

/decl/hierarchy/outfit/job/site19/crew/science/juniorscientist
	name = OUTFIT_JOB_NAME("Scientist Associate")
	uniform = /obj/item/clothing/under/scp/suittie
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	shoes = /obj/item/clothing/shoes/laceup
	id_type = /obj/item/weapon/card/id/sciencelvl1
	gloves = /obj/item/clothing/gloves/latex
	l_ear = /obj/item/device/radio/headset/headset_sci
	back = null

/decl/hierarchy/outfit/job/site19/crew/science/scientist
	name = OUTFIT_JOB_NAME("Scientist")
	uniform = /obj/item/clothing/under/scp/suittie
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/genetics
	shoes = /obj/item/clothing/shoes/laceup
	id_type = /obj/item/weapon/card/id/sciencelvl2
	gloves = /obj/item/clothing/gloves/latex
	l_ear = /obj/item/device/radio/headset/headset_sci
	l_pocket = /obj/item/weapon/book/manual/scp/scisop
	back = null

/decl/hierarchy/outfit/job/site19/crew/science/seniorscientist
	name = OUTFIT_JOB_NAME("Senior Scientist")
	uniform = /obj/item/clothing/under/scp/suittie
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/science
	shoes = /obj/item/clothing/shoes/laceup
	id_type = /obj/item/weapon/card/id/sciencelvl4
	gloves = /obj/item/clothing/gloves/latex/nitrile
	l_pocket = /obj/item/weapon/book/manual/scp/scisop
	l_ear = /obj/item/device/radio/headset/headset_sci
	back = null

/decl/hierarchy/outfit/job/site19/crew/science/researchdirector
	name = OUTFIT_JOB_NAME("Research Director")
	uniform = /obj/item/clothing/under/scp/suittie
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/rd
	shoes = /obj/item/clothing/shoes/laceup
	id_type = /obj/item/weapon/card/id/sciencelvl5
	gloves = /obj/item/clothing/gloves/latex/nitrile
	l_ear = /obj/item/device/radio/headset/heads/rd
	l_pocket = /obj/item/weapon/book/manual/scp/scisop
	back = null


// MISC OUTFITS

/decl/hierarchy/outfit/job/site19/crew/civ/classd
	name = OUTFIT_JOB_NAME("Class D")
	uniform = /obj/item/clothing/under/scp/dclass
	shoes = /obj/item/clothing/shoes/workboots
	l_ear = null
	back = null
	l_pocket = /obj/item/weapon/paper/dclass_orientation

/decl/hierarchy/outfit/job/site19/crew/civ/classd/post_equip(var/mob/living/carbon/human/H)
	..()
	if(prob(15))
		var/path = pick(/obj/item/weapon/material/kitchen/utensil/knife/boot, /obj/item/weapon/wrench, /obj/item/weapon/screwdriver)
		H.equip_to_slot_or_del(new path (H), slot_l_store)

/decl/hierarchy/outfit/job/site19/crew/civ/janitor
	name = OUTFIT_JOB_NAME("Janitor")
	uniform = /obj/item/clothing/under/rank/janitor
	shoes = /obj/item/clothing/shoes/workboots
	l_pocket = /obj/item/device/radio
	id_type = /obj/item/weapon/card/id/sciencelvl1
	back = null
	l_ear = null

/decl/hierarchy/outfit/job/site19/crew/civ/chef
	name = OUTFIT_JOB_NAME("Chef")
	uniform = /obj/item/clothing/under/color/white
	shoes = /obj/item/clothing/shoes/white
	l_pocket = /obj/item/device/radio
	id_type = /obj/item/weapon/card/id/chef
	back = null
	l_ear = null

/decl/hierarchy/outfit/job/site19/crew/civ/bartender
	name = OUTFIT_JOB_NAME("Bartender")
	uniform = /obj/item/clothing/under/suit_jacket/tan
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/device/radio
	id_type = /obj/item/weapon/card/id/bartender
	back = null
	l_ear = null

/decl/hierarchy/outfit/job/site19/crew/civ/archivist
	name = OUTFIT_JOB_NAME("Archivist")
	uniform = /obj/item/clothing/under/suit_jacket/really_black
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/device/radio
	id_type = /obj/item/weapon/card/id/archivist
	back = null
	l_ear = null

/decl/hierarchy/outfit/job/site19/crew/civ/o5rep
	name = OUTFIT_JOB_NAME("O5 Representative")
	uniform = /obj/item/clothing/under/suit_jacket/really_black
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/device/radio
	id_type = /obj/item/weapon/card/id/adminlvl5
	back = null
	l_ear = null

// ENGINEERING STUFF

/decl/hierarchy/outfit/job/site19/crew/engineering/juneng
	name = OUTFIT_JOB_NAME("Junior Engineer")
	uniform = /obj/item/clothing/under/solgov/utility/fleet/engineering
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/seclvl2
	belt = /obj/item/weapon/storage/belt/utility/full
	l_pocket = /obj/item/device/radio
	l_ear = null
	back = null

/decl/hierarchy/outfit/job/site19/crew/engineering/eng
	name = OUTFIT_JOB_NAME("Engineer")
	uniform = /obj/item/clothing/under/solgov/utility/fleet/engineering
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/seclvl3
	belt = /obj/item/weapon/storage/belt/utility/full
	l_pocket = /obj/item/device/radio
	l_ear = null
	back = null

/decl/hierarchy/outfit/job/site19/crew/engineering/seneng
	name = OUTFIT_JOB_NAME("Senior Engineer")
	uniform = /obj/item/clothing/under/solgov/utility/fleet/engineering
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/seclvl4
	belt = /obj/item/weapon/storage/belt/utility/full
	l_pocket = /obj/item/device/radio
	l_ear = null
	back = null

/decl/hierarchy/outfit/job/site19/crew/engineering/conteng
	name = OUTFIT_JOB_NAME("Containment Engineer")
	uniform = /obj/item/clothing/under/solgov/utility/fleet/engineering
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/seclvl4
	belt = /obj/item/weapon/storage/belt/utility/full
	l_pocket = /obj/item/device/radio
	l_ear = null
	back = null

// BRIG OFFICER
/decl/hierarchy/outfit/job/torch/crew/security/brig_officer
	name = OUTFIT_JOB_NAME("Brig Officer")
	uniform = /obj/item/clothing/under/scp/whiteuniform
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/seclvl2
	l_ear = null
	back = null

// MEDICAL OUTFITS

/decl/hierarchy/outfit/job/site19/crew/command/cmo
	name = OUTFIT_JOB_NAME("Chief Medical Officer")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/purple
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	shoes = /obj/item/clothing/shoes/white
	id_type = /obj/item/weapon/card/id/chiefmedicalofficer
	l_ear = /obj/item/device/radio/headset/heads/cmo
	back = null

/decl/hierarchy/outfit/job/site19/medical/psychiatrist
	name = OUTFIT_JOB_NAME("Psychiatrist")
	uniform = /obj/item/clothing/under/suit_jacket/tan
	shoes = /obj/item/clothing/shoes/laceup
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	id_type = /obj/item/weapon/card/id/psychiatrist
	l_ear = /obj/item/device/radio/headset/headset_med
	back = null

/decl/hierarchy/outfit/job/site19/medical/chemist
	name = OUTFIT_JOB_NAME("Chemist")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/navyblue
	shoes = /obj/item/clothing/shoes/white
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	id_type = /obj/item/weapon/card/id/chemist
	l_pocket = /obj/item/device/radio
	l_ear = null
	back = null

/decl/hierarchy/outfit/job/site19/medical/medicaldoctor
	name = OUTFIT_JOB_NAME("Medical Doctor")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/blue
	shoes = /obj/item/clothing/shoes/white
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	id_type = /obj/item/weapon/card/id/doctor
	l_ear = /obj/item/device/radio/headset/headset_med
	back = null

/decl/hierarchy/outfit/job/site19/medical/virologist
	name = OUTFIT_JOB_NAME("Virologist")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/teal
	shoes = /obj/item/clothing/shoes/white
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	id_type = /obj/item/weapon/card/id/virologist
	l_ear = /obj/item/device/radio/headset/headset_med
	back = null

/decl/hierarchy/outfit/job/site19/medical/surgeon
	name = OUTFIT_JOB_NAME("Surgeon")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/green
	shoes = /obj/item/clothing/shoes/white
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	id_type = /obj/item/weapon/card/id/doctor
	l_ear = /obj/item/device/radio/headset/headset_med
	back = null

/decl/hierarchy/outfit/job/site19/medical/emt
	name = OUTFIT_JOB_NAME("Emergency Medical Technician")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/black
	shoes = /obj/item/clothing/shoes/white
	id_type = /obj/item/weapon/card/id/emt
	l_ear = /obj/item/device/radio/headset/headset_med
	back = null


// LOGISTICS OUTFITS

/decl/hierarchy/outfit/job/site19/crew/command/logisticsofficer
	name = OUTFIT_JOB_NAME("Logistics Officer")
	uniform = /obj/item/clothing/under/scp/utility/logistics/officer
	gloves = /obj/item/clothing/gloves/thick
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/logoff
	l_ear = /obj/item/device/radio/headset/headset_deckofficer
	back = null

/decl/hierarchy/outfit/job/site19/crew/command/logisticspecialist
	name = OUTFIT_JOB_NAME("Logistics Specialist")
	uniform = /obj/item/clothing/under/scp/utility/logistics
	gloves = /obj/item/clothing/gloves/thick
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/logspec
	l_pocket = /obj/item/device/radio
	l_ear = null
	back = null

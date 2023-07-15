//Torch ID Cards (they have to be here to make the outfits work, no way around it)

/obj/item/card/id/torch
	name = "identification card"
	desc = "An identification card issued to personnel aboard the SEV Torch."
	icon_state = "id"
	item_state = "card-id"
	job_access_type = /datum/job/classd

/obj/item/card/id/torch/silver
	desc = "A silver identification card belonging to heads of staff."
	icon_state = "silver"
	item_state = "silver_id"
	job_access_type = /datum/job/hop

/obj/item/card/id/torch/gold
	desc = "A golden identification card belonging to the Commanding Officer."
	icon_state = "gold"
	item_state = "gold_id"
	job_access_type = /datum/job/captain

/obj/item/card/id/torch/captains_spare
	name = "commanding officer's spare ID"
	desc = "The skipper's spare ID."
	icon_state = "gold"
	item_state = "gold_id"
	registered_name = "Commanding Officer"
	assignment = "Commanding Officer"
/obj/item/card/id/torch/captains_spare/New()
	access = get_all_site_access()
	..()

/*
// SolGov Crew and Contractors
/obj/item/card/id/torch/crew
	desc = "An identification card issued to SolGov crewmembers aboard the SEV Torch."
	icon_state = "solgov"
	job_access_type = /datum/job/crew


/obj/item/card/id/torch/contractor
	desc = "An identification card issued to private contractors aboard the SEV Torch."
	icon_state = "civ"
	job_access_type = /datum/job/classd


/obj/item/card/id/torch/silver/medical
	job_access_type = /datum/job/cmo

/obj/item/card/id/torch/crew/medical
	job_access_type = /datum/job/doctor

/obj/item/card/id/torch/crew/medical/senior
	job_access_type = /datum/job/senior_doctor

/obj/item/card/id/torch/contractor/medical
	job_access_type = /datum/job/doctor_contractor

/obj/item/card/id/torch/contractor/chemist
	job_access_type = /datum/job/chemist

/obj/item/card/id/torch/contractor/medical/counselor
	job_access_type = /datum/job/psychiatrist


/obj/item/card/id/torch/silver/security
	job_access_type = /datum/job/hos

/obj/item/card/id/torch/crew/security
	job_access_type = /datum/job/officer

/obj/item/card/id/torch/crew/security/brigofficer
	job_access_type = /datum/job/warden

/obj/item/card/id/torch/crew/security/forensic
	job_access_type = /datum/job/detective


/obj/item/card/id/torch/silver/engineering
	job_access_type = /datum/job/chief_engineer

/obj/item/card/id/torch/crew/engineering
	job_access_type = /datum/job/engineer

/obj/item/card/id/torch/crew/engineering/senior
	job_access_type = /datum/job/senior_engineer

/obj/item/card/id/torch/contractor/engineering
	job_access_type = /datum/job/engineer_contractor

/obj/item/card/id/torch/contractor/engineering/roboticist
	job_access_type = /datum/job/roboticist


/obj/item/card/id/torch/crew/supply/deckofficer
	job_access_type = /datum/job/qm

/obj/item/card/id/torch/crew/supply
	job_access_type = /datum/job/cargo_tech

/obj/item/card/id/torch/contractor/supply
	job_access_type = /datum/job/cargo_contractor


/obj/item/card/id/torch/crew/service //unused
	job_access_type = /datum/job/classd

/obj/item/card/id/torch/crew/service/janitor
	job_access_type = /datum/job/janitor

/obj/item/card/id/torch/crew/service/chef
	job_access_type = /datum/job/chef

/obj/item/card/id/torch/contractor/service //unused
	job_access_type = /datum/job/classd

/obj/item/card/id/torch/contractor/service/bartender
	job_access_type = /datum/job/bartender


/obj/item/card/id/torch/crew/representative
	job_access_type = /datum/job/representative

/obj/item/card/id/torch/crew/sea
	job_access_type = /datum/job/sea

/obj/item/card/id/torch/crew/bridgeofficer
	job_access_type = /datum/job/bridgeofficer

/obj/item/card/id/torch/crew/pathfinder
	job_access_type = /datum/job/pathfinder

/obj/item/card/id/torch/crew/explorer
	job_access_type = /datum/job/explorer

//NanoTrasen and Passengers

/obj/item/card/id/torch/passenger
	desc = "A card issued to passengers and off-duty personnel aboard the SEV Torch."
	icon_state = "id"
	job_access_type = /datum/job/classd

/obj/item/card/id/torch/passenger/research
	desc = "A card issued to NanoTrasen personnel aboard the SEV Torch."
	icon_state = "corporate"
	job_access_type = /datum/job/scientist_assistant

/obj/item/card/id/torch/silver/research
	job_access_type = /datum/job/rd

/obj/item/card/id/torch/passenger/research/senior_scientist
	job_access_type = /datum/job/senior_scientist

/obj/item/card/id/torch/passenger/research/nt_pilot
	job_access_type = /datum/job/nt_pilot

/obj/item/card/id/torch/passenger/research/scientist
	job_access_type = /datum/job/scientist

/obj/item/card/id/torch/passenger/research/mining
	job_access_type = /datum/job/mining

/obj/item/card/id/torch/passenger/research/guard
	job_access_type = /datum/job/guard

/obj/item/card/id/torch/passenger/research/liaison
	job_access_type = /datum/job/liaison

// SCP CARDS


//Merchant
/obj/item/card/id/torch/merchant
	desc = "An identification card issued to Merchants, indicating their right to sell and buy goods."
	icon_state = "trader"
	job_access_type = /datum/job/merchant

//Stowaway
/obj/item/card/id/torch/stowaway
	desc = "An identification card issued to personnel aboard the SEV Torch. Looks like the photo fell off this one."
	icon_state = "id"
	job_access_type = /datum/job/crew
*/
/obj/item/card/id/torch/stowaway/New()
	..()
//	var/species = SPECIES_HUMAN
//	if(prob(10))
//		species = pick(SPECIES_SKRELL, SPECIES_IPC)
//	var/datum/species/S = all_species[species]
	var/gender = pick(MALE,FEMALE)
//	registered_name = S.get_random_name(gender)
	sex = capitalize(gender)
	age = rand(19,25)
	fingerprint_hash = md5(registered_name)
	dna_hash = md5(fingerprint_hash)
	blood_type = RANDOM_BLOOD_TYPE
//	update_name()

/obj/item/card/id/scp13/
	desc = "A golden identification card belonging to the Commanding Officer."
	icon_state = "gold"
	item_state = "gold_id"
	job_access_type = /datum/job/captain
/*
***************
***SCP CARDS***
***************
*/

// Currently, cards have to be added for each job and have their own unique identifier if we want access to be made more unique. So that's what we're doing here.

// TEMP CARDS

/obj/item/card/id/seclvl1
	name = " security ID"
	desc = "A light blue card. Seems almost as unimportant as the person itself."
	icon_state = "securitylvl1"
	item_state = "Sec_ID1"
	job_access_type = /datum/job/enlistedofficerlcz

/obj/item/card/id/seclvl2
	name = " security ID"
	desc = "A dark purple ID. Looks important. The person wearing it, not at all."
	icon_state = "securitylvl2"
	item_state = "Sec_ID2"
	job_access_type = /datum/job/juneng

/obj/item/card/id/seclvl3
	name = " security ID"
	desc = "A dark blue ID. Looks important. The person wearing it not so much."
	icon_state = "securitylvl3"
	item_state = "Sec_ID3"
	job_access_type = /datum/job/eng

/obj/item/card/id/seclvl4
	name = " security ID"
	desc = "A teal ID. Looks cool."
	icon_state = "securitylvl4"
	item_state = "Sec_ID4"
	job_access_type = /datum/job/seneng

//ENGINEERING

/obj/item/card/id/seclvl2eng
	name = " security ID"
	desc = "A dark purple ID. Looks important. The person wearing it, not at all."
	icon_state = "securitylvl2"
	item_state = "Sec_ID2"
	job_access_type = /datum/job/juneng

/obj/item/card/id/seclvl3eng
	name = " security ID"
	desc = "A dark blue ID. Looks important. The person wearing it not so much."
	icon_state = "securitylvl3"
	item_state = "Sec_ID3"
	job_access_type = /datum/job/eng

/obj/item/card/id/seclvl4eng
	name = " security ID"
	desc = "A teal ID. Looks cool."
	icon_state = "securitylvl4"
	item_state = "Sec_ID4"
	job_access_type = /datum/job/seneng


/obj/item/card/id/seclvl5eng
	name = " security ID"
	desc = "A teal ID. Looks cool."
	icon_state = "securitylvl5"
	item_state = "Sec_ID5"
	job_access_type = /datum/job/chief_engineer

// JUNIOR GUARD ID'S

/obj/item/card/id/junseclvl2lcz
	name = " security ID"
	desc = "A light blue card. Seems almost as unimportant as the person itself."
	icon_state = "securitylvl1"
	item_state = "Sec_ID1"
	job_access_type = /datum/job/enlistedofficerlcz

/obj/item/card/id/junseclvl2ez
	name = " security ID"
	desc = "A dark purple ID. Looks important. The person wearing it, not at all."
	icon_state = "securitylvl2"
	item_state = "Sec_ID2"
	job_access_type = /datum/job/enlistedofficerez

/obj/item/card/id/junseclvl3hcz
	name = " security ID"
	desc = "A dark blue ID. Looks important. The person wearing it not so much."
	icon_state = "securitylvl3"
	item_state = "Sec_ID3"
	job_access_type = /datum/job/enlistedofficerhcz

// GUARD ID'S.
/obj/item/card/id/seclvl3lcz
	name = " security ID"
	desc = "A dark purple ID. Looks important. The person wearing it, not at all."
	icon_state = "securitylvl2"
	item_state = "Sec_ID2"
	job_access_type = /datum/job/ncoofficerlcz

/obj/item/card/id/seclvl3ez
	name = " security ID"
	desc = "A dark blue ID. Looks important. The person wearing it not so much."
	icon_state = "securitylvl3"
	item_state = "Sec_ID3"
	job_access_type = /datum/job/ncoofficerez

/obj/item/card/id/seclvl3hcz
	name = " security ID"
	desc = "A dark blue ID. Looks important. The person wearing it not so much."
	icon_state = "securitylvl3"
	item_state = "Sec_ID3"
	job_access_type = /datum/job/ncoofficerhcz

// ZC ID'S

/obj/item/card/id/zcseclvl4hcz
	name = " security ID"
	desc = "A teal ID. Looks cool."
	icon_state = "securitylvl4"
	item_state = "Sec_ID4"
	job_access_type = /datum/job/ltofficerhcz

/obj/item/card/id/zcseclvl3lcz
	name = " security ID"
	desc = "A teal ID. A dark blue ID. Looks important. The person wearing it not so much."
	icon_state = "securitylvl3"
	item_state = "Sec_ID3"
	job_access_type = /datum/job/ltofficerlcz

/obj/item/card/id/zcseclvl4ez
	name = " security ID"
	desc = "A teal ID. Looks cool."
	icon_state = "securitylvl4"
	item_state = "Sec_ID4"
	job_access_type = /datum/job/ltofficerez

// GC ID.

/obj/item/card/id/gcseclvl5
	name = " security ID"
	desc = "A dark purple ID. Looks important."
	icon_state = "securitylvl5"
	item_state = "Sec_ID5"
	job_access_type = /datum/job/hos

// SCIENCE

/obj/item/card/id/sciencelvl1
	name = " science ID"
	desc = "A light blue ID. Haven't you seen a janitor with this before?"
	icon_state = "sciencelvl1"
	item_state = "Science_ID1"
	job_access_type = /datum/job/juniorscientist

/obj/item/card/id/sciencelvl2
	name = " science ID"
	desc = "A bright yellow ID. Looks ordinary?"
	icon_state = "sciencelvl2"
	item_state = "Science_ID2"
	job_access_type = /datum/job/scientist

/obj/item/card/id/sciencelvl3
	name = " science ID"
	desc = "A dark yellow ID. Looks cool, the person wearing it, not so much."
	icon_state = "sciencelvl3"
	item_state = "Science_ID3"
	job_access_type = /datum/job/scientist

/obj/item/card/id/sciencelvl4
	name = " science ID"
	desc = "An orange ID. Looks important."
	icon_state = "sciencelvl4"
	item_state = "Science_ID4"
	job_access_type = /datum/job/seniorscientist

/obj/item/card/id/sciencelvl5
	name = " science ID"
	desc = "A red ID. Looks like the person wearing this won't give it up easy."
	icon_state = "sciencelvl5"
	item_state = "Science_ID5"
	job_access_type = /datum/job/rd

// ADMIN
/obj/item/card/id/adminlvl1
	name = " administration ID"
	desc = "A black ID. Looks like the person wearing this won't give it up easy."
	icon_state = "adminlvl1"
	item_state = "Admin_ID"
//	job_access_type = /datum/job/rd

/obj/item/card/id/adminlvl2
	name = " administration ID"
	desc = "A black ID. Looks like the person wearing this won't give it up easy."
	icon_state = "adminlvl2"
	item_state = "Admin_ID"
//	job_access_type = /datum/job/rd

/obj/item/card/id/adminlvl3
	name = " administration ID"
	desc = "A black ID. Looks like the person wearing this won't give it up easy."
	icon_state = "adminlvl3"
	item_state = "Admin_ID"
	job_access_type = /datum/job/goirep

/obj/item/card/id/adminlvl4
	name = " administration ID"
	desc = "A black ID. Looks like the person wearing this won't give it up easy."
	icon_state = "adminlvl4"
	item_state = "Admin_ID"
	job_access_type = /datum/job/hop

/obj/item/card/id/adminlvl5
	name = " administration ID"
	desc = "A black ID. Looks like the person wearing this won't give it up easy."
	icon_state = "adminlvl5"
	item_state = "Admin_ID"
	job_access_type = /datum/job/captain

// ERT CARDS

/obj/item/card/id/mtf
	name = " mobile task force ID"
	desc = "A black ID. Looks like the person wearing this won't give it up easy."
	icon_state = "adminlvl5"
	item_state = "Admin_ID"

/obj/item/card/id/mtf/Initialize()
	. = ..()
	rank = "Mobile Task Force Operative"
	access |= get_all_station_access()


/obj/item/card/id/physics
	name = " military ID"
	desc = "A dark purple ID. Looks like the person wearing this won't give it up easy."
	icon_state = "securitylvl5"
	item_state = "Sec_ID5"

/obj/item/card/id/physics/Initialize()
	. = ..()
	rank = "UNGOC Physics Operative"
	access |= get_all_station_access()

// COMMS CARDS

/obj/item/card/id/commslvl1
	name = " administration ID"
	desc = "A black ID. A black ID. Looks like the person wearing this won't give it up easy."
	job_access_type = /datum/job/commeng
	icon_state = "adminlvl1"
	item_state = "Admin_ID"

/obj/item/card/id/commslvl4
	name = " administration ID"
	desc = "A black ID. A black ID. Looks like the person wearing this won't give it up easy."
	job_access_type = /datum/job/commsofficer
	icon_state = "adminlvl4"
	item_state = "Admin_ID"

// MEDICAL CARDS

/obj/item/card/id/emt
	name = " security ID"
	desc = "A light blue card. Seems almost as unimportant as the person itself."
	icon_state = "securitylvl1"
	item_state = "Sec_ID1"
	job_access_type = /datum/job/emt

/obj/item/card/id/chemist
	name = " security ID"
	desc = "A light blue card. Seems almost as unimportant as the person itself."
	icon_state = "securitylvl2"
	item_state = "Sec_ID2"
	job_access_type = /datum/job/chemist

/obj/item/card/id/doctor
	name = " security ID"
	desc = "A light blue card. Seems almost as unimportant as the person itself."
	icon_state = "securitylvl2"
	item_state = "Sec_ID2"
	job_access_type = /datum/job/medicaldoctor

/obj/item/card/id/chiefmedicalofficer
	name = " security ID"
	desc = "A dark purple ID. Looks important."
	icon_state = "securitylvl5"
	item_state = "Sec_ID5"
	job_access_type = /datum/job/cmo

/obj/item/card/id/psychiatrist
	name = " administration ID"
	desc = "A light blue card. Seems important."
	icon_state = "adminlvl3"
	item_state = "Admin_ID"
	job_access_type = /datum/job/psychiatrist


// ARCHIVE

/obj/item/card/id/archivist
	name = " administration ID"
	desc = "A black ID. Looks like the person wearing this won't give it up easy."
	icon_state = "adminlvl5"
	item_state = "Admin_ID"
	job_access_type = /datum/job/archivist

// RESEARCH

/obj/item/card/id/rd
	name = " science ID"
	desc = "A red ID. Looks like the person wearing this won't give it up easy."
	icon_state = "sciencelvl5"
	item_state = "Science_ID5"
	job_access_type = /datum/job/rd

// MISC

/obj/item/card/id/chef
	name = " science ID"
	desc = "A light blue ID. Haven't you seen a janitor with this before?"
	icon_state = "sciencelvl1"
	item_state = "Science_ID1"
	job_access_type = /datum/job/chef

/obj/item/card/id/bartender
	name = " science ID"
	desc = "A light blue ID. Haven't you seen a janitor with this before?"
	icon_state = "sciencelvl1"
	item_state = "Science_ID1"
	job_access_type = /datum/job/bartender

// LOGISTICS


/obj/item/card/id/logoff
	name = " security ID"
	desc = "A dark blue ID. Looks important. The person wearing it not so much."
	icon_state = "securitylvl3"
	item_state = "Sec_ID3"
	job_access_type = /datum/job/qm


/obj/item/card/id/logspec
	name = " security ID"
	desc = "A dark blue ID. Looks important. The person wearing it not so much."
	icon_state = "securitylvl3"
	item_state = "Sec_ID3"
	job_access_type = /datum/job/cargo_tech



/obj/item/card/id/dmining
	name = " Mining Assignment Card"
	desc = "A dark blue ID. Looks important. The person wearing it not so much."
	access = ACCESS_DCLASS_MINING
/obj/item/card/id/dbotany
	name = " Botany Assignment Card"
	desc = "A dark blue ID. Looks important. The person wearing it not so much."
	access = ACCESS_DCLASS_BOTANY

/obj/item/card/id/dkitchen
	name = " Kitchen Assignment Card"
	desc = "A dark blue ID. Looks important. The person wearing it not so much."
	access = ACCESS_DCLASS_KITCHEN

/obj/item/card/id/djanitorial
	name = " Janitorial Assignment Card"
	desc = "A dark blue ID. Looks important. The person wearing it not so much."
	access = ACCESS_DCLASS_JANITORIAL


/obj/item/card/id/officeworker
	name = "Office Staff ID"
	desc = "A low level ID issued to office workers."
	icon_state = "adminlvl1"
	item_state = "Admin_ID"
	job_access_type = /datum/job/officeworker

/obj/item/card/id/classd
	name = "Class-D ID"
	desc = "An ID card issued to Class-D Foundation personnel."
	icon_state = "classd"
	item_state = "Admin_ID"
	job_access_type = /datum/job/classd

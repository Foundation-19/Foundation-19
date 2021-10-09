//Torch ID Cards (they have to be here to make the outfits work, no way around it)

/obj/item/weapon/card/id/torch
	name = "identification card"
	desc = "An identification card issued to personnel aboard the SEV Torch."
	icon_state = "id"
	item_state = "card-id"
	job_access_type = /datum/job/assistant

/obj/item/weapon/card/id/torch/silver
	desc = "A silver identification card belonging to heads of staff."
	icon_state = "silver"
	item_state = "silver_id"
	job_access_type = /datum/job/hop

/obj/item/weapon/card/id/torch/gold
	desc = "A golden identification card belonging to the Commanding Officer."
	icon_state = "gold"
	item_state = "gold_id"
	job_access_type = /datum/job/captain

/obj/item/weapon/card/id/torch/captains_spare
	name = "commanding officer's spare ID"
	desc = "The skipper's spare ID."
	icon_state = "gold"
	item_state = "gold_id"
	registered_name = "Commanding Officer"
	assignment = "Commanding Officer"
/obj/item/weapon/card/id/torch/captains_spare/New()
	access = get_all_station_access()
	..()

/*
// SolGov Crew and Contractors
/obj/item/weapon/card/id/torch/crew
	desc = "An identification card issued to SolGov crewmembers aboard the SEV Torch."
	icon_state = "solgov"
	job_access_type = /datum/job/crew


/obj/item/weapon/card/id/torch/contractor
	desc = "An identification card issued to private contractors aboard the SEV Torch."
	icon_state = "civ"
	job_access_type = /datum/job/assistant


/obj/item/weapon/card/id/torch/silver/medical
	job_access_type = /datum/job/cmo

/obj/item/weapon/card/id/torch/crew/medical
	job_access_type = /datum/job/doctor

/obj/item/weapon/card/id/torch/crew/medical/senior
	job_access_type = /datum/job/senior_doctor

/obj/item/weapon/card/id/torch/contractor/medical
	job_access_type = /datum/job/doctor_contractor

/obj/item/weapon/card/id/torch/contractor/chemist
	job_access_type = /datum/job/chemist

/obj/item/weapon/card/id/torch/contractor/medical/counselor
	job_access_type = /datum/job/psychiatrist


/obj/item/weapon/card/id/torch/silver/security
	job_access_type = /datum/job/hos

/obj/item/weapon/card/id/torch/crew/security
	job_access_type = /datum/job/officer

/obj/item/weapon/card/id/torch/crew/security/brigofficer
	job_access_type = /datum/job/warden

/obj/item/weapon/card/id/torch/crew/security/forensic
	job_access_type = /datum/job/detective


/obj/item/weapon/card/id/torch/silver/engineering
	job_access_type = /datum/job/chief_engineer

/obj/item/weapon/card/id/torch/crew/engineering
	job_access_type = /datum/job/engineer

/obj/item/weapon/card/id/torch/crew/engineering/senior
	job_access_type = /datum/job/senior_engineer

/obj/item/weapon/card/id/torch/contractor/engineering
	job_access_type = /datum/job/engineer_contractor

/obj/item/weapon/card/id/torch/contractor/engineering/roboticist
	job_access_type = /datum/job/roboticist


/obj/item/weapon/card/id/torch/crew/supply/deckofficer
	job_access_type = /datum/job/qm

/obj/item/weapon/card/id/torch/crew/supply
	job_access_type = /datum/job/cargo_tech

/obj/item/weapon/card/id/torch/contractor/supply
	job_access_type = /datum/job/cargo_contractor


/obj/item/weapon/card/id/torch/crew/service //unused
	job_access_type = /datum/job/assistant

/obj/item/weapon/card/id/torch/crew/service/janitor
	job_access_type = /datum/job/janitor

/obj/item/weapon/card/id/torch/crew/service/chef
	job_access_type = /datum/job/chef

/obj/item/weapon/card/id/torch/contractor/service //unused
	job_access_type = /datum/job/assistant

/obj/item/weapon/card/id/torch/contractor/service/bartender
	job_access_type = /datum/job/bartender


/obj/item/weapon/card/id/torch/crew/representative
	job_access_type = /datum/job/representative

/obj/item/weapon/card/id/torch/crew/sea
	job_access_type = /datum/job/sea

/obj/item/weapon/card/id/torch/crew/bridgeofficer
	job_access_type = /datum/job/bridgeofficer

/obj/item/weapon/card/id/torch/crew/pathfinder
	job_access_type = /datum/job/pathfinder

/obj/item/weapon/card/id/torch/crew/explorer
	job_access_type = /datum/job/explorer

//NanoTrasen and Passengers

/obj/item/weapon/card/id/torch/passenger
	desc = "A card issued to passengers and off-duty personnel aboard the SEV Torch."
	icon_state = "id"
	job_access_type = /datum/job/assistant

/obj/item/weapon/card/id/torch/passenger/research
	desc = "A card issued to NanoTrasen personnel aboard the SEV Torch."
	icon_state = "corporate"
	job_access_type = /datum/job/scientist_assistant

/obj/item/weapon/card/id/torch/silver/research
	job_access_type = /datum/job/rd

/obj/item/weapon/card/id/torch/passenger/research/senior_scientist
	job_access_type = /datum/job/senior_scientist

/obj/item/weapon/card/id/torch/passenger/research/nt_pilot
	job_access_type = /datum/job/nt_pilot

/obj/item/weapon/card/id/torch/passenger/research/scientist
	job_access_type = /datum/job/scientist

/obj/item/weapon/card/id/torch/passenger/research/mining
	job_access_type = /datum/job/mining

/obj/item/weapon/card/id/torch/passenger/research/guard
	job_access_type = /datum/job/guard

/obj/item/weapon/card/id/torch/passenger/research/liaison
	job_access_type = /datum/job/liaison

// SCP CARDS


//Merchant
/obj/item/weapon/card/id/torch/merchant
	desc = "An identification card issued to Merchants, indicating their right to sell and buy goods."
	icon_state = "trader"
	job_access_type = /datum/job/merchant

//Stowaway
/obj/item/weapon/card/id/torch/stowaway
	desc = "An identification card issued to personnel aboard the SEV Torch. Looks like the photo fell off this one."
	icon_state = "id"
	job_access_type = /datum/job/crew
*/
/obj/item/weapon/card/id/torch/stowaway/New()
	..()
	var/species = SPECIES_HUMAN
	if(prob(10))
		species = pick(SPECIES_SKRELL,SPECIES_TAJARA,SPECIES_IPC)
	var/datum/species/S = all_species[species]
	var/gender = pick(MALE,FEMALE)
	registered_name = S.get_random_name(gender)
	sex = capitalize(gender)
	age = rand(19,25)
	fingerprint_hash = md5(registered_name)
	dna_hash = md5(fingerprint_hash)
	blood_type = RANDOM_BLOOD_TYPE
	update_name()

/obj/item/weapon/card/id/scp13/
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
/*
/obj/item/weapon/card/id/seclvl1
	name = "level one security keycard"
	desc = "A light blue card. Seems almost as unimportant as the person itself."
	icon_state = "securitylvl1"
	item_state = "Sec_ID1"
	job_access_type = /datum/job/enlistedofficer
*/
/obj/item/weapon/card/id/seclvl2
	name = "level two security keycard"
	desc = "A dark purple keycard. Looks important. The person wearing it, not at all."
	icon_state = "securitylvl2"
	item_state = "Sec_ID2"
	job_access_type = /datum/job/juneng

/obj/item/weapon/card/id/seclvl3
	name = "level three security keycard"
	desc = "A dark blue keycard. Looks important. The person wearing it not so much."
	icon_state = "securitylvl3"
	item_state = "Sec_ID3"
	job_access_type = /datum/job/eng

/obj/item/weapon/card/id/seclvl4
	name = "level four security keycard"
	desc = "A teal keycard. Looks cool."
	icon_state = "securitylvl4"
	item_state = "Sec_ID4"
	job_access_type = /datum/job/seneng



// JUNIOR GUARD ID'S

/obj/item/weapon/card/id/junseclvl1
	name = "level one security keycard"
	desc = "A light blue card. Seems almost as unimportant as the person itself."
	icon_state = "securitylvl1"
	item_state = "Sec_ID1"
	job_access_type = /datum/job/enlistedofficerlcz

// GUARD ID'S.

/obj/item/weapon/card/id/seclvl3hcz
	name = "level three security keycard"
	desc = "A dark blue keycard. Looks important. The person wearing it not so much."
	icon_state = "securitylvl3"
	item_state = "Sec_ID3"
	job_access_type = /datum/job/ncoofficerhcz

// ZC ID'S

/obj/item/weapon/card/id/zcseclvl4hcz
	name = "level four security keycard"
	desc = "A teal keycard. Looks cool."
	icon_state = "securitylvl4"
	item_state = "Sec_ID4"
	job_access_type = /datum/job/ltofficerhcz

// GC ID.

/obj/item/weapon/card/id/gcseclvl5
	name = "level five security keycard"
	desc = "A dark purple keycard. Looks important."
	icon_state = "securitylvl5"
	item_state = "Sec_ID5"
	job_access_type = /datum/job/hos

// SCIENCE

/obj/item/weapon/card/id/sciencelvl1
	name = "level one science keycard"
	desc = "A light blue keycard. Haven't you seen a janitor with this before?"
	icon_state = "sciencelvl1"
	item_state = "Science_ID1"
	job_access_type = /datum/job/juniorscientist

/obj/item/weapon/card/id/sciencelvl2
	name = "level two science keycard"
	desc = "A bright yellow keycard. Looks ordinary?"
	icon_state = "sciencelvl2"
	item_state = "Science_ID2"
	job_access_type = /datum/job/scientist

/obj/item/weapon/card/id/sciencelvl3
	name = "level three science keycard"
	desc = "A dark yellow keycard. Looks cool, the person wearing it, not so much."
	icon_state = "sciencelvl3"
	item_state = "Science_ID3"
	job_access_type = /datum/job/scientist

/obj/item/weapon/card/id/sciencelvl4
	name = "level four science keycard"
	desc = "An orange keycard. Looks important."
	icon_state = "sciencelvl4"
	item_state = "Science_ID4"
	job_access_type = /datum/job/seniorscientist

/obj/item/weapon/card/id/sciencelvl5
	name = "level five science keycard"
	desc = "A red keycard. Looks like the person wearing this won't give it up easy."
	icon_state = "sciencelvl5"
	item_state = "Science_ID5"
	job_access_type = /datum/job/rd

// ADMIN
/obj/item/weapon/card/id/adminlvl1
	name = "level one administration keycard"
	desc = "A black keycard. Looks like the person wearing this won't give it up easy."
	icon_state = "adminlvl1"
	item_state = "Admin_ID"
//	job_access_type = /datum/job/rd

/obj/item/weapon/card/id/adminlvl2
	name = "level two administration keycard"
	desc = "A black keycard. Looks like the person wearing this won't give it up easy."
	icon_state = "adminlvl2"
	item_state = "Admin_ID"
//	job_access_type = /datum/job/rd

/obj/item/weapon/card/id/adminlvl3
	name = "level three administration keycard"
	desc = "A black keycard. Looks like the person wearing this won't give it up easy."
	icon_state = "adminlvl3"
	item_state = "Admin_ID"
//	job_access_type = /datum/job/rd

/obj/item/weapon/card/id/adminlvl4
	name = "level four administration keycard"
	desc = "A black keycard. Looks like the person wearing this won't give it up easy."
	icon_state = "adminlvl4"
	item_state = "Admin_ID"
	job_access_type = /datum/job/hop

/obj/item/weapon/card/id/adminlvl5
	name = "level five administration keycard"
	desc = "A black keycard. Looks like the person wearing this won't give it up easy."
	icon_state = "adminlvl5"
	item_state = "Admin_ID"
	job_access_type = /datum/job/captain

// COMMS CARDS

/obj/item/weapon/card/id/commslvl1
	name = "level one administration keycard"
	desc = "A black keycard. A black keycard. Looks like the person wearing this won't give it up easy."
	job_access_type = /datum/job/commeng
	icon_state = "adminlvl1"
	item_state = "Admin_ID"

/obj/item/weapon/card/id/commslvl4
	name = "level four administration keycard"
	desc = "A black keycard. A black keycard. Looks like the person wearing this won't give it up easy."
	job_access_type = /datum/job/commsofficer
	icon_state = "adminlvl4"
	item_state = "Admin_ID"

// MEDICAL CARDS

/obj/item/weapon/card/id/emt
	name = "level one security keycard"
	desc = "A light blue card. Seems almost as unimportant as the person itself."
	icon_state = "securitylvl1"
	item_state = "Sec_ID1"
	job_access_type = /datum/job/emt

/obj/item/weapon/card/id/chemist
	name = "level two security keycard"
	desc = "A light blue card. Seems almost as unimportant as the person itself."
	icon_state = "securitylvl2"
	item_state = "Sec_ID2"
	job_access_type = /datum/job/chemist

/obj/item/weapon/card/id/doctor
	name = "level two security keycard"
	desc = "A light blue card. Seems almost as unimportant as the person itself."
	icon_state = "securitylvl2"
	item_state = "Sec_ID2"
	job_access_type = /datum/job/medicaldoctor

/obj/item/weapon/card/id/chiefmedicalofficer
	name = "level five security keycard"
	desc = "A dark purple keycard. Looks important."
	icon_state = "securitylvl5"
	item_state = "Sec_ID5"
	job_access_type = /datum/job/cmo

/obj/item/weapon/card/id/virologist
	name = "level two security keycard"
	desc = "A light blue card. Seems almost as unimportant as the person itself."
	icon_state = "adminlvl2"
	item_state = "Admin_ID"
	job_access_type = /datum/job/virologist

/obj/item/weapon/card/id/psychiatrist
	name = "level three administration keycard"
	desc = "A light blue card. Seems important."
	icon_state = "adminlvl3"
	item_state = "Admin_ID"
	job_access_type = /datum/job/psychiatrist


// ARCHIVE

/obj/item/weapon/card/id/archivist
	name = "level five administration keycard"
	desc = "A black keycard. Looks like the person wearing this won't give it up easy."
	icon_state = "adminlvl5"
	item_state = "Admin_ID"
	job_access_type = /datum/job/archivist

// RESEARCH

/obj/item/weapon/card/id/rd
	name = "level five science keycard"
	desc = "A red keycard. Looks like the person wearing this won't give it up easy."
	icon_state = "sciencelvl5"
	item_state = "Science_ID5"
	job_access_type = /datum/job/rd

// MISC

/obj/item/weapon/card/id/chef
	name = "level five science keycard"
	desc = "A light blue keycard. Haven't you seen a janitor with this before?"
	icon_state = "sciencelvl1"
	item_state = "Science_ID1"
	job_access_type = /datum/job/chef

/obj/item/weapon/card/id/bartender
	name = "level one science keycard"
	desc = "A light blue keycard. Haven't you seen a janitor with this before?"
	icon_state = "sciencelvl1"
	item_state = "Science_ID1"
	job_access_type = /datum/job/bartender

// LOGISTICS


/obj/item/weapon/card/id/logoff
	name = "level three security keycard"
	desc = "A dark blue keycard. Looks important. The person wearing it not so much."
	icon_state = "securitylvl3"
	item_state = "Sec_ID3"
	job_access_type = /datum/job/qm


/obj/item/weapon/card/id/logspec
	name = "level three security keycard"
	desc = "A dark blue keycard. Looks important. The person wearing it not so much."
	icon_state = "securitylvl3"
	item_state = "Sec_ID3"
	job_access_type = /datum/job/cargo_tech
/datum/map/site19
	branch_types = list(
		/datum/mil_branch/security,
		/datum/mil_branch/civilian
	)

	spawn_branch_types = list(
		/datum/mil_branch/security,
		/datum/mil_branch/civilian
	)


/*
 *  Branches
 *  ========
 */

/datum/mil_branch/security
	name = "Security Branch"
	name_short = "SB"
	email_domain = "site53.foundation"

	rank_types = list(
		/datum/mil_rank/security/e1,
		/datum/mil_rank/security/e2,
		/datum/mil_rank/security/e3,
		/datum/mil_rank/security/e4,
		/datum/mil_rank/security/e5,
		/datum/mil_rank/security/e6,
		/datum/mil_rank/security/e7,
		/datum/mil_rank/security/e8,
		/datum/mil_rank/security/e9,
		/datum/mil_rank/security/e9_alt1,
		/datum/mil_rank/security/w1,
		/datum/mil_rank/security/w2,
		/datum/mil_rank/security/w3,
		/datum/mil_rank/security/w4,
		/datum/mil_rank/security/w5,
		/datum/mil_rank/security/w6,
		/datum/mil_rank/security/o1,
		/datum/mil_rank/security/o2,
		/datum/mil_rank/security/o3,
		/datum/mil_rank/security/o4,
		/datum/mil_rank/security/o5,
		/datum/mil_rank/security/o6,
		/datum/mil_rank/security/o7,
		/datum/mil_rank/security/o8,
		/datum/mil_rank/security/o9,
		/datum/mil_rank/security/o10,
	)

	spawn_rank_types = list(
		/datum/mil_rank/security/e1,
		/datum/mil_rank/security/e2,
		/datum/mil_rank/security/e3,
		/datum/mil_rank/security/e4,
		/datum/mil_rank/security/e5,
		/datum/mil_rank/security/e6,
		/datum/mil_rank/security/e7,
		/datum/mil_rank/security/e8,
		/datum/mil_rank/security/e9,
		/datum/mil_rank/security/w1,
		/datum/mil_rank/security/w2,
		/datum/mil_rank/security/w3,
		/datum/mil_rank/security/w4,
		/datum/mil_rank/security/w5,
		/datum/mil_rank/security/w6,
		/datum/mil_rank/security/o1,
		/datum/mil_rank/security/o2,
		/datum/mil_rank/security/o3,
		/datum/mil_rank/security/o4,
		/datum/mil_rank/security/o5,
		/datum/mil_rank/security/o6
	)

//	assistant_job = "Private"

//	assistant_job = "Crewman"

/datum/mil_branch/civilian
	name = "Civilian"
	name_short = "civ"
	email_domain = "site53.foundation"

	rank_types = list(
		/datum/mil_rank/civ/classa,
		/datum/mil_rank/civ/classb,
		/datum/mil_rank/civ/classc,
		/datum/mil_rank/civ/classd,
		/datum/mil_rank/civ/classe
	)

	spawn_rank_types = list(
		/datum/mil_rank/civ/classa,
		/datum/mil_rank/civ/classb,
		/datum/mil_rank/civ/classc,
		/datum/mil_rank/civ/classd
	)

//	assistant_job = "Passenger"

/datum/mil_rank/grade()
	. = ..()
	if(!sort_order)
		return ""
	if(sort_order <= 10)
		return "E[sort_order]"
	return "O[sort_order - 10]"
/*
 *  Security
 *  ========
 */

/datum/mil_rank/security/e1
	name = "Recruit"
	name_short = "PSR"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/enlisted, /obj/item/clothing/accessory/solgov/specialty/enlisted)
	sort_order = 1

/datum/mil_rank/security/e2
	name = "Junior Protection Specialist"
	name_short = "JPS"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/enlisted/e2, /obj/item/clothing/accessory/solgov/specialty/enlisted)
	sort_order = 2

/datum/mil_rank/security/e3
	name = "Protection Specialist"
	name_short = "1PS"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/enlisted/e3, /obj/item/clothing/accessory/solgov/specialty/enlisted)
	sort_order = 3

/datum/mil_rank/security/e4
	name = "Senior Protection Specialist"
	name_short = "SPS"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/enlisted/e4, /obj/item/clothing/accessory/solgov/specialty/enlisted)
	sort_order = 4

/datum/mil_rank/security/e5
	name = "Master Protection Specialist"
	name_short = "MPS"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/enlisted/e5, /obj/item/clothing/accessory/solgov/specialty/enlisted)
	sort_order = 5

/datum/mil_rank/security/e6
	name = "Junior Protection Officer"
	name_short = "JPO"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/enlisted/e6, /obj/item/clothing/accessory/solgov/specialty/enlisted)
	sort_order = 6

/datum/mil_rank/security/e7
	name = "Protection Officer"
	name_short = "PO"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/enlisted/e7, /obj/item/clothing/accessory/solgov/specialty/enlisted)
	sort_order = 7

/datum/mil_rank/security/e8
	name = "Senior Protection Officer"
	name_short = "SPO"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/enlisted/e8, /obj/item/clothing/accessory/solgov/specialty/enlisted)
	sort_order = 8

/datum/mil_rank/security/e9
	name = "Master Protection Officer"
	name_short = "MPO"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/enlisted/e9, /obj/item/clothing/accessory/solgov/specialty/enlisted)
	sort_order = 9

/datum/mil_rank/security/e9_alt1
	name = "O5 Protection Official"
	name_short = "O5PO"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/enlisted/e9_alt1, /obj/item/clothing/accessory/solgov/specialty/enlisted)
	sort_order = 9
/*
/datum/mil_rank/security/e9_alt2
	name = "Command Sergeant Major"
	name_short = "CSM"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/enlisted/e9_alt2, /obj/item/clothing/accessory/solgov/specialty/enlisted)
	sort_order = 9
*/
/datum/mil_rank/security/w1
	name = "Technical Specialist"
	name_short = "TS"
	sort_order = -1
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/warrant)

/datum/mil_rank/security/w2
	name = "Containment Specialist 1"
	name_short = "CS1"
	sort_order = -2
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/warrant/w2)

/datum/mil_rank/security/w3
	name = "Containment Specialist 2"
	name_short = "CS2"
	sort_order = -3
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/warrant/w3)

/datum/mil_rank/security/w4
	name = "Containment Specialist 3"
	name_short = "CS3"
	sort_order = -4
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/warrant/w4)

/datum/mil_rank/security/w5
	name = "Site Specialist"
	name_short = "SiS"
	sort_order = -5
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/warrant/w5)

/datum/mil_rank/security/w6
	name = "O5 Site Specialist"
	name_short = "O5SiS"
	sort_order = -6
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/warrant/w6)

/datum/mil_rank/security/o1
	name = "Junior Lieutenant"
	name_short = "JLT"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/junofficer, /obj/item/clothing/accessory/solgov/specialty/officer)
	sort_order = 11

/datum/mil_rank/security/o2
	name = "Senior Lieutenant"
	name_short = "SLT"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/junofficer/o2, /obj/item/clothing/accessory/solgov/specialty/officer)
	sort_order = 12

/datum/mil_rank/security/o3
	name = "Site Lieutenant"
	name_short = "SiLT"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/officer, /obj/item/clothing/accessory/solgov/specialty/officer)
	sort_order = 13

/datum/mil_rank/security/o4
	name = "Captain"
	name_short = "CPT"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/officer/o4, /obj/item/clothing/accessory/solgov/specialty/officer)
	sort_order = 14

/datum/mil_rank/security/o5
	name = "Commander"
	name_short = "CMDR"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/officer/o5, /obj/item/clothing/accessory/solgov/specialty/officer)
	sort_order = 15

/datum/mil_rank/security/o6
	name = "Site Commander"
	name_short = "SiCMDR"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/officer/o6, /obj/item/clothing/accessory/solgov/specialty/officer)
	sort_order = 16

/datum/mil_rank/security/o7
	name = "Tertiary Division Leader"
	name_short = "TDL"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/flag, /obj/item/clothing/accessory/solgov/specialty/officer)
	sort_order = 17

/datum/mil_rank/security/o8
	name = "Secopndary Division Leader"
	name_short = "SDL"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/flag/o8, /obj/item/clothing/accessory/solgov/specialty/officer)
	sort_order = 18

/datum/mil_rank/security/o9
	name = "Primary Divsiion Leader"
	name_short = "PDL"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/flag/o9, /obj/item/clothing/accessory/solgov/specialty/officer)
	sort_order = 19

/datum/mil_rank/security/o10
	name = "O5 Strategic Specialist"
	name_short = "O5StS"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/flag/o10, /obj/item/clothing/accessory/solgov/specialty/officer)
	sort_order = 20
/*
/datum/mil_rank/security/o10_alt
	name = "Division General"
	name_short = "DG"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/flag/o10_alt, /obj/item/clothing/accessory/solgov/specialty/officer)
	sort_order = 20
*/
/* AWAITING OVERHAUL
/*
 *  EC
 *  =====
 */
/datum/mil_rank/ec/e1
	name = "Apprentice Explorer"
	name_short = "AXPL"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/ec/enlisted)
	sort_order = 1

/datum/mil_rank/ec/e3
	name = "Explorer"
	name_short = "XPL"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/ec/enlisted/e3)
	sort_order = 3

/datum/mil_rank/ec/e5
	name = "Senior Explorer"
	name_short = "SXPL"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/ec/enlisted/e5)
	sort_order = 5

/datum/mil_rank/ec/e7
	name = "Chief Explorer"
	name_short = "CXPL"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/ec/enlisted/e7)
	sort_order = 7

/datum/mil_rank/ec/o1
	name = "Ensign"
	name_short = "ENS"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/ec/officer)
	sort_order = 11

/datum/mil_rank/ec/o3
	name = "Lieutenant"
	name_short = "LT"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/ec/officer/o3)
	sort_order = 13

/datum/mil_rank/ec/o5
	name = "Commander"
	name_short = "CDR"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/ec/officer/o5)
	sort_order = 15

/datum/mil_rank/ec/o6
	name = "Captain"
	name_short = "CAPT"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/ec/officer/o6)
	sort_order = 16

/datum/mil_rank/ec/o8
	name = "Admiral"
	name_short = "ADM"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/ec/officer/o8)
	sort_order = 16
*/
/*
 *  Civilians
 *  =========
 */

/datum/mil_rank/civ/civ
	name = "Civilian"
	name_short = null

/datum/mil_rank/civ/classa
	name = "Class A Foundation Personnel"
	name_short = "Class A"

/datum/mil_rank/civ/classb
	name = "Class B Foundation Personnel"
	name_short = "Class B"

/datum/mil_rank/civ/classc
	name = "Class C Foundation Personnel"
	name_short = "Class C"

/datum/mil_rank/civ/classd
	name = "Class D Foundation Personnel"
	name_short = "Class D"

/datum/mil_rank/civ/classe
	name = "Class E Foundation Personnel"
	name_short = "Class E"

/datum/access
	var/id = ""
	var/desc = ""
	var/region = ACCESS_REGION_NONE
	var/access_type = ACCESS_TYPE_STATION

/datum/access/dd_SortValue()
	return "[access_type][desc]"

/*****************
* Station access *
*****************/

/datum/access/security
	id = ACCESS_SECURITY
	desc = "Security Equipment"
	region = ACCESS_REGION_SECURITY

/datum/access/holding
	id = ACCESS_BRIG
	desc = "Holding Cells"
	region = ACCESS_REGION_SECURITY

/datum/access/armory
	id = ACCESS_ARMORY
	desc = "Armory"
	region = ACCESS_REGION_SECURITY

/datum/access/forensics_lockers
	id = ACCESS_FORENSICS_LOCKERS
	desc = "Forensics"
	region = ACCESS_REGION_SECURITY

/datum/access/medical
	id = ACCESS_MEDICAL
	desc = "Medical"
	region = ACCESS_REGION_MEDBAY

/datum/access/morgue
	id = ACCESS_MORGUE
	desc = "Morgue"
	region = ACCESS_REGION_MEDBAY

/datum/access/tox
	id = ACCESS_TOX
	desc = "Research Labs"
	region = ACCESS_REGION_RESEARCH

/datum/access/tox_storage
	id = ACCESS_TOX_STORAGE
	desc = "Toxins Lab"
	region = ACCESS_REGION_RESEARCH

/datum/access/engine
	id = ACCESS_ENGINE
	desc = "Engineering"
	region = ACCESS_REGION_ENGINEERING

/datum/access/engine_equip
	id = ACCESS_ENGINE_EQUIP
	desc = "Engine Room"
	region = ACCESS_REGION_ENGINEERING

/datum/access/maint_tunnels
	id = ACCESS_MAINT_TUNNELS
	desc = "Maintenance"
	region = ACCESS_REGION_ENGINEERING

/datum/access/external_airlocks
	id = ACCESS_EXTERNAL_AIRLOCKS
	desc = "External Airlocks"
	region = ACCESS_REGION_ENGINEERING

/datum/access/emergency_storage
	id = ACCESS_EMERGENCY_STORAGE
	desc = "Emergency Storage"
	region = ACCESS_REGION_ENGINEERING

/datum/access/change_ids
	id = ACCESS_CHANGE_IDS
	desc = "ID Computer"
	region = ACCESS_REGION_COMMAND

/datum/access/ai_upload
	id = ACCESS_AI_UPLOAD
	desc = "AI Upload"
	region = ACCESS_REGION_COMMAND

/datum/access/teleporter
	id = ACCESS_TELEPORTER
	desc = "Teleporter"
	region = ACCESS_REGION_COMMAND

/datum/access/eva
	id = ACCESS_EVA
	desc = "EVA"
	region = ACCESS_REGION_COMMAND

/datum/access/bridge
	id = ACCESS_BRIDGE
	desc = "Bridge"
	region = ACCESS_REGION_COMMAND

/datum/access/captain
	id = ACCESS_CAPTAIN
	desc = "Captain"
	region = ACCESS_REGION_COMMAND

/datum/access/all_personal_lockers
	id = ACCESS_ALL_PERSONAL_LOCKERS
	desc = "Personal Lockers"
	region = ACCESS_REGION_COMMAND

/datum/access/chapel_office
	id = ACCESS_CHAPEL_OFFICE
	desc = "Chapel Office"
	region = ACCESS_REGION_GENERAL

/datum/access/tech_storage
	id = ACCESS_TECH_STORAGE
	desc = "Technical Storage"
	region = ACCESS_REGION_ENGINEERING

/datum/access/atmospherics
	id = ACCESS_ATMOSPHERICS
	desc = "Atmospherics"
	region = ACCESS_REGION_ENGINEERING

/datum/access/bar
	id = ACCESS_BAR
	desc = "Bar"
	region = ACCESS_REGION_GENERAL

/datum/access/janitor
	id = ACCESS_JANITOR
	desc = "Custodial Closet"
	region = ACCESS_REGION_GENERAL

/datum/access/crematorium
	id = ACCESS_CREMATORIUM
	desc = "Crematorium"
	region = ACCESS_REGION_GENERAL

/datum/access/kitchen
	id = ACCESS_KITCHEN
	desc = "Kitchen"
	region = ACCESS_REGION_GENERAL

/datum/access/robotics
	id = ACCESS_ROBOTICS
	desc = "Robotics"
	region = ACCESS_REGION_RESEARCH

/datum/access/rd
	id = ACCESS_RD
	desc = "Chief Science Officer"
	region = ACCESS_REGION_RESEARCH

/datum/access/cargo
	id = ACCESS_CARGO
	desc = "Cargo Bay"
	region = ACCESS_REGION_SUPPLY

/datum/access/construction
	id = ACCESS_CONSTRUCTION
	desc = "Construction Areas"
	region = ACCESS_REGION_ENGINEERING

/datum/access/chemistry
	id = ACCESS_CHEMISTRY
	desc = "Chemistry Lab"
	region = ACCESS_REGION_MEDBAY

/datum/access/cargo_bot
	id = ACCESS_CARGO_BOT
	desc = "Cargo Bot Delivery"
	region = ACCESS_REGION_SUPPLY

/datum/access/hydroponics
	id = ACCESS_HYDROPONICS
	desc = "Hydroponics"
	region = ACCESS_REGION_GENERAL

/datum/access/manufacturing
	id = ACCESS_MANUFACTURING
	desc = "Manufacturing"
	access_type = ACCESS_TYPE_NONE

/datum/access/library
	id = ACCESS_LIBRARY
	desc = "Library"
	region = ACCESS_REGION_GENERAL

/datum/access/lawyer
	id = ACCESS_LAWYER
	desc = "Internal Affairs"
	region = ACCESS_REGION_COMMAND

/datum/access/virology
	id = ACCESS_VIROLOGY
	desc = "Virology"
	region = ACCESS_REGION_MEDBAY

/datum/access/cmo
	id = ACCESS_CMO
	desc = "Chief Medical Officer"
	region = ACCESS_REGION_COMMAND

/datum/access/qm
	id = ACCESS_QM
	desc = "Quartermaster"
	region = ACCESS_REGION_SUPPLY

/datum/access/network
	id = ACCESS_NETWORK
	desc = "Primary Network"
	region = ACCESS_REGION_RESEARCH

/datum/access/surgery
	id = ACCESS_SURGERY
	desc = "Surgery"
	region = ACCESS_REGION_MEDBAY

/datum/access/research
	id = ACCESS_RESEARCH
	desc = "Science"
	region = ACCESS_REGION_RESEARCH

/datum/access/mining
	id = ACCESS_MINING
	desc = "Mining"
	region = ACCESS_REGION_SUPPLY

/datum/access/mining_office
	id = ACCESS_MINING_OFFICE
	desc = "Mining Office"
	access_type = ACCESS_TYPE_NONE

/datum/access/mailsorting
	id = ACCESS_MAILSORTING
	desc = "Cargo Office"
	region = ACCESS_REGION_SUPPLY

/datum/access/heads_vault
	id = ACCESS_HEADS_VAULT
	desc = "Main Vault"
	region = ACCESS_REGION_COMMAND

/datum/access/mining_station
	id = ACCESS_MINING_STATION
	desc = "Mining EVA"
	region = ACCESS_REGION_SUPPLY

/datum/access/xenobiology
	id = ACCESS_XENOBIOLOGY
	desc = "Xenobiology Lab"
	region = ACCESS_REGION_RESEARCH

/datum/access/ce
	id = ACCESS_CE
	desc = "Chief Engineer"
	region = ACCESS_REGION_ENGINEERING

/datum/access/hop
	id = ACCESS_HOP
	desc = "Head of Personnel"
	region = ACCESS_REGION_COMMAND

/datum/access/hos
	id = ACCESS_HOS
	desc = "Head of Security"
	region = ACCESS_REGION_SECURITY

/datum/access/RC_announce
	id = ACCESS_RC_ANNOUNCE
	desc = "RC Announcements"
	region = ACCESS_REGION_COMMAND

/datum/access/tcomsat
	id = ACCESS_TCOMSAT
	desc = "Telecommunications"
	region = ACCESS_REGION_COMMAND

/datum/access/gateway
	id = ACCESS_GATEWAY
	desc = "Gateway"
	region = ACCESS_REGION_COMMAND

/datum/access/sec_doors
	id = ACCESS_SEC_DOORS
	desc = "Security"
	region = ACCESS_REGION_SECURITY

/datum/access/psychiatrist
	id = ACCESS_PSYCHIATRIST
	desc = "Counselor's Office"
	region = ACCESS_REGION_MEDBAY

/datum/access/xenoarch
	id = ACCESS_XENOARCH
	desc = "Xenoarchaeology"
	region = ACCESS_REGION_RESEARCH

/datum/access/medical_equip
	id = ACCESS_MEDICAL_EQUIP
	desc = "Medical Equipment"
	region = ACCESS_REGION_MEDBAY

/datum/access/heads
	id = ACCESS_HEADS
	desc = "Command"
	region = ACCESS_REGION_COMMAND

/******************
* Central Command *
******************/

/datum/access/cent_general
	id = ACCESS_CENT_GENERAL
	desc = "Code Grey"
	access_type = ACCESS_TYPE_CENTCOM

/datum/access/cent_thunder
	id = ACCESS_CENT_THUNDER
	desc = "Code Yellow"
	access_type = ACCESS_TYPE_CENTCOM

/datum/access/cent_specops
	id = ACCESS_CENT_SPECOPS
	desc = "Code Black"
	access_type = ACCESS_TYPE_CENTCOM

/datum/access/cent_medical
	id = ACCESS_CENT_MEDICAL
	desc = "Code White"
	access_type = ACCESS_TYPE_CENTCOM

/datum/access/cent_living
	id = ACCESS_CENT_LIVING
	desc = "Code Green"
	access_type = ACCESS_TYPE_CENTCOM

/datum/access/cent_storage
	id = ACCESS_CENT_STORAGE
	desc = "Code Orange"
	access_type = ACCESS_TYPE_CENTCOM

/datum/access/cent_teleporter
	id = ACCESS_CENT_TELEPORTER
	desc = "Code Blue"
	access_type = ACCESS_TYPE_CENTCOM

/datum/access/cent_creed
	id = ACCESS_CENT_CREED
	desc = "Code Silver"
	access_type = ACCESS_TYPE_CENTCOM

/datum/access/cent_captain
	id = ACCESS_CENT_CAPTAIN
	desc = "Code Gold"
	access_type = ACCESS_TYPE_CENTCOM

/***************
* Antag access *
***************/

/datum/access/syndicate
	id = ACCESS_SYNDICATE
	desc = "Syndicate"
	access_type = ACCESS_TYPE_SYNDICATE

/*******
* Misc *
*******/

/datum/access/synthetic
	id = ACCESS_SYNTH
	desc = "Synthetic"
	access_type = ACCESS_TYPE_NONE

/datum/access/crate_cash
	id = ACCESS_CRATE_CASH
	desc = "Crate cash"
	access_type = ACCESS_TYPE_NONE

/datum/access/merchant
	id = ACCESS_MERCHANT
	desc = "Merchant"
	access_type = ACCESS_TYPE_NONE

/datum/access/psiadvisor
	id = ACCESS_PSIADVISOR
	desc = "Foundation Advisor"
	region = ACCESS_REGION_COMMAND
	access_type = ACCESS_TYPE_NONE

// Ascent access.

/datum/access/ascent
	id = ACCESS_ASCENT
	desc = "Ascent Materiel"
	access_type = ACCESS_TYPE_NONE

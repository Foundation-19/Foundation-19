/datum/access
	var/id = ""
	var/desc = ""
	var/region = ACCESS_REGION_NONE
	var/access_type = ACCESS_TYPE_STATION

/datum/access/dd_SortValue()
	return "[access_type][desc]"

/*************************
* Foundation Site Access *
*************************/

// NTF

/var/const/access_mtf = "ACCESS_MTF"
/datum/access/mtf
	id = access_mtf
	desc = "MTF"
	region = ACCESS_TYPE_CENTCOM

// Security

/var/const/access_securitylvl1 = "ACCESS_SECURITY_LEVEL1" //Security Lobby
/datum/access/securitylvl1
	id = access_securitylvl1
	desc = "Security Level 1"
	region = ACCESS_REGION_SECURITY

/var/const/access_securitylvl2 = "ACCESS_SECURITY_LEVEL2" //LCZ
/datum/access/securitylvl2
	id = access_securitylvl2
	desc = "Security Level 2"
	region = ACCESS_REGION_SECURITY

/var/const/access_securitylvl3 = "ACCESS_SECURITY_LEVEL3" //HCZ
/datum/access/securitylvl3
	id = access_securitylvl3
	desc = "Security Level 3"
	region = ACCESS_REGION_SECURITY

/var/const/access_securitylvl4 = "ACCESS_SECURITY_LEVEL4" //LCZ Zone Commander, EZ Supervisor
/datum/access/securitylvl4
	id = access_securitylvl4
	desc = "Security Level 4"
	region = ACCESS_REGION_SECURITY

/var/const/access_securitylvl5 = "ACCESS_SECURITY_LEVEL5" //Guard Commander
/datum/access/securitylvl5
	id = access_securitylvl5
	desc = "Security Level 5"
	region = ACCESS_REGION_SECURITY

// SCIENCE

/var/const/access_sciencelvl1 = "ACCESS_SCIENCE_LEVEL1" //Science Lobby
/datum/access/sciencelvl1
	id = access_sciencelvl1
	desc = "Science Level 1"
	region = ACCESS_REGION_RESEARCH

/var/const/access_sciencelvl2 = "ACCESS_SCIENCE_LEVEL2" //Safe, Research Associate
/datum/access/sciencelvl2
	id = access_sciencelvl2
	desc = "Science Level 2"
	region = ACCESS_REGION_RESEARCH

/var/const/access_sciencelvl3 = "ACCESS_SCIENCE_LEVEL3" //Euclid, Researcher, Comms Officer
/datum/access/sciencelvl3
	id = access_sciencelvl3
	desc = "Science Level 3"
	region = ACCESS_REGION_RESEARCH

/var/const/access_sciencelvl4 = "ACCESS_SCIENCE_LEVEL4" //Keter, Senior Researcher, Guard Commander
/datum/access/sciencelvl4
	id = access_sciencelvl4
	desc = "Science Level 4"
	region = ACCESS_REGION_RESEARCH

/var/const/access_sciencelvl5 = "ACCESS_SCIENCE_LEVEL5" //Research Director
/datum/access/sciencelvl5
	id = access_sciencelvl5
	desc = "Science Level 5"
	region = ACCESS_REGION_RESEARCH

// MEDICAL

/var/const/access_medicallvl1 = "ACCESS_MEDICAL_LEVEL1" //Psych, Medical Lobby
/datum/access/medicallvl1
	id = access_medicallvl1
	desc = "Medical Level 1"
	region =  ACCESS_REGION_MEDBAY

/var/const/access_medicallvl2 = "ACCESS_MEDICAL_LEVEL2" //Paramedic, Chemist
/datum/access/medicallvl2
	id = access_medicallvl2
	desc = "Medical Level 2"
	region =  ACCESS_REGION_MEDBAY

/var/const/access_medicallvl3 = "ACCESS_MEDICAL_LEVEL3" //Doctor, Surgeon
/datum/access/medicallvl3
	id = access_medicallvl3
	desc = "Medical Level 3"
	region =  ACCESS_REGION_MEDBAY

/var/const/access_medicallvl4 = "ACCESS_MEDICAL_LEVEL4" //Virologist, EZ Supervisor
/datum/access/medicallvl4
	id = access_medicallvl4
	desc = "Medical Level 4"
	region =  ACCESS_REGION_MEDBAY

/var/const/access_medicallvl5 = "ACCESS_MEDICAL_LEVEL5" //Chief Medical Officer
/datum/access/medicallvl5
	id = access_medicallvl5
	desc = "Medical Level 5"
	region =  ACCESS_REGION_MEDBAY

// ENGINEERING

/var/const/access_engineeringlvl1 = "ACCESS_ENGINEERING_LEVEL1" //Engineering Lobby
/datum/access/engineeringlvl1
	id = access_engineeringlvl1
	desc = "Engineering Level 1"
	region = ACCESS_REGION_ENGINEERING

/var/const/access_engineeringlvl2 = "ACCESS_ENGINEERING_LEVEL2" //Junior Engineer
/datum/access/engineeringlvl2
	id = access_engineeringlvl2
	desc = "Engineering Level 2"
	region = ACCESS_REGION_ENGINEERING

/var/const/access_engineeringlvl3 = "ACCESS_ENGINEERING_LEVEL3" //Engineer, Comms Tech, Comms Officer
/datum/access/engineeringlvl3
	id = access_engineeringlvl3
	desc = "Engineering Level 3"
	region = ACCESS_REGION_ENGINEERING

/var/const/access_engineeringlvl4 = "ACCESS_ENGINEERING_LEVEL4" //Senior Engineer, Containment Engineer, Comms Officer
/datum/access/engineeringlvl4
	id = access_engineeringlvl4
	desc = "Engineering Level 4"
	region = ACCESS_REGION_ENGINEERING

/var/const/access_engineeringlvl5 = "ACCESS_ENGINEERING_LEVEL5" //Chief Engineer
/datum/access/engineeringlvl5
	id = access_engineeringlvl5
	desc = "Engineering Level 5"
	region = ACCESS_REGION_ENGINEERING

// ADMINISTRATION

/var/const/access_adminlvl1 = "ACCESS_ADMIN_LEVEL1" //Command Lobby, Logistics, GOC Rep
/datum/access/adminlvl1
	id = access_adminlvl1
	desc = "Admin Level 1"
	region = ACCESS_REGION_COMMAND

/var/const/access_adminlvl2 = "ACCESS_ADMIN_LEVEL2" //Logistics Officer, Comms Tech
/datum/access/adminlvl2
	id = access_adminlvl2
	desc = "Admin Level 2"
	region = ACCESS_REGION_COMMAND

/var/const/access_adminlvl3 = "ACCESS_ADMIN_LEVEL3" //AIC Observation, Archivist
/datum/access/adminlvl3
	id = access_adminlvl3
	desc = "Admin Level 3"
	region = ACCESS_REGION_COMMAND

/var/const/access_adminlvl4 = "ACCESS_ADMIN_LEVEL4" //AIC Upload/Core, HoP, Comms Officer, EZ Supervisor, Guard Commander
/datum/access/adminlvl4
	id = access_adminlvl4
	desc = "Admin Level 4"
	region = ACCESS_REGION_COMMAND

/var/const/access_adminlvl5 = "ACCESS_ADMIN_LEVEL5" //O5 Rep, Site Director
/datum/access/adminlvl5
	id = access_adminlvl5
	desc = "Admin Level 5"
	region = ACCESS_REGION_COMMAND

//LOGISTICS
// /var/const/access_cargo = 951
// /datum/access/cargo
//	id = access_cargo
//	desc = "Logistics General"

// /var/const/access_mailsorting = 952
// /datum/access/mailsorting
//	id = access_mailsorting
//	desc = "Logistics Mail Sorting"

// D-CLASS WORK

/var/const/access_dclasskitchen = "ACCESS_DCLASS_KITCHEN"
/datum/access/dclasskitchen
	id = access_dclasskitchen
	desc = "D-Class Kitchen"
	region = ACCESS_REGION_GENERAL

/var/const/access_dclassbotany = "ACCESS_DCLASS_BOTANY"
/datum/access/dclassbotany
	id = access_dclassbotany
	desc = "D-Class Botany"
	region = ACCESS_REGION_GENERAL

/var/const/access_dclassmining = "ACCESS_DCLASS_MINING"
/datum/access/dclassmining
	id = access_dclassmining
	desc = "D-Class Mining"
	region = ACCESS_REGION_GENERAL

/var/const/access_dclassjanitorial = "ACCESS_DCLASS_JANITORIAL"
/datum/access/dclassjanitorial
	id = access_dclassjanitorial
	desc = "D-Class Janitorial"
	region = ACCESS_REGION_GENERAL

// KEYCARD AUTH

/var/const/access_keyauth = "ACCESS_KEYCARD_AUTH"
/datum/access/keyauth
	id = access_keyauth
	desc = "Keycard Authentication Access"
	region = ACCESS_REGION_COMMAND

// TELECOMMS CHANNELS - THESE DON'T GO ON DOORS

/var/const/access_eng_comms = "ACCESS_COMMS_ENGINEERING"
/datum/access/eng_comms
	id = access_eng_comms
	desc = "Engineering Comms"
	region = ACCESS_REGION_NONE

/var/const/access_sci_comms = "ACCESS_COMMS_SCIENCE"
/datum/access/sci_comms
	id = access_sci_comms
	desc = "Research Comms"
	region = ACCESS_REGION_NONE

/var/const/access_sec_comms = "ACCESS_COMMS_SECURITY"
/datum/access/sec_comms
	id = access_sec_comms
	desc = "Security Comms"
	region = ACCESS_REGION_NONE

/var/const/access_log_comms = "ACCESS_COMMS_LOGISTICS"
/datum/access/log_comms
	id = access_log_comms
	desc = "Logistics Comms"
	region = ACCESS_REGION_NONE

/var/const/access_civ_comms = "ACCESS_COMMS_CIVILIAN"
/datum/access/civ_comms
	id = access_civ_comms
	desc = "Civilian Comms"
	region = ACCESS_REGION_NONE

/var/const/access_med_comms = "ACCESS_COMMS_MEDICAL"
/datum/access/med_comms
	id = access_med_comms
	desc = "Medical Comms"
	region = ACCESS_REGION_NONE

/var/const/access_com_comms = "ACCESS_COMMS_COMMAND"
/datum/access/com_comms
	id = access_com_comms
	desc = "Command Comms"
	region = ACCESS_REGION_NONE

/* Additional Access
*/

/var/const/access_torch_fax = "ACCESS_TORCH_FAX"
/datum/access/torch_fax
	id = access_torch_fax
	desc = "Fax Machines"
	region = ACCESS_REGION_COMMAND

/*****************
* Station access *
*****************/
/*
/var/const/access_security = "ACCESS_SECURITY" //1
/datum/access/security
	id = access_security
	desc = "Security Equipment"
	region = ACCESS_REGION_SECURITY

/var/const/access_brig = "ACCESS_BRIG" // Brig timers and permabrig 2
/datum/access/holding
	id = access_brig
	desc = "Holding Cells"
	region = ACCESS_REGION_SECURITY

/var/const/access_armory = "ACCESS_ARMORY" //3
/datum/access/armory
	id = access_armory
	desc = "Armory"
	region = ACCESS_REGION_SECURITY

/var/const/access_forensics_lockers = "ACCESS_FORENSICS" //4
/datum/access/forensics_lockers
	id = access_forensics_lockers
	desc = "Forensics"
	region = ACCESS_REGION_SECURITY

/var/const/access_medical = "ACCESS_MEDICAL" //5
/datum/access/medical
	id = access_medical
	desc = "Medical"
	region = ACCESS_REGION_MEDBAY

/var/const/access_morgue = "ACCESS_MORGUE" //6
/datum/access/morgue
	id = access_morgue
	desc = "Morgue"
	region = ACCESS_REGION_MEDBAY
*/
/var/const/access_tox = "ACCESS_TOXINS" //7
/datum/access/tox
	id = access_tox
	desc = "Research Labs"
	region = ACCESS_REGION_RESEARCH

/var/const/access_tox_storage = "ACCESS_TOX_STORAGE" //8
/datum/access/tox_storage
	id = access_tox_storage
	desc = "Toxins Lab"
	region = ACCESS_REGION_RESEARCH

/var/const/access_engine = "ACCESS_ENGINEERING" //10
/datum/access/engine
	id = access_engine
	desc = "Engineering"
	region = ACCESS_REGION_ENGINEERING

/var/const/access_engine_equip = "ACCESS_ENGINE_EQUIP" //11
/datum/access/engine_equip
	id = access_engine_equip
	desc = "Engine Room"
	region = ACCESS_REGION_ENGINEERING

/var/const/access_maint_tunnels = "ACCESS_MAINT" //12
/datum/access/maint_tunnels
	id = access_maint_tunnels
	desc = "Maintenance"
	region = ACCESS_REGION_ENGINEERING

/var/const/access_external_airlocks = "ACCESS_EXTERNAL" //13
/datum/access/external_airlocks
	id = access_external_airlocks
	desc = "External Airlocks"
	region = ACCESS_REGION_ENGINEERING

/var/const/access_emergency_storage = "ACCESS_EMERGENCY_STORAGE" //14
/datum/access/emergency_storage
	id = access_emergency_storage
	desc = "Emergency Storage"
	region = ACCESS_REGION_ENGINEERING

/var/const/access_change_ids = "ACCESS_CHANGE_ID" //15
/datum/access/change_ids
	id = access_change_ids
	desc = "ID Computer"
	region = ACCESS_REGION_COMMAND

/var/const/access_ai_upload = "ACCESS_AI_UPLOAD" //16
/datum/access/ai_upload
	id = access_ai_upload
	desc = "AI Upload"
	region = ACCESS_REGION_COMMAND

/var/const/access_teleporter = "ACCESS_TELEPORTER" //17
/datum/access/teleporter
	id = access_teleporter
	desc = "Teleporter"
	region = ACCESS_REGION_COMMAND

/var/const/access_eva = "ACCESS_EVA" //18
/datum/access/eva
	id = access_eva
	desc = "EVA"
	region = ACCESS_REGION_COMMAND

/var/const/access_bridge = "ACCESS_BRIDGE" //19
/datum/access/bridge
	id = access_bridge
	desc = "Bridge"
	region = ACCESS_REGION_COMMAND

/var/const/access_captain = "ACCESS_CAPTAIN" //20
/datum/access/captain
	id = access_captain
	desc = "Captain"
	region = ACCESS_REGION_COMMAND

/var/const/access_all_personal_lockers = "ACCESS_PERSONAL_LOCKERS" //21
/datum/access/all_personal_lockers
	id = access_all_personal_lockers
	desc = "Personal Lockers"
	region = ACCESS_REGION_COMMAND

/var/const/access_chapel_office = "ACCESS_CHAPEL_STORAGE" //22
/datum/access/chapel_office
	id = access_chapel_office
	desc = "Chapel Office"
	region = ACCESS_REGION_GENERAL

/var/const/access_tech_storage = "ACCESS_TECH_STORAGE" //23
/datum/access/tech_storage
	id = access_tech_storage
	desc = "Technical Storage"
	region = ACCESS_REGION_ENGINEERING

/var/const/access_atmospherics = "ACCESS_ATMOS" //24
/datum/access/atmospherics
	id = access_atmospherics
	desc = "Atmospherics"
	region = ACCESS_REGION_ENGINEERING

/var/const/access_bar = "ACCESS_BAR" //25
/datum/access/bar
	id = access_bar
	desc = "Bar"
	region = ACCESS_REGION_GENERAL

/var/const/access_janitor = "ACCESS_JANITOR" //26
/datum/access/janitor
	id = access_janitor
	desc = "Custodial Closet"
	region = ACCESS_REGION_GENERAL

/var/const/access_crematorium = "ACCESS_CREMATORIUM" //27
/datum/access/crematorium
	id = access_crematorium
	desc = "Crematorium"
	region = ACCESS_REGION_GENERAL

/var/const/access_kitchen = "ACCESS_KITCHEN" //28
/datum/access/kitchen
	id = access_kitchen
	desc = "Kitchen"
	region = ACCESS_REGION_GENERAL

/var/const/access_robotics = "ACCESS_ROBOTICS" //29
/datum/access/robotics
	id = access_robotics
	desc = "Robotics"
	region = ACCESS_REGION_RESEARCH

/var/const/access_rd = "ACCESS_RESEARCH_DIRECTOR" //30
/datum/access/rd
	id = access_rd
	desc = "Chief Science Officer"
	region = ACCESS_REGION_RESEARCH

/var/const/access_cargo = "ACCESS_CARGO" //31
/datum/access/cargo
	id = access_cargo
	desc = "Cargo Bay"
	region = ACCESS_REGION_SUPPLY

/var/const/access_construction = "ACCESS_CONSTRUCTION" //32
/datum/access/construction
	id = access_construction
	desc = "Construction Areas"
	region = ACCESS_REGION_ENGINEERING
/*
/var/const/access_chemistry = "ACCESS_CHEMISTRY" //33
/datum/access/chemistry
	id = access_chemistry
	desc = "Chemistry Lab"
	region = ACCESS_REGION_MEDBAY
*/
/var/const/access_cargo_bot = "ACCESS_CARGO_BOT" //34
/datum/access/cargo_bot
	id = access_cargo_bot
	desc = "Cargo Bot Delivery"
	region = ACCESS_REGION_SUPPLY

/var/const/access_hydroponics = "ACCESS_HYDROPONICS" //35
/datum/access/hydroponics
	id = access_hydroponics
	desc = "Hydroponics"
	region = ACCESS_REGION_GENERAL

/var/const/access_manufacturing = "ACCESS_MANUFACTURING" //36
/datum/access/manufacturing
	id = access_manufacturing
	desc = "Manufacturing"
	access_type = ACCESS_TYPE_NONE

/var/const/access_library = "ACCESS_LIBRARY" //37
/datum/access/library
	id = access_library
	desc = "Library"
	region = ACCESS_REGION_GENERAL

/var/const/access_lawyer = "ACCESS_LAWYER" //38
/datum/access/lawyer
	id = access_lawyer
	desc = "Internal Affairs"
	region = ACCESS_REGION_COMMAND
/*
/var/const/access_virology = "ACCESS_VIRO" //39
/datum/access/virology
	id = access_virology
	desc = "Virology"
	region = ACCESS_REGION_MEDBAY

/var/const/access_cmo = "ACCESS_CHIEF_MEDICAL_OFFICER" //40
/datum/access/cmo
	id = access_cmo
	desc = "Chief Medical Officer"
	region = ACCESS_REGION_COMMAND
*/
/var/const/access_qm = "ACCESS_QUARTERMASTER" //41
/datum/access/qm
	id = access_qm
	desc = "Quartermaster"
	region = ACCESS_REGION_SUPPLY

/var/const/access_network = "ACCESS_NETWORK" //42
/datum/access/network
	id = access_network
	desc = "Primary Network"
	region = ACCESS_REGION_RESEARCH
/*
/var/const/access_surgery = "ACCESS_SURGERY" //45
/datum/access/surgery
	id = access_surgery
	desc = "Surgery"
	region = ACCESS_REGION_MEDBAY
*/
/var/const/access_research = "ACCESS_RESEARCH" //47
/datum/access/research
	id = access_research
	desc = "Science"
	region = ACCESS_REGION_RESEARCH

/var/const/access_mining = "ACCESS_MINING" //48
/datum/access/mining
	id = access_mining
	desc = "Mining"
	region = ACCESS_REGION_SUPPLY

/var/const/access_mining_office = "ACCESS_MINING_OFFICE" //49
/datum/access/mining_office
	id = access_mining_office
	desc = "Mining Office"
	access_type = ACCESS_TYPE_NONE

/var/const/access_mailsorting = "ACCESS_SORTING" //50
/datum/access/mailsorting
	id = access_mailsorting
	desc = "Cargo Office"
	region = ACCESS_REGION_SUPPLY

/var/const/access_heads_vault = "ACCESS_VAULT"  //53
/datum/access/heads_vault
	id = access_heads_vault
	desc = "Main Vault"
	region = ACCESS_REGION_COMMAND

/var/const/access_mining_station = "ACCESS_MINING_EVA" //54
/datum/access/mining_station
	id = access_mining_station
	desc = "Mining EVA"
	region = ACCESS_REGION_SUPPLY

/var/const/access_xenobiology = "ACCESS_XENOBIO" //55
/datum/access/xenobiology
	id = access_xenobiology
	desc = "Xenobiology Lab"
	region = ACCESS_REGION_RESEARCH

/var/const/access_ce = "ACCESS_CHIEF_ENGINEER" //56
/datum/access/ce
	id = access_ce
	desc = "Chief Engineer"
	region = ACCESS_REGION_ENGINEERING

/var/const/access_hop = "ACCESS_HEAD_OF_PERSONNEL" //57
/datum/access/hop
	id = access_hop
	desc = "Head of Personnel"
	region = ACCESS_REGION_COMMAND
/*
/var/const/access_hos = "ACCESS_HEAD_OF_SECURITY" //58
/datum/access/hos
	id = access_hos
	desc = "Head of Security"
	region = ACCESS_REGION_SECURITY

/var/const/access_RC_announce = "ACCESS_REQUEST_ANNOUCE" //Request console announcements 59
/datum/access/RC_announce
	id = access_RC_announce
	desc = "RC Announcements"
	region = ACCESS_REGION_COMMAND
*/
/var/const/access_tcomsat ="ACCESS_TELECOMS" // has access to the entire telecomms satellite / machinery 61
/datum/access/tcomsat
	id = access_tcomsat
	desc = "Telecommunications"
	region = ACCESS_REGION_COMMAND

/var/const/access_gateway = "ACCESS_GATEWAY" //62
/datum/access/gateway
	id = access_gateway
	desc = "Gateway"
	region = ACCESS_REGION_COMMAND

/var/const/access_sec_doors = "ACCESS_SEC_DOORS" // Security front doors //63
/datum/access/sec_doors
	id = access_sec_doors
	desc = "Security"
	region = ACCESS_REGION_SECURITY

/var/const/access_psychiatrist = "ACCESS_PSYCHIATRIST" // Psychiatrist's office 64
/datum/access/psychiatrist
	id = access_psychiatrist
	desc = "Counselor's Office"
	region = ACCESS_REGION_MEDBAY

/var/const/access_xenoarch = "ACCESS_XENOARCH" //65
/datum/access/xenoarch
	id = access_xenoarch
	desc = "Xenoarchaeology"
	region = ACCESS_REGION_RESEARCH
/*
/var/const/access_medical_equip = "ACCESS_MEDICAL_EQUIP" //66
/datum/access/medical_equip
	id = access_medical_equip
	desc = "Medical Equipment"
	region = ACCESS_REGION_MEDBAY
*/
/var/const/access_heads = "ACCESS_HEADS" //67
/datum/access/heads
	id = access_heads
	desc = "Command"
	region = ACCESS_REGION_COMMAND

/******************
* Central Command *
******************/
/var/const/access_cent_general = "ACCESS_CENT_GENERAL" //101
/datum/access/cent_general
	id = access_cent_general
	desc = "Code Grey"
	access_type = ACCESS_TYPE_CENTCOM

/var/const/access_cent_thunder = "ACCESS_CENT_THUNDERDOME" //102
/datum/access/cent_thunder
	id = access_cent_thunder
	desc = "Code Yellow"
	access_type = ACCESS_TYPE_CENTCOM

/var/const/access_cent_specops = "ACCESS_CENT_SPECOPS" //103
/datum/access/cent_specops
	id = access_cent_specops
	desc = "Code Black"
	access_type = ACCESS_TYPE_CENTCOM

/var/const/access_cent_medical = "ACCESS_CENT_MEDBAY" //104
/datum/access/cent_medical
	id = access_cent_medical
	desc = "Code White"
	access_type = ACCESS_TYPE_CENTCOM

/var/const/access_cent_living = "ACCESS_CENT_LIVING" //105
/datum/access/cent_living
	id = access_cent_living
	desc = "Code Green"
	access_type = ACCESS_TYPE_CENTCOM

/var/const/access_cent_storage = "ACCESS_CENT_STORAGE" //106
/datum/access/cent_storage
	id = access_cent_storage
	desc = "Code Orange"
	access_type = ACCESS_TYPE_CENTCOM

/var/const/access_cent_teleporter = "ACCESS_CENT_TELEPORTER" //107
/datum/access/cent_teleporter
	id = access_cent_teleporter
	desc = "Code Blue"
	access_type = ACCESS_TYPE_CENTCOM

/var/const/access_cent_creed = "ACCESS_CENT_CREED" //108
/datum/access/cent_creed
	id = access_cent_creed
	desc = "Code Silver"
	access_type = ACCESS_TYPE_CENTCOM

/var/const/access_cent_captain = "ACCESS_CENT_CAPTAIN" //109
/datum/access/cent_captain
	id = access_cent_captain
	desc = "Code Gold"
	access_type = ACCESS_TYPE_CENTCOM

/***************
* Antag access *
***************/
/var/const/access_syndicate = "ACCESS_SYNDICATE" //150
/datum/access/syndicate
	id = access_syndicate
	desc = "Syndicate"
	access_type = ACCESS_TYPE_SYNDICATE

/*******
* Misc *
*******/
/var/const/access_synth = "ACCESS_SYNTH" //199
/datum/access/synthetic
	id = access_synth
	desc = "Synthetic"
	access_type = ACCESS_TYPE_NONE

/var/const/access_crate_cash = "ACCESS_MERCHANT_CASH" //300
/datum/access/crate_cash
	id = access_crate_cash
	desc = "Crate cash"
	access_type = ACCESS_TYPE_NONE

/var/const/access_merchant = "ACCESS_MERCHANT" //301
/datum/access/merchant
	id = access_merchant
	desc = "Merchant"
	access_type = ACCESS_TYPE_NONE

/var/const/access_psiadvisor = "ACCESS_PSIADVISOR"
/datum/access/psiadvisor
	id = access_psiadvisor
	desc = "Foundation Advisor"
	region = ACCESS_REGION_COMMAND
	access_type = ACCESS_TYPE_NONE

// Ascent access.
/var/const/access_ascent = "ACCESS_ASCENT"
/datum/access/ascent
	id = access_ascent
	desc = "Ascent Materiel"
	access_type = ACCESS_TYPE_NONE

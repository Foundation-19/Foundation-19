/*********************
* Deep Space Site 90 *
*********************/

// NTF

/var/const/access_mtf = 299
/datum/access/mtf
	id = access_mtf
	desc = "MTF"
	region = ACCESS_TYPE_CENTCOM

// MTF

/var/const/access_mtflvl1 = 300
/datum/access/mtflvl1
	id = access_mtflvl1
	desc = "MTF Level 1"
	region = ACCESS_REGION_SECURITY

/var/const/access_mtflvl2 = 301
/datum/access/mtflvl2
	id = access_mtflvl2
	desc = "MTF Level 2"
	region = ACCESS_REGION_SECURITY

/var/const/access_mtflvl3 = 302
/datum/access/mtflvl3
	id = access_mtflvl3
	desc = "MTF Level 3"
	region = ACCESS_REGION_SECURITY

/var/const/access_mtflvl4 = 303
/datum/access/mtflvl4
	id = access_mtflvl4
	desc = "MTF Level 4"
	region = ACCESS_REGION_SECURITY

/var/const/access_mtflvl5 = 304
/datum/access/mtflvl5
	id = access_mtflvl5
	desc = "MTF Level 5"
	region = ACCESS_REGION_SECURITY

// SCIENCE

/var/const/access_sciencelvl1 = 400
/datum/access/sciencelvl1
	id = access_sciencelvl1
	desc = "Science Level 1"
	region = ACCESS_REGION_RESEARCH

/var/const/access_sciencelvl2 = 401
/datum/access/sciencelvl2
	id = access_sciencelvl2
	desc = "Science Level 2"
	region = ACCESS_REGION_RESEARCH

/var/const/access_sciencelvl3 = 402
/datum/access/sciencelvl3
	id = access_sciencelvl3
	desc = "Science Level 3"
	region = ACCESS_REGION_RESEARCH

/var/const/access_sciencelvl4 = 403
/datum/access/sciencelvl4
	id = access_sciencelvl4
	desc = "Science Level 4"
	region = ACCESS_REGION_RESEARCH

/var/const/access_sciencelvl5 = 404
/datum/access/sciencelvl5
	id = access_sciencelvl5
	desc = "Science Level 5"
	region = ACCESS_REGION_RESEARCH

// ADMINISTRATION

/var/const/access_adminlvl1 = 500
/datum/access/adminlvl1
	id = access_adminlvl1
	desc = "Admin Level 1"
	region = ACCESS_REGION_COMMAND

/var/const/access_adminlvl2 = 501
/datum/access/adminlvl2
	id = access_adminlvl2
	desc = "Admin Level 2"
	region = ACCESS_REGION_COMMAND

/var/const/access_adminlvl3 = 502
/datum/access/adminlvl3
	id = access_adminlvl3
	desc = "Admin Level 3"
	region = ACCESS_REGION_COMMAND

/var/const/access_adminlvl4 = 503
/datum/access/adminlvl4
	id = access_adminlvl4
	desc = "Admin Level 4"
	region = ACCESS_REGION_COMMAND

/var/const/access_adminlvl5 = 504
/datum/access/adminlvl5
	id = access_adminlvl5
	desc = "Admin Level 5"
	region = ACCESS_REGION_COMMAND

// D-CLASS WORK

/var/const/access_dclasskitchen = 901
/datum/access/dclasskitchen
	id = access_dclasskitchen
	desc = "D-Class Kitchen"
	region = ACCESS_REGION_GENERAL

/var/const/access_dclassbotany = 902
/datum/access/dclassbotany
	id = access_dclassbotany
	desc = "D-Class Botany"
	region = ACCESS_REGION_GENERAL

/var/const/access_dclassmining = 903
/datum/access/dclassmining
	id = access_dclassmining
	desc = "D-Class Mining"
	region = ACCESS_REGION_GENERAL

/var/const/access_dclassjanitorial = 904
/datum/access/dclassjanitorial
	id = access_dclassjanitorial
	desc = "D-Class Janitorial"
	region = ACCESS_REGION_GENERAL

// ARCHIVE

/var/const/access_archive = 600
/datum/access/archive
	id = access_archive
	desc = "Archive"
	region = ACCESS_REGION_GENERAL

// KEYCARD AUTH

/var/const/access_keyauth = 601
/datum/access/keyauth
	id = access_keyauth
	desc = "Keycard Authentication Access"
	region = ACCESS_REGION_COMMAND

// TELECOMMS

/var/const/access_telecommsgen = 701
/datum/access/telecommsgen
	id = access_telecommsgen
	desc = "Communications General"
	region = ACCESS_REGION_COMMAND

/var/const/access_servers = 702
/datum/access/servers
	id = access_servers
	desc = "Basement Level Server Farm"
	region = ACCESS_REGION_COMMAND

/var/const/access_commtower = 703
/datum/access/commtower
	id = access_commtower
	desc = "Communications Tower"
	region = ACCESS_REGION_COMMAND

// TELECOMMS CHANNELS - THESE DON'T GO ON DOORS

/var/const/access_eng_comms = 730
/datum/access/eng_comms
	id = access_eng_comms
	desc = "Engineering Comms"
	region = ACCESS_REGION_NONE

/var/const/access_sci_comms = 731
/datum/access/sci_comms
	id = access_sci_comms
	desc = "Research Comms"
	region = ACCESS_REGION_NONE

/var/const/access_sec_comms = 732
/datum/access/sec_comms
	id = access_sec_comms
	desc = "Security Comms"
	region = ACCESS_REGION_NONE

/var/const/access_log_comms = 733
/datum/access/log_comms
	id = access_log_comms
	desc = "Logistics Comms"
	region = ACCESS_REGION_NONE

/var/const/access_civ_comms = 734
/datum/access/civ_comms
	id = access_civ_comms
	desc = "Civilian Comms"
	region = ACCESS_REGION_NONE

/var/const/access_med_comms = 735
/datum/access/med_comms
	id = access_med_comms
	desc = "Medical Comms"
	region = ACCESS_REGION_NONE

/var/const/access_com_comms = 736
/datum/access/com_comms
	id = access_com_comms
	desc = "Command Comms"
	region = ACCESS_REGION_NONE

// LOGISTICS

/var/const/access_logofficer = 800
/datum/access/logofficer
	id = access_logofficer
	desc = "Logistics Officer's Office"
	region = ACCESS_REGION_COMMAND

/var/const/access_logistics = 801
/datum/access/logistics
	id = access_logistics
	desc = "Logistics"
	region = ACCESS_REGION_NONE

// MISC

/var/const/access_s53bar = 900
/datum/access/bar
	id = access_bar
	desc = "Tram Hub Bar"
	region = ACCESS_REGION_NONE

/var/const/access_s53kitchen = 901
/datum/access/kitchen
	id = access_kitchen
	desc = "Tram Hub Kitchen"
	region = ACCESS_REGION_NONE

// MEDICAL

/var/const/access_medicalgen = 930
/datum/access/medicalgen
	id = access_medicalgen
	desc = "General Medical Access"
	region = ACCESS_REGION_NONE

/var/const/access_medicalviro = 931
/datum/access/medicalviro
	id = access_medicalviro
	desc = "Virology"
	region = ACCESS_REGION_NONE

/var/const/access_medicalpsych = 932
/datum/access/medicalpsych
	id = access_medicalpsych
	desc = "Psychiatry"
	region = ACCESS_REGION_NONE

/var/const/access_medicalequip = 933
/datum/access/medicalequip
	id = access_medicalequip
	desc = "Medical Equipment"
	region = ACCESS_REGION_NONE

/var/const/access_medicalchem = 934
/datum/access/medicalchem
	id = access_medicalchem
	desc = "Chemistry"
	region = ACCESS_REGION_NONE

/var/const/access_s53cmo = 935
/datum/access/s53cmo
	id = access_s53cmo
	desc = "CMO"
	region = ACCESS_REGION_COMMAND

/* Additional Access
*/

/************
* SEV Torch *
************/
/var/const/access_hangar = 73
/datum/access/hangar
	id = access_hangar
	desc = "Hangar Deck"
	region = ACCESS_REGION_GENERAL

/var/const/access_petrov = 74
/datum/access/petrov
	id = access_petrov
	desc = "Petrov"
	region = ACCESS_REGION_GENERAL

/var/const/access_petrov_helm = 75
/datum/access/petrov_helm
	id = access_petrov_helm
	desc = "Petrov Helm"
	region = ACCESS_REGION_GENERAL

/var/const/access_guppy_helm = 76
/datum/access/guppy_helm
	id = access_guppy_helm
	desc = "General Utility Pod Helm"
	region = ACCESS_REGION_GENERAL

/var/const/access_expedition_shuttle_helm = 77
/datum/access/exploration_shuttle_helm
	id = access_expedition_shuttle_helm
	desc = "Charon Helm"
	region = ACCESS_REGION_GENERAL

/var/const/access_aquila = 78
/datum/access/aquila
	id = access_aquila
	desc = "Aquila"
	region = ACCESS_REGION_GENERAL

/var/const/access_aquila_helm = 79
/datum/access/aquila_helm
	id = access_aquila_helm
	desc = "Aquila Helm"
	region = ACCESS_REGION_GENERAL

/var/const/access_solgov_crew = 80
/datum/access/solgov_crew
	id = access_solgov_crew
	desc = "SolGov Crew"
	region = ACCESS_REGION_GENERAL

/var/const/access_nanotrasen = 81
/datum/access/nanotrasen
	id = access_nanotrasen
	desc = "NanoTrasen Personnel"
	region = ACCESS_REGION_RESEARCH

/var/const/access_robotics_engineering = 82 //two accesses so that you can give access to the lab without giving access to the borgs
/datum/access/robotics_engineering
	id = access_robotics_engineering
	desc = "Biomechanical Engineering"
	region = ACCESS_REGION_ENGINEERING

/var/const/access_emergency_armory = 83
/datum/access/emergency_armory
	id = access_emergency_armory
	desc = "Emergency Armory"
	region = ACCESS_REGION_COMMAND

/var/const/access_liaison = 84
/datum/access/liaison
	id = access_liaison
	desc = "NanoTrasen Liaison"
	region = ACCESS_REGION_COMMAND
	access_type = ACCESS_TYPE_NONE //Ruler of their own domain, CO and RD cannot enter

/var/const/access_representative = 85
/datum/access/representative
	id = access_representative
	desc = "SolGov Representative"
	region = ACCESS_REGION_COMMAND
	access_type = ACCESS_TYPE_NONE //Ruler of their own domain, CO cannot enter

/var/const/access_sec_guard = 86
/datum/access/sec_guard
	id = access_sec_guard
	desc = "Security Guard"
	region = ACCESS_REGION_RESEARCH

/var/const/access_gun = 87
/datum/access/gun
	id = access_gun
	desc = "Gunnery"
	region = ACCESS_REGION_COMMAND

/var/const/access_expedition_shuttle = 88
/datum/access/exploration_shuttle
	id = access_expedition_shuttle
	desc = "Charon"
	region = ACCESS_REGION_GENERAL

/var/const/access_guppy = 89
/datum/access/guppy
	id = access_guppy
	desc = "General Utility Pod"
	region = ACCESS_REGION_GENERAL

/var/const/access_seneng = 90
/datum/access/seneng
	id = access_seneng
	desc = "Senior Engineer"
	region = ACCESS_REGION_ENGINEERING

/var/const/access_senmed = 91
/datum/access/senmed
	id = access_senmed
	desc = "Physician"
	region = ACCESS_REGION_MEDBAY

/var/const/access_senadv = 92
/datum/access/senadv
	id = access_senadv
	desc = "Senior Enlisted Advisor"
	region = ACCESS_REGION_COMMAND

/var/const/access_explorer = 93
/datum/access/explorer
	id = access_explorer
	desc = "Explorer"
	region = ACCESS_REGION_RESEARCH

/var/const/access_pathfinder = 94
/datum/access/pathfinder
	id = access_pathfinder
	desc = "Pathfinder"
	region = ACCESS_REGION_RESEARCH


/************
* SEV Torch *
************/

/datum/access/robotics
	region = ACCESS_REGION_ENGINEERING

/datum/access/network
	region = ACCESS_REGION_COMMAND

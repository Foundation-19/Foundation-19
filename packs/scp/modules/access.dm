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
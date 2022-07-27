/*********************
* Deep Space Site 90 *
*********************/

// NTF
/*
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
// /var/const/access_logistics = 951
// /datum/access/cargo
//	id = access_logistics
//	desc = "Logistics General"

// /var/const/access_logistics = 952
// /datum/access/mailsorting
//	id = access_logistics
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
*/
/*
var/const/access_sciencelvl2 = "access_sciencelvl2"
/datum/access/robotics
	id = access_sciencelvl2
	desc = "Robotics"
	region = ACCESS_REGION_ENGINEERING

var/const/access_network = "ACCESS_NETWORK"
/datum/access/network
	id = access_network
	desc = "Network"
	region = ACCESS_REGION_COMMAND

var/const/access_network_admin = "ACCESS_NETWORK_ADMIN"
/datum/access/network_admin
	id = access_adminlvl1
	desc = "Network Admin"
	region = ACCESS_REGION_COMMAND

var/const/access_chapel_office = "ACCESS_CHAPEL_OFFICE"
/datum/access/chapel_office
	id = access_chapel_office
	desc = "Chapel Office"
	region = ACCESS_REGION_SERVICE

var/const/access_dclasskitchen = "access_dclasskitchen"
/datum/access/bar
	id = access_dclasskitchen
	desc = "Bar"
	region = ACCESS_REGION_SERVICE

var/const/access_dclasskitchen = "access_dclasskitchen"
/datum/access/kitchen
	id = access_dclasskitchen
	desc = "Kitchen"
	region = ACCESS_REGION_SERVICE

var/const/access_engineeringlvl1 = "access_engineeringlvl1"
/datum/access/eva
	id = access_engineeringlvl1
	desc = "EVA"
	region = ACCESS_REGION_GENERAL

var/const/access_medicallvl1 = "access_medicallvl1"
/datum/access/crematorium
	id = access_medicallvl1
	desc = "Crematorium"
	region = ACCESS_REGION_MEDBAY

var/const/access_dclassjanitorial = "access_dclassjanitorial"
/datum/access/janitor
	id = access_dclassjanitorial
	desc = "Janitor"
	region = ACCESS_REGION_SERVICE

var/const/access_adminlvl4 = "access_adminlvl4"
/datum/access/ai_upload
	id = access_adminlvl4
	desc = "AI Upload"
*/

/*********************
* Deep Space Site 90 *
*********************/

// NTF

/var/const/access_mtf = 100
/datum/access/mtf
	id = access_mtf
	desc = "MTF"
	region = ACCESS_TYPE_CENTCOM

// Security

/var/const/access_securitylvl1 = 201 //Security Lobby
/datum/access/securitylvl1
	id = access_securitylvl1
	desc = "Security Level 1"
	region = ACCESS_REGION_SECURITY

/var/const/access_securitylvl2 = 202 //LCZ
/datum/access/securitylvl2
	id = access_securitylvl2
	desc = "Security Level 2"
	region = ACCESS_REGION_SECURITY

/var/const/access_securitylvl3 = 203 //HCZ
/datum/access/securitylvl3
	id = access_securitylvl3
	desc = "Security Level 3"
	region = ACCESS_REGION_SECURITY

/var/const/access_securitylvl4 = 204 //Zone Commander
/datum/access/securitylvl4
	id = access_securitylvl4
	desc = "Security Level 4"
	region = ACCESS_REGION_SECURITY

/var/const/access_securitylvl5 = 205 //Guard Commander
/datum/access/securitylvl5
	id = access_securitylvl5
	desc = "Security Level 5"
	region = ACCESS_REGION_SECURITY

// SCIENCE

/var/const/access_sciencelvl1 = 301 //Lobby
/datum/access/sciencelvl1
	id = access_sciencelvl1
	desc = "Science Level 1"
	region = ACCESS_REGION_RESEARCH

/var/const/access_sciencelvl2 = 302 //Research Associate
/datum/access/sciencelvl2
	id = access_sciencelvl2
	desc = "Science Level 2"
	region = ACCESS_REGION_RESEARCH

/var/const/access_sciencelvl3 = 303 //Researcher
/datum/access/sciencelvl3
	id = access_sciencelvl3
	desc = "Science Level 3"
	region = ACCESS_REGION_RESEARCH

/var/const/access_sciencelvl4 = 304 //Senior Researcher
/datum/access/sciencelvl4
	id = access_sciencelvl4
	desc = "Science Level 4"
	region = ACCESS_REGION_RESEARCH

/var/const/access_sciencelvl5 = 305 //Research Director
/datum/access/sciencelvl5
	id = access_sciencelvl5
	desc = "Science Level 5"
	region = ACCESS_REGION_RESEARCH

// MEDICAL

/var/const/access_medicallvl1 = 401 //Psych
/datum/access/medicallvl1
	id = access_medicallvl1
	desc = "Medical Level 1"
	region =  ACCESS_REGION_MEDBAY

/var/const/access_medicallvl2 = 402 //Paramedic, Chemist
/datum/access/medicallvl2
	id = access_medicallvl2
	desc = "Medical Level 2"
	region =  ACCESS_REGION_MEDBAY

/var/const/access_medicallvl3 = 403 //Doctor, Surgeon
/datum/access/medicallvl3
	id = access_medicallvl3
	desc = "Medical Level 3"
	region =  ACCESS_REGION_MEDBAY

/var/const/access_medicallvl4 = 404 //Virologist
/datum/access/medicallvl4
	id = access_medicallvl4
	desc = "Medical Level 4"
	region =  ACCESS_REGION_MEDBAY

/var/const/access_medicallvl5 = 405 //Chief Medical Officer
/datum/access/medicallvl5
	id = access_medicallvl5
	desc = "Medical Level 5"
	region =  ACCESS_REGION_MEDBAY

// ENGINEERING

/var/const/access_engineeringlvl1 = 501 //Junior Engineer
/datum/access/engineeringlvl1
	id = access_engineeringlvl1
	desc = "Engineering Level 1"
	region = ACCESS_REGION_ENGINEERING

/var/const/access_engineeringlvl2 = 502 // Engineer
/datum/access/engineeringlvl2
	id = access_engineeringlvl2
	desc = "Engineering Level 2"
	region = ACCESS_REGION_ENGINEERING

/var/const/access_engineeringlvl3 = 503 // Senior Engineer, Comms Programmer
/datum/access/engineeringlvl3
	id = access_engineeringlvl3
	desc = "Engineering Level 3"
	region = ACCESS_REGION_ENGINEERING

/var/const/access_engineeringlvl4 = 504 // Containment Engineer
/datum/access/engineeringlvl4
	id = access_engineeringlvl4
	desc = "Engineering Level 4"
	region = ACCESS_REGION_ENGINEERING

/var/const/access_engineeringlvl5 = 505 //Chief Engineer
/datum/access/engineeringlvl5
	id = access_engineeringlvl5
	desc = "Engineering Level 5"
	region = ACCESS_REGION_ENGINEERING

// ADMINISTRATION

/var/const/access_adminlvl1 = 601 //Command Lobby, Logistics, Comms
/datum/access/adminlvl1
	id = access_adminlvl1
	desc = "Admin Level 1"
	region = ACCESS_REGION_COMMAND

/var/const/access_adminlvl2 = 602 //05 Rep, Logistics Officer, Comms Tech
/datum/access/adminlvl2
	id = access_adminlvl2
	desc = "Admin Level 2"
	region = ACCESS_REGION_COMMAND

/var/const/access_adminlvl3 = 603 //AIC Observation, Archivist
/datum/access/adminlvl3
	id = access_adminlvl3
	desc = "Admin Level 3"
	region = ACCESS_REGION_COMMAND

/var/const/access_adminlvl4 = 604 //AIC Upload/Core
/datum/access/adminlvl4
	id = access_adminlvl4
	desc = "Admin Level 4"
	region = ACCESS_REGION_COMMAND

/var/const/access_adminlvl5 = 605 //Site Director
/datum/access/adminlvl5
	id = access_adminlvl5
	desc = "Admin Level 5"
	region = ACCESS_REGION_COMMAND

// D-CLASS WORK

/var/const/access_dclasskitchen = 701
/datum/access/dclasskitchen
	id = access_dclasskitchen
	desc = "D-Class Kitchen"
	region = ACCESS_REGION_GENERAL

/var/const/access_dclassbotany = 702
/datum/access/dclassbotany
	id = access_dclassbotany
	desc = "D-Class Botany"
	region = ACCESS_REGION_GENERAL

/var/const/access_dclassmining = 703
/datum/access/dclassmining
	id = access_dclassmining
	desc = "D-Class Mining"
	region = ACCESS_REGION_GENERAL

/var/const/access_dclassjanitorial = 704
/datum/access/dclassjanitorial
	id = access_dclassjanitorial
	desc = "D-Class Janitorial"
	region = ACCESS_REGION_GENERAL

// KEYCARD AUTH

/var/const/access_keyauth = 801
/datum/access/keyauth
	id = access_keyauth
	desc = "Keycard Authentication Access"
	region = ACCESS_REGION_COMMAND

// TELECOMMS CHANNELS - THESE DON'T GO ON DOORS

/var/const/access_eng_comms = 900
/datum/access/eng_comms
	id = access_eng_comms
	desc = "Engineering Comms"
	region = ACCESS_REGION_NONE

/var/const/access_sci_comms = 901
/datum/access/sci_comms
	id = access_sci_comms
	desc = "Research Comms"
	region = ACCESS_REGION_NONE

/var/const/access_sec_comms = 902
/datum/access/sec_comms
	id = access_sec_comms
	desc = "Security Comms"
	region = ACCESS_REGION_NONE

/var/const/access_log_comms = 903
/datum/access/log_comms
	id = access_log_comms
	desc = "Logistics Comms"
	region = ACCESS_REGION_NONE

/var/const/access_civ_comms = 904
/datum/access/civ_comms
	id = access_civ_comms
	desc = "Civilian Comms"
	region = ACCESS_REGION_NONE

/var/const/access_med_comms = 905
/datum/access/med_comms
	id = access_med_comms
	desc = "Medical Comms"
	region = ACCESS_REGION_NONE

/var/const/access_com_comms = 906
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

/datum/access/robotics
	region = ACCESS_REGION_ENGINEERING

/datum/access/network
	region = ACCESS_REGION_COMMAND

/datum/access/network_admin
	region = ACCESS_REGION_COMMAND

/datum/access/chapel_office
	region = ACCESS_REGION_SERVICE

/datum/access/bar
	region = ACCESS_REGION_SERVICE

/datum/access/kitchen
	region = ACCESS_REGION_SERVICE

/datum/access/eva
	region = ACCESS_REGION_GENERAL

/datum/access/crematorium
	region = ACCESS_REGION_MEDBAY

/datum/access/janitor
	region = ACCESS_REGION_SERVICE

/datum/access/ai_upload
	desc = "Cyborg Upload"
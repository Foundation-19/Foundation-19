/*********************
* Deep Space Site 90 *
*********************/

// NTF

/datum/access/mtf
	id = ACCESS_MTF
	desc = "MTF"
	region = ACCESS_TYPE_CENTCOM

// Security

/datum/access/securitylvl1
	id = ACCESS_SECURITY_LVL1
	desc = "Security Level 1"
	region = ACCESS_REGION_SECURITY
	access_type = ACCESS_TYPE_INNATE

/datum/access/securitylvl2
	id = ACCESS_SECURITY_LVL2
	desc = "Security Level 2"
	region = ACCESS_REGION_SECURITY
	access_type = ACCESS_TYPE_INNATE

/datum/access/securitylvl3
	id = ACCESS_SECURITY_LVL3
	desc = "Security Level 3"
	region = ACCESS_REGION_SECURITY
	access_type = ACCESS_TYPE_INNATE

/datum/access/securitylvl4
	id = ACCESS_SECURITY_LVL4
	desc = "Security Level 4"
	region = ACCESS_REGION_SECURITY
	access_type = ACCESS_TYPE_INNATE

/datum/access/securitylvl5
	id = ACCESS_SECURITY_LVL5
	desc = "Security Level 5"
	region = ACCESS_REGION_SECURITY
	access_type = ACCESS_TYPE_INNATE

// SCIENCE

/datum/access/sciencelvl1
	id = ACCESS_SCIENCE_LVL1
	desc = "Science Level 1"
	region = ACCESS_REGION_RESEARCH
	access_type = ACCESS_TYPE_INNATE

/datum/access/sciencelvl2
	id = ACCESS_SCIENCE_LVL2
	desc = "Science Level 2"
	region = ACCESS_REGION_RESEARCH
	access_type = ACCESS_TYPE_INNATE

/datum/access/sciencelvl3
	id = ACCESS_SCIENCE_LVL3
	desc = "Science Level 3"
	region = ACCESS_REGION_RESEARCH
	access_type = ACCESS_TYPE_INNATE

/datum/access/sciencelvl4
	id = ACCESS_SCIENCE_LVL4
	desc = "Science Level 4"
	region = ACCESS_REGION_RESEARCH
	access_type = ACCESS_TYPE_INNATE

/datum/access/sciencelvl5
	id = ACCESS_SCIENCE_LVL5
	desc = "Science Level 5"
	region = ACCESS_REGION_RESEARCH
	access_type = ACCESS_TYPE_INNATE

// MEDICAL

/datum/access/medicallvl1
	id = ACCESS_MEDICAL_LVL1
	desc = "Medical Level 1"
	region =  ACCESS_REGION_MEDBAY
	access_type = ACCESS_TYPE_INNATE

/datum/access/medicallvl2
	id = ACCESS_MEDICAL_LVL2
	desc = "Medical Level 2"
	region =  ACCESS_REGION_MEDBAY
	access_type = ACCESS_TYPE_INNATE

/datum/access/medicallvl3
	id = ACCESS_MEDICAL_LVL3
	desc = "Medical Level 3"
	region =  ACCESS_REGION_MEDBAY
	access_type = ACCESS_TYPE_INNATE

/datum/access/medicallvl4
	id = ACCESS_MEDICAL_LVL4
	desc = "Medical Level 4"
	region =  ACCESS_REGION_MEDBAY
	access_type = ACCESS_TYPE_INNATE

/datum/access/medicallvl5
	id = ACCESS_MEDICAL_LVL5
	desc = "Medical Level 5"
	region =  ACCESS_REGION_MEDBAY
	access_type = ACCESS_TYPE_INNATE

// ENGINEERING

/datum/access/engineeringlvl1
	id = ACCESS_ENGINEERING_LVL1
	desc = "Engineering Level 1"
	region = ACCESS_REGION_ENGINEERING
	access_type = ACCESS_TYPE_INNATE

/datum/access/engineeringlvl2
	id = ACCESS_ENGINEERING_LVL2
	desc = "Engineering Level 2"
	region = ACCESS_REGION_ENGINEERING
	access_type = ACCESS_TYPE_INNATE

/datum/access/engineeringlvl3
	id = ACCESS_ENGINEERING_LVL3
	desc = "Engineering Level 3"
	region = ACCESS_REGION_ENGINEERING
	access_type = ACCESS_TYPE_INNATE

/datum/access/engineeringlvl4
	id = ACCESS_ENGINEERING_LVL4
	desc = "Engineering Level 4"
	region = ACCESS_REGION_ENGINEERING
	access_type = ACCESS_TYPE_INNATE

/datum/access/engineeringlvl5
	id = ACCESS_ENGINEERING_LVL5
	desc = "Engineering Level 5"
	region = ACCESS_REGION_ENGINEERING
	access_type = ACCESS_TYPE_INNATE

// ADMINISTRATION

/datum/access/adminlvl1
	id = ACCESS_ADMIN_LVL1
	desc = "Admin Level 1"
	region = ACCESS_REGION_COMMAND
	access_type = ACCESS_TYPE_INNATE

/datum/access/adminlvl2
	id = ACCESS_ADMIN_LVL2
	desc = "Admin Level 2"
	region = ACCESS_REGION_COMMAND
	access_type = ACCESS_TYPE_INNATE

/datum/access/adminlvl3
	id = ACCESS_ADMIN_LVL3
	desc = "Admin Level 3"
	region = ACCESS_REGION_COMMAND
	access_type = ACCESS_TYPE_INNATE

/datum/access/adminlvl4
	id = ACCESS_ADMIN_LVL4
	desc = "Admin Level 4"
	region = ACCESS_REGION_COMMAND
	access_type = ACCESS_TYPE_INNATE

/datum/access/adminlvl5
	id = ACCESS_ADMIN_LVL5
	desc = "Admin Level 5"
	region = ACCESS_REGION_COMMAND
	access_type = ACCESS_TYPE_INNATE

// D-CLASS WORK

/datum/access/dclasskitchen
	id = ACCESS_DCLASS_KITCHEN
	desc = "D-Class Kitchen"
	region = ACCESS_REGION_GENERAL

/datum/access/dclassbotany
	id = ACCESS_DCLASS_BOTANY
	desc = "D-Class Botany"
	region = ACCESS_REGION_GENERAL

/datum/access/dclassmining
	id = ACCESS_DCLASS_MINING
	desc = "D-Class Mining"
	region = ACCESS_REGION_GENERAL

/datum/access/dclassjanitorial
	id = ACCESS_DCLASS_JANITORIAL
	desc = "D-Class Janitorial"
	region = ACCESS_REGION_GENERAL

// KEYCARD AUTH

/datum/access/keyauth
	id = ACCESS_KEYAUTH
	desc = "Keycard Authentication Access"
	region = ACCESS_REGION_COMMAND

// TELECOMMS CHANNELS - THESE DON'T GO ON DOORS

/datum/access/eng_comms
	id = ACCESS_ENG_COMMS
	desc = "Engineering Comms"
	region = ACCESS_REGION_NONE

/datum/access/sci_comms
	id = ACCESS_SCI_COMMS
	desc = "Research Comms"
	region = ACCESS_REGION_NONE

/datum/access/sec_comms
	id = ACCESS_SEC_COMMS
	desc = "Security Comms"
	region = ACCESS_REGION_NONE

/datum/access/log_comms
	id = ACCESS_LOG_COMMS
	desc = "Logistics Comms"
	region = ACCESS_REGION_NONE

/datum/access/civ_comms
	id = ACCESS_CIV_COMMS
	desc = "Civilian Comms"
	region = ACCESS_REGION_NONE

/datum/access/med_comms
	id = ACCESS_MED_COMMS
	desc = "Medical Comms"
	region = ACCESS_REGION_NONE

/datum/access/com_comms
	id = ACCESS_COM_COMMS
	desc = "Command Comms"
	region = ACCESS_REGION_NONE

/* Additional Access
*/

/datum/access/torch_fax
	id = ACCESS_TORCH_FAX
	desc = "Fax Machines"
	region = ACCESS_REGION_COMMAND

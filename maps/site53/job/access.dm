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
/var/const/access_hangar = "ACCESS_TORCH_HANGAR" //73
/datum/access/hangar
	id = access_hangar
	desc = "Hangar Deck"
	region = ACCESS_REGION_GENERAL

/var/const/access_guppy_helm = "ACCESS_TORCH_GUP_HELM" //76
/datum/access/guppy_helm
	id = access_guppy_helm
	desc = "General Utility Pod Helm"
	region = ACCESS_REGION_GENERAL

/var/const/access_expedition_shuttle_helm = "ACCESS_EXPLO_HELM" //77
/datum/access/exploration_shuttle_helm
	id = access_expedition_shuttle_helm
	desc = "Charon Helm"
	region = ACCESS_REGION_GENERAL

/var/const/access_aquila = "ACCESS_TORCH_AQUILA" //78
/datum/access/aquila
	id = access_aquila
	desc = "Aquila"
	region = ACCESS_REGION_GENERAL

/var/const/access_aquila_helm = "ACCESS_TORCH_AQUILA_HELM" //79
/datum/access/aquila_helm
	id = access_aquila_helm
	desc = "Aquila Helm"
	region = ACCESS_REGION_GENERAL

/var/const/access_solgov_crew = "ACCESS_TORCH_CREW" //80
/datum/access/solgov_crew
	id = access_solgov_crew
	desc = "SolGov Crew"
	region = ACCESS_REGION_GENERAL

/var/const/access_nanotrasen = "ACCESS_TORCH_CORP" //81
/datum/access/nanotrasen
	id = access_nanotrasen
	desc = "Corporate Personnel"
	region = ACCESS_REGION_SERVICE

/var/const/access_emergency_armory = "ACCESS_TORCH_ARMORY" //83
/datum/access/emergency_armory
	id = access_emergency_armory
	desc = "Emergency Armory"
	region = ACCESS_REGION_COMMAND

/var/const/access_liaison = "ACCESS_TORCH_CORPORATE_LIAISON" //84
/datum/access/liaison
	id = access_liaison
	desc = "Corporate Liaison"
	region = ACCESS_REGION_COMMAND
	access_type = ACCESS_TYPE_NONE //Ruler of their own domain, CO and RD cannot enter

/var/const/access_representative = "ACCESS_TORCH_REPRESENTATIVE" //85
/datum/access/representative
	id = access_representative
	desc = "SolGov Representative"
	region = ACCESS_REGION_COMMAND
	access_type = ACCESS_TYPE_NONE //Ruler of their own domain, CO cannot enter

/var/const/access_sec_guard = "ACCESS_TORCH_SECURITY_GUARD" //86
/datum/access/sec_guard
	id = access_sec_guard
	desc = "Corporate Security"
	region = ACCESS_REGION_SERVICE

/var/const/access_gun = "ACCESS_TORCH_CANNON" //87
/datum/access/gun
	id = access_gun
	desc = "Gunnery"
	region = ACCESS_REGION_COMMAND

/var/const/access_expedition_shuttle = "ACCESS_TORCH_EXPLO" //88
/datum/access/exploration_shuttle
	id = access_expedition_shuttle
	desc = "Charon"
	region = ACCESS_REGION_GENERAL

/var/const/access_guppy = "ACCESS_TORCH_GUP" //89
/datum/access/guppy
	id = access_guppy
	desc = "General Utility Pod"
	region = ACCESS_REGION_GENERAL

/var/const/access_seneng = "ACCESS_TORCH_SENIOR_ENG" //90
/datum/access/seneng
	id = access_seneng
	desc = "Senior Engineer"
	region = ACCESS_REGION_ENGINEERING

/var/const/access_senmed = "ACCESS_TORCH_SENIOR_MED" //91
/datum/access/senmed
	id = access_senmed
	desc = "Physician"
	region = ACCESS_REGION_MEDBAY

/var/const/access_senadv = "ACCESS_TORCH_SENIOR_ADVISOR" //92
/datum/access/senadv
	id = access_senadv
	desc = "Senior Enlisted Advisor"
	region = ACCESS_REGION_COMMAND

/var/const/access_explorer = "ACCESS_TORCH_EXPLORER" //93
/datum/access/explorer
	id = access_explorer
	desc = "Explorer"
	region = ACCESS_REGION_GENERAL

/var/const/access_pathfinder = "ACCESS_TORCH_PATHFINDER" //94
/datum/access/pathfinder
	id = access_pathfinder
	desc = "Pathfinder"
	region = ACCESS_REGION_GENERAL

/var/const/access_pilot = "ACCESS_TORCH_PILOT" //95
/datum/access/pilot
	id = access_pilot
	desc = "Pilot"
	region = ACCESS_REGION_GENERAL

/var/const/access_commissary = "ACCESS_TORCH_SHOP" //96
/datum/access/commissary
	id = access_commissary
	desc = "Commissary"
	region = ACCESS_REGION_GENERAL

/datum/access/psychiatrist
	desc = "Mental Health"

/datum/access/hos
	desc = "Chief of Security"

/datum/access/hop
	desc = "Executive Officer"

/datum/access/qm
	desc = "Deck Chief"

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

/*************
* NRV Petrov *
*************/
/var/const/access_petrov = "ACCESS_TORCH_PETROV" //200
/datum/access/petrov
	id = access_petrov
	desc = "Petrov"
	region = ACCESS_REGION_GENERAL

/var/const/access_petrov_helm = "ACCESS_TORCH_PETROV_HELM" //201
/datum/access/petrov_helm
	id = access_petrov_helm
	desc = "Petrov Helm"
	region = ACCESS_REGION_GENERAL

/var/const/access_petrov_analysis = "ACCESS_TORCH_PETROV_ANALYSIS" //202
/datum/access/petrov_analysis
	id = access_petrov_analysis
	desc = "Petrov Analysis Lab"
	region = ACCESS_REGION_RESEARCH

/var/const/access_petrov_phoron = "ACCESS_TORCH_PETROV_PHORON" //203
/datum/access/petrov_phoron
	id = access_petrov_phoron
	desc = "Petrov Phoron Sublimation Lab"
	region = ACCESS_REGION_RESEARCH

/var/const/access_petrov_toxins = "ACCESS_TORCH_PETROV_TOXINS" //204
/datum/access/petrov_toxins
	id = access_petrov_toxins
	desc = "Petrov Toxins Lab"
	region = ACCESS_REGION_RESEARCH

/var/const/access_petrov_chemistry = "ACCESS_TORCH_PETROV_CHEMISTRY" //205
/datum/access/petrov_chemistry
	id = access_petrov_chemistry
	desc = "Petrov Chemistry Lab"
	region = ACCESS_REGION_RESEARCH

/var/const/access_petrov_rd = "ACCESS_TORCH_PETROV_RD" //206
/datum/access/petrov_rd
	id = access_petrov_rd
	desc = "Petrov Chief Science Officer's Office"
	region = ACCESS_REGION_COMMAND

/var/const/access_petrov_security = "ACCESS_TORCH_PETROV_SEC" //207
/datum/access/petrov_security
	id = access_petrov_security
	desc = "Petrov Security Office"
	region = ACCESS_REGION_SECURITY

/var/const/access_petrov_maint = "ACCESS_TORCH_PETROV_MAINT" //208
/datum/access/petrov_maint
	id = access_petrov_maint
	desc = "Petrov Maintenance"
	region = ACCESS_REGION_GENERAL

/var/const/access_torch_helm = "ACCESS_TORCH_HELM"
/datum/access/torch_helm
	id = access_torch_helm
	desc = "Torch Helm"
	region = ACCESS_REGION_COMMAND

// Torch Radio Access

/var/const/access_radio_comm = "ACCESS_RADIO_COMM"
/datum/access/access_radio_comm
	id = access_radio_comm
	desc = "Command Radio"
	region = ACCESS_REGION_COMMAND

/var/const/access_radio_eng = "ACCESS_RADIO_ENG"
/datum/access/access_radio_eng
	id = access_radio_eng
	desc = "Engineering Radio"
	region = ACCESS_REGION_ENGINEERING

/var/const/access_radio_med = "ACCESS_RADIO_MED"
/datum/access/access_radio_med
	id = access_radio_med
	desc = "Medical Radio"
	region = ACCESS_REGION_MEDBAY

/var/const/access_radio_sec = "ACCESS_RADIO_SEC"
/datum/access/access_radio_sec
	id = access_radio_sec
	desc = "Security Radio"
	region = ACCESS_REGION_SECURITY

/var/const/access_radio_sci = "ACCESS_RADIO_SCI"
/datum/access/access_radio_sic
	id = access_radio_sci
	desc = "Science Radio"
	region = ACCESS_REGION_RESEARCH

/var/const/access_radio_sup = "ACCESS_RADIO_SUP"
/datum/access/access_radio_sup
	id = access_radio_sup
	desc = "Supply Radio"
	region = ACCESS_REGION_SUPPLY

/var/const/access_radio_serv = "ACCESS_RADIO_SERV"
/datum/access/access_radio_serv
	id = access_radio_serv
	desc = "Service Radio"
	region = ACCESS_REGION_SERVICE

/var/const/access_radio_exp = "ACCESS_RADIO_EXP"
/datum/access/access_radio_exp
	id = access_radio_exp
	desc = "Exploration Radio"
	region = ACCESS_REGION_GENERAL

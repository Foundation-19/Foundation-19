// SECURITY
/datum/job/hos
	title = "Guard Commander"
	department = "Command"
	department_flag = SEC|COM
	//duties = "<big><b>As the Guard Commander, you have direct say over the Security department. You're not assigned to any zone, but instead should jump in where necessary or requested. You are to speak with your Zone Commanders oftenly, and assign new guards to the right zone, or where it's needed mostly.</b></big>"
	economic_power = 8
	alt_titles = list("Security Chief", "Head of Security")
	minimal_player_age = 15
	ideal_character_age = 35
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/command/cos
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/o3,
		/datum/mil_rank/security/o4,
		/datum/mil_rank/security/o5
	)
	hud_icon = "hudguardcommander"

	access = list(
		ACCESS_COM_COMMS,
		ACCESS_SEC_COMMS,
		ACCESS_SECURITY_LVL1,
		ACCESS_SECURITY_LVL2,
		ACCESS_SECURITY_LVL3,
		ACCESS_SECURITY_LVL4,
		ACCESS_SECURITY_LVL5,
		ACCESS_ADMIN_LVL1,
		ACCESS_ADMIN_LVL2,
		ACCESS_ADMIN_LVL3,
		ACCESS_ADMIN_LVL4,
		ACCESS_MEDICAL_LVL1,
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL2,
		ACCESS_SCIENCE_LVL3,
		ACCESS_SCIENCE_LVL4,
		ACCESS_KEYAUTH,
		ACCESS_CHAPEL_OFFICE
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_EXPERIENCED,
	                    SKILL_EVA         = SKILL_BASIC,
	                    SKILL_COMBAT      = SKILL_BASIC,
	                    SKILL_WEAPONS     = SKILL_EXPERIENCED,
	                    SKILL_HAULING     = SKILL_TRAINED,
	                    SKILL_FORENSICS   = SKILL_TRAINED)

	max_skill = list(   SKILL_COMBAT      = SKILL_MASTER,
	                    SKILL_WEAPONS     = SKILL_MASTER,
	                    SKILL_FORENSICS   = SKILL_MASTER)
	skill_points = 28

	software_on_spawn = list(/datum/computer_file/program/digitalwarrant,
							 /datum/computer_file/program/camera_monitor)

//##
//ZONE COMMANDERS
//##

/datum/job/ltofficerlcz
	title = "LCZ Zone Commander"
	department = "Light Containment Personnel"
	department_flag = SEC
	total_positions = 1
	spawn_positions = 1
	//duties = "<big><b>As the Zone Commander, you're the right hand of the Guard Commander, and in charge of a specific zone. In this zone, you have full command of the guards stationed there in every situation, except Code Red or higher. You also carry the responsibility of guarding the D-Cells. You should not leave your zone under usual SoP</b></big>"
	economic_power = 4
	minimal_player_age = 10
	ideal_character_age = 30
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/security/ltofficerlcz
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/o1
	)
	hud_icon = "hudlczcommander"

	access = list(
		ACCESS_SEC_COMMS,
		ACCESS_SECURITY_LVL1,
		ACCESS_SECURITY_LVL2,
		ACCESS_SECURITY_LVL3,
		ACCESS_SECURITY_LVL4,
		ACCESS_ADMIN_LVL1,
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL2,
		ACCESS_SCIENCE_LVL3
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_EVA         = SKILL_BASIC,
	                    SKILL_COMBAT      = SKILL_EXPERIENCED,
	                    SKILL_WEAPONS     = SKILL_TRAINED,
	                    SKILL_HAULING     = SKILL_TRAINED,
	                    SKILL_FORENSICS   = SKILL_TRAINED)

	max_skill = list(   SKILL_COMBAT      = SKILL_MASTER,
	                    SKILL_WEAPONS     = SKILL_MASTER,
	                    SKILL_FORENSICS   = SKILL_TRAINED)
	skill_points = 25

/datum/job/ltofficerhcz
	title = "HCZ Zone Commander"
	department = "Heavy Containment Personnel"
	department_flag = SEC
	total_positions = 1
	spawn_positions = 1
	//duties = "<big><b>As the Zone Commander, you're the right hand of the Guard Commander, and in charge of a specific zone. In this zone, you have full command of the guards stationed there in every situation, except Code Red or higher. You should not leave your zone under usual SoP</b></big>"
	economic_power = 4
	minimal_player_age = 10
	ideal_character_age = 30
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/security/ltofficerhcz
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/o2
	)
	hud_icon = "hudhczcommander"

	access = list(
		ACCESS_SEC_COMMS,
		ACCESS_SECURITY_LVL1,
		ACCESS_SECURITY_LVL2,
		ACCESS_SECURITY_LVL3,
		ACCESS_SECURITY_LVL4,
		ACCESS_ADMIN_LVL1,
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL2,
		ACCESS_SCIENCE_LVL3,
		ACCESS_SCIENCE_LVL4
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_EVA         = SKILL_BASIC,
	                    SKILL_COMBAT      = SKILL_EXPERIENCED,
	                    SKILL_WEAPONS     = SKILL_TRAINED,
	                    SKILL_HAULING     = SKILL_TRAINED,
	                    SKILL_FORENSICS   = SKILL_BASIC)

	max_skill = list(   SKILL_COMBAT      = SKILL_MASTER,
	                    SKILL_WEAPONS     = SKILL_MASTER,
	                    SKILL_FORENSICS   = SKILL_TRAINED)
	skill_points = 25

/datum/job/ltofficerez
	title = "EZ Supervisor"
	department = "Entrance Personnel"
	department_flag = SEC
	total_positions = 1
	spawn_positions = 1
	//duties = "<big><b>As the Entrance Zone Senior Agent, you and your team work independently from the guard commander and regular security structure. In this zone, you are tasked with the protection of administrative personnel, together with the agents stationed here. You should not leave your zone under usual SoP, or allow administration to go without protection detail into the facility.</b></big>"
	economic_power = 4
	minimal_player_age = 10
	ideal_character_age = 30
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/security/ltofficerez
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/w5
	)
	hud_icon = "hudezcommander"

	access = list(
		ACCESS_SEC_COMMS,
		ACCESS_SECURITY_LVL1,
		ACCESS_SECURITY_LVL2,
		ACCESS_SECURITY_LVL3,
		ACCESS_SECURITY_LVL4,
		ACCESS_ADMIN_LVL1,
		ACCESS_ADMIN_LVL2,
		ACCESS_ADMIN_LVL3,
		ACCESS_ADMIN_LVL4,
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL2,
		ACCESS_ENGINEERING_LVL1,
		ACCESS_ENGINEERING_LVL2,
		ACCESS_MEDICAL_LVL1,
		ACCESS_MEDICAL_LVL2,
		ACCESS_MEDICAL_LVL3,
		ACCESS_MEDICAL_LVL4,
		ACCESS_CHAPEL_OFFICE
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_HAULING     = SKILL_TRAINED,
	                    SKILL_COMPUTER    = SKILL_TRAINED,
	                    SKILL_EVA         = SKILL_BASIC,
	                    SKILL_COMBAT      = SKILL_TRAINED,
	                    SKILL_WEAPONS     = SKILL_EXPERIENCED,
	                    SKILL_FORENSICS   = SKILL_MASTER)

	max_skill = list(   SKILL_COMBAT      = SKILL_MASTER,
	                    SKILL_WEAPONS     = SKILL_MASTER,
	                    SKILL_FORENSICS   = SKILL_MASTER)
	skill_points = 25

//##
// OFFICERS
//##

/datum/job/ncoofficerlcz
	title = "LCZ Sergeant"
	department = "Light Containment Personnel"
	department_flag = SEC
	total_positions = 4
	spawn_positions = 4
	balance_limited = TRUE
	//duties = "<big><b>As the Guard you have more access than a Junior Guard, but do not control them. You are to guard tests and SCP's in the zone you spawned in. If in doubt, ask your Zone or Guard Commander. You also have the duty of guarding the D-Class Cell Blocks. You should not leave your zone under usual SoP.</b></big>"
	economic_power = 4
	alt_titles = list("LCZ Senior Containment Response Agent", "LCZ Containment Response Sergeant", "LCZ Senior Combat Medic", "LCZ Riot Control Sergeant", "LCZ Senior Riot Control Agent", "LCZ Senior Agent")
	minimal_player_age = 5
	ideal_character_age = 25
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/security/ncoofficerlcz
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e2,
		/datum/mil_rank/security/e3,
		/datum/mil_rank/security/e4,
		/datum/mil_rank/security/e5
	)
	hud_icon = "hudlczsarge"

	access = list(
		ACCESS_SEC_COMMS,
		ACCESS_SECURITY_LVL1,
		ACCESS_SECURITY_LVL2,
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL2,
		ACCESS_DCLASS_KITCHEN,
		ACCESS_DCLASS_BOTANY,
		ACCESS_DCLASS_MINING,
		ACCESS_DCLASS_JANITORIAL
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_HAULING     = SKILL_TRAINED,
	                    SKILL_EVA         = SKILL_BASIC,
	                    SKILL_COMBAT      = SKILL_TRAINED,
	                    SKILL_WEAPONS     = SKILL_TRAINED,
	                    SKILL_FORENSICS   = SKILL_BASIC)

	max_skill = list(   SKILL_COMBAT      = SKILL_EXPERIENCED,
	                    SKILL_WEAPONS     = SKILL_EXPERIENCED,
	                    SKILL_FORENSICS   = SKILL_TRAINED)
	skill_points = 21

/datum/job/ncoofficerhcz
	title = "HCZ Sergeant"
	department = "Heavy Containment Personnel"
	department_flag = SEC
	total_positions = 3
	spawn_positions = 3
	//duties = "<big><b>As the Guard you have more access than a Junior Guard, but do not control them. You are to guard tests and SCP's in the zone you spawned in. If in doubt, ask your Zone or Guard Commander. You also have the duty of guarding the D-Class Cell Blocks. You should not leave your zone under usual SoP.</b></big>"
	economic_power = 4
	alt_titles = list("HCZ Senior Containment Response Agent", "HCZ Containment Response Sergeant", "HCZ Senior Combat Medic", "HCZ Senior Agent")
	minimal_player_age = 5
	ideal_character_age = 25
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/security/ncoofficerhcz
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e4,
		/datum/mil_rank/security/e5,
		/datum/mil_rank/security/e6
	)
	hud_icon = "hudhczsarge"

	access = list(
		ACCESS_SEC_COMMS,
		ACCESS_SECURITY_LVL1,
		ACCESS_SECURITY_LVL2,
		ACCESS_SECURITY_LVL3,
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL2,
		ACCESS_SCIENCE_LVL3
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_HAULING     = SKILL_TRAINED,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_EVA         = SKILL_BASIC,
	                    SKILL_COMBAT      = SKILL_TRAINED,
	                    SKILL_WEAPONS     = SKILL_TRAINED,
	                    SKILL_FORENSICS   = SKILL_BASIC)

	max_skill = list(   SKILL_COMBAT      = SKILL_MASTER,
	                    SKILL_WEAPONS     = SKILL_MASTER,
	                    SKILL_FORENSICS   = SKILL_TRAINED)
	skill_points = 21

/datum/job/ncoofficerez
	title = "EZ Senior Agent"
	department = "Entrance Zone Personnel"
	department_flag = SEC
	total_positions = 2
	spawn_positions = 2
	//duties = "<big><b>As the Agent you have more access than a Junior Agent, but do not control them. You are to guard tests and SCP's in the zone you spawned in. If in doubt, ask your Zone or Guard Commander. You also have the duty of guarding the D-Class Cell Blocks. You should not leave your zone under usual SoP.</b></big>"
	economic_power = 4
	alt_titles = list("Investigation Officer" = /decl/hierarchy/outfit/job/site90/crew/security/secauditorofficer, "EZ Senior Combat Medic" = /decl/hierarchy/outfit/job/site90/crew/security/medic)
	minimal_player_age = 5
	ideal_character_age = 25
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/security/ncoofficerez
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e7,
		/datum/mil_rank/security/e8
	)
	hud_icon = "hudezsarge"

	access = list(
		ACCESS_SEC_COMMS,
		ACCESS_SCIENCE_LVL1,
		ACCESS_MEDICAL_LVL1,
		ACCESS_MEDICAL_LVL2,
		ACCESS_MEDICAL_LVL3,
		ACCESS_ENGINEERING_LVL1,
		ACCESS_SECURITY_LVL1,
		ACCESS_SECURITY_LVL2,
		ACCESS_SECURITY_LVL3,
		ACCESS_ADMIN_LVL1,
		ACCESS_ADMIN_LVL2,
		ACCESS_ADMIN_LVL3,
		ACCESS_CHAPEL_OFFICE
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_COMPUTER    = SKILL_TRAINED,
	                    SKILL_EVA         = SKILL_BASIC,
	                    SKILL_COMBAT      = SKILL_TRAINED,
	                    SKILL_WEAPONS     = SKILL_TRAINED,
	                    SKILL_FORENSICS   = SKILL_EXPERIENCED)

	max_skill = list(   SKILL_COMBAT      = SKILL_EXPERIENCED,
	                    SKILL_WEAPONS     = SKILL_EXPERIENCED,
	                    SKILL_FORENSICS   = SKILL_MASTER)
	skill_points = 21
//##
//JUNIOR OFFICER
//##

/datum/job/enlistedofficerlcz

	title = "LCZ Guard"
	department = "Light Containment Personnel"
	department_flag = SEC
	total_positions = 20
	spawn_positions = 20
	//duties = "<big><b>As the Junior Guard you have minimal access. You are to guard tests, SCP's and provide support in the zone you spawned in. If in doubt, ask your Zone or Guard Commander. You also have the duty of guarding the D-Class Cell Blocks. You should not leave your zone under usual SoP.</b></big>"
	economic_power = 4
	alt_titles = list("LCZ Containment Response Agent", "LCZ Containment Response Guard", "LCZ Combat Medic", "LCZ Riot Control Guard", "LCZ Riot Control Agent", "LCZ Agent")
//	minimal_player_age = 0
	ideal_character_age = 25
	balance_limited = TRUE
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/security/enlistedofficerlcz
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e1,
		/datum/mil_rank/security/e2
	)
	hud_icon = "hudlczsenior"

	access = list(
		ACCESS_SEC_COMMS,
		ACCESS_SECURITY_LVL1,
		ACCESS_SECURITY_LVL2,
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL2,
		ACCESS_DCLASS_KITCHEN,
		ACCESS_DCLASS_BOTANY,
		ACCESS_DCLASS_MINING,
		ACCESS_DCLASS_JANITORIAL
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_HAULING     = SKILL_TRAINED,
	                    SKILL_EVA         = SKILL_BASIC,
	                    SKILL_COMBAT      = SKILL_TRAINED,
	                    SKILL_WEAPONS     = SKILL_BASIC,
	                    SKILL_FORENSICS   = SKILL_BASIC)

	max_skill = list(   SKILL_COMBAT      = SKILL_EXPERIENCED,
	                    SKILL_WEAPONS     = SKILL_EXPERIENCED,
	                    SKILL_FORENSICS   = SKILL_TRAINED)
	skill_points = 17

/datum/job/enlistedofficerhcz

	title = "HCZ Guard"
	department = "Heavy Containment Personnel"
	department_flag = SEC
	total_positions = 6
	spawn_positions = 6
	//duties = "<big><b>As the Junior Guard you have minimal access. You are to guard tests, SCP's and provide support in the zone you spawned in. If in doubt, ask your Zone or Guard Commander. You should not leave your zone under usual SoP.</b></big>"
	//supervisors = "the Guard/Zone Commander"
	economic_power = 4
	alt_titles = list("HCZ Containment Response Agent", "HCZ Containment Response Guard", "HCZ Combat Medic", "HCZ Agent")
//	minimal_player_age = 0
	ideal_character_age = 25
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/security/enlistedofficerhcz
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e3,
		/datum/mil_rank/security/e4
	)
	hud_icon = "hudhczsenior"

	access = list(
		ACCESS_SEC_COMMS,
		ACCESS_SECURITY_LVL1,
		ACCESS_SECURITY_LVL2,
		ACCESS_SECURITY_LVL3,
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL2,
		ACCESS_SCIENCE_LVL3
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_HAULING     = SKILL_TRAINED,
	                    SKILL_EVA         = SKILL_BASIC,
	                    SKILL_COMBAT      = SKILL_TRAINED,
	                    SKILL_WEAPONS     = SKILL_BASIC,
	                    SKILL_FORENSICS   = SKILL_BASIC)

	max_skill = list(   SKILL_COMBAT      = SKILL_EXPERIENCED,
	                    SKILL_WEAPONS     = SKILL_EXPERIENCED,
	                    SKILL_FORENSICS   = SKILL_TRAINED)
	skill_points = 17

/datum/job/enlistedofficerez

	title = "EZ Agent"
	department = "Entrance Personnel"
	department_flag = SEC
	total_positions = 6
	spawn_positions = 6
	//duties = "<big><b>As the Junior Agent you have minimal access. You are to guard tests, SCP's and provide support in the zone you spawned in. If in doubt, ask your Zone or Guard Commander. You should not leave your zone under usual SoP.</b></big>"
	economic_power = 4
	alt_titles = list("Investigation Agent" = /decl/hierarchy/outfit/job/site90/crew/security/secauditor, "EZ Combat Medic" = /decl/hierarchy/outfit/job/site90/crew/security/medic)
	minimal_player_age = 0
	ideal_character_age = 25
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/security/enlistedofficerez
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e4,
		/datum/mil_rank/security/e5
	)
	hud_icon = "hudezsenior"

	access = list(
		ACCESS_SCIENCE_LVL1,
		ACCESS_SEC_COMMS,
		ACCESS_SECURITY_LVL1,
		ACCESS_SECURITY_LVL2,
		ACCESS_ENGINEERING_LVL1,
		ACCESS_MEDICAL_LVL1,
		ACCESS_MEDICAL_LVL2,
		ACCESS_MEDICAL_LVL3,
		ACCESS_ADMIN_LVL1,
		ACCESS_ADMIN_LVL2,
		ACCESS_CHAPEL_OFFICE
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_HAULING     = SKILL_TRAINED,
	                    SKILL_EVA         = SKILL_BASIC,
	                    SKILL_COMBAT      = SKILL_BASIC,
	                    SKILL_WEAPONS     = SKILL_TRAINED,
	                    SKILL_FORENSICS   = SKILL_EXPERIENCED)

	max_skill = list(   SKILL_COMBAT      = SKILL_EXPERIENCED,
	                    SKILL_WEAPONS     = SKILL_EXPERIENCED,
	                    SKILL_FORENSICS   = SKILL_MASTER)
	skill_points = 17


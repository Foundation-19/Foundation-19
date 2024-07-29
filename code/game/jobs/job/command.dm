/datum/job/captain
	title = "Site Director"
	department = "Command"
	head_position = TRUE
	department_flag = COM
	selection_color = "#1d1d4f"
	req_admin_notify = 1
	minimal_player_age = 20
	economic_power = 15
	ideal_character_age = 50
	outfit_type = /decl/hierarchy/outfit/job/command/facilitydir
	class = CLASS_A
	hud_icon = "hudsitedirector"

	total_positions = 1
	spawn_positions = 1

	access = list()				// see get_access() override
	minimal_access = list()		// see get_access() override

	max_skill = list(
		SKILL_WEAPONS       = SKILL_TRAINED,
		SKILL_COMPUTER		= SKILL_BASIC,
		SKILL_FINANCE       = SKILL_BASIC,
	)

	max_skill = list(
		SKILL_WEAPONS       = SKILL_EXPERIENCED,
		SKILL_COMPUTER		= SKILL_MASTER,
		SKILL_FINANCE       = SKILL_MASTER,
	)
	skill_points = 22

	requirements = list(EXP_TYPE_COMMAND = 1200)

	roleplay_difficulty = "Hard"
	mechanical_difficulty = "Easy"
	duties = "Communicate with your site's department heads. Delegate high-level responsibilities. Manage the site during on-going threats."

/datum/job/captain/get_access()
	return get_all_site_access()

/datum/job/hop
	title = "Site Manager"
	department = "Command"
	supervisors = "The Site Director"
	department_flag = COM|CIV|BUR|SRV
	selection_color = "#2f2f7f"
	head_position = TRUE
	total_positions = 1
	spawn_positions = 1
	req_admin_notify = 1
	economic_power = 10
	minimal_player_age = 15
	ideal_character_age = 45
	outfit_type = /decl/hierarchy/outfit/job/command/headofhr
	class = CLASS_A
	hud_icon = "hudhumanresources"
	alt_titles = list("Assistant Site Director")
	requirements = list(EXP_TYPE_COMMAND = 120, EXP_TYPE_BUR = 300)

	access = list(
		ACCESS_HOP,
		ACCESS_ADMIN_LVL1,
		ACCESS_ADMIN_LVL2,
		ACCESS_ADMIN_LVL3,
		ACCESS_ADMIN_LVL4,
		ACCESS_COM_COMMS,
		ACCESS_CHANGE_IDS,
		ACCESS_CIV_COMMS,
		ACCESS_ENGINEERING_LVL1,
		ACCESS_KEYAUTH,
		ACCESS_CHAPEL_OFFICE
	)

	minimal_access = list()

	max_skill = list(
		SKILL_WEAPONS       = SKILL_TRAINED,
		SKILL_COMPUTER		= SKILL_BASIC,
		SKILL_FINANCE       = SKILL_BASIC,
	)

	max_skill = list(
		SKILL_WEAPONS       = SKILL_EXPERIENCED,
		SKILL_COMPUTER		= SKILL_MASTER,
		SKILL_FINANCE       = SKILL_MASTER,
	)
	skill_points = 20

	roleplay_difficulty = "Medium"
	mechanical_difficulty = "Low - Medium"
	duties = "Manage available jobs. Change people's jobs and access levels. Assist the Site Director with human resources."

// COMMUNICATIONS

/datum/job/commsofficer
	title = "Communications Officer"
	department = "Command"
	department_flag = COM|ENG|SEC
	supervisors = "the Guard Commander and Site Director"
	selection_color = "#2f2f7f"
	total_positions = 1
	spawn_positions = 1
	economic_power = 10
	minimal_player_age = 15
	ideal_character_age = 45
	outfit_type = /decl/hierarchy/outfit/job/command/commsofficer
	class = CLASS_B
	hud_icon = "hudcommsofficer"
	requirements = list("Communications Technician" = 360)

	access = list(
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL3,
		ACCESS_COM_COMMS,
		ACCESS_SCI_COMMS,
		ACCESS_CIV_COMMS,
		ACCESS_LOG_COMMS,
		ACCESS_MED_COMMS,
		ACCESS_ENG_COMMS,
		ACCESS_SEC_COMMS,
		ACCESS_ADMIN_LVL4,
		ACCESS_ADMIN_LVL3,
		ACCESS_ADMIN_LVL2,
		ACCESS_ADMIN_LVL1,
		ACCESS_ENGINEERING_LVL1,
		ACCESS_ENGINEERING_LVL2,
		ACCESS_ENGINEERING_LVL3,
		ACCESS_NETWORK,
		ACCESS_SECURITY_LVL1,
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL2,
		ACCESS_SCIENCE_LVL3,
		ACCESS_KEYAUTH
	)

	minimal_access = list()

	min_skill = list(
		SKILL_COMPUTER      = SKILL_EXPERIENCED,
		SKILL_CONSTRUCTION  = SKILL_EXPERIENCED,
		SKILL_ELECTRICAL    = SKILL_EXPERIENCED,
		SKILL_ATMOS         = SKILL_EXPERIENCED,
		SKILL_ENGINES       = SKILL_TRAINED
	)

	max_skill = list(
		SKILL_CONSTRUCTION  = SKILL_MASTER,
		SKILL_ELECTRICAL    = SKILL_MASTER,
		SKILL_ATMOS         = SKILL_MASTER,
		SKILL_ENGINES       = SKILL_MASTER
	)
	skill_points = 30

	roleplay_difficulty = "Medium"
	mechanical_difficulty = "Medium"
	duties = "Keep communications systems online. Inform the site of on-going threats. Dispatch security. Manage your department."

// MISC

/datum/job/tribunal

	title = "Internal Tribunal Department Officer"
	department = "Civilian"
	selection_color = "#2f2f7f"
	department_flag = COM|BUR
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Tribunal Department"
	economic_power = 4
	minimal_player_age = 5
	ideal_character_age = 30
	outfit_type = /decl/hierarchy/outfit/job/civ/tribunal
	requirements = list(EXP_TYPE_COMMAND = 600, EXP_TYPE_SECURITY = 600, EXP_TYPE_BUR = 60)
	class = CLASS_A
	hud_icon = "huditdo"
	access = list(
		ACCESS_ADMIN_LVL1,
		ACCESS_ADMIN_LVL2,
		ACCESS_ADMIN_LVL3,
		ACCESS_ADMIN_LVL4,
		ACCESS_ADMIN_LVL5
	)

	minimal_access = list()

	max_skill = list(
		SKILL_WEAPONS       = SKILL_TRAINED,
		SKILL_COMPUTER		= SKILL_BASIC,
		SKILL_FINANCE       = SKILL_BASIC,
	)

	max_skill = list(
		SKILL_WEAPONS       = SKILL_EXPERIENCED,
		SKILL_COMPUTER		= SKILL_MASTER,
		SKILL_FINANCE       = SKILL_MASTER,
	)
	skill_points = 20

	roleplay_difficulty = "Hard"
	mechanical_difficulty = "Easy"
	duties = "Ensure Foundation protocols are followed. Keep security in line."

/datum/job/ethicsliaison

	title = "Ethics Committee Liaison"
	department = "Civilian"
	selection_color = "#2f2f7f"
	department_flag = COM|BUR
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Ethics Committee"
	economic_power = 4
	minimal_player_age = 5
	ideal_character_age = 30
	outfit_type = /decl/hierarchy/outfit/job/civ/ethics
	requirements = list(EXP_TYPE_BUR = 300)
	class = CLASS_A
	hud_icon = "hudecl"
	access = list(
		ACCESS_ADMIN_LVL1,
		ACCESS_ADMIN_LVL2,
		ACCESS_ADMIN_LVL3,
		ACCESS_ADMIN_LVL4,
		ACCESS_ADMIN_LVL5
	)

	minimal_access = list()

	max_skill = list(
		SKILL_WEAPONS       = SKILL_TRAINED,
		SKILL_COMPUTER		= SKILL_BASIC,
		SKILL_FINANCE       = SKILL_BASIC,
	)

	max_skill = list(
		SKILL_WEAPONS       = SKILL_EXPERIENCED,
		SKILL_COMPUTER		= SKILL_MASTER,
		SKILL_FINANCE       = SKILL_MASTER,
	)
	skill_points = 20

	roleplay_difficulty = "Hard"
	mechanical_difficulty = "Easy"
	duties = "Ensure that proper ethics is upheld, both with the treatment of personnel and of SCPs. Communicate with the Ethics Committee. Keep security in line."

/datum/job/goirep
	title = "Global Occult Coalition Representative"
	department = "Command"
	department_flag = REP|BUR
	selection_color = "#2f2f7f"
	supervisors = "Your respective Group of Interest leaders"
	total_positions = 1
	spawn_positions = 1
	economic_power = 5
	minimal_player_age = 9
	ideal_character_age = 30
	alt_titles = list(
		"Global Occult Coalition Ambassador",
		"UIU Relations Agent" = /decl/hierarchy/outfit/job/civ/uiu,
		"Marshall, Carter, and Dark Corporate Liaison" = /decl/hierarchy/outfit/job/civ/MCDRep,
		"Goldbaker-Reinz Corporate Liaison" = /decl/hierarchy/outfit/job/civ/grcl
	)
	outfit_type = /decl/hierarchy/outfit/job/civ/gocrep
	class = CLASS_A
	hud_icon = "hudgoi"
	requirements = list(EXP_TYPE_BUR = 30)

	access = list(
		ACCESS_COM_COMMS,
		ACCESS_ADMIN_LVL1,
		ACCESS_CHAPEL_OFFICE
	)

	minimal_access = list()

	max_skill = list(
		SKILL_WEAPONS       = SKILL_TRAINED,
		SKILL_COMPUTER		= SKILL_BASIC,
		SKILL_FINANCE       = SKILL_BASIC,
	)

	max_skill = list(
		SKILL_WEAPONS       = SKILL_EXPERIENCED,
		SKILL_COMPUTER		= SKILL_MASTER,
		SKILL_FINANCE       = SKILL_MASTER,
	)
	skill_points = 20

	roleplay_difficulty = "Hard"
	mechanical_difficulty = "Easy"
	duties = "Communicate with your respective Group of Interest and maintain diplomatic relations with the Foundation while also pursuing your group's interests."

/datum/job/commeng
	title = "Communications Technician"
	department = "Engineering"
	selection_color = "#5b4d20"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the Communications Officer"
	department_flag = ENG
	economic_power = 5
	minimal_player_age = 7
	ideal_character_age = 30
	requirements = list(EXP_TYPE_ENGINEERING = 300)
	alt_titles = list(
		"Communications Programmer",
		"Communications Dispatcher"
		)
	outfit_type = /decl/hierarchy/outfit/job/command/commstech
	class = CLASS_C
	hud_icon = "hudcommsprogrammer"

	access = list(
		ACCESS_COM_COMMS,
		ACCESS_SCI_COMMS,
		ACCESS_CIV_COMMS,
		ACCESS_LOG_COMMS,
		ACCESS_MED_COMMS,
		ACCESS_ENG_COMMS,
		ACCESS_SEC_COMMS,
		ACCESS_ADMIN_LVL1,
		ACCESS_ENGINEERING_LVL1,
		ACCESS_ENGINEERING_LVL2,
		ACCESS_ENGINEERING_LVL3
	)

	min_skill = list(
		SKILL_COMPUTER      = SKILL_BASIC,
		SKILL_CONSTRUCTION  = SKILL_EXPERIENCED,
		SKILL_ELECTRICAL    = SKILL_BASIC,
		SKILL_ATMOS         = SKILL_BASIC,
		SKILL_ENGINES       = SKILL_BASIC
	)

	max_skill = list(
		SKILL_CONSTRUCTION  = SKILL_MASTER,
		SKILL_ELECTRICAL    = SKILL_MASTER,
		SKILL_ATMOS         = SKILL_MASTER,
		SKILL_ENGINES       = SKILL_MASTER
	)
	skill_points = 20

	roleplay_difficulty = "Easy"
	mechanical_difficulty = "Medium"
	duties = "Keep communications systems online. Inform the site of on-going threats. Assist the Communications Officer."

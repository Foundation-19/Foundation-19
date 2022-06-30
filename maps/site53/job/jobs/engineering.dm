// ENGINEERING

/datum/job/juneng
	title = "Junior Engineer"
	total_positions = 4
	spawn_positions = 4
	department_flag = ENG
	//supervisors = "the Chief Engineer"
	economic_power = 5
	ideal_character_age = 30
	alt_titles = list(
		"Junior Maintenance Technician",
		"Junior Engine Technician",
		"Junior Damage Control Technician",
		"Junior Electrician"
		)
	outfit_type = /decl/hierarchy/outfit/job/ds90/crew/engineering/juneng
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e1,
		/datum/mil_rank/security/e2
	)

	access = list(
		access_eng_comms,
		access_engineeringlvl1,
		access_engineeringlvl2,
		access_sciencelvl1
	)
	minimal_access = list()

	max_skill = list(   SKILL_ANATOMY     = SKILL_MASTER,
	                    SKILL_DEVICES     = SKILL_MASTER,
	                    SKILL_SCIENCE     = SKILL_MASTER)

/datum/job/eng
	title = "Engineer"
	total_positions = 3
	spawn_positions = 3
	department_flag = ENG
	//supervisors = "the Chief Engineer"
	economic_power = 5
	minimal_player_age = 7
	ideal_character_age = 30
	alt_titles = list(
		"Maintenance Technician",
		"Engine Technician",
		"Damage Control Technician",
		"Electrician"
		)
	outfit_type = /decl/hierarchy/outfit/job/ds90/crew/engineering/juneng
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e3,
		/datum/mil_rank/security/e4,
		/datum/mil_rank/security/e5
	)

	access = list(
		access_eng_comms,
		access_engineeringlvl1,
		access_engineeringlvl2,
		access_engineeringlvl3,
		access_sciencelvl1
	)
	minimal_access = list()

	min_skill = list(   SKILL_COMPUTER     = SKILL_BASIC,
	                    SKILL_HAULING      = SKILL_EXPERIENCED,
	                    SKILL_EVA          = SKILL_EXPERIENCED,
	                    SKILL_CONSTRUCTION = SKILL_EXPERIENCED,
	                    SKILL_ELECTRICAL   = SKILL_EXPERIENCED,
	                    SKILL_ATMOS        = SKILL_EXPERIENCED,
	                    SKILL_ENGINES      = SKILL_EXPERIENCED)

	max_skill = list(   SKILL_CONSTRUCTION = SKILL_MASTER,
	                    SKILL_ELECTRICAL   = SKILL_MASTER,
	                    SKILL_ATMOS        = SKILL_MASTER,
	                    SKILL_ENGINES      = SKILL_MASTER)

/datum/job/seneng
	title = "Senior Engineer"
	total_positions = 2
	spawn_positions = 2
	department_flag = ENG
	//supervisors = "the Chief Engineer"
	economic_power = 5
	minimal_player_age = 7
	ideal_character_age = 30
	alt_titles = list(
		"Senior Maintenance Technician",
		"Senior Engine Technician",
		"Senior Damage Control Technician",
		"Senior Electrician"
		)
	outfit_type = /decl/hierarchy/outfit/job/ds90/crew/engineering/seneng
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e6,
		/datum/mil_rank/security/e7,
		/datum/mil_rank/security/e8
	)

	access = list(
		access_eng_comms,
		access_securitylvl1,
		access_sciencelvl1,
		access_sciencelvl2,
		access_engineeringlvl1,
		access_engineeringlvl2,
		access_engineeringlvl3,
		access_engineeringlvl4,
		access_engine_equip
	)
	minimal_access = list()

	min_skill = list(   SKILL_COMPUTER     = SKILL_BASIC,
	                    SKILL_HAULING      = SKILL_EXPERIENCED,
	                    SKILL_EVA          = SKILL_EXPERIENCED,
	                    SKILL_CONSTRUCTION = SKILL_EXPERIENCED,
	                    SKILL_ELECTRICAL   = SKILL_EXPERIENCED,
	                    SKILL_ATMOS        = SKILL_EXPERIENCED,
	                    SKILL_ENGINES      = SKILL_EXPERIENCED)

	max_skill = list(   SKILL_CONSTRUCTION = SKILL_MASTER,
	                    SKILL_ELECTRICAL   = SKILL_MASTER,
	                    SKILL_ATMOS        = SKILL_MASTER,
	                    SKILL_ENGINES      = SKILL_MASTER)

/datum/job/conteng
	title = "Containment Engineer"
	total_positions = 1
	spawn_positions = 1
	department_flag = ENG
	//supervisors = "the Chief Engineer"
	economic_power = 5
	minimal_player_age = 7
	ideal_character_age = 30
	outfit_type = /decl/hierarchy/outfit/job/ds90/crew/engineering/conteng
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e9,
		/datum/mil_rank/security/w2,
		/datum/mil_rank/security/w3,
		/datum/mil_rank/security/w4
	)

	access = list(
		access_eng_comms,
		access_securitylvl1,
		access_securitylvl2,
		access_securitylvl3,
		access_sciencelvl1,
		access_sciencelvl2,
		access_sciencelvl3,
		access_sciencelvl4,
		access_engineeringlvl1,
		access_engineeringlvl2,
		access_engineeringlvl3,
		access_engineeringlvl4,
		access_engine_equip
	)
	minimal_access = list()

	min_skill = list(   SKILL_COMPUTER     = SKILL_BASIC,
	                    SKILL_HAULING      = SKILL_EXPERIENCED,
	                    SKILL_EVA          = SKILL_EXPERIENCED,
	                    SKILL_CONSTRUCTION = SKILL_EXPERIENCED,
	                    SKILL_ELECTRICAL   = SKILL_EXPERIENCED,
	                    SKILL_ATMOS        = SKILL_EXPERIENCED,
	                    SKILL_ENGINES      = SKILL_EXPERIENCED)

	max_skill = list(   SKILL_CONSTRUCTION = SKILL_MASTER,
	                    SKILL_ELECTRICAL   = SKILL_MASTER,
	                    SKILL_ATMOS        = SKILL_MASTER,
	                    SKILL_ENGINES      = SKILL_MASTER)

/datum/job/chief_engineer
	title = "Chief Engineer"
	//supervisors = "the Security Commander and Facility Director"
	total_positions = 1
	spawn_positions = 1
	economic_power = 9
	ideal_character_age = 40
	minimal_player_age = 15
	outfit_type = /decl/hierarchy/outfit/job/ds90/crew/command/chief_engineer
	allowed_branches = list(/datum/mil_branch/security)
	allowed_ranks = list(
	/datum/mil_rank/security/o2,
	/datum/mil_rank/security/o3
	)

	access = list(
		access_eng_comms,
		access_securitylvl1,
		access_securitylvl2,
		access_securitylvl3,
		access_securitylvl4,
		access_securitylvl4,
		access_sciencelvl1,
		access_sciencelvl2,
		access_sciencelvl3,
		access_sciencelvl4,
		access_adminlvl1,
		access_engineeringlvl1,
		access_engineeringlvl2,
		access_engineeringlvl3,
		access_engineeringlvl4,
		access_engineeringlvl5,
		access_keyauth
	)
	minimal_access = list()

	min_skill = list(   SKILL_COMPUTER     = SKILL_BASIC,
	                    SKILL_HAULING      = SKILL_EXPERIENCED,
	                    SKILL_EVA          = SKILL_EXPERIENCED,
	                    SKILL_CONSTRUCTION = SKILL_EXPERIENCED,
	                    SKILL_ELECTRICAL   = SKILL_EXPERIENCED,
	                    SKILL_ATMOS        = SKILL_EXPERIENCED,
	                    SKILL_ENGINES      = SKILL_EXPERIENCED)

	max_skill = list(   SKILL_CONSTRUCTION = SKILL_MASTER,
	                    SKILL_ELECTRICAL   = SKILL_MASTER,
	                    SKILL_ATMOS        = SKILL_MASTER,
	                    SKILL_ENGINES      = SKILL_MASTER)

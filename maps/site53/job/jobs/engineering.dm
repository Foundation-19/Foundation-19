// ENGINEERING

/datum/job/juneng
	title = "Junior Engineer"
	total_positions = 6
	spawn_positions = 6
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
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classc)
	hud_icon = "hudengineertrainee"

	access = list(
		ACCESS_ENG_COMMS,
		ACCESS_ENGINEERING_LVL1,
		ACCESS_ENGINEERING_LVL2,
		ACCESS_SCIENCE_LVL1
	)
	minimal_access = list()

	max_skill = list(   SKILL_CONSTRUCTION = SKILL_MASTER,
	                    SKILL_ELECTRICAL   = SKILL_MASTER,
	                    SKILL_ATMOS        = SKILL_MASTER,
	                    SKILL_ENGINES      = SKILL_MASTER)

/datum/job/eng
	title = "Engineer"
	total_positions = 4
	spawn_positions = 4
	department_flag = ENG
	//supervisors = "the Chief Engineer"
	economic_power = 5
	minimal_player_age = 25
	ideal_character_age = 30
	alt_titles = list(
		"Maintenance Technician",
		"Engine Technician",
		"Damage Control Technician",
		"Electrician"
		)
	outfit_type = /decl/hierarchy/outfit/job/ds90/crew/engineering/eng
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classc)
	hud_icon = "hudengineer"

	access = list(
		ACCESS_ENG_COMMS,
		ACCESS_SECURITY_LVL1,
		ACCESS_ENGINEERING_LVL1,
		ACCESS_ENGINEERING_LVL2,
		ACCESS_ENGINEERING_LVL3,
		ACCESS_SCIENCE_LVL1
	)
	minimal_access = list()

	min_skill = list(   SKILL_COMPUTER     = SKILL_TRAINED,
	                    SKILL_HAULING      = SKILL_BASIC,
	                    SKILL_EVA          = SKILL_BASIC,
	                    SKILL_CONSTRUCTION = SKILL_TRAINED,
	                    SKILL_ELECTRICAL   = SKILL_TRAINED,
	                    SKILL_ATMOS        = SKILL_TRAINED,
	                    SKILL_ENGINES      = SKILL_TRAINED)

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
	minimal_player_age = 30
	ideal_character_age = 30
	alt_titles = list(
		"Senior Maintenance Technician",
		"Senior Engine Technician",
		"Senior Damage Control Technician",
		"Senior Electrician"
		)
	outfit_type = /decl/hierarchy/outfit/job/ds90/crew/engineering/seneng
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classc)
	hud_icon = "hudseniorengineer"

	access = list(
		ACCESS_ENG_COMMS,
		ACCESS_SECURITY_LVL1,
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL2,
		ACCESS_ENGINEERING_LVL1,
		ACCESS_ENGINEERING_LVL2,
		ACCESS_ENGINEERING_LVL3,
		ACCESS_ENGINEERING_LVL4,
		ACCESS_ATMOSPHERICS,
		ACCESS_ENGINE_EQUIP
	)
	minimal_access = list()

	min_skill = list(   SKILL_COMPUTER     = SKILL_EXPERIENCED,
	                    SKILL_HAULING      = SKILL_BASIC,
	                    SKILL_EVA          = SKILL_TRAINED,
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
	economic_power = 4
	minimal_player_age = 40
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
	hud_icon = "hudcontainmentengineer"
	
//NOTE, REMOVE SECURITY ACCESS LVL2 IF ABUSED!
	access = list(
		ACCESS_ENG_COMMS,
		ACCESS_SECURITY_LVL1,
		ACCESS_SECURITY_LVL2,
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL2,
		ACCESS_SCIENCE_LVL3,
		ACCESS_SCIENCE_LVL4,
		ACCESS_ENGINEERING_LVL1,
		ACCESS_ENGINEERING_LVL2,
		ACCESS_ENGINEERING_LVL3,
		ACCESS_ENGINEERING_LVL4,
		ACCESS_ATMOSPHERICS,
		ACCESS_ENGINE_EQUIP
	)
	minimal_access = list()

	min_skill = list(   SKILL_COMPUTER     = SKILL_EXPERIENCED,
	                    SKILL_HAULING      = SKILL_EXPERIENCED,
	                    SKILL_EVA          = SKILL_MASTER,
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
	minimal_player_age = 35
	outfit_type = /decl/hierarchy/outfit/job/ds90/crew/command/chief_engineer
	allowed_branches = list(/datum/mil_branch/security)
	allowed_ranks = list(
	/datum/mil_rank/security/o2,
	/datum/mil_rank/security/o3
	)
	hud_icon = "hudchiefengineer"

	access = list(
		ACCESS_ENG_COMMS,
		ACCESS_SECURITY_LVL1,
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL2,
		ACCESS_ADMIN_LVL1,
		ACCESS_ADMIN_LVL2,
		ACCESS_ADMIN_LVL3,
		ACCESS_ENGINEERING_LVL1,
		ACCESS_ENGINEERING_LVL2,
		ACCESS_ENGINEERING_LVL3,
		ACCESS_ENGINEERING_LVL4,
		ACCESS_ENGINEERING_LVL5,
		ACCESS_ATMOSPHERICS,
		ACCESS_ENGINE_EQUIP,
		ACCESS_KEYAUTH,
		ACCESS_NETWORK
	)
	minimal_access = list()

	min_skill = list(   SKILL_COMPUTER     = SKILL_EXPERIENCED,
	                    SKILL_HAULING      = SKILL_TRAINED,
	                    SKILL_EVA          = SKILL_TRAINED,
	                    SKILL_CONSTRUCTION = SKILL_MASTER,
	                    SKILL_ELECTRICAL   = SKILL_MASTER,
	                    SKILL_ATMOS        = SKILL_MASTER,
	                    SKILL_ENGINES      = SKILL_MASTER)

	max_skill = list(   SKILL_CONSTRUCTION = SKILL_MASTER,
	                    SKILL_ELECTRICAL   = SKILL_MASTER,
	                    SKILL_ATMOS        = SKILL_MASTER,
	                    SKILL_ENGINES      = SKILL_MASTER)

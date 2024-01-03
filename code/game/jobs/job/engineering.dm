/datum/job/juneng
	title = "Junior Engineer"
	department = "Engineering"
	total_positions = 6
	spawn_positions = 6
	department_flag = ENG
	selection_color = "#5b4d20"
	supervisors = "the Senior Engineers and Chief Engineer"
	economic_power = 3
	minimal_player_age = 0
	ideal_character_age = 20
	alt_titles = list(
		"Junior Maintenance Technician",
		"Junior Engine Technician",
		"Junior Damage Control Technician",
		"Junior Electrician"
		)
	outfit_type = /decl/hierarchy/outfit/job/engineering/juneng
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

	max_skill = list(
		SKILL_ANATOMY     = SKILL_MASTER,
	    SKILL_DEVICES     = SKILL_MASTER,
	    SKILL_SCIENCE     = SKILL_MASTER
	)

/datum/job/eng
	title = "Engineer"
	department = "Engineering"
	total_positions = 4
	spawn_positions = 4
	selection_color = "#5b4d20"
	department_flag = ENG
	supervisors = "the Senior Engineers and the Chief Engineer"
	economic_power = 4
	minimal_player_age = 3
	ideal_character_age = 25
	requirements = list(EXP_TYPE_ENGINEERING = 60)
	alt_titles = list(
		"Maintenance Technician",
		"Engine Technician",
		"Damage Control Technician",
		"Electrician"
		)
	outfit_type = /decl/hierarchy/outfit/job/engineering/eng
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

	min_skill = list(
		SKILL_COMPUTER     = SKILL_BASIC,
	    SKILL_HAULING      = SKILL_EXPERIENCED,
	    SKILL_CONSTRUCTION = SKILL_EXPERIENCED,
	    SKILL_ELECTRICAL   = SKILL_EXPERIENCED,
	    SKILL_ATMOS        = SKILL_EXPERIENCED,
	    SKILL_ENGINES      = SKILL_EXPERIENCED
	)

	max_skill = list(
		SKILL_CONSTRUCTION = SKILL_MASTER,
	    SKILL_ELECTRICAL   = SKILL_MASTER,
	    SKILL_ATMOS        = SKILL_MASTER,
	    SKILL_ENGINES      = SKILL_MASTER
	)

/datum/job/seneng
	title = "Senior Engineer"
	department = "Engineering"
	total_positions = 2
	spawn_positions = 2
	department_flag = ENG
	selection_color = "#5b4d20"
	supervisors = "the Chief Engineer"
	economic_power = 5
	minimal_player_age = 7
	ideal_character_age = 30
	requirements = list("Engineer" = 480)
	alt_titles = list(
		"Senior Maintenance Technician",
		"Senior Engine Technician",
		"Senior Damage Control Technician",
		"Senior Electrician"
		)
	outfit_type = /decl/hierarchy/outfit/job/engineering/seneng
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

	min_skill = list(
		SKILL_COMPUTER     = SKILL_BASIC,
	    SKILL_HAULING      = SKILL_EXPERIENCED,
	    SKILL_CONSTRUCTION = SKILL_EXPERIENCED,
	    SKILL_ELECTRICAL   = SKILL_EXPERIENCED,
	    SKILL_ATMOS        = SKILL_EXPERIENCED,
	    SKILL_ENGINES      = SKILL_EXPERIENCED
	)

	max_skill = list(
		SKILL_CONSTRUCTION = SKILL_MASTER,
	    SKILL_ELECTRICAL   = SKILL_MASTER,
	    SKILL_ATMOS        = SKILL_MASTER,
	    SKILL_ENGINES      = SKILL_MASTER
	)

/datum/job/conteng
	title = "Containment Engineer"
	department = "Engineering"
	total_positions = 2
	spawn_positions = 2
	department_flag = ENG
	selection_color = "#5b4d20"
	supervisors = "the Chief Engineer"
	economic_power = 5
	minimal_player_age = 10
	ideal_character_age = 30
	outfit_type = /decl/hierarchy/outfit/job/engineering/conteng
	requirements = list("Engineer" = 480, EXP_TYPE_ENGINEERING = 600)
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

	access = list(
		ACCESS_ENG_COMMS,
		ACCESS_SECURITY_LVL1,
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

	min_skill = list(
		SKILL_COMPUTER     = SKILL_BASIC,
	    SKILL_HAULING      = SKILL_EXPERIENCED,
	    SKILL_CONSTRUCTION = SKILL_EXPERIENCED,
	    SKILL_ELECTRICAL   = SKILL_EXPERIENCED,
	    SKILL_ATMOS        = SKILL_EXPERIENCED,
	    SKILL_ENGINES      = SKILL_EXPERIENCED
	)

	max_skill = list(
		SKILL_CONSTRUCTION = SKILL_MASTER,
	    SKILL_ELECTRICAL   = SKILL_MASTER,
	    SKILL_ATMOS        = SKILL_MASTER,
	    SKILL_ENGINES      = SKILL_MASTER
	)

/datum/job/chief_engineer
	title = "Chief Engineer"
	department = "Engineering"
	supervisors = "the Site Director"
	department_flag = ENG|COM
	selection_color = "#5b4d20"
	total_positions = 1
	spawn_positions = 1
	economic_power = 9
	ideal_character_age = 35
	minimal_player_age = 20
	requirements = list("Senior Engineer" = 480, EXP_TYPE_ENGINEERING = 1200)
	outfit_type = /decl/hierarchy/outfit/job/command/chief_engineer
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
		ACCESS_SCIENCE_LVL3,
		ACCESS_SCIENCE_LVL4,
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

	min_skill = list(
		SKILL_COMPUTER     = SKILL_BASIC,
	    SKILL_HAULING      = SKILL_EXPERIENCED,
	    SKILL_CONSTRUCTION = SKILL_EXPERIENCED,
	    SKILL_ELECTRICAL   = SKILL_EXPERIENCED,
	    SKILL_ATMOS        = SKILL_EXPERIENCED,
	    SKILL_ENGINES      = SKILL_EXPERIENCED
	)

	max_skill = list(
		SKILL_CONSTRUCTION = SKILL_MASTER,
	    SKILL_ELECTRICAL   = SKILL_MASTER,
	    SKILL_ATMOS        = SKILL_MASTER,
	    SKILL_ENGINES      = SKILL_MASTER
	)

	roleplay_difficulty = "Medium - Hard"
	mechanical_difficulty = "Medium - Hard"
	duties = "Manage the Engineering department. Delegate construction and repair work. Facilitate larger projects."
	codex_guides = list("<l>Hacking Wires</l>")

/datum/job/it_tech
	title = "IT Technician"
	department = "Engineering"
	selection_color = "#5b4d20"
	department_flag = ENG
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Chief Engineer"
	economic_power = 4
	minimal_player_age = 3
	ideal_character_age = 30
	requirements = list("Engineer" = 180, EXP_TYPE_ENGINEERING = 300)
	outfit_type = /decl/hierarchy/outfit/job/engineering/it_tech
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classc)
	hud_icon = "hudittech"

	access = list(
		ACCESS_ENG_COMMS,
		ACCESS_ENGINEERING_LVL1,
		ACCESS_ENGINEERING_LVL2,
		ACCESS_ENGINEERING_LVL3,
		ACCESS_ADMIN_LVL1,
		ACCESS_SCIENCE_LVL1,
		ACCESS_NETWORK
	)
	minimal_access = list()

	min_skill = list(
		SKILL_COMPUTER     = SKILL_EXPERIENCED,
	    SKILL_CONSTRUCTION = SKILL_BASIC,
	    SKILL_ELECTRICAL   = SKILL_BASIC
	)

	max_skill = list(
		SKILL_COMPUTER     = SKILL_MASTER
	)

	roleplay_difficulty = "Easy - Medium"
	mechanical_difficulty = "Medium"
	duties = "Maintain and expand the advanced technology behind the site's server infrastructure. Resolve technical problems. Prepare and protect against cybersecurity attacks."

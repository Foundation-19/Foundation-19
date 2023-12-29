/datum/job/juniorscientist
	title = "Researcher Associate"
	department = "Science"
	department_flag = SCI
	selection_color = "#633d63"
	total_positions = 10
	spawn_positions = 10
	supervisors = "the Senior Researchers and Research Director"
	economic_power = 4
	alt_titles = list("Junior Xenobiologist", "Junior Xenoarcheologist", "Assistant Researcher", "Research Assistant", "Research Intern", "Junior Researcher")
	ideal_character_age = 20
	outfit_type = /decl/hierarchy/outfit/job/science/juniorscientist
	class = CLASS_C
	hud_icon = "hudresearchassistant"

	access = list(
		ACCESS_SCI_COMMS,
		ACCESS_SCIENCE_LVL1
	)
	minimal_access = list()

	min_skill = list(
	    SKILL_COMPUTER    = SKILL_BASIC,
	    SKILL_DEVICES     = SKILL_BASIC,
	    SKILL_SCIENCE     = SKILL_EXPERIENCED
	)

	max_skill = list(
		SKILL_ANATOMY     = SKILL_MASTER,
	    SKILL_DEVICES     = SKILL_MASTER,
	    SKILL_SCIENCE     = SKILL_MASTER
	)

	skill_points = 10

	roleplay_difficulty = "Easy"
	mechanical_difficulty = "Easy - Medium"
	duties = "Assist with experiments and technological developments."

/datum/job/juniorroboticist
	title = "Junior Robotics Technician"
	department = "Science"
	department_flag = SCI
	selection_color = "#633d63"
	total_positions = 5
	spawn_positions = 5
	supervisors = "the Senior Robotics Technicians and Research Director"
	economic_power = 4
	alt_titles = list("Junior Exoskeleton Technician", "Junior Hardsuit Technician")
	ideal_character_age = 20
	outfit_type = /decl/hierarchy/outfit/job/science/juniorroboticist
	class = CLASS_C
	hud_icon = "hudresearchassistant"

	access = list(
		ACCESS_SCI_COMMS,
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL2
	)
	minimal_access = list()

	min_skill = list(
	    SKILL_COMPUTER    = SKILL_BASIC,
	    SKILL_DEVICES     = SKILL_BASIC,
	    SKILL_SCIENCE     = SKILL_BASIC,
		SKILL_ELECTRICAL  = SKILL_BASIC
	)

	max_skill = list(
		SKILL_ANATOMY     = SKILL_MASTER,
	    SKILL_DEVICES     = SKILL_MASTER,
	    SKILL_SCIENCE     = SKILL_MASTER
	)

	skill_points = 12

	roleplay_difficulty = "Easy"
	mechanical_difficulty = "Easy - Medium"

/datum/job/scientist
	title = "Researcher"
	department = "Science"
	department_flag = SCI
	total_positions = 8
	spawn_positions = 8
	selection_color = "#633d63"
	supervisors = "the Senior Researchers and Research Director"
	economic_power = 4
	requirements = list(EXP_TYPE_SCIENCE = 60)
	alt_titles = list("Xenobiologist", "Xenoarcheologist")
	minimal_player_age = 3
	ideal_character_age = 24
	outfit_type = /decl/hierarchy/outfit/job/science/scientist
	class = CLASS_C
	hud_icon = "hudscientist"

	access = list(
	ACCESS_SCI_COMMS,
	ACCESS_SCIENCE_LVL1,
	ACCESS_SCIENCE_LVL2
	)
	minimal_access = list()

	min_skill = list(
	    SKILL_COMPUTER    = SKILL_BASIC,
	    SKILL_DEVICES     = SKILL_BASIC,
	    SKILL_SCIENCE     = SKILL_EXPERIENCED
	)

	max_skill = list(
		SKILL_ANATOMY     = SKILL_MASTER,
	    SKILL_DEVICES     = SKILL_MASTER,
	    SKILL_SCIENCE     = SKILL_MASTER
	)

	skill_points = 15

	roleplay_difficulty = "Easy - Medium"
	mechanical_difficulty = "Medium"
	duties = "Perform experiments and develop new technologies. Instruct junior researchers."

/datum/job/roboticist
	title = "Robotics Technician"
	department = "Science"
	department_flag = SCI
	selection_color = "#633d63"
	total_positions = 3
	spawn_positions = 3
	supervisors = "the Senior Robotics Technicians and Research Director"
	economic_power = 4
	requirements = list(EXP_TYPE_SCIENCE = 60)
	alt_titles = list("Exoskeleton Technician", "Hardsuit Technician")
	minimal_player_age = 3
	ideal_character_age = 24
	outfit_type = /decl/hierarchy/outfit/job/science/roboticist
	class = CLASS_C
	hud_icon = "hudscientist"

	access = list(
		ACCESS_SCI_COMMS,
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL2,
		ACCESS_SCIENCE_LVL3
	)
	minimal_access = list()

	min_skill = list(
	    SKILL_COMPUTER    = SKILL_BASIC,
	    SKILL_DEVICES     = SKILL_TRAINED,
	    SKILL_SCIENCE     = SKILL_BASIC,
		SKILL_ELECTRICAL  = SKILL_TRAINED
	)

	max_skill = list(
		SKILL_ANATOMY     = SKILL_MASTER,
	    SKILL_DEVICES     = SKILL_MASTER,
	    SKILL_SCIENCE     = SKILL_MASTER
	)

	skill_points = 14

	roleplay_difficulty = "Easy - Medium"
	mechanical_difficulty = "Medium"


/datum/job/seniorscientist
	title = "Senior Researcher"
	department = "Science"
	department_flag = SCI
	selection_color = "#633d63"
	total_positions = 3
	spawn_positions = 3
	supervisors = "the Research Director"
	economic_power = 4
	requirements = list("Researcher" = 480)
	alt_titles = list("Senior Xenobiologist", "Senior Xenoarcheologist")
	minimal_player_age = 7
	ideal_character_age = 30
	outfit_type = /decl/hierarchy/outfit/job/science/seniorscientist
	class = CLASS_B
	hud_icon = "hudseniorresearcher"

	access = list(
		ACCESS_SCI_COMMS,
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL2,
		ACCESS_SCIENCE_LVL3,
		ACCESS_SCIENCE_LVL4,
		ACCESS_SECURITY_LVL1,
		ACCESS_RESEARCH
	)
	minimal_access = list()

	min_skill = list(
	    SKILL_COMPUTER    = SKILL_BASIC,
	    SKILL_DEVICES     = SKILL_TRAINED,
	    SKILL_SCIENCE     = SKILL_EXPERIENCED
	)

	max_skill = list(
		SKILL_ANATOMY     = SKILL_MASTER,
	    SKILL_DEVICES     = SKILL_MASTER,
	    SKILL_SCIENCE     = SKILL_MASTER
	)

	skill_points = 20

	roleplay_difficulty = "Medium"
	mechanical_difficulty = "Medium"
	duties = "Perform experiments and develop new technologies. Manage subordinate researchers."

/datum/job/seniorroboticist
	title = "Senior Robotics Technician"
	department = "Science"
	department_flag = SCI
	selection_color = "#633d63"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the Research Director"
	economic_power = 4
	requirements = list("Robotics Technician" = 480)
	alt_titles = list("Senior Exoskeleton Technician", "Senior Hardsuit Technician")
	minimal_player_age = 7
	ideal_character_age = 30
	outfit_type = /decl/hierarchy/outfit/job/science/seniorroboticist
	class = CLASS_B
	hud_icon = "hudseniorresearcher"

	access = list(
		ACCESS_SCI_COMMS,
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL2,
		ACCESS_SCIENCE_LVL3,
		ACCESS_SCIENCE_LVL4
	)
	minimal_access = list()

	min_skill = list(
	    SKILL_COMPUTER    = SKILL_BASIC,
	    SKILL_DEVICES     = SKILL_TRAINED,
	    SKILL_SCIENCE     = SKILL_TRAINED,
		SKILL_ELECTRICAL  = SKILL_EXPERIENCED
	)

	max_skill = list(
		SKILL_ANATOMY     = SKILL_MASTER,
	    SKILL_DEVICES     = SKILL_MASTER,
	    SKILL_SCIENCE     = SKILL_MASTER
	)

	skill_points = 18

	roleplay_difficulty = "Medium"
	mechanical_difficulty = "Medium"

/datum/job/rd
	title = "Research Director"
	department = "Science"
	department_flag = COM|SCI
	selection_color = "#ad6bad"
	head_position = TRUE
	total_positions = 1
	spawn_positions = 1
	economic_power = 15
	requirements = list("Senior Researcher" = 240, EXP_TYPE_SCIENCE = 900)
	req_admin_notify = 1
	supervisors = "the Site Director"
	alt_titles = list("Chief Science Officer", "Head Researcher")
	minimal_player_age = 20
	ideal_character_age = 40
	spawn_positions = 6
	outfit_type = /decl/hierarchy/outfit/job/command/researchdirector
	class = CLASS_A
	hud_icon = "hudchiefscienceofficer"

	access = list(
		ACCESS_COM_COMMS,
		ACCESS_SCI_COMMS,
		ACCESS_SCIENCE_LVL5,
		ACCESS_SCIENCE_LVL4,
		ACCESS_SCIENCE_LVL3,
		ACCESS_SCIENCE_LVL2,
		ACCESS_SCIENCE_LVL1,
		ACCESS_SECURITY_LVL1,
		ACCESS_MEDICAL_LVL1,
		ACCESS_ADMIN_LVL1,
		ACCESS_ADMIN_LVL2,
		ACCESS_ADMIN_LVL3,
		ACCESS_ADMIN_LVL4,
		ACCESS_KEYAUTH,
		ACCESS_RESEARCH
	)
	minimal_access = list()

	min_skill = list(
	    SKILL_COMPUTER    = SKILL_TRAINED,
	    SKILL_DEVICES     = SKILL_TRAINED,
	    SKILL_SCIENCE     = SKILL_EXPERIENCED
	)

	max_skill = list(
		SKILL_ANATOMY     = SKILL_MASTER,
	    SKILL_DEVICES     = SKILL_MASTER,
	    SKILL_SCIENCE     = SKILL_MASTER
	)

	skill_points = 25

	roleplay_difficulty = "Medium - Hard"
	mechanical_difficulty = "Medium - Hard"
	duties = "Manage the Research department. Coordinate experiments and technological developments."

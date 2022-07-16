// SCIENCE

/datum/job/juniorscientist
	title = "Researcher Associate"
	department = "Science"
	department_flag = SCI
	total_positions = 10
	spawn_positions = 10
	//supervisors = "the Research Director and anyone in a higher position than you"
	economic_power = 4
	alt_titles = list("Junior Xenobiologist", "Junior Xenoarcheologist", "Assistant Researcher", "Research Assistant", "Research Intern", "Junior Researcher", "Junior Robotics Technician")
	ideal_character_age = 22
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/science/juniorscientist
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classb, /datum/mil_rank/civ/classc)
	hud_icon = "hudresearchassistant"

	access = list(
		access_sci_comms,
		access_sciencelvl1
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_DEVICES     = SKILL_BASIC,
	                    SKILL_SCIENCE     = SKILL_EXPERIENCED)

	max_skill = list(   SKILL_ANATOMY     = SKILL_MASTER,
	                    SKILL_DEVICES     = SKILL_MASTER,
	                    SKILL_SCIENCE     = SKILL_MASTER)

	skill_points = 10

/datum/job/scientist
	title = "Researcher"
	department = "Science"
	department_flag = SCI
	total_positions = 8
	spawn_positions = 8
	//supervisors = "the Research Director and anyone in a higher position than you"
	economic_power = 4
	alt_titles = list("Xenobiologist", "Xenoarcheologist", "Robotics Technician")
	minimal_player_age = 5
	ideal_character_age = 22
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/science/scientist
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classb)
	hud_icon = "hudscientist"

	access = list(
	access_sci_comms,
	access_sciencelvl1,
	access_sciencelvl2,
	access_research
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_DEVICES     = SKILL_BASIC,
	                    SKILL_SCIENCE     = SKILL_EXPERIENCED)

	max_skill = list(   SKILL_ANATOMY     = SKILL_MASTER,
	                    SKILL_DEVICES     = SKILL_MASTER,
	                    SKILL_SCIENCE     = SKILL_MASTER)

	skill_points = 15

/datum/job/seniorscientist
	title = "Senior Researcher"
	department = "Science"
	department_flag = SCI
	total_positions = 4
	spawn_positions = 4
	//supervisors = "the Research Director and anyone in a higher position than you"
	economic_power = 4
	alt_titles = list("Senior Xenobiologist", "Senior Xenoarcheologist", "Senior Robotics Technician")
	minimal_player_age = 10
	ideal_character_age = 22
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/science/seniorscientist
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classb)
	hud_icon = "hudseniorresearcher"

	access = list(
		access_sci_comms,
		access_sciencelvl1,
		access_sciencelvl2,
		access_sciencelvl3,
		access_sciencelvl4,
		access_securitylvl1,
		access_research
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_DEVICES     = SKILL_TRAINED,
	                    SKILL_SCIENCE     = SKILL_EXPERIENCED)

	max_skill = list(   SKILL_ANATOMY     = SKILL_MASTER,
	                    SKILL_DEVICES     = SKILL_MASTER,
	                    SKILL_SCIENCE     = SKILL_MASTER)

	skill_points = 20

/datum/job/rd
	title = "Research Director"
	//supervisors = "Facility Director and the Head of Human Resources"
	total_positions = 1
	spawn_positions = 1
	economic_power = 20
	minimal_player_age = 15
	ideal_character_age = 60
	spawn_positions = 6
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/science/researchdirector
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classa)
	hud_icon = "hudchiefscienceofficer"

	access = list(
		access_com_comms,
		access_sci_comms,
		access_sciencelvl5,
		access_sciencelvl4,
		access_sciencelvl3,
		access_sciencelvl2,
		access_sciencelvl1,
		access_securitylvl1,
		access_medicallvl1,
		access_adminlvl1,
		access_adminlvl2,
		access_adminlvl3,
		access_adminlvl4,
		access_keyauth,
		access_research
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_COMPUTER    = SKILL_TRAINED,
	                    SKILL_DEVICES     = SKILL_TRAINED,
	                    SKILL_SCIENCE     = SKILL_EXPERIENCED)

	max_skill = list(   SKILL_ANATOMY     = SKILL_MASTER,
	                    SKILL_DEVICES     = SKILL_MASTER,
	                    SKILL_SCIENCE     = SKILL_MASTER)

	skill_points = 25

/datum/job/thaumaturge
	title = "Thaumaturge"
	department = "Science"
	department_flag = SCI
	total_positions = 1
	spawn_positions = 6
	economic_power = 4
	alt_titles = list("Thaumaturgist")
	minimal_player_age = 10
	ideal_character_age = 22
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/science/thaumaturge
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classb)
	hud_icon = "hudseniorresearcher"

	access = list(
		access_sci_comms,
		access_sciencelvl1,
		access_sciencelvl2,
		access_sciencelvl3,
		access_sciencelvl4,
		access_securitylvl1,
		access_research
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_DEVICES     = SKILL_TRAINED,
	                    SKILL_SCIENCE     = SKILL_EXPERIENCED)

	max_skill = list(   SKILL_ANATOMY     = SKILL_MASTER,
	                    SKILL_DEVICES     = SKILL_MASTER,
	                    SKILL_SCIENCE     = SKILL_MASTER)

	skill_points = 20

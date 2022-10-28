/datum/job/rd
	title = "Research Director"
	head_position = 1
	department = "Science"
	department_flag = COM|SCI

	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain"
	selection_color = "#ad6bad"
	req_admin_notify = 1
	economic_power = 15
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
	minimal_player_age = 14
	ideal_character_age = 50
	outfit_type = /decl/hierarchy/outfit/job/science/rd

// SCP JOBS

/datum/job/seniorscientist
	title = "Senior Researcher"
	department = "Science"
	department_flag = SCI
	selection_color = "#633d63"
	total_positions = 6
	spawn_positions = 6
	supervisors = "the Research Director"
	economic_power = 4
	alt_titles = list("Senior Xenobiologist", "Senior Xenoarcheologist")
	minimal_player_age = 10
	ideal_character_age = 40
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/science/seniorscientist
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classb)
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

/datum/job/scientist
	title = "Scientist"
	department = "Science"
	department_flag = SCI
	selection_color = "#633d63"
	total_positions = 6
	spawn_positions = 6
	supervisors = "the Research Director and anyone in a higher position than you"
	economic_power = 4
	alt_titles = list("Xenobiologist", "Xenoarcheologist")
	minimal_player_age = 5
	ideal_character_age = 32
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/science/scientist
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classc)
	access = list(
		ACCESS_SCI_COMMS,
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL2,
		ACCESS_RESEARCH
	)
	minimal_access = list()

/datum/job/juniorscientist
	title = "Junior Scientist"
	department = "Science"
	department_flag = SCI
	selection_color = "#633d63"
	total_positions = 6
	spawn_positions = 6
	supervisors = "the Research Director and anyone in a higher position than you"
	economic_power = 4
	alt_titles = list("Junior Xenobiologist", "Junior Xenoarcheologist")
	minimal_player_age = 0
	ideal_character_age = 25
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/science/juniorscientist
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classc)
	access = list(
		ACCESS_SCI_COMMS,
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL2,
		ACCESS_RESEARCH
	)
	minimal_access = list()


/datum/job/seniorroboticist
	title = "Senior Robotics Technician"
	department = "Science"
	department_flag = SCI
	selection_color = "#633d63"
	total_positions = 3
	spawn_positions = 3
	//supervisors = "the Research Director and anyone in a higher position than you"
	economic_power = 4
	alt_titles = list("Senior Exoskeleton Technician", "Senior Hardsuit Technician")
	ideal_character_age = 22
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/science/seniorroboticist
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classb, /datum/mil_rank/civ/classc)
	access = list(
		ACCESS_SCI_COMMS,
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL2,
		ACCESS_SCIENCE_LVL3,
		ACCESS_SCIENCE_LVL4
	)
	minimal_access = list()

/datum/job/roboticist
	title = "Robotics Technician"
	department = "Science"
	department_flag = SCI
	selection_color = "#633d63"
	total_positions = 3
	spawn_positions = 3
	//supervisors = "the Research Director and anyone in a higher position than you"
	economic_power = 4
	alt_titles = list("Exoskeleton Technician", "Hardsuit Technician")
	minimal_player_age = 5
	ideal_character_age = 22
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/science/roboticist
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classb, /datum/mil_rank/civ/classc)
	access = list(
		ACCESS_SCI_COMMS,
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL2,
		ACCESS_SCIENCE_LVL3
	)
	minimal_access = list()

/datum/job/juniorroboticist
	title = "Junior Robotics Technician"
	department = "Science"
	department_flag = SCI
	selection_color = "#633d63"
	total_positions = 3
	spawn_positions = 3
	//supervisors = "the Research Director and anyone in a higher position than you"
	economic_power = 4
	alt_titles = list("Junior Exoskeleton Technician", "Junior Hardsuit Technician")
	ideal_character_age = 22
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/science/juniorroboticist
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classc)
	hud_icon = "hudresearchassistant"
	access = list(
		ACCESS_SCI_COMMS,
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL2
	)
	minimal_access = list()

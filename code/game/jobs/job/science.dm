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
		access_sciencelvl2
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
		access_sci_comms,
		access_sciencelvl1,
		access_sciencelvl2,
		access_sciencelvl3,
		access_sciencelvl4,
		access_securitylvl1,
		access_sciencelvl2
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
		access_sci_comms,
		access_sciencelvl1,
		access_sciencelvl2,
		access_sciencelvl2
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
		access_sci_comms,
		access_sciencelvl1,
		access_sciencelvl2,
		access_sciencelvl2
	)
	minimal_access = list()


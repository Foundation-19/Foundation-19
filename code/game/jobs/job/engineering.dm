/datum/job/chief_engineer
	title = "Chief Engineer"
	supervisors = "the Security Commander and Facility Director"
	selection_color = "#5b4d20"
	department_flag = ENG|COM
	economic_power = 9
	ideal_character_age = 40
	minimal_player_age = 21
	outfit_type = /decl/hierarchy/outfit/job/ds90/crew/command/chief_engineer
	allowed_branches = list(/datum/mil_branch/security)
	allowed_ranks = list(/datum/mil_rank/security/o1)

	access = list(access_mtflvl1, access_mtflvl2, access_mtflvl3, access_mtflvl4)
	minimal_access = list()

/datum/job/conteng
	title = "Containment Engineer"
	total_positions = 1
	spawn_positions = 2
	department_flag = ENG
	supervisors = "the Chief Engineer"
	selection_color = "#5b4d20"
	economic_power = 5
	minimal_player_age = 7
	ideal_character_age = 30
	outfit_type = /decl/hierarchy/outfit/job/ds90/crew/engineering/conteng
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/w1
	)

	access = list(access_mtflvl1, access_mtflvl2, access_mtflvl3, access_mtflvl4, access_sciencelvl1, access_sciencelvl2, access_sciencelvl3, access_sciencelvl4)
	minimal_access = list()

/datum/job/commeng
	selection_color = "#5b4d20"
	title = "Communications Technician"
	total_positions = 0
	spawn_positions = 0
	department_flag = ENG
	supervisors = "the Communications Officer"
	economic_power = 5
	minimal_player_age = 7
	ideal_character_age = 30
	alt_titles = list(
		"Communications Programmer"
		)
//	outfit_type = /decl/hierarchy/outfit/job/ds90/crew/engineering/juneng
//	allowed_branches = list(
//		/datum/mil_branch/security
//	)
//	allowed_ranks = list(
//		/datum/mil_rank/security/e5,
//		/datum/mil_rank/security/e6
//	)

/datum/job/seneng
	title = "Senior Engineer"
	total_positions = 4
	spawn_positions = 4
	department_flag = ENG
	supervisors = "the Chief Engineer"
	selection_color = "#5b4d20"
	economic_power = 5
	minimal_player_age = 7
	ideal_character_age = 30
	alt_titles = list(
		"Senior Maintenance Technician",
		"Senior Engine Technician",
		"Senior Damage Control Technician",
		"Senior Electrician",
		"Senior Atmospheric Technician"
		)
	outfit_type = /decl/hierarchy/outfit/job/ds90/crew/engineering/seneng
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e7,
		/datum/mil_rank/security/e8,
		/datum/mil_rank/security/e9
	)

	access = list(access_mtflvl1, access_mtflvl2, access_mtflvl3, access_mtflvl4)
	minimal_access = list()

/datum/job/engineer
	title = "Engineer"
	selection_color = "#5b4d20"
	total_positions = 4
	spawn_positions = 4
	department_flag = ENG
	supervisors = "the Chief Engineer"
	economic_power = 5
	minimal_player_age = 7
	ideal_character_age = 30
	alt_titles = list(
		"Junior Maintenance Technician",
		"Junior Engine Technician",
		"Junior Damage Control Technician",
		"Junior Electrician",
		"Junior Atmospheric Technician",
		)
	outfit_type = /decl/hierarchy/outfit/job/ds90/crew/engineering/eng
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e4,
		/datum/mil_rank/security/e5
	)

	access = list(access_mtflvl1, access_mtflvl2, access_mtflvl3)
	minimal_access = list()

/datum/job/juneng
	title = "Junior Engineer"
	selection_color = "#5b4d20"
	total_positions = 4
	spawn_positions = 4
	department_flag = ENG
	supervisors = "the Chief Engineer"
	economic_power = 5
	minimal_player_age = 7
	ideal_character_age = 30
	alt_titles = list(
		"Junior Maintenance Technician",
		"Junior Engine Technician",
		"Junior Damage Control Technician",
		"Junior Electrician",
		"Junior Atmospheric Technician",
		)
	outfit_type = /decl/hierarchy/outfit/job/ds90/crew/engineering/juneng
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e4
	)

	access = list(access_mtflvl1, access_mtflvl2)
	minimal_access = list()




/*
/datum/job/engineer
	title = "Engineer"
	department = "Engineering"
	department_flag = ENG

	total_positions = 8
	spawn_positions = 7
	supervisors = "the chief engineer"
	selection_color = "#5b4d20"
	economic_power = 5
	minimal_player_age = 7
	access = list(access_eva, access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels, access_external_airlocks, access_construction, access_atmospherics, access_emergency_storage)
	minimal_access = list(access_eva, access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels, access_external_airlocks, access_construction, access_atmospherics, access_emergency_storage)
	alt_titles = list("Maintenance Technician","Engine Technician","Electrician",
		"Atmospheric Technician" = /decl/hierarchy/outfit/job/engineering/atmos)
	outfit_type = /decl/hierarchy/outfit/job/engineering/engineer

/datum/job/atmos
	title = "Atmospheric Technician"
	department = "Engineering"
	department_flag = ENG

	total_positions = 0
	spawn_positions = 0
	supervisors = "the chief engineer"
	selection_color = "#5b4d20"
	economic_power = 5
	minimal_player_age = 7
	access = list(access_eva, access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels, access_external_airlocks, access_construction, access_atmospherics, access_emergency_storage)
	minimal_access = list(access_eva, access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels, access_external_airlocks, access_construction, access_atmospherics, access_emergency_storage)
	outfit_type = /decl/hierarchy/outfit/job/engineering/atmos
*/
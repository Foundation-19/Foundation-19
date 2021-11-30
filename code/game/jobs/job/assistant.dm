/datum/job/assistant
	title = "Class D"
	department = "Civilian"
	department_flag = CIV
	selection_color = "#FFA500"

	total_positions = 20
	spawn_positions = 20

	supervisors = "Foundation Personnel"
	selection_color = "#E55700"
	economic_power = 1
	access = list()			//See /datum/job/assistant/get_access()
	minimal_access = list()	//See /datum/job/assistant/get_access()
	outfit_type = /decl/hierarchy/outfit/job/assistant

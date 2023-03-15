SUBSYSTEM_DEF(goals)
	name = "Goals"
	init_order = SS_INIT_GOALS
	wait = 1 SECOND
	flags = SS_NO_FIRE
	var/list/global_personal_goals = list()
	var/list/departments = list()
	var/list/ambitions =   list()
	var/list/pending_goals = list()

/datum/controller/subsystem/goals/Initialize()
	var/list/all_depts = GLOB.using_map.departments

	for(var/dtype in all_depts)
		var/datum/department/dept = dtype
		var/dept_flag = initial(dept.flag)
		if(dept_flag)
			departments["[dept_flag]"] = new dtype
	for(var/thing in departments)
		var/datum/department/dept = departments[thing]
		dept.Initialize()
	. = ..()

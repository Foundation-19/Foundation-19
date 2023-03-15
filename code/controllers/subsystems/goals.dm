SUBSYSTEM_DEF(goals)
	name = "Goals"
	init_order = SS_INIT_GOALS
	wait = 1 SECOND
	var/list/global_personal_goals = list()
	var/list/departments = list()
	var/list/ambitions =   list()
	var/list/pending_goals = list()

/datum/controller/subsystem/goals/fire(resumed)
	for(var/datum/goal/goal in pending_goals)
		if(goal.try_initialize())
			pending_goals -= goal
	if(!length(pending_goals))
		flags |= SS_NO_FIRE

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

/datum/controller/subsystem/goals/proc/update_department_goal(department_flag, goal_type, progress)
	var/datum/department/dept = departments["[department_flag]"]
	if(dept)
		dept.update_progress(goal_type, progress)

/datum/controller/subsystem/goals/proc/get_roundend_summary()
	. = list()
	for(var/thing in departments)
		var/datum/department/dept = departments[thing]
		. += "<b>[dept.name] had the following shift goals:</b>"
		. += dept.summarize_goals(show_success = TRUE)
	if(LAZYLEN(.))
		. = "<br>[jointext(., "<br>")]"
	else
		. = "<br><b>There were no departmental goals this round.</b>"

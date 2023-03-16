SUBSYSTEM_DEF(goals)
	name = "Goals"
	init_order = SS_INIT_GOALS
	wait = 1 SECOND
	flags = SS_NO_FIRE
	var/list/global_personal_goals = list()
	var/list/departments = list()

/datum/controller/subsystem/goals/Initialize()
	var/list/all_depts = subtypesof(/datum/department)

	for(var/datum/department/dept in all_depts)
		departments["[initial(dept.name)]"] = new dept

	for(var/thing in departments)
		var/datum/department/dept = departments[thing]
		dept.Initialize()

	. = ..()

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

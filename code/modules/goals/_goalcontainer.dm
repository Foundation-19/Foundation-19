/datum/component/goalcontainer
	var/list/goal_list = list()
	var/list/goal_history = list()	// text recap of objectives and whether they were succeeded/failed

/datum/component/goalcontainer/New()
	. = ..()
	GLOB.destroyed_event.register(parent, src, /datum/proc/qdel_self)

/datum/component/goalcontainer/Destroy()
	GLOB.destroyed_event.unregister(owner, src)
	for(goal in goal_list)
		qdel(goal)
	return ..()

/datum/component/goalcontainer/proc/add_new_personal_goal()
	var/possible_goals = subtypesof(/datum/goal/personal)

	for(var/datum/goal/G in goal_list)
		if(G.no_duplicates)
			possible_goals -= G.type

	if(LAZYLEN(possible_goals))
		var/goal = pick(possible_goals)
		return add_goal_by_type(goal)

/datum/component/goalcontainer/proc/add_new_job_goal(datum/job/job)
	var/possible_goals = job.possible_goals.Copy()

	for(var/datum/goal/G in goal_list)
		if(G.no_duplicates)
			possible_goals -= G.type

	if(LAZYLEN(possible_goals))
		var/goal = pick(possible_goals)
		goal_list = new goal(src)
		return add_goal_by_type(goal)

/datum/component/goalcontainer/proc/add_new_antag_goal(datum/antagonist/antag)
	var/possible_goals = antag.possible_goals.Copy()

	for(var/datum/goal/G in goal_list)
		if(G.no_duplicates)
			possible_goals -= G.type

	if(LAZYLEN(possible_goals))
		var/goal = pick(possible_goals)
		return add_goal_by_type(goal)

/datum/component/goalcontainer/proc/add_roundstart_goals(datum/job/job, datum/antagonist/antag)
	if(!isnull(job))
		for(var/i = job.goals_count, i > 0, i--)
			add_new_job_goal(job)
	if(!isnull(antag))
		for(var/i = antag.goals_count, i > 0, i--)
			add_new_antag_goal(antag)
	for(var/i = 3, i > 0, i--)
		add_new_personal_goal()

/datum/component/goalcontainer/proc/add_goal_by_type(type)
	var/datum/goal/G = type
	if(G.no_duplicates && (G in goal_list))
		return FALSE
	if(!G.is_valid())
		return FALSE
	goal_list += new G(parent)
	return TRUE

/datum/component/goalcontainer/tgui_interact(mob/user, datum/tgui/ui = null)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "PersonalGoals", "Goals List")
		ui.open()

/datum/component/goalcontainer/tgui_data(mob/user)
	var/list/data = list()

	var/list/goals = list()
	for(var/thing in goal_list)
		var/datum/goal/goal = thing

		goals.Add(list(list(
			"goalname" = goal.name
			"goaldesc" = goal.description
		)))

	return data

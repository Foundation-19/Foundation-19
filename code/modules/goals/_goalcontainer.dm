/datum/component/goalcontainer
	var/list/goal_list = list()

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
	if(type.no_duplicates && (type in goal_list))
		return FALSE
	goal_list += new goal(src)
	return TRUE

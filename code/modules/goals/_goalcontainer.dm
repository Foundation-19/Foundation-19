/datum/component/goalcontainer
	var/list/personal_goals	= list()
	var/list/job_goals		= list()
	var/list/antag_goals	= list()

/datum/component/goalcontainer/proc/add_new_personal_goal()
	var/goals_list = subtypesof(/datum/goal/personal)

	for(var/datum/goal/G in personal_goals)
		if(G.no_duplicates)
			goals_list -= G.type

	if(LAZYLEN(goals_list))
		var/goal = pick(goals_list)
		personal_goals = new goal(src)
		return TRUE
	else
		return FALSE

/datum/component/goalcontainer/proc/add_new_job_goal(datum/job/job)
	var/goals_list = job.possible_goals.Copy()

	for(var/datum/goal/G in job_goals)
		if(G.no_duplicates)
			goals_list -= G.type

	if(LAZYLEN(goals_list))
		var/goal = pick(goals_list)
		job_goals = new goal(src)
		return TRUE
	else
		return FALSE

/datum/component/goalcontainer/proc/add_new_antag_goal(datum/antagonist/antag)
	var/goals_list = antag.possible_goals.Copy()

	for(var/datum/goal/G in antag_goals)
		if(G.no_duplicates)
			goals_list -= G.type

	if(LAZYLEN(goals_list))
		var/goal = pick(goals_list)
		antag_goals = new goal(src)
		return TRUE
	else
		return FALSE

/datum/component/goalcontainer/proc/add_roundstart_goals(datum/job/job, datum/antagonist/antag)
	if(!isnull(job))
		for(var/i = job.goals_count, i > 0, i--)
			add_new_job_goal(job)
	if(!isnull(antag))
		for(var/i = antag.goals_count, i > 0, i--)
			add_new_antag_goal(antag)
	for(var/i = 3, i > 0, i--)
		add_new_personal_goal()

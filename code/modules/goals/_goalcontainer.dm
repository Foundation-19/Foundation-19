/datum/component/goalcontainer
	var/list/goal_list = list()		// associative list of lists, each list is a category and the key is the category name
	var/list/goal_history = list()	// text recap of objectives and whether they were succeeded/failed

/datum/component/goalcontainer/New()
	. = ..()
	GLOB.destroyed_event.register(parent, src, /datum/proc/qdel_self)

/datum/component/goalcontainer/Destroy()
	GLOB.destroyed_event.unregister(owner, src)
	for(goal in goal_list)
		qdel(goal)
	return ..()

/datum/component/goalcontainer/proc/add_goal_by_type(type)
	var/datum/goal/G = type
	if(G.no_duplicates && (G in goal_list))
		return FALSE
	var/datum/goal/new_G = new G(src)
	if(!new_G.is_valid())
		qdel(new_G)
		return FALSE
	goal_list += new_G
	return TRUE

/datum/component/goalcontainer/proc/roundstart_goals(/datum/job/job, /datum/antagonist/antag)
	var/list/goals_skills = subtypesof(/datum/goal/skills)

	var/list/built_skill_goals = list()
	while((built_skill_goals.len < GOAL_SKILLS_AMOUNT) && goals_skills.len)	// exit once we have GOAL_SKILLS_AMOUNT goal skills OR if we ran out of goals
		var/datum/goal/G = pick_n_take(goals_skills)
		add_goal_by_type(G)

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
			"goalcategory" = goal.category
		)))

	return data

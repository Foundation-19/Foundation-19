/datum/component/goalcontainer
	var/list/list/goal_list = list()	// associative list of lists, each list is a category and the key is the category name
	var/list/goal_history = list()		// text recap of objectives and whether they were succeeded/failed

/datum/component/goalcontainer/New()
	. = ..()
	RegisterSignal(SSdcs, COMSIG_ROUND_ENDED, PROC_REF(goal_recap))

/datum/component/goalcontainer/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MIND_POST_INIT, PROC_REF(recalculate_goals))

/datum/component/goalcontainer/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_MIND_POST_INIT)

/datum/component/goalcontainer/Destroy()
	QDEL_LIST_ASSOC_VAL(goal_list)
	goal_list = null
	return ..()

/datum/component/goalcontainer/proc/add_goal_by_type(type, category, autofill_rewards = FALSE)
	var/datum/goal/G = type
	if(initial(G.no_duplicates))
		for(var/thing in goal_list[category])
			if(istype(thing, G))
				return FALSE
	var/datum/goal/new_G = new G(src)
	if(!new_G.is_valid() || (autofill_rewards && !new_G.is_autofill_reward_valid()))
		qdel(new_G)
		return FALSE
	if(isnull(goal_list[category]))
		goal_list[category] = list(new_G)
	else
		var/list/C = goal_list[category]
		C.Add(new_G)
		goal_list[category] = C
	if(autofill_rewards)
		new_G.autofill_rewards()
	return TRUE

/datum/component/goalcontainer/proc/recalculate_goals()
	for(var/key in goal_list)
		var/list/category = goal_list[key]
		for(var/thing2 in category)
			var/datum/goal/goal = thing2
			if(goal.completed != GOAL_STAT_UNFINISHED)
				if(goal.completed == GOAL_STAT_SUCCEEDED)
					goal_history += goal.success_description
				else
					goal_history += goal.failure_description
				goal_list[key] -= goal
				qdel(goal)

	var/list/goals_skills = subtypesof(/datum/goal/skills)

	if(isnull(goal_list[GOAL_CAT_SKILLS]))
		goal_list[GOAL_CAT_SKILLS] = list()

	while((goal_list[GOAL_CAT_SKILLS].len < GOAL_SKILLS_AMOUNT) && goals_skills.len)	// exit once we have GOAL_SKILLS_AMOUNT goal skills OR if we ran out of goals
		var/datum/goal/G = pick_n_take(goals_skills)
		add_goal_by_type(G, GOAL_CAT_SKILLS, TRUE)

	var/list/goals_sanity = subtypesof(/datum/goal/sanity)

	if(isnull(goal_list[GOAL_CAT_SANITY]))
		goal_list[GOAL_CAT_SANITY] = list()

	while((goal_list[GOAL_CAT_SANITY].len < GOAL_SANITY_AMOUNT) && goals_sanity.len)	// exit once we have GOAL_SKILLS_AMOUNT goal skills OR if we ran out of goals
		var/datum/goal/G = pick_n_take(goals_sanity)
		add_goal_by_type(G, GOAL_CAT_SANITY, TRUE)

/datum/component/goalcontainer/proc/goal_recap()	// end-of-round/cryo recap
	var/datum/mind/mind = parent
	var/mob/mob = mind.current

	var/message = ""
	if(goal_history.len)
		message += "You completed the following goals:<br> [jointext(goal_history, "<br>")]<br>"
	if(goal_list.len)
		var/list/goal_list_descriptions = list()

		for(var/cat_name in goal_list)
			var/list/category = goal_list[cat_name]
			for(var/thing in category)
				var/datum/goal/goal = thing
				goal_list_descriptions += goal.description

		message += "You did not complete the following goals:<br> [jointext(goal_list_descriptions, "<br>")]<br>"

	to_chat(mob, SPAN_NOTICE(message))

/datum/component/goalcontainer/tgui_interact(mob/user, datum/tgui/ui = null)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "PersonalGoals", "Goals List")
		ui.open()

/datum/component/goalcontainer/tgui_data(mob/user)
	var/list/data = list()

	var/list/categories_values = list()
	var/list/categories_keys = list()	// we cant put an associative list through the TGUI backend, so we store the keys separately and combine them into a Javascript map later
	for(var/cat_name in goal_list)
		var/list/category = goal_list[cat_name]

		var/list/cat_goals = list()
		for(var/thing in category)
			var/datum/goal/goal = thing

			var/description = goal.description

			for(var/thing2 in goal.rewards)
				var/datum/reward/reward = thing2
				description += " [reward.on_success ? "Reward" : "Punishment"]: [reward.description]"

			cat_goals.Add(description)

		categories_values.Add(list(cat_goals))
		categories_keys.Add(list(cat_name))

	data["categories_values"] = categories_values
	data["categories_keys"] = categories_keys
	return data

/datum/component/goalcontainer/tgui_state(mob/user)
	return GLOB.always_tgui_state

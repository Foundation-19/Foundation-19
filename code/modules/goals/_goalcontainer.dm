/datum/component/goalcontainer
	var/list/list/goal_list = list()		// associative list of lists, each list is a category and the key is the category name
	var/list/goal_history = list()	// text recap of objectives and whether they were succeeded/failed

/datum/component/goalcontainer/New()
	. = ..()
	RegisterSignal(SSdcs, COMSIG_ROUND_ENDED, .proc/goal_recap)

/datum/component/goalcontainer/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MIND_POST_INIT, .proc/recalculate_goals)
	var/datum/mind/M = parent
	RegisterSignal(M.current, COMSIG_OPENING_GOAL_TGUI, .proc/tgui_interact)

/datum/component/goalcontainer/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_MIND_POST_INIT)
	var/datum/mind/M = parent
	UnregisterSignal(M.current, COMSIG_OPENING_GOAL_TGUI)

/datum/component/goalcontainer/Destroy()
	return ..()

/datum/component/goalcontainer/proc/add_goal_by_type(type, category, autofill_rewards = FALSE)
	var/datum/goal/G = type
	if(initial(G.no_duplicates) && (G in goal_list))
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
	for(var/thing1 in goal_list)
		var/list/category = thing1
		for(var/thing2 in category)
			var/datum/goal/goal = thing2
			if(goal.completed != GOAL_STAT_UNFINISHED)
				if(goal.completed == GOAL_STAT_SUCCEEDED)
					goal_history += goal.success_description
				else
					goal_history += goal.failure_description
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

		for(var/thing in goal_list)
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

	var/list/categories = list()
	for(var/cat_name in goal_list)
		var/list/category = goal_list[cat_name]

		var/list/cat_goals = list()
		for(var/thing in category)
			var/datum/goal/goal = thing

			var/description = goal.description

			for(var/thing2 in goal.rewards)
				var/datum/reward/reward = thing2
				description += "<br>[reward.on_success ? "Reward" : "Punishment"]: [reward.description]"

			cat_goals.Add(list(list(
				"description" = description
			)))

		categories[cat_name] = cat_goals

	data["goalcategories"] = categories
	return data

/datum/component/goalcontainer/tgui_state(mob/user)
	return GLOB.always_tgui_state

/datum/mind
	var/list/goals

/datum/mind/proc/show_roundend_summary()
	if(current && LAZYLEN(goals))
		to_chat(current, SPAN_NOTICE("<br><br><b>You had the following personal goals this round:</b><br>[jointext(summarize_goals(TRUE), "<br>")]"))

/datum/mind/proc/summarize_goals(show_success = FALSE, allow_modification = FALSE, mob/caller)
	. = list()
	if(LAZYLEN(goals))
		for(var/i = 1 to LAZYLEN(goals))
			var/datum/goal/goal = goals[i]
			. += "[i]. [goal.summarize(show_success, allow_modification, caller, position = i)]"

// Create and display personal goals for this round.
/datum/mind/proc/generate_goals(datum/job/job, adding_goals = FALSE, add_amount)

	if(!adding_goals)
		goals = null

	var/list/available_goals = list()
	if(job && LAZYLEN(job.possible_goals))
		available_goals |= job.possible_goals
	if(ishuman(current))
		var/mob/living/carbon/human/H = current
		for(var/token in H.cultural_info)
			var/decl/cultural_info/culture = H.get_cultural_value(token)
			var/list/new_goals = culture.get_possible_personal_goals(job ? job.department_flag : null)
			if(LAZYLEN(new_goals))
				available_goals |= new_goals
	if(isnull(add_amount))
		var/min_goals = 1
		var/max_goals = 3
		if(job)
			min_goals = job.min_goals
			max_goals = job.max_goals
		add_amount = rand(min_goals, max_goals)

	for(var/i = 1 to min(LAZYLEN(available_goals), add_amount))
		var/goal = pick_n_take(available_goals)
		new goal(src)
	return TRUE

/datum/mind/verb/show_goals_verb()

	set name = "Show Goals"
	set desc = "Shows your round goals."
	set category = "IC"

	show_goals(TRUE, TRUE)


/datum/mind/proc/show_goals(show_success = FALSE, allow_modification = FALSE)

	var/chat_string = "<hr>"

	if(LAZYLEN(goals))
		chat_string += SPAN_NOTICE(FONT_LARGE("<b>This round, you have the following personal goals:</b><br>"))
		chat_string += jointext(summarize_goals(show_success, allow_modification, current), "<br>")
	else
		chat_string += SPAN_NOTICE(FONT_LARGE("<b>You have no personal goals this round.</b>"))
	if(allow_modification && LAZYLEN(goals) < 5)
		chat_string += SPAN_NOTICE("<a href='?src=\ref[src];add_goal=1;add_goal_caller=\ref[current]'>Add Random Goal</a>")

	if(LAZYLEN(goals))
		chat_string += SPAN_NOTICE("<br><br>You can check your round goals with the <b>Show Goals</b> verb.")

	chat_string += "<hr>"
	to_chat(src, chat_string)

/datum/mind/proc/has_personal_goal(goal_type)
	return locate(goal_type) in goals

/datum/mind/proc/update_personal_goal(goal_type, progress)
	var/datum/goal/goal = has_personal_goal(goal_type)
	if(goal)
		goal.update_progress(progress)

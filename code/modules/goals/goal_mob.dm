/mob/proc/has_personal_goal(goal_type)
	if(mind) return locate(goal_type) in mind.goals

/mob/proc/update_personal_goal(goal_type, progress)
	var/datum/goal/goal = has_personal_goal(goal_type)
	if(goal)
		goal.update_progress(progress)

/mob/verb/show_goals_verb()

	set name = "Show Goals"
	set desc = "Shows your round goals."
	set category = "IC"

	show_goals(TRUE, TRUE)

/mob/proc/show_goals(show_success = FALSE, allow_modification = FALSE)

	if(!mind)
		to_chat(src, SPAN_WARNING("You are mindless and cannot have goals."))
		return

	var/datum/department/dept
	if(mind.assigned_job && mind.assigned_job.department_flag && SSgoals.departments["[mind.assigned_job.department_flag]"])
		dept = SSgoals.departments["[mind.assigned_job.department_flag]"]

	var/chat_string = "<hr>"

	if(LAZYLEN(mind.goals))
		chat_string += SPAN_NOTICE(FONT_LARGE("<b>This round, you have the following personal goals:</b><br>"))
		chat_string += jointext(mind.summarize_goals(show_success, allow_modification, mind.current), "<br>")
	else
		chat_string += SPAN_NOTICE(FONT_LARGE("<b>You have no personal goals this round.</b>"))
	if(allow_modification && LAZYLEN(mind.goals) < 5)
		chat_string += SPAN_NOTICE("<a href='?src=\ref[mind];add_goal=1;add_goal_caller=\ref[mind.current]'>Add Random Goal</a>")
	if(dept)
		chat_string += "<br><br>"
		if(LAZYLEN(dept.goals))
			chat_string += SPAN_NOTICE(FONT_LARGE("<b>This round, [dept.name] has the following departmental goals:</b><br>"))
			chat_string += jointext(dept.summarize_goals(show_success), "<br>")
		else
			chat_string += SPAN_NOTICE(FONT_LARGE("<b>[dept.name] has no departmental goals this round.</b>"))

	if(LAZYLEN(mind.goals))
		chat_string += SPAN_NOTICE("<br><br>You can check your round goals with the <b>Show Goals</b> verb.")

	chat_string += "<hr>"
	to_chat(src, chat_string)

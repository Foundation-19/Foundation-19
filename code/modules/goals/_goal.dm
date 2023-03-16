/datum/goal
	var/description
	var/owner
	var/completion_message
	var/failure_message

/datum/goal/New(_owner)
	owner = _owner
	GLOB.destroyed_event.register(owner, src, /datum/proc/qdel_self)
	if(istype(owner, /datum/mind))
		var/datum/mind/mind = owner
		LAZYADD(mind.goals, src)
	update_strings()

/datum/goal/Destroy()
	GLOB.destroyed_event.unregister(owner, src)
	if(owner)
		if(istype(owner, /datum/mind))
			var/datum/mind/mind = owner
			LAZYREMOVE(mind.goals, src)
		owner = null
	. = ..()

/datum/goal/proc/summarize(show_success = FALSE)
	. = "[description][get_summary_value()]"
	if(show_success)
		. += get_success_string()

/datum/goal/proc/get_success_string()
	return check_success() ? FONT_COLORED("green", " <b>Success!</b>") : FONT_COLORED("red", " <b>Failure.</b>")

/datum/goal/proc/get_summary_value()
	return

/datum/goal/proc/update_strings()
	return

/datum/goal/proc/update_progress(progress)
	return

/datum/goal/proc/check_success()
	return TRUE

/datum/goal/proc/try_initialize()
	return TRUE

/datum/goal/proc/on_completion()
	if(completion_message && check_success())
		if(istype(owner, /datum/mind))
			var/datum/mind/mind = owner
			to_chat(mind.current, SPAN_GOOD("<b>[completion_message]</b>"))

/datum/goal/proc/on_failure()
	if(failure_message && !check_success() && istype(owner, /datum/mind))
		var/datum/mind/mind = owner
		to_chat(mind.current, SPAN_BAD("<b>[failure_message]</b>"))

/datum/goal/proc/is_valid()
	return TRUE

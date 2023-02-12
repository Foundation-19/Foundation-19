/datum/admin_secret_item/admin_secret/mentor_logs
	name = "Mentor Logs"

/datum/admin_secret_item/admin_secret/mentor_logs/execute(mob/user)
	. = ..()
	if(!.)
		return
	var/dat = SPAN_BOLD("Mentor Log<hr>")
	for(var/l in GLOB.mentor_log)
		dat += "<li>[l]</li>"
	if(!GLOB.mentor_log.len)
		dat += "No mentors have done anything this round!"
	show_browser(user, dat, "window=mentor_log")

/datum/evacuation_option
	var/option_text = "Generic evac option"
	var/option_desc = "do something that should never be seen"
	var/option_target = "generic"
	var/needs_syscontrol = FALSE
	var/silicon_allowed = TRUE
	var/abandon_ship = FALSE

/datum/evacuation_option/proc/execute(mob/user)
	SSticker.news_report = max(SSticker.news_report, FACILITY_EVACUATED) // TODO: If we ever use more options - move it elsewhere and add more
	return

/datum/player_action/psionics
	action_tag = "_psionics"
	permissions_required = R_ADMIN

/datum/player_action/psionics/remove_psionics
	action_tag = "remove_psionics"
	name = "Remove Psionics"

/datum/player_action/psionics/remove_psionics/act(client/user, mob/living/target, list/params)
	if(!isliving(target))
		to_chat(user.mob, SPAN_WARNING("Target mob should be a living thing!"))
		return
	if(!target.psi)
		to_chat(user.mob, SPAN_WARNING("Mob doesn't have psionic powers!"))
		return
	if(!QDELETED(target.psi) && target.psi.owner == target)
		log_and_message_admins("removed all psionics from [key_name(target)].")
		to_chat(target, SPAN_NOTICE("<b>Your psionic powers vanish abruptly, leaving you cold and empty.</b>"))
		QDEL_NULL(target.psi)
		return TRUE

/datum/player_action/psionics/toggle_psi_latencies
	action_tag = "toggle_psi_latencies"
	name = "Toggle Psi Latencies"

/datum/player_action/psionics/toggle_psi_latencies/act(client/user, mob/living/target, list/params)
	if(!isliving(target))
		to_chat(user.mob, SPAN_WARNING("Target mob should be a living thing!"))
		return
	if(!target.psi)
		to_chat(user.mob, SPAN_WARNING("Mob doesn't have psionic powers!"))
		return
	log_and_message_admins("triggered psi latencies for [key_name(target)].")
	target.psi.check_latency_trigger(100, "outside intervention", redactive = TRUE)
	return TRUE

/datum/player_action/psionics/set_psi_faculty_rank
	action_tag = "set_psi_faculty_rank"
	name = "Set Psi Faculty Rank"

/datum/player_action/psionics/set_psi_faculty_rank/act(client/user, mob/living/target, list/params)
	if(!isliving(target))
		to_chat(user.mob, SPAN_WARNING("Target mob should be a living thing!"))
		return
	var/faculty_rank = text2num(params["psi_faculty_rank"])
	if(!params["psi_faculty"] || isnull(faculty_rank))
		to_chat(user.mob, SPAN_WARNING("HEY! STOP ABUSING HREFS BEFORE I REPORTED THAT!"))
		return
	target.set_psi_rank(params["psi_faculty"], faculty_rank)
	log_and_message_admins("set [key_name(user.mob)]'s [params["psi_faculty"]] faculty to [faculty_rank].")
	return TRUE

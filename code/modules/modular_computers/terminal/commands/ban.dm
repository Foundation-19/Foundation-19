/// Manages the NTNet banlist
/datum/terminal_command/banned
	name = "banned"
	man_entry = list(
		"Format: banned \[-flag nid\]",
		"Without options, list currently banned network ids.",
		"With -b followed by nid (number), ban the network id.",
		"With -u followed by nid (number), unban the network id.",
		"NOTICE: Requires network operator access for viewing, and admin access for modification"
	)
	pattern = "^banned"
	req_access = list("ACCESS_ENGINEERING_LEVEL3")
	skill_needed = SKILL_TRAINED

/datum/terminal_command/banned/proper_input_entered(text, mob/user, datum/terminal/terminal)
	if(!ntnet_global || !terminal.computer.get_ntnet_status())
		return "banned: Error; check networking status."
	if(text == "banned")
		if (ntnet_global.banned_nids.len)
			return list("[name]: The following network ids are banned:", jointext(ntnet_global.banned_nids, ", "))
		else
			return "[name]: There are no banned network ids."

	if(!has_access(list("ACCESS_ENGINEERING_LEVEL3"), user.GetAccess()))
		return "[name]: ACCESS DENIED"
	var/nid = text2num(copytext(text, 11))
	var/arg = copytext(text, 8, 9)
	if(arg == "-b")
		if (nid && !(nid in ntnet_global.banned_nids))
			LAZYADD(ntnet_global.banned_nids, nid)
			return "[name]: Network id '[nid]' banned."
		else
			return "[name]: Error; network id invalid or already banned."
	else if(arg == "-u")
		if (nid in ntnet_global.banned_nids)
			ntnet_global.banned_nids -= nid
			return "[name]: Network id '[nid]' unbanned."
		else
			return "[name]: Error; network id not found on list of banned ids."

	return "banned: Invalid input. Enter man banned for syntax help."

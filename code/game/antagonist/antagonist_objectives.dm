/datum/antagonist/proc/create_global_objectives(override=0)
	if(config.objectives_disabled != CONFIG_OBJECTIVE_ALL && !override)
		return 0
	if(global_objectives && global_objectives.len)
		return 0
	return 1

/datum/antagonist/proc/create_objectives(datum/mind/player, override=0)
	if(config.objectives_disabled != CONFIG_OBJECTIVE_ALL && !override)
		return 0
	if(create_global_objectives(override) || global_objectives.len)
		player.objectives |= global_objectives
	return 1

/datum/antagonist/proc/get_special_objective_text()
	return ""

/mob/proc/add_objectives()
	set name = "Get Objectives"
	set desc = "Recieve optional objectives."
	set category = "OOC"

	remove_verb(src, /mob/proc/add_objectives)

	if(!mind)
		return

	var/all_antag_types = GLOB.all_antag_types_
	for(var/tag in all_antag_types) //we do all of them in case an admin adds an antagonist via the PP. Those do not show up in gamemode.
		var/datum/antagonist/antagonist = all_antag_types[tag]
		if(antagonist && antagonist.is_antagonist(mind))
			antagonist.create_objectives(mind,1)

	to_chat(src, "<b><font size=3>These objectives are completely voluntary. You are not required to complete them.</font></b>")
	show_objectives(mind)

//some antagonist datums are not actually antagonists, so we might want to avoid
//sending them the antagonist meet'n'greet messages.
//E.G. ERT
/datum/antagonist/proc/show_objectives_at_creation(datum/mind/player)
	if(src.show_objectives_on_creation)
		show_objectives(player)

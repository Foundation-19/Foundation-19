/datum/preferences
	var/list/be_special_role

/datum/category_item/player_setup_item/antagonism/candidacy
	name = "Candidacy"
	sort_order = 1

/datum/category_item/player_setup_item/antagonism/candidacy/load_character(datum/pref_record_reader/R)
	pref.be_special_role = R.read("be_special")

/datum/category_item/player_setup_item/antagonism/candidacy/save_character(datum/pref_record_writer/W)
	W.write("be_special", pref.be_special_role)

/datum/category_item/player_setup_item/antagonism/candidacy/sanitize_character()
	if(!istype(pref.be_special_role))
		pref.be_special_role = list()

	var/special_roles = valid_special_roles()
	var/old_be_special_role = pref.be_special_role.Copy()
	for(var/role in old_be_special_role)
		if(!(role in special_roles))
			pref.be_special_role -= role

/datum/category_item/player_setup_item/antagonism/candidacy/get_setup_data(mob/user)
	var/list/data = list()
	var/list/antag_entries = list()
	var/list/all_antag_types = GLOB.all_antag_types_
	for(var/antag_type in all_antag_types)
		var/datum/antagonist/antag = all_antag_types[antag_type]
		var/is_banned = jobban_isbanned(preference_mob(), antag.id) || (antag.id == MODE_MALFUNCTION && jobban_isbanned(preference_mob(), "AIC"))
		antag_entries += list(list(
			"name" = antag.role_text,
			"id" = antag.id,
			"banned" = is_banned,
			"enabled" = (antag.id in pref.be_special_role)
		))

	var/list/ghost_entries = list()
	var/list/ghost_traps = get_ghost_traps()
	for(var/ghost_trap_key in ghost_traps)
		var/datum/ghosttrap/ghost_trap = ghost_traps[ghost_trap_key]
		if(!ghost_trap.list_as_special_role)
			continue
		var/is_banned = banned_from_ghost_role(preference_mob(), ghost_trap)
		var/is_whitelisted = ghost_trap.assess_whitelist(user)
		ghost_entries += list(list(
			"name" = ghost_trap.ghost_trap_role,
			"id" = ghost_trap.pref_check,
			"banned" = is_banned,
			"whitelisted" = is_whitelisted,
			"enabled" = (ghost_trap.pref_check in pref.be_special_role)
		))

	data["antag_roles"] = antag_entries
	data["ghost_roles"] = ghost_entries
	return data

/datum/category_item/player_setup_item/antagonism/candidacy/act_setup(action, list/params, mob/user)

	if(action == "add_special")
		var/id = params["id"]
		if(!(id in valid_special_roles(FALSE)))
			return FALSE
		pref.be_special_role |= id
		return TRUE

	if(action == "del_special")
		var/id = params["id"]
		if(!(id in valid_special_roles(FALSE)))
			return FALSE
		pref.be_special_role -= id
		return TRUE

	if(action == "select_all")
		var/selection = text2num(params["selection"])
		var/list/roles = valid_special_roles(FALSE)
		for(var/id in roles)
			switch(selection)
				if(0) pref.be_special_role -= id
				if(1) pref.be_special_role |= id
		return TRUE

	return FALSE

/datum/category_item/player_setup_item/antagonism/candidacy/content(mob/user)
	. = list()
	. += "<b>Special Role Availability:</b><br>"
	. += "<table>"
	var/list/all_antag_types = GLOB.all_antag_types_
	for(var/antag_type in all_antag_types)
		var/datum/antagonist/antag = all_antag_types[antag_type]
		. += "<tr><td>[antag.role_text]: </td><td>"
		if(jobban_isbanned(preference_mob(), antag.id) || (antag.id == MODE_MALFUNCTION && jobban_isbanned(preference_mob(), "AIC")))
			. += "<span class='danger'>\[BANNED\]</span><br>"
		else if(antag.id in pref.be_special_role)
			. += "<span class='linkOn'>Yes</span> <a href='byond://?src=\ref[src];del_special=[antag.id]'>No</a></br>"
		else
			. += "<a href='byond://?src=\ref[src];add_special=[antag.id]'>Yes</a> <span class='linkOn'>No</span></br>"

		. += "</td></tr>"
	. += "</table>"
	. += "<b>Ghost Role Availability:</b>"
	. += "<table>"
	var/list/ghost_traps = get_ghost_traps()
	for(var/ghost_trap_key in ghost_traps)
		var/datum/ghosttrap/ghost_trap = ghost_traps[ghost_trap_key]
		if(!ghost_trap.list_as_special_role)
			continue

		. += "<tr><td>[(ghost_trap.ghost_trap_role)]: </td><td>"
		if(banned_from_ghost_role(preference_mob(), ghost_trap))
			. += "<span class='danger'>\[BANNED\]</span><br>"
		else if (!ghost_trap.assess_whitelist(user))
			var/datum/species/S = new ghost_trap.species_whitelist()
			. += "[SPAN_DANGER("\[WHITELIST RESTRICTED - [S]\]")]<br />"
		else if(ghost_trap.pref_check in pref.be_special_role)
			. += "<span class='linkOn'>Yes</span> <a href='byond://?src=\ref[src];del_special=[ghost_trap.pref_check]'>No</a></br>"
		else
			. += "<a href='byond://?src=\ref[src];add_special=[ghost_trap.pref_check]'>Yes</a> <span class='linkOn'>No</span></br>"

		. += "</td></tr>"
	. += "<font size = 1.5><b><tr><td>Select All: </td><td></b></font><a href='byond://?src=\ref[src];select_all=1'>Yes</a> <a href='byond://?src=\ref[src];select_all=0'>No</a></td></tr>"
	. += "</table>"
	. = jointext(.,null)

/datum/category_item/player_setup_item/proc/banned_from_ghost_role(mob, datum/ghosttrap/ghost_trap)
	for(var/ban_type in ghost_trap.ban_checks)
		if(jobban_isbanned(mob, ban_type))
			return 1
	return 0

/datum/category_item/player_setup_item/antagonism/candidacy/OnTopic(href,list/href_list, mob/user)
	if(href_list["add_special"])
		if(!(href_list["add_special"] in valid_special_roles(FALSE)))
			return TOPIC_HANDLED
		pref.be_special_role |= href_list["add_special"]
		return TOPIC_REFRESH

	if(href_list["del_special"])
		if(!(href_list["del_special"] in valid_special_roles(FALSE)))
			return TOPIC_HANDLED
		pref.be_special_role -= href_list["del_special"]
		return TOPIC_REFRESH

	if(href_list["select_all"])
		var/selection = text2num(href_list["select_all"])
		var/list/roles = valid_special_roles(FALSE)

		for(var/id in roles)
			switch(selection)
				if(0)
					pref.be_special_role -= id
				if(1)
					pref.be_special_role |= id
		return TOPIC_REFRESH

	return ..()

/datum/category_item/player_setup_item/antagonism/candidacy/proc/valid_special_roles(include_bans = TRUE)
	var/list/private_valid_special_roles = list()

	for(var/antag_type in GLOB.all_antag_types_)
		if(!include_bans)
			if(jobban_isbanned(preference_mob(), antag_type))
				continue
			if(((antag_type  == MODE_MALFUNCTION) && jobban_isbanned(preference_mob(), "AIC")))
				continue
		private_valid_special_roles += antag_type

	var/list/ghost_traps = get_ghost_traps()
	for(var/ghost_trap_key in ghost_traps)
		var/datum/ghosttrap/ghost_trap = ghost_traps[ghost_trap_key]
		if(!ghost_trap.list_as_special_role)
			continue
		if(!include_bans)
			if(banned_from_ghost_role(preference_mob(), ghost_trap))
				continue
		private_valid_special_roles += ghost_trap.pref_check


	return private_valid_special_roles

/client/proc/wishes_to_be_role(role)
	if(!prefs)
		return FALSE
	if(role in prefs.be_special_role)
		return 1
	return FALSE	//Default to "never" if they don't opt-in.

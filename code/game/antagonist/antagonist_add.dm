/datum/antagonist/proc/add_antagonist(datum/mind/player, ignore_role, do_not_equip, move_to_spawn, do_not_announce, preserve_appearance)

	if(!add_antagonist_mind(player, ignore_role))
		return

	if(base_to_load)
		var/datum/map_template/base = new base_to_load()
		report_progress("Loading map template '[base]' for [role_text]...")
		base_to_load = null
		base.load_new_z()
		get_starting_locations()

	//do this again, just in case
	if(flags & ANTAG_OVERRIDE_JOB)
		player.assigned_job = null
		player.assigned_role = role_text
		player.role_alt_title = null
	player.special_role = role_text

	if(isghostmind(player))
		create_default(player.current)
	else
		create_antagonist(player, move_to_spawn, do_not_announce, preserve_appearance)
		if(istype(skill_setter))
			skill_setter.initialize_skills(player.current.skillset)
		if(!do_not_equip)
			equip(player.current)

	if(player.current)
		player.current.faction = faction
	return 1

/datum/antagonist/proc/add_antagonist_mind(datum/mind/player, ignore_role, nonstandard_role_type, nonstandard_role_msg)
	if(!istype(player))
		return 0
	if(!player.current)
		return 0
	if(player in current_antagonists)
		return 0
	if(!can_become_antag(player, ignore_role))
		return 0
	current_antagonists |= player

	if(faction_verb)
		add_verb(player.current, faction_verb)

	if(config.objectives_disabled == CONFIG_OBJECTIVE_VERB)
		add_verb(player.current, TYPE_PROC_REF(/mob, add_objectives))

	if(player.current.client)
		add_verb(player.current.client, TYPE_PROC_REF(/client, aooc))

	// Handle only adding a mind and not bothering with gear etc.
	if(nonstandard_role_type)
		faction_members |= player
		to_chat(player.current, SPAN_DANGER("<font size=3>You are \a [nonstandard_role_type]!</font>"))
		player.special_role = nonstandard_role_type
		if(nonstandard_role_msg)
			to_chat(player.current, SPAN_NOTICE("[nonstandard_role_msg]"))
		update_icons_added(player)
	return 1

/datum/antagonist/proc/remove_antagonist(datum/mind/player, show_message, implanted)
	if(!istype(player))
		return 0
	if(player.current && faction_verb)
		remove_verb(player.current, faction_verb)
	if(faction && player.current.faction == faction)
		player.current.faction = MOB_FACTION_NEUTRAL
	if(player in current_antagonists)
		to_chat(player.current, SPAN_DANGER("<font size = 3>You are no longer a [role_text]!</font>"))
		current_antagonists -= player
		faction_members -= player
		player.special_role = null
		update_icons_removed(player)

		if(player.current)
			BITSET(player.current.hud_updateflag, SPECIALROLE_HUD)
			player.current.reset_skillset() //Reset their skills to be job-appropriate.

		if(!is_special_character(player))
			if(player.current)
				if(player.current.client)
					remove_verb(player.current.client, TYPE_PROC_REF(/client, aooc))
		return 1
	return 0

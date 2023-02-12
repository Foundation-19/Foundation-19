/decl/communication_channel/ooc
	name = "OOC"
	config_setting = "ooc_allowed"
	expected_communicator_type = /client
	flags = COMMUNICATION_NO_GUESTS
	log_proc = /proc/log_ooc
	mute_setting = MUTE_OOC
	show_preference_setting = /datum/client_preference/show_ooc

/decl/communication_channel/ooc/can_communicate(client/C, message)
	. = ..()
	if(!.)
		return

	if(!C.holder)
		if(!config.dooc_allowed && (C.mob.stat == DEAD))
			to_chat(C, "<span class='danger'>[name] for dead mobs has been turned off.</span>")
			return FALSE

/decl/communication_channel/ooc/do_communicate(client/C, message)
	var/datum/admins/holder = C.holder
	var/is_stealthed = C.is_stealthed()

	var/ooc_style = "everyone"
	if(holder && !is_stealthed) // You have an admin datum AND not stealth-admined.
		ooc_style = "elevated"
		if(holder.rights & R_ADMIN) // You are an admin first of all.
			ooc_style = "admin"
		else if(holder.rights & R_DEBUG) // Not an admin, but have debug? Developer color then.
			ooc_style = "developer"
		else if(holder.rights & R_MOD) // None of it applies? Become moderator-colored.
			ooc_style = "moderator"
	else if(IS_TRUSTED_PLAYER(C.ckey)) // Don't have admin datum AND belong in the trusted list? Funny color time.
		ooc_style = "trusted_player"

	var/can_badmin = !is_stealthed && can_select_ooc_color(C) && (C.prefs.ooccolor != initial(C.prefs.ooccolor))
	var/ooc_color = C.prefs.ooccolor

	for(var/client/target in GLOB.clients)
		if(target.is_key_ignored(C.key)) // If we're ignored by this person, then do nothing.
			continue
		var/sent_message = "[create_text_tag("ooc", "OOC:", target)] [text_badge(C)] <EM>[C.key]:</EM> <span class='message linkify'>[message]</span>"
		if(can_badmin)
			receive_communication(C, target, "<span class='ooc'><font color='[ooc_color]'>[sent_message]</font></span>")
		else
			receive_communication(C, target, "<span class='ooc'><span class='[ooc_style]'>[sent_message]</span></span>")

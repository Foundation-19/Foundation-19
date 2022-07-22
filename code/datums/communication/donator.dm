/decl/communication_channel/dooc
	name = "DOOC"
	config_setting = "donator_ooc_allowed"
	expected_communicator_type = /client
	flags = COMMUNICATION_LOG_CHANNEL_NAME|COMMUNICATION_ADMIN_FOLLOW
	log_proc = /proc/log_ooc
	mute_setting = MUTE_OOC
	show_preference_setting = /datum/client_preference/show_ooc

/decl/communication_channel/dooc/can_communicate(var/client/C, var/message)
	. = ..()
	if(!.)
		return

	if(check_rights(R_INVESTIGATE))
		return
	else
		if(!(C.donator_holder && C.donator_holder.flags & D_DOOC))
			. = FALSE
	return

/decl/communication_channel/dooc/do_communicate(var/client/C, var/message)
	var/datum/admins/holder = C.holder

	for(var/client/target in GLOB.clients)
		if(target.holder)
			receive_communication(C, target, "<span class='ooc'><span class='dooc'>[create_text_tag("dooc", "Donator-OOC:", target)] <strong>[get_options_bar(C, 0, 1, 1)]:</strong> <span class='message'>[message]</span></span></span>")
		else if(target.donator_holder && target.donator_holder.flags & D_DOOC)
			var/display_name = C.key
			var/player_display = holder ? "[display_name]([usr.client.holder.rank])" : display_name
			receive_communication(C, target, "<span class='ooc'><span class='dooc'>[create_text_tag("dooc", "Donator-OOC:", target)] <strong>[player_display]:</strong> <span class='message'>[message]</span></span></span>")

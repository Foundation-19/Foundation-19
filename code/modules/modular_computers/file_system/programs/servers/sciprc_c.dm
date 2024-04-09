/datum/computer_file/program/chatserver_c
	filename = "scprc_client"
	filedesc = "SCiPnet Relay Chat Client"
	program_icon_state = "command"
	program_key_state = "med_key"
	program_menu_icon = "comment"
	extended_desc = "This program allows communication over the SCPRC network"
	size = 4
	requires_ntnet = TRUE
	requires_ntnet_feature = NTNET_COMMUNICATION
	network_destination = "SCPRC server"
	ui_header = "sciprc_no_server.gif" // we also use "sciprc_idle.gif" and "sciprc_new.gif"
	available_on_ntnet = TRUE
	tgui_id = "SCiPChatClient"
	usage_flags = PROGRAM_ALL

	/// The server we're currently connected to. If null, we're not connected to any server.
	var/datum/computer_file/program/chatserver/server

	/// The channel we're currently viewing. If null, we don't have a channel (or server) open.
	var/datum/chatserver_channel/active_channel

	/// List of channels we have unread messages in
	var/list/datum/chatserver_channel/unread_channels = list()

	/// If set, something happened (e.g. the server stopped hosting) that requires the user to restart.
	var/error

	/// 0 normally, 1 if editing user access, 2 if editing admin access
	var/editing_access = 0

/datum/computer_file/program/chatserver_c/proc/handle_new_message(datum/computer_file/program/chatserver/_server, datum/chatserver_channel/_channel, message)
	if(_server != server)
		UnregisterSignal(_server, COMSIG_SCIPRC_MESSAGE_SENT)
		return

	if(_channel == active_channel)
		return

	var/turf/T = get_turf(computer) // Because visible_message is being a butt
	if(T)
		T.visible_message(SPAN_NOTICE("[computer] beeps softly, indicating a new message has been posted."))
	playsound(computer, 'sounds/misc/server-ready.ogg', 100, 0)

	unread_channels |= _channel

/datum/computer_file/program/chatserver_c/proc/handle_crash(datum/computer_file/program/chatserver/_server)
	UnregisterSignal(_server, COMSIG_SERVER_PROGRAM_OFFLINE)

	if(_server != server)
		return

	error = "Network Error - Server dropped connection."

/datum/computer_file/program/chatserver_c/process_tick()
	..()
	if(program_state != PROGRAM_STATE_KILLED)
		if(isnull(server))
			ui_header = "sciprc_no_server.gif"
		else if(unread_channels.len)
			ui_header = "sciprc_new.gif"
		else
			ui_header = "sciprc_idle.gif"
		return TRUE

/datum/computer_file/program/chatserver_c/tgui_data(mob/user)
	var/list/data = get_header_data()

	data["error"] = error

	// We grab this here, since it's used so often
	var/list/u_access = user.GetAccess()

	if(server)
		data["servername"] = server.server_name
		data["channels"] = list()

		data["sysadmin"] = has_access(server.req_accesses_sysadmin, u_access)

		data["editing_access"] = editing_access

		if(active_channel)
			data["channel_open"] = (active_channel in server.channel_list)
			data["messages"] = active_channel.messages

		var/i = 1	// we can't get the index from a forlist so we have to track this manually (pain)
		for(var/thing in server.channel_list)
			var/datum/chatserver_channel/channel = thing

			if(!data["sysadmin"] && !has_access(channel.req_accesses_user, u_access) && !has_access(channel.req_accesses_admin, u_access))
				i++		// index tracker has to be increased manually
				continue

			data["channels"] += list(list(
				"name" = channel.title,
				"active" = (channel == active_channel),
				"unread" = (channel in unread_channels),
				"index" = i++,	// used so we can retrieve the channel from the server list
				"admin" = (data["sysadmin"] || has_access(channel.req_accesses_admin, u_access))
			))

		data["region_access"] = list()
		data["region_names"] = list()

		if(editing_access == 1)

			var/list/all_regions = get_all_access_datums_by_region()
			for(var/r_index in all_regions)
				var/list/region = all_regions[r_index]

				var/list/prepared_region = list()

				for(var/thing in region)
					var/datum/access/acc = thing
					if(acc.desc)
						prepared_region += list(list(
							"desc" = acc.desc,
							"id" = acc.id,
							"required" = (acc.id in active_channel.req_accesses_user)
						))

				data["region_access"] += list(prepared_region)
				data["region_names"] += get_region_accesses_name(text2num(r_index))

		if(editing_access == 2)

			var/list/all_regions = get_all_access_datums_by_region()
			for(var/r_index in all_regions)
				var/list/region = all_regions[r_index]

				var/list/prepared_region = list()

				for(var/thing in region)
					var/datum/access/acc = thing
					if(acc.desc)
						prepared_region += list(list(
							"desc" = acc.desc,
							"id" = acc.id,
							"required" = (acc.id in active_channel.req_accesses_admin)
						))

				data["region_access"] += list(prepared_region)
				data["region_names"] += get_region_accesses_name(text2num(r_index))
	else
		data["servers"] = list()
		for(var/datum/computer_file/program/chatserver/P in ntnet_global.chatservers)
			data["servers"] += list(list(
				"uid" = P.computer.network_card.identification_id,
				"name" = P.server_name,
				"sysadmin" = has_access(P.req_accesses_sysadmin, u_access)
			))

	return data

/datum/computer_file/program/chatserver_c/tgui_act(action, params)
	if(..())
		return

	switch(action)
		if("PRG_reset")
			server = null
			active_channel = null
			editing_access = 0
			error = null
			return TRUE
		if("PRG_connect_to_server")
			var/datum/computer_file/program/chatserver/new_server
			for(var/datum/computer_file/program/chatserver/S in ntnet_global.chatservers)
				if(S.computer.network_card.identification_id == text2num(params["uid"]))
					new_server = S
					break
			if(!new_server || !new_server.hosting)
				return FALSE
			server = new_server
			RegisterSignal(server, COMSIG_SCIPRC_MESSAGE_SENT, PROC_REF(handle_new_message))
			RegisterSignal(server, COMSIG_SERVER_PROGRAM_OFFLINE, PROC_REF(handle_crash))
			return TRUE
		if("PRG_post")
			if(isnull(active_channel))	// sanity check
				return

			var/obj/item/card/id/card = usr.GetIdCard()

			active_channel.add_message(computer.network_card.identification_id, card.registered_name, params["message"])
			return TRUE
		if("PRG_save_log")
			var/logname = sanitize(params["log_name"])
			if(!logname)
				return

			var/datum/computer_file/data/logfile = new /datum/computer_file/data/logfile()
			logfile.filename = logname
			logfile.stored_data = "\[b\]Logfile dump from SCPRC channel [active_channel.title]\[/b\]\n"
			for(var/logstring in active_channel.messages)
				logfile.stored_data += "[logstring]\n"
			logfile.stored_data += "\[b\]Logfile dump completed.\[/b\]"
			logfile.calculate_size()

			if(!computer || !computer.hard_drive || !computer.hard_drive.store_file(logfile))
				if(!computer)
					// This program shouldn't even be runnable without computer.
					CRASH("Var computer is null!")
				if(!computer.hard_drive)
					error = "I/O Error - Hard drive connection error."
				else	// In 99.9% cases this will mean our HDD is full
					error = "I/O Error - Hard drive may be full. Please free some space and try again. Required space: [logfile.size]GQ."
			return TRUE
		if("PRG_set_editing_access")
			editing_access = params["value"]
			return TRUE
		if("PRG_delete_channel")
			var/obj/item/card/id/card = usr.GetIdCard()
			server.add_log(computer.network_card.identification_id, card.registered_name, "Deleted channel ('[active_channel.title]').")
			server.channel_list -= active_channel
			QDEL_NULL(active_channel)
			return TRUE
		if("PRG_rename_channel")
			var/newname = sanitize(tgui_input_text(usr, "Enter new name for channel [active_channel.title]. Leave blank to cancel.", "Rename Channel", active_channel.title))
			if(!newname)
				return

			var/obj/item/card/id/card = usr.GetIdCard()
			server.add_log(computer.network_card.identification_id, card.registered_name, "Renamed channel from '[active_channel.title]' to '[newname]'.")
			active_channel.title = newname
			return TRUE
		if("PRG_new_channel")
			var/newname = params["new_channel_name"]
			if(!newname)
				return

			var/obj/item/card/id/card = usr.GetIdCard()
			server.add_log(computer.network_card.identification_id, card.registered_name, "Added channel ('[newname]').")
			server.channel_list += new /datum/chatserver_channel/(server, newname)
			return TRUE
		if("PRG_open_channel")
			active_channel = server.channel_list[params["id"]]
			unread_channels -= server.channel_list[params["id"]]
			return TRUE
		if("PRG_change_access_user")
			return active_channel.toggle_access(params["access"], FALSE)
		if("PRG_change_access_admin")
			return active_channel.toggle_access(params["access"], TRUE)

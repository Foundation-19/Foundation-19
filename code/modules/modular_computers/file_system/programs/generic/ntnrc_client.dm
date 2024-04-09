/datum/computer_file/program/chatclient
	filename = "scprc_client"
	filedesc = "SCiPnet Relay Chat Client"
	program_icon_state = "command"
	program_key_state = "med_key"
	program_menu_icon = "comment"
	extended_desc = "This program allows communication over the SCPRC network"
	size = 8
	requires_ntnet = 1
	requires_ntnet_feature = NTNET_COMMUNICATION
	network_destination = "SCPRC server"
	ui_header = "sciprc_idle.gif"
	available_on_ntnet = 1
	tgui_id = "NtosNetChat"
	/// Used to generate the toolbar icon
	var/last_message
	var/username
	var/active_channel
	/// Administrator mode (invisible to other users + bypasses passwords)
	var/netadmin_mode = FALSE
	usage_flags = PROGRAM_ALL

/datum/computer_file/program/chatclient/New()
	username = "DefaultUser[rand(100, 999)]"

/datum/computer_file/program/chatclient/tgui_act(action, params)
	if(..())
		return

	var/datum/ntnet_conversation/channel
	for(var/datum/ntnet_conversation/chan in ntnet_global.chat_channels)
		if(chan.id == active_channel)
			channel = chan
			break
	var/authed = FALSE
	if(channel && ((channel.operator == src) || netadmin_mode))
		authed = TRUE
	switch(action)
		if("PRG_speak")
			if(!channel || isnull(active_channel))
				return
			var/message = reject_bad_text(params["message"])
			if(!message)
				return
			if(channel.password && !(src in channel.clients))
				if(channel.password == message)
					channel.add_client(src)
					return TRUE

			channel.add_message(message, username)
			// var/mob/living/user = usr
			// user.log_talk(message, LOG_CHAT, tag="as [username] to channel [channel.title]")
			return TRUE
		if("PRG_joinchannel")
			var/new_target = text2num(params["id"])
			if(isnull(new_target) || new_target == active_channel)
				return

			if(netadmin_mode)
				active_channel = new_target // Bypasses normal leave/join and passwords. Technically makes the user invisible to others.
				return TRUE

			active_channel =  new_target
			for(var/datum/ntnet_conversation/chan in ntnet_global.chat_channels)
				if(chan.id == new_target)
					channel = chan
					break
			if(!(src in channel.clients) && !channel.password)
				channel.add_client(src)
			return TRUE
		if("PRG_leavechannel")
			if(channel)
				channel.remove_client(src)
				active_channel = null
				return TRUE
		if("PRG_newchannel")
			var/channel_title = reject_bad_text(params["new_channel_name"])
			if(!channel_title)
				return
			var/datum/ntnet_conversation/C = new /datum/ntnet_conversation()
			C.add_client(src)
			C.operator = src
			C.title = channel_title
			active_channel = C.id
			return TRUE
		if("PRG_toggleadmin")
			if(netadmin_mode)
				netadmin_mode = FALSE
				if(channel)
					channel.remove_client(src) // We shouldn't be in channel's user list, but just in case...
				return TRUE
			var/mob/living/user = usr
			if(program_has_access(user, TRUE, ACCESS_NETWORK))
				for(var/datum/ntnet_conversation/chan as anything in ntnet_global.chat_channels)
					chan.remove_client(src)
				netadmin_mode = TRUE
				return TRUE
		if("PRG_changename")
			var/newname = sanitize(params["new_name"])
			if(!newname)
				return
			for(var/datum/ntnet_conversation/chan as anything in ntnet_global.chat_channels)
				if(src in chan.clients)
					chan.add_status_message("[username] is now known as [newname].")
			username = newname
			return TRUE
		if("PRG_savelog")
			if(!channel)
				return
			var/logname = stripped_input(params["log_name"])
			if(!logname)
				return
			var/datum/computer_file/data/logfile = new /datum/computer_file/data/logfile()
			// Now we will generate HTML-compliant file that can actually be viewed/printed.
			logfile.filename = logname
			logfile.stored_data = "\[b\]Logfile dump from SCPRC channel [channel.title]\[/b\]\[BR\]"
			for(var/logstring in channel.messages)
				logfile.stored_data = "[logfile.stored_data][logstring]\[BR\]"
			logfile.stored_data = "[logfile.stored_data]\[b\]Logfile dump completed.\[/b\]"
			logfile.calculate_size()
			if(!computer || !computer.hard_drive || !computer.hard_drive.store_file(logfile))
				if(!computer)
					// This program shouldn't even be runnable without computer.
					CRASH("Var computer is null!")
				if(!computer.hard_drive)
					computer.visible_message(SPAN_WARNING("\The [computer] shows an \"I/O Error - Hard drive connection error\" warning."))
				else	// In 99.9% cases this will mean our HDD is full
					computer.visible_message(SPAN_WARNING("\The [computer] shows an \"I/O Error - Hard drive may be full. Please free some space and try again. Required space: [logfile.size]GQ\" warning."))
			return TRUE
		if("PRG_renamechannel")
			if(!authed)
				return
			var/newname = reject_bad_text(params["new_name"])
			if(!newname || !channel)
				return
			channel.add_status_message("Channel renamed from [channel.title] to [newname] by operator.")
			channel.title = newname
			return TRUE
		if("PRG_deletechannel")
			if(authed)
				qdel(channel)
				active_channel = null
				return TRUE
		if("PRG_setpassword")
			if(!authed)
				return

			var/new_password = sanitize(params["new_password"])
			if(!authed)
				return

			channel.password = new_password
			return TRUE

/datum/computer_file/program/chatclient/process_tick()
	..()
	var/datum/ntnet_conversation/channel
	for(var/datum/ntnet_conversation/chan in ntnet_global.chat_channels)
		if(chan.id == active_channel)
			channel = chan
			break
	if(program_state != PROGRAM_STATE_KILLED)
		ui_header = "sciprc_idle.gif"
		if(channel)
			// Remember the last message. If there is no message in the channel remember null.
			last_message = length(channel.messages) ? channel.messages[channel.messages.len - 1] : null
		else
			last_message = null
		return 1
	if(channel?.messages?.len)
		ui_header = last_message == channel.messages[channel.messages.len - 1] ? "sciprc_idle.gif" : "sciprc_new.gif"
	else
		ui_header = "sciprc_idle.gif"

/datum/computer_file/program/chatclient/kill_program(forced = FALSE)
	for(var/datum/ntnet_conversation/channel as anything in ntnet_global.chat_channels)
		channel.remove_client(src)
	..()

/datum/computer_file/program/chatclient/tgui_static_data(mob/user)
	var/list/data = list()
	data["can_admin"] = program_has_access(user, FALSE, ACCESS_NETWORK)
	return data

/datum/computer_file/program/chatclient/tgui_data(mob/user)
	if(!ntnet_global || !ntnet_global.chat_channels)
		return list()

	var/list/data = get_header_data()

	var/list/all_channels = list()
	for(var/datum/ntnet_conversation/conv as anything in ntnet_global.chat_channels)
		if(conv && conv.title)
			all_channels.Add(list(list(
				"chan" = conv.title,
				"id" = conv.id
			)))
	data["all_channels"] = all_channels

	data["active_channel"] = active_channel
	data["username"] = username
	data["adminmode"] = netadmin_mode
	var/datum/ntnet_conversation/channel
	for(var/datum/ntnet_conversation/chan in ntnet_global.chat_channels)
		if(chan.id == active_channel)
			channel = chan
			break
	if(channel)
		data["title"] = channel.title
		var/authed = FALSE
		if(!channel.password)
			authed = TRUE
		if(netadmin_mode)
			authed = TRUE
		var/list/clients = list()
		for(var/C in channel.clients)
			if(C == src)
				authed = TRUE
			var/datum/computer_file/program/chatclient/cl = C
			clients.Add(list(list(
				"name" = cl.username
			)))
		data["authed"] = authed
		//no fishing for ui data allowed
		if(authed)
			data["clients"] = clients
			var/list/messages = list()
			for(var/M in channel.messages)
				messages.Add(list(list(
					"msg" = M
				)))
			data["messages"] = messages
			data["is_operator"] = (channel.operator == src) || netadmin_mode
		else
			data["clients"] = list()
			data["messages"] = list()
	else
		data["clients"] = list()
		data["authed"] = FALSE
		data["messages"] = list()

	return data

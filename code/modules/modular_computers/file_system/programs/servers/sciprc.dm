/// The maximum amount of messages kept in the list. Once this limit is hit, old messages will be deleted when new ones are posted.
#define MESSAGES_LIST_CAP 100

// If you edit these, copy them other to the TGUI file (`SCiPChatServer.js`) for ease of reference
/// The base panel, shows some server-wide settings + links.
#define PAGE_BASE "base"
/// The logs panel, shows the history of all channels and the server at large.
#define PAGE_LOGS "logs"
/// The sysadmin access panel, allows editing of required accesses (for global channel administration).
#define PAGE_ACCESS_SYSADMIN "access_sysadmin"
/// The base channel panel, shows some channel-specific settings + links.
#define PAGE_CHANNEL_BASE "channel_base"
/// The user access panel, allows editing of required accesses (for joining the channel).
#define PAGE_CHANNEL_ACCESS_USER "channel_access_user"
/// The admin access panel, allows editing of required accesses (for admining the channel).
#define PAGE_CHANNEL_ACCESS_ADMIN "channel_access_admin"
/// The messages panel, allows viewing the chatlog and sending system messages.
#define PAGE_CHANNEL_MESSAGES "channel_messages"

/datum/computer_file/program/chatserver
	filename = "scprc_server"
	filedesc = "SCiPnet Relay Chat Server"
	extended_desc = "Servers use this program to host a chatroom over Foundation networks."
	program_icon_state = "generic"
	program_key_state = "generic_key"
	program_menu_icon = "server"
	size = 16
	available_on_ntnet = TRUE
	usage_flags = PROGRAM_CONSOLE
	tgui_id = "SCiPChatServer"

	/// User-set name for easier identification by the client
	var/server_name = ""

	/// Whether we're currently hosting
	var/hosting = FALSE

	/// List of open channels
	var/list/datum/chatserver_channel/channel_list = list()

	/// List of log messages
	var/list/server_logs = list()

	/// List of accesses required to be a sysadmin.
	var/list/req_accesses_sysadmin = list()

	//  TGUI vars
	/// Which TGUI panel we have open.
	var/current_page = PAGE_BASE

	/// Index for channel_list[], used when editing a specific channel
	var/editing_channel

/datum/computer_file/program/chatserver/New()
	if(!server_name)
		server_name = GenerateKey()
	..()

/datum/computer_file/program/chatserver/proc/add_log(uid, user, message)
	server_logs.Add("[station_time_timestamp("hh:mm")] - [user] (uid): [message]")

/datum/computer_file/program/chatserver/proc/set_hosting(new_hosting)
	if(hosting == new_hosting)
		return FALSE
	else
		hosting = new_hosting
		if(new_hosting)
			requires_ntnet = TRUE
			requires_ntnet_feature = NTNET_PEERTOPEER
			ntnet_global.chatservers.Add(src)
		else
			requires_ntnet = FALSE
			requires_ntnet_feature = FALSE
			ntnet_global.chatservers.Remove(src)

			SEND_SIGNAL(src, COMSIG_SERVER_PROGRAM_OFFLINE)

/datum/computer_file/program/upload_database/kill_program(forced)
	set_hosting(FALSE)
	. = ..()

/datum/computer_file/program/chatserver/tgui_data(mob/user)
	var/list/data = get_header_data()

	data["current_page"] = current_page

	data["hosting"] = hosting

	data["server_name"] = server_name

	data["channel_list"] = list()

	for(var/thing in channel_list)
		var/datum/chatserver_channel/C = thing
		data["channel_list"] += C.title

	data["server_logs"] = server_logs

	data["editing_channel"] = editing_channel ? channel_list[editing_channel].title : null

	data["ed_channel_messages"] = editing_channel ? channel_list[editing_channel].messages : null

	data["region_access"] = list()
	data["region_names"] = list()

	if((current_page == PAGE_CHANNEL_ACCESS_USER) && editing_channel)

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
						"required" = (acc.id in channel_list[editing_channel].req_accesses_user)
					))

			data["region_access"] += list(prepared_region)
			data["region_names"] += get_region_accesses_name(text2num(r_index))

	if((current_page == PAGE_CHANNEL_ACCESS_ADMIN) && editing_channel)

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
						"required" = (acc.id in channel_list[editing_channel].req_accesses_admin)
					))

			data["region_access"] += list(prepared_region)
			data["region_names"] += get_region_accesses_name(text2num(r_index))

	if(current_page == PAGE_ACCESS_SYSADMIN)

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
						"required" = (acc.id in req_accesses_sysadmin)
					))

			data["region_access"] += list(prepared_region)
			data["region_names"] += get_region_accesses_name(text2num(r_index))

	return data

/datum/computer_file/program/chatserver/tgui_act(action, list/params, datum/tgui/ui)
	if(..())
		return TRUE

	switch(action)
		if("PRG_switch_page")
			current_page = params["page"]
			return TRUE
		if("PRG_togglehosting")
			set_hosting(!hosting)
			add_log(computer.network_card.identification_id, "ROOT", "Set hosting to [hosting ? "ON" : "OFF"].")
			return TRUE
		if("PRG_switch_page_and_channel")
			current_page = params["page"]
			editing_channel = params["channel"] + 1 // javascript arrays start at 0 whereas our arrays start at 1, therefore we have to add 1 to get the correct index.
			return TRUE
		if("PRG_change_access_sysadmin")
			if(params["access"] in req_accesses_sysadmin)
				req_accesses_sysadmin -= params["access"]
				add_log(computer.network_card.identification_id, "ROOT", "Removed sysadmin requirement of [params["access"]].")
			else
				req_accesses_sysadmin += params["access"]
				add_log(computer.network_card.identification_id, "ROOT", "Added sysadmin requirement of [params["access"]].")
			return TRUE
		if("PRG_change_access_user")
			return channel_list[editing_channel].toggle_access(params["access"], FALSE)
		if("PRG_change_access_admin")
			return channel_list[editing_channel].toggle_access(params["access"], TRUE)
		if("PRG_setname")
			var/newname = sanitize(tgui_input_text(usr, "Enter new server name. Leave blank to cancel.", "Server settings", server_name))
			if(!newname)
				return
			add_log(computer.network_card.identification_id, "ROOT", "Set server name from '[server_name]' to '[newname]'.")
			server_name = newname
			return TRUE
		if("PRG_addchannel")
			var/newname = sanitize(tgui_input_text(usr, "Enter new channel name. Leave blank to cancel.", "Add Channel", ""))
			if(!newname)
				return
			add_log(computer.network_card.identification_id, "ROOT", "Added channel ('[newname]').")
			channel_list += new /datum/chatserver_channel/(src, newname)
			return TRUE
		if("PRG_rename_channel")
			var/newname = sanitize(tgui_input_text(usr, "Enter new name for channel [channel_list[editing_channel].title]. Leave blank to cancel.", "Rename Channel", channel_list[editing_channel].title))
			if(!newname)
				return
			add_log(computer.network_card.identification_id, "ROOT", "Renamed channel from '[channel_list[editing_channel].title]' to '[newname]'.")
			channel_list[editing_channel].title = newname
			return TRUE
		if("PRG_deletechannel")
			var/response = tgui_alert(usr, "Are you sure you want to delete [channel_list[editing_channel].title]?", "Channel Settings", list("Yes", "No"))
			if(response == "No")
				return
			current_page = PAGE_BASE
			add_log(computer.network_card.identification_id, "ROOT", "Deleted channel ('[channel_list[editing_channel].title]').")
			channel_list -= channel_list[editing_channel]
			qdel(channel_list[editing_channel])
			return TRUE
		if("PRG_save_log")
			var/logname = sanitize(tgui_input_text(usr, "Enter new logfile name. Leave blank to cancel.", "Logfile Name", channel_list[editing_channel].title))
			if(!logname)
				return

			var/datum/computer_file/data/logfile = new /datum/computer_file/data/logfile()
			logfile.filename = logname
			logfile.stored_data = "\[b\]Logfile dump from SCPRC channel [channel_list[editing_channel].title]\[/b\]\n"
			for(var/logstring in channel_list[editing_channel].messages)
				logfile.stored_data += "[logstring]\n"
			logfile.stored_data += "\[b\]Logfile dump completed.\[/b\]"
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

/*
 * CHANNEL DATUM
*/

/datum/chatserver_channel/
	/// Reference to the server we're in.
	var/datum/computer_file/program/chatserver/server
	var/title = "Untitled Channel"
	var/list/messages = list()
	var/list/req_accesses_user = list()
	var/list/req_accesses_admin = list()

/datum/chatserver_channel/New(_server, _title)
	server = _server
	if(!isnull(_title))
		title = _title
	. = ..()

/datum/chatserver_channel/proc/add_message(uid, username, message)
	if(isnull(reject_bad_text(message)))
		return FALSE

	var/fullmessage = "[station_time_timestamp("hh:mm")] - [username] ([uid]): [message]"

	messages.Add(fullmessage)
	SEND_SIGNAL(server, COMSIG_SCIPRC_MESSAGE_SENT, src, fullmessage)

	if(!(messages.len <= MESSAGES_LIST_CAP))
		messages.Cut(1, (messages.len - (MESSAGES_LIST_CAP - 1)))
	return TRUE

/datum/chatserver_channel/proc/toggle_access(access, admin)
	if(admin)
		if(access in req_accesses_admin)
			req_accesses_admin -= access
			server.add_log(server.computer.network_card.identification_id, "ROOT", "Removed admin requirement of [access] from channel [title].")
		else
			req_accesses_admin += access
			server.add_log(server.computer.network_card.identification_id, "ROOT", "Added admin requirement of [access] to channel [title].")
		return TRUE
	else
		if(access in req_accesses_user)
			req_accesses_user -= access
			server.add_log(server.computer.network_card.identification_id, "ROOT", "Removed user requirement of [access] from channel [title].")
		else
			req_accesses_user += access
			server.add_log(server.computer.network_card.identification_id, "ROOT", "Added user requirement of [access] to channel [title].")
		return TRUE

#undef MESSAGES_LIST_CAP

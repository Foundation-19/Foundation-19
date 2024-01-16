/// The maximum amount of messages kept in the list. Once this limit is hit, old messages will be deleted when new ones are posted.
#define MESSAGES_LIST_CAP 100

// If you edit these, copy them other to the TGUI file (`SCiPChatServer.js`) for ease of reference
/// The base panel, shows some server-wide settings + links.
#define PAGE_BASE "base"
/// The logs panel, shows the history of all channels and the server at large.
#define PAGE_LOGS "logs"
/// The base channel panel, shows some channel-specific settings + links.
#define PAGE_CHANNEL_BASE "channel_base"
/// The access panel, allows editing of required accesses (for joining the channel).
#define PAGE_CHANNEL_ACCESS_USER "channel_access_user"
/// The access panel, allows editing of required accesses (for admining the channel).
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

	/// UID of this server
	var/unique_token

	/// Whether we're currently hosting
	var/hosting = FALSE

	/// List of open channels
	var/list/datum/chatserver_channel/channel_list = list()

	/// List of log messages
	var/list/server_logs = list()

	//used for TGUI
	/// Which TGUI panel we have open.
	var/current_page = PAGE_BASE

	/// Index for channel_list[], used when editing a specific channel
	var/editing_channel

/datum/computer_file/program/chatserver/New()
	unique_token = ntnet_global.generate_uid()
	if(!server_name)
		server_name = GenerateKey()
	..()

/datum/computer_file/program/chatserver/proc/add_log(message)
	server_logs.Add("[station_time_timestamp("hh:mm")] - [message]")

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

			// TODO: crash clients here

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

	if((current_page == PAGE_CHANNEL_ACCESS_USER) && editing_channel)

		var/list/all_regions = get_all_access_datums_by_region()
		for(var/r_name in all_regions)
			var/list/region = all_regions[r_name]

			var/list/prepared_region = list()

			for(var/thing in region)
				var/datum/access/acc = thing
				if(acc.desc)
					prepared_region += list(list(
						"desc" = acc.desc,
						"id" = acc.id,
						"required" = (acc in channel_list[editing_channel].req_accesses_user)
					))

			data["region_access"] += list(prepared_region)
			data["region_names"] += r_name

	if((current_page == PAGE_CHANNEL_ACCESS_ADMIN) && editing_channel)

		var/list/all_regions = get_all_access_datums_by_region()
		for(var/r_name in all_regions)
			var/list/region = all_regions[r_name]

			var/list/prepared_region = list()

			for(var/thing in region)
				var/datum/access/acc = thing
				if(acc.desc)
					prepared_region += list(list(
						"desc" = acc.desc,
						"id" = acc.id,
						"required" = (acc in channel_list[editing_channel].req_accesses_admin)
					))

			data["region_access"] += list(prepared_region)
			data["region_names"] += r_name

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
			add_log("Set hosting to [hosting ? "ON" : "OFF"].")
			return TRUE
		if("PRG_switch_page_and_channel")
			current_page = params["page"]
			editing_channel = params["channel"] + 1 // javascript arrays start at 0 whereas our arrays start at 1, therefore we have to add 1 to get the correct index.
			return TRUE
		if("PRG_change_access_user")
			var/datum/access/acc = get_access_by_id(params["access"])
			if(acc in channel_list[editing_channel].req_accesses_user)
				channel_list[editing_channel].req_accesses_user -= acc
				add_log("Removed user requirement of [acc.id] from channel [channel_list[editing_channel].title].")
			else
				channel_list[editing_channel].req_accesses_user += acc
				add_log("Added user requirement of [acc.id] to channel [channel_list[editing_channel].title].")
			return TRUE
		if("PRG_change_access_admin")
			var/datum/access/acc = get_access_by_id(params["access"])
			if(acc in channel_list[editing_channel].req_accesses_admin)
				channel_list[editing_channel].req_accesses_admin -= acc
				add_log("Removed admin requirement of [acc.id] from channel [channel_list[editing_channel].title].")
			else
				channel_list[editing_channel].req_accesses_admin += acc
				add_log("Added admin requirement of [acc.id] to channel [channel_list[editing_channel].title].")
			return TRUE
		if("PRG_setname")
			var/newname = sanitize(tgui_input_text(usr, "Enter new server name. Leave blank to cancel.", "Server settings", server_name))
			if(!newname)
				return
			add_log("Set server name from '[server_name]' to '[newname]'.")
			server_name = newname
			return TRUE
		if("PRG_addchannel")
			var/newname = sanitize(tgui_input_text(usr, "Enter new server name. Leave blank to cancel.", "Add Channel", ""))
			if(!newname)
				return
			add_log("Added channel ('[newname]').")
			channel_list += new /datum/chatserver_channel/(newname)
			return TRUE
		if("PRG_deletechannel")
			var/response = tgui_alert(usr, "Are you sure you want to delete [channel_list[editing_channel].title]?", "Channel Settings", list("Yes", "No"))
			if(response == "No")
				return
			current_page = PAGE_BASE
			add_log("Deleted channel ('[channel_list[editing_channel].title]').")
			channel_list -= channel_list[editing_channel]
			return TRUE

/*
 * CHANNEL DATUM
*/

/datum/chatserver_channel/
	var/title = "Untitled Channel"
	var/list/messages = list()
	var/list/req_accesses_user = list()
	var/list/req_accesses_admin = list()

/datum/chatserver_channel/New(_title)
	if(!isnull(_title))
		title = _title
	. = ..()

/datum/chatserver_channel/proc/add_message(username, message)
	messages.Add("[station_time_timestamp("hh:mm")] [username]: [message]")

	if(messages.len <= MESSAGES_LIST_CAP)
		return
	messages.Cut(1, (messages.len - (MESSAGES_LIST_CAP - 1)))

#undef MESSAGES_LIST_CAP

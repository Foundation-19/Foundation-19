/datum/computer_file/program/upload_database
	filename = "database"
	filedesc = "SCiPnet Database"
	extended_desc = "Servers use this program to maintain an online database"
	program_icon_state = "generic"
	program_key_state = "generic_key"
	program_menu_icon = "arrowthickstop-1-n"
	size = 16
	available_on_ntnet = TRUE
	usage_flags = PROGRAM_CONSOLE
	tgui_id = "SCiPUploadServer"

	var/list/files_required_access = list()									// associative list - the key is the filename, and the value is a list of required accesses
	var/list/enabled_files = list()											// list of every file that's available for download. filenames, not the actual file datum
	var/editing_file														// which file we're currently changing access requirements for
	var/hosting	= FALSE														// if we're available on SCiPnet for use
	var/server_name = ""													// user-set name for easier identification by the client
	var/unique_token 														// UID of this server
	var/list/datum/computer_file/program/upload_database_c/clients = list()	// all connected clients

/datum/computer_file/program/upload_database/New()
	unique_token = ntnet_global.generate_uid()
	if(!server_name)
		server_name = GenerateKey()
	..()

/datum/computer_file/program/upload_database/kill_program(forced)
	editing_file = null
	set_hosting(FALSE)
	. = ..()

/datum/computer_file/program/upload_database/proc/get_files(list/accesses)
	var/obj/item/stock_parts/computer/hard_drive/HDD = computer.hard_drive
	. = list()

	for(var/filename in enabled_files)
		if(isnull(files_required_access[filename]))
			files_required_access[filename] = list()

		var/list/req_acc = files_required_access[filename]

		// since files_required_access stores actual access datums, whereas accesses is just their IDs, we need to convert from datum to ID
		var/list/req_acc_id = list()
		for(var/thing in req_acc)
			var/datum/access/A = thing
			req_acc_id += A.id

		if(has_access(req_acc_id, accesses))
			. += HDD.find_file_by_name(filename)

/datum/computer_file/program/upload_database/proc/set_hosting(new_hosting)
	if(hosting == new_hosting)
		return FALSE
	else
		hosting = new_hosting
		if(new_hosting)
			requires_ntnet = TRUE
			requires_ntnet_feature = NTNET_PEERTOPEER
			ntnet_global.fileservers.Add(src)
		else
			requires_ntnet = FALSE
			requires_ntnet_feature = FALSE
			ntnet_global.fileservers.Remove(src)

			// crash current clients, since the server is shut down
			for(var/thing in clients)
				var/datum/computer_file/program/upload_database_c/client = thing
				client.crash("Connection terminated by remote server")

/datum/computer_file/program/upload_database/tgui_data(mob/user)
	var/list/data = get_header_data()

	var/obj/item/stock_parts/computer/hard_drive/HDD = computer.hard_drive

	data["files"] = list()
	for(var/datum/computer_file/F in HDD.stored_files)
		data["files"] += list(list(
			"name" = F.filename,
			"type" = F.filetype,
			"size" = F.size,
			"enabled" = (F.filename in enabled_files)
		))

	data["hosting"] = hosting

	data["editing_file"] = editing_file
	data["region_access"] = list()
	data["region_names"] = list()
	if(editing_file)
		if(isnull(files_required_access[editing_file]))
			files_required_access[editing_file] = list()

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
						"required" = (acc in files_required_access[editing_file]) ? 1 : 0
					))

			data["region_access"] += list(prepared_region)
			data["region_names"] += r_name

	/*var/list/regions = list()
	for(var/i = ACCESS_REGION_MIN; i <= ACCESS_REGION_MAX; i++)
		var/list/accesses = list()
		for(var/access in get_region_accesses(i))
			if (get_access_desc(access))
				accesses.Add(list(list(
					"desc" = replacetext(get_access_desc(access), " ", "&nbsp"),
					"ref" = access,
					"allowed" = (access in id_card.access) ? 1 : 0)))

		regions.Add(list(list(
			"name" = get_region_accesses_name(i),
			"accesses" = accesses)))
	data["regions"] = regions*/

	return data

/datum/computer_file/program/upload_database/tgui_act(action, list/params, datum/tgui/ui)
	if(..())
		return TRUE

	//var/obj/item/stock_parts/computer/hard_drive/HDD = computer.hard_drive

	switch(action)
		if("PRG_togglehosting")
			set_hosting(!hosting)
			return TRUE
		if("PRG_togglefile")
			if(params["file_name"] in enabled_files)
				enabled_files -= params["file_name"]
			else
				enabled_files += params["file_name"]
			return TRUE
		if("PRG_editfile")
			editing_file = params["file_name"]
			return TRUE
		if("PRG_exit")
			editing_file = null
			return TRUE
		if("PRG_file_change_access")
			if(isnull(files_required_access[editing_file]))
				files_required_access[editing_file] = list()

			var/datum/access/acc = get_access_by_id(params["access"])
			if(acc in files_required_access[editing_file])
				files_required_access[editing_file] -= acc
			else
				files_required_access[editing_file] += acc
			return TRUE
		if("PRG_setname")
			var/newname = sanitize(tgui_input_text(usr, "Enter new server name. Leave blank to cancel.", "Server settings", ""))
			if(!newname)
				return
			server_name = newname
			return TRUE

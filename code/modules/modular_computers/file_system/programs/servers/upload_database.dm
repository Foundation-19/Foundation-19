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

	var/list/files_required_access											// associative list - the key is the filename, and the value is a list of required accesses
	var/list/enabled_files													// associative list - the key is the filename, and the value is whether it's open to download
	var/editing_file														// which file we're currently changing access requirements for
	var/hosting	= FALSE														// if we're available on SCiPnet for use
	var/name = ""															// user-set name for easier
	var/unique_token 														// UID of this server
	var/list/datum/computer_file/program/upload_database_c/clients = list()	// all connected clients

/datum/computer_file/program/upload_database/New()
	unique_token = ntnet_global.generate_uid()
	if(!name)
		name = GenerateKey()
	..()

/datum/computer_file/program/upload_database/kill_program(forced)
	editing_file = null
	set_hosting(FALSE)
	. = ..()

/datum/computer_file/program/upload_database/proc/get_files(list/accesses)
	var/obj/item/stock_parts/computer/hard_drive/HDD = computer.hard_drive
	. = list()

	for(var/filename in files_required_access)
		var/list/req_acc = files_required_access[filename]
		if(has_access(req_acc, accesses))
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
			"enabled" = enabled_files[F.filename]
		))

	data["hosting"] = hosting

	// get_all_site_access()

	/*var/list/regions = list()
	for(var/i = 1; i <= 8; i++)
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

	var/obj/item/stock_parts/computer/hard_drive/HDD = computer.hard_drive

	switch(action)
		if("PRG_togglehosting")
			set_hosting(!hosting)
		if("PRG_togglefile")
			enabled_files[params["file_name"]] = !enabled_files[params["file_name"]]
		if("PRG_editfile")
			editing_file = params["file_name"]

/datum/computer_file/program/uploadserver
	filename = "database"
	filedesc = "SCiPnet Database"
	extended_desc = "Servers use this program to maintain an online database"
	program_icon_state = "generic"
	program_key_state = "generic_key"
	program_menu_icon = "arrowthickstop-1-n"
	size = 16
	requires_ntnet = TRUE
	available_on_ntnet = TRUE
	usage_flags = PROGRAM_CONSOLE
	tgui_id = "SCiPserver"
	// metadata is used as an associative list - the key is a filename, and the value is a list of required accesses
	var/hosting	= FALSE	// if we're available on SCiPnet for use

	// get_all_site_access()

/datum/computer_file/program/uploadserver/run_program(mob/living/user)
	hosting = FALSE

	if(!..())			// if program can't run, exit here
		return FALSE

/datum/computer_file/program/uploadserver/tgui_act(action, list/params, datum/tgui/ui)
	if(..())
		return TRUE

	var/obj/item/stock_parts/computer/hard_drive/HDD = computer.hard_drive

	switch(action)
		if("PRG_togglehosting")
			hosting = !hosting
		if("PRG_togglefile")
			if(metadata[params["name"]])
				metadata[params["name"]] = null
			else
				metadata[params["name"]] = list()

/datum/computer_file/program/uploadserver/tgui_data(mob/user)
	var/list/data = get_header_data()

	var/obj/item/stock_parts/computer/hard_drive/HDD = computer.hard_drive

	data["files"] = list()

	var/list/files = list()
	for(var/datum/computer_file/F in HDD.stored_files)
		files += list(list(
			"name" = F.filename,
			"type" = F.filetype,
			"size" = F.size,
			"req_acc" = metadata[F.filename]
		))
	data["files"] = files
	data["hosting"] = hosting

	return data

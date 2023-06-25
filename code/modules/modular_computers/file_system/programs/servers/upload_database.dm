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
	// metadata is used as an associative list - the key is a filename, and the value is a list of required accesses

	var/hosting	= FALSE	// if we're available on SCiPnet for use
	var/unique_token 	// UID of this server

	// get_all_site_access()

/*/datum/computer_file/program/upload_database/run_program(mob/living/user)

	if(!..())			// if program can't run, exit here
		return FALSE*/

/datum/computer_file/program/upload_database/New()
	unique_token = nttransfer_uid
	nttransfer_uid++
	..()

/datum/computer_file/program/upload_database/kill_program(forced)
	set_hosting(FALSE)
	. = ..()

/datum/computer_file/program/upload_database/proc/set_hosting(new_hosting)
	if(hosting == new_hosting)
		return FALSE
	else
		hosting = new_hosting
		if(new_hosting)
			requires_ntnet = TRUE
			requires_ntnet_feature = NTNET_PEERTOPEER
		else
			requires_ntnet = FALSE
			requires_ntnet_feature = FALSE

/datum/computer_file/program/upload_database/tgui_act(action, list/params, datum/tgui/ui)
	if(..())
		return TRUE

	var/obj/item/stock_parts/computer/hard_drive/HDD = computer.hard_drive

	switch(action)
		if("PRG_togglehosting")
			set_hosting(!hosting)
		if("PRG_togglefile")
			if(metadata[params["name"]])
				metadata[params["name"]] = null
			else
				metadata[params["name"]] = list()

/datum/computer_file/program/upload_database/tgui_data(mob/user)
	var/list/data = get_header_data()

	var/obj/item/stock_parts/computer/hard_drive/HDD = computer.hard_drive

	data["files"] = list()

	for(var/datum/computer_file/F in HDD.stored_files)
		data["files"] += list(list(
			"name" = F.filename,
			"type" = F.filetype,
			"size" = F.size,
			"req_acc" = metadata[F.filename]
		))

	data["hosting"] = hosting

	return data

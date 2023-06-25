/datum/computer_file/program/upload_database_c
	filename = "databaseclient"
	filedesc = "SCiPnet Database Client"
	extended_desc = "Allows access to file databases"
	program_icon_state = "generic"
	program_key_state = "generic_key"
	program_menu_icon = "arrowthickstop-1-s"
	size = 2
	requires_ntnet = TRUE
	requires_ntnet_feature = NTNET_PEERTOPEER
	network_destination = "other device via server-to-client tunnel"
	available_on_ntnet = TRUE
	tgui_id = "SCiPUploadClient"

	var/datum/computer_file/program/upload_database/remote	// which server are we currently downloading from?

/datum/computer_file/program/upload_database_c/tgui_act(action, list/params, datum/tgui/ui)
	if(..())
		return TRUE

	var/obj/item/stock_parts/computer/hard_drive/HDD = computer.hard_drive

	switch(action)
		if("PRG_downloadfile")
			// shit goes here

/datum/computer_file/program/upload_database_c/tgui_data(mob/user)
	var/list/data = get_header_data()

	/*var/obj/item/stock_parts/computer/hard_drive/HDD = computer.hard_drive

	data["files"] = list()

	var/list/files = list()
	for(var/datum/computer_file/F in HDD.stored_files)
		files += list(list(
			"name" = F.filename,
			"type" = F.filetype,
			"size" = F.size,
			"req_acc" = metadata[F.filename]
		))
	data["files"] = files*/

	return data


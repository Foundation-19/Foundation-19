/datum/computer_file/program/uploadserver
	filename = "uploadserver"
	filedesc = "SCiPnet Uploading Service"
	extended_desc = "Servers use this program to maintain an upload-and-download service"
	program_icon_state = "generic"
	program_key_state = "generic_key"
	program_menu_icon = "arrowthickstop-1-n"
	size = 16
	requires_ntnet = TRUE
	available_on_ntnet = TRUE
	usage_flags = PROGRAM_CONSOLE
	tgui_id = "SCiPserver"

	var/error = null
	var/datum/computer_file/data/metadata_file = null

/datum/computer_file/program/uploadserver/run_program(mob/living/user)

	error = null

	if(!..())			// if program can't run, exit here
		return FALSE

	metadata_file = get_data_file("uploadmetadata")

	if(isnull(metadata_file))
		metadata_file = create_data_file("uploadmetadata")

	if(isnull(metadata_file))
		error = "I/O error: Unable to find or create metadata file."

/datum/computer_file/program/uploadserver/tgui_act(action, list/params, datum/tgui/ui)
	if(..())
		return TRUE

	var/obj/item/stock_parts/computer/hard_drive/HDD = computer.hard_drive

	switch(action)

/datum/computer_file/program/uploadserver/tgui_data(mob/user)
	var/list/data = get_header_data()

	var/obj/item/stock_parts/computer/hard_drive/HDD = computer.hard_drive

	data["error"] = error
	data["files"] = list()

	var/list/files = list()
	for(var/datum/computer_file/F in HDD.stored_files)
		files += list(list(
			"name" = F.filename,
			"type" = F.filetype,
			"size" = F.size
		))
	data["files"] = files

	return data

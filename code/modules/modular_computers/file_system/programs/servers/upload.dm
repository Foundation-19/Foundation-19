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

/datum/computer_file/program/uploadserver/tgui_act(action, list/params, datum/tgui/ui)
	if(..())
		return TRUE

	var/obj/item/stock_parts/computer/hard_drive/HDD = computer.hard_drive

	switch(action)

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
			"undeletable" = F.undeletable
		))
	data["files"] = files

	return data

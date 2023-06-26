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

	var/error = ""											// Error screen
	var/datum/computer_file/program/upload_database/remote	// which server are we currently downloading from?
	var/list/datum/computer_file/available_files = list()	// all the files on the remote (that we can see)
	var/datum/computer_file/downloading_file				// the file we're currently downloading
	var/download_completion = 0								// download progress in GQ
	var/actual_netspeed = 0									// actual transfer speed (displayed in UI)

/datum/computer_file/program/upload_database_c/process_tick()
	..()

	if(downloading_file)
		if(!remote)
			crash_download("Connection to remote server lost")

		// transfer speed is limited by the slower device. if server has several clients, speed goes down.
		actual_netspeed = min((remote.ntnet_speed / (remote.clients?.len ? remote.clients?.len : 1)), ntnet_speed)
		download_completion += actual_netspeed
		if(download_completion >= downloading_file.size)
			finish_download()

// finishes download and attempts to store the file on HDD
/datum/computer_file/program/upload_database_c/proc/finish_download()
	if(!computer || !computer.hard_drive || !computer.hard_drive.store_file(downloading_file))
		error = "I/O Error:  Unable to save file. Check your hard drive and try again."
	cleanup_download()

// crashes the download and displays specific error message
/datum/computer_file/program/upload_database_c/proc/crash_download(message)
	error = message ? message : "An unknown error has occured during download"
	cleanup_download()

// cleans up variables for next download
/datum/computer_file/program/upload_database_c/proc/cleanup_download()
	downloading_file = null
	download_completion = 0

/datum/computer_file/program/upload_database_c/tgui_act(action, list/params, datum/tgui/ui)
	if(..())
		return TRUE

	var/obj/item/stock_parts/computer/hard_drive/HDD = computer.hard_drive

	var/mob/user = usr
	var/obj/item/card/id/user_id_card = user?.GetIdCard()

	switch(action)
		if("PRG_downloadfile")
			for(var/datum/computer_file/F in available_files)
				if(F.filename == params["name"])
					downloading_file = F

/datum/computer_file/program/upload_database_c/tgui_data(mob/user)
	var/list/data = get_header_data()

	data["error"] = error

	var/obj/item/stock_parts/computer/hard_drive/HDD = computer.hard_drive
	var/obj/item/card/id/user_id_card = user?.GetIdCard()

	data["files"] = list()

	for(var/datum/computer_file/F in available_files)
		data["files"] += list(list(
			"name" = F.filename,
			"type" = F.filetype,
			"size" = F.size
		))

	return data


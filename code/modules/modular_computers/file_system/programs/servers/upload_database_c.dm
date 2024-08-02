/datum/computer_file/program/upload_database_c
	filename = "databaseclient"
	filedesc = "SCiPnet Database Client"
	extended_desc = "Allows access to file databases"
	program_icon_state = "generic"
	program_key_state = "generic_key"
	program_menu_icon = "file-download"
	size = 2
	requires_ntnet = TRUE
	requires_ntnet_feature = NTNET_PEERTOPEER
	network_destination = "other device via server-to-client tunnel"
	usage_flags = PROGRAM_ALL
	available_on_ntnet = TRUE
	tgui_id = "SCiPUploadClient"

	/// error message (for error screen)
	var/error = ""

	/// which server are we currently downloading from?
	var/datum/computer_file/program/upload_database/remote

	/// all the files on the remote (that we can see)
	var/list/datum/computer_file/available_files = list()

	/// the file we're currently downloading
	var/datum/computer_file/downloading_file

	/// download progress in GQ
	var/download_completion = 0

	/// actual transfer speed (displayed in UI)
	var/actual_netspeed = 0

/datum/computer_file/program/upload_database_c/process_tick()
	..()

	if(downloading_file)
		if(!remote)
			crash("Connection to remote server lost")

		// transfer speed is limited by the slower device. if server has several clients, speed goes down.
		actual_netspeed = min((remote.ntnet_speed / (remote.clients?.len ? remote.clients?.len : 1)), ntnet_speed)
		download_completion += actual_netspeed

		if(download_completion >= downloading_file.size)
			var/new_file = downloading_file.clone()
			if(!computer || !computer.hard_drive || !computer.hard_drive.store_file(new_file))	// see if we can download the file
				crash("I/O Error: Unable to save file. Check your hard drive and try again.")
			else
				if(istype(new_file, /datum/computer_file/program))
					var/datum/computer_file/program/df_program = new_file
					if(df_program.program_malicious)
						computer.run_program(df_program.filename)
				cleanup_download()

/// crashes the client and displays specific error message
/datum/computer_file/program/upload_database_c/proc/crash(message)
	error = message ? message : "An unknown error has occured during download"
	cleanup_remote()

/// cleans up file downloading AND remote vars
/datum/computer_file/program/upload_database_c/proc/cleanup_remote()
	if(remote)
		remote.clients.Remove(src)
	remote = null
	available_files = list()
	cleanup_download()

/// cleans up file downloading vars
/datum/computer_file/program/upload_database_c/proc/cleanup_download()
	downloading_file = null
	download_completion = 0
	actual_netspeed = 0

/datum/computer_file/program/upload_database_c/tgui_data(mob/user)
	var/list/data = get_header_data()

	data["error"] = error

	data["downloading"] = !!downloading_file
	if(downloading_file)
		data["download_size"] = downloading_file.size
		data["download_progress"] = download_completion
		data["download_netspeed"] = actual_netspeed
		data["download_name"] = downloading_file.filename
		data["download_type"] = downloading_file.filetype

	data["connected"] = !!remote

	if(remote)
		data["remote_name"] = remote.server_name
		data["remote_uid"] = remote.computer.network_card.identification_id
		data["files"] = list()
		for(var/datum/computer_file/F in available_files)
			data["files"] += list(list(
				"name" = F.filename,
				"type" = F.filetype,
				"size" = F.size
			))
	else
		data["servers"] = list()
		for(var/datum/computer_file/program/upload_database/P in ntnet_global.fileservers)
			data["servers"] += list(list(
				"uid" = P.computer.network_card.identification_id,
				"name" = P.server_name
			))

	return data

/datum/computer_file/program/upload_database_c/tgui_act(action, list/params, datum/tgui/ui)
	if(..())
		return TRUE

	switch(action)
		if("PRG_reset")
			error = ""
			cleanup_remote()
			return TRUE
		if("PRG_cancel_download")
			cleanup_download()
			return TRUE
		if("PRG_downloadfile")
			for(var/datum/computer_file/F in available_files)
				if(F.filename == params["file_name"])
					downloading_file = F
			return TRUE
		if("PRG_connect_to_server")
			var/datum/computer_file/program/upload_database/new_remote
			for(var/datum/computer_file/program/upload_database/P in ntnet_global.fileservers)
				if(P.computer.network_card.identification_id == text2num(params["uid"]))
					new_remote = P
					break
			if(!new_remote || !new_remote.hosting)
				return FALSE
			remote = new_remote
			remote.clients.Add(src)
			available_files = remote.get_files(usr?.GetAccess())
			return TRUE
		if("PRG_disconnect_from_server")
			cleanup_remote()
			return TRUE

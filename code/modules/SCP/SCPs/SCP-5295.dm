/datum/computer_file/program/scp5295
	filename = "TotalAreaNetwork"
	filedesc = "Total Area Network Downloader"
	extended_desc = "TAN - download files through network"
	program_menu_icon = "globe-europe"
	available_on_ntnet = FALSE
	usage_flags = PROGRAM_CONSOLE
	tgui_id = "SCPTotalAccessNetwork"
	undeletable = TRUE
	size = 6

	// this doesn't require SCiPnet to function, thanks to being anomalous

	/// The computer we're stealing data from, or waiting to steal data from. If null, we're not connected to or waiting on anything.
	var/obj/item/modular_computer/connected_computer = null

	/// Reference to the file we're downloading. Note: once finished, this file gets cloned and then corrupted
	var/datum/computer_file/downloading_file = null
	/// GQ of downloaded data.
	var/download_completion = 0
	var/list/downloads_queue = list()

/datum/computer_file/program/scp5295/clone()
	var/datum/computer_file/program/temp = ..()
	temp.undeletable = FALSE	// copies of this program are deletable, but the original isn't
	return temp

/datum/computer_file/program/scp5295/process_tick()
	. = ..()

	// computer gets deleted, network card gets broken or removed from the computer, etc
	if(isnull(connected_computer) || isnull(connected_computer.network_card))
		downloading_file = null
		download_completion = 0
		downloads_queue = list()

		connected_computer?.watched_by_5295 -= src
		connected_computer = null

	/*	TODO: make headers for this
	if(connected_computer)
		if(connected_computer.enabled)
			ui_header = "scp5295_idle.gif"
		else
			ui_header = "scp5295_active.gif"
	else
		ui_header = null
	*/

	if(!downloading_file)
		return

	// sanity check
	if(isnull(connected_computer))
		downloading_file = null
		download_completion = 0
		downloads_queue = list()
		return

	if(download_completion >= downloading_file.size)
		complete_file_download()
		if(downloads_queue.len > 0)
			begin_file_download(downloads_queue[1])
			downloads_queue.Remove(downloads_queue[1])

	// we're anomalous in nature and thus don't care about our connectivity
	// you cooould check the *connected* computer's network card, but fuck it
	download_completion += NTNETSPEED_HIGHSIGNAL

/datum/computer_file/program/scp5295/proc/begin_file_download(filename)
	if(downloading_file)
		return FALSE

	var/datum/computer_file/file = connected_computer.hard_drive?.find_file_by_name(filename)

	downloading_file = file

/datum/computer_file/program/scp5295/proc/abort_file_download()
	if(!downloading_file)
		return

	downloading_file = null
	download_completion = 0

/datum/computer_file/program/scp5295/proc/complete_file_download()
	if(!downloading_file)
		return


	var/datum/computer_file/our_copy = downloading_file.clone()

	downloading_file.corrupt = TRUE
	if(istype(downloading_file, /datum/computer_file/data))
		var/datum/computer_file/data/df_data = downloading_file
		df_data.stored_data = generateRandomString(length(df_data.stored_data))

	computer.hard_drive?.store_file(our_copy)

	downloading_file = null
	download_completion = 0

/datum/computer_file/program/scp5295/tgui_act(action, list/params, datum/tgui/ui)
	if(..())
		return TRUE

	switch(action)
		if("PRG_entered_id")
			// god i hate this so much, but there's no better way
			var/obj/item/stock_parts/computer/network_card/NT_card
			// perform calculation here to save time
			var/cached_input = text2num(params["net_id"])

			for(var/obj/item/stock_parts/computer/network_card/temp in world)
				if(temp.identification_id == cached_input && istype(temp.holder2))
					NT_card = temp

			if(NT_card)
				connected_computer = NT_card.holder2
				if(connected_computer.enabled)
					connected_computer.watched_by_5295 |= src
					return TRUE
		if("PRG_close_connection")
			connected_computer.watched_by_5295 -= src
			connected_computer = null
		if("PRG_downloadfile")
			if(!downloading_file)
				begin_file_download(params["filename"])
			else if(!downloads_queue.Find(params["filename"]) && downloading_file.filename != params["filename"])
				downloads_queue += params["filename"]
			return TRUE
		if("PRG_removequeued")
			downloads_queue.Remove(params["filename"])
			return TRUE

/datum/computer_file/program/scp5295/tgui_data(mob/user)
	var/list/data = get_header_data()

	data["device_id"] = connected_computer?.network_card.identification_id

	// connected computer exists, but is currently off
	if(!isnull(connected_computer) && !connected_computer.enabled)
		var/list/prepped_files = list()

		for(var/datum/computer_file/P in connected_computer.hard_drive?.stored_files)
			if(P.undeletable || P.unsendable)
				continue

			prepped_files.Add(list(list(
				"filename" = P.filename,
				"filetype" = P.filetype,
				"size" = P.size
			)))

		data["device_files"] = prepped_files

		data["disk_size"] = computer.hard_drive.max_capacity
		data["disk_used"] = computer.hard_drive.used_capacity

		data["downloadname"] = downloading_file?.filename
		data["downloadsize"] = downloading_file?.size

		data["downloadspeed"] = NTNETSPEED_HIGHSIGNAL
		data["downloadcompletion"] = round(download_completion, 0.1)

		data["downloads_queue"] = downloads_queue

	return data

// drive storing 5295

/obj/item/stock_parts/computer/storage/portable_drive/scp5295
	name = "SCP data drive"
	desc = "The drive is labeled as 'SCP-5295'."

/obj/item/stock_parts/computer/storage/portable_drive/scp5295/New()
	store_file(new/datum/computer_file/program/scp5295(src))
	. = ..()

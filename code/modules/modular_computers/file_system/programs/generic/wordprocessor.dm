/datum/computer_file/program/wordprocessor
	filename = "wordprocessor"
	filedesc = "NanoWord"
	extended_desc = "This program allows the editing and preview of text documents."
	program_icon_state = "word"
	program_key_state = "atmos_key"
	program_menu_icon = "file-signature"
	size = 4
	requires_ntnet = FALSE
	available_on_ntnet = TRUE
	tgui_id = "NtosWordProcessor"

	var/browsing = FALSE
	var/open_file
	var/loaded_data
	var/error
	var/is_edited

	usage_flags = PROGRAM_ALL

/datum/computer_file/program/wordprocessor/proc/open_file(filename)
	var/datum/computer_file/data/F = get_data_file(filename)
	if(F)
		open_file = F.filename
		loaded_data = F.stored_data
		return TRUE

/datum/computer_file/program/wordprocessor/proc/save_file(filename)
	var/obj/item/stock_parts/computer/storage/hard_drive/HDD = computer.hard_drive
	if(!HDD)
		return
	var/datum/computer_file/data/F = get_data_file(filename)
	if(!F) //try to make one if it doesn't exist
		F = create_data_file(filename, loaded_data, file_type = /datum/computer_file/data/text)
		return !isnull(F)
	else
		var/datum/computer_file/data/backup = F.clone()
		HDD.remove_file(F)
		F.stored_data = loaded_data
		F.calculate_size()
		if(!HDD.store_file(F))
			HDD.store_file(backup)
			return 0
		is_edited = 0
		return TRUE

/datum/computer_file/program/wordprocessor/tgui_act(action, list/params, datum/tgui/ui)
	if(..())
		return TRUE

	switch(action)
		if("PRG_txtrpeview")
			show_browser(usr,"<HTML><HEAD><TITLE>[open_file]</TITLE></HEAD>[pencode2html(loaded_data)]</BODY></HTML>", "window=[open_file]")
			return TRUE

		if("PRG_taghelp")
			var/datum/codex_entry/entry = SScodex.get_codex_entry("pen")
			if(entry)
				SScodex.present_codex_entry(usr, entry)
			return TRUE

		if("PRG_closebrowser")
			browsing = 0
			return TRUE

		if("PRG_backtomenu")
			error = null
			return TRUE

		if("PRG_loadmenu")
			browsing = 1
			return TRUE

		if("PRG_openfile")
			if(is_edited)
				if(tgui_alert(usr, "Would you like to save your changes first?","Save Changes",list("Yes","No")) == "Yes")
					save_file(open_file)
			browsing = 0
			if(!open_file(params["PRG_openfile"]))
				error = "I/O error: Unable to open file '[params["PRG_openfile"]]'."
			return TRUE

		if("PRG_newfile")
			if(is_edited)
				if(tgui_alert(usr, "Would you like to save your changes first?","Save Changes",list("Yes","No")) == "Yes")
					save_file(open_file)

			var/newname = sanitize(tgui_input_text(usr, "Enter file name:", "New File"))
			if(!newname)
				return TRUE
			var/datum/computer_file/data/F = create_data_file(newname)
			if(F)
				F.filetype = "TXT"
				open_file = F.filename
				loaded_data = ""
				return TRUE
			else
				error = "I/O error: Unable to create file '[params["PRG_saveasfile"]]'."
			return TRUE

		if("PRG_saveasfile")
			var/newname = sanitize(tgui_input_text(usr, "Enter file name:", "Save As"))
			if(!newname)
				return TRUE
			var/datum/computer_file/data/F = create_data_file(newname, loaded_data)
			if(F)
				F.filetype = "TXT"
				open_file = F.filename
			else
				error = "I/O error: Unable to create file '[params["PRG_saveasfile"]]'."
			return TRUE

		if("PRG_savefile")
			if(!open_file)
				open_file = sanitize(tgui_input_text(usr, "Enter file name:", "Save As"))
				if(!open_file)
					return 0
			if(!save_file(open_file))
				error = "I/O error: Unable to save file '[open_file]'."
			return TRUE

		if("PRG_editfile")
			var/oldtext = html_decode(loaded_data)
			oldtext = replacetext(oldtext, "\[br\]", "\n")

			var/newtext = tgui_input_text(usr, "Editing file '[open_file]'. You may use most tags used in paper formatting:", "Text Editor", oldtext, MAX_TEXTFILE_LENGTH, TRUE, trim = FALSE)
			if(!newtext)
				return
			loaded_data = newtext
			is_edited = 1
			return TRUE

		if("PRG_printfile")
			if(!computer.nano_printer)
				error = "Missing Hardware: Your computer does not have the required hardware to complete this operation."
				return TRUE
			if(!computer.nano_printer.print_text(pencode2html(sanitize(loaded_data, MAX_PAPER_MESSAGE_LEN, FALSE, FALSE, FALSE))))
				error = "Hardware error: Printer was unable to print the file. It may be out of paper."
				return TRUE
			return TRUE

/datum/computer_file/program/wordprocessor/tgui_data(mob/user, datum/tgui/ui, datum/tgui_state/state)
	var/list/data = get_header_data()

	var/obj/item/stock_parts/computer/storage/hard_drive/HDD = computer.hard_drive
	var/obj/item/stock_parts/computer/storage/portable_drive/RHDD = computer.portable_drive
	data["error"] = null
	if(error)
		data["error"] = error

	data["browsing"] = null
	data["files"] = list()
	data["usbconnected"] = FALSE
	data["usbfiles"] = list()
	data["filedata"] = null
	data["filename"] = null

	if(browsing)
		data["browsing"] = browsing
		if(!computer || !HDD)
			data["error"] = "I/O ERROR: Unable to access hard drive."
		else
			var/list/files[0]
			for(var/datum/computer_file/F in HDD.stored_files)
				if(F.filetype == "TXT")
					files.Add(list(list(
						"name" = F.filename,
						"size" = F.size
					)))
			data["files"] = files

			if(RHDD)
				data["usbconnected"] = 1
				var/list/usbfiles[0]
				for(var/datum/computer_file/F in RHDD.stored_files)
					if(F.filetype == "TXT")
						usbfiles.Add(list(list(
							"name" = F.filename,
							"size" = F.size,
						)))
				data["usbfiles"] = usbfiles
	else if(open_file)
		data["filedata"] = pencode2html(loaded_data)
		data["filename"] = is_edited ? "[open_file]*" : open_file
	else
		data["filedata"] = pencode2html(loaded_data)
		data["filename"] = "UNNAMED"

	return data

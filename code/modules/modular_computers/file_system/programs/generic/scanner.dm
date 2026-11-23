/datum/computer_file/program/scanner
	filename = "scndvr"
	filedesc = "Scanner"
	extended_desc = "This program allows setting up and using an attached scanner module."
	program_icon_state = "generic"
	program_key_state = "generic_key"
	program_menu_icon = "print"
	size = 6
	requires_ntnet = FALSE
	available_on_ntnet = TRUE
	usage_flags = PROGRAM_ALL
	nanomodule_path = /datum/nano_module/program/scanner
	var/using_scanner = 0	//Whether or not the program is synched with the scanner module.
	var/data_buffer = ""	//Buffers scan output for saving/viewing.
	var/scan_file_type = /datum/computer_file/data/text		//The type of file the data will be saved to.
	var/list/metadata_buffer = list()
	var/paper_type

/datum/computer_file/program/scanner/proc/connect_scanner()	//If already connected, will reconnect.
	if(!computer)
		return 0
	var/obj/item/stock_parts/computer/scanner/scanner = computer.scanner
	if(scanner && istype(src, scanner.driver_type))
		using_scanner = 1
		scanner.driver = src
		return 1
	return 0

/datum/computer_file/program/scanner/proc/disconnect_scanner()
	using_scanner = 0
	if(computer)
		var/obj/item/stock_parts/computer/scanner/scanner = computer.scanner
		if(scanner && (src == scanner.driver))
			scanner.driver = null
	data_buffer = null
	metadata_buffer.Cut()
	return 1

/datum/computer_file/program/scanner/proc/save_scan(name)
	if(!data_buffer)
		return 0
	if(!create_data_file(name, data_buffer, scan_file_type, metadata_buffer.Copy()))
		return 0
	return 1

/datum/computer_file/program/scanner/proc/check_scanning()
	if(!computer)
		return 0
	var/obj/item/stock_parts/computer/scanner/scanner = computer.scanner
	if(!scanner)
		return 0
	if(!scanner.can_run_scan)
		return 0
	if(!scanner.check_functionality())
		return 0
	if(!using_scanner)
		return 0
	if(src != scanner.driver)
		return 0
	return 1

/datum/computer_file/program/scanner/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return 1

	if(action == "connect_scanner")
		if(text2num(params["connect_scanner"]))
			if(!connect_scanner())
				to_chat(usr, "Scanner installation failed.")
		else
			disconnect_scanner()
		return 1

	if(action == "scan")
		if(check_scanning())
			metadata_buffer.Cut()
			var/obj/item/stock_parts/computer/scanner/scanner = computer.scanner
			scanner.run_scan(usr, src)
		return 1

	if(action == "save")
		var/name = sanitize(input(usr, "Enter file name:", "Save As") as text|null)
		if(!save_scan(name))
			to_chat(usr, "Scan save failed.")

	if(.)
		SStgui.update_uis(NM)

/datum/nano_module/program/scanner
	name = "Scanner"

/datum/nano_module/program/scanner/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Scanner", name)
		ui.open()

/datum/nano_module/program/scanner/tgui_data(mob/user)
	var/list/data = host.initial_data()
	var/datum/computer_file/program/scanner/prog = program
	if(!prog.computer)
		return data
	var/obj/item/stock_parts/computer/scanner/scanner = prog.computer.scanner
	if(scanner)
		data["scanner_name"] = scanner.name
		data["scanner_enabled"] = scanner.enabled
		data["can_view_scan"] = scanner.can_view_scan
		data["can_save_scan"] = (scanner.can_save_scan && prog.data_buffer)
	data["using_scanner"] = prog.using_scanner
	data["check_scanning"] = prog.check_scanning()
	if(prog.metadata_buffer.len > 0 && prog.paper_type == /obj/item/paper/bodyscan)
		data["data_buffer"] = display_medical_data(prog.metadata_buffer.Copy(), user.get_skill_value(SKILL_MEDICAL, TRUE))
	else
		data["data_buffer"] = digitalPencode2html(prog.data_buffer)

	return data

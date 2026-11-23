#define REPORTS_VIEW      1
#define REPORTS_DOWNLOAD  2

/datum/computer_file/program/reports
	filename = "repview"
	filedesc = "Report Editor"
	nanomodule_path = /datum/nano_module/program/reports
	extended_desc = "A general paperwork viewing and editing utility."
	size = 2
	available_on_ntnet = TRUE
	requires_ntnet = FALSE
	usage_flags = PROGRAM_ALL

/datum/nano_module/program/reports
	name = "Report Editor"
	var/can_view_only = 0                              //Whether we are in view-only mode.
	var/datum/computer_file/report/selected_report     //A report being viewed/edited. This is a temporary copy.
	var/datum/computer_file/report/saved_report        //The computer file open.
	var/prog_state = REPORTS_VIEW

/datum/nano_module/program/reports/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Reports", name)
		ui.open()

/datum/nano_module/program/reports/tgui_data(mob/user)
	var/list/data = host.initial_data()
	data["prog_state"] = prog_state
	switch(prog_state)
		if(REPORTS_VIEW)
			if(selected_report)
				data["report_data"] = selected_report.generate_nano_data(get_access(user))
			data["view_only"] = can_view_only
			data["printer"] = program.computer.nano_printer
		if(REPORTS_DOWNLOAD)
			var/list/L = list()
			for(var/datum/computer_file/report/report in ntnet_global.fetch_reports(get_access(user)))
				var/M = list()
				M["name"] = report.display_name()
				M["uid"] = report.uid
				L += list(M)
			data["reports"] = L

	return data

/datum/nano_module/program/reports/proc/switch_state(new_state)
	if(prog_state == new_state)
		return
	switch(new_state)
		if(REPORTS_VIEW)
			program.requires_ntnet_feature = null
			program.requires_ntnet = FALSE
			prog_state = REPORTS_VIEW
		if(REPORTS_DOWNLOAD)
			close_report()
			program.requires_ntnet_feature = NTNET_SOFTWAREDOWNLOAD
			program.requires_ntnet = TRUE
			prog_state = REPORTS_DOWNLOAD

/datum/nano_module/program/reports/proc/close_report()
	QDEL_NULL(selected_report)
	saved_report = null

/datum/nano_module/program/reports/proc/save_report(mob/user, save_as)
	if(!program.computer || !program.computer.hard_drive)
		to_chat(user, "Unable to find hard drive.")
		return
	selected_report.rename_file()
	if(program.computer.hard_drive.store_file(selected_report))
		saved_report = selected_report
		selected_report = saved_report.clone()
		to_chat(user, "The report has been saved as [saved_report.filename].[saved_report.filetype]")
	else
		to_chat(user, "Error storing file. Please check your hard drive.")

/datum/nano_module/program/reports/proc/load_report(mob/user)
	if(!program.computer || !program.computer.hard_drive)
		to_chat(user, "Unable to find hard drive.")
		return
	var/choices = list()
	for(var/datum/computer_file/report/R in program.computer.hard_drive.stored_files)
		choices["[R.filename].[R.filetype]"] = R
	var/choice = input(user, "Which report would you like to load?", "Loading Report") as null|anything in choices
	if(choice in choices)
		var/datum/computer_file/report/chosen_report = choices[choice]
		var/editing = alert(user, "Would you like to view or edit the report", "Loading Report", "View", "Edit")
		if(editing == "View")
			if(!chosen_report.verify_access(get_access(user)))
				to_chat(user, SPAN_WARNING("You lack access to view this report."))
				return
			can_view_only = 1
		else
			if(!chosen_report.verify_access_edit(get_access(user)))
				to_chat(user, SPAN_WARNING("You lack access to edit this report."))
				return
			can_view_only = 0
		saved_report = chosen_report
		selected_report = chosen_report.clone()
		return 1

/datum/nano_module/program/reports/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return 1

	if(text2num(params["warning"]))
		if(alert(usr, "Are you sure you want to leave this page? Unsubmitted data will be lost.",, "Yes.", "No.") == "No.")
			return 1

	if(action == "load")
		if(selected_report || saved_report)
			close_report()
		load_report(usr)
		return 1
	if(action == "save")
		if(!selected_report)
			return 1
		if(!selected_report.verify_access(get_access(usr)))
			return 1
		var/save_as = text2num(params["save_as"])
		save_report(usr, save_as)
	if(action == "submit")
		if(!selected_report)
			return 1
		if(!selected_report.verify_access_edit(get_access(usr)))
			return 1
		if(selected_report.submit(usr))
			to_chat(usr, "The [src] has been submitted.")
			if(alert(usr, "Would you like to save a copy?","Save Report", "Yes.", "No.") == "Yes.")
				save_report(usr)
		return 1
	if(action == "discard")
		if(!selected_report)
			return 1
		close_report()
		return 1
	if(action == "edit")
		if(!selected_report)
			return 1
		var/field_ID = text2num(params["ID"])
		var/datum/report_field/field = selected_report.field_from_ID(field_ID)
		if(!field || !field.verify_access_edit(get_access(usr)))
			return 1
		field.ask_value(usr)
		return 1
	if(action == "print")
		if(!selected_report || !selected_report.verify_access(get_access(usr)))
			return 1
		if(!program.computer.nano_printer)
			to_chat(usr, SPAN_WARNING("Missing Hardware: Your computer does not have the required hardware to complete this operation."))
			return
		var/with_fields = text2num(params["print_mode"])
		var/text = selected_report.generate_pencode(get_access(usr), with_fields)
		if(!program.computer.nano_printer.print_text(text, selected_report.display_name()))
			to_chat(usr, "Hardware error: Printer was unable to print the file. It may be out of paper.")
		return 1
	if(action == "export")
		if(!selected_report || !selected_report.verify_access(get_access(usr)))
			return 1
		var/datum/computer_file/data/text/file = new
		selected_report.rename_file()
		file.stored_data = selected_report.generate_pencode(get_access(usr), no_html = 1)
		file.filename = selected_report.filename
		if(program.computer.hard_drive.store_file(file))
			to_chat(usr, "The report has been exported as [file.filename].[file.filetype]")
		else
			to_chat(usr, "Error storing file. Please check your hard drive.")
		return 1

	if(action == "download")
		switch_state(REPORTS_DOWNLOAD)
		return 1
	if(action == "get_report")
		var/uid = text2num(params["report"])
		for(var/datum/computer_file/report/report in ntnet_global.fetch_reports(get_access(usr)))
			if(report.uid == uid)
				selected_report = report.clone()
				can_view_only = 0
				switch_state(REPORTS_VIEW)
				return 1
		to_chat(usr, "Network error: Selected report could not be downloaded. Check network functionality and credentials.")
		return 1
	if(action == "home")
		switch_state(REPORTS_VIEW)
		return 1

#undef REPORTS_VIEW
#undef REPORTS_DOWNLOAD

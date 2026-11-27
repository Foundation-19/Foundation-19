/datum/computer_file/program/uplink
	filename = "taxquickly"
	filedesc = "TaxQuickly 1.45b"
	program_icon_state = "uplink"
	program_menu_icon = "file-invoice-dollar"
	extended_desc = "An online tax filing software. It is a few years out of date."
	size = 0 // it is cloud based
	requires_ntnet = FALSE
	available_on_ntnet = FALSE
	usage_flags = PROGRAM_PDA
	tgui_id = "TaxQuickly"

	var/password
	var/authenticated = 0
	var/entered_code = ""

/datum/computer_file/program/uplink/New(password)
	src.password = password

/datum/computer_file/program/uplink/tgui_interact(mob/user, datum/tgui/ui)
	// A real window: without one, the program switch leaves the PDA screen
	// blank until the next tick (the "black screen and exits" report).
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, tgui_id, filedesc)
		ui.set_autoupdate(FALSE)
		ui.open()

/datum/computer_file/program/uplink/tgui_data(mob/user)
	var/list/data = get_header_data()
	data["authenticated"] = authenticated
	return data

/datum/computer_file/program/uplink/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	var/obj/item/device/uplink/uplink = computer?.hidden_uplink
	switch(action)
		if("submit_code")
			var/code = params["code"]
			if(uplink && password)
				if(uplink.check_trigger(usr, code, password))
					authenticated = 1
					return TRUE
			// Decoy behavior: code wrong or no uplink — stay on the form
			// so it does not look obviously fake to other crew.
			to_chat(usr, SPAN_WARNING("Invalid tax ID. Please try again."))
			return TRUE
		if("resume")
			if(uplink && authenticated)
				uplink.trigger(usr)
				authenticated = 0
				computer.kill_program(src)
				return TRUE
		if("secure")
			authenticated = 0
			computer.kill_program(src)
			return TRUE
		if("exit")
			authenticated = 0
			computer.kill_program(src)
			return TRUE
	authenticated = 0
	return TRUE

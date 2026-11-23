/datum/computer_file/program/rcon_console
	filename = "rconconsole"
	filedesc = "RCON Remote Control"
	nanomodule_path = /datum/nano_module/rcon
	program_icon_state = "generic"
	program_key_state = "rd_key"
	program_menu_icon = "charging-station"
	extended_desc = "This program allows remote control of power distribution systems. This program can not be run on tablet computers."
	required_access = ACCESS_ENGINEERING_LVL2
	requires_ntnet = TRUE
	network_destination = "RCON remote control system"
	requires_ntnet_feature = NTNET_SYSTEMCONTROL
	usage_flags = PROGRAM_LAPTOP | PROGRAM_CONSOLE
	size = 19

/datum/nano_module/rcon
	name = "Power RCON"
	var/list/known_SMESs = null
	var/list/known_breakers = null
	// Allows you to hide specific parts of the UI
	var/hide_SMES = 0
	var/hide_SMES_details = 0
	var/hide_breakers = 0

/datum/nano_module/rcon/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "RconConsole", name)
		ui.open()

/datum/nano_module/rcon/tgui_data(mob/user)
	FindDevices()
	var/list/data = host.initial_data()

	var/list/smeslist[0]
	for(var/obj/machinery/power/smes/buildable/SMES in known_SMESs)
		smeslist.Add(list(list(
		"charge" = round(SMES.Percentage()),
		"input_set" = SMES.input_attempt,
		"input_val" = round(SMES.input_level/1000, 0.1),
		"input_load" = round(SMES.input_available/1000, 0.1),
		"output_set" = SMES.output_attempt,
		"output_val" = round(SMES.output_level/1000, 0.1),
		"output_load" = round(SMES.output_used/1000, 0.1),
		"RCON_tag" = SMES.RCon_tag
		)))

	data["smes_info"] = sortByKey(smeslist, "RCON_tag")

	var/list/breakerlist[0]
	for(var/obj/machinery/power/breakerbox/BR in known_breakers)
		breakerlist.Add(list(list(
		"RCON_tag" = BR.RCon_tag,
		"enabled" = BR.on
		)))
	data["breaker_info"] = breakerlist
	data["hide_smes"] = hide_SMES
	data["hide_smes_details"] = hide_SMES_details
	data["hide_breakers"] = hide_breakers

	return data


/datum/nano_module/rcon/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return

	if(action == "smes_in_toggle")
		var/obj/machinery/power/smes/buildable/SMES = GetSMESByTag(params["smes_in_toggle"])
		if(SMES)
			SMES.toggle_input()
	if(action == "smes_out_toggle")
		var/obj/machinery/power/smes/buildable/SMES = GetSMESByTag(params["smes_out_toggle"])
		if(SMES)
			SMES.toggle_output()
	if(action == "smes_in_set")
		var/obj/machinery/power/smes/buildable/SMES = GetSMESByTag(params["smes_in_set"])
		if(SMES)
			var/inputset = (input(usr, "Enter new input level (0-[SMES.input_level_max/1000] kW)", "SMES Input Power Control", SMES.input_level/1000) as num) * 1000
			SMES.set_input(inputset)
	if(action == "smes_out_set")
		var/obj/machinery/power/smes/buildable/SMES = GetSMESByTag(params["smes_out_set"])
		if(SMES)
			var/outputset = (input(usr, "Enter new output level (0-[SMES.output_level_max/1000] kW)", "SMES Input Power Control", SMES.output_level/1000) as num) * 1000
			SMES.set_output(outputset)

	if(action == "toggle_breaker")
		var/obj/machinery/power/breakerbox/toggle = null
		for(var/obj/machinery/power/breakerbox/breaker in known_breakers)
			if(breaker.RCon_tag == params["toggle_breaker"])
				toggle = breaker
		if(toggle)
			if(toggle.update_locked)
				to_chat(usr, "The breaker box was recently toggled. Please wait before toggling it again.")
			else
				toggle.auto_toggle()
	if(action == "hide_smes")
		hide_SMES = !hide_SMES
	if(action == "hide_smes_details")
		hide_SMES_details = !hide_SMES_details
	if(action == "hide_breakers")
		hide_breakers = !hide_breakers


// Proc: GetSMESByTag()
// Parameters: 1 (tag - RCON tag of SMES we want to look up)
// Description: Looks up and returns SMES which has matching RCON tag
/datum/nano_module/rcon/proc/GetSMESByTag(tag)
	if(!tag)
		return

	for(var/obj/machinery/power/smes/buildable/S in known_SMESs)
		if(S.RCon_tag == tag)
			return S

// Proc: FindDevices()
// Parameters: None
// Description: Refreshes local list of known devices.
/datum/nano_module/rcon/proc/FindDevices()
	known_SMESs = new /list()
	for(var/obj/machinery/power/smes/buildable/SMES in SSmachines.machinery)
		if(AreConnectedZLevels(get_host_z(), get_z(SMES)) && SMES.RCon_tag && (SMES.RCon_tag != "NO_TAG") && SMES.RCon)
			known_SMESs.Add(SMES)

	known_breakers = new /list()
	for(var/obj/machinery/power/breakerbox/breaker in SSmachines.machinery)
		if(AreConnectedZLevels(get_host_z(), get_z(breaker)) && breaker.RCon_tag != "NO_TAG")
			known_breakers.Add(breaker)

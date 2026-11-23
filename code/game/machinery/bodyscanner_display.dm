/obj/machinery/body_scan_display
	name = "Body Scan Display"
	desc = "A wall-mounted display linked to a body scanner."
	icon = 'icons/obj/modular_telescreen.dmi'
	icon_state = "operating"
	var/icon_state_unpowered = "telescreen"
	anchored = TRUE
	density = FALSE
	idle_power_usage = 75
	active_power_usage = 300
	construct_state = /decl/machine_construction/default/panel_closed
	uncreated_component_parts = null
	stat_immune = 0
	w_class = ITEM_SIZE_HUGE

	machine_name = "body scanner display"
	machine_desc = "Receives body scans from a linked body scanner and allows them to be viewed remotely."

	var/list/bodyscans = list()
	var/selected = 0

/obj/machinery/body_scan_display/proc/add_new_scan(list/scan)
	bodyscans += list(scan.Copy())
	SStgui.update_uis(src)

/obj/machinery/body_scan_display/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE

	if(action == "view")
		var/selection = text2num(params["view"])
		if(is_valid_index(selection, bodyscans))
			selected = selection
		return TRUE

	if(action == "delete")
		var/selection = text2num(params["delete"])
		if(!is_valid_index(selection, bodyscans))
			return TRUE
		if(selected == selection)
			selected = 0
		else if(selected > selection)
			selected--
		bodyscans -= list(bodyscans[selection])
		return TRUE

/obj/machinery/body_scan_display/interface_interact(user)
	tgui_interact(user)
	return TRUE

/obj/machinery/body_scan_display/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "BodyScanDisplay", "Body Scan Display Console", 600, 800)
		ui.open()

/obj/machinery/body_scan_display/tgui_data(mob/user)
	var/list/data = list()
	data["scans"] = bodyscans
	data["selected"] = selected

	if(selected > 0)
		data["scan_header"] = display_medical_data_header(bodyscans[selected], user.get_skill_value(SKILL_MEDICAL))
		data["scan_health"] = display_medical_data_health(bodyscans[selected], user.get_skill_value(SKILL_MEDICAL))
		data["scan_body"] = display_medical_data_body(bodyscans[selected], user.get_skill_value(SKILL_MEDICAL))
	else
		data["scan_header"] = "&nbsp;"
		data["scan_health"] = "&nbsp;"
		data["scan_body"] = "&nbsp;"
	return data

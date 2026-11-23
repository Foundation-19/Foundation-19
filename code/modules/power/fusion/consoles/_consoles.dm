/obj/machinery/computer/fusion
	icon_keyboard = "power_key"
	icon_screen = "rust_screen"
	light_color = COLOR_ORANGE
	idle_power_usage = 250
	active_power_usage = 500
	var/ui_template
	var/initial_id_tag

/obj/machinery/computer/fusion/Initialize()
	set_extension(src, /datum/extension/local_network_member)
	if(initial_id_tag)
		var/datum/extension/local_network_member/fusion = get_extension(src, /datum/extension/local_network_member)
		fusion.set_tag(null, initial_id_tag)
	. = ..()

/obj/machinery/computer/fusion/proc/get_local_network()
	var/datum/extension/local_network_member/fusion = get_extension(src, /datum/extension/local_network_member)
	return fusion.get_local_network()

/obj/machinery/computer/fusion/attackby(obj/item/thing, mob/user)
	if(isMultitool(thing))
		var/datum/extension/local_network_member/fusion = get_extension(src, /datum/extension/local_network_member)
		fusion.get_new_tag(user)
		return
	else
		return ..()

/obj/machinery/computer/fusion/interface_interact(mob/user)
	tgui_interact(user)
	return TRUE

/obj/machinery/computer/fusion/proc/build_ui_data()
	var/datum/extension/local_network_member/fusion = get_extension(src, /datum/extension/local_network_member)
	var/datum/local_network/lan = fusion.get_local_network()
	var/list/data = list()
	data["id"] = lan ? lan.id_tag : "unset"
	data["name"] = name
	. = data

/obj/machinery/computer/fusion/tgui_data(mob/user)
	return build_ui_data()

/obj/machinery/computer/fusion/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	// Legacy OnTopic hrefs reused as tgui actions: machine + sub-actions.
	var/href_list = params
	if(action == "toggle_active" || action == "str" || action == "toggle" || action == "modifypower" || action == "modifyrate" || action == "toggle_injecting" || action == "injection_rate" || action == "global_toggle")
		return handle_fusion_topic(href_list, action)
	return FALSE

/obj/machinery/computer/fusion/proc/handle_fusion_topic(list/href_list, action)
	// Implemented by subtypes.
	return FALSE

/obj/machinery/computer/fusion/tgui_interact(mob/user, datum/tgui/ui)
	if(ui_template)
		ui = SStgui.try_update_ui(user, src, ui)
		if (!ui)
			ui = new(user, src, "FusionConsole", name, 400, 600)
			ui.open()

/obj/machinery/embedded_controller/radio/docking_port_multi
	name = "docking port controller"
	program = /datum/computer/file/embedded_program/docking/multi
	var/child_tags_txt
	var/child_names_txt
	var/list/child_names = list()

/obj/machinery/embedded_controller/radio/docking_port_multi/Initialize()
	. = ..()
	var/list/names = splittext(child_names_txt, ";")
	var/list/tags = splittext(child_tags_txt, ";")
	if (names.len == tags.len)
		for (var/i = 1; i <= tags.len; i++)
			child_names[tags[i]] = names[i]

/obj/machinery/embedded_controller/radio/docking_port_multi/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "MultiDockingConsole", name, 470, 290)
		ui.open()

/obj/machinery/embedded_controller/radio/docking_port_multi/tgui_data(mob/user)
	var/list/data = list()
	var/datum/computer/file/embedded_program/docking/multi/docking_program = program

	var/list/airlocks = list()
	var/i = 1
	for(var/child_tag in child_names)
		airlocks[i++] = list("name"=child_names[child_tag], "override_enabled"=(docking_program.children_override[child_tag] == "enabled"))

	data = list(
		"docking_status" = docking_program.get_docking_status(),
		"airlocks" = airlocks,
	)

	return data

/obj/machinery/embedded_controller/radio/docking_port_multi/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	return TRUE

/obj/machinery/embedded_controller/radio/airlock/docking_port_multi
	name = "docking port controller"
	program = /datum/computer/file/embedded_program/airlock/multi_docking
	var/master_tag
	tag_secure = 1

/obj/machinery/embedded_controller/radio/airlock/docking_port_multi/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "DockingAirlockConsole", name, 470, 290)
		ui.open()

/obj/machinery/embedded_controller/radio/airlock/docking_port_multi/tgui_data(mob/user)
	var/list/data = list()
	var/datum/computer/file/embedded_program/airlock/multi_docking/airlock_program

	data = list(
		"chamber_pressure" = round(airlock_program.memory["chamber_sensor_pressure"]),
		"exterior_status" = airlock_program.memory["exterior_status"],
		"interior_status" = airlock_program.memory["interior_status"],
		"processing" = airlock_program.memory["processing"],
		"docking_status" = airlock_program.master_status,
		"airlock_disabled" = (airlock_program.docking_enabled && !airlock_program.override_enabled),
		"override_enabled" = airlock_program.override_enabled,
	)

	return data

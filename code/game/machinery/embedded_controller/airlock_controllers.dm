//base type for controllers of two-door systems
/obj/machinery/embedded_controller/radio/airlock
	// Setup parameters only
	radio_filter = RADIO_AIRLOCK
	program = /datum/computer/file/embedded_program/airlock
	var/tag_exterior_door
	var/tag_interior_door
	var/tag_airpump
	var/tag_chamber_sensor
	var/tag_exterior_sensor
	var/tag_interior_sensor
	var/tag_airlock_mech_sensor
	var/tag_shuttle_mech_sensor
	var/tag_secure = 0
	var/tag_air_alarm
	var/list/dummy_terminals = list()
	var/cycle_to_external_air = 0
	var/scrubber_assist = 0

/obj/machinery/embedded_controller/radio/airlock/Destroy()
	for(var/thing in dummy_terminals)
		var/obj/machinery/dummy_airlock_controller/dummy = thing
		dummy.master_controller = null
	dummy_terminals.Cut()
	return ..()

/obj/machinery/embedded_controller/radio/airlock/tgui_status(mob/user, datum/tgui_state/state)
	if(!allowed(user))
		return min(STATUS_UPDATE, ..())
	else
		return ..()

/obj/machinery/embedded_controller/radio/airlock/advanced_airlock_controller
	name = "Advanced Airlock Controller"

/obj/machinery/embedded_controller/radio/airlock/advanced_airlock_controller/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AdvancedAirlockConsole", name, 470, 290)
		ui.open()

/obj/machinery/embedded_controller/radio/airlock/advanced_airlock_controller/tgui_data(mob/user)
	var/list/data = list()

	data = list(
		"chamber_pressure" = round(program.memory["chamber_sensor_pressure"]),
		"external_pressure" = round(program.memory["external_sensor_pressure"]),
		"internal_pressure" = round(program.memory["internal_sensor_pressure"]),
		"processing" = program.memory["processing"],
		"purge" = program.memory["purge"],
		"secure" = program.memory["secure"]
	)

	return data

/obj/machinery/embedded_controller/radio/airlock/airlock_controller
	name = "Airlock Controller"
	tag_secure = 1

/obj/machinery/embedded_controller/radio/airlock/airlock_controller/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SimpleAirlockConsole", name, 470, 290)
		ui.open()

/obj/machinery/embedded_controller/radio/airlock/airlock_controller/tgui_data(mob/user)
	var/list/data = list()

	data = list(
		"chamber_pressure" = round(program.memory["chamber_sensor_pressure"]),
		"exterior_status" = program.memory["exterior_status"],
		"interior_status" = program.memory["interior_status"],
		"processing" = program.memory["processing"],
	)

	return data

/obj/machinery/embedded_controller/radio/airlock/access_controller
	icon = 'icons/obj/airlock_machines.dmi'
	name = "Access Controller"
	tag_secure = 1

/obj/machinery/embedded_controller/radio/airlock/access_controller/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "DoorAccessConsole", name, 330, 220)
		ui.open()

/obj/machinery/embedded_controller/radio/airlock/access_controller/tgui_data(mob/user)
	var/list/data = list()

	data = list(
		"exterior_status" = program.memory["exterior_status"],
		"interior_status" = program.memory["interior_status"],
		"processing" = program.memory["processing"]
	)

	return data

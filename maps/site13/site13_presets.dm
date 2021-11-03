var/const/NETWORK_FIRST_FLOOR  = "Surface"
var/const/NETWORK_SECOND_FLOOR = "LCZ Floor"
var/const/NETWORK_SUPPLY      = "Supply"
var/const/NETWORK_THIRD_FLOOR  = "HCZ Floor"
var/const/NETWORK_COMMAND  = "Administration"

/datum/map/site13
	// Networks that will show up as options in the camera monitor program
	station_networks = list(
		NETWORK_FIRST_FLOOR,
		NETWORK_SECOND_FLOOR,
		NETWORK_THIRD_FLOOR,
		NETWORK_COMMAND,
		NETWORK_ENGINEERING,
		NETWORK_MEDICAL,
		NETWORK_RESEARCH,
		NETWORK_SECURITY,
		NETWORK_SUPPLY,
		NETWORK_ALARM_ATMOS,
		NETWORK_ALARM_CAMERA,
		NETWORK_ALARM_FIRE,
		NETWORK_ALARM_MOTION,
		NETWORK_ALARM_POWER,
	)

/obj/machinery/camera/network/first_floor
	network = list(NETWORK_FIRST_FLOOR)

/obj/machinery/camera/network/second_floor
	network = list(NETWORK_SECOND_FLOOR)

/obj/machinery/camera/network/supply
	network = list(NETWORK_SUPPLY)

/obj/machinery/camera/network/third_floor
	network = list(NETWORK_THIRD_FLOOR)

/obj/machinery/camera/network/command
	network = list(NETWORK_COMMAND)

// Substation SMES
/obj/machinery/power/smes/buildable/preset/site13/substation
	uncreated_component_parts = list(/obj/item/stock_parts/smes_coil = 1) // Note that it gets one more from construction
	_input_maxed = TRUE
	_output_maxed = TRUE

// Substation SMES (charged and with full I/O setting)
/obj/machinery/power/smes/buildable/preset/site13/substation_full
	uncreated_component_parts = list(/obj/item/stock_parts/smes_coil = 1)
	_input_maxed = TRUE
	_output_maxed = TRUE
	_input_on = TRUE
	_output_on = TRUE
	_fully_charged = TRUE

// Main Engine output SMES
/obj/machinery/power/smes/buildable/preset/site13/engine_main
	uncreated_component_parts = list(
		/obj/item/stock_parts/smes_coil/super_io = 2,
		/obj/item/stock_parts/smes_coil/super_capacity = 2)
	_input_maxed = TRUE
	_output_maxed = TRUE
	_input_on = TRUE
	_output_on = TRUE
	_fully_charged = TRUE

// Shuttle SMES
/obj/machinery/power/smes/buildable/preset/site13/shuttle
	uncreated_component_parts = list(
		/obj/item/stock_parts/smes_coil/super_io = 1,
		/obj/item/stock_parts/smes_coil/super_capacity = 1)
	_input_maxed = TRUE
	_output_maxed = TRUE
	_input_on = TRUE
	_output_on = TRUE
	_fully_charged = TRUE

// Hangar SMES. Charges the shuttles so needs a pretty big throughput.
/obj/machinery/power/smes/buildable/preset/site13/hangar
	uncreated_component_parts = list(
		/obj/item/stock_parts/smes_coil/super_io = 2)
	_input_maxed = TRUE
	_output_maxed = TRUE
	_input_on = TRUE
	_output_on = TRUE
	_fully_charged = TRUE

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
/obj/machinery/power/smes/buildable/preset/site13/substation/configure_and_install_coils()
	component_parts += new /obj/item/weapon/smes_coil(src)
	component_parts += new /obj/item/weapon/smes_coil(src)
	_input_maxed = TRUE
	_output_maxed = TRUE

// Substation SMES (charged and with full I/O setting)
/obj/machinery/power/smes/buildable/preset/site13/substation_full/configure_and_install_coils()
	component_parts += new /obj/item/weapon/smes_coil(src)
	component_parts += new /obj/item/weapon/smes_coil(src)
	_input_maxed = TRUE
	_output_maxed = TRUE
	_input_on = TRUE
	_output_on = TRUE
	_fully_charged = TRUE

// Main Engine output SMES
/obj/machinery/power/smes/buildable/preset/site13/engine_main/configure_and_install_coils()
	component_parts += new /obj/item/weapon/smes_coil/super_io(src)
	component_parts += new /obj/item/weapon/smes_coil/super_io(src)
	component_parts += new /obj/item/weapon/smes_coil/super_capacity(src)
	component_parts += new /obj/item/weapon/smes_coil/super_capacity(src)
	_input_maxed = TRUE
	_output_maxed = TRUE
	_input_on = TRUE
	_output_on = TRUE
	_fully_charged = TRUE

// Shuttle SMES
/obj/machinery/power/smes/buildable/preset/site13/shuttle/configure_and_install_coils()
	component_parts += new /obj/item/weapon/smes_coil/super_io(src)
	_input_maxed = TRUE
	_output_maxed = TRUE
	_input_on = TRUE
	_output_on = TRUE
	_fully_charged = TRUE

// Hangar SMES. Charges the shuttles so needs a pretty big throughput.
/obj/machinery/power/smes/buildable/preset/site13/hangar/configure_and_install_coils()
	component_parts += new /obj/item/weapon/smes_coil/super_io(src)
	component_parts += new /obj/item/weapon/smes_coil/super_io(src)
	_input_maxed = TRUE
	_output_maxed = TRUE
	_input_on = TRUE
	_output_on = TRUE
	_fully_charged = TRUE

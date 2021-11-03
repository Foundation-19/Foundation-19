var/const/NETWORK_ENGINE		= "Engineering Network"
var/const/NETWORK_ENTRANCE		= "Entrance Zone Network"
var/const/NETWORK_LCZ			= "Light Containment Zone Network"
var/const/NETWORK_HCZ			= "Heavy Containment Zone Network"
var/const/NETWORK_513			= "SCP-513 CCTV Network"
var/const/NETWORK_049			= "SCP-049 CCTV Network"
var/const/NETWORK_106			= "SCP-106 CCTV Network"
var/const/NETWORK_173			= "SCP-173 CCTV Network"
var/const/NETWORK_012			= "SCP-012 CCTV Network"
var/const/NETWORK_895			= "SCP-895 CCTV Network (CAUTION!)"

/datum/map/site53/get_network_access(var/network)
	switch(network)
		if(NETWORK_ENGINE, NETWORK_ENTRANCE, NETWORK_LCZ, NETWORK_HCZ)
			return access_mtflvl1
		if(NETWORK_513, NETWORK_049, NETWORK_106, NETWORK_173, NETWORK_012)
			return access_sciencelvl1
		if(NETWORK_895)
			return access_sciencelvl3
	return ..()

/datum/map/site53
	// Networks that will show up as options in the camera monitor program
	station_networks = list(
		NETWORK_ENGINE,
		NETWORK_ENTRANCE,
		NETWORK_LCZ,
		NETWORK_HCZ,
		NETWORK_513,
		NETWORK_049,
		NETWORK_106,
		NETWORK_173,
		NETWORK_012,
		NETWORK_895
	)

//
// Cameras
//

// Networks
/obj/machinery/camera/network/scp173
	network = list(NETWORK_173)

/obj/machinery/camera/network/scp012
	network = list(NETWORK_012)

/obj/machinery/camera/network/scp106
	network = list(NETWORK_106)

/obj/machinery/camera/network/scp049
	network = list(NETWORK_049)

/obj/machinery/camera/network/scp513
	network = list(NETWORK_513)

/obj/machinery/camera/network/engine
	network = list(NETWORK_ENGINE)

/obj/machinery/camera/network/entrance
	network = list(NETWORK_ENTRANCE)

/obj/machinery/camera/network/lcz
	network = list(NETWORK_LCZ)

/obj/machinery/camera/network/hcz
	network = list(NETWORK_HCZ)

/obj/machinery/camera/network/scp895
	network = list(NETWORK_895)

// Substation SMES
/obj/machinery/power/smes/buildable/preset/ds90/substation
	uncreated_component_parts = list(/obj/item/stock_parts/smes_coil = 1) // Note that it gets one more from construction
	_input_maxed = TRUE
	_output_maxed = TRUE

// Substation SMES (charged and with full I/O setting)
/obj/machinery/power/smes/buildable/preset/ds90/substation_full
	uncreated_component_parts = list(/obj/item/stock_parts/smes_coil = 1)
	_input_maxed = TRUE
	_output_maxed = TRUE
	_input_on = TRUE
	_output_on = TRUE
	_fully_charged = TRUE

// Main Engine output SMES
/obj/machinery/power/smes/buildable/preset/ds90/engine_main
	uncreated_component_parts = list(
		/obj/item/weapon/smes_coil/super_io = 2,
		/obj/item/weapon/smes_coil/super_capacity = 2
	)
	_input_maxed = TRUE
	_output_maxed = TRUE
	_input_on = TRUE
	_output_on = TRUE
	_fully_charged = TRUE

// Shuttle SMES
/obj/machinery/power/smes/buildable/preset/ds90/shuttle
	uncreated_component_parts = list(/obj/item/stock_parts/smes_coil/super_io = 1)
	_input_maxed = TRUE
	_output_maxed = TRUE
	_input_on = TRUE
	_output_on = TRUE
	_fully_charged = TRUE

// Hangar SMES. Charges the shuttles so needs a pretty big throughput.
/obj/machinery/power/smes/buildable/preset/ds90/hangar
	uncreated_component_parts = list(/obj/item/stock_parts/smes_coil/super_io = 2)
	_input_maxed = TRUE
	_output_maxed = TRUE
	_input_on = TRUE
	_output_on = TRUE
	_fully_charged = TRUE

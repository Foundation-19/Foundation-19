#define NETWORK_ADMIN "Administration Department Network"
#define NETWORK_ENGINE "Engineering Department Network"
#define NETWORK_LOGISTICS "Logistics Department Network"

#define NETWORK_EZ "Entrance Zone Network"
#define NETWORK_SCI "Research Department Network"
#define NETWORK_MED "Medical Department Network"
#define NETWORK_SERVICE "Service Department Network"

#define NETWORK_LCZ "Light Containment Zone Network"
#define NETWORK_012 "SCP-012 CCTV Network"
#define NETWORK_173 "SCP-173 CCTV Network"
#define NETWORK_343 "SCP-343 CCTV Network"
#define NETWORK_513 "SCP-513 CCTV Network"
#define NETWORK_529 "SCP-529 CCTV Network"
#define NETWORK_999 "SCP-999 CCTV Network"

#define NETWORK_HCZ "Heavy Containment Zone Network"
#define NETWORK_008 "SCP-008 CCTV Network"
#define NETWORK_017 "SCP-017 CCTV Network"
#define NETWORK_035 "SCP-035 CCTV Network"
#define NETWORK_049 "SCP-049 CCTV Network"
#define NETWORK_082 "SCP-082 CCTV Network"
#define NETWORK_096 "SCP-096 CCTV Network"
#define NETWORK_106 "SCP-106 CCTV Network"
#define NETWORK_247 "SCP-247 CCTV Network"
#define NETWORK_280 "SCP-280 CCTV Network"
#define NETWORK_457 "SCP-457 CCTV Network"
#define NETWORK_895 "SCP-895 CCTV Network"
#define NETWORK_2427 "SCP-2427-3 CCTV Network"

/datum/map/site404/get_network_access(network)
	switch(network)
		if(list(
			(NETWORK_ADMIN),
			(NETWORK_LOGISTICS)
		))
			return ACCESS_ADMIN_LVL1

		if (NETWORK_ENGINE)
			return ACCESS_ENGINEERING_LVL1

		if (NETWORK_MED)
			return ACCESS_MEDICAL_LVL1

		if(NETWORK_SCI)
			return ACCESS_SCIENCE_LVL1

		if(list(
			(NETWORK_EZ),
			(NETWORK_LCZ),
			(NETWORK_012),
			(NETWORK_173),
			(NETWORK_343),
			(NETWORK_513),
			(NETWORK_529),
			(NETWORK_895), // Intentionally LVL1 Access, let people across the site vomit when their curiousity gets the better of them.
			(NETWORK_999)
		))
			return ACCESS_SECURITY_LVL1

		if(list(
			(NETWORK_HCZ),
			(NETWORK_008),
			(NETWORK_017),
			(NETWORK_035),
			(NETWORK_049),
			(NETWORK_082),
			(NETWORK_096),
			(NETWORK_106),
			(NETWORK_247),
			(NETWORK_280),
			(NETWORK_457),
			(NETWORK_895),
			(NETWORK_2427)
		))
			return ACCESS_SECURITY_LVL3

	return get_shared_network_access(network) || ..()

/datum/map/site404
	// Networks that will show up as options in the camera monitor program
	station_networks = list(
			NETWORK_ADMIN,
			NETWORK_ENGINE,
			NETWORK_LOGISTICS,
			NETWORK_EZ,
			NETWORK_SCI,
			NETWORK_MED,
			NETWORK_SERVICE,
			NETWORK_LCZ,
			NETWORK_012,
			NETWORK_173,
			NETWORK_343,
			NETWORK_513,
			NETWORK_529,
			NETWORK_999,
			NETWORK_HCZ,
			NETWORK_008,
			NETWORK_017,
			NETWORK_035,
			NETWORK_049,
			NETWORK_082,
			NETWORK_096,
			NETWORK_106,
			NETWORK_247,
			NETWORK_280,
			NETWORK_457,
			NETWORK_895,
			NETWORK_2427
		)

//
// Cameras
//

// Networks
/obj/machinery/camera/network/department/administrationzone
	network = list(NETWORK_ADMIN)

/obj/machinery/camera/network/department/engineeringdepartment
	network = list(NETWORK_ENGINE)

/obj/machinery/camera/network/department/logisticsdepartment
	network = list(NETWORK_LOGISTICS)

/obj/machinery/camera/network/department/entrancezone
	network = list(NETWORK_EZ)

/obj/machinery/camera/network/department/sciencedepartment
	network = list(NETWORK_SCI)

/obj/machinery/camera/network/department/medicaldepartment
	network = list(NETWORK_MED)

/obj/machinery/camera/network/department/servicedepartment
	network = list(NETWORK_SERVICE)

/obj/machinery/camera/network/department/lightcontainmentzone
	network = list(NETWORK_LCZ)

/obj/machinery/camera/network/containmentunit/scp012
	network = list(NETWORK_012)

/obj/machinery/camera/network/containmentunit/scp173
	network = list(NETWORK_173)

/obj/machinery/camera/network/containmentunit/scp343
	network = list(NETWORK_343)

/obj/machinery/camera/network/containmentunit/scp513
	network = list(NETWORK_513)

/obj/machinery/camera/network/containmentunit/scp529
	network = list(NETWORK_529)

/obj/machinery/camera/network/containmentunit/scp999
	network = list(NETWORK_999)

/obj/machinery/camera/network/department/heavycontainmentunit
	network = list(NETWORK_HCZ)

/obj/machinery/camera/network/containmentunit/scp008
	network = list(NETWORK_008)

/obj/machinery/camera/network/containmentunit/scp017
	network = list(NETWORK_017)

/obj/machinery/camera/network/containmentunit/scp035
	network = list(NETWORK_035)

/obj/machinery/camera/network/containmentunit/scp049
	network = list(NETWORK_049)

/obj/machinery/camera/network/containmentunit/scp082
	network = list(NETWORK_082)

/obj/machinery/camera/network/containmentunit/scp096
	network = list(NETWORK_096)

/obj/machinery/camera/network/containmentunit/scp106
	network = list(NETWORK_106)

/obj/machinery/camera/network/containmentunit/scp247
	network = list(NETWORK_247)

/obj/machinery/camera/network/containmentunit/scp280
	network = list(NETWORK_280)

/obj/machinery/camera/network/containmentunit/scp457
	network = list(NETWORK_457)

/obj/machinery/camera/network/containmentunit/scp895
	network = list(NETWORK_895)

/obj/machinery/camera/network/containmentunit/scp2427
	network = list(NETWORK_2427)

/datum/map/proc/get_shared_network_access(network)
	switch(network)
		if(NETWORK_ENGINE)
			return ACCESS_ENGINEERING_LVL1

// Substation SMES

//Standard Performance SMES presets.
/obj/machinery/power/smes/buildable/preset/site404/standard/empty_off/configure_and_install_coils()
	component_parts += new /obj/item/stock_parts/smes_coil(src)
	component_parts += new /obj/item/stock_parts/smes_coil(src)
	_input_maxed = TRUE
	_output_maxed = TRUE

/obj/machinery/power/smes/buildable/preset/site404/standard/empty_on/configure_and_install_coils()
	component_parts += new /obj/item/stock_parts/smes_coil(src)
	component_parts += new /obj/item/stock_parts/smes_coil(src)
	_input_maxed = TRUE
	_output_maxed = TRUE
	_input_on = TRUE
	_output_on = TRUE

/obj/machinery/power/smes/buildable/preset/site404/standard/full_off/configure_and_install_coils()
	component_parts += new /obj/item/stock_parts/smes_coil(src)
	component_parts += new /obj/item/stock_parts/smes_coil(src)
	_input_maxed = TRUE
	_output_maxed = TRUE
	_fully_charged = TRUE

/obj/machinery/power/smes/buildable/preset/site404/standard/full_on/configure_and_install_coils()
	component_parts += new /obj/item/stock_parts/smes_coil(src)
	component_parts += new /obj/item/stock_parts/smes_coil(src)
	_input_maxed = TRUE
	_output_maxed = TRUE
	_input_on = TRUE
	_output_on = TRUE
	_fully_charged = TRUE

// Above-Standard Performance SMES presets.
/obj/machinery/power/smes/buildable/preset/site404/advanced/empty_off/configure_and_install_coils()
	component_parts += new /obj/item/stock_parts/smes_coil/super_io(src)
	component_parts += new /obj/item/stock_parts/smes_coil/super_capacity(src)
	_input_maxed = TRUE
	_output_maxed = TRUE

/obj/machinery/power/smes/buildable/preset/site404/advanced/empty_on/configure_and_install_coils()
	component_parts += new /obj/item/stock_parts/smes_coil/super_io(src)
	component_parts += new /obj/item/stock_parts/smes_coil/super_capacity(src)
	_input_maxed = TRUE
	_output_maxed = TRUE
	_input_on = TRUE
	_output_on = TRUE

/obj/machinery/power/smes/buildable/preset/site404/advanced/full_off/configure_and_install_coils()
	component_parts += new /obj/item/stock_parts/smes_coil/super_io(src)
	component_parts += new /obj/item/stock_parts/smes_coil/super_capacity(src)
	_input_maxed = TRUE
	_output_maxed = TRUE
	_fully_charged = TRUE

/obj/machinery/power/smes/buildable/preset/site404/advanced/full_on/configure_and_install_coils()
	component_parts += new /obj/item/stock_parts/smes_coil/super_io(src)
	component_parts += new /obj/item/stock_parts/smes_coil/super_capacity(src)
	_input_maxed = TRUE
	_output_maxed = TRUE
	_input_on = TRUE
	_output_on = TRUE
	_fully_charged = TRUE

// Main Engine output SMES
/obj/machinery/power/smes/buildable/preset/site404/critical/full_off/configure_and_install_coils()
	component_parts += new /obj/item/stock_parts/smes_coil/super_io(src)
	component_parts += new /obj/item/stock_parts/smes_coil/super_io(src)
	component_parts += new /obj/item/stock_parts/smes_coil/super_capacity(src)
	component_parts += new /obj/item/stock_parts/smes_coil/super_capacity(src)
	_input_maxed = TRUE
	_output_maxed = TRUE
	_fully_charged = TRUE

/obj/machinery/power/smes/buildable/preset/site404/critical/full_on/configure_and_install_coils()
	component_parts += new /obj/item/stock_parts/smes_coil/super_io(src)
	component_parts += new /obj/item/stock_parts/smes_coil/super_io(src)
	component_parts += new /obj/item/stock_parts/smes_coil/super_capacity(src)
	component_parts += new /obj/item/stock_parts/smes_coil/super_capacity(src)
	_input_maxed = TRUE
	_output_maxed = TRUE
	_input_on = TRUE
	_output_on = TRUE
	_fully_charged = TRUE

// Override and implement to customize the SMES's loadout
/obj/machinery/power/smes/buildable/preset/proc/configure_and_install_coils()
	CRASH("configure_and_install_coils() not implemented for type [type]!")


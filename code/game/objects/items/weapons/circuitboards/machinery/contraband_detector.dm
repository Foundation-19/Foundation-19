/obj/item/stock_parts/circuitboard/contraband_detector
	name = T_BOARD("contraband detector")
	build_path = /obj/machinery/contraband_detector
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_MATERIAL)
	req_components = list(
							/obj/item/stack/cable_coil = 2,
							/obj/item/stock_parts/scanning_module = 1,
							/obj/item/device/assembly/prox_sensor = 1)
	additional_spawn_components = list()

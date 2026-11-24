/obj/machinery/computer/area_atmos
	name = "Area Air Control"
	desc = "A computer used to control the stationary scrubbers and pumps in the area."
	icon_keyboard = "atmos_key"
	icon_screen = "area_atmos"
	light_color = "#e6ffff"
	machine_name = "area air control console"
	machine_desc = "A larger and less complex form of air alarm that allows configuration of an area's vents and scrubbers."

	var/list/connectedscrubbers = new()
	var/status = ""

	var/range = 25

	//Simple variable to prevent me from doing attack_hand in both this and the child computer
	var/zone = "This computer is working on a wireless range, the range is currently limited to 25 meters."

/obj/machinery/computer/area_atmos/New()
	. = ..()
	//So the scrubbers have time to spawn
	spawn(10)
		scanscrubbers()

/obj/machinery/computer/area_atmos/interface_interact(mob/user)
	tgui_interact(user)
	return TRUE

/obj/machinery/computer/area_atmos/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AreaAtmosComputer", "Area Air Control")
		ui.open()

/obj/machinery/computer/area_atmos/tgui_data(mob/user)
	var/list/data = list()
	data["status"] = status
	status = ""
	data["zone"] = zone
	var/list/scrubbers = list()
	for(var/obj/machinery/portable_atmospherics/powered/scrubber/huge/scrubber in connectedscrubbers)
		scrubbers += list(list(
			"ref" = "\ref[scrubber]",
			"name" = scrubber.name,
			"pressure" = round(scrubber.air_contents.return_pressure(), 0.01),
			"flow_rate" = round(scrubber.last_flow_rate, 0.1),
			"power_draw" = round(scrubber.last_power_draw),
			"on" = scrubber.use_power > POWER_USE_OFF ? TRUE : FALSE
		))
	data["scrubbers"] = scrubbers
	return data

/obj/machinery/computer/area_atmos/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	switch(action)
		if("scan")
			scanscrubbers()
			return TRUE
		if("toggle")
			var/obj/machinery/portable_atmospherics/powered/scrubber/huge/scrubber = locate(params["scrub"])
			if(!validscrubber(scrubber))
				spawn(20)
					status = "ERROR: Couldn't connect to scrubber! (timeout)"
					connectedscrubbers -= scrubber
					SStgui.update_uis(src)
				return TRUE
			scrubber.update_use_power(text2num(params["toggle"]) ? POWER_USE_ACTIVE : POWER_USE_IDLE)
			scrubber.update_icon()
			return TRUE
	return FALSE

/obj/machinery/computer/area_atmos/proc/validscrubber( obj/machinery/portable_atmospherics/powered/scrubber/huge/scrubber as obj )
	if(!isobj(scrubber) || get_dist(scrubber.loc, src.loc) > src.range || scrubber.loc.z != src.loc.z)
		return 0

	return 1

/obj/machinery/computer/area_atmos/proc/scanscrubbers()
	connectedscrubbers = new()

	var/found = 0
	for(var/obj/machinery/portable_atmospherics/powered/scrubber/huge/scrubber in range(range, src.loc))
		if(istype(scrubber))
			found = 1
			connectedscrubbers += scrubber

	if(!found)
		status = "ERROR: No scrubber found!"

	SStgui.update_uis(src)


/obj/machinery/computer/area_atmos/area
	zone = "This computer is working in a wired network limited to this area."

/obj/machinery/computer/area_atmos/area/validscrubber( obj/machinery/portable_atmospherics/powered/scrubber/huge/scrubber as obj )
	if(!isobj(scrubber))
		return 0

	/*
	wow this is stupid, someone help me
	*/
	var/turf/T_src = get_turf(src)
	if(!T_src.loc) return 0
	var/area/A_src = T_src.loc

	var/turf/T_scrub = get_turf(scrubber)
	if(!T_scrub.loc) return 0
	var/area/A_scrub = T_scrub.loc

	if(A_scrub != A_src)
		return 0

	return 1

/obj/machinery/computer/area_atmos/area/scanscrubbers()
	connectedscrubbers = new()

	var/found = 0

	var/turf/T = get_turf(src)
	if(!T.loc) return
	var/area/A = T.loc
	for(var/obj/machinery/portable_atmospherics/powered/scrubber/huge/scrubber in world )
		var/turf/T2 = get_turf(scrubber)
		if(T2 && T2.loc)
			var/area/A2 = T2.loc
			if(istype(A2) && A2 == A)
				connectedscrubbers += scrubber
				found = 1


	if(!found)
		status = "ERROR: No scrubber found!"

	SStgui.update_uis(src)

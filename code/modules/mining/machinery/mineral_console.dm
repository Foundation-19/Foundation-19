/obj/machinery/computer/mining
	name = "ore processing console"
	icon = 'icons/obj/machines/mining_machines.dmi'
	icon_state = "console"
	machine_name = "mineral processing console"
	machine_desc = "Used to configure and operate a linked ore processor, and capable of processing minerals in a variety of fashions."
	var/obj/machinery/mineral/connected

/obj/machinery/computer/mining/interface_interact(mob/user)
	tgui_interact(user)
	return TRUE

/obj/machinery/computer/mining/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "MineralConsole", "[src] Control Panel")
		ui.open()

/obj/machinery/computer/mining/tgui_data(mob/user)
	var/list/data = list()
	data["connected"] = connected ? TRUE : FALSE
	if(!connected)
		return data
	data["connected_name"] = connected.name
	data["input"] = connected.input_turf ? dir2text(get_dir(connected, connected.input_turf)) : null
	data["output"] = connected.output_turf ? dir2text(get_dir(connected, connected.output_turf)) : null
	if(istype(connected, /obj/machinery/mineral/processing_unit))
		var/obj/machinery/mineral/processing_unit/P = connected
		data["kind"] = "processor"
		data["active"] = P.active ? TRUE : FALSE
		data["report_all"] = P.report_all_ores ? TRUE : FALSE
		var/list/ores = list()
		for(var/ore in P.ores_processing)
			if(!P.ores_stored[ore] && !P.report_all_ores)
				continue
			var/material/M = SSmaterials.get_material_by_name(ore)
			if(!M)
				continue
			var/mode = P.ores_processing[ore]
			var/mode_text = "Not processing"
			switch(mode)
				if(1)
					mode_text = "Smelting"
				if(2)
					mode_text = "Compressing"
				if(3)
					mode_text = "Alloying"
			ores += list(list(
				"name" = capitalize(M.display_name),
				"ref" = ore,
				"sheets" = Floor(P.ores_stored[ore] / M.units_per_sheet),
				"units" = P.ores_stored[ore],
				"mode" = mode,
				"mode_text" = mode_text
			))
		data["ores"] = ores
	else if(istype(connected, /obj/machinery/mineral/stacking_machine))
		var/obj/machinery/mineral/stacking_machine/S = connected
		data["kind"] = "stacker"
		data["stack_amt"] = S.stack_amt
		var/list/stacks = list()
		for(var/stacktype in S.stacks)
			if(S.stacks[stacktype] <= 0)
				continue
			stacks += list(list(
				"name" = capitalize(stacktype),
				"amount" = S.stacks[stacktype],
				"ref" = stacktype
			))
		data["stacks"] = stacks
	else
		data["kind"] = "generic"
	return data

/obj/machinery/computer/mining/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	switch(action)
		if("scan_for_machine")
			for(var/c in GLOB.alldirs)
				var/turf/T = get_step(loc, c)
				if(T)
					var/obj/machinery/mineral/M = locate(/obj/machinery/mineral) in T
					if(M && ispath(M.console) && istype(src, M.console))
						M.console = src
						connected = M
						break
			return TRUE
		if("configure_input_output")
			if(connected)
				connected.Topic(list("configure_input_output" = 1), list("configure_input_output" = 1))
			return TRUE
		if("toggle_smelting")
			if(connected)
				connected.Topic(list("toggle_smelting" = params["ore"]), list("toggle_smelting" = params["ore"]))
			return TRUE
		if("toggle_power")
			if(connected)
				connected.Topic(list("toggle_power" = 1), list("toggle_power" = 1))
			return TRUE
		if("toggle_ores")
			if(connected)
				connected.Topic(list("toggle_ores" = 1), list("toggle_ores" = 1))
			return TRUE
		if("change_stack")
			if(connected)
				connected.Topic(list("change_stack" = 1), list("change_stack" = 1))
			return TRUE
		if("release_stack")
			if(connected)
				connected.Topic(list("release_stack" = params["stack"]), list("release_stack" = params["stack"]))
			return TRUE
	return FALSE

/obj/machinery/computer/mining/Destroy()
	if(connected)
		if(connected.console == src)
			connected.console = initial(connected.console)
		connected = null
	. = ..()

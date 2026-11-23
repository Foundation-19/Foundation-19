//Engine control and monitoring console

/obj/machinery/computer/ship/engines
	name = "engine control console"
	icon_keyboard = "tech_key"
	icon_screen = "engines"
	machine_name = "engine control console"
	machine_desc = "Allows remote control of a spacecraft's gas thrusters, and displays information about remaining fuel."
	var/display_state = "status"

/obj/machinery/computer/ship/engines/tgui_interact(mob/user, datum/tgui/ui)
	if(!linked)
		display_reconnect_dialog(user, "ship control systems")
		return

	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "OvermapEngineControl", "[linked.name] Engines Control", 390, 530)
		ui.open()

/obj/machinery/computer/ship/engines/tgui_data(mob/user)
	var/list/data = list()
	data["state"] = display_state
	data["global_state"] = linked.engines_state
	data["global_limit"] = round(linked.thrust_limit*100)
	var/total_thrust = 0

	var/list/enginfo = list()
	for(var/datum/ship_engine/E in linked.engines)
		var/list/rdata = list()
		rdata["eng_type"] = E.name
		rdata["eng_on"] = E.is_on()
		rdata["eng_thrust"] = E.get_thrust()
		rdata["eng_thrust_limiter"] = round(E.get_thrust_limit()*100)
		rdata["eng_status"] = E.get_status()
		rdata["eng_reference"] = "\ref[E]"
		total_thrust += E.get_thrust()
		enginfo += list(rdata)

	data["engines_info"] = enginfo
	data["total_thrust"] = total_thrust
	return data

/obj/machinery/computer/ship/engines/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE

	if(action == "state")
		display_state = params["state"]
		return TRUE

	if(action == "global_toggle")
		linked.engines_state = !linked.engines_state
		for(var/datum/ship_engine/E in linked.engines)
			if(linked.engines_state == !E.is_on())
				E.toggle()
		return TRUE

	if(action == "set_global_limit")
		var/newlim = input("Input new thrust limit (0..100%)", "Thrust limit", linked.thrust_limit*100) as num
		if(!CanInteract(usr, state))
			return
		linked.thrust_limit = Clamp(newlim/100, 0, 1)
		for(var/datum/ship_engine/E in linked.engines)
			E.set_thrust_limit(linked.thrust_limit)
		return TRUE

	if(action == "global_limit")
		linked.thrust_limit = Clamp(linked.thrust_limit + text2num(params["global_limit"]), 0, 1)
		for(var/datum/ship_engine/E in linked.engines)
			E.set_thrust_limit(linked.thrust_limit)
		return TRUE

	if(action == "engine")
		if(params["set_limit"])
			var/datum/ship_engine/E = locate(params["engine"])
			var/newlim = input("Input new thrust limit (0..100)", "Thrust limit", E.get_thrust_limit()) as num
			if(!CanInteract(usr, state))
				return
			var/limit = Clamp(newlim/100, 0, 1)
			if(istype(E))
				E.set_thrust_limit(limit)
			return TRUE
		if(params["limit"])
			var/datum/ship_engine/E = locate(params["engine"])
			var/limit = Clamp(E.get_thrust_limit() + text2num(params["limit"]), 0, 1)
			if(istype(E))
				E.set_thrust_limit(limit)
			return TRUE

		if(params["toggle"])
			var/datum/ship_engine/E = locate(params["engine"])
			if(istype(E))
				E.toggle()
			return TRUE
		return TRUE
	return FALSE

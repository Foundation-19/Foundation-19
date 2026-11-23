/obj/machinery/computer/fusion/fuel_control
	name = "fuel injection control computer"
	icon_keyboard = "rd_key"
	icon_screen = "fuel_screen"
	ui_template = "fusion_injector_control.tmpl"

/obj/machinery/computer/fusion/fuel_control/handle_fusion_topic(list/href_list, action)
	var/datum/local_network/lan = get_local_network()
	if(!lan)
		return FALSE
	var/list/fuel_injectors = lan.get_devices(/obj/machinery/fusion_fuel_injector)

	if(action == "global_toggle")
		if(!fuel_injectors)
			return FALSE
		for(var/obj/machinery/fusion_fuel_injector/F in fuel_injectors)
			if(F.injecting)
				F.StopInjecting()
			else
				F.BeginInjecting()
		return TRUE

	if(action == "toggle_injecting" || action == "injection_rate")
		var/obj/machinery/fusion_fuel_injector/I = locate(href_list["machine"])
		if(!istype(I) || !fuel_injectors || !fuel_injectors[I])
			return FALSE

		if(action == "toggle_injecting")
			if(I.injecting)
				I.StopInjecting()
			else
				I.BeginInjecting()

		if(action == "injection_rate")
			var/new_injection_rate = input(usr, "Enter a new injection rate between 0 and 100", "Modifying injection rate", I.injection_rate * 100) as num
			if(!new_injection_rate)
				to_chat(usr, SPAN_WARNING("That's not a valid injection rate."))
				return FALSE
			I.injection_rate = Clamp(new_injection_rate, 0, 100) / 100
		return TRUE

	return FALSE

/obj/machinery/computer/fusion/fuel_control/build_ui_data()
	. = ..()
	var/datum/extension/local_network_member/fusion = get_extension(src, /datum/extension/local_network_member)
	var/datum/local_network/lan = fusion.get_local_network()
	var/list/injectors = list()
	if(lan)
		var/list/fuel_injectors = lan.get_devices(/obj/machinery/fusion_fuel_injector)
		for(var/i = 1 to LAZYLEN(fuel_injectors))
			var/list/injector = list()
			var/obj/machinery/fusion_fuel_injector/I = fuel_injectors[i]
			injector["id"] =       "#[i]"
			injector["ref"] =       "\ref[I]"
			injector["injecting"] =  I.injecting
			injector["fueltype"] =  "[I.cur_assembly ? I.cur_assembly.fuel_type : "No Fuel Inserted"]"
			injector["depletion"] = "[I.cur_assembly ? (I.cur_assembly.percent_depleted * 100) : 100]%"
			injector["injection_rate"] = "[I.injection_rate * 100]%"
			injectors += list(injector)
	.["injectors"] = injectors

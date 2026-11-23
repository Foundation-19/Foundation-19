/obj/machinery/computer/fusion/core_control
	name = "\improper R-UST Mk. 8 core control"
	ui_template = "fusion_core_control.tmpl"

/obj/machinery/computer/fusion/core_control/OnTopic(mob/user, href_list, datum/topic_state/state)

	if(href_list["toggle_active"] || href_list["str"])
		var/obj/machinery/power/fusion_core/C = locate(href_list["machine"])
		if(!istype(C))
			return TOPIC_NOACTION

		var/datum/local_network/lan = get_local_network()
		if(!lan || !lan.is_connected(C))
			return TOPIC_NOACTION

		if(!C.check_core_status())
			return TOPIC_NOACTION

		if(href_list["toggle_active"])
			if(!C.Startup()) //Startup() whilst the device is active will return null.
				if(!C.owned_field.is_shutdown_safe())
					if(alert(user, "Shutting down this fusion core without proper safety procedures will cause serious damage, do you wish to continue?", "Shut Down?", "Yes", "No") == "No")
						return TOPIC_NOACTION
				C.Shutdown()
			return TOPIC_REFRESH

		if(href_list["str"] && C)
			var/val = text2num(href_list["str"])
			if(!val) //Value is 0, which is manual entering.
				C.set_strength(input("Enter the new field power density (W.m^-3)", "Fusion Control", C.field_strength) as num)
			else
				C.set_strength(C.field_strength + val)
			return TOPIC_REFRESH

/obj/machinery/computer/fusion/core_control/handle_fusion_topic(list/href_list, action)
	var/obj/machinery/power/fusion_core/C = locate(href_list["machine"])
	if(!istype(C))
		return FALSE

	var/datum/local_network/lan = get_local_network()
	if(!lan || !lan.is_connected(C))
		return FALSE

	if(!C.check_core_status())
		return FALSE

	if(action == "toggle_active")
		if(!C.Startup())
			if(!C.owned_field.is_shutdown_safe())
				if(alert(usr, "Shutting down this fusion core without proper safety procedures will cause serious damage, do you wish to continue?", "Shut Down?", "Yes", "No") == "No")
					return FALSE
			C.Shutdown()
		return TRUE

	if(action == "str")
		var/val = text2num(href_list["str"])
		if(!val)
			C.set_strength(input(usr, "Enter the new field power density (W.m^-3)", "Fusion Control", C.field_strength) as num)
		else
			C.set_strength(C.field_strength + val)
		return TRUE

	return FALSE

/obj/machinery/computer/fusion/core_control/build_ui_data()
	. = ..()
	var/datum/extension/local_network_member/fusion = get_extension(src, /datum/extension/local_network_member)
	var/datum/local_network/lan = fusion.get_local_network()
	var/list/cores = list()
	if(lan)
		var/list/fusion_cores = lan.get_devices(/obj/machinery/power/fusion_core)
		for(var/i = 1 to LAZYLEN(fusion_cores))
			var/list/core = list()
			var/obj/machinery/power/fusion_core/C = fusion_cores[i]
			core["id"] =          "#[i]"
			core["ref"] =         "\ref[C]"
			core["field"] =       !isnull(C.owned_field)
			core["power"] =       "[C.field_strength/10.0] tesla"
			core["size"] =        C.owned_field ? "[C.owned_field.size] meter\s" : "Field offline."
			core["instability"] = C.owned_field ? "[C.owned_field.percent_unstable * 100]%" : "Field offline."
			core["temperature"] = C.owned_field ? "[C.owned_field.plasma_temperature + 295]K" : "Field offline."
			core["powerstatus"] = "[C.avail()]/[C.active_power_usage] W"
			var/list/fuel_list = list()
			if(C.owned_field && LAZYLEN(C.owned_field.reactants))
				for(var/reactant in C.owned_field.reactants)
					fuel_list += list(list("name" = "[reactant]", "amount" = "[C.owned_field.reactants[reactant]]"))
			core["fuel"] = fuel_list

			cores += list(core)
	.["cores"] = cores

/obj/machinery/psi_monitor
	name = "psionic implant monitor"
	icon = 'icons/obj/machines/psimeter.dmi'
	icon_state = "meter_on"
	use_power = POWER_USE_ACTIVE
	anchored = TRUE
	density = TRUE
	opacity = FALSE
	req_access = list(list(ACCESS_PSIADVISOR, ACCESS_CAPTAIN, ACCESS_CMO, ACCESS_HOP, ACCESS_HOS))

	var/list/psi_violations = list()
	var/show_violations = FALSE
	var/authorized

/obj/machinery/psi_monitor/New()
	SSpsi.psi_monitors += src
	..()

/obj/machinery/psi_monitor/emag_act(remaining_charges, mob/user)
	if(!emagged)
		emagged = TRUE
		remaining_charges--
		req_access.Cut()
		to_chat(user, SPAN_NOTICE("You short out the access protocols."))
		return TRUE
	return FALSE

/obj/machinery/psi_monitor/interface_interact(mob/user)
	tgui_interact(user)
	return TRUE

/obj/machinery/psi_monitor/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PsiMonitor", "Psi-Monitor")
		ui.open()

/obj/machinery/psi_monitor/tgui_data(mob/user)
	var/list/data = list()
	data["authorized"] = authorized
	data["show_violations"] = show_violations
	var/list/dampeners = list()
	for(var/thing in SSpsi.psi_dampeners)
		var/obj/item/implant/psi_control/implant = thing
		if(!implant.imp_in)
			continue
		dampeners += list(list(
			"name" = implant.imp_in.name,
			"overload" = implant.malfunction ? null : implant.overload,
			"mode" = implant.psi_mode,
			"malfunction" = implant.malfunction,
			"ref" = "\ref[implant]",
		))
	data["dampeners"] = dampeners
	data["violations"] = psi_violations.Copy()
	return data

/obj/machinery/psi_monitor/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	switch(action)
		if("login")
			var/obj/item/card/id/ID = usr.GetIdCard()
			if(!ID || !allowed(usr))
				to_chat(usr, SPAN_WARNING("Access denied."))
			else
				authorized = "[ID.registered_name] ([ID.assignment])"
			return TRUE
		if("logout")
			authorized = FALSE
			return TRUE
		if("show_violations")
			show_violations = params["show"]
			return TRUE
		if("remove_violation")
			var/remove_ind = text2num(params["index"])
			if(remove_ind > 0 && remove_ind <= psi_violations.len)
				psi_violations.Cut(remove_ind, remove_ind++)
			return TRUE
		if("change_mode")
			var/obj/item/implant/psi_control/implant = locate(params["ref"])
			if(istype(implant) && implant.imp_in && !implant.malfunction)
				var/choice = input("Select a new implant mode.", "Psi Dampener") as null|anything in list(PSI_IMPLANT_SHOCK, PSI_IMPLANT_WARN, PSI_IMPLANT_LOG, PSI_IMPLANT_DISABLED)
				if(choice && implant && implant.imp_in && !implant.malfunction)
					implant.psi_mode = choice
					implant.update_functionality()
			return TRUE
	return FALSE


/obj/machinery/psi_monitor/proc/report_failure(obj/item/implant/psi_control/implant)
	psi_violations += FONT_COLORED("#FF0000","Critical system failure - [implant.imp_in.name].")

/obj/machinery/psi_monitor/proc/report_violation(obj/item/implant/psi_control/implant, stress)
	psi_violations += "Sigma [round(stress/10)] event - [implant.imp_in.name]."

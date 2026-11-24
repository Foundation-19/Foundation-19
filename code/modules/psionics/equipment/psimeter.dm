/obj/machinery/psi_meter
	name = "psi-meter"
	desc = "A bulky psi-meter for conducting assays of psi-operants."
	icon = 'icons/obj/machines/psimeter.dmi'
	icon_state = "meter_on"
	use_power = POWER_USE_ACTIVE
	anchored = TRUE
	density = TRUE
	opacity = FALSE

	var/list/last_assay
	var/mob/living/last_assayed

/obj/machinery/psi_meter/on_update_icon()
	if(use_power && !(stat & (NOPOWER|BROKEN)))
		icon_state = "meter_on"
	else
		icon_state = "meter_off"

/obj/machinery/psi_meter/interface_interact(mob/user)
	tgui_interact(user)
	return TRUE

/obj/machinery/psi_meter/tgui_interact(mob/user, datum/tgui/ui)
	if(!use_power)
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PsiMeter", "Psi-Assay")
		ui.open()

/obj/machinery/psi_meter/tgui_data(mob/user)
	var/list/data = list()
	if(LAZYLEN(last_assay))
		data["has_assay"] = TRUE
		data["assay_html"] = jointext(last_assay, null)
		data["assayed_name"] = last_assayed ? last_assayed.name : null
	else
		data["has_assay"] = FALSE
		var/list/candidates = list()
		for(var/mob/living/H in range(1, src))
			candidates += list(list("name" = H.name, "ref" = "\ref[H]"))
		data["candidates"] = candidates
	return data

/obj/machinery/psi_meter/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if(!issilicon(usr) && !Adjacent(usr))
		return TRUE
	switch(action)
		if("print")
			if(last_assay)
				var/obj/item/paper/P = new(loc)
				P.name = "paper - Psi-Assay ([last_assayed.name])"
				P.info = jointext(last_assay, null)
			return TRUE
		if("clear")
			last_assay = null
			return TRUE
		if("assay")
			last_assayed = locate(params["ref"])
			if(istype(last_assayed))
				last_assayed.show_psi_assay(usr, src)
			return TRUE
	return FALSE

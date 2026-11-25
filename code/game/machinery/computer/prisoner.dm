/obj/machinery/computer/prisoner
	name = "prisoner management console"
	icon = 'icons/obj/computer.dmi'
	icon_keyboard = "security_key"
	icon_screen = "explosive"
	light_color = "#a91515"
	req_access = list(ACCESS_ARMORY)
	machine_name = "prison management console"
	machine_desc = "Prison management consoles display a readout of active tracking and chemical implants, and allows for remote activation of them."
	var/id = 0.0
	var/temp = null
	var/status = 0
	var/timeleft = 60
	var/stop = 0.0
	var/screen = 0 // 0 - No Access Denied, 1 - Access allowed


/obj/machinery/computer/prisoner/interface_interact(mob/user)
	tgui_interact(user)
	return TRUE

/obj/machinery/computer/prisoner/tgui_interact(mob/user, datum/tgui/ui)
	user.set_machine(src)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PrisonerConsole", "Prisoner Implant Management System")
		ui.open()

/obj/machinery/computer/prisoner/tgui_data(mob/user)
	var/list/data = list()
	data["screen"] = screen
	// The world was scanned for implant objects on every refresh here —
	// two typed in-world loops each costing a full object sweep, even with
	// the console locked. Iterate the implant registry instead, and only
	// when the console is actually unlocked (the frontend renders neither
	// list while locked).
	var/list/chem_implants = list()
	var/list/tracking_implants = list()
	if(screen)
		for(var/obj/item/implant/I in GLOB.all_implants)
			if(!I.implanted)
				continue
			var/turf/Tr = get_turf(I)
			if(Tr && !AreConnectedZLevels(Tr.z, src.z))
				continue // Out of range
			if(istype(I, /obj/item/implant/chem))
				var/obj/item/implant/chem/C = I
				chem_implants += list(list(
					"ref" = "\ref[C]",
					"name" = C.imp_in ? C.imp_in.name : "unknown",
					"units" = C.reagents ? C.reagents.total_volume : 0,
				))
			else if(istype(I, /obj/item/implant/tracking))
				var/obj/item/implant/tracking/T = I
				var/mob/living/carbon/M = T.imp_in
				if(!M)
					continue
				var/loc_display = "Space"
				if(!isspaceturf(M.loc))
					var/turf/mob_loc = get_turf(M)
					loc_display = mob_loc ? mob_loc.loc : "Space"
				if(T.malfunction)
					loc_display = pick(teleportlocs)
				tracking_implants += list(list(
					"ref" = "\ref[T]",
					"id" = T.id,
					"location" = loc_display,
				))
	data["chem_implants"] = chem_implants
	data["tracking_implants"] = tracking_implants
	return data

/obj/machinery/computer/prisoner/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	switch(action)
		if("inject")
			var/obj/item/implant/I = locate(params["ref"])
			if(I)	I.activate(text2num(params["amount"]))
			return TRUE

		if("warn")
			var/warning = sanitize(tgui_input_text(usr, "Message:", "Enter your message here!"))
			if(!warning) return TRUE
			var/obj/item/implant/I = locate(params["ref"])
			if((I)&&(I.imp_in))
				var/mob/living/carbon/R = I.imp_in
				to_chat(R, SPAN_NOTICE("You hear a voice in your head saying: '[warning]'"))
			return TRUE

		if("lock")
			if(src.allowed(usr))
				screen = !screen
			else
				to_chat(usr, "Unauthorized Access.")
			return TRUE
	return FALSE


/obj/machinery/computer/prisoner/Process()
	if(!..())
		// Push updates to open UIs once per machine tick. While locked the
		// payload is empty and static, so don't spam updates; the "lock" act
		// refreshes the UI when access changes.
		if(screen)
			SStgui.update_uis(src)
	return

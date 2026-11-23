/obj/machinery/body_scanconsole
	var/obj/machinery/bodyscanner/connected
	var/stored_scan_subject
	name = "body scanner console"
	desc = "A small terminal used to operate an adjacent body scanner, view the results of a scan, and send those results to connected medical displays."
	icon = 'icons/obj/Cryogenic2.dmi'
	icon_state = "body_scannerconsole"
	density = FALSE
	anchored = TRUE
	construct_state = /decl/machine_construction/default/panel_closed
	uncreated_component_parts = null
	stat_immune = 0

	machine_name = "body scanner console"
	machine_desc = "A small touchscreen terminal, used to operate an adjacent body scanner, as well as viewing and manipulating its readouts."

	var/list/connected_displays = list()
	var/list/data = list()
	var/scan_data

/obj/machinery/body_scanconsole/Initialize()
	. = ..()
	FindScanner()

/obj/machinery/body_scanconsole/on_update_icon()
	if(stat & (BROKEN | NOPOWER))
		icon_state = "body_scannerconsole-p"
	else
		icon_state = initial(icon_state)

/obj/machinery/body_scanconsole/ex_act(severity)

	switch(severity)
		if(1.0)
			qdel(src)
		if(2.0)
			if (prob(50))
				qdel(src)

/obj/machinery/body_scanconsole/proc/FindScanner()
	for(var/D in GLOB.cardinal)
		connected = locate(/obj/machinery/bodyscanner, get_step(src, D))
		if(connected)
			break
		RegisterSignal(connected, COMSIG_PARENT_QDELETING, PROC_REF(unlink_scanner))

/obj/machinery/body_scanconsole/proc/unlink_scanner(obj/machinery/bodyscanner/scanner)
	UnregisterSignal(scanner, COMSIG_PARENT_QDELETING)
	connected = null

/obj/machinery/body_scanconsole/proc/FindDisplays()
	for(var/obj/machinery/body_scan_display/D in SSmachines.machinery)
		if (AreConnectedZLevels(D.z, z))
			connected_displays += D
			RegisterSignal(D, COMSIG_PARENT_QDELETING, PROC_REF(remove_display))
	return !!connected_displays.len

/obj/machinery/body_scanconsole/attack_hand(mob/user)
	if(!connected || (connected.stat & (NOPOWER|BROKEN)))
		to_chat(user, SPAN_WARNING("This console is not connected to a functioning body scanner."))
		return TRUE
	return ..()

/obj/machinery/body_scanconsole/interface_interact(mob/user)
	tgui_interact(user)
	return TRUE

/obj/machinery/body_scanconsole/tgui_status(mob/user, datum/tgui_state/state)
	if(!connected)
		return STATUS_CLOSE
	return ..()

/obj/machinery/body_scanconsole/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "BodyScanner", "Body Scanner", 600, 800)
		ui.open()

/obj/machinery/body_scanconsole/tgui_data(mob/user)
	var/list/data = list()

	if(connected && connected.occupant)
		data["scanEnabled"] = TRUE
		if(ishuman(connected.occupant))
			data["isCompatible"] = TRUE
		else
			data["isCompatible"] = FALSE
	else
		data["scanEnabled"] = FALSE

	if(!data["scan"])
		data["html_scan_header"] = "<center>No scan loaded.</center>"
		data["html_scan_health"] = "&nbsp;"
		data["html_scan_body"] = "&nbsp;"
	else
		data["html_scan_header"] = display_medical_data_header(data["scan"], user.get_skill_value(SKILL_MEDICAL))
		data["html_scan_health"] = display_medical_data_health(data["scan"], user.get_skill_value(SKILL_MEDICAL))
		data["html_scan_body"] = display_medical_data_body(data["scan"], user.get_skill_value(SKILL_MEDICAL))

	return data

/obj/machinery/body_scanconsole/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE

	if(action == "scan")
		if(!connected.occupant)
			to_chat(usr, SPAN_WARNING("[icon2html(src, usr)]The body scanner is empty."))
			return TRUE
		if(!istype(connected.occupant))
			to_chat(usr, SPAN_WARNING("[icon2html(src, usr)]The body scanner cannot scan that lifeform."))
			return TRUE
		data["printEnabled"] = TRUE
		data["eraseEnabled"] = TRUE
		data["pushEnabled"] = TRUE
		data["scan"] = connected.occupant.get_raw_medical_data(TRUE)
		data["html_scan_header"] = display_medical_data_header(data["scan"], usr.get_skill_value(SKILL_MEDICAL))
		data["html_scan_health"] = display_medical_data_health(data["scan"], usr.get_skill_value(SKILL_MEDICAL))
		data["html_scan_body"] = display_medical_data_body(data["scan"], usr.get_skill_value(SKILL_MEDICAL))

		stored_scan_subject = connected.occupant
		usr.visible_message(
			SPAN_NOTICE("\The [usr] performs a scan of \the [connected.occupant] using \the [initial(connected.name)]."),
			SPAN_NOTICE("You run a full-body diagnostic of \the [connected.occupant] using \the [initial(connected.name)]."),
			SPAN_ITALIC("You hear a series of beeps, followed by a deep humming sound.")
		)
		playsound(connected.loc, 'sounds/machines/medbayscanner.ogg', 50)
		return TRUE

	if(action == "print")
		if(!data["scan"])
			to_chat(usr, SPAN_WARNING("[icon2html(src, usr)]Error: No scan stored."))
			return TRUE
		var/list/scan = data["scan"]
		new /obj/item/paper/bodyscan(loc, "Printout error.", "Body scan report - [stored_scan_subject]", scan.Copy())
		var/obj/item/organ/internal/heart/heart_organ = connected.occupant?.internal_organs_by_name[BP_HEART]
		if(istype(heart_organ) && (heart_organ.SCP?.designation == "3349-1"))
			new /obj/item/paper/scp3349_ekg(loc, "<img src = scp3349_ekg.png>", "EKG report - [stored_scan_subject]")
		return TRUE

	if(action == "push")
		if(!connected_displays.len && !FindDisplays())
			to_chat(usr, SPAN_WARNING("[icon2html(src, usr)]Error: No configured displays detected."))
			return TRUE
		for(var/obj/machinery/body_scan_display/D in connected_displays)
			D.add_new_scan(data["scan"])
		usr.visible_message(
			SPAN_NOTICE("\The [usr] keys a command into \the [src]."),
			SPAN_NOTICE("The console beeps, confirming it has successfully sent the scan to the connected displays."),
			SPAN_ITALIC("You hear someone typing on a terminal, then a beep.")
		)
		return TRUE

	if(action == "erase")
		data["scan"] = null
		data["html_scan"] = null
		stored_scan_subject = null
		data["eraseEnabled"] = FALSE
		data["printEnabled"] = FALSE
		data["pushEnabled"] = FALSE
		return TRUE

/obj/machinery/body_scanconsole/state_transition(decl/machine_construction/default/new_state)
	. = ..()
	if(istype(new_state))
		updateUsrDialog()

/obj/machinery/body_scanconsole/proc/remove_display(obj/machinery/body_scan_display/display)
	connected_displays -= display
	UnregisterSignal(display, COMSIG_PARENT_QDELETING)

/obj/machinery/body_scanconsole/Destroy()
	. = ..()
	for(var/D in connected_displays)
		remove_display(D)
	unlink_scanner(connected)

/obj/machinery/computer/operating
	name = "patient monitoring console"
	density = TRUE
	anchored = TRUE
	icon_keyboard = "med_key"
	icon_screen = "crew"
	machine_name = "patient monitoring console"
	machine_desc = "Displays a realtime health readout of a patient laid onto an adjacent operating table."
	var/mob/living/carbon/human/victim = null
	var/obj/machinery/optable/table = null

/obj/machinery/computer/operating/New()
	. = ..()
	for(var/D in list(NORTH,EAST,SOUTH,WEST))
		table = locate(/obj/machinery/optable, get_step(src, D))
		if (table)
			table.computer = src
			break

/obj/machinery/computer/operating/interface_interact(user)
	tgui_interact(user)
	return TRUE

/obj/machinery/computer/operating/tgui_interact(mob/user, datum/tgui/ui)
	if((get_dist(src, user) > 1 ) || (stat & (BROKEN|NOPOWER)))
		if(!issilicon(user))
			user.unset_machine()
			return

	user.set_machine(src)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "OperatingConsole", "Patient Monitoring System")
		ui.open()

/obj/machinery/computer/operating/tgui_data(mob/user)
	var/list/data = list()
	if(src.table && (src.table.check_victim()))
		src.victim = src.table.victim
		data["has_patient"] = TRUE
		data["patient"] = victim.name
		data["scan"] = medical_scan_results(victim, 1)
	else
		src.victim = null
		data["has_patient"] = FALSE
	return data

/obj/machinery/computer/operating/Process()
	if(!inoperable())
		SStgui.update_uis(src)

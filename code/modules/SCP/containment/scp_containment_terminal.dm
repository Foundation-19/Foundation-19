

/obj/machinery/scp_containment_terminal
	name = "containment terminal"
	desc = "A terminal inside an SCP containment cell for entity interaction and monitoring."
	icon = 'icons/obj/computer.dmi'
	icon_state = "oldcomp"
	anchored = TRUE
	density = FALSE
	use_power = POWER_USE_IDLE
	idle_power_usage = 50
	var/datum/scp_containment_system/linked_system

/obj/machinery/scp_containment_terminal/Initialize()
	. = ..()
	find_linked_scp()

/obj/machinery/scp_containment_terminal/proc/find_linked_scp()
	linked_system = null
	for(var/mob/living/L in range(5, src))
		if(L.scp_containment_system)
			linked_system = L.scp_containment_system
			return

/obj/machinery/scp_containment_terminal/tgui_interact(mob/user, datum/tgui/ui)
	if(!linked_system)
		find_linked_scp()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ScpContainmentProgram", "Containment Terminal")
		ui.set_autoupdate(TRUE)
		ui.open()

/obj/machinery/scp_containment_terminal/tgui_state(mob/user)
	// The SCP inside the cell (possibly a playerless mob being played by a
	// ghost-possessed mind) plus adjacent staff; personal-terminal feel.
	return GLOB.physical_tgui_state

/obj/machinery/scp_containment_terminal/tgui_data(mob/user)
	var/list/data = list()
	if(!linked_system)
		find_linked_scp()
	if(linked_system)
		data = linked_system.get_data()
	var/mob/living/L = user
	data["is_scp"] = istype(L) && L.scp_containment_system != null
	data["scp_id"] = linked_system ? linked_system.get_scp_id() : null
	data["containing_zone"] = null
	var/area/A = get_area(src)
	if(A)
		var/datum/containment_zone/CZ = A.get_containment_zone()
		if(CZ)
			data["containing_zone"] = CZ.scp_designation || "Unassigned"
	// Stress/work block for staff users.
	if(linked_system?.stress)
		var/datum/containment_stress/S = linked_system.stress
		data["stress"] = S.get_data()
	return data

/obj/machinery/scp_containment_terminal/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if(!linked_system)
		return
	var/mob/user = ui?.user || usr
	switch(action)
		if("interact")
			linked_system.perform_interaction(params["id"])
			return TRUE
		if("do_work")
			var/mob/living/carbon/human/H = user
			if(!istype(H) || H.scp_containment_system)
				return
			linked_system?.stress?.perform_work(H, params["work_type"])
			return TRUE
		if("refresh")
			return TRUE
	return FALSE

// ---------------------------------------------------------------------------
// Cell structures — flavor interactions for contained entities.
// ---------------------------------------------------------------------------

/obj/structure/scp_cell_window
	name = "reinforced observation window"
	desc = "A thick reinforced glass window for observing contained entities."
	icon = 'icons/obj/structures.dmi'
	icon_state = "rwindow"
	density = TRUE
	opacity = 0
	anchored = TRUE
	var/integrity = 100

/obj/structure/scp_cell_window/attack_hand(mob/user)
	var/mob/living/L = user
	if(istype(L) && L.scp_containment_system)
		var/datum/scp_containment_system/CS = L.scp_containment_system
		if(CS.get_scp_id() == "106")
			visible_message(SPAN_DANGER("[user] presses against the observation window, acid dripping from their fingers!"))
			integrity -= 5
		else if(CS.get_scp_id() == "682")
			visible_message(SPAN_DANGER("[user] slams against the observation window!"))
			integrity -= 8
		else
			to_chat(user, SPAN_NOTICE("You press against the window but it holds firm."))
			return TRUE
		if(integrity <= 0)
			visible_message(SPAN_DANGER("The observation window shatters!"))
			qdel(src)
		return TRUE
	return FALSE

/obj/structure/scp_cell_vent
	name = "containment vent"
	desc = "A ventilation grate in the containment cell. Too small for most entities to fit through."
	icon = 'icons/obj/structures.dmi'
	icon_state = "grille"
	density = FALSE
	anchored = TRUE

/obj/structure/scp_cell_vent/attack_hand(mob/user)
	var/mob/living/L = user
	if(istype(L) && L.scp_containment_system)
		var/datum/scp_containment_system/CS = L.scp_containment_system
		if(CS.get_scp_id() == "106")
			to_chat(user, SPAN_NOTICE("You could phase through this vent to another room..."))
			if(CS.spend_resource(RESOURCE_CORROSION, 15))
				var/turf/target = get_step_rand(user)
				if(target && !target.density)
					user.forceMove(target)
					user.visible_message(SPAN_WARNING("[user] phases through the vent!"), SPAN_NOTICE("You slip through the vent."))
				else
					to_chat(user, SPAN_WARNING("The vent leads nowhere useful."))
			else
				to_chat(user, SPAN_WARNING("You need more corrosion energy to phase through."))
			return TRUE
		if(CS.get_scp_id() == "079")
			to_chat(user, SPAN_NOTICE("This vent connects to the facility's camera network. You could use it to hop to a nearby camera."))
			return TRUE
		to_chat(user, SPAN_WARNING("You cannot fit through the vent."))
		return TRUE
	return FALSE

/obj/structure/scp_cell_bed
	name = "containment cell bed"
	desc = "A reinforced bed bolted to the floor."
	icon = 'icons/obj/structures.dmi'
	icon_state = "table"
	density = FALSE
	anchored = TRUE

/obj/structure/scp_cell_bed/attack_hand(mob/user)
	var/mob/living/L = user
	if(istype(L) && L.scp_containment_system)
		to_chat(L, SPAN_NOTICE("You sit on the bed. There is nothing else to do."))
		var/datum/scp_containment_system/CS = L.scp_containment_system
		if(CS.resources[RESOURCE_TENSION] != null)
			CS.resources[RESOURCE_TENSION] = max(0, CS.resources[RESOURCE_TENSION] - 2)
		return TRUE
	return FALSE

/obj/structure/scp_cell_scratch_marks
	name = "scratch marks"
	desc = "Deep scratch marks gouged into the wall. Someone has been here a long time."
	icon = 'icons/obj/structures.dmi'
	icon_state = "catwalkfull"
	density = FALSE
	anchored = TRUE

/obj/structure/scp_cell_scratch_marks/examine(mob/user)
	. = ..()
	var/mob/living/L = user
	if(istype(L) && L.scp_containment_system)
		. += SPAN_NOTICE("You recognize your own handiwork. Each mark is a day of containment.")

/obj/machinery/computer/shuttle_control/multi

/obj/machinery/computer/shuttle_control/multi/get_ui_data(datum/shuttle/autodock/multi/shuttle)
	. = ..()
	if(istype(shuttle))
		. += list(
			"destination_name" = shuttle.next_location? shuttle.next_location.name : "No destination set.",
			"can_pick" = shuttle.moving_status == SHUTTLE_IDLE,
		)

/obj/machinery/computer/shuttle_control/multi/handle_topic_href(datum/shuttle/autodock/multi/shuttle, action, list/params, user)
	if((. = ..()) != null)
		return

	if(action == "pick")
		var/dest_key = input("Choose shuttle destination", "Shuttle Destination") as null|anything in shuttle.get_destinations()
		if(dest_key && CanInteract(usr, GLOB.default_state))
			shuttle.set_destination(dest_key, usr)
		return TRUE


/obj/machinery/computer/shuttle_control/multi/antag

/obj/machinery/computer/shuttle_control/multi/antag/get_ui_data(datum/shuttle/autodock/multi/antag/shuttle)
	. = ..()
	if(istype(shuttle))
		. += list(
			"cloaked" = shuttle.cloaked,
		)

/obj/machinery/computer/shuttle_control/multi/antag/handle_topic_href(datum/shuttle/autodock/multi/antag/shuttle, action, list/params, user)
	if((. = ..()) != null)
		return

	if(action == "toggle_cloaked")
		shuttle.cloaked = !shuttle.cloaked
		return TRUE

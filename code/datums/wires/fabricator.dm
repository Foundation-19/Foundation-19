/datum/wires/fabricator
	holder_type = /obj/machinery/fabricator
	wire_count = 6
	proper_name = "Autolathe"

/datum/wires/fabricator/New(atom/_holder)
	wires = list(WIRE_AUTOLATHE_HACK, WIRE_ELECTRIFY, WIRE_AUTOLATHE_DISABLE)
	return ..()

/datum/wires/fabricator/get_status()
	. = ..()
	var/obj/machinery/fabricator/A = holder
	. += "The red light is [(A.fab_status_flags & FAB_DISABLED) ? "off" : "on"]."
	. += "The green light is [(A.fab_status_flags & FAB_SHOCKED) ? "off" : "on"]."
	. += "The blue light is [(A.fab_status_flags & FAB_HACKED) ? "off" : "on"]."

/datum/wires/fabricator/interactable(mob/user)
	var/obj/machinery/fabricator/A = holder
	if(A.panel_open)
		return TRUE
	return FALSE

/datum/wires/fabricator/on_cut(wire, mend)
	var/obj/machinery/fabricator/A = holder
	switch(wire)
		if(WIRE_AUTOLATHE_HACK)
			if(mend)
				A.fab_status_flags &= ~FAB_HACKED
			else
				A.fab_status_flags |= FAB_HACKED
		if(WIRE_ELECTRIFY)
			if(mend)
				A.fab_status_flags &= ~FAB_SHOCKED
			else
				A.fab_status_flags |= FAB_SHOCKED
		if(WIRE_AUTOLATHE_DISABLE)
			if(mend)
				A.fab_status_flags &= ~FAB_DISABLED
			else
				A.fab_status_flags |= FAB_DISABLED

/datum/wires/fabricator/on_pulse(wire)
	if(is_cut(wire))
		return
	var/obj/machinery/fabricator/A = holder
	switch(wire)
		if(WIRE_AUTOLATHE_HACK)
			A.fab_status_flags ^= FAB_HACKED
			spawn(50)
				if(A && !is_cut(wire))
					A.fab_status_flags &= ~FAB_HACKED
		if(WIRE_ELECTRIFY)
			A.fab_status_flags ^= FAB_SHOCKED
			spawn(50)
				if(A && !is_cut(wire))
					A.fab_status_flags &= ~FAB_SHOCKED
		if(WIRE_AUTOLATHE_DISABLE)
			A.fab_status_flags ^= FAB_DISABLED
			spawn(50)
				if(A && !is_cut(wire))
					A.fab_status_flags &= ~FAB_DISABLED

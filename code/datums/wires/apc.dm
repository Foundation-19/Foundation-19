/datum/wires/apc
	holder_type = /obj/machinery/power/apc
	wire_count = 6	// 2 duds
	proper_name = "APC"

/datum/wires/apc/New(atom/_holder)
	wires = list(WIRE_IDSCAN, WIRE_MAIN_POWER1, WIRE_MAIN_POWER2, WIRE_AI_CONTROL)
	return ..()

/datum/wires/apc/get_status()
	. = ..()
	var/obj/machinery/power/apc/A = holder
	. += "The APC is [A.locked ? "" : "un"]locked."
	. += A.shorted ? "The APCs power has been shorted." : "The APC is working properly!"
	. += "The 'AI control allowed' light is [A.aidisabled ? "off" : "on"]."

/datum/wires/apc/interactable(mob/user)
	var/obj/machinery/power/apc/A = holder
	if(A.wiresexposed)
		return 1
	return 0

/datum/wires/apc/on_pulse(wire)
	var/obj/machinery/power/apc/A = holder

	switch(wire)
		if(WIRE_IDSCAN)
			A.locked = FALSE

			addtimer(CALLBACK(A, TYPE_PROC_REF(/obj/machinery/power/apc, reset_wire), wire), 30 SECONDS)

		if(WIRE_MAIN_POWER1, WIRE_MAIN_POWER2)
			if(!A.shorted)
				A.shorted = TRUE

				addtimer(CALLBACK(A, TYPE_PROC_REF(/obj/machinery/power/apc, reset_wire), wire), 120 SECONDS)

		if(WIRE_AI_CONTROL)
			if(!A.aidisabled)
				A.aidisabled = TRUE

				addtimer(CALLBACK(A, TYPE_PROC_REF(/obj/machinery/power/apc, reset_wire), wire), 1 SECOND)

/datum/wires/apc/on_cut(wire, mend)
	var/obj/machinery/power/apc/A = holder

	switch(wire)
		if(WIRE_MAIN_POWER1, WIRE_MAIN_POWER2)
			if(!mend)
				if(isliving(usr))
					A.shock(usr, 50)
				A.shorted = TRUE

			else if(!is_cut(WIRE_MAIN_POWER1) && !is_cut(WIRE_MAIN_POWER2))
				A.shorted = FALSE
				if(isliving(usr))
					A.shock(usr, 50)

		if(WIRE_AI_CONTROL)
			A.aidisabled = !mend

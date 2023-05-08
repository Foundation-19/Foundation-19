/datum/wires/contraband_detector
	holder_type = /obj/machinery/contraband_detector
	wire_count = 4
	proper_name = "Contraband Detector"

/datum/wires/contraband_detector/New(atom/_holder)
	wires = list(WIRE_MAIN_POWER1, WIRE_MAIN_POWER2, WIRE_CONTRADETECT_IDENTIFIER, WIRE_CONTRADETECT_ALARM)
	return ..()

/datum/wires/contraband_detector/get_status()
	. = ..()
	var/obj/machinery/contraband_detector/CD = holder
	var/haspower = !(CD.stat & (BROKEN|NOPOWER)) //If there's no power, then no lights will be on.
	. += "The test light is [haspower ? "on." : "off!"]"
	. += "The contraband identification light is [(haspower && !is_cut(WIRE_CONTRADETECT_IDENTIFIER)) ? (((CD.identifier_wire_pulsed_until > world.time) && CD.identifier_wire_pulsed_until != 0) ? "blinking!" : "on.") : "off!"]"
	. += "The radio light is [(haspower && !is_cut(WIRE_CONTRADETECT_ALARM)) ? "on." : "off!"]"

/datum/wires/contraband_detector/interactable(mob/user)
	var/obj/machinery/contraband_detector/CD = holder
	return CD.panel_open

/datum/wires/contraband_detector/on_cut(wire, mend)
	var/obj/machinery/contraband_detector/CD = holder

	switch(wire)
		if(WIRE_MAIN_POWER1, WIRE_MAIN_POWER2)
			CD.update_icon()

		if(WIRE_CONTRADETECT_IDENTIFIER)
			if(!mend)
				CD.announce_tampering()

/datum/wires/contraband_detectort/on_pulse(wire)
	var/obj/machinery/contraband_detector/CD = holder

	switch(wire)
		if(WIRE_MAIN_POWER1, WIRE_MAIN_POWER2)
			CD.announce_tampering()

		if(WIRE_CONTRADETECT_IDENTIFIER)
			CD.identifier_wire_pulsed_until = world.time + 30 SECONDS

		if(WIRE_CAM_ALARM)
			CD.announce_tampering()

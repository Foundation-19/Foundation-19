/datum/wires/tele_beacon
	holder_type = /obj/machinery/tele_beacon
	wire_count = 3
	proper_name = "Suit storage unit"

/datum/wires/tele_beacon/New(atom/_holder)
	wires = list(WIRE_TELEBEACON_POWER, WIRE_TELEBEACON_RELAY, WIRE_TELEBEACON_SIGNALLER)
	return ..()

/datum/wires/tele_beacon/interactable(mob/user)
	var/obj/machinery/tele_beacon/tele_beacon = holder
	if (!tele_beacon.panel_open || !tele_beacon.anchored)
		return FALSE
	return TRUE

/datum/wires/tele_beacon/get_status()
	var/obj/machinery/tele_beacon/tele_beacon = holder
	. = ..()
	if (!tele_beacon.functioning())
		. += "The panel is completely unpowered or disabled."
	else
		. += "The panel is powered."
		if (usr.skill_check(SKILL_ELECTRICAL, SKILL_TRAINED))
			. += "The remote relay chip is [is_cut(WIRE_TELEBEACON_RELAY) ? "disconnected" : "connected"]"
			. += "The connection signaller circuitry is [is_cut(WIRE_TELEBEACON_SIGNALLER) ? "disconnected" : "connected"]."
		else
			. += "There are lights and wires here, but you don't know how the wiring works.</li>"

/datum/wires/tele_beacon/on_cut(wire, mend)
	var/obj/machinery/tele_beacon/tele_beacon = holder
	switch(wire)
		// WIRE_TELEBEACON_SIGNALLER - Enable (mend) or disable (cut) the 'connected computer' beep. Handled in `connect_computer()`
		if(WIRE_TELEBEACON_POWER) // Enable (mend) or disable (cut) power. Has a shock risk.
			tele_beacon.set_power_cut(!mend)
			tele_beacon.shock(usr, 50)
		if(WIRE_TELEBEACON_RELAY) // Allow (mend) or disallow (cut) teleporter connections. Handled in `connect_computer()`
			tele_beacon.disconnect_computers()

/datum/wires/tele_beacon/on_pulse(wire)
	var/obj/machinery/tele_beacon/tele_beacon = holder
	switch(wire)
		if(WIRE_TELEBEACON_POWER)
			tele_beacon.set_power_cut()
			spawn(rand(15 SECONDS, 45 SECONDS))
				if(!is_cut(WIRE_TELEBEACON_POWER))
					tele_beacon.set_power_cut(FALSE)
		if(WIRE_TELEBEACON_RELAY)
			tele_beacon.disconnect_computers()
		if(WIRE_TELEBEACON_SIGNALLER)
			tele_beacon.notify_connection()

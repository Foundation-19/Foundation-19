/datum/wires/nuclearbomb
	holder_type = /obj/machinery/nuclearbomb
	randomize = 1
	wire_count = 7
	proper_name = "Nuclear Bomb"

/datum/wires/nuclearbomb/New(atom/_holder)
	wires = list(WIRE_BOMB_LIGHT, WIRE_BOMB_TIMING, WIRE_BOMB_SAFETY)
	return ..()

/datum/wires/nuclearbomb/interactable(mob/user)
	var/obj/machinery/nuclearbomb/N = holder
	return N.panel_open

/datum/wires/nuclearbomb/get_status()
	var/obj/machinery/nuclearbomb/N = holder
	. += ..()
	. += "The device is [N.timing ? "shaking!" : "still."]"
	. += "The device is is [N.safety ? "quiet" : "whirring"]."
	. += "The lights are [N.lighthack ? "static" : "functional"]."

/datum/wires/nuclearbomb/on_pulse(wire)
	var/obj/machinery/nuclearbomb/N = holder
	switch(wire)
		if(WIRE_BOMB_LIGHT)
			N.lighthack = !N.lighthack
			N.update_icon()
			spawn(100)
				N.lighthack = !N.lighthack
				N.update_icon()

		if(WIRE_BOMB_TIMING)
			if(N.timing)
				spawn
					log_and_message_staff("pulsed a nuclear bomb's detonation wire, causing it to explode.")
					N.explode()

		if(WIRE_BOMB_SAFETY)
			N.safety = !N.safety
			spawn(100)
				N.safety = !N.safety
				if(N.safety)
					N.visible_message(SPAN_NOTICE("\The [N] quiets down."))
					N.secure_device()
				else
					N.visible_message(SPAN_NOTICE("\The [N] emits a quiet whirling noise!"))

/datum/wires/apc/on_cut(wire, mend)
	var/obj/machinery/nuclearbomb/N = holder
	switch(wire)
		if(WIRE_BOMB_SAFETY)
			N.safety = mend
			if(N.timing)
				spawn
					log_and_message_staff("cut a nuclear bomb's timing wire, causing it to explode.")
					N.explode()

		if(WIRE_BOMB_TIMING)
			N.secure_device()

		if(WIRE_BOMB_LIGHT)
			N.lighthack = !mend
			N.update_icon()

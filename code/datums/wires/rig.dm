/datum/wires/rig
	holder_type = /obj/item/rig
	wire_count = 5

/datum/wires/rig/New(atom/_holder)
	wires = list(WIRE_RIG_SECURITY, WIRE_RIG_AI_OVERRIDE, WIRE_RIG_SYSTEM_CONTROL, WIRE_RIG_INTERFACE_LOCK, WIRE_RIG_INTERFACE_SHOCK)
	return ..()

/datum/wires/robot/on_cut(wire, mend)
	var/obj/item/rig/rig = holder
	switch(wire)
		if(WIRE_RIG_SECURITY) //Cut the law wire, and the borg will no longer receive law updates from its AI
			rig.security_check_enabled = mend
		if(WIRE_RIG_INTERFACE_SHOCK) //Cut the AI wire to reset AI control
			rig.electrified = mend ? 0 : -1
			rig.shock(usr,100)

/datum/wires/robot/on_pulse(wire)
	var/obj/item/rig/rig = holder
	switch(wire)
		if(WIRE_RIG_SECURITY)
			rig.security_check_enabled = !rig.security_check_enabled
			rig.visible_message("\The [rig] twitches as several suit locks [rig.security_check_enabled?"close":"open"].")
		if(WIRE_RIG_AI_OVERRIDE)
			rig.ai_override_enabled = !rig.ai_override_enabled
			rig.visible_message("A small red light on [rig] [rig.ai_override_enabled?"goes dead":"flickers on"].")
		if(WIRE_RIG_SYSTEM_CONTROL)
			if (rig.offline)
				rig.visible_message("\The [rig] sparks, damaging its delicate control systems.")
			rig.malfunctioning += 10
			if(rig.malfunction_delay <= 0)
				rig.malfunction_delay = 20
			rig.shock(usr,100)
		if(WIRE_RIG_INTERFACE_LOCK)
			rig.interface_locked = !rig.interface_locked
			rig.visible_message("\The [rig] clicks audibly as the software interface [rig.interface_locked?"darkens":"brightens"].")
		if(WIRE_RIG_INTERFACE_SHOCK)
			if(rig.electrified != -1)
				rig.electrified = 30
			rig.shock(usr,100)

/datum/wires/robot/interactable(mob/user)
	var/obj/item/rig/rig = holder
	if(rig.p_open)
		return 1
	return 0

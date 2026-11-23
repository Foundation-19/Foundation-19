/obj/machinery/computer/robotics
	name = "robotics control console"
	desc = "Used to remotely lockdown or monitor linked synthetics."
	icon = 'icons/obj/computer.dmi'
	icon_keyboard = "mining_key"
	icon_screen = "robot"
	light_color = "#a97faa"
	req_access = list(ACCESS_ROBOTICS)
	machine_name = "robotics control console"
	machine_desc = "A control console that maintains a radio link with ship synthetics. Allows remote monitoring of them, as well as locking down their movement systems."

/obj/machinery/computer/robotics/interface_interact(mob/user)
	tgui_interact(user)
	return TRUE

/obj/machinery/computer/robotics/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "RobotComputer", "Robotic Control Console", 400, 500)
		ui.open()

/obj/machinery/computer/robotics/tgui_data(mob/user)
	var/data[0]
	data["robots"] = get_cyborgs(user)
	data["is_ai"] = issilicon(user)
	return data

/obj/machinery/computer/robotics/tgui_status(mob/user)
	if(!allowed(user))
		to_chat(user, SPAN_WARNING("Access Denied"))
		return STATUS_CLOSE
	return ..()

/obj/machinery/computer/robotics/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	// Locks or unlocks the cyborg
	if (action == "lockdown")
		var/mob/living/silicon/robot/target = get_cyborg_by_name(params["lockdown"])
		if(!target || !istype(target))
			return TRUE

		if(isAI(usr) && (target.connected_ai != usr))
			to_chat(usr, SPAN_WARNING("Access Denied. This robot is not linked to you."))
			return TRUE

		if(isrobot(usr))
			to_chat(usr, SPAN_WARNING("Access Denied."))
			return TRUE

		var/choice = input("Really [target.lockcharge ? "unlock" : "lockdown"] [target.name] ?") in list ("Yes", "No")
		if(choice != "Yes")
			return TRUE

		if(!target || !istype(target))
			return TRUE

		if(target.SetLockdown(!target.lockcharge))
			log_and_message_staff("[target.lockcharge ? "locked down" : "released"] [target.name]!")
			if(target.lockcharge)
				to_chat(target, SPAN_DANGER("You have been locked down!"))
			else
				to_chat(target, SPAN_NOTICE("Your lockdown has been lifted!"))
		else
			to_chat(usr, SPAN_WARNING("ERROR: Lockdown attempt failed."))
		return TRUE

	// Remotely hacks the cyborg. Only antag AIs can do this and only to linked cyborgs.
	else if (action == "hack")
		var/mob/living/silicon/robot/target = get_cyborg_by_name(params["hack"])
		if(!target || !istype(target))
			return TRUE

		// Antag AI checks
		if(!istype(usr, /mob/living/silicon/ai) || !(usr.mind.special_role && usr.mind.original == usr))
			to_chat(usr, SPAN_WARNING("Access Denied"))
			return TRUE

		if(target.emagged)
			to_chat(usr, "Robot is already hacked.")
			return TRUE

		var/choice = input("Really hack [target.name]? This cannot be undone.") in list("Yes", "No")
		if(choice != "Yes")
			return TRUE

		if(!target || !istype(target))
			return TRUE

		log_and_message_staff("emagged [target.name] using robotic console!")
		target.emagged = TRUE
		to_chat(target, SPAN_NOTICE("Failsafe protocols overriden. New tools available."))
		return TRUE

	else if (action == "message")
		var/mob/living/silicon/robot/target = get_cyborg_by_name(params["message"])
		if(!target || !istype(target))
			return

		var/message = sanitize(input("Enter message to transmit to the synthetic.") as null|text)
		if(!message || !istype(target))
			return

		log_and_message_staff("sent message '[message]' to [target.name] using robotics control console!")
		to_chat(target, SPAN_NOTICE("New remote message received using R-SSH protocol:"))
		to_chat(target, message)
		return TRUE

// Proc: get_cyborgs()
// Parameters: 1 (operator - mob which is operating the console.)
// Description: Returns NanoUI-friendly list of accessible cyborgs.
/obj/machinery/computer/robotics/proc/get_cyborgs(mob/operator)
	var/list/robots = list()

	for(var/mob/living/silicon/robot/R in GLOB.silicon_mob_list)
		// Ignore drones
		if(is_drone(R))
			continue
		// Ignore antagonistic cyborgs
		if(R.scrambledcodes)
			continue

		var/list/robot = list()
		robot["name"] = R.name
		var/turf/T = get_turf(R)
		var/area/A = get_area(T)

		if(istype(T) && istype(A) && (T.z in GLOB.using_map.contact_levels))
			robot["location"] = "[A.name] ([T.x], [T.y])"
		else
			robot["location"] = "Unknown"

		if(R.stat)
			robot["status"] = "Not Responding"
		else if (R.lockcharge)
			robot["status"] = "Lockdown"
		else
			robot["status"] = "Operational"

		if(R.cell)
			robot["cell"] = 1
			robot["cell_capacity"] = R.cell.maxcharge
			robot["cell_current"] = R.cell.charge
			robot["cell_percentage"] = round(R.cell.percent())
		else
			robot["cell"] = 0

		robot["module"] = R.module ? R.module.name : "None"
		robot["master_ai"] = R.connected_ai ? R.connected_ai.name : "None"
		robot["hackable"] = 0
		// Antag AIs know whether linked cyborgs are hacked or not.
		if(operator && istype(operator, /mob/living/silicon/ai) && (R.connected_ai == operator) && (operator.mind.special_role && operator.mind.original == operator))
			robot["hacked"] = R.emagged ? 1 : 0
			robot["hackable"] = R.emagged? 0 : 1
		robots.Add(list(robot))
	return robots

// Proc: get_cyborg_by_name()
// Parameters: 1 (name - Cyborg we are trying to find)
// Description: Helper proc for finding cyborg by name
/obj/machinery/computer/robotics/proc/get_cyborg_by_name(name)
	if (!name)
		return
	for(var/mob/living/silicon/robot/R in GLOB.silicon_mob_list)
		if(R.name == name)
			return R

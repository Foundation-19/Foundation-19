/datum/computer_file/program/suit_sensors
	filename = "sensormonitor"
	filedesc = "Suit Sensors Monitoring"
	nanomodule_path = /datum/nano_module/crew_monitor
	ui_header = "crew_green.gif"
	program_icon_state = "crew"
	program_key_state = "med_key"
	program_menu_icon = "heart"
	extended_desc = "This program connects to life signs monitoring system to provide basic information on personnel health."
	required_access = ACCESS_MEDICAL_LVL1
	requires_ntnet = TRUE
	network_destination = "crew lifesigns monitoring system"
	size = 11
	var/has_alert = FALSE

/datum/computer_file/program/suit_sensors/process_tick()
	..()

	var/datum/nano_module/crew_monitor/NMC = NM
	if(istype(NMC) && (NMC.has_alerts() != has_alert))
		if(!has_alert)
			program_icon_state = "crew-red"
			ui_header = "crew_red.gif"
		else
			program_icon_state = "crew"
			ui_header = "crew_green.gif"
		update_computer_icon()
		has_alert = !has_alert

	return 1

/datum/nano_module/crew_monitor
	name = "Crew monitor"

/datum/nano_module/crew_monitor/proc/has_alerts()
	for(var/z_level in GLOB.using_map.map_levels)
		if (crew_repository.has_health_alert(z_level))
			return TRUE
	return FALSE

/datum/nano_module/crew_monitor/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..()) return 1

	if(action == "track")
		if(isAI(usr))
			var/mob/living/silicon/ai/AI = usr
			var/mob/living/carbon/human/H = locate(params["track"]) in SSmobs.mob_list
			if(hassensorlevel(H, SUIT_SENSOR_TRACKING))
				AI.ai_actual_track(H)
		return 1

/datum/nano_module/crew_monitor/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SuitSensors", "Crew Monitoring Computer")
		ui.open()

/datum/nano_module/crew_monitor/tgui_data(mob/user)
	var/list/data = host.initial_data()

	data["isAI"] = isAI(user)
	var/Z = get_host_z()
	data["crewmembers"] = crew_repository.health_data(Z)

	return data

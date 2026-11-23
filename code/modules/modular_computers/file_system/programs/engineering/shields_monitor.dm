/datum/computer_file/program/shields_monitor
	filename = "shieldsmonitor"
	filedesc = "Shield Generators Monitoring"
	nanomodule_path = /datum/nano_module/shields_monitor/
	program_icon_state = "shield"
	program_key_state = "generic_key"
	extended_desc = "This program connects to shield generators and monitors their statuses."
	ui_header = "shield.gif"
	requires_ntnet = TRUE
	network_destination = "shields monitoring system"
	size = 10

/datum/nano_module/shields_monitor
	name = "Shields monitor"
	var/obj/machinery/power/shield_generator/active = null

/datum/nano_module/shields_monitor/Destroy()
	. = ..()
	deselect_shield()

/datum/nano_module/shields_monitor/proc/get_shields()
	var/list/shields = list()
	var/connected_z_levels = GetConnectedZlevels(get_host_z())
	for(var/obj/machinery/power/shield_generator/S in SSmachines.machinery)
		if(!(S.z in connected_z_levels))
			continue
		shields.Add(S)

	if(!(active in shields))
		deselect_shield()
	return shields

/datum/nano_module/shields_monitor/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "ShieldsMonitor", name)
		ui.open()

/datum/nano_module/shields_monitor/tgui_data(mob/user)
	var/list/data = host.initial_data()

	if (active)
		data["active"] = 1
		data["running"] = active.running
		data["modes"] = active.get_flag_descriptions()
		data["overloaded"] = active.overloaded
		data["mitigation_max"] = active.mitigation_max
		data["mitigation_physical"] = round(active.mitigation_physical, 0.1)
		data["mitigation_em"] = round(active.mitigation_em, 0.1)
		data["mitigation_heat"] = round(active.mitigation_heat, 0.1)
		data["field_integrity"] = active.field_integrity()
		data["max_energy"] = round(active.max_energy / 1000000, 0.1)
		data["current_energy"] = round(active.current_energy / 1000000, 0.1)
		if(data["max_energy"] > 0)
			data["percentage_energy"] = round(data["current_energy"] / data["max_energy"] * 100)
		else
			data["percentage_energy"] = "ERR"
		data["total_segments"] = active.field_segments ? active.field_segments.len : 0
		data["functional_segments"] = active.damaged_segments ? data["total_segments"] - active.damaged_segments.len : data["total_segments"]
		data["field_radius"] = active.field_radius
		data["input_cap_kw"] = round(active.input_cap / 1000)
		data["upkeep_power_usage"] = round(active.upkeep_power_usage / 1000, 0.1)
		data["power_usage"] = round(active.power_usage / 1000)
		data["hacked"] = active.hacked
		data["offline_for"] = active.offline_for * 2
		data["pos_x"] = active.x
		data["pos_y"] = active.y
		data["pos_z"] = active.z
	else
		data["active"] = null
		var/list/shields = get_shields()
		var/list/shields_info = list()
		for(var/obj/machinery/power/shield_generator/S in shields)
			var/area/A = get_area(S)
			var/list/temp = list(list(
				"shield_status" = S.running,
				"shield_ref" = REF(S),
				"area" = A.name))
			shields_info.Add(temp)
		data["shields"] = shields_info

	return data

/datum/nano_module/shields_monitor/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return 1
	if( action == "refresh" )
		get_shields()
		return 1
	if( action == "return" )
		deselect_shield()
		return 1
	if( action == "ref" )
		var/list/shields = get_shields()
		var/obj/machinery/power/shield_generator/S = locate(params["ref"]) in shields
		if(S)
			deselect_shield()
			RegisterSignal(S, COMSIG_PARENT_QDELETING, TYPE_PROC_REF(/datum/nano_module/shields_monitor, deselect_shield))
			active = S
		return 1

/datum/nano_module/shields_monitor/proc/deselect_shield(source)
	if(!active)
		return
	UnregisterSignal(active, COMSIG_PARENT_QDELETING)
	active = null
	if(source) // source is only set if called by the shield destroyed event, which is the only time we want to update the UI
		SStgui.update_uis(src)

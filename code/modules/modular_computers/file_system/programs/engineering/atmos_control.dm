/datum/computer_file/program/atmos_control
	filename = "atmoscontrol"
	filedesc = "Atmosphere Control"
	nanomodule_path = /datum/nano_module/atmos_control
	program_icon_state = "atmos_control"
	program_key_state = "atmos_key"
	program_menu_icon = "thermometer-half"
	extended_desc = "This program allows remote control of air alarms. This program can not be run on tablet computers."
	required_access = ACCESS_ENGINEERING_LVL2
	requires_ntnet = TRUE
	network_destination = "atmospheric control system"
	requires_ntnet_feature = NTNET_SYSTEMCONTROL
	usage_flags = PROGRAM_LAPTOP | PROGRAM_CONSOLE
	size = 17

/datum/nano_module/atmos_control
	name = "Atmospherics Control"
	var/obj/access = new()
	var/emagged = FALSE
	var/ui_ref
	var/list/monitored_alarms = list()

/datum/nano_module/atmos_control/New(atmos_computer, list/req_access, monitored_alarm_ids)
	..()

	if(istype(req_access))
		access.req_access = req_access
	else if(req_access)
		log_debug("\The [src] was given an unepxected req_access: [req_access]")

	if(monitored_alarm_ids)
		for(var/obj/machinery/alarm/alarm in SSmachines.machinery)
			if(alarm.alarm_id && (alarm.alarm_id in monitored_alarm_ids))
				monitored_alarms += alarm
		// machines may not yet be ordered at this point
		monitored_alarms = dd_sortedObjectList(monitored_alarms)

/datum/nano_module/atmos_control/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return 1

	if(action == "alarm")
		if(ui_ref)
			var/obj/machinery/alarm/alarm = locate(params["alarm"]) in (monitored_alarms.len ? monitored_alarms : SSmachines.machinery)
			if(alarm)
				var/datum/topic_state/TS = generate_state(alarm)
				alarm.ui_interact(usr, master_ui = ui_ref, state = TS)
		return 1

/datum/nano_module/atmos_control/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AtmosControl", name)
		ui.open()
	ui_ref = ui

/datum/nano_module/atmos_control/tgui_data(mob/user)
	var/list/data = host.initial_data()
	var/alarms[0]
	var/alarmsAlert[0]
	var/alarmsDanger[0]

	for(var/obj/machinery/alarm/alarm in (monitored_alarms.len ? monitored_alarms : SSmachines.machinery))
		var/Z = get_host_z()
		if ((!monitored_alarms.len) && (!Z || !AreConnectedZLevels(Z, alarm.z)))
			continue
		var/danger_level = max(alarm.danger_level, alarm.alarm_area.atmosalm)
		if(danger_level == 2)
			alarmsAlert[++alarmsAlert.len] = list("name" = sanitize(alarm.name), "ref"= "\ref[alarm]", "danger" = danger_level)
		else if(danger_level == 1)
			alarmsDanger[++alarmsDanger.len] = list("name" = sanitize(alarm.name), "ref"= "\ref[alarm]", "danger" = danger_level)
		else
			alarms[++alarms.len] = list("name" = sanitize(alarm.name), "ref"= "\ref[alarm]", "danger" = danger_level)

	data["alarms"] = sortByKey(alarms, "name")
	data["alarmsAlert"] = sortByKey(alarmsAlert, "name")
	data["alarmsDanger"] = sortByKey(alarmsDanger, "name")

	return data

/datum/nano_module/atmos_control/proc/generate_state(air_alarm)
	var/datum/topic_state/air_alarm/state = new()
	state.atmos_control = src
	state.air_alarm = air_alarm
	return state

/datum/topic_state/air_alarm
	var/datum/nano_module/atmos_control/atmos_control	= null
	var/obj/machinery/alarm/air_alarm					= null

/datum/topic_state/air_alarm/can_use_topic(src_object, mob/user)
	if(alarm_has_access(user))
		return STATUS_INTERACTIVE
	return STATUS_UPDATE

/datum/topic_state/air_alarm/href_list(mob/user)
	var/list/extra_href = list()
	extra_href["remote_connection"] = 1
	extra_href["remote_access"] = alarm_has_access(user)

	return extra_href

/datum/topic_state/air_alarm/proc/alarm_has_access(mob/user)
	return user && (isAI(user) || atmos_control.access.allowed(user) || atmos_control.emagged || air_alarm.rcon_setting == RCON_YES || (air_alarm.alarm_area.atmosalm && air_alarm.rcon_setting == RCON_AUTO))

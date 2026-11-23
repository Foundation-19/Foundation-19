var/global/list/priority_air_alarms = list()
var/global/list/minor_air_alarms = list()


/obj/machinery/computer/atmos_alert
	name = "atmospheric alert computer"
	desc = "Used to access the atmospheric sensors."
	icon_keyboard = "atmos_key"
	icon_screen = "alert:0"
	light_color = "#e6ffff"
	machine_name = "atmospheric alert console"
	machine_desc = "A hub for local air sensor systems, displaying a list of atmospheric alarms in the region."

/obj/machinery/computer/atmos_alert/Initialize()
	. = ..()
	GLOB.atmosphere_alarm.register_alarm(src, TYPE_PROC_REF(/atom, update_icon))

/obj/machinery/computer/atmos_alert/Destroy()
	GLOB.atmosphere_alarm.unregister_alarm(src)
	. = ..()

/obj/machinery/computer/atmos_alert/interface_interact(user)
	tgui_interact(user)
	return TRUE

/obj/machinery/computer/atmos_alert/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AtmosAlert", src.name, 500, 500)
		ui.open()

/obj/machinery/computer/atmos_alert/tgui_data(mob/user)
	var/data[0]
	var/major_alarms[0]
	var/minor_alarms[0]

	for(var/datum/alarm/alarm in GLOB.atmosphere_alarm.major_alarms(get_z(src)))
		major_alarms[++major_alarms.len] = list("name" = sanitize(alarm.alarm_name()), "ref" = "\ref[alarm]")

	for(var/datum/alarm/alarm in GLOB.atmosphere_alarm.minor_alarms(get_z(src)))
		minor_alarms[++minor_alarms.len] = list("name" = sanitize(alarm.alarm_name()), "ref" = "\ref[alarm]")

	data["priority_alarms"] = major_alarms
	data["minor_alarms"] = minor_alarms

	return data

/obj/machinery/computer/atmos_alert/on_update_icon()
	if(!(stat & (NOPOWER|BROKEN)))
		if(GLOB.atmosphere_alarm.has_major_alarms(get_z(src)))
			icon_screen = "alert:2"
		else if (GLOB.atmosphere_alarm.has_minor_alarms(get_z(src)))
			icon_screen = "alert:1"
		else
			icon_screen = initial(icon_screen)
	..()

/obj/machinery/computer/atmos_alert/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(action == "clear_alarm")
		var/datum/alarm/alarm = locate(params["clear_alarm"]) in GLOB.atmosphere_alarm.alarms
		if(alarm)
			for(var/datum/alarm_source/alarm_source in alarm.sources)
				var/obj/machinery/alarm/air_alarm = alarm_source.source
				if(istype(air_alarm))
					var/list/new_ref = list("atmos_reset" = 1)
					air_alarm.Topic(air_alarm, new_ref, state = air_alarm_topic)
		return TRUE


var/datum/topic_state/air_alarm_topic/air_alarm_topic = new()

/datum/topic_state/air_alarm_topic/href_list(mob/user)
	var/list/extra_href = list()
	extra_href["remote_connection"] = 1
	extra_href["remote_access"] = 1

	return extra_href

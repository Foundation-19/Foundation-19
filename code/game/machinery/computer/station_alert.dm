
/obj/machinery/computer/station_alert
	name = "alert console"
	desc = "Used to access the automated alert system."
	icon_keyboard = "tech_key"
	icon_screen = "alert:0"
	light_color = "#e6ffff"
	machine_name = "alert console"
	machine_desc = "A compact monitoring system that displays a readout of all active atmosphere, camera, and fire alarms on the network."
	base_type = /obj/machinery/computer/station_alert
	var/datum/tgui_module/alarm_monitor/alarm_monitor
	var/monitor_type = /datum/tgui_module/alarm_monitor

/obj/machinery/computer/station_alert/engineering
	monitor_type = /datum/tgui_module/alarm_monitor/engineering

/obj/machinery/computer/station_alert/security
	monitor_type = /datum/tgui_module/alarm_monitor/security

/obj/machinery/computer/station_alert/all
	monitor_type = /datum/tgui_module/alarm_monitor/all

/obj/machinery/computer/station_alert/Initialize()
	alarm_monitor = new monitor_type(src)
	alarm_monitor.register_alarm(src, /atom/proc/update_icon)
	. = ..()
	if(monitor_type)
		register_monitor(new monitor_type(src))

/obj/machinery/computer/station_alert/Destroy()
	. = ..()
	unregister_monitor()

/obj/machinery/computer/station_alert/proc/register_monitor(datum/tgui_module/alarm_monitor/monitor)
	if(monitor.host != src)
		return

	alarm_monitor = monitor
	alarm_monitor.register_alarm(src, /atom/proc/update_icon)

/obj/machinery/computer/station_alert/proc/unregister_monitor()
	if(alarm_monitor)
		alarm_monitor.unregister_alarm(src)
		qdel(alarm_monitor)
		alarm_monitor = null

/obj/machinery/computer/station_alert/interface_interact(user)
	tgui_interact(user)
	return TRUE

/obj/machinery/computer/station_alert/tgui_interact(mob/user, datum/tgui/ui)
	if(alarm_monitor)
		alarm_monitor.tgui_interact(user, ui)

/obj/machinery/computer/station_alert/on_update_icon()
	icon_screen = initial(icon_screen)
	if(!(stat & (BROKEN|NOPOWER)))
		if(alarm_monitor)
			if(alarm_monitor.has_major_alarms(get_z(src)))
				icon_screen = "alert:2"
	..()

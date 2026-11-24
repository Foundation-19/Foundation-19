/obj/machinery/scp_containment_monitor
	name = "containment monitor"
	desc = "A wall-mounted monitoring unit that tracks SCP containment status in its assigned area."
	icon = 'icons/obj/machines/scp_monitor.dmi'
	icon_state = "monitor"
	anchored = TRUE
	density = FALSE
	layer = ABOVE_WINDOW_LAYER
	idle_power_usage = 10
	active_power_usage = 50
	var/datum/containment_zone/linked_zone
	var/scp_designation = ""
	var/alert_active = FALSE
	var/last_alert_time = 0
	var/alert_cooldown = 2 MINUTES

/obj/machinery/scp_containment_monitor/Initialize()
	. = ..()
	if(scp_designation)
		setup_zone()
	GLOB.scp_containment_monitors += src

/obj/machinery/scp_containment_monitor/Destroy()
	GLOB.scp_containment_monitors -= src
	if(linked_zone)
		linked_zone.monitor = null
		linked_zone = null
	return ..()

/obj/machinery/scp_containment_monitor/proc/setup_zone()
	var/area/my_area = get_area(src)
	if(!my_area)
		return
	for(var/datum/containment_zone/CZ in GLOB.containment_zones)
		if(CZ.zone_area == my_area)
			linked_zone = CZ
			CZ.monitor = src
			return
	linked_zone = new(my_area, scp_designation)
	linked_zone.monitor = src
	if(scp_designation)
		var/datum/scp/scp_datum = find_scp_by_designation(scp_designation)
		if(scp_datum)
			linked_zone.link_scp(scp_datum)

/obj/machinery/scp_containment_monitor/proc/find_scp_by_designation(desg)
	for(var/atom/A in GLOB.SCP_list)
		if(A.SCP && A.SCP.designation == desg)
			return A.SCP
	return null

/obj/machinery/scp_containment_monitor/Process()
	if(!linked_zone)
		return
	linked_zone.process()
	update_icon()

/obj/machinery/scp_containment_monitor/on_update_icon()
	overlays.Cut()
	if(stat & (BROKEN|NOPOWER))
		icon_state = "monitor_off"
		return
	icon_state = "monitor"
	if(!linked_zone)
		return
	var/status = linked_zone.containment_status
	switch(status)
		if(SCP_CONTAINED)
			overlays += "light_green"
		if(SCP_BREACHED)
			overlays += "light_red"
			if(!alert_active)
				trigger_alert()
		if(SCP_UNKNOWN)
			overlays += "light_yellow"
		else
			overlays += "light_yellow"

/obj/machinery/scp_containment_monitor/proc/trigger_alert()
	// Per-zone announcement cooldown: status flapping (SCP walks out, gets
	// recontained, walks out again) must not re-siren the site each cycle.
	if(world.time < last_alert_time + alert_cooldown)
		return
	alert_active = TRUE
	last_alert_time = world.time + alert_cooldown // next alert allowed after this one expires
	var/datum/scp/scp_datum = linked_zone.linked_scp
	var/desg = scp_datum ? scp_datum.designation : linked_zone.scp_designation
	var/class = scp_datum ? scp_datum.classification : "Unknown"
	priority_announcement.Announce(
		"Containment breach detected in [linked_zone.zone_area ? linked_zone.zone_area.name : "unknown area"]. SCP-[desg] ([class]) is no longer in its designated containment zone. All personnel are advised to exercise caution.",
		"SCP-[desg] Containment Breach Alert",
		'sounds/effects/siren.ogg'
	)
	addtimer(CALLBACK(src, PROC_REF(clear_alert)), alert_cooldown)

/obj/machinery/scp_containment_monitor/proc/clear_alert()
	alert_active = FALSE

/obj/machinery/scp_containment_monitor/attack_hand(mob/user)
	if(stat & (BROKEN|NOPOWER))
		to_chat(user, SPAN_WARNING("\The [src] is unresponsive."))
		return
	if(!linked_zone)
		to_chat(user, SPAN_WARNING("\The [src] has no linked containment zone."))
		return
	var/datum/scp/scp_datum = linked_zone.linked_scp
	var/data = linked_zone.get_data()
	to_chat(user, SPAN_NOTICE("<b>Containment Monitor - SCP-[data["designation"]]</b>"))
	to_chat(user, SPAN_NOTICE("Area: [data["area_name"]]"))
	to_chat(user, SPAN_NOTICE("Status: [data["status"]]"))
	to_chat(user, SPAN_NOTICE("Integrity: [data["integrity"]]%"))
	to_chat(user, SPAN_NOTICE("Power: [data["has_power"] ? "Online" : "Offline"]"))
	if(scp_datum && scp_datum.research)
		to_chat(user, SPAN_NOTICE("Research Tier: [scp_datum.research.get_tier_name()]"))
		to_chat(user, SPAN_NOTICE("Containment Rating: [scp_datum.research.containment_rating]"))

/obj/machinery/scp_containment_monitor/attackby(obj/item/W, mob/user)
	if(isWelder(W))
		if(stat & BROKEN)
			var/obj/item/weldingtool/WT = W
			if(!WT.remove_fuel(0, user))
				return
			to_chat(user, SPAN_NOTICE("You begin repairing \the [src]..."))
			if(do_after(user, 3 SECONDS, src))
				stat &= ~BROKEN
				to_chat(user, SPAN_NOTICE("You repair \the [src]."))
				update_icon()
			return
	. = ..()

GLOBAL_LIST_EMPTY(scp_containment_monitors)

/obj/item/device/scp_containment_meter
	name = "containment status meter"
	desc = "A handheld device that displays the containment status of all tracked SCPs on the site."
	icon = 'icons/obj/machines/scp_containment_meter.dmi'
	icon_state = "meter"
	item_state = "scp_meter"
	w_class = ITEM_SIZE_SMALL
	slot_flags = SLOT_BELT
	var/list/last_known_statuses = list()
	var/alert_range = 0
	var/show_detailed = FALSE

/obj/item/device/scp_containment_meter/attack_self(mob/user)
	show_status(user)

/obj/item/device/scp_containment_meter/proc/show_status(mob/user)
	if(!GLOB.scp_research_tracker)
		to_chat(user, SPAN_WARNING("Unable to connect to research database."))
		return
	var/list/data = GLOB.scp_research_tracker.get_all_scp_data()
	if(!length(data))
		to_chat(user, SPAN_WARNING("No SCP data available."))
		return
	var/list/output = list()
	output += "<b>SCP Containment Status Overview</b><br><br>"
	for(var/list/scp in data)
		var/status_color
		switch(scp["containment_status"])
			if(SCP_CONTAINED)
				status_color = "green"
			if(SCP_BREACHED)
				status_color = "red"
			if(SCP_UNKNOWN)
				status_color = "yellow"
			else
				status_color = "orange"
		output += "<span style='color:[status_color]'>SCP-[scp["designation"]] ([scp["classification"]]) - [scp["containment_status"]]</span>"
		if(show_detailed)
			output += " | Research: [SCP_RESEARCH_TIER_NAME(scp["research_level"])] | Rating: [scp["containment_rating"]] | Breaches: [scp["times_breached"]]"
		output += "<br>"
	var/datum/browser/popup = new(user, "scp_meter", "Containment Status", 400, 400)
	popup.set_content(jointext(output, ""))
	popup.open()
	update_last_statuses(data)

/obj/item/device/scp_containment_meter/proc/update_last_statuses(list/data)
	last_known_statuses = list()
	for(var/list/scp in data)
		last_known_statuses[scp["designation"]] = scp["containment_status"]

/obj/item/device/scp_containment_meter/Process()
	if(!ismob(loc))
		STOP_PROCESSING(SSobj, src)
		return
	check_for_changes()

/obj/item/device/scp_containment_meter/proc/check_for_changes()
	if(!GLOB.scp_research_tracker)
		return
	var/list/data = GLOB.scp_research_tracker.get_all_scp_data()
	for(var/list/scp in data)
		var/desg = scp["designation"]
		var/new_status = scp["containment_status"]
		var/old_status = last_known_statuses[desg]
		if(old_status && old_status != new_status)
			var/mob/user = loc
			if(ismob(user))
				switch(new_status)
					if(SCP_BREACHED)
						to_chat(user, SPAN_DANGER("<b>ALERT:</b> SCP-[desg] has breached containment!"))
						playsound(loc, 'sounds/machines/alarm.ogg', 30, 1)
					if(SCP_CONTAINED)
						to_chat(user, SPAN_NOTICE("<b>UPDATE:</b> SCP-[desg] has been recontained."))
						playsound(loc, 'sounds/machines/ping.ogg', 30, 1)
	update_last_statuses(data)

/obj/item/device/scp_containment_meter/pickup(mob/user)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/device/scp_containment_meter/dropped(mob/user)
	. = ..()
	STOP_PROCESSING(SSobj, src)

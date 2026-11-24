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
	tgui_interact(user)

/obj/item/device/scp_containment_meter/tgui_interact(mob/user, datum/tgui/ui)
	if(!GLOB.scp_research_tracker)
		to_chat(user, SPAN_WARNING("Unable to connect to research database."))
		return
	var/list/scp_data = GLOB.scp_research_tracker.get_all_scp_data()
	if(!length(scp_data))
		to_chat(user, SPAN_WARNING("No SCP data available."))
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ContainmentMeter", name)
		ui.open()

/obj/item/device/scp_containment_meter/tgui_data(mob/user)
	var/list/data = list()
	var/list/scps = list()
	if(GLOB.scp_research_tracker)
		var/list/scp_data = GLOB.scp_research_tracker.get_all_scp_data()
		update_last_statuses(scp_data)
		for(var/list/scp in scp_data)
			var/status = scp["containment_status"]
			var/status_color = "orange"
			switch(status)
				if(SCP_CONTAINED)
					status_color = "green"
				if(SCP_BREACHED)
					status_color = "red"
				if(SCP_UNKNOWN)
					status_color = "yellow"
			scps += list(list(
				"designation" = scp["designation"],
				"classification" = scp["classification"],
				"status" = status,
				"status_color" = status_color,
				"research" = SCP_RESEARCH_TIER_NAME(scp["research_level"]),
				"rating" = scp["containment_rating"],
				"breaches" = scp["times_breached"],
			))
	data["scps"] = scps
	data["show_detailed"] = show_detailed
	return data

/obj/item/device/scp_containment_meter/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	return FALSE

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

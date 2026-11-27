// Facility Morale — site-wide and per-zone personnel morale with timed
// modifiers and threshold effects. Ported from daedalusdock, adapted:
//  - priority_announcement instead of daedalus announce procs
//  - zone keys kept generic (LCZ/HCZ/EZ/Surface/Engineering/Medical)

#define FACILITY_MORALE_CRISIS 20
#define FACILITY_MORALE_LOW 40
#define FACILITY_MORALE_NORMAL 60
#define FACILITY_MORALE_HIGH 80
#define FACILITY_MORALE_EUPHORIC 95

SUBSYSTEM_DEF(facility_morale)
	name = "Facility Morale"
	wait = 30 SECONDS
	init_order = SS_INIT_MISC_LATE

	var/global_morale = FACILITY_MORALE_NORMAL
	var/morale_trend = 0
	var/list/morale_modifiers = list()
	var/list/morale_events_log = list()
	var/last_event_time = 0
	var/list/zone_morale = list(
		"LCZ" = FACILITY_MORALE_NORMAL,
		"HCZ" = FACILITY_MORALE_NORMAL,
		"EZ" = FACILITY_MORALE_NORMAL,
		"Surface" = FACILITY_MORALE_NORMAL,
		"Engineering" = FACILITY_MORALE_NORMAL,
		"Medical" = FACILITY_MORALE_NORMAL,
	)
	var/list/threshold_effects = list()

/datum/controller/subsystem/facility_morale/fire()
	recalculate_morale()
	decay_modifiers()
	apply_threshold_effects()
	check_morale_events()

/datum/controller/subsystem/facility_morale/proc/recalculate_morale()
	var/old_morale = global_morale
	var/base = FACILITY_MORALE_NORMAL
	var/total_mod = 0
	for(var/key in morale_modifiers)
		var/list/mod = morale_modifiers[key]
		total_mod += mod["amount"]
	global_morale = clamp(base + total_mod, 0, 100)
	morale_trend = global_morale - old_morale
	for(var/zone in zone_morale)
		var/zone_mod = 0
		for(var/key in morale_modifiers)
			var/list/mod = morale_modifiers[key]
			if(mod["zone"] == zone || mod["zone"] == "all")
				zone_mod += mod["amount"]
		zone_morale[zone] = clamp(base + zone_mod, 0, 100)

/datum/controller/subsystem/facility_morale/proc/decay_modifiers()
	var/list/to_remove = list()
	for(var/key in morale_modifiers)
		var/list/mod = morale_modifiers[key]
		if(mod["duration"] > 0)
			mod["duration"] -= wait
			if(mod["duration"] <= 0)
				to_remove += key
			else if(mod["decay_rate"] > 0)
				var/abs_val = abs(mod["amount"])
				var/sign = mod["amount"] >= 0 ? 1 : -1
				mod["amount"] = sign * max(0, abs_val - mod["decay_rate"])
	for(var/key in to_remove)
		morale_modifiers -= key

/datum/controller/subsystem/facility_morale/proc/add_morale_modifier(source, amount, zone, duration, decay_rate)
	if(!source)
		return
	morale_modifiers[source] = list(
		"amount" = amount,
		"zone" = zone || "all",
		"duration" = duration || 0,
		"decay_rate" = decay_rate || 0,
		"timestamp" = world.time,
	)
	log_morale_event(source, amount, zone)

/datum/controller/subsystem/facility_morale/proc/remove_morale_modifier(source)
	morale_modifiers -= source

/datum/controller/subsystem/facility_morale/proc/log_morale_event(source, amount, zone)
	morale_events_log += list(list(
		"source" = source,
		"amount" = amount,
		"zone" = zone || "all",
		"time" = time2text(world.time, "hh:mm:ss"),
		"current_morale" = global_morale,
	))
	if(length(morale_events_log) > 200)
		morale_events_log.Cut(1, 50)
	last_event_time = world.time

/datum/controller/subsystem/facility_morale/proc/apply_threshold_effects()
	threshold_effects = list()
	if(global_morale <= FACILITY_MORALE_CRISIS)
		threshold_effects += list("CRISIS: All actions 30% slower", "CRISIS: Research output halved", "CRISIS: Increased SCP breach chance")
	else if(global_morale <= FACILITY_MORALE_LOW)
		threshold_effects += list("LOW: All actions 15% slower", "LOW: Research output reduced 25%", "LOW: Minor SCP unrest chance")
	else if(global_morale >= FACILITY_MORALE_EUPHORIC)
		threshold_effects += list("EUPHORIC: All actions 10% faster", "EUPHORIC: Research output +25%", "EUPHORIC: Reduced SCP agitation")

/datum/controller/subsystem/facility_morale/proc/check_morale_events()
	if(global_morale <= FACILITY_MORALE_CRISIS && prob(10))
		priority_announcement.Announce("Facility morale has reached CRITICAL levels. All personnel are advised to take a break and use recreational facilities.", "MORALE CRISIS")
	else if(global_morale >= FACILITY_MORALE_EUPHORIC && prob(5))
		priority_announcement.Announce("Facility morale is at an all-time high. Outstanding work, personnel.", "MORALE ADVISORY")

/datum/controller/subsystem/facility_morale/proc/get_morale_label()
	if(global_morale <= FACILITY_MORALE_CRISIS)
		return "CRISIS"
	if(global_morale <= FACILITY_MORALE_LOW)
		return "LOW"
	if(global_morale <= FACILITY_MORALE_HIGH)
		return "NORMAL"
	if(global_morale <= FACILITY_MORALE_EUPHORIC)
		return "HIGH"
	return "EUPHORIC"

/datum/controller/subsystem/facility_morale/proc/get_speed_mult()
	if(global_morale <= FACILITY_MORALE_CRISIS)
		return 1.3
	if(global_morale <= FACILITY_MORALE_LOW)
		return 1.15
	if(global_morale >= FACILITY_MORALE_EUPHORIC)
		return 0.9
	return 1.0

/datum/controller/subsystem/facility_morale/proc/get_research_mult()
	if(global_morale <= FACILITY_MORALE_CRISIS)
		return 0.5
	if(global_morale <= FACILITY_MORALE_LOW)
		return 0.75
	if(global_morale >= FACILITY_MORALE_EUPHORIC)
		return 1.25
	return 1.0

/datum/controller/subsystem/facility_morale/proc/get_breach_chance_mult()
	if(global_morale <= FACILITY_MORALE_CRISIS)
		return 1.5
	if(global_morale <= FACILITY_MORALE_LOW)
		return 1.2
	if(global_morale >= FACILITY_MORALE_EUPHORIC)
		return 0.7
	return 1.0

/obj/machinery/facility_morale_console
	name = "Facility morale console"
	desc = "A console for monitoring and managing facility-wide personnel morale."
	icon = 'icons/obj/computer.dmi'
	icon_state = "command"
	anchored = TRUE
	density = TRUE
	use_power = POWER_USE_IDLE
	idle_power_usage = 300
	active_power_usage = 500

/obj/machinery/facility_morale_console/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ScpMoraleProgram", "Facility Morale")
		ui.set_autoupdate(TRUE)
		ui.open()

/obj/machinery/facility_morale_console/tgui_state(mob/user)
	return GLOB.physical_tgui_state

/obj/machinery/facility_morale_console/tgui_data(mob/user)
	var/list/data = list()
	data["global_morale"] = SSfacility_morale.global_morale
	data["morale_label"] = SSfacility_morale.get_morale_label()
	data["morale_trend"] = SSfacility_morale.morale_trend
	data["zone_morale"] = SSfacility_morale.zone_morale.Copy()
	data["active_modifiers"] = list()
	for(var/key in SSfacility_morale.morale_modifiers)
		var/list/mod = SSfacility_morale.morale_modifiers[key]
		data["active_modifiers"] += list(list(
			"source" = key,
			"amount" = mod["amount"],
			"zone" = mod["zone"],
			"remaining" = max(0, round(mod["duration"] / 10)),
		))
	var/list/events = SSfacility_morale.morale_events_log
	data["recent_events"] = events.Copy(max(1, length(events) - 19), 0)
	data["speed_mult"] = SSfacility_morale.get_speed_mult()
	data["research_mult"] = SSfacility_morale.get_research_mult()
	data["breach_mult"] = SSfacility_morale.get_breach_chance_mult()
	data["threshold_effects"] = SSfacility_morale.threshold_effects.Copy()
	data["zones"] = list()
	for(var/zone in SSfacility_morale.zone_morale)
		data["zones"] += list(list(
			"name" = zone,
			"morale" = SSfacility_morale.zone_morale[zone],
		))
	return data

/obj/machinery/facility_morale_console/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	var/mob/living/carbon/human/H = ui?.user || usr
	if(!istype(H))
		return
	switch(action)
		if("boost_morale")
			SSfacility_morale.add_morale_modifier("manual_boost_[H.ckey]", 5, "all", 5 MINUTES, 1)
			to_chat(H, SPAN_NOTICE("Facility-wide morale boost initiated. +5 morale for 5 minutes."))
			return TRUE
		if("zone_boost")
			var/zone = params["zone"]
			if(!zone || !SSfacility_morale.zone_morale[zone])
				return
			SSfacility_morale.add_morale_modifier("zone_boost_[zone]_[H.ckey]", 8, zone, 3 MINUTES, 1.5)
			to_chat(H, SPAN_NOTICE("Morale boost applied to [zone]. +8 for 3 minutes."))
			return TRUE
	return FALSE

#undef FACILITY_MORALE_CRISIS
#undef FACILITY_MORALE_LOW
#undef FACILITY_MORALE_NORMAL
#undef FACILITY_MORALE_HIGH
#undef FACILITY_MORALE_EUPHORIC

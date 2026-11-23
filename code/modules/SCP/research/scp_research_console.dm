/obj/machinery/scp_research_console
	name = "SCP research console"
	desc = "A dedicated terminal for tracking SCP research progress, containment status, and authorizing tests."
	icon = 'icons/obj/computer.dmi'
	icon_state = "rdcomp"
	anchored = TRUE
	density = TRUE
	use_power = POWER_USE_IDLE
	idle_power_usage = 300
	active_power_usage = 500
	var/selected_scp = null
	var/current_tab = "overview"
	var/required_access = ACCESS_SCIENCE_LVL3

#define SCP_VERIFY_COOLDOWN 5 MINUTES
#define SCP_VERIFY_POINTS   10

/obj/machinery/scp_research_console/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SCPDatabase", "SCP Research Console")
		ui.open()

/obj/machinery/scp_research_console/tgui_data(mob/user)
	var/list/data = list()
	data["tab"] = current_tab
	data["selected_scp"] = selected_scp
	data["scp_list"] = GLOB.scp_research_tracker ? GLOB.scp_research_tracker.get_all_scp_data() : list()
	data["breach_log"] = GLOB.scp_research_tracker ? GLOB.scp_research_tracker.breach_log : list()
	data["test_log"] = GLOB.scp_research_tracker ? GLOB.scp_research_tracker.test_log : list()
	data["active_breaches"] = GLOB.scp_research_tracker ? GLOB.scp_research_tracker.get_active_breaches() : list()
	data["total_breaches"] = GLOB.scp_research_tracker ? GLOB.scp_research_tracker.total_breaches_this_round : 0
	data["PC_device_theme"] = "scp_terminal"
	data["dclass_requests"] = list()
	for(var/datum/dclass_request/R in GLOB.dclass_requests)
		if(R.status == DCLASS_REQUEST_OPEN || R.status == DCLASS_REQUEST_ARRIVED)
			data["dclass_requests"] += list(R.get_data())
	data["codex_entry"] = user?.ckey && SSscp_codex?.manager ? SSscp_codex.manager.get_entry_display(user.ckey, selected_scp) : null
	data["codex_progress"] = user?.ckey && SSscp_codex?.manager ? SSscp_codex.manager.get_player_progress(user.ckey) : null
	if(selected_scp)
		var/datum/scp_research/research = GLOB.scp_research_tracker.get_research(selected_scp)
		if(research)
			data["scp_detail"] = research.get_data()
			data["containment_history"] = research.containment_history
			data["can_test"] = research.can_test()
			data["test_cooldown_remaining"] = research.can_test() ? 0 : round((research.last_test_time + research.test_cooldown - world.time) / 10, 1)
			data["open_request"] = get_open_dclass_request(selected_scp) ? get_open_dclass_request(selected_scp).get_data() : null
			data["personality_traits"] = SSscp_personality ? SSscp_personality.get_traits_data(selected_scp) : list()
			var/datum/containment_zone/zone = null
			for(var/datum/containment_zone/CZ in GLOB.containment_zones)
				if(CZ.scp_designation == selected_scp)
					zone = CZ
					break
			if(zone)
				data["zone_data"] = zone.get_data()
				data["can_verify"] = world.time >= (zone.last_verify_time + SCP_VERIFY_COOLDOWN)
				data["verify_cooldown_remaining"] = data["can_verify"] ? 0 : round((zone.last_verify_time + SCP_VERIFY_COOLDOWN - world.time) / 10, 1)
			data["countermeasure"] = get_countermeasure_data(selected_scp)
			if(selected_scp == "216")
				var/datum/scp_research/r216 = GLOB.scp_research_tracker.get_research("216")
				var/known = get_scp216_known_codes(r216 ? r216.research_level : 0)
				if(known)
					data["known_codes"] = known
	return data

/obj/machinery/scp_research_console/tgui_act(act, params, mob/user)
	if(..())
		return TRUE
	if(stat & (BROKEN|NOPOWER))
		return
	switch(act)
		if("PRG_select_scp")
			selected_scp = params["designation"]
			current_tab = "detail"
			return TRUE
		if("PRG_switch_tab")
			current_tab = params["tab"]
			return TRUE
		if("PRG_log_test")
			if(!selected_scp)
				return
			if(!allowed(user))
				to_chat(user, SPAN_WARNING("Access denied. Level 3 science clearance required to authorize tests."))
				return
			var/datum/scp_research/research = GLOB.scp_research_tracker.get_research(selected_scp)
			if(!research || !research.can_test())
				return
			var/test_type = params["test_type"] || "observation"
			var/risk = params["risk"] || "low"
			if(risk == "extreme" || test_type == "crosstest")
				var/confirm = alert(user, "This test carries extreme risk. Are you sure?", "Confirm Extreme Test", "Yes", "No")
				if(confirm != "Yes")
					return
			var/points = research.perform_test(user, test_type, risk)
			if(points)
				to_chat(user, SPAN_NOTICE("Test authorized and logged. +[points] research points."))
				if(test_type == "dclass")
					var/datum/dclass_request/R = get_open_dclass_request(selected_scp)
					if(R)
						R.complete(user)
			return TRUE
		if("PRG_request_dclass")
			if(!selected_scp)
				return
			if(!allowed(user))
				to_chat(user, SPAN_WARNING("Access denied. Level 3 science clearance required to request test subjects."))
				return
			var/datum/scp_research/research = GLOB.scp_research_tracker.get_research(selected_scp)
			if(!research)
				return
			if(get_open_dclass_request(selected_scp))
				to_chat(user, SPAN_WARNING("There is already an open D-Class request for SCP-[selected_scp]."))
				return
			var/atom/scp_atom = research.parent
			if(!scp_atom)
				return
			if(research.containment_status == SCP_BREACHED)
				to_chat(user, SPAN_WARNING("SCP-[selected_scp] is breached. Requesting test subjects during a breach is prohibited."))
				return
			var/risk = params["risk"] || "high"
			new /datum/dclass_request(selected_scp, research, user, "dclass", risk)
			to_chat(user, SPAN_NOTICE("D-Class request filed for SCP-[selected_scp]. Security has been notified."))
			return TRUE
		if("PRG_cancel_dclass")
			if(!selected_scp)
				return
			if(!allowed(user))
				to_chat(user, SPAN_WARNING("Access denied."))
				return
			var/datum/dclass_request/R = get_open_dclass_request(selected_scp)
			if(!R)
				return
			R.cancel(user)
			return TRUE
		if("PRG_verify_containment")
			if(!selected_scp)
				return
			if(!allowed(user))
				to_chat(user, SPAN_WARNING("Access denied. Level 3 science clearance required."))
				return
			var/datum/containment_zone/zone = null
			for(var/datum/containment_zone/CZ in GLOB.containment_zones)
				if(CZ.scp_designation == selected_scp)
					zone = CZ
					break
			if(!zone)
				to_chat(user, SPAN_WARNING("No containment zone registered for SCP-[selected_scp]."))
				return
			if(world.time < (zone.last_verify_time + SCP_VERIFY_COOLDOWN))
				to_chat(user, SPAN_WARNING("Containment verification is recharging. [round((zone.last_verify_time + SCP_VERIFY_COOLDOWN - world.time) / (1 MINUTES), 1)] minutes remaining."))
				return
			zone.last_verify_time = world.time
			var/datum/scp_research/research = GLOB.scp_research_tracker.get_research(selected_scp)
			var/atom/scp_atom = research ? research.parent : null
			var/in_zone = scp_atom && (get_area(scp_atom) == zone.zone_area)
			var/report = "VERIFICATION SCAN - SCP-[selected_scp] - [station_time_timestamp()]<br>"
			report += "Zone: [zone.zone_area ? zone.zone_area.name : "Unknown"]<br>"
			report += "Zone power: [zone.has_power ? "ONLINE" : "OFFLINE"]<br>"
			report += "Zone integrity: [zone.integrity]%<br>"
			if(scp_atom)
				report += "Anomaly location: [in_zone ? "IN ZONE - CONTAINED" : "OUT OF ZONE - [get_area(scp_atom)]"]<br>"
			else
				report += "Anomaly not registered on site network.<br>"
			to_chat(user, SPAN_NOTICE("[report]"))
			log_and_message_staff("Containment verification scan run on SCP-[selected_scp] by [key_name(user)]: [in_zone ? "contained" : "NOT IN ZONE"].")
			if(research && in_zone && research.containment_status == SCP_CONTAINED)
				research.add_research_points(SCP_VERIFY_POINTS, "verification_scan")
				to_chat(user, SPAN_NOTICE("Verification confirmed. +[SCP_VERIFY_POINTS] research points."))
			else if(research && !in_zone && research.containment_status == SCP_CONTAINED)
				to_chat(user, SPAN_DANGER("WARNING: SCP-[selected_scp] registered as contained but is not in its zone. Notify Site Security immediately."))
			return TRUE
		if("PRG_fabricate_countermeasure")
			if(!selected_scp)
				return
			if(!allowed(user))
				to_chat(user, SPAN_WARNING("Access denied. Level 3 science clearance required."))
				return
			var/list/cm = get_countermeasure_data(selected_scp)
			if(!cm)
				to_chat(user, SPAN_WARNING("No countermeasure program exists for SCP-[selected_scp]."))
				return
			if(!cm["unlocked"])
				to_chat(user, SPAN_WARNING("Countermeasure locked: SCP-[selected_scp] research must reach [SCP_RESEARCH_TIER_NAME(cm["required_tier"])] tier first."))
				return
			var/type_path = text2path(cm["type"])
			if(!type_path)
				return
			new type_path(get_turf(src))
			to_chat(user, SPAN_NOTICE("[cm["name"]] fabricated at the console."))
			log_and_message_staff("[key_name(user)] fabricated [cm["name"]] (SCP-[selected_scp] tier reward).")
			return TRUE
		if("PRG_clear_selection")
			selected_scp = null
			current_tab = "overview"
			return TRUE

/obj/machinery/scp_research_console/on_update_icon()
	if(stat & BROKEN)
		icon_state = "rdcompb"
		return
	if(stat & NOPOWER)
		icon_state = "rdcomp0"
		return
	icon_state = "rdcomp"

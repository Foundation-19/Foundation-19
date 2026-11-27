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
			var/datum/dclass_request/console_open_request = get_open_dclass_request(selected_scp)
			data["dclass_arrived"] = console_open_request ? (console_open_request.status == DCLASS_REQUEST_ARRIVED) : FALSE
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
	var/list/director_data = list()
	if(GLOB.scp_research_director)
		var/datum/scp_research_director/D = GLOB.scp_research_director
		director_data["pool"] = D.site_research_points
		director_data["total_earned"] = D.total_points_earned
		director_data["safety_rating"] = D.safety_rating
		director_data["research_multiplier"] = round((D.tech_tree.get_research_multiplier() - 1) * 100)
		director_data["sanity_resist"] = round(D.tech_tree.get_sanity_resist() * 100)
		director_data["containment_floor"] = D.tech_tree.get_containment_floor()
		director_data["tech_nodes"] = D.tech_tree.get_all_nodes_data()
		director_data["projects"] = D.get_projects_data()
		director_data["teams"] = D.get_teams_data()
		director_data["research_log"] = D.research_log
		director_data["achievements"] = D.achievements
		var/list/catalog = list()
		for(var/typepath in D.tech_tree.get_catalog_items())
			catalog += list(list("type" = "[typepath]", "name" = D.tech_tree.get_catalog_items()[typepath]))
		director_data["catalog"] = catalog
	data["director"] = director_data
	// Cross-SCP interaction registry.
	var/list/interaction_list = list()
	var/discovered_count = 0
	if(SSscp_cross_interactions && SSscp_cross_interactions.setup_complete)
		for(var/interaction_id in SSscp_cross_interactions.interactions)
			var/datum/cross_scp_interaction/I = SSscp_cross_interactions.interactions[interaction_id]
			if(I.discovered)
				discovered_count++
			interaction_list += list(list(
				"id" = I.interaction_id,
				"name" = I.name,
				"description" = I.discovered ? I.description : "",
				"scp1" = I.scp_id_1,
				"scp2" = I.scp_id_2,
				"tier" = I.tier,
				"discovered" = I.discovered,
				"discovered_by" = I.discovered_by,
				"trigger_count" = I.trigger_count,
				"req1" = I.research_required_scp1,
				"req2" = I.research_required_scp2,
			))
	data["interactions"] = interaction_list
	data["discovered_count"] = discovered_count
	data["total_count"] = interaction_list.len
	return data

/obj/machinery/scp_research_console/tgui_act(act, params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	var/mob/user = ui?.user || usr
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
		// ---- Site research overhaul actions ----
		if("PRG_unlock_node")
			if(!allowed(user))
				to_chat(user, SPAN_WARNING("Access denied. Level 3 science clearance required to unlock research."))
				return
			GLOB.scp_research_director.try_unlock_node(params["node_id"], user)
			return TRUE
		if("PRG_create_project")
			if(!allowed(user))
				to_chat(user, SPAN_WARNING("Access denied. Level 3 science clearance required."))
				return
			var/title = tgui_input_text(user, "Project title:", "New Research Project", "SCP Study", MAX_NAME_LEN)
			if(!title)
				return
			var/required = input(user, "Required research points (50-1000):", "New Research Project", 200) as null|num
			if(isnull(required))
				return
			required = clamp(round(required), 50, 1000)
			var/list/targets = list()
			if(selected_scp)
				targets += selected_scp
			var/desc = tgui_input_text(user, "Description (optional):", "New Research Project", "", 200)
			var/datum/scp_research_project/project = GLOB.scp_research_director.create_project(title, desc || "", targets, required, user)
			if(project)
				to_chat(user, SPAN_NOTICE("Research project '[title]' filed for approval ([required] points, target: [targets.len ? "SCP-[selected_scp]" : "any SCP"])."))
			return TRUE
		if("PRG_approve_project")
			if(!allowed(user))
				to_chat(user, SPAN_WARNING("Access denied. Level 3 science clearance required."))
				return
			var/datum/scp_research_project/project = find_project_by_id(params["project_id"])
			if(project && GLOB.scp_research_director.approve_project(project, user))
				to_chat(user, SPAN_NOTICE("Project '[project.title]' approved. Staff may now contribute research points."))
			return TRUE
		if("PRG_revoke_project")
			if(!allowed(user))
				to_chat(user, SPAN_WARNING("Access denied. Level 3 science clearance required."))
				return
			var/datum/scp_research_project/project = find_project_by_id(params["project_id"])
			if(project && GLOB.scp_research_director.revoke_project(project, user))
				to_chat(user, SPAN_NOTICE("Project '[project.title]' revoked."))
			return TRUE
		if("PRG_create_team")
			if(!allowed(user))
				to_chat(user, SPAN_WARNING("Access denied. Level 3 science clearance required."))
				return
			var/datum/scp_research_team/team = GLOB.scp_research_director.create_team(null, user)
			if(team)
				to_chat(user, SPAN_NOTICE("Formed [team.name] with you as leader."))
			return TRUE
		if("PRG_request_join")
			var/team_id = params["team_id"]
			for(var/datum/scp_research_team/team in GLOB.scp_research_director.teams)
				if(team.id == team_id)
					if(GLOB.scp_research_director.request_team_join(team, user))
						to_chat(user, SPAN_NOTICE("Join request sent to [team.name]."))
					return TRUE
			return TRUE
		if("PRG_approve_join")
			var/team_id = params["team_id"]
			var/ckey_name = params["ckey"]
			for(var/datum/scp_research_team/team in GLOB.scp_research_director.teams)
				if(team.id == team_id)
					GLOB.scp_research_director.approve_join(team, ckey_name, user)
					return TRUE
			return TRUE
		if("PRG_deny_join")
			var/team_id = params["team_id"]
			var/ckey_name = params["ckey"]
			for(var/datum/scp_research_team/team in GLOB.scp_research_director.teams)
				if(team.id == team_id)
					GLOB.scp_research_director.deny_join(team, ckey_name)
					return TRUE
			return TRUE
		if("PRG_fabricate_catalog")
			if(!allowed(user))
				to_chat(user, SPAN_WARNING("Access denied. Level 3 science clearance required."))
				return
			var/type_path = text2path(params["type"])
			if(!type_path)
				return
			var/catalog_items = GLOB.scp_research_director.tech_tree.get_catalog_items()
			if(!(type_path in catalog_items))
				to_chat(user, SPAN_WARNING("That item is not unlocked in the research catalog."))
				return
			new type_path(get_turf(src))
			to_chat(user, SPAN_NOTICE("[catalog_items[type_path]] fabricated at the console."))
			log_and_message_staff("[key_name(user)] fabricated [catalog_items[type_path]] (research catalog).")
			return TRUE

/obj/machinery/scp_research_console/proc/find_project_by_id(project_id)
	var/wanted = text2num(project_id)
	for(var/datum/scp_research_project/project in GLOB.scp_research_director.projects)
		if(project.id == wanted)
			return project
	return null

/obj/machinery/scp_research_console/on_update_icon()
	if(stat & BROKEN)
		icon_state = "rdcompb"
		return
	if(stat & NOPOWER)
		icon_state = "rdcomp0"
		return
	icon_state = "rdcomp"

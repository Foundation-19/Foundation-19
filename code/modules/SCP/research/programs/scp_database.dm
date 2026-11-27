/datum/computer_file/program/scp_database
	filename = "scp_db"
	filedesc = "SCP Database & Research"
	program_icon_state = "generic"
	program_key_state = "generic_key"
	extended_desc = "A comprehensive database and research tracking system for SCP Foundation anomalies."
	size = 24
	requires_ntnet = 0
	available_on_ntnet = 0
	available_on_syndinet = 0
	required_access = ACCESS_SCIENCE_LVL1
	tgui_id = "SCPDatabase"
	var/selected_scp = null
	var/current_tab = "overview"

/datum/computer_file/program/scp_database/tgui_data(mob/user)
	var/list/data = get_header_data()
	data["tab"] = current_tab
	data["user_ckey"] = user?.ckey
	data["selected_scp"] = selected_scp
	data["scp_list"] = GLOB.scp_research_tracker ? GLOB.scp_research_tracker.get_all_scp_data() : list()
	data["breach_log"] = GLOB.scp_research_tracker ? GLOB.scp_research_tracker.breach_log : list()
	data["test_log"] = GLOB.scp_research_tracker ? GLOB.scp_research_tracker.test_log : list()
	data["active_breaches"] = GLOB.scp_research_tracker ? GLOB.scp_research_tracker.get_active_breaches() : list()
	data["total_breaches"] = GLOB.scp_research_tracker ? GLOB.scp_research_tracker.total_breaches_this_round : 0
	data["dclass_requests"] = list()
	for(var/datum/dclass_request/R in GLOB.dclass_requests)
		if(R.status == DCLASS_REQUEST_OPEN || R.status == DCLASS_REQUEST_ARRIVED)
			data["dclass_requests"] += list(R.get_data())
	if(selected_scp)
		var/datum/scp_research/research = GLOB.scp_research_tracker.get_research(selected_scp)
		if(research)
			data["scp_detail"] = research.get_data()
			data["containment_history"] = research.containment_history
			data["can_test"] = research.can_test()
			data["test_cooldown_remaining"] = research.can_test() ? 0 : round((research.last_test_time + research.test_cooldown - world.time) / 10, 1)
			var/datum/dclass_request/open_request = get_open_dclass_request(selected_scp)
			if(open_request)
				data["open_request"] = open_request.get_data()
				data["dclass_arrived"] = (open_request.status == DCLASS_REQUEST_ARRIVED)
	return data

/datum/computer_file/program/scp_database/tgui_act(act, params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	var/mob/user = ui?.user || usr
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
			if(!program_has_access(usr, 1, ACCESS_SCIENCE_LVL3))
				to_chat(usr, SPAN_WARNING("Access denied. Level 3 science clearance required to authorize tests."))
				return
			var/datum/scp_research/research = GLOB.scp_research_tracker.get_research(selected_scp)
			if(!research || !research.can_test())
				return
			var/test_type = params["test_type"] || "observation"
			var/risk = params["risk"] || "low"
			if(risk == "extreme" || test_type == "crosstest")
				var/confirm = alert(usr, "This test carries extreme risk. Are you sure?", "Confirm Extreme Test", "Yes", "No")
				if(confirm != "Yes")
					return
			var/points = research.perform_test(usr, test_type, risk)
			if(points)
				to_chat(usr, SPAN_NOTICE("Test authorized and logged. +[points] research points."))
			return TRUE
		if("PRG_request_dclass")
			if(!selected_scp)
				return
			if(!program_has_access(usr, 1, ACCESS_SCIENCE_LVL3))
				to_chat(usr, SPAN_WARNING("Access denied. Level 3 science clearance required to request test subjects."))
				return
			var/datum/scp_research/research = GLOB.scp_research_tracker.get_research(selected_scp)
			if(!research)
				return
			if(get_open_dclass_request(selected_scp))
				to_chat(usr, SPAN_WARNING("There is already an open D-Class request for SCP-[selected_scp]."))
				return
			var/atom/scp_atom = research.parent
			if(!scp_atom)
				return
			if(research.containment_status == SCP_BREACHED)
				to_chat(usr, SPAN_WARNING("SCP-[selected_scp] is breached. Requesting test subjects during a breach is prohibited."))
				return
			var/risk = params["risk"] || "high"
			new /datum/dclass_request(selected_scp, research, usr, "dclass", risk)
			to_chat(usr, SPAN_NOTICE("D-Class request filed for SCP-[selected_scp]. Security has been notified."))
			return TRUE
		if("PRG_cancel_dclass")
			if(!selected_scp)
				return
			if(!program_has_access(usr, 1, ACCESS_SCIENCE_LVL3))
				to_chat(usr, SPAN_WARNING("Access denied."))
				return
			var/datum/dclass_request/R = get_open_dclass_request(selected_scp)
			if(!R)
				return
			R.cancel(usr)
			return TRUE
		if("PRG_clear_selection")
			selected_scp = null
			current_tab = "overview"
			return TRUE

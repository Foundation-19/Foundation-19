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
	data["selected_scp"] = selected_scp
	data["scp_list"] = GLOB.scp_research_tracker ? GLOB.scp_research_tracker.get_all_scp_data() : list()
	data["breach_log"] = GLOB.scp_research_tracker ? GLOB.scp_research_tracker.breach_log : list()
	data["test_log"] = GLOB.scp_research_tracker ? GLOB.scp_research_tracker.test_log : list()
	data["active_breaches"] = GLOB.scp_research_tracker ? GLOB.scp_research_tracker.get_active_breaches() : list()
	data["total_breaches"] = GLOB.scp_research_tracker ? GLOB.scp_research_tracker.total_breaches_this_round : 0
	if(selected_scp)
		var/datum/scp_research/research = GLOB.scp_research_tracker.get_research(selected_scp)
		if(research)
			data["scp_detail"] = research.get_data()
			data["containment_history"] = research.containment_history
			data["can_test"] = research.can_test()
			data["test_cooldown_remaining"] = research.can_test() ? 0 : round((research.last_test_time + research.test_cooldown - world.time) / 10, 1)
	return data

/datum/computer_file/program/scp_database/tgui_act(act, params, mob/user)
	if(..())
		return TRUE
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
			var/datum/scp_research/research = GLOB.scp_research_tracker.get_research(selected_scp)
			if(!research || !research.can_test())
				return
			var/test_type = params["test_type"] || "observation"
			var/risk = params["risk"] || "low"
			var/points = research.perform_test(user, test_type, risk)
			if(points)
				to_chat(user, SPAN_NOTICE("Test logged successfully. +[points] research points."))
			return TRUE
		if("PRG_clear_selection")
			selected_scp = null
			current_tab = "overview"
			return TRUE

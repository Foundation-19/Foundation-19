// Research Laboratory program — ported from daedalusdock research_laboratory.
// Laptop/tablet program exposing the site research overhaul: tech tree,
// projects, teams, safety, logs. Uses the same director APIs as the console.

/datum/computer_file/program/research_laboratory
	filename = "research_lab"
	filedesc = "Research Laboratory"
	program_icon_state = "generic"
	program_key_state = "generic_key"
	program_menu_icon = "flask"
	extended_desc = "Foundation site research management: technology tree, research projects, teams and safety protocols."
	size = 18
	requires_ntnet = FALSE
	available_on_ntnet = TRUE
	required_access = ACCESS_SCIENCE_LVL2
	tgui_id = "ResearchLab"
	var/selected_scp = null

/datum/computer_file/program/research_laboratory/tgui_data(mob/user)
	var/list/data = get_header_data()
	data["selected_scp"] = selected_scp
	data["scp_list"] = GLOB.scp_research_tracker ? GLOB.scp_research_tracker.get_all_scp_data() : list()
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
	if(selected_scp)
		var/datum/scp_research/research = GLOB.scp_research_tracker.get_research(selected_scp)
		if(research)
			data["scp_detail"] = research.get_data()
	return data

/datum/computer_file/program/research_laboratory/tgui_act(act, params, mob/user)
	if(..())
		return TRUE
	// Program access: level 3 science required for management actions.
	var/can_manage = program_has_access(user, 0, ACCESS_SCIENCE_LVL3)
	switch(act)
		if("PRG_select_scp")
			selected_scp = params["designation"]
			return TRUE
		if("PRG_unlock_node")
			if(!can_manage)
				to_chat(user, SPAN_WARNING("Access denied. Level 3 science clearance required."))
				return TRUE
			GLOB.scp_research_director.try_unlock_node(params["node_id"], user)
			return TRUE
		if("PRG_create_project")
			if(!can_manage)
				to_chat(user, SPAN_WARNING("Access denied. Level 3 science clearance required."))
				return TRUE
			var/title = tgui_input_text(user, "Project title:", "New Research Project", "SCP Study", MAX_NAME_LEN)
			if(!title)
				return TRUE
			var/required = input(user, "Required research points (50-1000):", "New Research Project", 200) as null|num
			if(isnull(required))
				return TRUE
			required = clamp(round(required), 50, 1000)
			var/list/targets = list()
			if(selected_scp)
				targets += selected_scp
			var/desc = tgui_input_text(user, "Description (optional):", "New Research Project", "", 200)
			var/datum/scp_research_project/project = GLOB.scp_research_director.create_project(title, desc || "", targets, required, user)
			if(project)
				to_chat(user, SPAN_NOTICE("Research project '[title]' filed for approval."))
			return TRUE
		if("PRG_approve_project")
			if(!can_manage)
				return TRUE
			var/wanted = text2num(params["project_id"])
			for(var/datum/scp_research_project/project in GLOB.scp_research_director.projects)
				if(project.id == wanted)
					GLOB.scp_research_director.approve_project(project, user)
					return TRUE
			return TRUE
		if("PRG_revoke_project")
			if(!can_manage)
				return TRUE
			var/wanted = text2num(params["project_id"])
			for(var/datum/scp_research_project/project in GLOB.scp_research_director.projects)
				if(project.id == wanted)
					GLOB.scp_research_director.revoke_project(project, user)
					return TRUE
			return TRUE
		if("PRG_create_team")
			if(!can_manage)
				return TRUE
			var/datum/scp_research_team/team = GLOB.scp_research_director.create_team(null, user)
			if(team)
				to_chat(user, SPAN_NOTICE("Formed [team.name] with you as leader."))
			return TRUE
		if("PRG_request_join")
			var/team_id = params["team_id"]
			for(var/datum/scp_research_team/team in GLOB.scp_research_director.teams)
				if(team.id == team_id)
					GLOB.scp_research_director.request_team_join(team, user)
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
			if(!can_manage)
				return TRUE
			var/type_path = text2path(params["type"])
			if(!type_path)
				return TRUE
			var/catalog_items = GLOB.scp_research_director.tech_tree.get_catalog_items()
			if(!(type_path in catalog_items))
				to_chat(user, SPAN_WARNING("That item is not unlocked in the research catalog."))
				return TRUE
			new type_path(get_turf(computer))
			to_chat(user, SPAN_NOTICE("[catalog_items[type_path]] printed from the computer."))
			log_and_message_staff("[key_name(user)] fabricated [catalog_items[type_path]] (research catalog).")
			return TRUE
		if("PRG_clear_selection")
			selected_scp = null
			return TRUE
	return FALSE

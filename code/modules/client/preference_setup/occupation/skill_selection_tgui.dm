// TGUI skill selection for Foundation-19 character setup.
// Replaces the legacy HTML popup (open_skill_setup / generate_skill_content).
// A dedicated ui datum so the window can be opened per-job.

/datum/skill_selection_ui
	var/datum/preferences/preferences
	var/datum/job/selected_job

/datum/skill_selection_ui/New(datum/preferences/prefs, datum/job/job)
	preferences = prefs
	selected_job = job

/datum/skill_selection_ui/tgui_state(mob/user)
	return GLOB.always_tgui_state

/datum/skill_selection_ui/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SkillSelection", "SKILL ALLOCATION — " + (selected_job ? selected_job.title : "?"), 700, 760)
		ui.open()

/datum/skill_selection_ui/tgui_data(mob/user)
	var/list/data = list()
	if(!preferences || !selected_job)
		return data
	var/datum/job/job = selected_job
	data["job_title"] = job.title
	data["points_remaining"] = preferences.points_by_job[job] || 0

	var/decl/hierarchy/skill/root = decls_repository.get_decl(/decl/hierarchy/skill)
	var/list/categories = list()
	for(var/decl/hierarchy/skill/cat in root.children)
		var/list/cat_data = list("name" = cat.name, "skills" = list())
		for(var/decl/hierarchy/skill/S in cat.children)
			var/list/row = preferences.get_skill_row_data(job, S)
			cat_data["skills"] += list(row)
			for(var/decl/hierarchy/skill/perk in S.children)
				cat_data["skills"] += list(preferences.get_skill_row_data(job, perk))
		categories += list(cat_data)
	data["categories"] = categories
	return data

/datum/skill_selection_ui/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if(!preferences || !selected_job)
		return TRUE
	var/mob/user = usr

	switch(action)
		if("set_skill")
			var/decl/hierarchy/skill/S = locate(params["skill"])
			var/value = text2num(params["value"])
			if(istype(S) && isnum(value))
				var/datum/category_item/player_setup_item/occupation/occupation_item = preferences.player_setup ? preferences.player_setup.locate_item("Occupation") : null
				if(occupation_item)
					occupation_item.update_skill_value(selected_job, S, value)
					SStgui.update_uis(src)
					return TRUE
		if("info")
			var/decl/hierarchy/skill/S = locate(params["skill"])
			if(istype(S))
				var/list/out = list()
				out += "[S.name]"
				for(var/i = 1, i <= length(S.levels), i++)
					out += "<b>[S.levels[i]]</b>: [S.levels[S.levels[i]]]"
				to_chat(user, jointext(out, "<br>"))
				return TRUE
	return FALSE

/datum/preferences/proc/get_skill_row_data(datum/job/job, decl/hierarchy/skill/S)
	var/list/row = list()
	row["name"] = S.name
	row["skill_ref"] = "\ref[S]"
	var/min = get_min_skill(job, S)
	var/allocation = skills_allocated[job]
	row["current"] = min + (allocation ? (allocation[S] || 0) : 0)
	row["min"] = min
	row["max"] = get_max_skill(job, S)
	row["max_affordable"] = get_max_affordable(job, S)
	row["spent"] = get_spent_points(job, S)
	row["cost_next"] = S.get_cost(row["current"] + 1) || 0
	var/list/levels = list()
	var/offset = S.prerequisites ? S.prerequisites[S.parent.type] - 1 : 0
	for(var/i in 1 to length(S.levels))
		var/list/lvl = list()
		lvl["level"] = i + offset
		lvl["name"] = S.levels[i]
		lvl["cost"] = S.get_cost(i + offset)
		levels += list(lvl)
	row["levels"] = levels
	return row

/datum/category_collection/player_setup_collection/proc/locate_item(item_name)
	for(var/datum/category_group/player_setup_category/PS in categories)
		for(var/datum/category_item/player_setup_item/PI in PS.items)
			if(PI.name == item_name)
				return PI
	return null

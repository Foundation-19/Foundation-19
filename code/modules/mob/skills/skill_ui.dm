//Holders/managers for nano_ui for the skill panel.

/datum/nano_module/skill_ui
	available_to_ai = FALSE
	var/datum/skillset/skillset
	var/template = "skill_ui.tmpl"
	var/hide_unskilled = FALSE

/datum/nano_module/skill_ui/New(datum/host, topic_manager, datum/skillset/override)
	skillset = override
	if(!skillset && ismob(host))
		var/mob/M = host
		skillset = M.skillset
	if(skillset)
		LAZYADD(skillset.nm_viewing, src)
	..()

/datum/nano_module/skill_ui/Destroy()
	if(skillset)
		LAZYREMOVE(skillset.nm_viewing, src)
	skillset = null
	. = ..()

/datum/nano_module/skill_ui/tgui_interact(mob/user, datum/tgui/ui, datum/tgui_state/state = GLOB.self_tgui_state)
	if(!skillset)
		return

	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "SkillUI", "Skills", 600, 900, state = state)
		ui.open()

/datum/nano_module/skill_ui/tgui_data(mob/user)
	if(!skillset)
		return list()
	var/list/data = skillset.get_nano_data(hide_unskilled)
	data += get_data()
	return data

/datum/nano_module/skill_ui/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if(!skillset || !skillset.owner)
		return TRUE

	if(action == "toggle_hide_unskilled")
		hide_unskilled = !hide_unskilled
		return TRUE

/datum/nano_module/skill_ui/proc/get_data()
	return list()

/datum/skillset/proc/get_nano_data(hide_unskilled)
	. = list()
	.["name"] = owner.real_name
	.["job"] = owner.mind && owner.mind.assigned_role
	.["hide_unskilled"] = hide_unskilled

	var/list/skill_data = list()
	var/decl/hierarchy/skill/skill = decls_repository.get_decl(/decl/hierarchy/skill)
	for(var/decl/hierarchy/skill/V in skill.children)
		var/list/skill_cat = list()
		skill_cat["name"] = V.name
		var/list/skills_in_cat = list()
		for(var/decl/hierarchy/skill/S in V.children)
			var/offset = S.prerequisites ? S.prerequisites[S.parent.type] - 1 : 0
			if(hide_unskilled && (get_value(S.type) + offset == SKILL_MIN))
				continue
			skills_in_cat += list(get_nano_row(S))
			for(var/decl/hierarchy/skill/perk in S.children)
				skills_in_cat += list(get_nano_row(perk))
		if(length(skills_in_cat))
			skill_cat["skills"] = skills_in_cat
			skill_data += list(skill_cat)
	.["skills_by_cat"] = skill_data

/datum/skillset/proc/get_nano_row(decl/hierarchy/skill/S)
	var/list/skill_item = list()
	skill_item["name"] = S.name
	var/value = get_value(S.type)
	skill_item["val"] = value
	skill_item["ref"] = "\ref[S.type]"
	skill_item["available"] = check_prerequisites(S.type)
	var/offset = S.prerequisites ? S.prerequisites[S.parent.type] - 1 : 0
	var/list/levels = list()
	for(var/i in 1 to offset)
		levels += list(list("blank" = 1))
	for(var/i in 1 to length(S.levels))
		var/list/level = list()
		level["blank"] = 0
		level["val"] = i
		level["name"] = S.levels[i]
		level["selected"] = (i == value)
		levels += list(level)
	for(var/i in (length(levels) + 1) to SKILL_MAX)
		levels += list(list("blank" = 1))
	skill_item["levels"] = levels
	return skill_item

/datum/skillset/proc/check_prerequisites(skill_type)
	var/decl/hierarchy/skill/S = decls_repository.get_decl(skill_type)
	if(!S.prerequisites)
		return TRUE
	for(var/prereq_type in S.prerequisites)
		if(!(get_value(prereq_type) >= S.prerequisites[prereq_type]))
			return FALSE
	return TRUE

/*
The generic antag version.
*/
/datum/nano_module/skill_ui/antag
	var/list/max_choices = list(0, 0, 4, 2, 1)
	var/list/currently_selected
	var/buff_type = /datum/skill_buff/antag
	template = "skill_ui_antag.tmpl"

/datum/nano_module/skill_ui/antag/get_data()
	. = ..()
	.["can_choose"] = can_choose()
	var/list/selection_data = list()
	var/decl/hierarchy/skill/skill = decls_repository.get_decl(/decl/hierarchy/skill)
	for(var/i in 1 to length(max_choices))
		var/choices = max_choices[i]
		if(!choices)
			continue
		var/list/level_data = list()
		level_data["name"] = skill.levels[i]
		level_data["level"] = i
		var/selected = LAZYACCESS(currently_selected, i)
		level_data["selected"] = list()
		for(var/skill_type in selected)
			var/decl/hierarchy/skill/S = skill_type // False type.
			level_data["selected"] += list(list("name" = initial(S.name), "ref" = "\ref[skill_type]"))
		level_data["remaining"] = choices - length(selected)
		selection_data += list(level_data)
	.["selection_data"] = selection_data

/datum/nano_module/skill_ui/antag/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if(!skillset || !skillset.owner)
		return TRUE

	if(action == "add_skill")
		if(!can_choose())
			return TRUE
		var/level = text2num(params["add_skill"])
		var/list/choices = list()
		for(var/decl/hierarchy/skill/S in GLOB.skills)
			if(can_select(S.type, level))
				choices[S.name] = S.type
		var/choice = input(usr, "Which skill would you like to add?", "Add Skill") as null|anything in choices
		if(!can_choose() || !choices[choice])
			return TRUE
		if(!can_select(choices[choice], level))
			return TRUE
		select(choices[choice], level)
		skillset.refresh_uis()
		return TRUE
	if(action == "remove_skill")
		if(!can_choose())
			return TRUE
		var/skill_path = locate(params["remove_skill"])
		deselect(skill_path)
		skillset.refresh_uis()
		return TRUE
	if(action == "submit")
		if(!can_choose())
			return TRUE
		if(alert(usr, "Are you sure you want to commit this selection? You won't be able to change it again.", "Warning", "Yes", "No")=="No")
			return TRUE
		if(!can_choose())
			return TRUE
		commit()
		return TRUE
	if(action == "admin_reset")
		if(usr.client)
			usr.client.adminhelp("I am requesting an antag skill selection reset.")
		return TRUE

/datum/nano_module/skill_ui/antag/proc/can_choose()
	return !skillset.owner.too_many_buffs(buff_type)

/datum/nano_module/skill_ui/antag/proc/can_select(skill_type, level)
	var/remaining = LAZYACCESS(max_choices, level)
	var/selected = LAZYACCESS(currently_selected, level)

	if(length(selected) >= remaining)
		return
	if(skill_type in selected)
		return
	if(skillset.get_value(skill_type) >= level)
		return
	var/decl/hierarchy/skill/S = decls_repository.get_decl(skill_type)
	if(length(S.levels) < level)
		return
	if(S.prerequisites)
		return // Can't select perks from here.
	return 1

/datum/nano_module/skill_ui/antag/proc/select(skill_type, level)
	if(!can_select(skill_type, level))
		return
	deselect(skill_type)
	LAZYINITLIST(currently_selected)
	if(currently_selected.len < level)
		currently_selected.len = level
	var/selection = currently_selected[level]
	LAZYADD(selection, skill_type)
	currently_selected[level] = selection

/datum/nano_module/skill_ui/antag/proc/deselect(skill_type)
	for(var/i in 1 to length(currently_selected))
		var/list/selection = currently_selected[i]
		LAZYREMOVE(selection, skill_type) // Can't send list[key] into the macro.
		currently_selected[i] = selection

/datum/nano_module/skill_ui/antag/proc/commit()
	if(!skillset || !skillset.owner)
		return
	var/list/buff = list()
	for(var/i in 1 to length(currently_selected))
		for(var/skill_type in currently_selected[i])
			buff[skill_type] = i - skillset.get_value(skill_type)
	if(skillset.owner.buff_skill(buff, buff_type = buff_type))
		currently_selected = null
		return 1

/datum/skill_buff/antag
	limit = 1
/*
Similar, but for station antags that have jobs.
*/
/datum/nano_module/skill_ui/antag/station
	max_choices = list(0, 0, 2, 1, 1)
/*
Similar, but for off-station jobs (Bearcat, Verne, survivor etc.).
*/
/datum/nano_module/skill_ui/antag/station/offstation
	max_choices = list(0, 2, 2, 1, 1)
/*
Admin version, with debugging options.
*/
/datum/nano_module/skill_ui/admin
	template = "skill_ui_admin.tmpl"

/datum/nano_module/skill_ui/admin/tgui_data(mob/user)
	. = ..()
	.["antag_buff"] = length(skillset.owner.fetch_buffs_of_type(/datum/skill_buff/antag))
	.["antag"] = skillset.owner && skillset.owner.mind && player_is_antag(skillset.owner.mind)

/datum/nano_module/skill_ui/admin/tgui_interact(mob/user, datum/tgui/ui, datum/tgui_state/state = GLOB.admin_tgui_state)
	..()

/datum/nano_module/skill_ui/admin/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if(action == "close")
		qdel(src)
		return TRUE
	if(!check_rights(R_ADMIN|R_MOD, 0, usr))
		return TRUE

	if(action == "reset_antag")
		for(var/datum/skill_buff/buff in skillset.owner.fetch_buffs_of_type(/datum/skill_buff/antag))
			buff.remove()
		log_and_message_staff("SKILLS: [key_name_admin(skillset.owner)] has been granted a reset of antag skills.")
		return TRUE
	if(action == "reset_buffs")
		for(var/datum/skill_buff/buff in skillset.owner.fetch_buffs_of_type(/datum/skill_buff))
			buff.remove()
		log_and_message_staff("SKILLS: All skill buffs have been removed from [key_name_admin(skillset.owner)].")
		return TRUE
	if(action == "reset_hard")
		log_and_message_staff("SKILLS: The skillset of [key_name_admin(skillset.owner)] has been reset.")
		skillset.owner.reset_skillset()
		return TRUE
	if(action == "prefs")
		var/my_client = skillset.owner.client
		if(!my_client)
			to_chat(usr, "Mob client not found.")
			return TRUE
		var/datum/job/job = skillset.owner.mind && SSjobs.get_by_title(skillset.owner.mind.assigned_role)
		if(!job)
			to_chat(usr, "Valid job not found.")
			return TRUE
		skillset.obtain_from_client(job, my_client)
		log_and_message_staff("SKILLS: The job skills for [key_name_admin(skillset.owner)] have been imported.")
		return TRUE
	if(action == "antag")
		var/datum/antagonist/antag = skillset.owner.mind && player_is_antag(skillset.owner.mind)
		if(!antag)
			to_chat(usr, "Mob lacks valid antag status.")
			return TRUE
		if(!istype(antag.skill_setter))
			to_chat(usr, "Antag has no skill setter assigned.")
			return TRUE
		antag.skill_setter.initialize_skills(skillset)
		log_and_message_staff("SKILLS: The antag skills for [key_name_admin(skillset.owner)] have been re-initialized.")
		return TRUE
	if(action == "refresh")
		skillset.refresh_uis()
		return TRUE

	if(action == "value_hit")
		var/skill_type = locate(params["skill"])
		if(!skill_type)
			return TRUE
		var/new_val = sanitize_integer(text2num(params["value_hit"]), SKILL_MIN, SKILL_MAX, SKILL_MIN)
		var/old_val = skillset.get_value(skill_type)
		if(new_val == old_val)
			return TRUE
		var/datum/skill_buff/admin/buff
		var/buffs = skillset.owner.fetch_buffs_of_type(/datum/skill_buff/admin, 0)
		if(length(buffs))
			buff = buffs[1]
		if(buff)
			buff.change_value(skill_type, new_val)
		else
			var/buff_list = list()
			buff_list[skill_type] = new_val - old_val
			skillset.owner.buff_skill(buff_list, buff_type = /datum/skill_buff/admin)
		log_and_message_staff("SKILLS: The skill values of [key_name_admin(skillset.owner)] have been altered.")
		return TRUE

/datum/skill_buff/admin
	limit = 1

/datum/skill_buff/admin/proc/change_value(skill_type, new_value)
	var/old_value = skillset.get_value(skill_type)
	buffs[skill_type] = new_value - old_value + buffs[skill_type]
	skillset.on_levels_change()

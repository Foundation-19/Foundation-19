#define NPP_TAB_MAIN "main"
#define NPP_TAB_GAME "game"

/datum/new_player_panel
	var/mob/new_player/parent
	var/active_tab = NPP_TAB_MAIN

/datum/new_player_panel/New(parent)
	src.parent = parent

/datum/new_player_panel/Destroy(force, ...)
	parent = null
	return ..()

/datum/new_player_panel/tgui_state(mob/user)
	return GLOB.always_tgui_state

/datum/new_player_panel/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "LobbyMenu", "SCiPNET-OS", 640, 520)
		ui.open()
	if(ui)
		// tgui_data rebuilds the full crew manifest (records x players) —
		// doing that every 0.9s per lobby player is the single biggest
		// background cost in the lobby. Refresh on acts (tab switch /
		// refresh button) and initial open only.
		ui.set_autoupdate(FALSE)

/datum/new_player_panel/tgui_data(mob/user)
	var/list/data = list()

	data["active_tab"] = active_tab
	data["ckey"] = parent?.ckey || "unknown"
	data["game_state"] = GAME_STATE

	if(parent?.client?.prefs)
		var/datum/preferences/prefs = parent.client.prefs
		data["character_name"] = prefs.be_random_name ? "Random Name" : prefs.real_name
	else
		data["character_name"] = "Unknown"

	if(GAME_STATE <= RUNLEVEL_LOBBY)
		data["ready"] = parent?.ready || 0
		data["round_started"] = FALSE
	else
		data["ready"] = 0
		data["round_started"] = TRUE

	data["round_duration"] = (GAME_STATE >= RUNLEVEL_GAME) ? DisplayTimeText(world.time - SSticker.round_start_time) : null

	// SCiPNET-OS extras
	data["player_count"] = length(GLOB.player_list)
	data["server_time"] = station_time_timestamp()
	var/decl/security_state/security_state = decls_repository.get_decl(GLOB.using_map.security_state)
	data["security_level"] = security_state.current_security_level.name

	// Structured crew manifest for the lobby's manifest app. Active flag is
	// OOC-style (client present and not AFK 10+ minutes); inactive players
	// are shown but dimmed. Empty pre-round lobby yields section headers
	// with no rows — fine for a desktop app.
	var/list/departments = list(
		list("name" = "Command", "flag" = COM),
		list("name" = "Command Support", "flag" = SPT),
		list("name" = "Research", "flag" = SCI),
		list("name" = "Security", "flag" = SEC),
		list("name" = "Medical", "flag" = MED),
		list("name" = "Engineering", "flag" = ENG),
		list("name" = "Supply", "flag" = SUP),
		list("name" = "Exploration", "flag" = EXP),
		list("name" = "Service", "flag" = SRV),
		list("name" = "Civilian", "flag" = CIV),
		list("name" = "Miscellaneous", "flag" = MSC),
	)
	var/list/dept_rows = list()
	for(var/list/department in departments)
		dept_rows[department["name"]] = list()

	var/list/misc = list()
	for(var/datum/computer_file/report/crew_record/CR in GLOB.all_crew_records)
		var/entry_name = CR.get_name()
		var/rank = CR.get_job()
		var/active = FALSE
		for(var/mob/M in GLOB.player_list)
			if(sanitize(M.real_name) == entry_name && M.client && M.client.inactivity <= 10 MINUTES)
				active = TRUE
				break
		var/entry = list(
			"name" = entry_name,
			"rank" = rank,
			"active" = active,
		)
		var/datum/job/job = SSjobs.get_by_title(rank)
		var/placed = FALSE
		if(job)
			for(var/list/department in departments)
				if(job.department_flag & department["flag"])
					dept_rows[department["name"]].Add(list(entry))
					placed = TRUE
					break
		if(!placed)
			misc.Add(list(entry))

	// Synthetics have no records; pull them straight from the mob list.
	for(var/mob/living/silicon/ai/ai in SSmobs.mob_list)
		misc.Add(list(list("name" = ai.name, "rank" = "Artificially Intelligent Construct", "active" = TRUE)))
	for(var/mob/living/silicon/robot/robot in SSmobs.mob_list)
		if(robot.module && robot.module.hide_on_manifest)
			continue
		misc.Add(list(list("name" = robot.name, "rank" = "[robot.modtype] [robot.braintype]", "active" = TRUE)))

	var/list/manifest = list()
	for(var/list/department in departments)
		var/list/rows = dept_rows[department["name"]]
		if(!LAZYLEN(rows))
			continue
		manifest.Add(list(list(
			"name" = department["name"],
			"members" = rows,
		)))
	if(LAZYLEN(misc))
		manifest.Add(list(list("name" = "Miscellaneous", "members" = misc)))
	data["manifest"] = manifest
	data["manifest_count"] = length(GLOB.player_list)

	return data

/datum/new_player_panel/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if(!parent || !parent.client)
		return TRUE
	if(usr != parent)
		return TRUE

	if(action == "tab")
		active_tab = params["tab"] || NPP_TAB_MAIN
		return TRUE

	if(action == "ready")
		if(GAME_STATE <= RUNLEVEL_LOBBY)
			parent.ready = text2num(params["value"]) || 0
		return TRUE

	if(action == "character_setup")
		if(parent?.client?.prefs)
			parent.client.prefs.open_setup_window(parent)
		return TRUE

	if(action == "late_join")
		if(GAME_STATE < RUNLEVEL_GAME)
			to_chat(usr, SPAN_WARNING("The round is either not ready, or has already finished..."))
			return TRUE
		parent.LateChoices()
		return TRUE

	if(action == "observe")
		parent.new_player_observe()
		return TRUE

	if(action == "manifest")
		if(GAME_STATE < RUNLEVEL_GAME)
			to_chat(usr, SPAN_WARNING("The game hasn't started yet!"))
			return TRUE
		parent.ViewManifest()
		return TRUE

	if(action == "refresh")
		return TRUE

	return FALSE

/datum/new_player_panel/proc/open()
	if(!parent?.client)
		return
	tgui_interact(parent)

/datum/new_player_panel/proc/update()
	SStgui.update_uis(src)

#undef NPP_TAB_MAIN
#undef NPP_TAB_GAME

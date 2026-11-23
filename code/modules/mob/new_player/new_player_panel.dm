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

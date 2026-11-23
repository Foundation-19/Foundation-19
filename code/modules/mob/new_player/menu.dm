/mob/new_player
	hud_type = /datum/hud/new_player

/datum/hud/new_player
	hud_shown = TRUE
	inventory_shown = FALSE
	hotkey_ui_hidden = FALSE

/datum/hud/new_player/FinalizeInstantiation(ui_style, ui_color, ui_alpha)
	adding = list()
	var/atom/movable/screen/using

	using = new /atom/movable/screen/new_player/title(src)
	using.hud_ref = weakref(src)
	adding += using

	mymob.client.screen = list()
	mymob.client.screen += adding

/atom/movable/screen/new_player
	icon = 'icons/misc/hudmenu.dmi'
	layer = HUD_ABOVE_ITEM_LAYER

/atom/movable/screen/new_player/title
	name = "Lobby art"
	icon = 'maps/site53/icons/lobby.dmi'
	icon_state = "title_new"
	screen_loc = "WEST,SOUTH"
	var/lobby_index = 1
	var/lobby_transition_delay = 100

/atom/movable/screen/new_player/title/Initialize()
	var/list/lobby_screens = icon_states(icon)

	icon_state = lobby_screens[lobby_index]

	addtimer(CALLBACK(src, PROC_REF(cycle_lobby_screen), lobby_screens), lobby_transition_delay, TIMER_UNIQUE | TIMER_CLIENT_TIME | TIMER_OVERRIDE)

	return ..()

/atom/movable/screen/new_player/title/proc/cycle_lobby_screen(list/lobby_screens)
	var/datum/hud/hud = hud_ref.resolve()
	if(!istype(hud) || !isnewplayer(hud.mymob))
		return
	lobby_index += 1
	if(lobby_index > length(lobby_screens))
		lobby_index = 1
	animate(src, alpha = 0, time = 10)
	animate(alpha = 255, icon_state = lobby_screens[lobby_index], time = 10)
	if(Master.initializing)
		spawn(lobby_transition_delay)
			cycle_lobby_screen(lobby_screens)
	else
		addtimer(CALLBACK(src, PROC_REF(cycle_lobby_screen), lobby_screens), lobby_transition_delay, TIMER_UNIQUE | TIMER_CLIENT_TIME | TIMER_OVERRIDE)

/mob/new_player/proc/new_player_observe()
	if(GAME_STATE < RUNLEVEL_LOBBY)
		to_chat(src, SPAN_WARNING("Please wait for server initialization to complete..."))
		return

	if(!config.respawn_delay || tgui_alert(client,
		"Are you sure you wish to observe? You will have to wait [config.respawn_delay] minute\s before being able to respawn!",
		"Player Setup", list("Yes", "No")) == "Yes")

		if(!client)
			return TRUE
		var/mob/observer/ghost/observer = new()

		spawning = TRUE
		sound_to(src, sound(null, repeat = 0, wait = 0, volume = 85, channel = GLOB.lobby_sound_channel))// MAD JAMS cant last forever yo

		if(mind)
			mind.active = FALSE //we wish to transfer the key manually
			mind.original = observer
			if(client.prefs.memory)
				mind.StoreMemory(client.prefs.memory)
			mind.transfer_to(observer)					//won't transfer key since the mind is not active

		observer.started_as_observer = TRUE
		var/obj/O = locate("landmark*Observer-Start")
		if(istype(O))
			to_chat(src, SPAN_NOTICE("Now teleporting."))
			observer.forceMove(O.loc)
		else
			to_chat(src, SPAN_DANGER("Could not locate an observer spawn point. Use the Teleport verb to jump to the map."))
		observer.timeofdeath = world.time // Set the time of death so that the respawn timer works correctly.

		var/should_announce = client.get_preference_value(/datum/client_preference/announce_ghost_join) == GLOB.PREF_YES

		if(isnull(client.holder) && should_announce)
			announce_ghost_joinleave(src)

		var/mob/living/carbon/human/dummy/mannequin = new()
		client.prefs.dress_preview_mob(mannequin)
		observer.set_appearance(mannequin)
		qdel(mannequin)

		if(client.prefs.be_random_name)
			client.prefs.real_name = random_name(client.prefs.gender)
		observer.real_name = client.prefs.real_name
		observer.SetName(observer.real_name)
		if(!client.holder && !config.antag_hud_allowed)           // For new ghosts we remove the verb from even showing up if it's not allowed.
			add_verb(observer, /mob/observer/ghost/verb/toggle_antagHUD) // Poor guys, don't know what they are missing!
		observer.key = key
		observer.client.init_verbs()
		qdel(src)

		return TRUE

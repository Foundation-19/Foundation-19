/mob/new_player
	hud_type = /datum/hud/new_player

/datum/hud/new_player
	hud_shown = TRUE
	inventory_shown = FALSE
	hotkey_ui_hidden = FALSE

/datum/hud/new_player/FinalizeInstantiation(ui_style, ui_color, ui_alpha)
	adding = list()
	var/obj/screen/using

	using = new /obj/screen/new_player/title(src)
	using.hud = src
	adding += using

	using = new /obj/screen/new_player/selection/join_game(src)
	using.hud = src
	adding += using

	using = new /obj/screen/new_player/selection/settings(src)
	using.hud = src
	adding += using

	using = new /obj/screen/new_player/selection/manifest(src)
	using.hud = src
	adding += using

	using = new /obj/screen/new_player/selection/observe(src)
	using.hud = src
	adding += using

	mymob.client.screen = list()
	mymob.client.screen += adding

/obj/screen/new_player
	icon = 'icons/misc/hudmenu.dmi'
	layer = HUD_ABOVE_ITEM_LAYER

//I am way too lazy to port map specific lobby screens since I heavily doubt we'll ever use them.

/obj/screen/new_player/title
	name = "Lobby art"
	icon = 'maps/site53/icons/lobby.dmi'
	icon_state = "title_new"
	screen_loc = "WEST,SOUTH"
	var/lobby_index = 1
	var/lobby_transition_delay = 100

/obj/screen/new_player/title/Initialize()
	var/list/lobby_screens = icon_states(icon)

	icon_state = lobby_screens[lobby_index]

	addtimer(CALLBACK(src, .proc/cycle_lobby_screen, lobby_screens), lobby_transition_delay, TIMER_UNIQUE | TIMER_CLIENT_TIME | TIMER_OVERRIDE)

	return ..()

/obj/screen/new_player/title/proc/cycle_lobby_screen(list/lobby_screens)
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
		addtimer(CALLBACK(src, .proc/cycle_lobby_screen, lobby_screens), lobby_transition_delay, TIMER_UNIQUE | TIMER_CLIENT_TIME | TIMER_OVERRIDE)

/obj/screen/new_player/selection/New(datum/hud/H)
	color = null
	hud = H
	return ..()

/obj/screen/new_player/selection/MouseEntered(location, control, params)
	animate(src, color = color_rotation(30), time = 3)
	return ..()

/obj/screen/new_player/selection/MouseExited(location, control, params)
	animate(src, color = null, time = 3)
	return ..()

/obj/screen/new_player/selection/join_game
	name = "Join Game"
	icon_state = "unready"
	screen_loc = "NORTH, CENTER-7"

/obj/screen/new_player/selection/join_game/Initialize()
	. = ..()
	RegisterSignal(SSticker, COMSIG_GAME_STARTED, .proc/update_lobby_icon)

/obj/screen/new_player/selection/join_game/Click()
	var/mob/new_player/player = hud.mymob
	sound_to(player, 'sound/effects/menu_click.ogg')

	if(!check_rights(R_INVESTIGATE, FALSE, player) && GAME_STATE > RUNLEVEL_LOBBY)
		var/dsdiff = config.respawn_menu_delay MINUTES - (world.time - player.respawned_time)
		if(dsdiff > 0)
			to_chat(player, SPAN_WARNING("You must wait [time2text(dsdiff, "mm:ss")] before rejoining."))
			return

	if(GAME_STATE <= RUNLEVEL_LOBBY)
		player.ready = !player.ready
		to_chat(player, "<span class='notice'>You are now [player.ready ? "ready" : "not ready"].</span>")

	else
		player.LateChoices() //show the latejoin job selection menu

	update_lobby_icon()

/obj/screen/new_player/selection/join_game/proc/update_lobby_icon()
	SIGNAL_HANDLER

	var/mob/new_player/player = hud.mymob

	if(GAME_STATE <= RUNLEVEL_LOBBY)
		if(player.ready)
			icon_state = "ready"
		else
			icon_state = "unready"
	else
		icon_state = "joingame"

/obj/screen/new_player/selection/settings
	name = "Setup"
	icon_state = "setup"
	screen_loc = "NORTH-1,CENTER-7"

/obj/screen/new_player/selection/settings/Click()
	var/mob/new_player/player = hud.mymob
	sound_to(player, 'sound/effects/menu_click.ogg')
	player.setupcharacter()

/mob/new_player/proc/setupcharacter()
	client.prefs.open_setup_window(src) //see code\modules\client\preferences.dm
	return TRUE

/obj/screen/new_player/selection/manifest
	name = "Crew Manifest"
	icon_state = "manifest"
	screen_loc = "NORTH-2,CENTER-7"

/obj/screen/new_player/selection/manifest/Click()
	var/mob/new_player/player = hud.mymob
	sound_to(player, 'sound/effects/menu_click.ogg')
	if(GAME_STATE != (RUNLEVEL_GAME || RUNLEVEL_POSTGAME))
		to_chat(player, SPAN_WARNING("The game hasn't started yet!"))
		return
	player.ViewManifest() //see code\modules\mob\new_player\new_player.dm

/obj/screen/new_player/selection/observe
	name = "Observe"
	icon_state = "observe"
	screen_loc = "NORTH-3,CENTER-7"

/obj/screen/new_player/selection/observe/Click()
	var/mob/new_player/player = hud.mymob
	sound_to(player, 'sound/effects/menu_click.ogg')
	player.new_player_observe()

/mob/new_player/proc/new_player_observe()
	if(GAME_STATE < RUNLEVEL_LOBBY)
		to_chat(src, "<span class='warning'>Please wait for server initialization to complete...</span>")
		return

	if(!config.respawn_delay || tgui_alert(client,
		"Are you sure you wish to observe? You will have to wait [config.respawn_delay] minute\s before being able to respawn!",
		"Player Setup", list("Yes", "No")) == "Yes")

		if(!client)
			return TRUE
		var/mob/observer/ghost/observer = new()

		spawning = TRUE
		sound_to(src, sound(null, repeat = 0, wait = 0, volume = 85, channel = GLOB.lobby_sound_channel))// MAD JAMS cant last forever yo

		observer.started_as_observer = TRUE
		var/obj/O = locate("landmark*Observer-Start")
		if(istype(O))
			to_chat(src, "<span class='notice'>Now teleporting.</span>")
			observer.forceMove(O.loc)
		else
			to_chat(src, "<span class='danger'>Could not locate an observer spawn point. Use the Teleport verb to jump to the map.</span>")
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

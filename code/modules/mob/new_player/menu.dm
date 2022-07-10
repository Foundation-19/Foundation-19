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
	using.name = "Title"
	using.hud = src
	adding += using

	mymob.client.screen = list()
	mymob.client.screen += adding
/*
	using = new /obj/screen/new_player/selection/join_game(src)
	using.name = "Join Game"
	using.hud = src
	adding += using

	using = new /obj/screen/new_player/selection/settings(src)
	using.name = "Setup Character"
	adding += using

	using = new /obj/screen/new_player/selection/manifest(src)
	using.name = "Crew Manifest"
	adding += using

	using = new /obj/screen/new_player/selection/observe(src)
	using.name = "Observe"
	adding += using
*/
/obj/screen/new_player
	layer = HUD_ABOVE_ITEM_LAYER

//I am way too lazy to port map specific lobby screens since I heavily doubt we'll ever want them.

/obj/screen/new_player/title
	name = "Title"
	icon = 'maps/site53/icons/lobby.dmi'
	screen_loc = "WEST,SOUTH"
	var/lobby_index = 1
	var/lobby_transition_delay = 100

/obj/screen/new_player/title/Initialize()
	var/list/lobby_screens = icon_states(icon)

	icon_state = lobby_screens[lobby_index]
	if(Master.initializing)
		spawn(lobby_transition_delay)
			cycle_lobby_screen(lobby_screens)
	else
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



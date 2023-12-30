GLOBAL_DATUM_INIT(cinematic, /datum/cinematic, new)
//Was moved from the gameticker to here. Could use further improvement.

/datum/cinematic
	//station_explosion used to be a variable for every mob's hud. Which was a waste!
	//Now we have a general cinematic centrally held within the gameticker....far more efficient!
	var/atom/movable/screen/cinematic_screen = null
	/// List of clients currently watching a cinematic
	var/list/watching_clients = list()

//Plus it provides an easy way to make cinematics for other events. Just use this as a template :)
/datum/cinematic/proc/station_explosion_cinematic(station_missed = FALSE, datum/game_mode/override)
	set waitfor = FALSE

	if(cinematic_screen)
		return //already a cinematic in progress!

	if(!override)
		override = SSticker.mode
	if(!override)
		override = gamemode_cache["extended"]
	if(!override)
		return

	watching_clients = list()

	// Initialise our cinematic screen object
	cinematic_screen = new(src)
	cinematic_screen.icon = 'icons/effects/station_explosion.dmi'
	cinematic_screen.icon_state = "station_intact"
	cinematic_screen.plane = HUD_PLANE
	cinematic_screen.layer = HUD_ABOVE_ITEM_LAYER
	cinematic_screen.mouse_opacity = 0
	cinematic_screen.screen_loc = "BOTTOM,LEFT+50%"
	cinematic_screen.appearance_flags = APPEARANCE_UI | TILE_BOUND

	for(var/client/C in GLOB.clients)
		// Show every client the cinematic
		C.screen += cinematic_screen
		watching_clients += C
		if(C.mob)
			C.mob.stunned += 8000

	// Cinematic happens here, as does mob death.
	override.nuke_act(cinematic_screen, station_missed)
	// If its actually the end of the round, wait for it to end.
	// Otherwise if its a verb it will continue on afterwards.
	sleep(20 SECONDS)

	animate(cinematic_screen, alpha = 0, time = (2 SECONDS))

	sleep(2 SECONDS)

	for(var/client/C in watching_clients)
		C.screen -= cinematic_screen
		if(C.mob)
			C.mob.stunned = max(0, C.mob.stunned - 8000)

	watching_clients = list()
	QDEL_NULL(cinematic_screen)

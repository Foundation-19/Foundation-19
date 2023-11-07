
/mob
	var/list/screens = list()

/mob/proc/set_fullscreen(condition, screen_name, screen_type, arg)
	condition ? overlay_fullscreen(screen_name, screen_type, arg) : clear_fullscreen(screen_name)

/mob/proc/overlay_fullscreen(category, type, severity)
	var/atom/movable/screen/fullscreen/screen = screens[category]

	if(screen)
		if(screen.type != type)
			clear_fullscreen(category, FALSE)
			screen = null
		else if(!severity || severity == screen.severity)
			return null

	if(!screen)
		screen = new type()

	screen.icon_state = "[initial(screen.icon_state)][severity]"
	screen.severity = severity

	screens[category] = screen
	if(client && (stat != DEAD || screen.allstate))
		client.screen += screen
	return screen

/mob/proc/clear_fullscreen(category, animated = 1 SECOND)
	var/atom/movable/screen/fullscreen/screen = screens[category]
	if(!screen)
		return

	screens -= category

	if(animated)
		spawn(0)
			animate(screen, alpha = 0, time = animated)
			sleep(animated)
			if(client)
				client.screen -= screen
			qdel(screen)
	else
		if(client)
			client.screen -= screen
		qdel(screen)

/mob/proc/clear_fullscreens()
	for(var/category in screens)
		clear_fullscreen(category)

/mob/proc/hide_fullscreens()
	if(client)
		for(var/category in screens)
			client.screen -= screens[category]

/mob/proc/reload_fullscreen()
	if(client)
		for(var/category in screens)
			client.screen |= screens[category]

/atom/movable/screen/fullscreen
	icon = 'icons/mob/screen_full.dmi'
	icon_state = "default"
	screen_loc = "CENTER-7,CENTER-7"
	plane = FULLSCREEN_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/severity = 0
	var/allstate = 0 //shows if it should show up for dead people too

/atom/movable/screen/fullscreen/Destroy()
	severity = 0
	return ..()

/atom/movable/screen/fullscreen/brute
	icon_state = "brutedamageoverlay"
	layer = DAMAGE_LAYER

/atom/movable/screen/fullscreen/oxy
	icon_state = "oxydamageoverlay"
	layer = DAMAGE_LAYER

/atom/movable/screen/fullscreen/crit
	icon_state = "passage"
	layer = CRIT_LAYER

/atom/movable/screen/fullscreen/blind
	icon_state = "blackimageoverlay"
	layer = BLIND_LAYER

/atom/movable/screen/fullscreen/blackout
	icon = 'icons/mob/screen1.dmi'
	icon_state = "black"
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	layer = BLIND_LAYER

/atom/movable/screen/fullscreen/impaired
	icon_state = "impairedoverlay"
	layer = IMPAIRED_LAYER

/atom/movable/screen/fullscreen/blurry
	icon = 'icons/mob/screen1.dmi'
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "blurry"
	alpha = 100

/atom/movable/screen/fullscreen/flash
	icon = 'icons/mob/screen1.dmi'
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "flash"

/atom/movable/screen/fullscreen/flash/noise
	icon_state = "noise"

/atom/movable/screen/fullscreen/high
	icon = 'icons/mob/screen1.dmi'
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "druggy"

/atom/movable/screen/fullscreen/noise
	icon = 'icons/effects/static.dmi'
	icon_state = "1 light"
	screen_loc = ui_entire_screen
	layer = FULLSCREEN_LAYER
	alpha = 127

/atom/movable/screen/fullscreen/fadeout
	icon = 'icons/mob/screen1.dmi'
	icon_state = "black"
	screen_loc = ui_entire_screen
	layer = FULLSCREEN_LAYER
	alpha = 0
	allstate = 1

/atom/movable/screen/fullscreen/fadeout/Initialize()
	. = ..()
	animate(src, alpha = 255, time = 10)

/atom/movable/screen/fullscreen/scanline
	icon = 'icons/effects/static.dmi'
	icon_state = "scanlines"
	screen_loc = ui_entire_screen
	alpha = 50
	layer = FULLSCREEN_LAYER

/atom/movable/screen/fullscreen/fishbed
	icon_state = "fishbed"
	allstate = 1

/atom/movable/screen/fullscreen/pain
	icon_state = "brutedamageoverlay6"
	alpha = 0


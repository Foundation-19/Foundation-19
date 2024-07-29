/*
	The global hud:
	Uses the same visual objects for all players.
*/

GLOBAL_DATUM_INIT(global_hud, /datum/global_hud, new())

/datum/global_hud
	var/atom/movable/screen/holomap

/datum/global_hud/New()
	//Holomap screen object is invisible and work
	//By setting it as n images location, without icon changes
	//Make it part of global hud since it's inmutable
	holomap = new /atom/movable/screen()
	holomap.name = "holomap"
	holomap.icon = null
	holomap.layer = HUD_BASE_LAYER
	holomap.screen_loc = UI_HOLOMAP
	holomap.mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/fullscreen/hud
	icon = 'icons/obj/hud_full.dmi'

/atom/movable/screen/fullscreen/hud/nvg
	icon_state = "nvg_hud"

/atom/movable/screen/fullscreen/hud/scramble
	icon_state = "scramble_hud"

/atom/movable/screen/fullscreen/hud/thermal
	icon_state = "thermal_hud"

/atom/movable/screen/fullscreen/hud/meson
	icon_state = "meson_hud"

/atom/movable/screen/fullscreen/hud/science
	icon_state = "science_hud"

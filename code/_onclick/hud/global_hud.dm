/*
	The global hud:
	Uses the same visual objects for all players.
*/

GLOBAL_DATUM_INIT(global_hud, /datum/global_hud, new())

/datum/global_hud
	var/atom/movable/screen/nvg
	var/atom/movable/screen/scramble
	var/atom/movable/screen/thermal
	var/atom/movable/screen/meson
	var/atom/movable/screen/science
	var/atom/movable/screen/holomap

/datum/global_hud/proc/setup_overlay(icon_state)
	var/atom/movable/screen/screen = new /atom/movable/screen()
	screen.screen_loc = "1,1"
	screen.icon = 'icons/obj/hud_full.dmi'
	screen.icon_state = icon_state
	screen.mouse_opacity = MOUSE_OPACITY_TRANSPARENT

	return screen

/datum/global_hud/New()
	nvg = setup_overlay("nvg_hud")
	scramble = setup_overlay("scramble_hud")
	thermal = setup_overlay("thermal_hud")
	meson = setup_overlay("meson_hud")
	science = setup_overlay("science_hud")

	//Holomap screen object is invisible and work
	//By setting it as n images location, without icon changes
	//Make it part of global hud since it's inmutable
	holomap = new /atom/movable/screen()
	holomap.name = "holomap"
	holomap.icon = null
	holomap.layer = HUD_BASE_LAYER
	holomap.screen_loc = UI_HOLOMAP
	holomap.mouse_opacity = MOUSE_OPACITY_TRANSPARENT

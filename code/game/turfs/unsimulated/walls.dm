/turf/unsimulated/wall
	name = "wall"
	icon = 'icons/turf/walls.dmi'
	icon_state = "riveted"
	opacity = 1
	density = TRUE

/turf/unsimulated/wall/is_wall()
	return TRUE

/turf/unsimulated/wall/is_phasable()
	return TRUE

/turf/unsimulated/wall/fakeglass
	name = "window"
	icon_state = "fakewindows"
	opacity = 0

/turf/unsimulated/wall/other
	icon_state = "r_wall"

/turf/unsimulated/wall/cult
	name = "cult wall"
	desc = "Hideous images dance beneath the surface."
	icon = 'icons/turf/wall_masks.dmi'
	icon_state = "cult"

/turf/unsimulated/wall/lobby_background
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT //we don't need to see this.
	icon_state = "lobby_black"

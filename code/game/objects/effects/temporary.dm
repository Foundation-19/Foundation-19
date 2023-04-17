//temporary visual effects
/obj/effect/temp_visual
	icon = 'icons/effects/effects.dmi'
	icon_state = "nothing"
	anchored = TRUE
	layer = ABOVE_HUMAN_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	simulated = FALSE
	var/duration = 10 //in deciseconds

/obj/effect/temp_visual/Initialize(mapload, set_dir)
	if(set_dir)
		set_dir(set_dir)
	. = ..()
	QDEL_IN(src, duration)

/obj/effect/temp_visual/bloodsplatter
	icon = 'icons/effects/bloodspatter.dmi'
	duration = 5
	layer = LYING_HUMAN_LAYER
	var/splatter_type = "splatter"

/obj/effect/temp_visual/bloodsplatter/Initialize(mapload, set_dir, _color)
	if(set_dir in GLOB.cornerdirs)
		icon_state = "[splatter_type][pick(1, 2, 6)]"
	else
		icon_state = "[splatter_type][pick(3, 4, 5)]"
	. = ..()
	if (_color)
		color = _color

	var/target_pixel_x = 0
	var/target_pixel_y = 0
	if(set_dir & NORTH)
		target_pixel_y = 16
	if(set_dir & SOUTH)
		target_pixel_y = -16
		layer = ABOVE_HUMAN_LAYER
	if(set_dir & EAST)
		target_pixel_x = 16
	if(set_dir & WEST)
		target_pixel_x = -16
	animate(src, pixel_x = target_pixel_x, pixel_y = target_pixel_y, alpha = 0, time = duration)

// Smoke effect

/obj/effect/temp_visual/smoke
	name = "smoke"
	icon_state = "smoke"
	duration = 5

// Temporary sparkles

/obj/effect/temp_visual/sparkle
	name = "sparkle"
	icon_state = "pink_sparkles"
	duration = 8

// Cult effects

/obj/effect/temp_visual/cultfloor
	name = "cult floor"
	icon_state = "cultfloor"
	duration = 5

/obj/effect/temp_visual/runeconvert
	name = "rune convert"
	icon_state = "rune_convert"
	duration = 5

/obj/effect/temp_visual/decoy
	desc = "It's a decoy!"
	duration = 15

/obj/effect/temp_visual/decoy/Initialize(mapload, setdir, atom/mimiced_atom, modified_duration = 15)
	duration = modified_duration
	. = ..()
	alpha = initial(alpha)
	if(mimiced_atom)
		name = mimiced_atom.name
		appearance = mimiced_atom.appearance
		set_dir(setdir)
		mouse_opacity = 0

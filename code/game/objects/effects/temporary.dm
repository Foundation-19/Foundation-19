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

// Used in place of old /obj/effect/temporary where applicable.
// Do not use it for new stuff, please
/obj/effect/temp_visual/temporary/Initialize(mapload, new_dur = 5, new_icon = null, new_icon_state = null)
	duration = new_dur
	icon = new_icon
	icon_state = new_icon_state
	return ..()

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

// Attack effect
/obj/effect/temp_visual/smash
	name = "smash"
	icon_state = "smash"
	duration = 8

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

/obj/effect/temp_visual/sparkle/cyan
	icon_state = "cyan_sparkles"

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

/obj/effect/temp_visual/cig_smoke
	name = "smoke"
	icon_state = "smallsmoke"
	icon = 'icons/effects/effects.dmi'
	opacity = FALSE
	anchored = TRUE
	mouse_opacity = FALSE
	layer = ABOVE_HUMAN_LAYER

	duration = 3 SECONDS

/obj/effect/temp_visual/cig_smoke/Initialize()
	. = ..()
	set_dir(pick(GLOB.cardinal))
	pixel_x = rand(-12, 12)
	pixel_y = rand(0, 16)
	animate(src, alpha = 0, pixel_x = pixel_x + rand(-6, 6), pixel_y = pixel_y + 12, duration, easing = EASE_IN)

/obj/effect/temp_visual/bite
	name = "bite"
	icon_state = "bite"
	icon = 'icons/effects/effects.dmi'
	opacity = FALSE
	anchored = TRUE
	mouse_opacity = FALSE
	layer = ABOVE_HUMAN_LAYER

	duration = 1 SECONDS

/obj/effect/temp_visual/bite/Initialize()
	. = ..()
	addtimer(CALLBACK(src, .proc/FadeOut), (duration * 0.8))

/obj/effect/temp_visual/bite/proc/FadeOut()
	animate(src, alpha = 0, (duration * 0.2))

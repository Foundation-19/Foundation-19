//temporary visual effects
/obj/effect/temp_visual
	icon = 'icons/effects/effects.dmi'
	icon_state = "nothing"
	anchored = TRUE
	layer = ABOVE_HUMAN_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	simulated = FALSE
	var/duration = 1 SECOND

/obj/effect/temp_visual/Initialize(mapload, setDir)
	if(setDir)
		setDir(setDir)
	. = ..()
	QDEL_IN(src, duration)

// Used in place of old /obj/effect/temporary where applicable.
// Do not use it for new stuff, please
/obj/effect/temp_visual/temporary/Initialize(mapload, new_dur = 5, new_icon = null, new_icon_state = null)
	if(!isnull(new_dur))
		duration = new_dur
	icon = new_icon
	icon_state = new_icon_state
	return ..()

/obj/effect/temp_visual/bloodsplatter
	icon = 'icons/effects/bloodspatter.dmi'
	duration = 5
	layer = LYING_HUMAN_LAYER
	var/splatter_type = "splatter"

/obj/effect/temp_visual/bloodsplatter/Initialize(mapload, setDir, _color)
	if(setDir in GLOB.cornerdirs)
		icon_state = "[splatter_type][pick(1, 2, 6)]"
	else
		icon_state = "[splatter_type][pick(3, 4, 5)]"
	. = ..()
	if (_color)
		color = _color

	var/target_pixel_x = 0
	var/target_pixel_y = 0
	if(setDir & NORTH)
		target_pixel_y = 16
	if(setDir & SOUTH)
		target_pixel_y = -16
		layer = ABOVE_HUMAN_LAYER
	if(setDir & EAST)
		target_pixel_x = 16
	if(setDir & WEST)
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

/obj/effect/temp_visual/decoy/Initialize(mapload, set_dir, atom/mimiced_atom, modified_duration = 15)
	duration = modified_duration
	. = ..()
	alpha = initial(alpha)
	if(mimiced_atom)
		name = mimiced_atom.name
		appearance = mimiced_atom.appearance
		setDir(set_dir)
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
	setDir(pick(GLOB.cardinal))
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
	addtimer(CALLBACK(src, PROC_REF(FadeOut)), (duration * 0.8))

/obj/effect/temp_visual/bite/proc/FadeOut()
	animate(src, alpha = 0, (duration * 0.2))

// Used by pestilence spell
/obj/effect/temp_visual/pestilence_glow
	name = "pestilence"
	icon_state = "greenglow"
	icon = 'icons/effects/effects.dmi'
	alpha = 125
	opacity = FALSE
	anchored = TRUE
	mouse_opacity = FALSE
	layer = ABOVE_HUMAN_LAYER

	duration = 1 SECONDS

	var/max_spread_pixels = 16

/obj/effect/temp_visual/pestilence_glow/Initialize()
	. = ..()
	pixel_x = rand(-4, 4)
	pixel_y = rand(-4, 4)
	animate(src, alpha = 0, pixel_x = pixel_x + rand(-max_spread_pixels, max_spread_pixels), pixel_y = pixel_y + rand(-max_spread_pixels, max_spread_pixels), duration, easing = EASE_IN)

// The one spreading from the user
/obj/effect/temp_visual/pestilence_glow/self
	duration = 5 SECONDS
	max_spread_pixels = 64

/obj/effect/temp_visual/slash
	name = "slash"
	icon_state = "slash"
	icon = 'icons/effects/effects.dmi'
	alpha = 25
	opacity = FALSE
	anchored = TRUE
	mouse_opacity = FALSE
	layer = ABOVE_HUMAN_LAYER

	duration = 1 SECONDS

/obj/effect/temp_visual/slash/proc/FadeOut()
	animate(src, alpha = 0, time = 5)

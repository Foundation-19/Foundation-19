//A temporary effect that does not DO anything except look pretty.
/obj/effect/temporary
	icon = 'icons/effects/effects.dmi'
	anchored = TRUE
	unacidable = TRUE
	mouse_opacity = 0
	density = FALSE
	layer = ABOVE_HUMAN_LAYER
	var/duration = 30

/obj/effect/temporary/Initialize(var/mapload)
	. = ..()
	QDEL_IN(src, duration)

// Smoke effect

/obj/effect/temporary/smoke
	name = "smoke"
	icon_state = "smoke"
	duration = 5

// Temporary sparkles

/obj/effect/temporary/sparkle
	name = "sparkle"
	icon_state = "pink_sparkles"
	duration = 8

// Cult effects

/obj/effect/temporary/cultfloor
	name = "cult floor"
	icon_state = "cultfloor"
	duration = 5

/obj/effect/temporary/runeconvert
	name = "rune convert"
	icon_state = "rune_convert"
	duration = 5

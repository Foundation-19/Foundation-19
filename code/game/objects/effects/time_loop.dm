/obj/effect/time_loop
	acid_resistance = -1
	density = TRUE
	anchored = TRUE
	simulated = FALSE

/obj/effect/time_loop/Initialize(mapload, set_dir, atom/copied_atom)
	. = ..()
	name = copied_atom.name
	desc = copied_atom.desc
	appearance = copied_atom.appearance
	plane = copied_atom.plane
	layer = copied_atom.layer

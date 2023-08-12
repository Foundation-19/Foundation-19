/atom/movable
	var/tmp/atom/movable/openspace/overlay/bound_overlay	// The overlay that is directly mirroring us that we proxy movement to.
	var/no_z_overlay	// If TRUE, this atom will not be drawn on open turfs.

/atom/movable/forceMove(atom/dest)
	. = ..(dest)
	if (. && bound_overlay)
		// The overlay will handle cleaning itself up on non-openspace turfs.
		if (isturf(dest))
			bound_overlay.forceMove(get_step(src, UP))
			if (dir != bound_overlay.dir)
				bound_overlay.setDir(dir)
		else	// Not a turf, so we need to destroy immediately instead of waiting for the destruction timer to proc.
			qdel(bound_overlay)

/atom/movable/Move()
	. = ..()
	if (. && bound_overlay)
		bound_overlay.forceMove(get_step(src, UP))
		if (bound_overlay.dir != dir)
			bound_overlay.setDir(dir)

/atom/movable/setDir(ndir)
	. = ..()
	if (. && bound_overlay)
		bound_overlay.setDir(ndir)

/atom/movable/update_above()
	if (!bound_overlay || !isturf(loc))
		return

	var/turf/T = loc

	if (TURF_IS_MIMICING(T.above))
		if (!bound_overlay.queued)
			SSzcopy.queued_overlays += bound_overlay
			bound_overlay.queued = TRUE
	else
		qdel(bound_overlay)

// Grabs a list of every openspace object that's directly or indirectly mimicing this object. Returns an empty list if none found.
/atom/movable/proc/get_above_oo()
	. = list()
	var/atom/movable/curr = src
	while (curr.bound_overlay)
		. += curr.bound_overlay
		curr = curr.bound_overlay

// -- Openspace movables --

/atom/movable/openspace
	name = ""
	simulated = FALSE
	anchored = TRUE
	mouse_opacity = FALSE

/atom/movable/openspace/can_fall()
	return FALSE

// No blowing up abstract objects.
/atom/movable/openspace/ex_act(ex_sev)
	SHOULD_CALL_PARENT(FALSE)
	return

/atom/movable/openspace/singularity_act()
	return

/atom/movable/openspace/singularity_pull()
	return

/atom/movable/openspace/singuloCanEat()
	return

// -- MULTIPLIER / SHADOWER --

// Holder object used for dimming openspaces & copying lighting of below turf.
/atom/movable/openspace/multiplier
	name = "openspace multiplier"
	desc = "You shouldn't see this."
	icon = 'icons/effects/lighting_overlay.dmi'
	icon_state = "dark"
	plane = OVER_OPENSPACE_PLANE
	layer = MIMICED_LIGHTING_LAYER
	blend_mode = DEFAULT
	color = "#000000"
	alpha = (255 * (1 - SHADOWER_DARKENING_FACTOR))
/atom/movable/openspace/multiplier/Destroy()
	var/turf/myturf = loc
	if (istype(myturf))
		myturf.shadower = null

	return ..()

/atom/movable/openspace/multiplier/proc/copy_lighting(atom/movable/lighting_overlay/LO)
	appearance = LO
	layer = MIMICED_LIGHTING_LAYER
	plane = OPENTURF_MAX_PLANE
	invisibility = 0
	blend_mode = BLEND_MULTIPLY
	if (icon_state == null)
		// We're using a color matrix, so just darken the colors across the board.
		// Bay stores lights as inverted so the lighting PM can invert it for darksight, but
		//   we don't have a plane master, so invert it again.
		var/list/c_list = color
		c_list[CL_MATRIX_RR] *= -SHADOWER_DARKENING_FACTOR
		c_list[CL_MATRIX_RG] *= -SHADOWER_DARKENING_FACTOR
		c_list[CL_MATRIX_RB] *= -SHADOWER_DARKENING_FACTOR
		c_list[CL_MATRIX_GR] *= -SHADOWER_DARKENING_FACTOR
		c_list[CL_MATRIX_GG] *= -SHADOWER_DARKENING_FACTOR
		c_list[CL_MATRIX_GB] *= -SHADOWER_DARKENING_FACTOR
		c_list[CL_MATRIX_BR] *= -SHADOWER_DARKENING_FACTOR
		c_list[CL_MATRIX_BG] *= -SHADOWER_DARKENING_FACTOR
		c_list[CL_MATRIX_BB] *= -SHADOWER_DARKENING_FACTOR
		c_list[CL_MATRIX_AR] *= -SHADOWER_DARKENING_FACTOR
		c_list[CL_MATRIX_AG] *= -SHADOWER_DARKENING_FACTOR
		c_list[CL_MATRIX_AB] *= -SHADOWER_DARKENING_FACTOR
		color = c_list
	else
		// Not a color matrix, so we just ignore the lighting values.
		icon_state = "dark"	// this is actually just a white sprite, which is what this blending needs
		color = list(
			SHADOWER_DARKENING_FACTOR, 0, 0,
			0, SHADOWER_DARKENING_FACTOR, 0,
			0, 0, SHADOWER_DARKENING_FACTOR
		)

	var/turf/parent = loc
	ASSERT(isturf(parent))
	if (LAZYLEN(parent.ao_overlays_mimic))
		add_overlay(parent.ao_overlays_mimic)

	if (bound_overlay)
		update_above()

// -- OPENSPACE OVERLAY --
// todo: rename

// Object used to hold a mimiced atom's appearance.
/atom/movable/openspace/overlay
	plane = OPENTURF_MAX_PLANE
	var/atom/movable/associated_atom
	var/depth
	var/queued = FALSE
	var/destruction_timer
	var/mimiced_type
	var/original_z
	var/override_depth

/atom/movable/openspace/overlay/New()
	atom_flags |= ATOM_FLAG_INITIALIZED
	SSzcopy.openspace_overlays += 1

/atom/movable/openspace/overlay/Destroy()
	SSzcopy.openspace_overlays -= 1

	if (associated_atom)
		associated_atom.bound_overlay = null
		associated_atom = null

	if (destruction_timer)
		deltimer(destruction_timer)

	return ..()

/atom/movable/openspace/overlay/attackby(obj/item/W, mob/user)
	to_chat(user, SPAN_NOTICE("\The [src] is too far away."))

/atom/movable/openspace/overlay/attack_hand(mob/user)
	to_chat(user, SPAN_NOTICE("You cannot reach \the [src] from here."))

/atom/movable/openspace/overlay/examine(...)
	SHOULD_CALL_PARENT(FALSE)
	. = associated_atom.examine(arglist(args))	// just pass all the args to the copied atom

/atom/movable/openspace/overlay/forceMove(turf/dest)
	. = ..()
	if (TURF_IS_MIMICING(dest))
		if (destruction_timer)
			deltimer(destruction_timer)
			destruction_timer = null
	else if (!destruction_timer)
		destruction_timer = addtimer(CALLBACK(src, /datum/.proc/qdel_self), 10 SECONDS, TIMER_STOPPABLE)

// Called when the turf we're on is deleted/changed.
/atom/movable/openspace/overlay/proc/owning_turf_changed()
	if (!destruction_timer)
		destruction_timer = addtimer(CALLBACK(src, /datum/.proc/qdel_self), 10 SECONDS, TIMER_STOPPABLE)

// -- TURF DELEGATE --

// This thing holds the mimic appearance for non-OVERWRITE turfs.
/atom/movable/openspace/turf_delegate
	plane = OPENTURF_MAX_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	no_z_overlay = TRUE  // Only one of these should ever be visible at a time, the mimic logic will handle that.

/atom/movable/openspace/turf_delegate/attackby(obj/item/W, mob/user)
	loc.attackby(W, user)

/atom/movable/openspace/turf_delegate/attack_hand(mob/user as mob)
	loc.attack_hand(user)

/atom/movable/openspace/turf_delegate/attack_generic(mob/user as mob)
	loc.attack_generic(user)

/atom/movable/openspace/turf_delegate/examine(mob/examiner)
	SHOULD_CALL_PARENT(FALSE)
	. = loc.examine(examiner)


// -- DELEGATE COPY --

// A type for copying delegates' self-appearance.
/atom/movable/openspace/delegate_copy
	plane = OPENTURF_MAX_PLANE	// These *should* only ever be at the top?
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/turf/delegate

/atom/movable/openspace/delegate_copy/Initialize(mapload, ...)
	. = ..()
	ASSERT(isturf(loc))
	delegate = loc:below

/atom/movable/openspace/delegate_copy/attackby(obj/item/W, mob/user)
	loc.attackby(W, user)

/atom/movable/openspace/delegate_copy/attack_hand(mob/user as mob)
	to_chat(user, SPAN_NOTICE("You cannot reach \the [src] from here."))

/atom/movable/openspace/delegate_copy/attack_generic(mob/user as mob)
	to_chat(user, SPAN_NOTICE("You cannot reach \the [src] from here."))

/atom/movable/openspace/delegate_copy/examine(mob/examiner)
	SHOULD_CALL_PARENT(FALSE)
	. = delegate.examine(examiner)

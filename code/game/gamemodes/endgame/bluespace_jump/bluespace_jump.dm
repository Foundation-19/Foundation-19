/datum/universal_state/bluespace_jump
	name = "Bluespace Jump"
	var/list/bluespaced = list()
	var/list/bluegoasts = list()
	var/list/affected_levels
	var/list/old_accessible_z_levels

/datum/universal_state/bluespace_jump/New(list/zlevels)
	affected_levels = zlevels

/datum/universal_state/bluespace_jump/OnEnter()
	var/space_zlevel = GLOB.using_map.get_empty_zlevel() //get a place for stragglers
	for(var/mob/living/M in SSmobs.mob_list)
		if(M.z in affected_levels)
			var/area/A = get_area(M)
			if(istype(A,/area/space)) //straggler
				var/turf/T = locate(M.x, M.y, space_zlevel)
				if(T)
					M.forceMove(T)
			else
				apply_bluespaced(M)
	for(var/mob/goast in GLOB.ghost_mob_list)
		goast.mouse_opacity = MOUSE_OPACITY_TRANSPARENT	//can't let you click that Dave
		goast.set_invisibility(SEE_INVISIBLE_LIVING)
		goast.alpha = 255
	old_accessible_z_levels = GLOB.using_map.accessible_z_levels.Copy()
	for(var/z in affected_levels)
		GLOB.using_map.accessible_z_levels -= "[z]" //not accessible during the jump

/datum/universal_state/bluespace_jump/OnExit()
	for(var/mob/M in bluespaced)
		if(!QDELETED(M))
			clear_bluespaced(M)

	bluespaced.Cut()
	GLOB.using_map.accessible_z_levels = old_accessible_z_levels
	old_accessible_z_levels = null

/datum/universal_state/bluespace_jump/OnPlayerLatejoin(mob/living/M)
	if(M.z in affected_levels)
		apply_bluespaced(M)

/datum/universal_state/bluespace_jump/OnTouchMapEdge(atom/A)
	if((A.z in affected_levels) && (A in bluespaced))
		if(ismob(A))
			to_chat(A,SPAN_WARNING("You drift away into the shifting expanse, never to be seen again."))
		qdel(A) //lost in bluespace
		return FALSE
	return TRUE

/datum/universal_state/bluespace_jump/proc/apply_bluespaced(mob/living/M)
	bluespaced += M
	if(M.client)
		to_chat(M,SPAN_NOTICE("You feel oddly light, and somewhat disoriented as everything around you shimmers and warps ever so slightly."))
		M.overlay_fullscreen("bluespace", /obj/screen/fullscreen/bluespace_overlay)
	M.confused = 20
	bluegoasts += new/obj/effect/bluegoast/(get_turf(M),M)

/datum/universal_state/bluespace_jump/proc/clear_bluespaced(mob/living/M)
	if(M.client)
		to_chat(M,SPAN_NOTICE("You feel rooted in material world again."))
		M.clear_fullscreen("bluespace")
	M.confused = 0
	for(var/mob/goast in GLOB.ghost_mob_list)
		goast.mouse_opacity = initial(goast.mouse_opacity)
		goast.set_invisibility(initial(goast.invisibility))
		goast.alpha = initial(goast.alpha)
	for(var/G in bluegoasts)
		qdel(G)
	bluegoasts.Cut()

/obj/effect/bluegoast
	name = "bluespace echo"
	desc = "It's not going to punch you, is it?"
	var/mob/living/carbon/human/real_one
	anchored = TRUE
	var/reality = 0
	simulated = FALSE

/obj/effect/bluegoast/New(nloc, nreal_one)
	..(nloc)
	if(!nreal_one)
		qdel(src)
		return
	real_one = nreal_one
	set_dir(real_one.dir)
	appearance = real_one.appearance
	GLOB.moved_event.register(real_one, src, /obj/effect/bluegoast/proc/mirror)
	GLOB.dir_set_event.register(real_one, src, /obj/effect/bluegoast/proc/mirror_dir)
	GLOB.destroyed_event.register(real_one, src, /datum/proc/qdel_self)

/obj/effect/bluegoast/Destroy()
	GLOB.destroyed_event.unregister(real_one, src)
	GLOB.dir_set_event.unregister(real_one, src)
	GLOB.moved_event.unregister(real_one, src)
	real_one = null
	. = ..()

/obj/effect/bluegoast/proc/mirror(atom/movable/am, old_loc, new_loc)
	var/ndir = get_dir(new_loc,old_loc)
	appearance = real_one.appearance
	var/nloc = get_step(src, ndir)
	if(nloc)
		forceMove(nloc)
	if(nloc == new_loc)
		to_chat(real_one, SPAN_WARNING("You feel a bit less real. Which one of you two was original again?.."))
		if(prob(50))
			real_one.confused = max(real_one.confused, 10)
		if(prob(20))
			real_one.drowsyness = max(real_one.drowsyness, 3)

/obj/effect/bluegoast/proc/mirror_dir(atom/movable/am, old_dir, new_dir)
	set_dir(GLOB.reverse_dir[new_dir])

/obj/effect/bluegoast/examine()
	return real_one?.examine(arglist(args))

/obj/screen/fullscreen/bluespace_overlay
	icon = 'icons/effects/effects.dmi'
	icon_state = "mfoam"
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	color = "#ff9900"
	alpha = 100
	blend_mode = BLEND_SUBTRACT
	layer = FULLSCREEN_LAYER

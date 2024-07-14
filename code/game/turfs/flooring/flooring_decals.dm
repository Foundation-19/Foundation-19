// These are objects that destroy themselves and add themselves to the
// decal list of the floor under them. Use them rather than distinct icon_states
// when mapping in interesting floor designs.
var/list/floor_decals = list()

/obj/effect/floor_decal
	name = "floor decal"
	icon = 'icons/turf/flooring/decals.dmi'
	layer = DECAL_LAYER
	appearance_flags = RESET_COLOR
	var/detail_overlay
	var/detail_color

/obj/effect/floor_decal/Initialize(mapload, newdir, newcolour, newappearance)
	SHOULD_CALL_PARENT(FALSE)
	if(newappearance) appearance = newappearance
	if(newcolour) color = newcolour
	if(newdir) setDir(newdir)

	var/turf/T = get_turf(src)
	if(istype(T, /turf/simulated/floor) || istype(T, /turf/unsimulated/floor))
		layer = T.is_plating() ? DECAL_PLATING_LAYER : DECAL_LAYER
		var/cache_key = "[alpha][color][dir][icon_state][layer][detail_overlay][detail_color][appearance_flags]"
		var/image/I = floor_decals[cache_key]
		if(!I)
			I = image(icon = src.icon, icon_state = src.icon_state, dir = src.dir)
			I.layer = layer
			I.appearance_flags = appearance_flags
			I.color = src.color
			I.alpha = src.alpha
			if(detail_overlay)
				I.overlays |= overlay_image(icon, "[detail_overlay]", color = detail_color, flags = RESET_COLOR)
			floor_decals[cache_key] = I

		if(!T.decals) T.decals = list()
		T.decals |= I
		T.add_overlay(I)

	atom_flags |= ATOM_FLAG_INITIALIZED
	return INITIALIZE_HINT_QDEL

/*/obj/effect/floor_decal/LateInitialize()
	SHOULD_CALL_PARENT(FALSE)

	qdel(src)*/

// These are objects that destroy themselves and add themselves to the
// decal list of the floor under them. Use them rather than distinct icon_states
// when mapping in interesting floor designs.
var/list/floor_decals = list()

/obj/effect/floor_decal
	name = "floor decal"
	icon = 'icons/turf/flooring/decals.dmi'
	layer = DECAL_LAYER
	appearance_flags = RESET_COLOR
	var/supplied_dir
	var/detail_overlay
	var/detail_color

/obj/effect/floor_decal/New(newloc, newdir, newcolour, newappearance)
	supplied_dir = newdir
	if(newappearance) appearance = newappearance
	if(newcolour) color = newcolour
	..(newloc)

/obj/effect/floor_decal/Initialize()
	SHOULD_CALL_PARENT(FALSE)
	if(supplied_dir) set_dir(supplied_dir)
	var/turf/T = get_turf(src)
	if(istype(T, /turf/simulated/floor) || istype(T, /turf/unsimulated/floor))
		layer = T.is_plating() ? DECAL_PLATING_LAYER : DECAL_LAYER
		var/cache_key = "[alpha]-[color]-[dir]-[icon_state]-[plane]-[layer]-[detail_overlay]-[detail_color]"
		if(!floor_decals[cache_key])
			var/image/I = image(icon = src.icon, icon_state = src.icon_state, dir = src.dir)
			I.layer = layer
			I.appearance_flags = appearance_flags
			I.color = src.color
			I.alpha = src.alpha
			if(detail_overlay)
				var/image/B = overlay_image(icon, "[detail_overlay]", flags=RESET_COLOR)
				B.color = detail_color
				I.add_overlay(B)
			floor_decals[cache_key] = I
		if(!T.decals) T.decals = list()
		T.decals |= floor_decals[cache_key]
		T.add_overlay(floor_decals[cache_key])
	atom_flags |= ATOM_FLAG_INITIALIZED
	return INITIALIZE_HINT_QDEL

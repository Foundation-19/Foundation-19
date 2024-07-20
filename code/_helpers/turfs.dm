// Returns the atom sitting on the turf.
// For example, using this on a disk, which is in a bag, on a mob, will return the mob because it's on the turf.
/proc/get_atom_on_turf(atom/movable/M)
	var/atom/mloc = M
	while(mloc && mloc.loc && !istype(mloc.loc, /turf/))
		mloc = mloc.loc
	return mloc

/proc/isfloor(turf/T)
	return (istype(T, /turf/simulated/floor) || istype(T, /turf/unsimulated/floor))

/proc/turf_clear(turf/T)
	for(var/atom/A in T)
		if(A.simulated)
			return 0
	return 1

// Picks a turf without a mob from the given list of turfs, if one exists.
// If no such turf exists, picks any random turf from the given list of turfs.
/proc/pick_mobless_turf_if_exists(list/start_turfs)
	if(!start_turfs.len)
		return null

	var/list/available_turfs = list()
	for(var/start_turf in start_turfs)
		var/mob/M = locate() in start_turf
		if(!M)
			available_turfs += start_turf
	if(!available_turfs.len)
		available_turfs = start_turfs
	return pick(available_turfs)

/proc/get_random_turf_in_range(atom/origin, outer_range, inner_range)
	origin = get_turf(origin)
	if(!origin)
		return
	var/list/turfs = list()
	for(var/turf/T in orange(origin, outer_range))
		if(!(T.z in GLOB.using_map.sealed_levels)) // Picking a turf outside the map edge isn't recommended
			if(T.x >= world.maxx-TRANSITIONEDGE || T.x <= TRANSITIONEDGE)	continue
			if(T.y >= world.maxy-TRANSITIONEDGE || T.y <= TRANSITIONEDGE)	continue
		if(!inner_range || get_dist(origin, T) >= inner_range)
			turfs += T
	if(turfs.len)
		return pick(turfs)

///Returns a turf based on text inputs, original turf and viewing client
/proc/parse_caught_click_modifiers(list/modifiers, turf/origin, client/viewing_client)
	if(!modifiers)
		return null

	var/screen_loc = splittext(LAZYACCESS(modifiers, SCREEN_LOC), ",")
	var/list/actual_view = getviewsize(viewing_client ? viewing_client.view : world.view)
	var/click_turf_x = splittext(screen_loc[1], ":")
	var/click_turf_y = splittext(screen_loc[2], ":")
	var/click_turf_z = origin.z

	var/click_turf_px = text2num(click_turf_x[2])
	var/click_turf_py = text2num(click_turf_y[2])
	click_turf_x = origin.x + text2num(click_turf_x[1]) - round(actual_view[1] / 2) - 1
	click_turf_y = origin.y + text2num(click_turf_y[1]) - round(actual_view[2] / 2) - 1

	var/turf/click_turf = locate(clamp(click_turf_x, 1, world.maxx), clamp(click_turf_y, 1, world.maxy), click_turf_z)
	LAZYSET(modifiers, ICON_X, "[(click_turf_px - click_turf.pixel_x) + ((click_turf_x - click_turf.x) * world.icon_size)]")
	LAZYSET(modifiers, ICON_Y, "[(click_turf_py - click_turf.pixel_y) + ((click_turf_y - click_turf.y) * world.icon_size)]")
	return click_turf

/*
	Z-level Helpers
*/
///Like get_step but can handle z-levels
/proc/get_step_multiz(ref, dir)
	if(dir & UP)
		dir &= ~UP
		return GetAbove(ref)
	if(dir & DOWN)
		dir &= ~DOWN
		return GetBelow(ref)
	return get_step(ref, dir)

///Like get_dir but works with zlevels
/proc/get_dir_multiz(turf/us, turf/them)
	us = get_turf(us)
	them = get_turf(them)
	var/dir = NONE
	if(!us || !them)
		return NONE
	if(us.z == them.z)
		return get_dir(us, them)
	else
		if(us.z < them.z)
			dir = UP
		else if(us.z > them.z)
			dir = DOWN
	return (dir | get_dir(us, them))

/*
	Predicate helpers
*/

/proc/is_space_turf(turf/T)
	return isspaceturf(T)

/proc/is_not_space_turf(turf/T)
	return !isspaceturf(T)

/proc/is_open_space(turf/T)
	return isopenspace(T)

/proc/is_not_open_space(turf/T)
	return !isopenspace(T)

/proc/is_holy_turf(turf/T)
	return T && T.holy

/proc/is_not_holy_turf(turf/T)
	return !is_holy_turf(T)

/proc/turf_contains_dense_objects(turf/T)
	return T.contains_dense_objects()

/proc/not_turf_contains_dense_objects(turf/T)
	return !turf_contains_dense_objects(T)

/proc/is_station_turf(turf/T)
	return T && isStationLevel(T.z)

/proc/has_air(turf/T)
	return !!T.return_air()

/proc/IsTurfAtmosUnsafe(turf/T)
	if (!T)
		return "The spawn location doesn't seem to exist. Please contact an admin via adminhelp if this error persists."

	if(isspaceturf(T)) // Space tiles
		return "Spawn location is open to space."
	var/datum/gas_mixture/air = T.return_air()
	if(!air)
		return "Spawn location lacks atmosphere."
	return get_atmosphere_issues(air, 1)

/proc/IsTurfAtmosSafe(turf/T)
	return !IsTurfAtmosUnsafe(T)

/proc/is_below_sound_pressure(turf/T)
	var/datum/gas_mixture/environment = T ? T.return_air() : null
	var/pressure =  environment ? environment.return_pressure() : 0
	if(pressure < SOUND_MINIMUM_PRESSURE)
		return TRUE
	return FALSE

/proc/is_dark(turf/T, darkness_threshold = 0.03)
	if(T.get_lumcount() <= darkness_threshold)
		return TRUE
	return FALSE

/*
	Turf manipulation
*/

//Returns an assoc list that describes how turfs would be changed if the
//turfs in turfs_src were translated by shifting the src_origin to the dst_origin
/proc/get_turf_translation(turf/src_origin, turf/dst_origin, list/turfs_src)
	var/list/turf_map = list()
	for(var/turf/source in turfs_src)
		var/x_pos = (source.x - src_origin.x)
		var/y_pos = (source.y - src_origin.y)
		var/z_pos = (source.z - src_origin.z)

		var/turf/target = locate(dst_origin.x + x_pos, dst_origin.y + y_pos, dst_origin.z + z_pos)
		if(!target)
			error("Null turf in translation @ ([dst_origin.x + x_pos], [dst_origin.y + y_pos], [dst_origin.z + z_pos])")
		turf_map[source] = target //if target is null, preserve that information in the turf map

	return turf_map


/proc/translate_turfs(list/translation, area/base_area = null, turf/base_turf)
	for(var/turf/source in translation)

		var/turf/target = translation[source]

		if(target)
			if(base_area)
				ChangeArea(target, get_area(source))
				ChangeArea(source, base_area)
			transport_turf_contents(source, target)

	//change the old turfs
	for(var/turf/source in translation)
		source.ChangeTurf(base_turf ? base_turf : get_base_turf_by_area(source), 1, 1)

//Transports a turf from a source turf to a target turf, moving all of the turf's contents and making the target a copy of the source.
/proc/transport_turf_contents(turf/source, turf/target)

	var/turf/new_turf = target.ChangeTurf(source.type, 1, 1)
	new_turf.transport_properties_from(source)

	for(var/obj/O in source)
		if(O.simulated)
			O.forceMove(new_turf)
		else if(istype(O,/obj/effect))
			var/obj/effect/E = O
			if(E.movable_flags & MOVABLE_FLAG_EFFECTMOVE)
				E.forceMove(new_turf)

	for(var/mob/M in source)
		if(isEye(M)) continue // If we need to check for more mobs, I'll add a variable
		M.forceMove(new_turf)

	if (GLOB.mob_spawners[source])
		var/datum/mob_spawner/source_spawner = GLOB.mob_spawners[source]
		source_spawner.area = get_area(new_turf)
		source_spawner.center = new_turf
		GLOB.mob_spawners[new_turf] = source_spawner

		GLOB.mob_spawners[source] = null

	return new_turf

/*
	List generation helpers
*/

/proc/get_turfs_in_range(turf/center, range, list/predicates)
	. = list()

	if (!istype(center))
		return

	for (var/turf/T in trange(range, center))
		if (!predicates || all_predicates_true(list(T), predicates))
			. += T

/*
	Pick helpers
*/

/proc/pick_turf_in_range(turf/center, range, list/turf_predicates)
	var/list/turfs = get_turfs_in_range(center, range, turf_predicates)
	if (length(turfs))
		return pick(turfs)

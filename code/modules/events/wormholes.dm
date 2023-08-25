/datum/event/wormholes/setup()
	endWhen = rand(30,60)

/datum/event/wormholes/announce()
	command_announcement.Announce("Topological anomalies have been detected near [station_name()].", "[station_name()] Sensor Array", new_sound = sound('sound/AI/spanomalies.ogg', volume=25))

/datum/event/wormholes/end()
	var/list/turfs = get_viable_turfs()

	for(var/i = 0, i < (severity * 5 - 1), i++)
		if(LAZYLEN(turfs) < 2)
			break
		var/enterTurf = pick_n_take(turfs)
		var/exitTurf = pick_n_take(turfs)
		create_wormhole(enterTurf, exitTurf, rand(1 MINUTES, (2 * severity) MINUTES))

/datum/event/wormholes/proc/get_viable_turfs()

	var/list/location = get_filtered_areas(list(/proc/is_not_space_area, /proc/is_station_area, /proc/is_not_maint_area))

	if(!location)
		log_debug("Wormhole event failed to find a viable area. Aborting.")
		kill(TRUE)
		return

	var/list/turfs = list()

	for(var/area/A in location)
		turfs |= get_area_turfs(A, list(/proc/not_turf_contains_dense_objects, /proc/IsTurfAtmosSafe))

	if(!turfs.len)
		log_debug("Wormhole event failed to find viable turfs after finding areas.")
		kill(TRUE)
		return

	return turfs

// proc is global in case wormholes need to be spawned outside event
/proc/create_wormhole(turf/enter as turf, turf/exit as turf, lifetime)
	var/obj/effect/portal/P = new /obj/effect/portal(enter, exit, lifetime, prec = 0)
	P.icon = 'icons/obj/objects.dmi'
	P.icon_state = "anom"
	P.SetName("wormhole")

/datum/event/wallrot/setup()
	announceWhen = rand(60, 180)
	endWhen = announceWhen + 1

/datum/event/wallrot/announce()
	command_announcement.Announce("Containment breach of biohazardous Euclid-class object detected. Structures may be contaminated with fungal SCP.", "Biohazard Alert")

/datum/event/wallrot/start()

	var/list/pick_turfs = list()

	for(var/z in GLOB.using_map.station_levels)
		var/list/turfs = block(locate(1, 1, z), locate(world.maxx, world.maxy, z))
		for(var/turf/simulated/wall/T in turfs)
			if(is_randomly_rottable_turf(T))
				pick_turfs += T

	var/turf/simulated/wall/center

	if(pick_turfs.len)

		center = pick(pick_turfs)
		center.rot()

		for(var/i = (severity * rand(5, 10)), i > 0, i--)
			var/turf/simulated/wall/W = pick_turf_in_range(center, (3 + (2 * severity)), list(/proc/is_station_turf, /proc/is_randomly_rottable_turf))
			if(W)
				W.rot()
			else
				break

// Predicate used for picking rottable turfs

/proc/is_randomly_rottable_turf(turf/T)
	return (istype(T, /turf/simulated/wall) && !(locate(/obj/effect/overlay/wallrot) in T))

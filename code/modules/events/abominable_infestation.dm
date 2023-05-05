/datum/event/abominable_infestation
	announceWhen = 30
	var/spawncount = 1

/datum/event/abominable_infestation/setup()
	announceWhen = rand(announceWhen, announceWhen + 30)
	spawncount = rand(2 * severity, 4 * severity)

/datum/event/abominable_infestation/announce()
	GLOB.using_map.unidentified_lifesigns_announcement()

/datum/event/abominable_infestation/start()
	var/list/vents = list()
	for(var/obj/machinery/atmospherics/unary/vent_pump/temp_vent in SSmachines.machinery)
		if(!temp_vent.welded && temp_vent.network && (temp_vent.loc.z in affecting_z))
			if(temp_vent.network.normal_members.len > 50)
				vents += temp_vent

	while((spawncount >= 1) && LAZYLEN(vents))
		var/obj/vent = pick(vents)
		if(prob(33))
			new /mob/living/simple_animal/hostile/infestation/larva/implanter(get_turf(vent))
		else
			new /mob/living/simple_animal/hostile/infestation/larva(get_turf(vent))
		vents -= vent
		spawncount--

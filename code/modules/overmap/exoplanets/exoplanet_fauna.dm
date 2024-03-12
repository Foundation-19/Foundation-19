/obj/effect/overmap/visitable/sector/exoplanet/proc/adapt_animal(mob/living/simple_animal/A, setname = TRUE)
	if (setname)
		if (species[A.type])
			A.setName(species[A.type])
			A.real_name = species[A.type]
		else
			A.setName("alien creature")
			A.real_name = "alien creature"
			add_verb(A, /mob/living/simple_animal/proc/name_species)
	if (atmosphere)
		//Set up gases for living things
		if (!LAZYLEN(breathgas))
			var/list/goodgases = gas_data.gases.Copy()
			var/gasnum = min(rand(1,3), goodgases.len)
			for (var/i = 1 to gasnum)
				var/gas = pick(goodgases)
				breathgas[gas] = round(0.4*goodgases[gas], 0.1)
				goodgases -= gas
		if (!badgas)
			var/list/badgases = gas_data.gases.Copy()
			badgases -= atmosphere.gas
			badgas = pick(badgases)

		A.minbodytemp = atmosphere.temperature - 20
		A.maxbodytemp = atmosphere.temperature + 30
		A.bodytemperature = (A.maxbodytemp+A.minbodytemp)/2
		if (A.min_gas)
			A.min_gas = breathgas.Copy()
		if (A.max_gas)
			A.max_gas = list()
			A.max_gas[badgas] = 5
	else
		A.min_gas = null
		A.max_gas = null

/obj/effect/overmap/visitable/sector/exoplanet/proc/remove_animal(mob/M)
	animals -= M
	UnregisterSignal(M, COMSIG_ADD_TO_DEAD_MOB_LIST)
	UnregisterSignal(M, COMSIG_PARENT_QDELETING)
	repopulate_types |= M.type

/obj/effect/overmap/visitable/sector/exoplanet/proc/handle_repopulation()
	for (var/i = 1 to round(max_animal_count - animals.len))
		if (prob(10))
			var/turf/simulated/T = pick_area_turf(planetary_area, list(/proc/not_turf_contains_dense_objects))
			var/mob_type = pick(repopulate_types)
			var/mob/S = new mob_type(T)
			track_animal(S)
			adapt_animal(S)
	if (animals.len >= max_animal_count)
		repopulating = 0

/obj/effect/overmap/visitable/sector/exoplanet/proc/track_animal(mob/A)
	animals += A
	RegisterSignal(A, COMSIG_ADD_TO_DEAD_MOB_LIST, /obj/effect/overmap/visitable/sector/exoplanet/proc/remove_animal)
	RegisterSignal(A, COMSIG_PARENT_QDELETING, /obj/effect/overmap/visitable/sector/exoplanet/proc/remove_animal)

/obj/effect/overmap/visitable/sector/exoplanet/proc/get_random_species_name()
	return pick("nol","shan","can","fel","xor")+pick("a","e","o","t","ar")+pick("ian","oid","ac","ese","inian","rd")

/obj/effect/overmap/visitable/sector/exoplanet/proc/rename_species(species_type, newname, force = FALSE)
	if (species[species_type] && !force)
		return FALSE

	species[species_type] = newname
	log_and_message_staff("renamed [species_type] to [newname]")
	for (var/mob/living/simple_animal/A in animals)
		if (istype(A,species_type))
			A.setName(newname)
			A.real_name = newname
			remove_verb(A, /mob/living/simple_animal/proc/name_species)
	return TRUE

/obj/effect/landmark/exoplanet_spawn
	name = "spawn exoplanet animal"

/obj/effect/landmark/exoplanet_spawn/proc/do_spawn(obj/effect/overmap/visitable/sector/exoplanet/planet)
	if (LAZYLEN(planet.fauna_types))
		var/beastie = pick(planet.fauna_types)
		var/mob/M = new beastie(get_turf(src))
		planet.adapt_animal(M)
		planet.track_animal(M)

/obj/effect/landmark/exoplanet_spawn/megafauna
	name = "spawn exoplanet megafauna"

/obj/effect/landmark/exoplanet_spawn/megafauna/do_spawn(obj/effect/overmap/visitable/sector/exoplanet/planet)
	if (LAZYLEN(planet.megafauna_types))
		var/beastie = pick(planet.megafauna_types)
		var/mob/M = new beastie(get_turf(src))
		planet.adapt_animal(M)
		planet.track_animal(M)

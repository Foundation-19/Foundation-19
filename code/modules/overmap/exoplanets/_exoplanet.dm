GLOBAL_VAR(planet_repopulation_disabled)
/// The number of planetary bodies in this sector, usually exoplanets. We use this when generating names for planets and some away sites.
GLOBAL_VAR_INIT(number_of_planetoids, 0)

/obj/effect/overmap/visitable/sector/exoplanet
	name = "exoplanet"
	icon_state = "globe"
	in_space = FALSE
	known = TRUE
	var/area/planetary_area
	var/list/seeds = list()
	var/list/fauna_types = list()		// possible types of mobs to spawn
	var/list/megafauna_types = list() 	// possibble types of megafauna to spawn
	var/list/animals = list()
	var/max_animal_count
	var/datum/gas_mixture/atmosphere
	var/list/breathgas = list()	//list of gases animals/plants require to survive
	var/badgas					//id of gas that is toxic to life here

	var/lightlevel = 0 //This default makes turfs not generate light. Adjust to have exoplanents be lit.
	var/night = TRUE
	var/daycycle //How often do we change day and night
	var/daycolumn = 0 //Which column's light needs to be updated next?
	var/daycycle_column_delay = 10 SECONDS

	var/maxx
	var/maxy
	var/landmark_type = /obj/effect/shuttle_landmark/automatic

	var/list/rock_colors = list(COLOR_ASTEROID_ROCK)
	var/list/plant_colors = list("RANDOM")
	var/grass_color
	var/surface_color = COLOR_ASTEROID_ROCK
	var/water_color = "#436499"
	var/image/skybox_image

	var/list/actors = list() //things that appear in engravings on xenoarch finds.
	var/list/species = list() //list of names to use for simple animals

	var/flora_diversity = 4				// max number of different seeds growing here
	var/has_trees = TRUE				// if large flora should be generated
	var/list/small_flora_types = list()	// seeds of 'small' flora
	var/list/big_flora_types = list()	// seeds of tree-tier flora

	var/repopulating = FALSE
	var/repopulate_types = list() // animals which have died that may come back

	var/list/possible_themes = list(
		/datum/exoplanet_theme = 45,
		/datum/exoplanet_theme/mountains = 65,
		/datum/exoplanet_theme/radiation_bombing = 10,
		/datum/exoplanet_theme/ruined_city = 5,
		/datum/exoplanet_theme/robotic_guardians = 10
		)
	var/list/themes = list()

	var/list/map_generators = list()

	//Flags deciding what features to pick
	var/ruin_tags_whitelist
	var/ruin_tags_blacklist
	var/features_budget = 5
	var/list/possible_features = list()
	var/list/spawned_features

	//Either a type or a list of types and weights. You must include all types if it's a list
	var/list/habitability_distribution = list(
		HABITABILITY_IDEAL = 10,
		HABITABILITY_OKAY = 40,
		HABITABILITY_BAD = 50
	)
	var/habitability_class

/obj/effect/overmap/visitable/sector/exoplanet/proc/generate_habitability()
	if (isnum(habitability_distribution))
		habitability_class = habitability_distribution
	else
		habitability_class = pickweightindex(habitability_distribution)

/obj/effect/overmap/visitable/sector/exoplanet/New(nloc, max_x, max_y)
	if (!GLOB.using_map.use_overmap)
		return

	maxx = max_x ? max_x : world.maxx
	maxy = max_y ? max_y : world.maxy

	GLOB.number_of_planetoids++
	var/planet_name = generate_planet_name()
	name = "[planet_name], \a [name]"

	planetary_area = new planetary_area()
	GLOB.using_map.area_purity_test_exempt_areas += planetary_area.type
	planetary_area.name = "Surface of [planet_name]"

	INCREMENT_WORLD_Z_SIZE
	forceMove(locate(1,1,world.maxz))

	if (LAZYLEN(possible_themes))
		var/datum/exoplanet_theme/T = pick(possible_themes)
		themes += new T
		possible_themes -= T

	for (var/datum/exoplanet_theme/T in themes)
		if (T.ruin_tags_whitelist)
			ruin_tags_whitelist |= T.ruin_tags_whitelist
		if (T.ruin_tags_blacklist)
			ruin_tags_blacklist |= T.ruin_tags_blacklist

	for (var/T in subtypesof(/datum/map_template/ruin/exoplanet))
		var/datum/map_template/ruin/exoplanet/ruin = T
		if (ruin_tags_whitelist && !(ruin_tags_whitelist & initial(ruin.ruin_tags)))
			continue
		if (ruin_tags_blacklist & initial(ruin.ruin_tags))
			continue
		possible_features += new ruin
	..()

/obj/effect/overmap/visitable/sector/exoplanet/proc/build_level()
	generate_habitability()
	generate_atmosphere()
	for (var/datum/exoplanet_theme/T in themes)
		T.adjust_atmosphere(src)
	generate_flora()
	generate_map()
	generate_features()
	for (var/datum/exoplanet_theme/T in themes)
		T.after_map_generation(src)
	generate_landing(2)
	update_biome()
	generate_daycycle()
	generate_planet_image()
	START_PROCESSING(SSobj, src)

//attempt at more consistent history generation for xenoarch finds.
/obj/effect/overmap/visitable/sector/exoplanet/proc/get_engravings()
	if (!actors.len)
		actors += pick("alien humanoid","an amorphic blob","a short, hairy being","a rodent-like creature","a robot","a primate","a reptilian alien","an unidentifiable object","a statue","a starship","unusual devices","a structure")
		actors += pick("alien humanoids","amorphic blobs","short, hairy beings","rodent-like creatures","robots","primates","reptilian aliens")

	var/engravings = "[actors[1]] \
	[pick("surrounded by","being held aloft by","being struck by","being examined by","communicating with")] \
	[actors[2]]"
	if (prob(50))
		engravings += ", [pick("they seem to be enjoying themselves","they seem extremely angry","they look pensive","they are making gestures of supplication","the scene is one of subtle horror","the scene conveys a sense of desperation","the scene is completely bizarre")]"
	engravings += "."
	return engravings

/obj/effect/overmap/visitable/sector/exoplanet/Process(wait, tick)
	if (animals.len < 0.5*max_animal_count && !repopulating)
		repopulating = TRUE
		max_animal_count = round(max_animal_count * 0.5)

	for (var/zlevel in map_z)
		if (repopulating && !GLOB.planet_repopulation_disabled)
			handle_repopulation()

		if (!atmosphere)
			continue

		var/zone/Z
		for (var/i = 1 to maxx)
			var/turf/simulated/T = locate(i, 2, zlevel)
			if (istype(T) && T.zone && T.zone.contents.len > (maxx*maxy*0.25)) //if it's a zone quarter of zlevel, good enough odds it's planetary main one
				Z = T.zone
				break
		if (Z && !Z.fire_tiles.len && !atmosphere.compare(Z.air)) //let fire die out first if there is one
			var/datum/gas_mixture/daddy = new() //make a fake 'planet' zone gas
			daddy.copy_from(atmosphere)
			daddy.group_multiplier = Z.air.group_multiplier
			Z.air.equalize(daddy)

	if (daycycle)
		if (tick % round(daycycle / wait) == 0)
			night = !night
			daycolumn = 1
		if (daycolumn && tick % round(daycycle_column_delay / wait) == 0)
			update_daynight()

/obj/effect/overmap/visitable/sector/exoplanet/proc/update_daynight()
	var/light = 0.1
	if (!night)
		light = lightlevel
	for (var/turf/simulated/floor/exoplanet/T in block(locate(daycolumn,1,min(map_z)),locate(daycolumn,maxy,max(map_z))))
		T.set_light(light, 0.1, 2)
	daycolumn++
	if (daycolumn > maxx)
		daycolumn = 0

/obj/effect/overmap/visitable/sector/exoplanet/proc/generate_map()
	var/list/grasscolors = plant_colors.Copy()
	grasscolors -= "RANDOM"
	if (length(grasscolors))
		grass_color = pick(grasscolors)

	for (var/datum/exoplanet_theme/T in themes)
		T.before_map_generation(src)
	for (var/zlevel in map_z)
		var/list/edges
		edges += block(locate(1, 1, zlevel), locate(TRANSITIONEDGE, maxy, zlevel))
		edges |= block(locate(maxx-TRANSITIONEDGE, 1, zlevel),locate(maxx, maxy, zlevel))
		edges |= block(locate(1, 1, zlevel), locate(maxx, TRANSITIONEDGE, zlevel))
		edges |= block(locate(1, maxy-TRANSITIONEDGE, zlevel),locate(maxx, maxy, zlevel))
		for (var/turf/T in edges)
			T.ChangeTurf(/turf/simulated/planet_edge)
		var/padding = TRANSITIONEDGE
		for (var/map_type in map_generators)
			if (ispath(map_type, /datum/random_map/noise/exoplanet))
				new map_type(null,padding,padding,zlevel,maxx-padding,maxy-padding,0,1,1,planetary_area, plant_colors)
			else
				new map_type(null,1,1,zlevel,maxx,maxy,0,1,1,planetary_area)

/obj/effect/overmap/visitable/sector/exoplanet/proc/generate_features()
	spawned_features = seedRuins(map_z, features_budget, possible_features, /area/exoplanet, maxx, maxy)

/obj/effect/overmap/visitable/sector/exoplanet/proc/update_biome()
	for (var/datum/seed/S in seeds)
		adapt_seed(S)

	for (var/mob/living/simple_animal/A in animals)
		adapt_animal(A)

/obj/effect/overmap/visitable/sector/exoplanet/proc/generate_daycycle()
	if (lightlevel)
		night = FALSE //we start with a day if we have light.

		//When you set daycycle ensure that the minimum is larger than [maxx * daycycle_column_delay].
		//Otherwise the right side of the exoplanet can get stuck in a forever day.
		daycycle = rand(10 MINUTES, 40 MINUTES)

/obj/effect/landmark/exoplanet_spawn/Initialize()
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/effect/landmark/exoplanet_spawn/LateInitialize()
	. = ..()
	var/obj/effect/overmap/visitable/sector/exoplanet/E = map_sectors["[z]"]
	if (istype(E))
		do_spawn(E)

//Tries to generate num landmarks, but avoids repeats.
/obj/effect/overmap/visitable/sector/exoplanet/proc/generate_landing(num = 1)
	var/places = list()
	var/attempts = 30*num
	var/new_type = landmark_type
	while(num)
		attempts--
		var/turf/T = locate(rand(20, maxx - 30), rand(20, maxy - 30),map_z[map_z.len])
		if (!T || (T in places)) // Two landmarks on one turf is forbidden as the landmark code doesn't work with it.
			continue
		if (attempts >= 0) // While we have the patience, try to find better spawn points. If out of patience, put them down wherever, so long as there are no repeats.
			var/valid = TRUE
			var/list/block_to_check = block(locate(T.x - 15, T.y - 15, T.z), locate(T.x + 15, T.y + 15, T.z))
			for (var/turf/check in block_to_check)
				if (!istype(get_area(check), /area/exoplanet) || check.turf_flags & TURF_FLAG_NORUINS)
					valid = FALSE
					break
			if (attempts >= 10)
				if (check_collision(T.loc, block_to_check)) //While we have lots of patience, ensure landability
					valid = FALSE
			else //Running out of patience, but would rather not clear ruins, so switch to clearing landmarks and bypass landability check
				new_type = /obj/effect/shuttle_landmark/automatic/clearing

			if (!valid)
				continue

		num--
		places += T
		new new_type(T)

/obj/effect/overmap/visitable/sector/exoplanet/get_scan_data(mob/user)
	var/list/extra_data = list("<b>Target:</b> [name]")
	var/user_skill = user.get_skill_value(SKILL_SCIENCE)
	// Show a detailed scan summary if we have it
	if (scan_summary)
		extra_data += "<br><b>Analysis:</b> [scan_summary]"
		if (scan_assessment)
			extra_data += "<br><b>Assessment:</b> [scan_assessment]"
	// Otherwise, just use the description
	else
		extra_data += "<br><b>Description:</b> [desc]"
	extra_data += "<br><hr>"

	// Atmosphere
	if (user_skill >= SKILL_BASIC)
		if (atmosphere)
			if (user_skill >= SKILL_TRAINED)
				var/list/gases = list()
				for (var/g in atmosphere.gas)
					if (atmosphere.gas[g] > atmosphere.total_moles * 0.05)
						gases += gas_data.name[g]
				extra_data += "<b>Atmosphere composition:</b> [english_list(gases)]"
				var/inaccuracy = rand(8, 12) / 10
				extra_data += "<b>Surface pressure:</b> ~[atmosphere.return_pressure() * inaccuracy] kPa"
				extra_data += "<b>Temperature:</b> ~[atmosphere.temperature * inaccuracy] K"
			else
				extra_data += "Atmosphere present. Unable to determine surface conditions."
		else
			extra_data += "No atmosphere present."
		extra_data += "<br><hr>"

	if (user_skill >= SKILL_BASIC)
		// Mineral content
		var/mineral_string = "Normal."
		for (var/V in map_generators)
			if (ispath(V, /datum/random_map/noise/ore))
				var/datum/random_map/noise/ore/O = V
				mineral_string = initial(O.scan_info)
				break // we should only ever have one of these, so use the first one we find
		extra_data += "<b>Mineral content:</b> [mineral_string]"

		// Xenoflora and xenofauna
		var/has_flora = small_flora_types.len || big_flora_types.len
		if (!has_flora && !animals.len)
			extra_data += "No life signs detected."
		else
			if (has_flora)
				extra_data += "Plant life detected."
			if (animals.len)
				extra_data += "Animal life detected."

	// Artificial ruins
	if (LAZYLEN(spawned_features) && user_skill >= SKILL_TRAINED)
		var/ruin_num = 0
		for (var/datum/map_template/ruin/exoplanet/R in spawned_features)
			if (!(R.ruin_tags & RUIN_NATURAL))
				ruin_num++
		if (ruin_num)
			extra_data += "[ruin_num] notable structure\s detected."

	// Any data from exoplanet themes
	for (var/datum/exoplanet_theme/T in themes)
		if (T.get_sensor_data())
			extra_data += T.get_sensor_data()
	. += jointext(extra_data, "<br>")

/obj/effect/overmap/visitable/sector/exoplanet/proc/get_surface_color()
	return surface_color

/area/exoplanet
	name = "\improper Planetary surface"
	ambience = list(
		'sounds/effects/wind/wind_2_1.ogg',
		'sounds/effects/wind/wind_2_2.ogg',
		'sounds/effects/wind/wind_3_1.ogg',
		'sounds/effects/wind/wind_4_1.ogg',
		'sounds/effects/wind/wind_4_2.ogg',
		'sounds/effects/wind/wind_5_1.ogg'
	)
	always_unpowered = TRUE
	area_flags = AREA_FLAG_EXTERNAL
	planetary_surface = TRUE

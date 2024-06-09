/proc/generate_system_name()
	return "[pick("Gilese","GSC", "Luyten", "GJ", "HD", "SCGECO")][prob(10) ? " Eridani" : ""] [rand(100,999)]"

/**
 * Returns a planet name equal to (system name) (lowercase letter in order) based on the number of planetoids - for instance, "GSC 103 b" is the second planetoid in a system.
 * If too many planetoids are present to assign a letter, it'll use (random last name)-(greek letter) instead, such as "Caldwell-Theta".
 */
/proc/generate_planet_name()
	if (GLOB.number_of_planetoids > 26) // We should absolutely never have this many planetoids, but it's best to future-proof just in case
		return "[capitalize(pick(GLOB.last_names))]-[pick(GLOB.greek_letters)]"
	return "[GLOB.using_map.system_name] [ascii2text(Clamp(96 + GLOB.number_of_planetoids, 97, 122))]"

/proc/station_name()
	if(!GLOB.using_map)
		return server_name
	if (GLOB.using_map.station_name)
		return GLOB.using_map.station_name

	var/random = rand(1,5)
	var/name = ""

	//Rare: Pre-Prefix
	if (prob(10))
		name = pick(GLOB.station_prefixes)
		GLOB.using_map.station_name = name + " "

	// Prefix
	name = pick(GLOB.station_names)
	if(name)
		GLOB.using_map.station_name += name + " "

	// Suffix
	name = pick(GLOB.station_suffixes)
	GLOB.using_map.station_name += name + " "

	// ID Number
	switch(random)
		if(1)
			GLOB.using_map.station_name += "[rand(1, 99)]"
		if(2)
			GLOB.using_map.station_name += pick(GLOB.greek_letters)
		if(3)
			GLOB.using_map.station_name += "\Roman[rand(1,99)]"
		if(4)
			GLOB.using_map.station_name += pick(GLOB.phonetic_alphabet)
		if(5)
			GLOB.using_map.station_name += pick(GLOB.numbers_as_words)
		if(13)
			GLOB.using_map.station_name += pick("13","XIII","Thirteen")


	if (config && config.server_name)
		world.name = "[config.server_name]: [name]"
	else
		world.name = GLOB.using_map.station_name

	return GLOB.using_map.station_name

/proc/world_name(name)
	GLOB.using_map.station_name = name

	if (config && config.server_name)
		world.name = "[config.server_name]: [name]"
	else
		world.name = name

	return name

var/syndicate_name = null
/proc/syndicate_name()
	if (syndicate_name)
		return syndicate_name

	var/name = ""

	// Prefix
	name += pick("Clandestine", "Prima", "Blue", "Zero-G", "Max", "Blasto", "Waffle", "North", "Omni", "Newton", "Cyber", "Bonk", "Gene", "Gib")

	// Suffix
	if (prob(80))
		name += " "

		// Full
		if (prob(60))
			name += pick("Syndicate", "Consortium", "Collective", "Corporation", "Group", "Holdings", "Biotech", "Industries", "Systems", "Products", "Chemicals", "Enterprises", "Family", "Creations", "International", "Intergalactic", "Interplanetary", "Foundation", "Positronics", "Hive")
		// Broken
		else
			name += pick("Syndi", "Corp", "Bio", "System", "Prod", "Chem", "Inter", "Hive")
			name += pick("", "-")
			name += pick("Tech", "Sun", "Co", "Tek", "X", "Inc", "Code")
	// Small
	else
		name += pick("-", "*", "")
		name += pick("Tech", "Sun", "Co", "Tek", "X", "Inc", "Gen", "Star", "Dyne", "Code", "Hive")

	syndicate_name = name
	return name


//Traitors and traitor silicons will get these. Revs will not.
GLOBAL_VAR(syndicate_code_phrase) //Code phrase for traitors.
GLOBAL_VAR(syndicate_code_response) //Code response for traitors.

//Cached regex search - for checking if codewords are used.
GLOBAL_DATUM(syndicate_code_phrase_regex, /regex)
GLOBAL_DATUM(syndicate_code_response_regex, /regex)

/// This proc generates a list of 2-5 words, used for traitor phrase/response generation.
/proc/generate_codephrase_list()

	. = list() //What is returned when the proc finishes.
	var/words = pick(//How many words there will be. Minimum of two. 2, 4 and 5 have a lesser chance of being selected. 3 is the most likely.
		50; 2,
		200; 3,
		50; 4,
		25; 5
	)

	var/list/safety = list(1,2,3)//Tells the proc which options to remove later on.
	var/list/nouns = list("love","hate","anger","peace","pride","sympathy","bravery","loyalty","honesty","integrity","compassion","charity","success","courage","deceit","skill","beauty","brilliance","pain","misery","beliefs","dreams","justice","truth","faith","liberty","knowledge","thought","information","culture","trust","dedication","progress","education","hospitality","leisure","trouble","friendships", "relaxation")
	var/list/drinks = list("vodka and tonic","gin fizz","bahama mama","manhattan","black Russian","whiskey soda","long island tea","margarita","Irish coffee","manly dwarf","Irish cream","doctor's delight","Beepksy Smash","tequilla sunrise","brave bull","gargle blaster","bloody mary","whiskey cola","white Russian","vodka martini","martini","Cuba libre","kahlua","vodka","wine","moonshine")
	var/list/locations = length(stationlocs) ? stationlocs : drinks//if null, defaults to drinks instead.

	var/list/names = list()
	for(var/datum/computer_file/report/crew_record/t in GLOB.all_crew_records) //Picks from crew manifest.
		names += t.get_name()

	var/maxwords = words //Extra var to check for duplicates.

	for(words, words > 0, words--) //Randomly picks from one of the choices below.

		if(words == 1 && (1 in safety) && (2 in safety)) //If there is only one word remaining and choice 1 or 2 have not been selected.
			safety = list(pick(1,2)) //Select choice 1 or 2.
		else if(words == 1 && maxwords == 2) //Else if there is only one word remaining (and there were two originally), and 1 or 2 were chosen,
			safety = list(3) //Default to list 3

		switch(pick(safety)) //Chance based on the safety list.
			if(1) //1 and 2 can only be selected once each to prevent more than two specific names/places/etc.
				switch(rand(1, 2)) //Mainly to add more options later.
					if(1)
						if(names.len && prob(70))
							. += pick(names)
						else
							. += "[pick(pick(GLOB.first_names_male, GLOB.first_names_female))] [pick(GLOB.last_names)]"
					if(2)
						. += pick(SSjobs.titles_to_datums) //Returns a job.
				safety -= 1
			if(2)
				switch(rand(1,2))//Places or things.
					if(1)
						. += pick(drinks)
					if(2)
						. += pick(locations)
				safety -= 2
			if(3)
				switch(rand(1,3))//Nouns, adjectives, verbs. Can be selected more than once.
					if(1)
						. += pick(nouns)
					if(2)
						. += pick(GLOB.adjectives)
					if(3)
						. += pick(GLOB.verbs)

/proc/get_name(atom/A)
	return A.name

/proc/get_name_and_coordinates(atom/A)
	return "[A.name] \[[A.x],[A.y],[A.z]\]"

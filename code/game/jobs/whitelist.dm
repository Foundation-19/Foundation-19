#define WHITELISTFILE "data/whitelist.txt"

var/list/whitelist = list()

/hook/startup/proc/loadWhitelist()
	if (config.usewhitelist)
		load_whitelist()
	return 1

/proc/load_whitelist()
	if (config.sql_whitelists)
		establish_db_connection(dbcon)

		if (!dbcon.IsConnected())
			//Continue with the old code if we have no database.
			error("Database connection failed while loading whitelists. Reverting to legacy system.")
			config.sql_whitelists = 0
		else
			return

	whitelist = file2list(WHITELISTFILE)
	if (!whitelist.len)
		whitelist = null

/proc/check_whitelist(mob/M)
	if (config.sql_whitelists)
		var/head_of_staff_whitelist = 1
		if (M.client && M.client.whitelist_status)
			return (M.client.whitelist_status & head_of_staff_whitelist)

		return 0
	else
		if (!whitelist)
			return 0
		return ("[M.ckey]" in whitelist)

/var/list/alien_whitelist = list()

/hook/startup/proc/loadAlienWhitelist()
	if (config.usealienwhitelist)
		load_alienwhitelist()
	return 1

/proc/load_alienwhitelist()
	if (config.sql_whitelists)
		establish_db_connection(dbcon)

		if (!dbcon.IsConnected())
			//Continue with the old code if we have no database.
			error("Database connection failed while loading alien whitelists. Reverting to legacy system.")
			config.sql_whitelists = 0
		else
			var/DBQuery/query = dbcon.NewQuery("SELECT status_name, flag FROM ss13_whitelist_statuses")
			query.Execute()

			while (query.NextRow())
				if (query.item[1] in GLOB.whitelisted_species)
					GLOB.whitelisted_species[query.item[1]] = text2num(query.item[2])

			return

	var/text = file2text("config/alienwhitelist.txt")
	if (!text)
		log_misc("Failed to load config/alienwhitelist.txt")
	else
		alien_whitelist = text2list(text, "\n")

/proc/is_alien_whitelisted(mob/M, var/species)
	if (!config.usealienwhitelist)
		return 1

	if (!M || !species)
		return 0

	if (lowertext(species) == "human")
		return 1

	if (!alien_whitelist && !config.sql_whitelists)
		return 0

	if (config.sql_whitelists)
		if (M.client && M.client.whitelist_status)
			return (M.client.whitelist_status & GLOB.whitelisted_species[species])
	else
		if (M && species)
			for (var/s in alien_whitelist)
				if (findtext(s,"[M.ckey] - [species]"))
					return 1
				if (findtext(s,"[M.ckey] - All"))
					return 1
	return 0

/proc/whitelist_lookup(item, ckey)
	if(!alien_whitelist)
		return 0

	if(config.usealienwhitelistSQL)
		//SQL Whitelist
		if(!(ckey in alien_whitelist))
			return 0;
		var/list/whitelisted = alien_whitelist[ckey]
		if(lowertext(item) in whitelisted)
			return 1
	else
		//Config File Whitelist
		for(var/s in alien_whitelist)
			if(findtext(s,"[ckey] - [item]"))
				return 1
			if(findtext(s,"[ckey] - All"))
				return 1
	return 0

/proc/is_species_whitelisted(mob/M, species_name)
	var/datum/species/S = all_species[species_name]
	return is_alien_whitelisted(M, S)


#undef WHITELISTFILE

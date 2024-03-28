GLOBAL_LIST_EMPTY(clients)   //all clients
GLOBAL_LIST_EMPTY(admins)    //all clients whom are admins
GLOBAL_PROTECT(admins)
GLOBAL_LIST_EMPTY(ckey_directory) //all ckeys with associated client


GLOBAL_LIST_EMPTY(player_list)      //List of all mobs **with clients attached**. Excludes /mob/new_player
GLOBAL_LIST_EMPTY(human_mob_list)   //List of all human mobs and sub-types, including clientless
GLOBAL_LIST_EMPTY(silicon_mob_list) //List of all silicon mobs, including clientless
GLOBAL_LIST_EMPTY(living_mob_list_) //List of all alive mobs, including clientless. Excludes /mob/new_player
GLOBAL_LIST_EMPTY(dead_mob_list_)   //List of all dead mobs, including clientless. Excludes /mob/new_player
GLOBAL_LIST_EMPTY(ghost_mob_list)   //List of all ghosts, including clientless. Excludes /mob/new_player

GLOBAL_LIST_EMPTY(panicbunker_bypass)

GLOBAL_LIST_EMPTY(mob_config_movespeed_type_lookup)

/proc/update_config_movespeed_type_lookup(update_mobs = TRUE)
	var/list/mob_types = list()
	var/list/entry_value = 1 //CONFIG_GET(keyed_list/multiplicative_movespeed) TODO: port and implement config system
	for(var/path in entry_value)
		var/value = entry_value[path]
		if(!value)
			continue
		for(var/subpath in typesof(path))
			mob_types[subpath] = value
	GLOB.mob_config_movespeed_type_lookup = mob_types
	if(update_mobs)
		update_mob_config_movespeeds()

/proc/update_mob_config_movespeeds()
	for(var/i in GLOB.living_mob_list_)
		var/mob/M = i
		M.update_config_movespeed()

	for(var/i in GLOB.dead_mob_list_)
		var/mob/M = i
		M.update_config_movespeed()

/*
	FUN ZONE OF ADMIN LISTINGS
	Try to keep this in sync with __DEFINES/traits.dm
	quirks have it's own panel so we don't need them here.
*/
GLOBAL_LIST_INIT(traits_by_type, list(
	/mob = list(
		"TRAIT_PACIFISM" = TRAIT_PACIFISM,
		"TRAIT_CLUMSY" = TRAIT_CLUMSY,
		"TRAIT_MUTE" = TRAIT_MUTE,
		"TRAIT_ADVANCED_TOOL_USER" = TRAIT_ADVANCED_TOOL_USER,
		"TRAIT_DISCOORDINATED_TOOL_USER" = TRAIT_DISCOORDINATED_TOOL_USER,
		"TRAIT_HANDS_BLOCKED" = TRAIT_HANDS_BLOCKED,
		"TRAIT_DEAF" = TRAIT_DEAF,
		"TRAIT_CRITICAL_CONDITION" = TRAIT_CRITICAL_CONDITION,
		"TRAIT_HEAR_HEARTBEAT" = TRAIT_HEAR_HEARTBEAT,
		"TRAIT_UI_BLOCKED" = TRAIT_UI_BLOCKED
	)
))

/// value -> trait name, generated on use from trait_by_type global
GLOBAL_LIST(trait_name_map)

/proc/generate_trait_name_map()
	. = list()
	for(var/key in GLOB.traits_by_type)
		for(var/tname in GLOB.traits_by_type[key])
			var/val = GLOB.traits_by_type[key][tname]
			.[val] = tname

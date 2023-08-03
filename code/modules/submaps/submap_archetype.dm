/decl/submap_archetype
	var/map
	var/descriptor = "generic ship archetype"
	var/list/whitelisted_species = UNRESTRICTED_SPECIES
	var/list/blacklisted_species = RESTRICTED_SPECIES
	var/call_webhook
	var/list/crew_jobs = list(
		/datum/job/submap
	)

/decl/submap_archetype/Destroy()
	if(SSmapping.submap_archetypes[descriptor] == src)
		SSmapping.submap_archetypes -= descriptor
	. = ..()

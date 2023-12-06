/datum/map
	var/list/branch_types                         // list of branch datum paths for military branches available on this map
	var/list/spawn_branch_types                   // subset of above for branches a player can spawn in with

	var/list/species_to_branch_whitelist = list() // List of branches which are allowed, per species. Checked before the blacklist.
	var/list/species_to_branch_blacklist = list() // List of branches which are restricted, per species.

	var/list/species_to_rank_whitelist = list()   // List of ranks which are allowed, per branch and species. Checked before the blacklist.
	var/list/species_to_rank_blacklist = list()   // Lists of ranks which are restricted, per species.

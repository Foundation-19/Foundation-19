/datum/codex_category/species/
	name = "Species"
	desc = "Anomalous and mundane species that show signs of sapience."

/datum/codex_category/species/Initialize()
	for(var/thing in all_species)
		var/datum/species/species = all_species[thing]
		if(!species.hidden_from_codex)
			var/datum/codex_entry/entry = new(_display_name = "[species.name] (species)")
			entry.entry_text = species.description + species.ooc_codex_information
			entry.update_links()
			SScodex.add_entry_by_string(entry.display_name, entry)
			SScodex.add_entry_by_string(species.name, entry)
			items += entry.display_name
	..()

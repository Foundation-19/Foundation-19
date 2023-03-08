/datum/codex_category/reagents/
	name = "Reagents"
	desc = "Chemicals and reagents, both natural and artificial."

/datum/codex_category/reagents/Initialize()

	for(var/thing in subtypesof(/datum/reagent))
		var/datum/reagent/reagent = thing
		if(initial(reagent.hidden_from_codex))
			continue
		var/chem_name = lowertext(initial(reagent.name))
		var/datum/codex_entry/entry = new( \
		_display_name = "[chem_name] (chemical)", \
		_associated_strings = list("[chem_name] pill"), \
		_lore_text = "[initial(reagent.description)] It apparently tastes of [initial(reagent.taste_description)].", \
		_mechanics_text = "")

		switch(initial(reagent.reagent_state))
			if(SOLID)
				entry.mechanics_text += "It's a solid.</br>"
			if(LIQUID)
				entry.mechanics_text += "It's a liquid.</br>"
			if(GAS)
				entry.mechanics_text += "It's a gas.</br>"

		if(initial(reagent.color_foods))
			entry.mechanics_text += "It can be used to dye foods.</br>"

		if(initial(reagent.overdose))
			entry.mechanics_text += "This causes adverse effects if more than [initial(reagent.overdose)]u is ingested."

		if(initial(reagent.metabolism) != REM)
			entry.mechanics_text += "It metabolizes [(initial(reagent.metabolism) < REM) ? "slower" : "quicker"] than the average reagent.<br>"

		// since chilling/heating points are represented in kelvin, we need to subtract to get in celsius
		if(initial(reagent.chilling_point))
			entry.mechanics_text += "At [(initial(reagent.chilling_point) - T0C)] degrees celsius, this chills into [initial(reagent.chilling_prod_english)].<br>"

		if(initial(reagent.heating_point))
			entry.mechanics_text += "At [(initial(reagent.heating_point) - T0C)] degrees celsius, this boils into [initial(reagent.heating_prod_english)].<br>"

		var/list/production_strings = list()
		for(var/react in SSchemistry.chemical_reactions_by_result[thing])

			var/datum/chemical_reaction/reaction = react

			if(reaction.hidden_from_codex)
				continue

			var/list/reactant_values = list()
			for(var/reactant_id in reaction.required_reagents)
				var/datum/reagent/reactant = reactant_id
				reactant_values += "[reaction.required_reagents[reactant_id]]u <span codexlink='[lowertext(initial(reactant.name))] (chemical)'>[lowertext(initial(reactant.name))]</span>"

			if(!reactant_values.len)
				continue

			var/list/catalysts = list()
			for(var/catalyst_id in reaction.catalysts)
				var/datum/reagent/catalyst = catalyst_id
				catalysts += "[reaction.catalysts[catalyst_id]]u <span codexlink='[lowertext(initial(catalyst.name))] (chemical)'>[lowertext(initial(catalyst.name))]</span>"

			var/list/inhibitors = list()
			for(var/inhibitor_id in reaction.inhibitors)
				var/datum/reagent/inhibitor = inhibitor_id
				inhibitors += "[reaction.inhibitors[inhibitor_id]]u <span codexlink='[lowertext(initial(inhibitor.name))] (chemical)'>[lowertext(initial(inhibitor.name))]</span>"

			var/datum/reagent/result = reaction.result
			production_strings += "- [jointext(reactant_values, " + ")][catalysts.len ? " (catalysts: [jointext(catalysts, ", ")])" : ""]\
			[inhibitors.len ? " (inhibitors: [jointext(inhibitors, ", ")])" : ""]: [reaction.result_amount]u [lowertext(initial(result.name))]"

		if(production_strings.len)
			if(!length(entry.mechanics_text))
				entry.mechanics_text += "It can be produced as follows:<br>"
			else
				entry.mechanics_text += "<br>It can be produced as follows:<br>"
			entry.mechanics_text += jointext(production_strings, "<br>")

		entry.update_links()
		SScodex.add_entry_by_string(entry.display_name, entry)
		items += entry.display_name

	..()

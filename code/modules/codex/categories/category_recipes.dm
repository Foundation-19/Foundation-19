/datum/codex_category/recipes/
	name = "Recipes"
	desc = "Recipes for a variety of reagents."

/datum/codex_category/recipes/Initialize()
	for(var/datum/recipe/recipe in SScuisine.stove_recipes)
		if(recipe.hidden_from_codex || !recipe.result)
			continue

		var/entry_text = ""

		if(recipe.codex_desc)
			entry_text = "[recipe.codex_desc]<br><br>"

		entry_text += "This recipe requires the following ingredients:<br><ul>"
		for(var/thing in recipe.reagents)
			var/datum/reagent/thing_reagent = thing
			entry_text += "<li>[recipe.reagents[thing]]u [initial(thing_reagent.name)]</li>"
		for(var/thing in recipe.items)
			var/atom/thing_atom = thing
			entry_text += "<li>\a [initial(thing_atom.name)]</li>"
		for(var/thing in recipe.fruit)
			entry_text += "<li>[recipe.fruit[thing]] [thing]\s</li>"
		entry_text += "</ul>"

		var/atom/recipe_product = recipe.result
		entry_text += "<br>This recipe takes [ceil(recipe.time/10)] second\s to cook in a microwave and creates \a [initial(recipe_product.name)]."

		entry_text += initial(recipe_product.desc)

		var/recipe_name = recipe.display_name
		if(!recipe_name)
			recipe_name = sanitize(initial(recipe_product.name))

		var/datum/codex_entry/entry = new(                   \
		 _display_name =       "[recipe_name] (recipe)",     \
		 _associated_strings = list(lowertext(recipe_name)), \
		 _entry_text =     entry_text
		)
		entry.update_links()
		SScodex.add_entry_by_string(entry.display_name, entry)
		items += entry.display_name
	..()

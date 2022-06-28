SUBSYSTEM_DEF(cuisine)
	name = "Cuisine"
	flags = SS_NO_FIRE
	init_order = SS_INIT_MISC_LATE
	var/stove_maximum_item_storage = 0
	var/list/stove_recipes = list()
	var/list/stove_accepts_reagents = list()
	var/list/stove_accepts_items = list(
		/obj/item/holder,
		/obj/item/reagent_containers/food/snacks/grown,
		/obj/item/tray/baking
	)
	var/list/microwave_accepts_items = list(/obj/item/reagent_containers/food)

/datum/controller/subsystem/cuisine/Initialize()

	for (var/recipe_type in subtypesof(/datum/recipe))
		var/datum/recipe/recipe = new recipe_type
		stove_recipes += recipe
		for(var/thing in recipe.reagents)
			stove_accepts_reagents |= thing
		for(var/thing in recipe.items)
			stove_accepts_items |= thing
		stove_maximum_item_storage = max(stove_maximum_item_storage, length(recipe.items))
	. = ..()

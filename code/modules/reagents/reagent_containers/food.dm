////////////////////////////////////////////////////////////////////////////////
/// Food.
////////////////////////////////////////////////////////////////////////////////
/obj/item/reagent_containers/food
	randpixel = 6
	atom_flags = ATOM_FLAG_OPEN_CONTAINER
	possible_transfer_amounts = null
	volume = 50 //Sets the default container amount for all food items.
	var/filling_color = "#ffffff" //Used by sandwiches.
	var/trash = null

	/// An associative list of reagent types associated to the volume to add.
	var/list/food_reagents

/obj/item/reagent_containers/food/Initialize()
	. = ..()
	if (reagents)
		for (var/V in food_reagents)
			reagents.add_reagent(V, food_reagents[V])

/obj/item/reagent_containers/food/on_color_transfer_reagent_change()
	for(var/datum/reagent/R in reagents.reagent_list)
		if (!R.color_foods)
			continue
		color = R.color //Possible todo: Mixing of food-coloring reagents for final result?

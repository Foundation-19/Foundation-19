// Soups, e.g. primarily liquid and served hot.

/obj/item/reagent_containers/food/snacks/meatballsoup
	name = "meatball soup"
	desc = "You've got balls kid, BALLS!"
	icon_state = "meatballsoup"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#785210"
	center_of_mass = "x=16;y=8"
	bitesize = 5
	eat_sound = list('sound/items/eatfood.ogg', 'sound/items/drink.ogg')
	food_reagents = list(
		/datum/reagent/nutriment/protein = 8,
		/datum/reagent/water = 5
	)

/obj/item/reagent_containers/food/snacks/slimesoup
	name = "slime soup"
	desc = "If no water is available, you may substitute tears."
	icon_state = "slimesoup"//nonexistant?
	filling_color = "#c4dba0"
	bitesize = 5
	eat_sound = 'sound/items/drink.ogg'
	food_reagents = list(
		/datum/reagent/slime_jelly = 5,
		/datum/reagent/water = 10
	)

/obj/item/reagent_containers/food/snacks/bloodsoup
	name = "tomato soup"
	desc = "Smells like copper."
	icon_state = "tomatosoup"
	filling_color = "#ff0000"
	center_of_mass = "x=16;y=7"
	bitesize = 5
	eat_sound = 'sound/items/drink.ogg'
	food_reagents = list(
		/datum/reagent/nutriment/protein = 2,
		/datum/reagent/blood = 10,
		/datum/reagent/water = 5
	)

/obj/item/reagent_containers/food/snacks/clownstears
	name = "clown's tears"
	desc = "Not very funny."
	icon_state = "clownstears"
	filling_color = "#c4fbff"
	center_of_mass = "x=16;y=7"
	nutriment_desc = list("salt" = 1, "the worst joke" = 3)
	nutriment_amt = 4
	bitesize = 5
	eat_sound = 'sound/items/drink.ogg'
	food_reagents = list(
		/datum/reagent/drink/juice/banana = 5,
		/datum/reagent/water = 10
	)

/obj/item/reagent_containers/food/snacks/vegetablesoup
	name = "vegetable soup"
	desc = "A highly nutritious blend of vegetative goodness. Guaranteed to leave you with a, er, \"souped-up\" sense of wellbeing."
	icon_state = "vegetablesoup"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#afc4b5"
	center_of_mass = "x=16;y=8"
	nutriment_desc = list("carrot" = 2, "corn" = 2, "eggplant" = 2, "potato" = 2)
	nutriment_amt = 8
	bitesize = 5
	eat_sound = list('sound/items/eatfood.ogg', 'sound/items/drink.ogg')
	food_reagents = list(/datum/reagent/water = 5)

/obj/item/reagent_containers/food/snacks/nettlesoup
	name = "nettle soup"
	desc = "A mean, green, calorically lean dish derived from a poisonous plant. It has a rather acidic bite to its taste."
	icon_state = "nettlesoup"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#afc4b5"
	center_of_mass = "x=16;y=7"
	nutriment_desc = list("salad" = 4, "egg" = 2, "potato" = 2)
	nutriment_amt = 8
	bitesize = 5
	eat_sound = list('sound/items/eatfood.ogg', 'sound/items/drink.ogg')
	food_reagents = list(
		/datum/reagent/water = 5,
		/datum/reagent/medicine/tricordrazine = 5
	)

/obj/item/reagent_containers/food/snacks/mysterysoup
	name = "mystery soup"
	desc = "The mystery is, why aren't you eating it?"
	icon_state = "mysterysoup"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#f082ff"
	center_of_mass = "x=16;y=6"
	nutriment_desc = list("backwash" = 1)
	nutriment_amt = 1
	bitesize = 5
	eat_sound = 'sound/items/drink.ogg'

/obj/item/reagent_containers/food/snacks/mysterysoup/Initialize()
	. = ..()
	switch(rand(1,10))
		if(1)
			reagents.add_reagent(/datum/reagent/nutriment, 6)
			reagents.add_reagent(/datum/reagent/capsaicin, 3)
			reagents.add_reagent(/datum/reagent/drink/juice/tomato, 2)
		if(2)
			reagents.add_reagent(/datum/reagent/nutriment, 6)
			reagents.add_reagent(/datum/reagent/frostoil, 3)
			reagents.add_reagent(/datum/reagent/drink/juice/tomato, 2)
		if(3)
			reagents.add_reagent(/datum/reagent/nutriment, 5)
			reagents.add_reagent(/datum/reagent/water, 5)
			reagents.add_reagent(/datum/reagent/medicine/tricordrazine, 5)
		if(4)
			reagents.add_reagent(/datum/reagent/nutriment, 5)
			reagents.add_reagent(/datum/reagent/water, 10)
		if(5)
			reagents.add_reagent(/datum/reagent/nutriment, 2)
			reagents.add_reagent(/datum/reagent/drink/juice/banana, 10)
		if(6)
			reagents.add_reagent(/datum/reagent/nutriment, 6)
			reagents.add_reagent(/datum/reagent/blood, 10)
		if(7)
			reagents.add_reagent(/datum/reagent/slime_jelly, 10)
			reagents.add_reagent(/datum/reagent/water, 10)
		if(8)
			reagents.add_reagent(/datum/reagent/carbon, 10)
			reagents.add_reagent(/datum/reagent/toxin, 10)
		if(9)
			reagents.add_reagent(/datum/reagent/nutriment, 5)
			reagents.add_reagent(/datum/reagent/drink/juice/tomato, 10)
		if(10)
			reagents.add_reagent(/datum/reagent/nutriment, 6)
			reagents.add_reagent(/datum/reagent/drink/juice/tomato, 5)
			reagents.add_reagent(/datum/reagent/medicine/imidazoline, 5)

/obj/item/reagent_containers/food/snacks/wishsoup
	name = "wish soup"
	desc = "I wish this was soup."
	icon_state = "wishsoup"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#d1f4ff"
	center_of_mass = "x=16;y=11"
	bitesize = 5
	eat_sound = 'sound/items/drink.ogg'
	food_reagents = list(/datum/reagent/water = 10)

/obj/item/reagent_containers/food/snacks/wishsoup/Initialize()
	. = ..()
	if(prob(25))
		desc = "A wish come true!"
		reagents.add_reagent(/datum/reagent/nutriment, 8, list("something good" = 8))

/obj/item/reagent_containers/food/snacks/hotchili
	name = "hot chili"
	desc = "A five alarm Texan chili!"
	icon_state = "hotchili"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#ff3c00"
	center_of_mass = "x=15;y=9"
	nutriment_desc = list("chilli peppers" = 3)
	nutriment_amt = 3
	bitesize = 5
	food_reagents = list(
		/datum/reagent/nutriment/protein = 3,
		/datum/reagent/capsaicin = 3,
		/datum/reagent/drink/juice/tomato = 2
	)

/obj/item/reagent_containers/food/snacks/coldchili
	name = "cold chili"
	desc = "This slush is barely a liquid!"
	icon_state = "coldchili"
	filling_color = "#2b00ff"
	center_of_mass = "x=15;y=9"
	nutriment_desc = list("chilly peppers" = 3)
	nutriment_amt = 3
	trash = /obj/item/trash/snack_bowl
	bitesize = 5
	food_reagents = list(
		/datum/reagent/nutriment/protein = 3,
		/datum/reagent/frostoil = 3,
		/datum/reagent/drink/juice/tomato = 2
	)

/obj/item/reagent_containers/food/snacks/tomatosoup
	name = "tomato soup"
	desc = "Drinking this feels like being a vampire! A tomato vampire..."
	icon_state = "tomatosoup"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#d92929"
	center_of_mass = "x=16;y=7"
	nutriment_desc = list("soup" = 5)
	nutriment_amt = 5
	bitesize = 3
	eat_sound = 'sound/items/drink.ogg'
	food_reagents = list(/datum/reagent/drink/juice/tomato = 10)

/obj/item/reagent_containers/food/snacks/stew // stew is a soup in 33XX. blame the CL
	name = "stew"
	desc = "A nice and warm stew. Healthy and strong."
	icon_state = "stew"
	filling_color = "#9e673a"
	center_of_mass = "x=16;y=5"
	nutriment_desc = list("tomato" = 2, "potato" = 2, "carrot" = 2, "eggplant" = 2, "mushroom" = 2)
	nutriment_amt = 6
	bitesize = 10
	food_reagents = list(
		/datum/reagent/nutriment/protein = 4,
		/datum/reagent/drink/juice/tomato = 5,
		/datum/reagent/medicine/imidazoline = 5,
		/datum/reagent/water = 5
	)

/obj/item/reagent_containers/food/snacks/milosoup
	name = "milosoup"
	desc = "The universes best soup! Yum!!!"
	icon_state = "milosoup"
	trash = /obj/item/trash/snack_bowl
	center_of_mass = "x=16;y=7"
	nutriment_desc = list("soy" = 8)
	nutriment_amt = 8
	bitesize = 4
	eat_sound = 'sound/items/drink.ogg'
	food_reagents = list(/datum/reagent/water = 5)

/obj/item/reagent_containers/food/snacks/mushroomsoup
	name = "chantrelle soup"
	desc = "A delicious and hearty mushroom soup."
	icon_state = "mushroomsoup"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#e386bf"
	center_of_mass = "x=17;y=10"
	nutriment_desc = list("mushroom" = 8, "milk" = 2)
	nutriment_amt = 8
	bitesize = 3
	eat_sound = list('sound/items/eatfood.ogg', 'sound/items/drink.ogg')

/obj/item/reagent_containers/food/snacks/beetsoup
	name = "beet soup"
	desc = "Wait, how do you spell it again..?"
	icon_state = "beetsoup"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#fac9ff"
	center_of_mass = "x=15;y=8"
	nutriment_desc = list("tomato" = 4, "beet" = 4)
	nutriment_amt = 8
	bitesize = 2
	eat_sound = 'sound/items/drink.ogg'

/obj/item/reagent_containers/food/snacks/beetsoup/Initialize()
	. = ..()
	name = pick(list("borsch", "bortsch", "borstch", "borsh", "borshch", "borscht"))

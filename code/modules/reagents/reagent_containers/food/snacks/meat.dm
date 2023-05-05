// Slabs of meat, as well as products that are primarily meat.

/obj/item/reagent_containers/food/snacks/meat
	name = "meat"
	desc = "A slab of meat."
	icon = 'icons/obj/food_ingredients.dmi'
	icon_state = "meat"
	slice_path = /obj/item/reagent_containers/food/snacks/rawcutlet
	slices_num = 3
	bitesize = 3
	filling_color = "#ff1c1c"
	center_of_mass = "x=16;y=14"
	food_reagents = list(/datum/reagent/nutriment/protein = 9)
	cooks_into_type = /obj/item/reagent_containers/food/snacks/plainsteak

/obj/item/reagent_containers/food/snacks/meat/syntiflesh
	name = "synthetic meat"
	desc = "A slab of flesh synthetized from reconstituted biomass or artificially grown from chemicals."
	icon = 'icons/obj/food.dmi'

// Separate definitions because some food likes to know if it's human.
// TODO: rewrite kitchen code to check a var on the meat item so we can remove
// all these sybtypes.
/obj/item/reagent_containers/food/snacks/meat/human
/obj/item/reagent_containers/food/snacks/meat/monkey
	//same as plain meat

/obj/item/reagent_containers/food/snacks/meat/corgi
	name = "corgi meat"
	desc = "Tastes like... well, you know."

/obj/item/reagent_containers/food/snacks/meat/beef
	name = "beef slab"
	desc = "The classic red meat."

/obj/item/reagent_containers/food/snacks/meat/goat
	name = "chevon slab"
	desc = "Goat meat, to the uncultured."

/obj/item/reagent_containers/food/snacks/meat/chicken
	name = "chicken piece"
	desc = "It tastes like you'd expect."

/obj/item/reagent_containers/food/snacks/meat/chicken/game
	name = "game bird piece"
	desc = "Fresh game meat, harvested from some wild bird."

/obj/item/reagent_containers/food/snacks/fishfingers
	name = "fish fingers"
	desc = "A finger of fish."
	icon_state = "fishfingers"
	filling_color = "#ffdefe"
	center_of_mass = "x=16;y=13"
	bitesize = 3
	food_reagents = list(/datum/reagent/nutriment/protein = 4)

/obj/item/reagent_containers/food/snacks/hugemushroomslice
	name = "huge mushroom slice"
	desc = "A slice from a huge mushroom."
	icon_state = "hugemushroomslice"
	filling_color = "#e0d7c5"
	center_of_mass = "x=17;y=16"
	nutriment_amt = 3
	nutriment_desc = list("raw" = 2, "mushroom" = 2)
	bitesize = 6
	food_reagents = list(/datum/reagent/psilocybin = 3)

/obj/item/reagent_containers/food/snacks/tomatomeat
	name = "tomato slice"
	desc = "A slice from a huge tomato."
	icon_state = "tomatomeat"
	filling_color = "#db0000"
	center_of_mass = "x=17;y=16"
	nutriment_amt = 3
	nutriment_desc = list("raw" = 2, "tomato" = 3)
	bitesize = 6

/obj/item/reagent_containers/food/snacks/bearmeat
	name = "bear meat"
	desc = "A very manly slab of meat."
	icon_state = "bearmeat"
	filling_color = "#db0000"
	center_of_mass = "x=16;y=10"
	bitesize = 3
	food_reagents = list(
		/datum/reagent/nutriment/protein = 12,
		/datum/reagent/medicine/stimulant/hyperzine = 5
	)

/obj/item/reagent_containers/food/snacks/spider
	name = "giant spider leg"
	desc = "An economical replacement for crab. In space! Would probably be a lot nicer cooked."
	icon_state = "spiderleg"
	filling_color = "#d5f5dc"
	center_of_mass = "x=16;y=10"
	bitesize = 3
	food_reagents = list(/datum/reagent/nutriment/protein = 9)
	cooks_into_type = /obj/item/reagent_containers/food/snacks/spider/cooked

/obj/item/reagent_containers/food/snacks/spider/cooked
	name = "boiled spider meat"
	desc = "An economical replacement for crab. In space!"
	icon_state = "spiderleg_c"
	bitesize = 5

/obj/item/reagent_containers/food/snacks/xenomeat
	name = "meat"
	desc = "A slab of green meat. Smells like acid."
	icon_state = "xenomeat"
	filling_color = "#43de18"
	center_of_mass = "x=16;y=10"
	bitesize = 6
	food_reagents = list(
		/datum/reagent/nutriment/protein = 6,
		/datum/reagent/acid/polytrinic = 6
	)

/obj/item/reagent_containers/food/snacks/abominationmeat
	name = "meat"
	desc = "A slab of red-ish meat. Smells terribly."
	icon_state = "rottenmeat"
	filling_color = COLOR_MAROON
	center_of_mass = "x=16;y=10"
	bitesize = 5
	food_reagents = list(
		/datum/reagent/nutriment/protein = 4,
		/datum/reagent/grauel = 6
	)

/obj/item/reagent_containers/food/snacks/sausage
	name = "sausage"
	desc = "A piece of mixed, long meat."
	icon = 'icons/obj/food_ingredients.dmi'
	icon_state = "sausage"
	filling_color = "#db0000"
	center_of_mass = "x=16;y=16"
	bitesize = 2
	food_reagents = list(/datum/reagent/nutriment/protein = 6)

/obj/item/reagent_containers/food/snacks/fatsausage
	name = "fat sausage"
	desc = "A piece of mixed, long meat, with some bite to it."
	icon_state = "sausage"
	filling_color = "#db0000"
	center_of_mass = "x=16;y=16"
	bitesize = 2
	food_reagents = list(/datum/reagent/nutriment/protein = 8)

/obj/item/reagent_containers/food/snacks/wingfangchu
	name = "wing fang chu"
	desc = "A savory dish of alien wing wang in soy."
	icon_state = "wingfangchu"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#43de18"
	center_of_mass = "x=17;y=9"
	bitesize = 2
	food_reagents = list(/datum/reagent/nutriment/protein = 6)

/obj/item/reagent_containers/food/snacks/meatkabob
	name = "meat-kabob"
	icon_state = "kabob"
	desc = "Delicious meat, on a stick."
	trash = /obj/item/stack/material/rods
	filling_color = "#a85340"
	center_of_mass = "x=17;y=15"
	bitesize = 2
	food_reagents = list(/datum/reagent/nutriment/protein = 8)

/obj/item/reagent_containers/food/snacks/plainsteak
	name = "plain steak"
	desc = "A piece of unseasoned cooked meat."
	icon = 'icons/obj/food_ingredients.dmi'
	icon_state = "steak"
	slice_path = /obj/item/reagent_containers/food/snacks/cutlet
	slices_num = 3
	filling_color = "#7a3d11"
	center_of_mass = "x=16;y=13"
	bitesize = 3
	food_reagents = list(/datum/reagent/nutriment/protein = 4)

/obj/item/reagent_containers/food/snacks/meatsteak
	name = "meat steak"
	desc = "A piece of hot spicy meat."
	icon_state = "meatstake"
	trash = /obj/item/trash/plate
	filling_color = "#7a3d11"
	center_of_mass = "x=16;y=13"
	bitesize = 3
	food_reagents = list(
		/datum/reagent/nutriment/protein = 4,
		/datum/reagent/sodiumchloride = 1,
		/datum/reagent/blackpepper = 1
	)

/obj/item/reagent_containers/food/snacks/meatsteak/synthetic
	name = "meaty steak"
	desc = "A piece of hot spicy pseudo-meat."

/obj/item/reagent_containers/food/snacks/loadedsteak
	name = "loaded steak"
	desc = "A steak slathered in sauce with sauteed onions and mushrooms."
	icon_state = "meatstake"
	trash = /obj/item/trash/plate
	filling_color = "#7a3d11"
	center_of_mass = "x=16;y=13"
	nutriment_desc = list("onion" = 2, "mushroom" = 2)
	nutriment_amt = 4
	bitesize = 3
	food_reagents = list(
		/datum/reagent/nutriment/protein = 2,
		/datum/reagent/nutriment/garlicsauce = 2
	)

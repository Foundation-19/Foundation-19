// This file is specifically for non-baked candy, like chocolate and so on. Pastries should go in baked.dm.

/obj/item/reagent_containers/food/snacks/spacylibertyduff
	name = "spacy liberty duff"
	desc = "Jello gelatin, from Alfred Hubbard's cookbook."
	icon_state = "spacylibertyduff"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#42b873"
	center_of_mass = "x=16;y=8"
	nutriment_desc = list("mushroom" = 6)
	nutriment_amt = 6
	bitesize = 3
	food_reagents = list(/datum/reagent/psilocybin = 6)

/obj/item/reagent_containers/food/snacks/amanitajelly
	name = "amanita jelly"
	desc = "Looks curiously toxic."
	icon_state = "amanitajelly"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#ed0758"
	center_of_mass = "x=16;y=5"
	nutriment_desc = list("jelly" = 3, "mushroom" = 3)
	nutriment_amt = 6
	bitesize = 3
	food_reagents = list(
		/datum/reagent/toxin/amatoxin = 6,
		/datum/reagent/psilocybin = 3
	)

/obj/item/reagent_containers/food/snacks/poppypretzel
	name = "poppy pretzel"
	desc = "It's all twisted up!"
	icon_state = "poppypretzel"
	bitesize = 2
	filling_color = "#916e36"
	center_of_mass = "x=16;y=10"
	nutriment_desc = list("poppy seeds" = 2, "pretzel" = 3)
	nutriment_amt = 5
	bitesize = 2

/obj/item/reagent_containers/food/snacks/candiedapple
	name = "candied apple"
	desc = "An apple coated in sugary sweetness."
	icon_state = "candiedapple"
	filling_color = "#f21873"
	center_of_mass = "x=15;y=13"
	nutriment_desc = list("apple" = 3, "caramel" = 3, "sweetness" = 2)
	nutriment_amt = 3
	bitesize = 3

/obj/item/reagent_containers/food/snacks/mint
	name = "mint"
	desc = "A tasty after-dinner mint. It is only wafer thin."
	icon_state = "mint"
	filling_color = "#f2f2f2"
	center_of_mass = "x=16;y=14"
	bitesize = 1
	food_reagents = list(/datum/reagent/nutriment/mint = 1)

/obj/item/reagent_containers/food/snacks/appletart
	name = "golden apple streusel tart"
	desc = "A tasty dessert that won't make it through a metal detector."
	icon_state = "gappletart"
	trash = /obj/item/trash/plate
	filling_color = "#ffff00"
	center_of_mass = "x=16;y=18"
	nutriment_desc = list("apple" = 8)
	nutriment_amt = 8
	bitesize = 3
	food_reagents = list(/datum/reagent/gold = 5)

/obj/item/reagent_containers/food/snacks/candy_corn
	name = "candy corn"
	desc = "It's a handful of candy corn. Cannot be stored in a detective's hat, alas."
	icon_state = "candy_corn"
	filling_color = "#fffcb0"
	center_of_mass = "x=14;y=10"
	nutriment_amt = 4
	nutriment_desc = list("candy corn" = 4)
	bitesize = 2
	food_reagents = list(/datum/reagent/sugar = 2)

/obj/item/reagent_containers/food/snacks/cookie
	name = "cookie"
	desc = "COOKIE!!!"
	icon_state = "cookie"
	filling_color = "#dbc94f"
	center_of_mass = "x=17;y=18"
	nutriment_amt = 5
	nutriment_desc = list("sweetness" = 3, "cookie" = 2)
	w_class = ITEM_SIZE_TINY
	bitesize = 1

/obj/item/reagent_containers/food/snacks/chocolatebar
	name = "chocolate bar"
	desc = "Such sweet, fattening food."
	icon_state = "chocolatebar"
	filling_color = "#7d5f46"
	center_of_mass = "x=15;y=15"
	nutriment_amt = 2
	nutriment_desc = list("chocolate" = 5)
	bitesize = 2
	food_reagents = list(
		/datum/reagent/sugar = 2,
		/datum/reagent/nutriment/coco = 2
	)

/obj/item/reagent_containers/food/snacks/chocolateegg
	name = "chocolate egg"
	desc = "Such sweet, fattening food."
	icon_state = "chocolateegg"
	filling_color = "#7d5f46"
	center_of_mass = "x=16;y=13"
	nutriment_amt = 3
	nutriment_desc = list("chocolate" = 5)
	bitesize = 2
	food_reagents = list(
		/datum/reagent/sugar = 2,
		/datum/reagent/nutriment/coco = 2
	)

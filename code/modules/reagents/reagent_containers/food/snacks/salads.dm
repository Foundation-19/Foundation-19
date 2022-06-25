// Salads.

/obj/item/reagent_containers/food/snacks/aesirsalad
	name = "aesir salad"
	desc = "Probably too incredible for mortal men to fully enjoy."
	icon_state = "aesirsalad"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#468c00"
	center_of_mass = "x=17;y=11"
	nutriment_amt = 8
	nutriment_desc = list("apples" = 3,"salad" = 5)
	bitesize = 3
	food_reagents = list(
		/datum/reagent/drink/doctor_delight = 8,
		/datum/reagent/medicine/tricordrazine = 8
	)


/obj/item/reagent_containers/food/snacks/tossedsalad
	name = "tossed salad"
	desc = "A proper salad, basic and simple, with little bits of carrot, tomato and apple intermingled. Vegan!"
	icon_state = "herbsalad"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#76b87f"
	center_of_mass = "x=17;y=11"
	nutriment_desc = list("salad" = 2, "tomato" = 2, "carrot" = 2, "apple" = 2)
	nutriment_amt = 8
	bitesize = 3

/obj/item/reagent_containers/food/snacks/validsalad
	name = "valid salad"
	desc = "It's just a salad of questionable 'herbs' with meatballs and fried potato slices. Nothing suspicious about it."
	icon_state = "validsalad"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#76b87f"
	center_of_mass = "x=17;y=11"
	nutriment_desc = list("100% real salad")
	nutriment_amt = 6
	bitesize = 3
	food_reagents = list(/datum/reagent/nutriment/protein = 2)

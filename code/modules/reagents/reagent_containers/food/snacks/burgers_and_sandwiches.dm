// Burgers, sandwiches, and anything that might resemble them. Any of the three top left-most values on the sandwich alignment chart can help you with this.

/////////////
// BURGERS //
/////////////

/obj/item/reagent_containers/food/snacks/brainburger
	name = "brainburger"
	desc = "A strange looking burger. It looks almost sentient."
	icon_state = "brainburger"
	filling_color = "#f2b6ea"
	center_of_mass = "x=15;y=11"
	bitesize = 2
	food_reagents = list(
		/datum/reagent/nutriment/protein = 6,
		/datum/reagent/medicine/alkysine = 6
	)

/obj/item/reagent_containers/food/snacks/ghostburger
	name = "ghost burger"
	desc = "Spooky! It doesn't look very filling."
	icon_state = "ghostburger"
	filling_color = "#fff2ff"
	center_of_mass = "x=16;y=11"
	nutriment_desc = list("buns" = 3, "spookiness" = 3)
	nutriment_amt = 2
	bitesize = 2

/obj/item/reagent_containers/food/snacks/human
	var/hname = ""
	var/job = null
	filling_color = "#d63c3c"

/obj/item/reagent_containers/food/snacks/human/burger
	name = "-burger"
	desc = "A bloody burger."
	icon_state = "hburger"
	center_of_mass = "x=16;y=11"
	bitesize = 2
	food_reagents = list(/datum/reagent/nutriment/protein = 6)

/obj/item/reagent_containers/food/snacks/cheeseburger
	name = "cheeseburger"
	desc = "The cheese adds a good flavor."
	icon_state = "cheeseburger"
	center_of_mass = "x=16;y=11"
	nutriment_desc = list("cheese" = 2, "bun" = 2)
	nutriment_amt = 2
	food_reagents = list(/datum/reagent/nutriment/protein = 2)

/obj/item/reagent_containers/food/snacks/meatburger
	name = "burger"
	desc = "The cornerstone of every nutritious breakfast."
	icon_state = "hburger"
	filling_color = "#d63c3c"
	center_of_mass = "x=16;y=11"
	nutriment_desc = list("bun" = 2)
	nutriment_amt = 3
	bitesize = 2
	food_reagents = list(/datum/reagent/nutriment/protein = 3)

/obj/item/reagent_containers/food/snacks/plainburger
	name = "burger"
	desc = "The cornerstone of every nutritious breakfast."
	icon = 'icons/obj/food_ingredients.dmi'
	icon_state = "burger"
	filling_color = "#d63c3c"
	center_of_mass = "x=16;y=11"
	nutriment_desc = list("bun" = 2)
	nutriment_amt = 3
	bitesize = 2
	food_reagents = list(/datum/reagent/nutriment/protein = 3)

/obj/item/reagent_containers/food/snacks/hamburger
	name = "hamburger"
	desc = "The cornerstone of every nutritious breakfast, now with ham!"
	icon = 'icons/obj/food_ingredients.dmi'
	icon_state = "hamburger"
	filling_color = "#d63c3c"
	center_of_mass = "x=16;y=11"
	nutriment_desc = list("bun" = 2)
	nutriment_amt = 3
	bitesize = 2
	food_reagents = list(/datum/reagent/nutriment/protein = 5)

/obj/item/reagent_containers/food/snacks/fishburger
	name = "fish sandwich"
	desc = "Almost like a carp is yelling somewhere... Give me back that fillet -o- carp, give me that carp."
	icon_state = "fishburger"
	filling_color = "#ffdefe"
	center_of_mass = "x=16;y=10"
	bitesize = 3
	food_reagents = list(/datum/reagent/nutriment/protein = 6)

/obj/item/reagent_containers/food/snacks/tofuburger
	name = "tofu burger"
	desc = "What.. is that meat?"
	icon_state = "tofuburger"
	filling_color = "#fffee0"
	center_of_mass = "x=16;y=10"
	nutriment_desc = list("bun" = 2, "pseudo-soy meat" = 3)
	nutriment_amt = 6
	bitesize = 2

/obj/item/reagent_containers/food/snacks/roburger
	name = "roburger"
	desc = "The lettuce is the only organic component. Beep."
	icon_state = "roburger"
	filling_color = COLOR_GRAY80
	center_of_mass = "x=16;y=11"
	nutriment_desc = list("bun" = 2, "metal" = 3)
	nutriment_amt = 2
	bitesize = 2
	food_reagents = list(/datum/reagent/iron = 3)


/obj/item/reagent_containers/food/snacks/roburgerbig
	name = "roburger"
	desc = "This massive patty looks like poison. Beep."
	icon_state = "roburger"
	filling_color = COLOR_GRAY80
	volume = 100
	center_of_mass = "x=16;y=11"
	bitesize = 0.1
	food_reagents = list(/datum/reagent/iron = 20)

/obj/item/reagent_containers/food/snacks/xenoburger
	name = "xenoburger"
	desc = "Smells caustic. Tastes like heresy."
	icon_state = "xburger"
	filling_color = "#43de18"
	center_of_mass = "x=16;y=11"
	bitesize = 2
	food_reagents = list(/datum/reagent/nutriment/protein = 8)

/obj/item/reagent_containers/food/snacks/clownburger
	name = "clown burger"
	desc = "This tastes funny..."
	icon_state = "clownburger"
	filling_color = "#ff00ff"
	center_of_mass = "x=17;y=12"
	nutriment_desc = list("bun" = 2, "clown shoe" = 3)
	nutriment_amt = 6
	bitesize = 2

/obj/item/reagent_containers/food/snacks/mimeburger
	name = "mime burger"
	desc = "Its taste defies language."
	icon_state = "mimeburger"
	filling_color = "#ffffff"
	center_of_mass = "x=16;y=11"
	nutriment_desc = list("bun" = 2, "mime paint" = 3)
	nutriment_amt = 6
	bitesize = 2

/obj/item/reagent_containers/food/snacks/spellburger
	name = "spell burger"
	desc = "This is absolutely Ei Nath."
	icon_state = "spellburger"
	filling_color = "#d505ff"
	nutriment_desc = list("magic" = 3, "buns" = 3)
	nutriment_amt = 6
	bitesize = 2

/obj/item/reagent_containers/food/snacks/bigbiteburger
	name = "big bite burger"
	desc = "Forget the Luna Burger! THIS is the future!"
	icon_state = "bigbiteburger"
	filling_color = "#e3d681"
	center_of_mass = "x=16;y=11"
	nutriment_desc = list("buns" = 4)
	nutriment_amt = 4
	bitesize = 3
	food_reagents = list(/datum/reagent/nutriment/protein = 10)

/obj/item/reagent_containers/food/snacks/jellyburger
	name = "jelly burger"
	desc = "Culinary delight..?"
	icon_state = "jellyburger"
	filling_color = "#b572ab"
	center_of_mass = "x=16;y=11"
	nutriment_desc = list("buns" = 5)
	nutriment_amt = 5
	bitesize = 2

/obj/item/reagent_containers/food/snacks/jellyburger/cherry
	food_reagents = list(/datum/reagent/nutriment/cherryjelly = 5)

/obj/item/reagent_containers/food/snacks/jellyburger/slime
	food_reagents = list(/datum/reagent/slime_jelly = 5)

/obj/item/reagent_containers/food/snacks/superbiteburger
	name = "super bite burger"
	desc = "This is a mountain of a burger. FOOD!"
	icon_state = "superbiteburger"
	filling_color = "#cca26a"
	center_of_mass = "x=16;y=3"
	nutriment_desc = list("buns" = 25)
	nutriment_amt = 25
	bitesize = 10
	food_reagents = list(/datum/reagent/nutriment/protein = 25)

////////////////
// SANDWICHES //
////////////////

/obj/item/reagent_containers/food/snacks/sandwich
	name = "sandwich"
	desc = "A grand creation of meat, cheese, bread, and several leaves of lettuce! Arthur Dent would be proud."
	icon_state = "sandwich"
	trash = /obj/item/trash/plate
	filling_color = "#d9be29"
	center_of_mass = "x=16;y=4"
	nutriment_desc = list("bread" = 3, "cheese" = 3)
	nutriment_amt = 3
	bitesize = 2
	food_reagents = list(/datum/reagent/nutriment/protein = 3)

/obj/item/reagent_containers/food/snacks/toastedsandwich
	name = "toasted sandwich"
	desc = "Now if you only had a pepper bar."
	icon_state = "toastedsandwich"
	trash = /obj/item/trash/plate
	filling_color = "#d9be29"
	center_of_mass = "x=16;y=4"
	nutriment_desc = list("toasted bread" = 3, "cheese" = 3)
	nutriment_amt = 3
	bitesize = 2
	food_reagents = list(
		/datum/reagent/nutriment/protein = 3,
		/datum/reagent/carbon = 3
	)

/obj/item/reagent_containers/food/snacks/grilledcheese
	name = "grilled cheese sandwich"
	desc = "Goes great with Tomato soup!"
	icon_state = "toastedsandwich"
	trash = /obj/item/trash/plate
	filling_color = "#d9be29"
	nutriment_desc = list("toasted bread" = 3, "cheese" = 3)
	nutriment_amt = 3
	bitesize = 2
	food_reagents = list(/datum/reagent/nutriment/protein = 4)

/obj/item/reagent_containers/food/snacks/cubancarp
	name = "cuban carp"
	desc = "A sandwich that burns your tongue and then leaves it numb!"
	icon_state = "cubancarp"
	trash = /obj/item/trash/plate
	filling_color = "#e9adff"
	center_of_mass = "x=12;y=5"
	nutriment_desc = list("toasted bread" = 3)
	nutriment_amt = 3
	bitesize = 3
	food_reagents = list(
		/datum/reagent/nutriment/protein = 3,
		/datum/reagent/capsaicin = 3
	)

/obj/item/reagent_containers/food/snacks/jellysandwich
	name = "jelly sandwich"
	desc = "You wish you had some peanut butter to go with this..."
	icon_state = "jellysandwich"
	trash = /obj/item/trash/plate
	filling_color = "#9e3a78"
	center_of_mass = "x=16;y=8"
	nutriment_desc = list("bread" = 2)
	nutriment_amt = 2
	bitesize = 3

/obj/item/reagent_containers/food/snacks/jellysandwich/cherry
	food_reagents = list(/datum/reagent/nutriment/cherryjelly = 5)

/obj/item/reagent_containers/food/snacks/jellysandwich/slime
	food_reagents = list(/datum/reagent/slime_jelly = 5)

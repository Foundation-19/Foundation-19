// Canned foods come in a metal can that need to be opened before eating.

/obj/item/reagent_containers/food/snacks/canned
	name = "void can"
	icon = 'icons/obj/food_canned.dmi'
	atom_flags = 0
	var/sealed = TRUE

/obj/item/reagent_containers/food/snacks/canned/Initialize()
	. = ..()
	if(!sealed)
		unseal()

/obj/item/reagent_containers/food/snacks/canned/examine(mob/user)
	. = ..()
	to_chat(user, "It is [sealed ? "" : "un"]sealed.")

/obj/item/reagent_containers/food/snacks/canned/proc/unseal()
	atom_flags |= ATOM_FLAG_OPEN_CONTAINER
	sealed = FALSE
	update_icon()

/obj/item/reagent_containers/food/snacks/canned/attack_self(mob/user)
	if(sealed)
		playsound(loc,'sound/effects/canopen.ogg', rand(10,50), 1)
		to_chat(user, SPAN_NOTICE("You unseal \the [src] with a crack of metal."))
		unseal()

/obj/item/reagent_containers/food/snacks/canned/on_update_icon()
	if(!sealed)
		icon_state = "[initial(icon_state)]-open"

//Just a short line of Canned Consumables, great for treasure in faraway abandoned outposts

/obj/item/reagent_containers/food/snacks/canned/beef
	name = "quadrangled beefium"
	icon_state = "beef"
	desc = "Proteins carefully cloned from extinct stock of holstein in the meat foundries of Mars."
	trash = /obj/item/trash/beef
	filling_color = "#663300"
	center_of_mass = "x=15;y=9"
	nutriment_desc = list("beef" = 1)
	bitesize = 3
	food_reagents = list(/datum/reagent/nutriment/protein = 12)

/obj/item/reagent_containers/food/snacks/canned/beans
	name = "baked beans"
	icon_state = "beans"
	desc = "Luna Colony beans. Carefully synthethized from soy."
	trash = /obj/item/trash/beans
	filling_color = "#ff6633"
	center_of_mass = "x=15;y=9"
	nutriment_desc = list("beans" = 1)
	nutriment_amt = 12
	bitesize = 3

/obj/item/reagent_containers/food/snacks/canned/tomato
	name = "tomato soup"
	icon_state = "tomato"
	desc = "Plain old unseasoned tomato soup. This can predates the formation of the SCG."
	trash = /obj/item/trash/tomato
	filling_color = "#ae0000"
	center_of_mass = "x=15;y=9"
	nutriment_desc = list("tomato" = 1)
	bitesize = 3
	eat_sound = 'sound/items/drink.ogg'
	food_reagents = list(/datum/reagent/drink/juice/tomato = 12)


/obj/item/reagent_containers/food/snacks/canned/tomato/feed_sound(mob/user)
	playsound(user.loc, 'sound/items/drink.ogg', rand(10, 50), 1)

/obj/item/reagent_containers/food/snacks/canned/spinach
	name = "spinach"
	icon_state = "spinach"
	desc = "Wup-Az! Brand canned spinach. Notably has less iron in it than a watermelon."
	trash = /obj/item/trash/spinach
	filling_color = "#003300"
	center_of_mass = "x=15;y=9"
	nutriment_amt = 5
	nutriment_desc = list("soggy" = 1, "vegetable" = 1)
	bitesize = 20
	food_reagents = list(
		/datum/reagent/medicine/adrenaline = 5,
		/datum/reagent/medicine/stimulant/hyperzine = 5,
		/datum/reagent/iron = 5
	)

//Vending Machine Foods should go here.

/obj/item/reagent_containers/food/snacks/canned/caviar
	name = "caviar"
	icon_state = "fisheggs"
	desc = "Terran caviar, or space carp eggs. Carefully faked using alginate, artificial flavoring and salt. Skrell approved!"
	trash = /obj/item/trash/fishegg
	filling_color = "#000000"
	center_of_mass = "x=15;y=9"
	nutriment_desc = list("fish" = 1, "salt" = 1)
	nutriment_amt = 6
	bitesize = 1

/obj/item/reagent_containers/food/snacks/canned/caviar/true
	name = "caviar"
	icon_state = "carpeggs"
	desc = "Terran caviar, or space carp eggs. Banned by the Sol Food Health Administration for exceeding the legally set amount of carpotoxins in foodstuffs."
	trash = /obj/item/trash/carpegg
	filling_color = "#330066"
	center_of_mass = "x=15;y=9"
	nutriment_desc = list("fish" = 1, "salt" = 1, "numbing sensation" = 1)
	nutriment_amt = 6
	bitesize = 1
	food_reagents = list(
		/datum/reagent/nutriment/protein = 4,
		/datum/reagent/toxin/carpotoxin = 1
	)

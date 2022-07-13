// This file is for eggs, cutlets, dough, etc - foods that are primarily used to make other dishes.

/obj/item/reagent_containers/food/snacks/egg
	name = "egg"
	desc = "An egg!"
	icon_state = "egg"
	filling_color = "#fdffd1"
	volume = 10
	center_of_mass = "x=16;y=13"
	food_reagents = list(/datum/reagent/nutriment/protein/egg = 3)

/obj/item/reagent_containers/food/snacks/egg/afterattack(obj/O, mob/user, proximity)
	if (istype(O, /obj/machinery/stove))
		return ..()
	if (!(proximity && O.is_open_container()))
		return
	to_chat(user, "You crack \the [src] into \the [O].")
	reagents.trans_to(O, reagents.total_volume)
	qdel(src)

/obj/item/reagent_containers/food/snacks/egg/throw_impact(atom/hit_atom)
	if(QDELETED(src))
		return // Could potentially happen with unscupulous atoms on hitby() throwing again, etc.
	new/obj/effect/decal/cleanable/egg_smudge(src.loc)
	reagents.splash(hit_atom, reagents.total_volume)
	visible_message("<span class='warning'>\The [src] has been squashed!</span>","<span class='warning'>You hear a smack.</span>")
	..()
	qdel(src)

/obj/item/reagent_containers/food/snacks/egg/attackby(obj/item/W, mob/user)
	if(istype( W, /obj/item/pen/crayon ))
		var/obj/item/pen/crayon/C = W
		var/clr = C.colourName

		if(!(clr in list("blue","green","mime","orange","purple","rainbow","red","yellow")))
			to_chat(usr, "<span class='notice'>The egg refuses to take on this color!</span>")
			return

		to_chat(usr, "<span class='notice'>You color \the [src] [clr]</span>")
		icon_state = "egg-[clr]"
	else
		..()

/obj/item/reagent_containers/food/snacks/egg/blue
	icon_state = "egg-blue"

/obj/item/reagent_containers/food/snacks/egg/green
	icon_state = "egg-green"

/obj/item/reagent_containers/food/snacks/egg/mime
	icon_state = "egg-mime"

/obj/item/reagent_containers/food/snacks/egg/orange
	icon_state = "egg-orange"

/obj/item/reagent_containers/food/snacks/egg/purple
	icon_state = "egg-purple"

/obj/item/reagent_containers/food/snacks/egg/rainbow
	icon_state = "egg-rainbow"

/obj/item/reagent_containers/food/snacks/egg/red
	icon_state = "egg-red"

/obj/item/reagent_containers/food/snacks/egg/yellow
	icon_state = "egg-yellow"

/obj/item/reagent_containers/food/snacks/egg/lizard
	name = "unathi egg"
	desc = "A large, slightly elongated egg with a thick shell."
	icon_state = "lizard_egg"
	w_class = ITEM_SIZE_SMALL
	food_reagents = list(/datum/reagent/nutriment/protein/egg = 3)

/obj/item/reagent_containers/food/snacks/egg/lizard/Initialize()
	. = ..()
	if (prob(30))	//extra protein
		reagents.add_reagent(/datum/reagent/nutriment/protein, 5)

/obj/item/reagent_containers/food/snacks/tofu
	name = "tofu"
	icon_state = "tofu"
	desc = "We all love tofu."
	filling_color = "#fffee0"
	center_of_mass = "x=17;y=10"
	nutriment_desc = list("tofu" = 3, "goeyness" = 3)
	bitesize = 3
	food_reagents = list(/datum/reagent/nutriment/softtofu = 6)

/obj/item/reagent_containers/food/snacks/rawcutlet
	name = "raw cutlet"
	desc = "A thin piece of raw meat."
	icon = 'icons/obj/food_ingredients.dmi'
	icon_state = "rawcutlet"
	bitesize = 1
	center_of_mass = "x=17;y=20"
	cooks_into_type = /obj/item/reagent_containers/food/snacks/cutlet

/obj/item/reagent_containers/food/snacks/cutlet
	name = "cutlet"
	desc = "A tasty meat slice."
	icon = 'icons/obj/food_ingredients.dmi'
	icon_state = "cutlet"
	bitesize = 2
	center_of_mass = "x=17;y=20"

/obj/item/reagent_containers/food/snacks/rawmeatball
	name = "raw meatball"
	desc = "A raw meatball."
	icon = 'icons/obj/food_ingredients.dmi'
	icon_state = "rawmeatball"
	bitesize = 2
	center_of_mass = "x=16;y=15"
	cooks_into_type = /obj/item/reagent_containers/food/snacks/meatball

/obj/item/reagent_containers/food/snacks/meatball
	name = "meatball"
	desc = "A great meal all round."
	icon_state = "meatball"
	filling_color = "#db0000"
	center_of_mass = "x=16;y=16"
	bitesize = 2
	food_reagents = list(/datum/reagent/nutriment/protein = 3)

/obj/item/reagent_containers/food/snacks/dough
	name = "dough"
	desc = "A piece of dough."
	icon = 'icons/obj/food_ingredients.dmi'
	icon_state = "dough"
	bitesize = 2
	center_of_mass = "x=16;y=13"
	nutriment_desc = list("dough" = 3)
	nutriment_amt = 3
	cooks_into_type = /obj/item/reagent_containers/food/snacks/bun

//obj/item/reagent_containers/food/snacks/dough/Initialize()
//	. = ..()
//	reagents.add_reagent(/datum/reagent/nutriment/protein, 1)

// Dough + rolling pin = flat dough
/obj/item/reagent_containers/food/snacks/dough/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/material/kitchen/rollingpin))
		new /obj/item/reagent_containers/food/snacks/sliceable/flatdough(src)
		to_chat(user, "You flatten the dough.")
		qdel(src)

// slicable into 3x doughslices
/obj/item/reagent_containers/food/snacks/sliceable/flatdough
	name = "flat dough"
	desc = "A flattened dough."
	icon = 'icons/obj/food_ingredients.dmi'
	icon_state = "flat dough"
	nutriment_amt = 3
	slice_path = /obj/item/reagent_containers/food/snacks/doughslice
	slices_num = 3
	center_of_mass = "x=16;y=16"

/obj/item/reagent_containers/food/snacks/doughslice
	name = "dough slice"
	desc = "A building block of an impressive dish."
	icon = 'icons/obj/food_ingredients.dmi'
	icon_state = "doughslice"
	slice_path = /obj/item/reagent_containers/food/snacks/spagetti
	slices_num = 1
	bitesize = 2
	center_of_mass = "x=17;y=19"
	nutriment_desc = list("dough" = 1)
	nutriment_amt = 1

/obj/item/reagent_containers/food/snacks/bun
	name = "bun"
	desc = "A base for any self-respecting burger."
	icon = 'icons/obj/food_ingredients.dmi'
	icon_state = "bun"
	bitesize = 2
	center_of_mass = "x=16;y=12"
	nutriment_desc = list("bun" = 4)
	nutriment_amt = 4

/obj/item/reagent_containers/food/snacks/sliceable/cheesewheel
	name = "cheese wheel"
	desc = "A big wheel of delcious cheddar."
	icon_state = "cheesewheel"
	slice_path = /obj/item/reagent_containers/food/snacks/cheesewedge
	slices_num = 5
	filling_color = "#fff700"
	center_of_mass = "x=16;y=10"
	nutriment_desc = list("cheese" = 10)
	nutriment_amt = 10
	bitesize = 2
	food_reagents = list(/datum/reagent/nutriment/protein = 10)

/obj/item/reagent_containers/food/snacks/cheesewedge
	name = "cheese wedge"
	desc = "A wedge of delicious cheddar. The cheese wheel it was cut from can't have gone far."
	icon_state = "cheesewedge"
	filling_color = "#fff700"
	bitesize = 2
	center_of_mass = "x=16;y=10"

//Items you can craft together. Like bomb making, but with food and less screwdrivers.

/obj/item/reagent_containers/food/snacks/bun/attackby(obj/item/W as obj, mob/user as mob)
	// bun + meatball = burger
	if(istype(W,/obj/item/reagent_containers/food/snacks/meatball))
		new /obj/item/reagent_containers/food/snacks/plainburger(src)
		to_chat(user, "You make a burger.")
		qdel(W)
		qdel(src)

	// bun + cutlet = hamburger
	else if(istype(W,/obj/item/reagent_containers/food/snacks/cutlet))
		new /obj/item/reagent_containers/food/snacks/hamburger(src)
		to_chat(user, "You make a hamburger.")
		qdel(W)
		qdel(src)

	// bun + sausage = hotdog
	else if(istype(W,/obj/item/reagent_containers/food/snacks/sausage))
		new /obj/item/reagent_containers/food/snacks/hotdog(src)
		to_chat(user, "You make a hotdog.")
		qdel(W)
		qdel(src)

// burger + cheese wedge = cheeseburger
/obj/item/reagent_containers/food/snacks/plainburger/attackby(obj/item/reagent_containers/food/snacks/cheesewedge/W as obj, mob/user as mob)
	if(istype(W))// && !istype(src,/obj/item/reagent_containers/food/snacks/cheesewedge))
		new /obj/item/reagent_containers/food/snacks/cheeseburger(src)
		to_chat(user, "You make a cheeseburger.")
		qdel(W)
		qdel(src)
		return
	else
		..()

// Hamburger + cheese wedge = cheeseburger
/obj/item/reagent_containers/food/snacks/hamburger/attackby(obj/item/reagent_containers/food/snacks/cheesewedge/W as obj, mob/user as mob)
	if(istype(W))// && !istype(src,/obj/item/reagent_containers/food/snacks/cheesewedge))
		new /obj/item/reagent_containers/food/snacks/cheeseburger(src)
		to_chat(user, "You make a cheeseburger.")
		qdel(W)
		qdel(src)
		return
	else
		..()

// Human burger + cheese wedge = cheeseburger
/obj/item/reagent_containers/food/snacks/human/burger/attackby(obj/item/reagent_containers/food/snacks/cheesewedge/W as obj, mob/user as mob)
	if(istype(W))
		new /obj/item/reagent_containers/food/snacks/cheeseburger(src)
		to_chat(user, "You make a cheeseburger.")
		qdel(W)
		qdel(src)
		return
	else
		..()

// Spaghetti + meatball = spaghetti with meatball(s)
/obj/item/reagent_containers/food/snacks/boiledspagetti/attackby(obj/item/reagent_containers/food/snacks/meatball/W as obj, mob/user as mob)
	if(istype(W))
		new /obj/item/reagent_containers/food/snacks/meatballspagetti(src)
		to_chat(user, "You add some meatballs to the spaghetti.")
		qdel(W)
		qdel(src)
		return
	else
		..()

// Spaghetti with meatballs + meatball = spaghetti with more meatball(s)
/obj/item/reagent_containers/food/snacks/meatballspagetti/attackby(obj/item/reagent_containers/food/snacks/meatball/W as obj, mob/user as mob)
	if(istype(W))
		new /obj/item/reagent_containers/food/snacks/spesslaw(src)
		to_chat(user, "You add some more meatballs to the spaghetti.")
		qdel(W)
		qdel(src)
		return
	else
		..()

// Spaghetti + tomato = tomato'd spaghetti //commented out because I don't know how to define a tomato.
//obj/item/reagent_containers/food/snacks/spagetti/attackby(/obj/item/reagent_containers/food/snacks/grown/tomato/W as obj, mob/user as mob)
//	if(istype(W))
//		new /obj/item/reagent_containers/food/snacks/pastatomato(src)
//		to_chat(user, "You add some more meatballs to the spaghetti.")
//		qdel(W)
//		qdel(src)
//		return
//	else
//		..()

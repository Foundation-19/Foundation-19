#define ICECREAM_VANILLA 1
#define ICECREAM_CHOCOLATE 2
#define ICECREAM_STRAWBERRY 3
#define ICECREAM_BLUE 4
#define ICECREAM_CHERRY 5
#define ICECREAM_BANANA 6
#define CONE_WAFFLE 7
#define CONE_CHOC 8

// Ported wholesale from Apollo Station.

/obj/machinery/icecream_vat
	name = "icecream vat"
	desc = "A heavy metal container used to produce and store ice cream."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "icecream_vat"
	density = TRUE
	anchored = FALSE
	atom_flags = ATOM_FLAG_NO_TEMP_CHANGE | ATOM_FLAG_NO_REACT | ATOM_FLAG_OPEN_CONTAINER

	var/list/product_types = list()
	var/dispense_flavour = ICECREAM_VANILLA
	var/flavour_name = "vanilla"
	var/canmake = 1

/obj/machinery/icecream_vat/proc/get_ingredient_list(type)
	switch(type)
		if(ICECREAM_CHOCOLATE)
			return list(/datum/reagent/drink/milk, /datum/reagent/drink/ice, /datum/reagent/nutriment/coco)
		if(ICECREAM_STRAWBERRY)
			return list(/datum/reagent/drink/milk, /datum/reagent/drink/ice, /datum/reagent/drink/juice/berry)
		if(ICECREAM_BLUE)
			return list(/datum/reagent/drink/milk, /datum/reagent/drink/ice, /datum/reagent/ethanol/singulo)
		if(ICECREAM_CHERRY)
			return list(/datum/reagent/drink/milk, /datum/reagent/drink/ice, /datum/reagent/nutriment/cherryjelly)
		if(ICECREAM_BANANA)
			return list(/datum/reagent/drink/milk, /datum/reagent/drink/ice, /datum/reagent/drink/juice/banana)
		if(CONE_WAFFLE)
			return list(/datum/reagent/nutriment/flour, /datum/reagent/sugar)
		if(CONE_CHOC)
			return list(/datum/reagent/nutriment/flour, /datum/reagent/sugar, /datum/reagent/nutriment/coco)
		else
			return list(/datum/reagent/drink/milk, /datum/reagent/drink/ice)

/obj/machinery/icecream_vat/proc/get_flavour_name(flavour_type)
	switch(flavour_type)
		if(ICECREAM_CHOCOLATE)
			return "chocolate"
		if(ICECREAM_STRAWBERRY)
			return "strawberry"
		if(ICECREAM_BLUE)
			return "blue"
		if(ICECREAM_CHERRY)
			return "cherry"
		if(ICECREAM_BANANA)
			return "banana"
		if(CONE_WAFFLE)
			return "waffle"
		if(CONE_CHOC)
			return "chocolate"
		else
			return "vanilla"

/obj/machinery/icecream_vat/Initialize()
	. = ..()
	create_reagents(100)
	while(product_types.len < 8)
		product_types.Add(5)
	reagents.add_reagent(/datum/reagent/drink/milk, 5)
	reagents.add_reagent(/datum/reagent/nutriment/flour, 5)
	reagents.add_reagent(/datum/reagent/sugar, 5)
	reagents.add_reagent(/datum/reagent/drink/ice, 5)

/obj/machinery/icecream_vat/interface_interact(mob/user)
	tgui_interact(user)
	return TRUE

/obj/machinery/icecream_vat/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "IcecreamVat", "Icecream Vat")
		ui.open()

/obj/machinery/icecream_vat/tgui_data(mob/user)
	var/list/data = list()
	data["dispensing"] = flavour_name
	data["products"] = list(
		list("id" = ICECREAM_VANILLA, "name" = "Vanilla icecream", "count" = product_types[ICECREAM_VANILLA], "unit" = "scoops", "ingredients" = "milk, ice", "is_cone" = FALSE),
		list("id" = ICECREAM_STRAWBERRY, "name" = "Strawberry icecream", "count" = product_types[ICECREAM_STRAWBERRY], "unit" = "dollops", "ingredients" = "milk, ice, berry juice", "is_cone" = FALSE),
		list("id" = ICECREAM_CHOCOLATE, "name" = "Chocolate icecream", "count" = product_types[ICECREAM_CHOCOLATE], "unit" = "dollops", "ingredients" = "milk, ice, coco powder", "is_cone" = FALSE),
		list("id" = ICECREAM_BLUE, "name" = "Blue icecream", "count" = product_types[ICECREAM_BLUE], "unit" = "dollops", "ingredients" = "milk, ice, singulo", "is_cone" = FALSE),
		list("id" = ICECREAM_CHERRY, "name" = "Cherry icecream", "count" = product_types[ICECREAM_CHERRY], "unit" = "dollops", "ingredients" = "milk, ice, cherry jelly", "is_cone" = FALSE),
		list("id" = ICECREAM_BANANA, "name" = "Banana icecream", "count" = product_types[ICECREAM_BANANA], "unit" = "dollops", "ingredients" = "milk, ice, banana", "is_cone" = FALSE),
		list("id" = CONE_WAFFLE, "name" = "Waffle cones", "count" = product_types[CONE_WAFFLE], "unit" = "cones", "ingredients" = "flour, sugar", "is_cone" = TRUE),
		list("id" = CONE_CHOC, "name" = "Chocolate cones", "count" = product_types[CONE_CHOC], "unit" = "cones", "ingredients" = "flour, sugar, coco powder", "is_cone" = TRUE)
	)
	var/list/reagent_list = list()
	for (var/i = 1 to length(reagents.reagent_list))
		var/datum/reagent/R = reagents.reagent_list[i]
		reagent_list += list(list("index" = i, "name" = R.name, "volume" = R.volume))
	data["reagents"] = reagent_list
	return data

/obj/machinery/icecream_vat/attackby(obj/item/O as obj, mob/user as mob)
	if(istype(O, /obj/item/reagent_containers/food/snacks/icecream))
		var/obj/item/reagent_containers/food/snacks/icecream/I = O
		if(!I.ice_creamed)
			if(product_types[dispense_flavour] > 0)
				src.visible_message("[icon2html(src, viewers(get_turf(src)))] <span class='info'>[user] scoops delicious [flavour_name] icecream into [I].</span>")
				product_types[dispense_flavour] -= 1
				I.add_ice_cream(flavour_name)
			//	if(beaker)
			//		beaker.reagents.trans_to(I, 10)
				if(I.reagents.total_volume < 10)
					I.reagents.add_reagent(/datum/reagent/sugar, 10 - I.reagents.total_volume)
			else
				to_chat(user, SPAN_WARNING("There is not enough icecream left!"))
		else
			to_chat(user, SPAN_NOTICE("[O] already has icecream in it."))
		return 1
	else if(O.is_open_container())
		return
	else
		..()

/obj/machinery/icecream_vat/proc/make(mob/user, make_type, amount)
	if(amount > 5 || amount < 1)
		return
	if(!canmake)
		to_chat(user, SPAN_WARNING("The machine is cooling off!"))
		return
	for(var/R in get_ingredient_list(make_type))
		if(reagents.has_reagent(R, amount))
			continue
		amount = 0
		break
	if(amount)
		for(var/R in get_ingredient_list(make_type))
			reagents.remove_reagent(R, amount)
		product_types[make_type] += amount
		var/flavour = get_flavour_name(make_type)
		if(make_type > 6)
			src.visible_message(SPAN_INFO("[user] cooks up some [flavour] cones."))
		else
			src.visible_message(SPAN_INFO("[user] whips up some [flavour] icecream."))
		canmake = 0
		sleep(100)
		canmake = 1
	else
		to_chat(user, SPAN_WARNING("You don't have the ingredients to make this."))

/obj/machinery/icecream_vat/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	switch(action)
		if ("select")
			dispense_flavour = text2num(params["select"])
			flavour_name = get_flavour_name(dispense_flavour)
			visible_message(SPAN_NOTICE("[usr] sets [src] to dispense [flavour_name] flavoured icecream."))
			return TRUE
		if ("cone")
			var/dispense_cone = text2num(params["cone"])
			var/cone_name = get_flavour_name(dispense_cone)
			if (product_types[dispense_cone] >= 1)
				product_types[dispense_cone] -= 1
				var/obj/item/reagent_containers/food/snacks/icecream/I = new(src.loc)
				I.cone_type = cone_name
				I.icon_state = "icecream_cone_[cone_name]"
				I.desc = "Delicious [cone_name] cone, but no ice cream."
				visible_message(SPAN_INFO("[usr] dispenses a crunchy [cone_name] cone from [src]."))
			else
				to_chat(usr, SPAN_WARNING("There are no [cone_name] cones left!"))
			return TRUE
		if ("make")
			var/amount = text2num(params["amount"])
			var/make_type = text2num(params["make"])
			make(usr, make_type, amount)
			return TRUE
		if ("disposeI")
			var/index = text2num(params["index"])
			if (is_valid_index(index, reagents.reagent_list))
				var/datum/reagent/R = reagents.reagent_list[index]
				reagents.del_reagent(R.type)
			return TRUE
	return FALSE

/obj/item/reagent_containers/food/snacks/icecream
	name = "ice cream cone"
	desc = "Delicious waffle cone, but no ice cream."
	icon_state = "icecream_cone_waffle" //default for admin-spawned cones, href_list["cone"] should overwrite this all the time
	layer = ABOVE_OBJ_LAYER
	bitesize = 3

	var/ice_creamed = 0
	var/cone_type

/obj/item/reagent_containers/food/snacks/icecream/New()
	create_reagents(20)
	reagents.add_reagent(/datum/reagent/nutriment, 5)

/obj/item/reagent_containers/food/snacks/icecream/proc/add_ice_cream(flavour_name)
	name = "[flavour_name] icecream"
	src.add_overlay("icecream_[flavour_name]")
	desc = "Delicious [cone_type] cone with a dollop of [flavour_name] ice cream."
	ice_creamed = 1

#undef ICECREAM_VANILLA
#undef ICECREAM_CHOCOLATE
#undef ICECREAM_STRAWBERRY
#undef ICECREAM_BLUE
#undef ICECREAM_CHERRY
#undef ICECREAM_BANANA
#undef CONE_WAFFLE
#undef CONE_CHOC

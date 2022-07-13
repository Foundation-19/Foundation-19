/obj/machinery/stove
	name = "electric stove"
	desc = "A Skinner Catering electric cooking range, Model VII-21, equipped with six burners and automatic turn-off. This one is well-used, and comes outfitted with a collection of pots, pans, skillets, and other dishes to cook any variety of food you can think of."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "stove"
	layer = BELOW_OBJ_LAYER
	density = TRUE
	anchored = TRUE
	idle_power_usage = 5
	active_power_usage = 100
	obj_flags = OBJ_FLAG_ANCHORABLE
	atom_flags = ATOM_FLAG_NO_TEMP_CHANGE | ATOM_FLAG_NO_REACT | ATOM_FLAG_OPEN_CONTAINER
	construct_state = /decl/machine_construction/default/panel_closed
	uncreated_component_parts = null

	machine_name = "electric stove"
	machine_desc = "A multipurpose cooking range used to create prepared food from ingredients."

	/// Whether or not this stove is in the process of cooking.
	var/cooking = FALSE
	/// The amount of time it takes to run a full cooking cycle. Starts at 6.4 so that it's 6 by default after RefreshParts().
	var/cook_time = 4.4 SECONDS
	/// The amount of time added or removed from cook_time. This is set in interface_interact() and varies depending on user.
	var/user_time_modifier = 0
	/// A list of all of the food items stored inside of this stove.
	var/list/ingredients = list()

/obj/machinery/stove/Initialize()
	. = ..()
	create_reagents(100)
	if (prob(1))
		desc = "Oh, ye gods! My roast is ruined!"

/obj/machinery/stove/InsertedContents()
	return ingredients

/obj/machinery/stove/RefreshParts()
	. = ..()
	cook_time = initial(cook_time)
	cook_time = max(cook_time - Clamp(total_component_rating_of_type(/obj/item/stock_parts/micro_laser), 0, 12), 1 SECOND)

/obj/machinery/stove/on_update_icon()
	var/initial_icon = initial(icon_state)
	if (cooking)
		initial_icon += "_on"
	icon_state = initial_icon

/obj/machinery/stove/interface_interact(mob/living/user)
	var/dat = ""
	if (stat || !anchored)
		dat += UI_FONT_BAD("\The [src] is in no condition to operate.")
	else
		if (cooking)
			dat += "<b>Contents are cooking. Please wait...</b>"
		else
			var/cooking_skill = user.get_skill_value(SKILL_COOKING)
			if (cooking_skill > SKILL_UNTRAINED)
				user_time_modifier = -(0.1 SECONDS * cooking_skill)
			else
				user_time_modifier = 0
			var/effective_cook_time = cook_time + user_time_modifier
			dat += "[UIBUTTON("empty_stove", "Empty Ingredients", null)]<br>"
			dat += "[UIBUTTON("start_cooking", "Start", null)]<br>"
			dat += "<b>Cooking time for you:</b> [effective_cook_time / 10] second\s."
			dat += "<br><hr>"
			if (!LAZYLEN(ingredients))
				dat += UI_FONT_BAD("No ingredients!")
			else
				var/list/item_counts = list()
				for (var/obj/item/I in ingredients)
					if (istype(I, /obj/item/tray/baking))
						var/obj/item/tray/T = I
						dat += "[I.name] with [T.carrying.len > 0 ? T.carrying.len : "no"] item\s<br>"
					else
						item_counts[I.name]++
				for (var/V in item_counts)
					var/N = item_counts[V]
					dat += "[N] [V]\s<br>"
			if (reagents?.total_volume)
				for (var/datum/reagent/R in reagents.reagent_list)
					dat += "[R.volume] units of [R.name]<br>"
				dat += "<br>"

	var/datum/browser/popup = new(user, "stove", name, 450, 600, src)
	popup.set_content(dat)
	popup.open()

/obj/machinery/stove/OnTopic(mob/user, href_list, datum/topic_state/state)
	if (stat || !anchored)
		to_chat(user, SPAN_WARNING("\The [src] is in no condition to operate."))
		return
	else if (href_list["empty_stove"])
		if (is_processing)
			to_chat(user, SPAN_WARNING("Turn off \the [src] first."))
			return
		else if (length(ingredients) || reagents?.total_volume)
			to_chat(user, SPAN_NOTICE("You empty \the [src]."))
			for (var/obj/item/I in ingredients)
				I.dropInto(loc)
				LAZYREMOVE(ingredients, I)
			reagents?.clear_reagents()
		interface_interact(user)
	else if (href_list["start_cooking"])
		user.visible_message(
			SPAN_NOTICE("\The [user] turns on \the [src]."),
			SPAN_NOTICE("You turn on \the [src] and set the timer."),
			SPAN_NOTICE("You hear the click-click <i>fwoosh</i> of a stovetop turning on.")
		)
		cooking = TRUE
		playsound(src, 'sound/machines/stove_on.ogg', 100, FALSE) // 100% volume here because the sound itself is pretty quiet
		addtimer(CALLBACK(src, .proc/attempt_cook), cook_time + user_time_modifier)
		update_icon()
		interface_interact(user)

/obj/machinery/stove/attackby(obj/item/I, mob/user)
	if (is_type_in_list(I, SScuisine.stove_accepts_items))
		if (LAZYLEN(ingredients) >= SScuisine.stove_maximum_item_storage)
			to_chat(user, SPAN_WARNING("\The [src] is completely full!"))
		else if (istype(I, /obj/item/stack))
			var/obj/item/stack/S = I
			if (S.use(1))
				var/stack_item = new I.type (src)
				LAZYADD(ingredients, stack_item)
				user.visible_message( \
					SPAN_NOTICE("\The [user] adds \a [S.singular_name] to \the [src]."), \
					SPAN_NOTICE("You add one [S.singular_name] to \the [src].")
				)
		else
			if (!user.unEquip(I, src))
				return
			LAZYADD(ingredients, I)
			user.visible_message( \
				SPAN_NOTICE("\The [user] adds \the [I] to \the [src]."), \
				SPAN_NOTICE("You put \the [I] into \the [src].")
			)
		if (winget(user, "stove", "is-visible") == "true") // refresh if open, otherwise don't open it just for adding an item
			interface_interact(user)
		return

	else if (istype(I, /obj/item/storage))
		if (LAZYLEN(ingredients) >= SScuisine.stove_maximum_item_storage)
			to_chat(user, SPAN_WARNING("[src] is completely full!"))
			return

		var/obj/item/storage/bag/P = I
		var/objects_loaded = 0
		for (var/obj/G in P.contents)
			if (is_type_in_list(G, SScuisine.stove_accepts_items) && LAZYLEN(ingredients) < SScuisine.stove_maximum_item_storage && P.remove_from_storage(G, src, 1))
				objects_loaded++
				LAZYADD(ingredients, G)
		P.finish_bulk_removal()

		if (objects_loaded)
			if (!P.contents.len)
				user.visible_message(
					SPAN_NOTICE("\The [user] empties \the [P] into \the [src]."), \
					SPAN_NOTICE("You empty \the [P] into \the [src].")
				)
			else
				user.visible_message(
					SPAN_NOTICE("\The [user] empties \the [P] into \the [src]."), \
					SPAN_NOTICE("You empty what you can from \the [P] into \the [src].")
				)
		else
			to_chat(user, SPAN_WARNING("\The [P] doesn't contain any compatible items to put into \the [src]!"))
		return

	// This block is largely copypasted from above. Todo: Remove when trays are refactored into /storage.
	else if (istype(I, /obj/item/tray)) // We don't need to check subtypes for baking sheets here because they're already handled in the first if()
		if (LAZYLEN(ingredients) >= SScuisine.stove_maximum_item_storage)
			to_chat(user, SPAN_WARNING("[src] is completely full!"))
			return

		var/obj/item/tray/T = I
		var/objects_loaded = 0
		for (var/obj/G in T.carrying)
			if (is_type_in_list(G, SScuisine.stove_accepts_items) && LAZYLEN(ingredients) < SScuisine.stove_maximum_item_storage)
				objects_loaded++
				G.forceMove(src)
				LAZYREMOVE(T.carrying, G)
				LAZYADD(ingredients, G)

		if (objects_loaded)
			if (!LAZYLEN(T.carrying))
				user.visible_message(
					SPAN_NOTICE("\The [user] empties \the [T] into \the [src]."), \
					SPAN_NOTICE("You empty \the [T] into \the [src].")
				)
			else
				user.visible_message(
					SPAN_NOTICE("\The [user] empties \the [T] into \the [src]."), \
					SPAN_NOTICE("You empty what you can from \the [T] into \the [src].")
				)
		else
			to_chat(user, SPAN_WARNING("\The [T] doesn't contain any compatible items to put into \the [src]!"))
		T.update_icon()
		return

	else if (user.a_intent != I_HURT)
		to_chat(user, SPAN_WARNING("\The [I] isn't a valid ingredient in any recipes."))
		return

	. = ..()

/obj/machinery/stove/proc/attempt_cook()
	if (!stat)
		cook()
	finish_cook()

/obj/machinery/stove/proc/cook()
	var/datum/recipe/recipe
	var/obj/item/cooked
	for (var/obj/item/tray/baking/tray in ingredients)
		if (LAZYLEN(tray.carrying))
			recipe = select_recipe(SScuisine.stove_recipes, tray)
			if (recipe)
				cooked = recipe.make_food(tray)
				recipe = null
			else
				cooked = new /obj/item/reagent_containers/food/snacks/badrecipe (tray)
			if (cooked)
				cooked.dropInto(loc)
				cooked = null
		LAZYCLEARLIST(tray.carrying)
		LAZYREMOVE(ingredients, tray)
		tray.dropInto(loc)
		tray.cut_overlays()
	recipe = select_recipe(SScuisine.stove_recipes, src)
	if (recipe)
		cooked = recipe.make_food(src)
	else if (LAZYLEN(ingredients))
		cooked = new /obj/item/reagent_containers/food/snacks/badrecipe (src)
	for (var/mob/living/L in contents) // mob holder ended up in a stove. RIP
		L.death()
		qdel(L)
	LAZYCLEARLIST(ingredients)
	reagents?.clear_reagents()
	if (cooked)
		cooked.dropInto(loc)
	visible_message(SPAN_NOTICE("\The [src] finishes a cooking cycle."))
	playsound(src, 'sound/machines/ding.ogg', 50, TRUE)
	finish_cook()
	updateUsrDialog()

/obj/machinery/stove/proc/finish_cook()
	cooking = FALSE
	update_icon()
	updateUsrDialog()

// Simple version for roundstart maintenance hideouts, offships, and so on. Takes longer to cook stuff
/obj/machinery/stove/hotplate
	name = "hot plate"
	desc = "A flat metal surface with a simple electric heating element, used to cook food. Cleanliness not guaranteed."
	density = FALSE
	icon_state = "hotplate"
	cook_time = 6.2 SECONDS // Hotplate has two micro-lasers instead of four

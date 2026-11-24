/obj/machinery/pipedispenser
	name = "pipe dispenser"
	desc = "A huge dispenser loaded with an internal stock of compressed matter. It can create a wide selection of pipes and atmospherics machinery."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "pipe_d"
	density = TRUE
	anchored = FALSE
	stat_immune = NOSCREEN // Doesn't need a screen, just input for the parts wanted

	construct_state = /decl/machine_construction/default/panel_closed
	uncreated_component_parts = null

	idle_power_usage = 500
	power_channel = EQUIP
	use_power = POWER_USE_OFF

	machine_name = "pipe dispenser"
	machine_desc = "A semi-portable dispenser that uses compressed matter to create atmospherics pipes. Vital for repair or construction efforts."

	/// Whether or not this pipe dispenser has color customization for its pipes.
	var/has_colors = TRUE
	/// Pipes dispensed by this machine will take on this color.
	var/pipe_color = "white"
	/// A list of atom types that this pipe dispenser can consume by being hit by them or having a user drag-drop them onto the dispenser.
	var/list/consume_types = list(
		/obj/item/pipe,
		/obj/item/machine_chassis
	)

/obj/machinery/pipedispenser/Initialize() //for mapping purposes. Anchor them by map var edit if needed.
	. = ..()
	if (anchored)
		update_use_power(POWER_USE_IDLE)

/// Returns an associated list of pipes that this dispenser can create. We can't use globals in compile-time defs, so we do this instead.
/obj/machinery/pipedispenser/proc/get_pipe_types()
	return GLOB.all_pipe_datums_by_category

/obj/machinery/pipedispenser/proc/build_quantity(datum/pipe/P, quantity)
	for (var/I = quantity;I > 0;I -= 1)
		P.Build(P, loc, pipe_colors[pipe_color])
		use_power_oneoff(500)
	playsound(src, 'sounds/items/Deconstruct.ogg', 50, TRUE)

/obj/machinery/pipedispenser/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "PipeDispenser", name)
		ui.open()

/obj/machinery/pipedispenser/tgui_data(mob/user)
	var/list/data = list()
	var/list/pipe_types = get_pipe_types()
	var/list/categories = list()
	for (var/category in pipe_types)
		var/datum/pipe/cat = category
		var/list/pipe_list = list()
		for (var/datum/pipe/pipe in pipe_types[category])
			pipe_list += list(list(
				"name" = pipe.name,
				"ref" = REF(pipe)))
		categories += list(list(
			"name" = initial(cat.category),
			"pipes" = pipe_list))
	data["categories"] = categories
	data["has_colors"] = has_colors
	data["pipe_color"] = pipe_color
	if (has_colors)
		var/list/colors = list()
		for (var/color in pipe_colors)
			colors += color
		data["colors"] = colors
	return data

/obj/machinery/pipedispenser/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if (..())
		return TRUE
	switch (action)
		if ("build")
			var/datum/pipe/P = locate(params["pipe"])
			if (!istype(P))
				return TRUE
			var/quantity = text2num(params["amount"])
			if (!quantity)
				return TRUE
			build_quantity(P, quantity)
			return TRUE
		if ("set_color")
			if (!has_colors)
				return TRUE
			var/choice = params["color"]
			if (!(choice in pipe_colors))
				return TRUE
			pipe_color = choice
			SStgui.update_uis(src)
			return TRUE
	return FALSE

/obj/machinery/pipedispenser/interface_interact(mob/user)
	tgui_interact(user)
	return TRUE

/obj/machinery/pipedispenser/attackby(obj/item/W, mob/user)
	if (is_type_in_list(W, consume_types))
		if (!user.unEquip(W))
			return
		to_chat(user, SPAN_NOTICE("You dump \the [W] into \the [src] for recycling."))
		add_fingerprint(user)
		qdel(W)
		return
	if (!panel_open)
		if (isWrench(W))
			add_fingerprint(user)
			playsound(src, 'sounds/items/Ratchet.ogg', 50, TRUE)
			user.visible_message(
				SPAN_NOTICE("\The [user] starts [anchored ? "un" : ""]securing \the [src]."),
				SPAN_NOTICE("You start [anchored ? "un" : ""]fastening \the [src]."),
				SPAN_ITALIC("You hear bolts being turned.")
			)
			if (!do_after(user, 4 SECONDS, src, bonus_percentage = 25))
				return
			user.visible_message(
				SPAN_NOTICE("\The [user] [anchored ? "un" : ""]secures \the [src]."),
				SPAN_NOTICE("You [anchored ? "undo \the [src]\'s securing bolts" : "fasten \the [src] to the floor"]."),
				SPAN_ITALIC("You hear bolts being turned.")
			)
			playsound(src, 'sounds/items/Deconstruct.ogg', 50, TRUE)
			anchored = !anchored
			if (!anchored)
				stat |= MAINT
				update_use_power(POWER_USE_OFF)
				SStgui.close_uis(src)
			else
				stat &= ~MAINT
				update_use_power(POWER_USE_IDLE)
			return
	. = ..()

/obj/machinery/pipedispenser/MouseDrop_T(obj/O, mob/user)
	if (!CanPhysicallyInteract(user))
		return

	if (!is_type_in_list(O, consume_types) || O.anchored)
		return

	if (user.pulling == O)
		user.stop_pulling()
	to_chat(user, SPAN_NOTICE("You dump \the [O] into \the [src] for recycling."))
	qdel(O)

/obj/machinery/pipedispenser/disposal
	name = "disposal pipe dispenser"
	desc = "This pipe dispenser is configured for the huge, bulky metal pipes and machines used in constructing a disposals network."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "pipe_d"
	machine_name = "disposal pipe dispenser"
	machine_desc = "Similar to a normal pipe dispenser, but calibrated for tubes used in disposals networks."

	has_colors = FALSE
	consume_types = list(/obj/structure/disposalconstruct)

/obj/machinery/pipedispenser/disposal/get_pipe_types()
	return GLOB.all_disposal_pipe_datums_by_category

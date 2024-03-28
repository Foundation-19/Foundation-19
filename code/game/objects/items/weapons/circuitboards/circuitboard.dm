/obj/item/stock_parts/circuitboard
	name = "circuit board"
	desc = "An electronic PCB used to build machines."
	icon = 'icons/obj/module.dmi'
	icon_state = "id_mod"
	item_state = "electronic"
	origin_tech = list(TECH_DATA = 2)
	density = FALSE
	anchored = FALSE
	w_class = ITEM_SIZE_SMALL
	obj_flags = OBJ_FLAG_CONDUCTIBLE
	force = 5.0
	throwforce = 5.0
	throw_speed = 3
	throw_range = 15
	part_flags = 0
	var/build_path = null
	var/board_type = "computer"
	var/list/req_components = list(
		/obj/item/stock_parts/console_screen = 1,
		/obj/item/stock_parts/keyboard = 1
	)  // Components needed to build the machine.
	var/list/spawn_components // If set, will be used as a replacement for req_components when setting components at round start.
	var/list/additional_spawn_components = list(
		/obj/item/stock_parts/power/apc/buildable = 1
	) // unlike the above, this is added to req_components instead of replacing them.
	var/buildtype_select = FALSE

/obj/item/stock_parts/circuitboard/examine(mob/user)
	. = ..()
	if (!user.skill_check(SKILL_CONSTRUCTION, SKILL_BASIC) && !isobserver(user))
		to_chat(user, "You aren't sure what you can build with this.")
		return
	if (build_path)
		var/obj/machinery/M = build_path
		var/machine_name = initial(M.machine_name)
		var/machine_desc = initial(M.machine_desc)
		if (machine_name && machine_desc)
			to_chat(user, SPAN_NOTICE("This circuit board is part of \a <b>[machine_name]</b>."))
			to_chat(user, SPAN_NOTICE(machine_desc))
			if (buildtype_select)
				to_chat(user, SPAN_NOTICE("This board can be used for multiple machines. Use a multitool to determine what type of machine that will be created."))
	if (user.skill_check(SKILL_CONSTRUCTION, SKILL_TRAINED) || isobserver(user))
		if (req_components.len)
			to_chat(user, SPAN_NOTICE("It requires the following parts to function:"))
			for (var/V in req_components)
				var/obj/item/I = V
				to_chat(user, SPAN_NOTICE("&nbsp;&nbsp;[req_components[V]] [initial(I.name)]"))
		if (additional_spawn_components.len)
			to_chat(user, SPAN_NOTICE("It[req_components.len ? " also" : ""] requires the following parts to actually be usable:"))
			for (var/V in additional_spawn_components)
				var/obj/item/I = V
				to_chat(user, SPAN_NOTICE("&nbsp;&nbsp;[additional_spawn_components[V]] [initial(I.name)]"))

//Called when the circuitboard is used to contruct a new machine.
/obj/item/stock_parts/circuitboard/proc/construct(obj/machinery/M)
	if (istype(M, build_path))
		return 1
	return 0

//Called when a computer is deconstructed to produce a circuitboard.
//Only used by computers, as other machines store their circuitboard instance.
/obj/item/stock_parts/circuitboard/proc/deconstruct(obj/machinery/M)
	if (istype(M, build_path))
		return 1
	return 0

// Used with the build type selection multitool extension. Return a list of possible build types to allow multitool toggle.
/obj/item/stock_parts/circuitboard/proc/get_buildable_types()

/obj/item/stock_parts/circuitboard/Initialize()
	. = ..()
	if(buildtype_select)
		if(get_extension(src, /datum/extension/interactive/multitool))
			CRASH("A circuitboard of type [type] has conflicting multitool extensions")
		set_extension(src, /datum/extension/interactive/multitool/circuitboards/buildtype_select)

/obj/item/stock_parts/circuitboard/on_uninstall(obj/machinery/machine)
	. = ..()
	if(buildtype_select && machine)
		build_path = machine.base_type || machine.type
		var/obj/machinery/thing = build_path
		SetName(T_BOARD(initial(thing.name)))

// Assoc list of all circuits by their board_type
GLOBAL_LIST_EMPTY(circuitboards_by_type)

// 1:1 - Returns random board with same board_type
// Fine - Has a chance to instantly build the machine, or explode slightly
// Very Fine - Turns into an item that allows its user to instantly build the target machine
/obj/item/stock_parts/circuitboard/Conversion914(mode = MODE_ONE_TO_ONE, mob/user = usr)
	switch(mode)
		if(MODE_ONE_TO_ONE)
			if(!length(GLOB.circuitboards_by_type))
				for(var/thing in subtypesof(/obj/item/stock_parts/circuitboard))
					var/obj/item/stock_parts/circuitboard/C = thing
					if(!(initial(C.board_type) in GLOB.circuitboards_by_type))
						GLOB.circuitboards_by_type[initial(C.board_type)] = list()
					GLOB.circuitboards_by_type[initial(C.board_type)] += C
			if(!length(GLOB.circuitboards_by_type[board_type]))
				return src
			return pick(GLOB.circuitboards_by_type[board_type])
		if(MODE_FINE)
			if(!build_path)
				return src
			playsound(src, 'sounds/items/rped.ogg', 50, TRUE)
			return build_path
		if(MODE_VERY_FINE)
			var/obj/item/machine_builder/MB = new(get_turf(src))
			MB.machine_type = build_path
			return MB
	return ..()

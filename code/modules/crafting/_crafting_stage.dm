/decl/crafting_stage
	var/item_desc = "It's an unfinished item of some sort."
	var/item_icon = 'icons/obj/crafting_icons.dmi'
	var/item_icon_state = "default"
	var/completion_trigger_type = /obj/item
	var/consume_completion_trigger = TRUE
	var/stack_consume_amount
	var/progress_message
	var/begins_with_object_type
	var/list/next_stages
	var/product

/decl/crafting_stage/New()
	var/stages = list()
	for(var/nid in next_stages)
		stages += decls_repository.get_decl(nid)
	next_stages = stages
	..()

/decl/crafting_stage/proc/can_begin_with(obj/item/thing)
	. = istype(thing, begins_with_object_type)

/decl/crafting_stage/proc/get_next_stage(obj/item/trigger)
	for(var/decl/crafting_stage/next_stage in next_stages)
		if(next_stage.is_appropriate_tool(trigger))
			return next_stage

/decl/crafting_stage/proc/progress_to(obj/item/thing, mob/user, obj/item/target)
	. = is_appropriate_tool(thing) && consume(user, thing, target)
	if(.)
		on_progress(user)

/decl/crafting_stage/proc/is_appropriate_tool(obj/item/thing)
	. = istype(thing, completion_trigger_type)

/decl/crafting_stage/proc/consume(mob/user, obj/item/thing, obj/item/target)
	. = !consume_completion_trigger || (user.unEquip(thing) && thing.forceMove(target))
	if(. && stack_consume_amount > 0)
		var/obj/item/stack/stack = thing
		if(!istype(stack) || stack.amount < stack_consume_amount)
			on_insufficient_material(user)
			return FALSE
		stack.use(stack_consume_amount)

/decl/crafting_stage/proc/on_insufficient_material(mob/user, obj/item/stack/thing)
	if(istype(thing))
		to_chat(user, SPAN_NOTICE("You need at least [stack_consume_amount] [stack_consume_amount == 1 ? thing.singular_name : thing.plural_name] to complete this task."))

/decl/crafting_stage/proc/on_progress(mob/user)
	if(progress_message)
		to_chat(user, SPAN_NOTICE(progress_message))

/decl/crafting_stage/proc/get_product(obj/item/work)
	. = ispath(product) && new product(get_turf(work))

/decl/crafting_stage/wiring
	completion_trigger_type = /obj/item/stack/cable_coil
	stack_consume_amount = 5
	consume_completion_trigger = FALSE

/decl/crafting_stage/material
	completion_trigger_type = /obj/item/stack/material
	stack_consume_amount = 5
	consume_completion_trigger = FALSE
	var/stack_material = MATERIAL_STEEL

/decl/crafting_stage/material/consume(mob/user, obj/item/thing, obj/item/target)
	var/obj/item/stack/material/M = thing
	. = istype(M) && (!stack_material || M.material.name == stack_material) && ..()

/decl/crafting_stage/rods
	completion_trigger_type = /obj/item/stack/material/rods
	stack_consume_amount = 5
	consume_completion_trigger = FALSE
	var/stack_material = MATERIAL_STEEL

/decl/crafting_stage/rods/consume(mob/user, obj/item/thing, obj/item/target)
	var/obj/item/stack/material/rods/M = thing
	. = istype(M) && (!stack_material || M.material.name == stack_material) && ..()

/decl/crafting_stage/welding
	consume_completion_trigger = FALSE

/decl/crafting_stage/welding/consume(mob/user, obj/item/thing, obj/item/target)
	var/obj/item/weldingtool/T = thing
	. = istype(T) && T.remove_fuel(0, user) && T.isOn()

/decl/crafting_stage/welding/on_progress(mob/user)
	..()
	playsound(user.loc, 'sounds/items/Welder2.ogg', 100, 1)

/decl/crafting_stage/screwdriver
	consume_completion_trigger = FALSE

/decl/crafting_stage/screwdriver/on_progress(mob/user)
	..()
	playsound(user.loc, 'sounds/items/Screwdriver.ogg', 100, 1)

/decl/crafting_stage/screwdriver/is_appropriate_tool(obj/item/thing)
	. = ..() && isScrewdriver(thing)

/decl/crafting_stage/wirecutter
	consume_completion_trigger = FALSE

/decl/crafting_stage/wirecutter/on_progress(mob/user)
	..()
	playsound(user.loc, 'sounds/items/Wirecutter.ogg', 100, 1)

/decl/crafting_stage/wirecutter/is_appropriate_tool(obj/item/thing)
	. = ..() && isWirecutter(thing)

/decl/crafting_stage/crowbar
	consume_completion_trigger = FALSE

/decl/crafting_stage/crowbar/on_progress(mob/user)
	..()
	playsound(user.loc, 'sounds/items/Crowbar.ogg', 100, 1)

/decl/crafting_stage/crowbar/is_appropriate_tool(obj/item/thing)
	. = ..() && isCrowbar(thing)

/decl/crafting_stage/tape
	consume_completion_trigger = FALSE
	completion_trigger_type = /obj/item/tape_roll

/decl/crafting_stage/pipe
	completion_trigger_type = /obj/item/pipe

/decl/crafting_stage/scanner
	completion_trigger_type = /obj/item/device/scanner/health

/decl/crafting_stage/proximity
	completion_trigger_type = /obj/item/device/assembly/prox_sensor

/decl/crafting_stage/robot_arms
	progress_message = "You add the robotic arm to the assembly."
	completion_trigger_type = /obj/item/robot_parts

/decl/crafting_stage/robot_arms/is_appropriate_tool(obj/item/thing)
	. = istype(thing, /obj/item/robot_parts/l_arm) || istype(thing, /obj/item/robot_parts/r_arm)

/decl/crafting_stage/empty_storage/can_begin_with(obj/item/thing)
	. = ..()
	if(. && istype(thing, /obj/item/storage))
		var/obj/item/storage/box = thing
		. = (length(box.contents) == 0)

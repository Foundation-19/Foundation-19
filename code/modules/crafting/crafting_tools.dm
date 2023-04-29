/decl/crafting_stage/tape/tool_handle
	begins_with_object_type = /obj/item/stack/material/rods
	progress_message = "You wrap some tape around the rod to make a handle."
	next_stages = list(/decl/crafting_stage/wirecutter/imp_screwdriver, /decl/crafting_stage/rods/imp_wirecutters, /decl/crafting_stage/material/imp_crowbar, /decl/crafting_stage/crowbar/imp_wrench, /decl/crafting_stage/imp_pickaxe, /decl/crafting_stage/imp_shovel)
	item_icon_state = "tool_handle"

/decl/crafting_stage/wirecutter/imp_screwdriver
	progress_message = "You file the rod into a makeshift screwdriver."
	product = /obj/item/screwdriver/makeshift

/decl/crafting_stage/rods/imp_wirecutters
	progress_message = "You tape on a second rod and make a pair of makeshift wirecutters."
	stack_consume_amount = 1
	product = /obj/item/wirecutters/makeshift

/decl/crafting_stage/material/imp_crowbar
	progress_message = "You attach a sheet of metal to make a makeshift crowbar."
	stack_consume_amount = 1
	product = /obj/item/crowbar/makeshift

/decl/crafting_stage/crowbar/imp_wrench
	progress_message = "You pry the rod into a makeshift wrench."
	product = /obj/item/wrench/makeshift

/decl/crafting_stage/imp_pickaxe
	progress_message = "You jam a fork in and make a makeshift pickaxe."
	product = /obj/item/pickaxe/makeshift
	completion_trigger_type = /obj/item/material/kitchen/utensil/fork

/decl/crafting_stage/imp_shovel
	progress_message = "You jam a spoon in and make a makeshift pickaxe."
	product = /obj/item/shovel/makeshift
	completion_trigger_type = /obj/item/material/kitchen/utensil/spoon

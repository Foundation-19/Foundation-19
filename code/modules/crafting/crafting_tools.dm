/decl/crafting_stage/tape/tool_handle
	begins_with_object_type = /obj/item/stack/material/rods
	progress_message = "You wrap some tape around the rod to make a handle."
	next_stages = list(/decl/crafting_stage/wirecutter/screwdriver, /decl/crafting_stage/rods/wirecutters, /decl/crafting_stage/material/crowbar, /decl/crafting_stage/crowbar/wrench)
	item_icon_state = "tool_handle"

/decl/crafting_stage/wirecutter/screwdriver
	progress_message = "You file the rod into a makeshift screwdriver."
	product = /obj/item/screwdriver/makeshift

/decl/crafting_stage/rods/wirecutters
	progress_message = "You tape on a second rod and make a pair of makeshift wirecutters."
	stack_consume_amount = 1
	product = /obj/item/wirecutters/makeshift

/decl/crafting_stage/material/crowbar
	progress_message = "You attach a sheet of metal to make a makeshift crowbar."
	stack_consume_amount = 1
	product = /obj/item/crowbar/makeshift

/decl/crafting_stage/crowbar/wrench
	progress_message = "You pry the rod into a makeshift wrench."
	product = /obj/item/wrench/makeshift

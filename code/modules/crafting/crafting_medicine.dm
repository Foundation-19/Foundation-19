/decl/crafting_stage/rods/makeshift_splint
	begins_with_object_type = /obj/item/tape_roll
	progress_message = "You use up the tape on the rods."
	next_stages = list(/decl/crafting_stage/wirecutter/makeshift_splint)
	item_icon_state = "makeshift_splint_1"
	stack_consume_amount = 1

/decl/crafting_stage/wirecutter/makeshift_splint
	progress_message = "You trim the tape into a makeshift splint."
	product = /obj/item/stack/medical/splint/ghetto

/obj/item/storage/briefcase/scp1689
	name = "burlap bag"
	desc = "A burlap bag of potatos"
	icon = 'icons/SCP/scp-1689.dmi'

	icon_state = "scp1689"
	w_class = ITEM_SIZE_HUGE

	//Mechanics

	var/obj/structure/ladder/scp1689ladder/enter_point

/obj/item/storage/briefcase/scp1689/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"burlap bag", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_SAFE, //Obj Class
		"1689" //Numerical Designation
	)

//Overrides

/obj/item/storage/briefcase/scp1689/open(mob/user)
	if(!enter_point)
		enter_point = locate(/obj/structure/ladder/scp1689ladder) in GLOB.SCP_list
	var/turf/T = get_turf(enter_point)
	if(!T)
		to_chat(user, SPAN_WARNING("The bag appears empty!"))
		return
	user.visible_message(SPAN_NOTICE("\The [user] begins to try to climb into [src]!"))
	if(!do_after(user, 2 SECONDS))
		return
	user.drop_from_inventory(src, get_turf(user))
	user.forceMove(T)
	playsound(src, pick(enter_point.climbsounds), 50)
	playsound(enter_point, pick(enter_point.climbsounds), 50)
	visible_message(SPAN_WARNING("The [user] has opened the [src] and climbed down into it!"))

//Ladder

/obj/structure/ladder/scp1689ladder
	allowed_directions = UP

/obj/structure/ladder/scp1689ladder/Initialize()
	. = ..()
	SCP = new /datum/scp( //This is here just so we can reference it in the global SCP list
		src, // Ref to actual SCP atom
		"ladder", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_SAFE, //Obj Class
		"1689-1" //Numerical Designation
	)

//Overrides

/obj/structure/ladder/scp1689ladder/getTargetLadder(mob/M)
	if(!target_up)
		target_up = locate(/obj/item/storage/briefcase/scp1689) in GLOB.SCP_list //Technically a type mismatch but uhhhhh ladders never check so this works without runtimes
	return target_up


/obj/effect/blob/potato
	name = "potato wall"
	desc = "A wall of potatoes, you can see them slowly growing."
	icon = 'icons/SCP/scp-1689.dmi'
	icon_state = "wall"
	density = TRUE
	opacity = 1
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_OPAQUE
	health_max = 30

	expandType = /obj/effect/blob/potato
	attack_freq = 100
	product = /obj/item/reagent_containers/food/snacks/grown/potato


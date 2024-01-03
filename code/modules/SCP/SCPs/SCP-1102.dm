/obj/item/storage/briefcase/scp1102ru
	name = "old plastic case"
	desc = "A strange plastic case covered in cloth."

	w_class = ITEM_SIZE_HUGE

	//Mechanics

	var/obj/structure/ladder/scp1102ladder/enter_point

/obj/item/storage/briefcase/scp1102ru/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"old plastic case", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SAFE, //Obj Class
		"1102-RU" //Numerical Designation
	)

//Overrides

/obj/item/storage/briefcase/scp1102ru/open(mob/user)
	if(!enter_point)
		enter_point = locate(/obj/structure/ladder/scp1102ladder) in GLOB.SCP_list
	var/turf/T = get_turf(enter_point)
	if(!T)
		to_chat(user, SPAN_WARNING("The suitcase appears empty!"))
		return
	user.visible_message(SPAN_NOTICE("\The [user] begins to try to climb into [src]!"))
	if(!do_after(user, 2 SECONDS))
		return
	user.drop_from_inventory(src, get_turf(user))
	user.forceMove(T)
	playsound(src, pick(enter_point.climbsounds), 50)
	playsound(enter_point, pick(enter_point.climbsounds), 50)
	visible_message(SPAN_WARNING("The [user] has opened the [src] and climbed down into it!"))

///////////Ladder

/obj/structure/ladder/scp1102ladder
	icon_state = "ladder10"

	//Mechanical

	var/obj/item/storage/briefcase/scp1102ru/return_point

/obj/structure/ladder/scp1102ladder/Initialize()
	. = ..()
	SCP = new /datum/scp( //This is here just so we can reference it in the global SCP list
		src, // Ref to actual SCP atom
		"ladder", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SAFE, //Obj Class
		"1102-RU-1" //Numerical Designation
	)

//Overrides

/obj/structure/ladder/scp1102ladder/climb(mob/user)
	if(!return_point)
		return_point = locate(/obj/item/storage/briefcase/scp1102ru) in GLOB.SCP_list
	var/turf/T = get_turf(return_point)
	if(!T)
		to_chat(user, SPAN_WARNING("The ladder dosent seem to go anywhere!"))
		return
	if(!do_after(user, 2 SECONDS))
		return
	user.forceMove(T)
	playsound(src, pick(climbsounds), 50)
	playsound(return_point, pick(climbsounds), 50)
	user.visible_message(SPAN_WARNING("[user] climbs up the ladder!"))

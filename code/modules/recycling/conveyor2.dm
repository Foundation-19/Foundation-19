#define DIRECTION_FORWARDS	1
#define DIRECTION_OFF		0
#define DIRECTION_REVERSED	-1
#define IS_OPERATING		(operating && can_conveyor_run())

GLOBAL_LIST_INIT(conveyor_belts, list()) //Saves us having to look through the entire machines list for our things
GLOBAL_LIST_INIT(conveyor_switches, list())

//conveyor2 is pretty much like the original, except it supports corners, but not diverters.

/obj/machinery/conveyor
	name = "conveyor belt"
	desc = "A conveyor belt."
	icon = 'icons/obj/machines/conveyor.dmi'
	icon_state = "conveyor_stopped_cw"
	layer = BELOW_OBJ_LAYER	// so they appear under stuff
	anchored = TRUE
	var/operating = FALSE	// NB: this can be TRUE while the belt doesn't go
	var/forwards			// The direction the conveyor sends you in
	var/backwards			// hopefully self-explanatory
	var/clockwise = TRUE	// For corner pieces - do we go clockwise or counterclockwise?
	var/operable = TRUE		// Can this belt actually go?
	var/list/affecting		// the list of all items that will be moved this ptick
	var/reversed = FALSE	// set to TRUE to have the conveyor belt be reversed
	var/id					// ID of the connected lever

// create a conveyor
/obj/machinery/conveyor/New(loc, new_dir, new_id)
	..(loc)
	GLOB.conveyor_belts += src
	if(new_id)
		id = new_id
	if(new_dir)
		dir = new_dir
	update_move_direction()
	for(var/I in GLOB.conveyor_switches)
		var/obj/machinery/conveyor_switch/S = I
		if(id == S.id)
			S.conveyors += src

/obj/machinery/conveyor/Destroy()
	GLOB.conveyor_belts -= src
	return ..()

// attack with item, place item on conveyor
/obj/machinery/conveyor/attackby(obj/item/I, mob/user)
	if(isCrowbar(I))
		if(!(stat & BROKEN))
			var/obj/item/construct/conveyor/C = new /obj/item/construct/conveyor(loc, id)
			transfer_fingerprints_to(C)
		to_chat(user, SPAN_NOTICE("You remove the conveyor belt."))
		qdel(src)
		return

	if(isWrench(I))
		if(!(stat & BROKEN))
			set_rotation(user)
			update_move_direction()
		return

	if(istype(I, /obj/item/construct/conveyor_switch))
		var/obj/item/construct/conveyor_switch/S = I
		if(S.id == id)
			return ..()
		for(var/obj/machinery/conveyor_switch/CS in GLOB.conveyor_switches)
			if(CS.id == id)
				CS.conveyors -= src
		id = S.id
		to_chat(user, SPAN_NOTICE("You link [I] with [src]."))
		return

	if(user.a_intent != I_HURT)
		user.unequip_item(get_turf(src))
		return

	else
		return ..()

// attack with hand, move pulled object onto conveyor
/obj/machinery/conveyor/physical_attack_hand(mob/user)
	if(!user.pulling)
		return
	if(user.pulling.anchored)
		return
	if((user.pulling.loc != user.loc && get_dist(user, user.pulling) > 1))
		return
	if(ismob(user.pulling))
		var/mob/M = user.pulling
		M.stop_pulling()
		step(user.pulling, get_dir(user.pulling.loc, src))
		user.stop_pulling()
		return TRUE
	else
		step(user.pulling, get_dir(user.pulling.loc, src))
		user.stop_pulling()
		return TRUE

/obj/machinery/conveyor/on_update_icon()
	..()
	if(operating && can_conveyor_run())
		icon_state = "conveyor_started_[clockwise ? "cw" : "ccw"]"
		if(reversed)
			icon_state += "_r"
	else
		icon_state = "conveyor_stopped_[clockwise ? "cw" : "ccw"]"

/obj/machinery/conveyor/proc/update_move_direction()
	update_icon()
	switch(dir)
		if(NORTH)
			forwards = NORTH
			backwards = SOUTH
		if(EAST)
			forwards = EAST
			backwards = WEST
		if(SOUTH)
			forwards = SOUTH
			backwards = NORTH
		if(WEST)
			forwards = WEST
			backwards = EAST
		if(NORTHEAST)
			forwards = clockwise ? EAST : NORTH
			backwards = clockwise ? SOUTH : WEST
		if(SOUTHEAST)
			forwards = clockwise ? SOUTH : EAST
			backwards = clockwise ? WEST : NORTH
		if(SOUTHWEST)
			forwards = clockwise ? WEST : SOUTH
			backwards = clockwise ? NORTH : EAST
		if(NORTHWEST)
			forwards = clockwise ? NORTH : WEST
			backwards = clockwise ? EAST : SOUTH
	if(!reversed)
		return
	var/temporary_direction = forwards
	forwards = backwards
	backwards = temporary_direction

/obj/machinery/conveyor/proc/set_rotation(mob/user)
	dir = turn(reversed ? backwards : forwards, -90) //Fuck it, let's do it this way instead of doing something clever with dir
	var/turf/left = get_step(src, turn(dir, 90))	//We need to get conveyors to the right, left, and behind this one to be able to determine if we need to make a corner piece
	var/turf/right = get_step(src, turn(dir, -90))
	var/turf/back = get_step(src, turn(dir, 180))
	to_chat(user, SPAN_NOTICE("You rotate [src]."))
	var/obj/machinery/conveyor/CL = locate() in left
	var/obj/machinery/conveyor/CR = locate() in right
	var/obj/machinery/conveyor/CB = locate() in back
	var/link_to_left = FALSE
	var/link_to_right = FALSE
	var/link_to_back = FALSE
	if(CL)
		if(CL.id == id && get_step(CL, CL.reversed ? CL.backwards : CL.forwards) == loc)
			link_to_left = TRUE
	if(CR)
		if(CR.id == id && get_step(CR, CR.reversed ? CR.backwards : CR.forwards) == loc)
			link_to_right = TRUE
	if(CB)
		if(CB.id == id && get_step(CB, CB.reversed ? CB.backwards : CB.forwards) == loc)
			link_to_back = TRUE
	if(link_to_back) //Don't need to do anything because we can assume the conveyor carries on in a line
		return
	else if(!(link_to_left ^ link_to_right)) //Either no valid conveyors point here, or two point here (making a "junction" with this belt as the middle piece). Either way we don't need a corner
		return
	if(link_to_right)
		dir = turn(dir, 45)
		clockwise = TRUE
	else if(link_to_left)
		dir = turn(dir, -45)
		clockwise = FALSE

/obj/machinery/conveyor/power_change()
	..()
	update_icon()

/obj/machinery/conveyor/Process(wait)
	if(!operating)
		return
	if(!can_conveyor_run())
		return
	use_power_oneoff(100)
	affecting = loc.contents - src // moved items will be all in loc
	if(!affecting)
		return
	sleep(1)
	for(var/atom/movable/A in affecting)
		if(!A.anchored)
			if(A.loc == loc) // prevents the object from being affected if it's not currently here.
				step(A, forwards)
		CHECK_TICK

/obj/machinery/conveyor/proc/can_conveyor_run()
	if(stat & BROKEN)
		return FALSE
	else if(stat & NOPOWER)
		return FALSE
	else if(!operable)
		return FALSE
	return TRUE

// make the conveyor broken and propagate inoperability to any connected conveyor with the same conveyor datum
/obj/machinery/conveyor/proc/make_broken()
	stat |= BROKEN
	operable = FALSE
	update_icon()
	var/obj/machinery/conveyor/C = locate() in get_step(src, forwards)
	if(C)
		C.set_operable(TRUE, id, FALSE)
	C = locate() in get_step(src, backwards)
	if(C)
		C.set_operable(FALSE, id, FALSE)

/obj/machinery/conveyor/proc/set_operable(propagate_forwards, match_id, op) //Sets a conveyor inoperable if ID matches it, and propagates forwards / backwards
	if(id != match_id)
		return
	operable = op

	update_icon()
	var/obj/machinery/conveyor/C = locate() in get_step(src, propagate_forwards ? forwards : backwards)
	if(C)
		C.set_operable(propagate_forwards ? TRUE : FALSE, id, op)

// the conveyor control switch

/obj/machinery/conveyor_switch
	name = "conveyor switch"
	desc = "A conveyor control switch."
	icon = 'icons/obj/machines/conveyor.dmi'
	icon_state = "switch-off"
	anchored = TRUE
	var/position = DIRECTION_OFF
	var/reversed = TRUE
	var/one_way = FALSE	// Do we go in one direction?
	var/id
	var/list/conveyors = list()

/obj/machinery/conveyor_switch/New(newloc, new_id)
	..(newloc)
	GLOB.conveyor_switches += src
	if(!id)
		id = new_id
	for(var/I in GLOB.conveyor_belts)
		var/obj/machinery/conveyor/C = I
		if(C.id == id)
			conveyors += C

/obj/machinery/conveyor_switch/Destroy()
	GLOB.conveyor_switches -= src
	return ..()

// update the icon depending on the position

/obj/machinery/conveyor_switch/on_update_icon()
	cut_overlays()
	if(!position)
		icon_state = "switch-off"
	else if(position == DIRECTION_REVERSED)
		icon_state = "switch-rev"
		if(!(stat & NOPOWER))
			add_overlay("redlight")
	else if(position == DIRECTION_FORWARDS)
		icon_state = "switch-fwd"
		if(!(stat & NOPOWER))
			add_overlay("greenlight")

// attack with hand, switch position
/obj/machinery/conveyor_switch/attack_hand(mob/user)
	if(..())
		return TRUE
	toggle()

/obj/machinery/conveyor_switch/proc/toggle(mob/user)
	add_fingerprint(user)
	if(!allowed(user))
		to_chat(user, SPAN_WARNING("Access denied."))
		return
	if(position)
		position = DIRECTION_OFF
	else
		reversed = one_way ? FALSE : !reversed
		position = reversed ? DIRECTION_REVERSED : DIRECTION_FORWARDS
	update_icon()
	for(var/obj/machinery/conveyor/C in conveyors)
		C.operating = abs(position)
		if(C.reversed != reversed)
			C.reversed = reversed
			C.update_move_direction()
		else
			C.update_icon()
		CHECK_TICK
	for(var/I in GLOB.conveyor_switches) // find any switches with same id as this one, and set their positions to match us
		var/obj/machinery/conveyor_switch/S = I
		if(S == src || S.id != id)
			continue
		S.position = position
		S.one_way = one_way //Break everything!!1!
		S.reversed = reversed
		S.update_icon()
		CHECK_TICK

/obj/machinery/conveyor_switch/attackby(obj/item/I, mob/user)
	if(isCrowbar(I))
		var/obj/item/construct/conveyor_switch/C = new(loc, id)
		transfer_fingerprints_to(C)
		to_chat(user, SPAN_NOTICE("You detach the conveyor switch."))
		qdel(src)
		return
	if(isMultitool(I))
		one_way = !one_way
		to_chat(user, SPAN_NOTICE("[src] will now go [one_way ? "forwards only" : "both forwards and backwards"]."))
		return
	return ..()

/obj/machinery/conveyor_switch/power_change()
	..()
	update_icon()

//
// CONVEYOR CONSTRUCTION STARTS HERE
//

/obj/item/construct/conveyor
	name = "conveyor belt assembly"
	desc = "A conveyor belt assembly. Must be linked to a conveyor control switch assembly before placement."
	icon = 'icons/obj/machines/conveyor.dmi'
	icon_state = "conveyor_loose"
	w_class = ITEM_SIZE_HUGE
	var/id = "" //inherited by the belt
	matter = list(MATERIAL_STEEL = 400, MATERIAL_PLASTIC = 200)

/obj/item/construct/conveyor/attackby(obj/item/I, mob/user, params)
	..()
	if(istype(I, /obj/item/construct/conveyor_switch))
		to_chat(user, SPAN_NOTICE("You link the switch to the conveyor belt assembly."))
		var/obj/item/construct/conveyor_switch/C = I
		id = C.id

/obj/item/construct/conveyor/afterattack(atom/A, mob/user, proximity)
	if(!proximity || !istype(A, /turf/simulated/floor) || istype(A, /area/shuttle) || user.incapacitated())
		return
	var/cdir = get_dir(A, user)
	if(!(cdir in GLOB.cardinal) || A == user.loc)
		return
	for(var/obj/machinery/conveyor/CB in A)
		if(CB.dir == cdir || CB.dir == turn(cdir,180))
			return
		cdir |= CB.dir
		qdel(CB)
	var/obj/machinery/conveyor/C = new/obj/machinery/conveyor(A, cdir, id)
	transfer_fingerprints_to(C)
	qdel(src)

/obj/item/construct/conveyor_switch
	name = "conveyor switch assembly"
	desc = "A conveyor control switch assembly."
	icon = 'icons/obj/machines/conveyor.dmi'
	icon_state = "switch"
	w_class = ITEM_SIZE_HUGE
	var/id = "" //inherited by the switch
	matter = list(MATERIAL_STEEL = 200)


/obj/item/construct/conveyor_switch/New(loc, new_id)
	..(loc)
	if(new_id)
		id = new_id
	else
		id = world.time + rand() //this couldn't possibly go wrong

/obj/item/construct/conveyor_switch/afterattack(atom/A, mob/user, proximity)
	if(!proximity || !istype(A, /turf/simulated/floor) || istype(A, /area/shuttle) || user.incapacitated())
		return
	var/found = 0
	for(var/obj/machinery/conveyor/C in view())
		if(C.id == src.id)
			found = 1
			break
	if(!found)
		to_chat(user, "[icon2html(src, user)]<span class=notice>The conveyor switch did not detect any linked conveyor belts in range.</span>")
		return
	var/obj/machinery/conveyor_switch/NC = new /obj/machinery/conveyor_switch(A, id)
	transfer_fingerprints_to(NC)
	qdel(src)

/obj/machinery/conveyor/centcom_auto
	id = "round_end_belt"

/obj/machinery/conveyor_switch/oneway
	one_way = TRUE

//Other types of conveyor, mostly for saving yourself a headache during mapping
/obj/machinery/conveyor/north
	dir = NORTH

/obj/machinery/conveyor/northeast
	dir = NORTHEAST

/obj/machinery/conveyor/east
	dir = EAST

/obj/machinery/conveyor/southeast
	dir = SOUTHEAST

/obj/machinery/conveyor/south
	dir = SOUTH

/obj/machinery/conveyor/southwest
	dir = SOUTHWEST

/obj/machinery/conveyor/west
	dir = WEST

/obj/machinery/conveyor/northwest
	dir = NORTHWEST

/obj/machinery/conveyor/north/ccw
	icon_state = "conveyor_stopped_ccw"
	clockwise = FALSE

/obj/machinery/conveyor/northeast/ccw
	icon_state = "conveyor_stopped_ccw"
	clockwise = FALSE

/obj/machinery/conveyor/east/ccw
	icon_state = "conveyor_stopped_ccw"
	clockwise = FALSE

/obj/machinery/conveyor/southeast/ccw
	icon_state = "conveyor_stopped_ccw"
	clockwise = FALSE

/obj/machinery/conveyor/south/ccw
	icon_state = "conveyor_stopped_ccw"
	clockwise = FALSE

/obj/machinery/conveyor/southwest/ccw
	icon_state = "conveyor_stopped_ccw"
	clockwise = FALSE

/obj/machinery/conveyor/west/ccw
	icon_state = "conveyor_stopped_ccw"
	clockwise = FALSE

/obj/machinery/conveyor/northwest/ccw
	icon_state = "conveyor_stopped_ccw"
	clockwise = FALSE

#undef DIRECTION_FORWARDS
#undef DIRECTION_OFF
#undef DIRECTION_REVERSED

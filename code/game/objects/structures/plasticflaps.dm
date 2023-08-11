/obj/structure/plasticflaps //HOW DO YOU CALL THOSE THINGS ANYWAY
	name = "\improper plastic flaps"
	desc = "Completely impassable - or are they?"
	icon = 'icons/obj/stationobjs.dmi' //Change this.
	icon_state = "plasticflaps"
	density = FALSE
	anchored = TRUE
	layer = ABOVE_HUMAN_LAYER
	explosion_resistance = 5

	obj_flags = OBJ_FLAG_ANCHORABLE

	can_astar_pass = CANPATHINGPASS_ALWAYS_PROC

	var/list/mobs_can_pass = list(
		/mob/living/bot,
		/mob/living/carbon/slime,
		/mob/living/simple_animal/friendly/mouse,
		/mob/living/silicon/robot/drone
		)
	var/airtight = 0

/obj/structure/plasticflaps/CanPass(atom/A, turf/T)
	if(istype(A) && A.checkpass(PASS_FLAG_GLASS))
		return prob(60)

	var/obj/structure/bed/B = A
	if (istype(A, /obj/structure/bed) && B.buckled_mob)//if it's a bed/chair and someone is buckled, it will not pass
		return 0

	if(istype(A, /obj/vehicle))	//no vehicles
		return 0

	var/mob/living/M = A
	if(istype(M))
		if(M.lying)
			return ..()
		for(var/mob_type in mobs_can_pass)
			if(istype(A, mob_type))
				return ..()
		return issmall(M)

	return ..()

/obj/structure/plasticflaps/attackby(obj/item/W, mob/user)
	if(isCrowbar(W) && !anchored)
		user.visible_message(SPAN_NOTICE("\The [user] begins deconstructing \the [src]."), SPAN_NOTICE("You start deconstructing \the [src]."))
		if(user.do_skilled(3 SECONDS, SKILL_CONSTRUCTION, src))
			user.visible_message(SPAN_WARNING("\The [user] deconstructs \the [src]."), SPAN_WARNING("You deconstruct \the [src]."))
			qdel(src)
	if(isScrewdriver(W) && anchored)
		airtight = !airtight
		airtight ? become_airtight() : clear_airtight()
		user.visible_message(SPAN_WARNING("\The [user] adjusts \the [src], [airtight ? "preventing" : "allowing"] air flow."))
	else ..()

/obj/structure/plasticflaps/ex_act(severity)
	switch(severity)
		if (1)
			qdel(src)
		if (2)
			if (prob(50))
				qdel(src)
		if (3)
			if (prob(5))
				qdel(src)

/obj/structure/plasticflaps/Destroy() //lazy hack to set the turf to allow air to pass if it's a simulated floor
	clear_airtight()
	. = ..()

/obj/structure/plasticflaps/proc/become_airtight()
	var/turf/T = get_turf(loc)
	if(T)
		T.blocks_air = 1

/obj/structure/plasticflaps/proc/clear_airtight()
	var/turf/T = get_turf(loc)
	if(T)
		if(istype(T, /turf/simulated/floor))
			T.blocks_air = 0

/*
/obj/structure/plasticflaps/CanPathingPass(obj/item/card/id/ID, to_dir, atom/movable/caller, no_id = FALSE)
	if(isliving(caller))
		if(isbot(caller))
			return TRUE

		var/mob/living/living_caller = caller
		var/ventcrawler = HAS_TRAIT(living_caller, TRAIT_VENTCRAWLER_ALWAYS) || HAS_TRAIT(living_caller, TRAIT_VENTCRAWLER_NUDE)
		if(!ventcrawler && living_caller.mob_size != MOB_SIZE_TINY)
			return FALSE

	if(caller?.pulling)
		return CanAStarPass(ID, to_dir, caller.pulling, no_id = no_id)
	return TRUE //diseases, stings, etc can pass
*/

/obj/structure/plasticflaps/airtight // airtight defaults to on
	airtight = 1

/mob/living/scp173
	name = "statue"
	desc = "A statue, constructed from concrete and rebar with traces of Krylon brand spray paint."
	icon = 'icons/SCP/scp-173.dmi'
	icon_state = "173"
	status_flags = NO_ANTAG

	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7

	maxHealth = 5000
	health = 5000

	mob_size = MOB_LARGE //173 should not be able to be pulled around by humans

	can_pull_size = 0 // Can't pull things
	a_intent = "harm" // Doesn't switch places with people
	can_be_buckled = FALSE

	//Config

	/// Amount of the attack cooldown
	var/snap_cooldown_time = 4 SECONDS
	/// Amount of light fixture break cooldown
	var/light_break_cooldown_time = 3 SECONDS
	/// How much time you have to wait before defecating again
	var/defecation_cooldown_time = 45 SECONDS
	/// What kind of objects/effects we spawn on defecation. Also used when checking the area
	var/list/defecation_types = list(/obj/effect/decal/cleanable/blood/gibs/red, /obj/effect/decal/cleanable/vomit, /obj/effect/decal/cleanable/mucus)
	/// How much defecation we need to breach
	var/defication_max = 60

	/// If TRUE - 173 will automatically trigger attack when bumping a human mob
	var/bump_attack = FALSE

	/// If TRUE - we will ignore anyone looking at us
	var/ignore_vision = FALSE

	/// Movement sound, same function as with simple mobs. Remove when 173 becomes one
	var/movement_sound = null

	//AI config

	//How many tiles 173 moves in a single run of life
	var/tile_move_range = 3
	//How far wander targets can be set
	var/wander_distance = 8
	var/flee_distance = 30
	//How far we can track a target before giving up
	var/target_track_distance = 14
	//How far fleeing targets can be set. Used for pathing distance since it should be the farthest that 173's AI will ever attempt to path

	//Mechanical

	/// Reference to the area we were created in
	var/area/spawn_area
	/// List of humans under the blinking influence
	var/list/next_blinks = list()
	/// List of times at which humans joined the list (Used for HUD calculation)
	var/list/next_blinks_join_time = list()
	/// Current attack cooldown
	var/snap_cooldown
	/// Current light break cooldown
	var/light_break_cooldown
	/// Cooldown for defecation...
	var/defecation_cooldown
	/// Simple cooldown for warning message for passive breach
	var/warning_cooldown
	/// Same, but for breaching effect
	var/breach_cooldown
	/// This one to avoid sound spam when opening doors
	var/door_cooldown

	///AI Related vars

	//Our current step list (this is to avoid calling pathfinding unless neccesary)
	var/list/steps_to_target = list()
	//Target's position when pathfinding was last ran (this is also to help avoid calling pathfinding unless neccesary)
	var/turf/target_pos_last
	//AI's current target
	var/atom/movable/target

/mob/living/scp173/Initialize()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"statue", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_EUCLID, //Obj Class
		"173", //Numerical Designation
		SCP_PLAYABLE
	)

	SCP.min_playercount = 30

	defecation_cooldown = world.time + 10 MINUTES // Give everyone some time to prepare
	spawn_area = get_area(src)
	add_language(LANGUAGE_EAL, FALSE)
	add_language(LANGUAGE_SKRELLIAN, FALSE)
	add_language(LANGUAGE_GUTTER, FALSE)
	add_language(LANGUAGE_SIGN, FALSE)
	add_language(LANGUAGE_ENGLISH, FALSE)
	return ..()

/mob/living/scp173/Destroy()
	for(var/mob/living/carbon/human/H in next_blinks)
		H.disable_blink(src)
	next_blinks = null
	next_blinks_join_time = null
	clear_target()

	return ..()

/mob/living/scp173/say(message)
	return // lol you can't talk

/mob/living/scp173/Move(a,b,f)
	if(IsBeingWatched())
		return FALSE
	return ..()

/mob/living/scp173/face_atom(atom/A)
	if(IsBeingWatched())
		return FALSE
	return ..()

/mob/living/scp173/movement_delay(decl/move_intent/using_intent = move_intent)
	return -5

/mob/living/scp173/UnarmedAttack(atom/A)
	if(IsBeingWatched() || incapacitated())// We can't do anything while being watched
		return
	if(ishuman(A))
		if(snap_cooldown > world.time)
			to_chat(src, SPAN_WARNING("You can't attack yet."))
			return
		var/mob/living/carbon/human/H = A
		if(H.SCP)
			to_chat(src, SPAN_WARNING("<I>[H] is a fellow SCP!</I>"))
			return
		if(H.stat == DEAD)
			to_chat(src, SPAN_WARNING("<I>[H] is already dead!</I>"))
			return
		snap_cooldown = world.time + snap_cooldown_time
		visible_message(SPAN_DANGER("[src] snaps [H]'s neck!"))
		playsound(loc, pick('sounds/scp/spook/NeckSnap1.ogg', 'sounds/scp/spook/NeckSnap3.ogg'), 50, 1)
		show_sound_effect(loc, src)
		H.death()
		return
	if(istype(A, /obj/machinery/door))
		OpenDoor(A)
		return
	if(istype(A,/obj/machinery/floor_light))
		if(get_area(A) == spawn_area)
			to_chat(src, SPAN_WARNING("You can't reach the lights in your own containment zone."))
			return
		if(light_break_cooldown > world.time) //cooldown
			to_chat(src, SPAN_WARNING("You can't break that yet."))
			return
		var/obj/machinery/floor_light/W = A
		W.physical_attack_hand(src)
		light_break_cooldown = world.time + light_break_cooldown_time
		return
	if(istype(A,/obj/machinery/light))
		if(get_area(A) == spawn_area)
			to_chat(src, SPAN_WARNING("You can't reach the lights in your own containment zone."))
			return
		if(light_break_cooldown > world.time) //cooldown
			to_chat(src, SPAN_WARNING("You can't break that yet."))
			return
		var/obj/machinery/light/W = A
		W.broken()
		light_break_cooldown = world.time + light_break_cooldown_time
		return
	if(istype(A,/obj/structure/window))
		var/obj/structure/window/W = A
		W.shatter()
		return
	if(istype(A,/obj/structure/grille))
		playsound(get_turf(A), 'sounds/effects/grillehit.ogg', 50, 1)
		qdel(A)
		return
	if(istype(A, /obj/structure/inflatable))
		var/obj/structure/inflatable/W = A
		W.deflate(violent=1)
	if(istype(A, /obj/structure/closet))
		var/obj/structure/closet/C = A
		if(C.open())
			return
		C.dump_contents()
		QDEL_NULL(C)
	return

/mob/living/scp173/Life()
	. = ..()
	var/list/our_view = dview(9, istype(loc, /obj/structure/scp173_cage) ? loc : src) //In case we are caged, we must see if our cage is being looked at rather than us
	for(var/mob/living/carbon/human/H in next_blinks)
		if(!(H in our_view))
			H.disable_blink(src)
			next_blinks -= H
	for(var/mob/living/carbon/human/H in our_view)
		H.enable_blink(src)
		next_blinks |= H
	handle_regular_hud_updates()
	process_blink_hud(src)
	if(!isturf(loc)) // Inside of something
		return
	if(world.time > defecation_cooldown)
		Defecate()
	if(IsBeingWatched() || client) // AI controls from here
		return
	handle_AI()

/mob/living/scp173/ClimbCheck(atom/A)
	if(IsBeingWatched())
		to_chat(src, SPAN_DANGER("You can't climb while being watched."))
		return FALSE
	return TRUE

/mob/living/scp173/get_status_tab_items()
	. = ..()

	if(get_area(src) == spawn_area)
		. += "Estimated time until breach: [max(Round(((defication_max - CheckFeces()) * defecation_cooldown_time) / (60 SECONDS)), 0)] minutes."

// Remove it when 173 becomes simple animal subtype
/mob/living/scp173/DoMove(direction, mob/mover)
	var/turf/old_turf = get_turf(src)
	. = ..()
	if(. & MOVEMENT_HANDLED)
		if(movement_sound && old_turf != get_turf(src))
			playsound(src, movement_sound, 50, TRUE)

// If bump attack is enabled, we will automaticall kill humans that we bump into
/mob/living/scp173/Bump(atom/A)
	. = ..()
	if(bump_attack && ishuman(A))
		UnarmedAttack(A)

// Someone decided to put 173 into it? Good lord, it's over!
// P.S. Only humans can activate 914, so no powergaming here
/mob/living/scp173/Conversion914(mode = MODE_ONE_TO_ONE, mob/user = usr)
	log_and_message_admins("put [src] through SCP-914 on \"[mode]\" mode.", user, src)
	switch(mode)
		if(MODE_ROUGH, MODE_COARSE)
			movement_sound = null
			bump_attack = FALSE
			ignore_vision = FALSE
			snap_cooldown_time = initial(snap_cooldown_time)
			maxHealth = initial(maxHealth)
			health = clamp(health - maxHealth * 0.5, maxHealth * 0.1, maxHealth)
		if(MODE_FINE)
			playsound(src, 'sounds/effects/screech.ogg', 75, FALSE, 16)
			to_chat(src, SPAN_USERDANGER("You are feeling more powerful!"))
			movement_sound = 'sounds/scp/173/rattle.ogg'
			bump_attack = TRUE
		if(MODE_VERY_FINE) // God has abandoned you
			playsound(src, 'sounds/effects/screech2.ogg', 150, FALSE, 32)
			to_chat(src, SPAN_USERDANGER("You are unstoppable, nothing can stand on your path now!"))
			movement_sound = 'sounds/scp/173/rattle.ogg'
			bump_attack = TRUE
			ignore_vision = TRUE
			snap_cooldown_time = 0
			maxHealth = initial(maxHealth) * 10
			health = maxHealth
	return src

/mob/living/scp173/proc/IsBeingWatched()
	if(ignore_vision) // Nobody can stop us now
		return FALSE
	// Same as before, cage needs to be used as reference rather than 173
	var/atom/A = src
	if(istype(loc, /obj/structure/scp173_cage))
		A = loc
	for(var/mob/living/L in dview(9, A))
		if((istype(L, /mob/living/simple_animal/friendly/scp131)) && (InCone(L, L.dir)))
			return TRUE
		if(!istype(L, /mob/living/carbon/human))
			continue
		var/mob/living/carbon/human/H = L
		if(H.SCP)
			continue
		if(H.can_see(A))
			return TRUE
	return FALSE

/mob/living/scp173/proc/OpenDoor(obj/machinery/door/A)
	if(door_cooldown > world.time)
		return

	if(!istype(A))
		return

	if(!A.density)
		return

	if(!A.Adjacent(src))
		to_chat(src, SPAN_WARNING("\The [A] is too far away."))
		return

	var/open_time = 4 SECONDS
	if(istype(A, /obj/machinery/door/blast))
		if(get_area(A) == spawn_area)
			to_chat(src, SPAN_WARNING("You cannot open blast doors in your containment zone."))
			return
		open_time = 16 SECONDS

	if(istype(A, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/AR = A
		if(AR.locked)
			open_time += 23 SECONDS
		if(AR.welded)
			open_time += 3 SECONDS
		if(AR.secured_wires)
			open_time += 3 SECONDS

	A.visible_message(SPAN_WARNING("\The [src] begins to pry open \the [A]!"))
	playsound(get_turf(A), 'sounds/machines/airlock_creaking.ogg', 35, 1)
	door_cooldown = world.time + open_time // To avoid sound spam
	if(!do_after(src, open_time, A, bonus_percentage = 25))
		return

	if(istype(A, /obj/machinery/door/blast))
		var/obj/machinery/door/blast/DB = A
		DB.visible_message(SPAN_DANGER("\The [src] forcefully opens \the [DB]!"))
		DB.force_open()
		return

	if(istype(A, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/AR = A
		AR.unlock(TRUE) // No more bolting in the SCPs and calling it a day
		AR.welded = FALSE
	A.set_broken(TRUE)
	var/check = A.open(1)
	src.visible_message("\The [src] slices \the [A]'s controls[check ? ", ripping it open!" : ", breaking it!"]")

/mob/living/scp173/proc/Defecate()
	var/feces_amount = CheckFeces()
	if(feces_amount >= 30 && (!SCP.has_minimum_players()) && !client) //If we're lowpop we cant breach ourselves
		return
	if(!isobj(loc) && world.time > defecation_cooldown)
		defecation_cooldown = world.time + defecation_cooldown_time
		var/feces = pick(defecation_types)
		var/obj/effect/new_f = new feces(loc)
		new_f.update_icon()
	// Breach check
	if(feces_amount >= defication_max) // Breach, gonna take ~45 minutes
		if(breach_cooldown > world.time)
			return
		breach_cooldown = world.time + 15 MINUTES
		warning_cooldown = world.time + 5 MINUTES // Just in case 173 doesn't immediately leave the area
		priority_announcement.Announce("ALERT! SCP-173's containment zone security measures have shut down due to severe acidic degradation. Security personnel are to report to the location and secure the threat as soon as possible.", "Containment Failure", 'sounds/AI/173.ogg')
		BreachEffect()
	else if((feces_amount >= 40) && world.time > warning_cooldown) // Warning, after ~20 minutes
		warning_cooldown = world.time + 2 MINUTES
		priority_announcement.Announce("ATTENTION! SCP-173's containment zone is suffering from mild acidic degradation. Janitorial services involvement is required.", "Acidic Degredation", 'sounds/AI/acidic_degredation.ogg')

/mob/living/scp173/proc/CheckFeces(containment_zone = TRUE) // Proc that returns amount of 173 feces in the area
	var/area/A = get_area(src)
	if((A != spawn_area) && containment_zone) // Not in containment zone
		return 0
	var/feces_amount = 0
	for(var/obj/O in A)
		if(istype(O, /obj/effect/decal/cleanable/blood))
			var/obj/effect/decal/cleanable/blood/B = O
			if(B.amount == 0)
				continue
		if(O.type in defecation_types)
			feces_amount += 1
			continue
	return feces_amount

/mob/living/scp173/proc/BreachEffect()
	var/area/A = get_area(src)
	A.full_breach()

// 173 AI procs

/mob/living/scp173/proc/handle_AI()
	if(istype(loc, /obj/structure/scp173_cage))
		loc.relaymove(src, NORTH)
		return

	var/list/possible_human_targets = list()

	for(var/mob/living/carbon/human/H in dview(18, src)) //Identifies possible human targets. Range is double regular view to allow 173 to pursue tarets outside of world.view to make evading him harder.
		if(H.SCP || H.stat == DEAD)
			continue
		if(!LAZYLEN(get_path_to(src, H, flee_distance * 2, min_target_dist = 1)))
			continue
		possible_human_targets += H

	if(target)
		LAZYADD(possible_human_targets, target)

	if(target) //this will handle any invalid targets
		if(ishuman(target))
			var/mob/living/carbon/human/H = target
			var/turf/target_turf_current = get_turf(target)
			if(H.stat == DEAD || (get_dist(src, target) >= target_track_distance))
				clear_target()
			if(target && (target_pos_last != target_turf_current))
				steps_to_target = get_path_to(src, target_turf_current, flee_distance * 2, min_target_dist = 1)		//if our target changes positions we recalculate our path
				target_pos_last = target_turf_current
				if(!LAZYLEN(steps_to_target))
					clear_target()
		else if(istype(target, /obj/machinery/light))
			var/obj/machinery/light/L = target
			if(L.get_status() != LIGHT_OK)
				clear_target()
		else if(isturf(target))
			if((LAZYLEN(possible_human_targets)) && LAZYLEN(steps_to_target) < wander_distance) //If we get a possible target or if our wandering target is invalid and we arent currently fleeing we stop wandering and remove our wander target
				clear_target()

	if(target)
		move_to_target()
		if((get_dist(loc, get_turf(target)) > 1) || IsBeingWatched())
			return
		if(!isturf(target) && (world.time > snap_cooldown)) //If 173 has a non wander (non turf) target, and we are in range, we will attack
			if(IsBeingWatched())
				return
			face_atom(target)
			UnarmedAttack(target)
		else //Otherwise, we just wipe the target turf 173 was wandering to
			clear_target()
		return

	var/turf/our_turf = get_turf(src)

	switch(LAZYLEN(possible_human_targets))
		if(0)
			if(prob(50)) //If we have no targets, 50% chance we will choose a wander target
				assign_target(pick_turf_in_range(loc, wander_distance, list(GLOBAL_PROC_REF(isfloor))))

		if(1,2) //If we have a manageable amount of targets, we will pursue or try to break a light
			if(!is_dark(our_turf) && prob(30))
				assign_target(get_viable_light_target())
			else
				assign_target(DEFAULTPICK(possible_human_targets, null))

		if(3,INFINITY) //If we have too many targets, we will attempt to flee or break a light
			if(!is_dark(our_turf))
				if(prob(60))
					var/while_timeout = world.time + 1 SECONDS //prevent infinity loops

					while(!target)
						assign_target(pick_turf_in_range(loc, flee_distance, list(GLOBAL_PROC_REF(isfloor))))
						if(world.time > while_timeout)
							break
				else
					assign_target(get_viable_light_target())
			else
				assign_target(DEFAULTPICK(possible_human_targets, null))

	move_to_target()

/mob/living/scp173/proc/assign_target(atom/movable/new_target) //Assigns a new target for 173
	clear_target()

	if(!new_target)
		return FALSE

	var/list/temp_steps_to_target = get_path_to(src, new_target, flee_distance * 2, min_target_dist = 1)
	if(LAZYLEN(temp_steps_to_target)) //Double check to ensure that whatever target we assign we can actually get to
		steps_to_target = temp_steps_to_target
		target = new_target
		target_pos_last = get_turf(new_target)
		return TRUE

/mob/living/scp173/proc/clear_target()
	target = null
	target_pos_last = null
	LAZYCLEARLIST(steps_to_target)

/mob/living/scp173/proc/move_to_target() //Moves 173 towards the target using steps list and also deals with any obstacles
	if(!target || !LAZYLEN(steps_to_target))
		clear_target()
		return

	var/turf/step_turf = steps_to_target[1]

	for(var/obj/obstacle in step_turf.contents) //we will handle any obstacles, if there are any, instead of moving
		if(istype(obstacle, /obj/machinery/door))
			var/obj/machinery/door/D = obstacle
			if(!D.density)
				continue
			if((get_area(D) == spawn_area) && (istype(D, /obj/machinery/door/blast)))
				continue
			UnarmedAttack(D)
			return
		else if(obstacle.can_climb(src)) //If we can climb it, we should
			obstacle.do_climb(src)
			return
		else if(istype(obstacle, /obj/structure/window) || istype(obstacle, /obj/structure/grille))
			UnarmedAttack(obstacle)
			return

	for(var/move=0, move < tile_move_range, move++)
		if(!steps_to_target)
			break
		step_turf = steps_to_target[1]
		step_towards(src, step_turf)
		if(get_turf(src) != step_turf) //if for whatever reason we are unable to move to the next turf, we stop
			if(step_turf.contains_dense_objects_whitelist(list(/obj/machinery/door, /obj/structure/window, /obj/structure/grille)) || get_area(step_turf) == spawn_area) //if we are blocked by something we cant break, we clear our target
				clear_target()
			break
		else
			LAZYREMOVE(steps_to_target, step_turf)

/mob/living/scp173/proc/get_viable_light_target() //Gets a viable light bulb target
	for(var/obj/machinery/light/light_in_view in dview(9, src))
		if(get_area(light_in_view) == spawn_area)
			continue
		if(light_in_view.get_status() != LIGHT_OK)
			continue
		if(!get_path_to(src, light_in_view, wander_distance))
			continue
		return light_in_view
	return null

// 173 Cage

/obj/structure/scp173_cage
	name = "SCP-173 Containment Cage"
	desc = "An empty cage for containing SCP-173."
	icon = 'icons/SCP/cage.dmi'
	icon_state = "open"
	density = TRUE
	layer = MOB_LAYER + 0.05
	var/resist_cooldown
	/// Current damage points of the cage
	var/damage_state = 0
	/// Maximum damage points, upon which cage becomes unusable and 173, if inside, escapes
	var/damage_state_max = 5

/obj/structure/scp173_cage/MouseDrop_T(atom/movable/dropping, mob/user) // When someone drags 173 onto the cage
	if(locate(/mob/living) in contents)
		to_chat(user, SPAN_WARNING("\The [src] is already full!"))
		return FALSE
	if(damage_state >= damage_state_max)
		to_chat(user, SPAN_WARNING("\The [src] is too damaged to operate!"))
		return FALSE
	if(isscp173(dropping))
		visible_message(SPAN_WARNING("[user] starts to put [dropping] into the cage."))
		var/oloc = loc
		if(do_after(user, 13 SECONDS, dropping, bonus_percentage = 25) && loc == oloc)
			dropping.forceMove(src)
			update_icon()
			visible_message(SPAN_NOTICE("[user] puts [dropping] in the cage."))
			playsound(loc, 'sounds/machines/bolts_down.ogg', 50, 1)
			return TRUE
		return FALSE
	if(isliving(dropping))
		to_chat(user, SPAN_WARNING("\The [dropping] won't fit in the cage."))
	return FALSE

/obj/structure/scp173_cage/attack_hand(mob/living/L)
	if(!LAZYLEN(contents))
		return ..()
	visible_message(SPAN_WARNING("[L] attempts to open \the [src]."))
	if(do_after(L, 7 SECONDS, src, bonus_percentage = 25))
		visible_message(SPAN_DANGER("[L] opens \the [src]!"))
		ReleaseContents()

/obj/structure/scp173_cage/relaymove(mob/living/scp173/user, direction)
	if(resist_cooldown > world.time)
		return
	if(user.IsBeingWatched())
		to_chat(user, SPAN_WARNING("Someone is looking at you!"))
		return
	resist_cooldown = world.time + 5 SECONDS
	if(!do_after(user, 1 SECOND, src, DO_BOTH_CAN_MOVE|DO_DEFAULT, bonus_percentage = 100)) // Some moron suggested putting 173 in a conveyor loop.
		return
	if(user.IsBeingWatched())
		to_chat(user, SPAN_WARNING("Someone is looking at you!"))
		return
	damage_state += 1
	update_icon()
	if(damage_state < damage_state_max)
		visible_message(SPAN_WARNING("[user] damages \the [src]!"))
		playsound(src, 'sounds/effects/grillehit.ogg', 35, TRUE)
		return
	visible_message(SPAN_DANGER("[user] opens \the [src] from the inside!"))
	ReleaseContents()

/obj/structure/scp173_cage/examine(mob/user, distance, infix = "", suffix = "")
	. = ..()
	for(var/mob/M in contents)
		to_chat(user, "[icon2html(M, user)] It has [M] inside of it!")
	switch(damage_state)
		if(1, 2)
			to_chat(user, SPAN_NOTICE("It looks slightly damaged."))
		if(3, 4)
			to_chat(user, SPAN_WARNING("It is seriously damaged!"))
		if(5 to INFINITY)
			to_chat(user, SPAN_DANGER("It is completely broken!"))

// Updates icon state and underlays
/obj/structure/scp173_cage/update_icon()
	underlays.Cut()

	if(!LAZYLEN(contents))
		plane = initial(plane)
		icon_state = "open"
	else
		plane = MOB_PLANE
		icon_state = "closed"

	switch(damage_state)
		if(1, 2)
			icon_state = "damage_1"
		if(3, 4)
			icon_state = "damage_2"
		if(5 to INFINITY)
			icon_state = "damage_3"

	for(var/mob/M in contents)
		underlays += image(M)

/obj/structure/scp173_cage/attackby(obj/item/I, mob/user) //Gotta be able to repair the cage
	if(!isWelder(I))
		return
	if(LAZYLEN(contents))
		to_chat(user, SPAN_WARNING("\The [src] must be empty to complete this task!"))
		return
	if(damage_state <= 0)
		to_chat(user, SPAN_NOTICE("\The [src] is not damaged."))
		return

	var/obj/item/weldingtool/WT = I
	if(!WT.isOn())
		to_chat(user, SPAN_WARNING("\The [WT] must be on to complete this task."))
		return
	if(WT.get_fuel() < damage_state)
		to_chat(user, SPAN_WARNING("You will need more fuel to repair [src]."))
		return
	playsound(src, 'sounds/items/Welder2.ogg', 30, TRUE)
	user.visible_message(SPAN_NOTICE("\The [user] starts repairing sections of \the [src]."))
	if(!do_after(user, (6 SECONDS + damage_state SECONDS), src, bonus_percentage = 25))
		return FALSE
	if(!WT.remove_fuel(damage_state, user))
		return
	user.visible_message(SPAN_NOTICE("\The [user] successfuly repairs a section of \the [src]."))
	damage_state -= 1
	update_icon()
	if(damage_state <= 0)
		visible_message(SPAN_NOTICE("\The [src] is completely repaired!"))
	playsound(src.loc, 'sounds/items/Welder.ogg', 30, 1)
	return TRUE

/obj/structure/scp173_cage/proc/ReleaseContents() //Releases cage contents
	if(!LAZYLEN(contents))
		return FALSE
	playsound(loc, 'sounds/machines/bolts_up.ogg', 50, 1)
	for(var/mob/living/L in contents)
		L.forceMove(get_turf(src))
	update_icon()
	return TRUE

/obj/structure/scp173_cage/Destroy()
	ReleaseContents()
	return ..()

/*
 * Acid
 */
 #define ACID_STRONG     2
 #define ACID_MODERATE   1.5
 #define ACID_WEAK       1

/obj/effect/acid
	name = "acid"
	desc = "Burbling corrosive stuff. Probably a bad idea to roll around in it."
	icon_state = "acid"
	icon = 'icons/mob/alien.dmi'

	density = FALSE
	opacity = 0
	anchored = TRUE

	var/atom/target
	var/acid_strength = ACID_WEAK
	var/melt_time = 60 SECONDS
	var/last_melt = 0

/obj/effect/acid/Initialize(loc, supplied_target)
	..(loc)
	target = supplied_target
	melt_time = melt_time / acid_strength
	START_PROCESSING(SSprocessing, src)

/obj/effect/acid/Destroy()
	STOP_PROCESSING(SSprocessing, src)
	target = null
	. = ..()

/obj/effect/acid/Process()
	if(QDELETED(target))
		qdel(src)
	else if(world.time > last_melt + melt_time)
		var/done_melt = target.acid_melt()
		last_melt = world.time
		if(done_melt)
			qdel(src)

/atom/var/acid_melted = 0

/atom/proc/acid_melt()
	. = FALSE
	switch(acid_melted)
		if(0)
			visible_message(SPAN_CLASS("euclid","Acid hits \the [src] with a sizzle!"))
		if(1 to 3)
			visible_message(SPAN_CLASS("euclid","The acid melts \the [src]!"))
		if(4)
			visible_message(SPAN_CLASS("euclid","The acid melts \the [src] away into nothing!"))
			. = TRUE
			qdel(src)
	acid_melted++

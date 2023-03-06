GLOBAL_LIST_EMPTY(scp173s)

/datum/scp/scp_173
	name = "SCP-173"
	designation = "173"
	classification = EUCLID

/mob/living/scp_173
	name = "SCP-173"
	desc = "A statue, constructed from concrete and rebar with traces of Krylon brand spray paint."
	icon = 'icons/SCP/scp-173.dmi'
	icon_state = "173"
	SCP = /datum/scp/scp_173
	status_flags = NO_ANTAG

	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7

	maxHealth = 5000
	health = 5000

	can_pull_size = 0 // Can't pull things
	a_intent = "harm" // Doesn't switch places with people
	can_be_buckled = FALSE

	/// Reference to the area we were created in
	var/area/spawn_area

	/// List of humans under the blinking influence
	var/list/next_blinks = list()
	/// List of times at which humans joined the list (Used for HUD calculation)
	var/list/next_blinks_join_time = list()

	/// Current attack cooldown
	var/snap_cooldown
	/// Amount of the attack cooldown
	var/snap_cooldown_time = 4 SECONDS
	/// Current light break cooldown
	var/light_break_cooldown
	/// Amount of light fixture break cooldown
	var/light_break_cooldown_time = 3 SECONDS
	/// Maximium light level at which blink cooldown can start to drop off (value between 0 and 1)
	var/max_lightlevel = 0.5
	/// Cooldown for defecation...
	var/defecation_cooldown
	/// How much time you have to wait before defecating again
	var/defecation_cooldown_time = 60 SECONDS
	/// What kind of objects/effects we spawn on defecation. Also used when checking the area
	var/list/defecation_types = list(/obj/effect/decal/cleanable/blood/gibs/red, /obj/effect/decal/cleanable/vomit, /obj/effect/decal/cleanable/mucus)

	/// Simple cooldown for warning message for passive breach
	var/warning_cooldown
	/// Same, but for breaching effect
	var/breach_cooldown

	/// This one to avoid sound spam when opening doors
	var/door_cooldown

	/// Is 173 caged?
	var/is_caged = FALSE
	/// 173's current cage.
	var/obj/structure/scp173_cage/cage

/mob/living/scp_173/Initialize()
	GLOB.scp173s += src
	defecation_cooldown = world.time + 15 MINUTES // Give everyone some time to prepare
	spawn_area = get_area(src)
	add_language(LANGUAGE_EAL, FALSE)
	add_language(LANGUAGE_SKRELLIAN, FALSE)
	add_language(LANGUAGE_GUTTER, FALSE)
	add_language(LANGUAGE_SIGN, FALSE)
	add_language(LANGUAGE_ENGLISH, FALSE)
	return ..()

/mob/living/scp_173/Destroy()
	next_blinks = null
	next_blinks_join_time = null

	GLOB.scp173s -= src
	return ..()

/mob/living/scp_173/say(message)
	return // lol you can't talk

/mob/living/scp_173/Move(a,b,f)
	if(IsBeingWatched())
		return FALSE
	return ..()

/mob/living/scp_173/face_atom(atom/A)
	if(IsBeingWatched())
		return FALSE
	return ..()

/mob/living/scp_173/movement_delay()
	return -5

/mob/living/scp_173/UnarmedAttack(atom/A)
	if(is_caged) // We can't do anything while caged
		if(!IsBeingWatched() && istype(A, /obj/structure/scp173_cage)) //Can only attack the cage when not being watched and inside the cage
			if(snap_cooldown <= world.time)
				var/obj/structure/scp173_cage/cage = A
				cage.attack_hand(src)
				snap_cooldown = world.time + snap_cooldown_time
				to_chat(src, SPAN_WARNING("You damage the cage."))
			else
				to_chat(src, SPAN_WARNING("You can't attack yet."))
		else if(IsBeingWatched() && istype(A, /obj/structure/scp173_cage))
			to_chat(src, SPAN_WARNING("You can't attack the cage while they're looking!"))
		else
			return
	if(IsBeingWatched() || incapacitated())// We can't do anything while being watched
		return
	if(ishuman(A))
		if(snap_cooldown > world.time)
			to_chat(src, SPAN_WARNING("You can't attack yet."))
			return
		var/mob/living/carbon/human/H = A
		if(H.SCP)
			to_chat(src, SPAN_WARNING(SPAN_ITALIC("[H] is a fellow SCP!")))
			return
		if(H.stat == DEAD)
			to_chat(src, SPAN_WARNING(SPAN_ITALIC("[H] is already dead!")))
			return
		snap_cooldown = world.time + snap_cooldown_time
		visible_message(SPAN_DANGER("[src] snaps [H]'s neck!"))
		playsound(loc, pick('sound/scp/spook/NeckSnap1.ogg', 'sound/scp/spook/NeckSnap3.ogg'), 50, 1)
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
		playsound(get_turf(A), 'sound/effects/grillehit.ogg', 50, 1)
		qdel(A)
		return
	if(istype(A, /obj/structure/inflatable))
		var/obj/structure/inflatable/W = A
		W.deflate(violent=1)
	return

/mob/living/scp_173/Life()
	. = ..()
	if(length(GLOB.clients) <= 30 && !client)
		return
	var/list/our_view = view(7, is_caged ? cage : src)//In case we are caged, we must see if our cage is being looked at rather than us
	for(var/A in next_blinks)
		if(!(A in our_view))
			DisableBlinking(A)
			continue
		var/mob/living/carbon/human/H = A
		if(world.time >= next_blinks[H])
			if(H.stat) // Sleeping or dead people can't blink!
				DisableBlinking(H)
				continue
			CauseBlink(H)
		BITSET(H.hud_updateflag, BLINK_HUD)
	handle_regular_hud_updates()
	process_blink_hud(src)
	if(is_caged)
		return
	if(world.time > defecation_cooldown)
		Defecate()
	if(IsBeingWatched() || client) // AI controls from here
		return
	if(world.time > snap_cooldown)
		AIAttemptAttack()

/mob/living/scp_173/ClimbCheck(atom/A)
	if(IsBeingWatched())
		to_chat(src, SPAN_DANGER("You can't climb while being watched."))
		return FALSE
	return TRUE

/mob/living/scp_173/proc/IsBeingWatched()
	for(var/mob/living/L in view(7, is_caged ? cage : src)) //same as before, cage needs to be used as reference rather than 173
		if((istype(L, /mob/living/simple_animal/scp_131)) && (InCone(L, L.dir)))
			return TRUE
		if(!istype(L, /mob/living/carbon/human))
			continue
		var/mob/living/carbon/human/H = L
		if(next_blinks[H] == null)
			BITSET(H.hud_updateflag, BLINK_HUD) //Ensures HUD appears before first blink
			var/turf/T = get_turf(src)
			var/lightcount = T.get_lumcount()
			if(lightcount > max_lightlevel)
				lightcount = 1 //Light level must be less than max_lightlevel before blink time drop off
			next_blinks[H] = world.time + (rand(5 SECONDS, 10 SECONDS) * lightcount) // Just encountered SCP 173
			next_blinks_join_time[H] = world.time
		if(H.SCP)
			continue
		if(is_blind(H) || H.eye_blind > 0)
			continue
		if(H.stat != CONSCIOUS)
			continue
		if(InCone(H, H.dir))
			return TRUE
	return FALSE

/mob/living/scp_173/proc/OpenDoor(obj/machinery/door/A)
	if(door_cooldown > world.time)
		return

	if(!istype(A))
		return

	if(!A.density)
		return

	if(!A.Adjacent(src))
		to_chat(src, SPAN_WARNING("\The [A] is too far away."))
		return

	var/open_time = 3 SECONDS
	if(istype(A, /obj/machinery/door/blast))
		if(get_area(A) == spawn_area)
			to_chat(src, SPAN_WARNING("You cannot open blast doors in your containment zone."))
			return
		open_time = 15 SECONDS

	if(istype(A, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/AR = A
		if(AR.locked)
			open_time += 2 SECONDS
		if(AR.welded)
			open_time += 2 SECONDS
		if(AR.secured_wires)
			open_time += 2 SECONDS

	A.visible_message(SPAN_WARNING("\The [src] begins to pry open \the [A]!"))
	playsound(get_turf(A), 'sound/machines/airlock_creaking.ogg', 35, 1)
	door_cooldown = world.time + open_time // To avoid sound spam
	if(!do_after(src, open_time, A))
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
	A.stat |= BROKEN
	var/check = A.open(1)
	src.visible_message("\The [src] slices \the [A]'s controls[check ? ", ripping it open!" : ", breaking it!"]")

/mob/living/scp_173/proc/DisableBlinking(mob/living/carbon/human/H)
	next_blinks[H] = null
	next_blinks_join_time[H] = null
	for(var/mob/living/scp_173/S in GLOB.scp173s) // In case you spawned more than one
		if(S.next_blinks[H]) // Not null
			return
	remove_verb(H, /mob/living/carbon/human/verb/manual_blink)

/mob/living/scp_173/proc/CauseBlink(mob/living/carbon/human/H)
	H.visible_message(SPAN_NOTICE("[H] blinks."))
	H.eye_blind += 2
	BITSET(H.hud_updateflag, BLINK_HUD)
	add_verb(H, /mob/living/carbon/human/verb/manual_blink)
	var/turf/T = get_turf(src)
	var/lightcount = T.get_lumcount()
	if(lightcount > max_lightlevel)
		lightcount = 1 //Light level must be less than max_lightlevel before blink time drop off
	next_blinks[H] = world.time + (rand(15 SECONDS, 25 SECONDS) * lightcount)
	next_blinks_join_time[H] = world.time

/mob/living/scp_173/proc/AIAttemptAttack()
	var/mob/living/carbon/human/target
	var/list/possible_targets = list()
	var/turf/T
	for(var/mob/living/carbon/human/H in view(7, src))
		if(H.SCP)
			continue
		if(H.stat == DEAD)
			continue
		if(!AStar(loc, H.loc, /turf/proc/AdjacentTurfs, /turf/proc/Distance, max_nodes=25, max_node_depth=7))
			continue // We can't reach this person anyways
		possible_targets += H
	if(LAZYLEN(possible_targets))
		target = pick(possible_targets)
	if(target)
		var/turf/behind_target = get_step(target.loc, turn(target.dir, 180))
		if(isfloor(behind_target) && get_dist(behind_target, loc) <= 7)
			T = behind_target
		else
			var/list/directions = shuffle(GLOB.cardinal)
			for(var/D in directions)
				var/turf/TF = get_step(target, D)
				if(isfloor(T) && get_dist(T, loc) <= 7)
					T = TF
					break
		if(!T) // We couldn't find a spot to go to!
			return
		forceMove(T)
		UnarmedAttack(target)

/mob/living/scp_173/proc/Defecate()
	if(!isobj(loc) && world.time > defecation_cooldown)
		defecation_cooldown = world.time + defecation_cooldown_time
		var/feces = pick(defecation_types)
		var/obj/effect/new_f = new feces(loc)
		new_f.update_icon()
		if(!client) // So it doesn't spam it in one spot
			var/Tdir = pick(NORTH, SOUTH, EAST, WEST, NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST)
			if(Tdir && !IsBeingWatched())
				SelfMove(Tdir)
	// Breach check
	var/feces_amount = CheckFeces()
	if(feces_amount >= 60) // Breach, gonna take ~60 minutes
		if(breach_cooldown > world.time)
			return
		breach_cooldown = world.time + 25 MINUTES
		warning_cooldown = world.time + 5 MINUTES // Just in case 173 doesn't immediately leave the area
		command_announcement.Announce("ALERT! SCP-173 containment zone security measures have shut down due to severe acidic degradation.")
		BreachEffect()
	else if((feces_amount >= 40) && world.time > warning_cooldown) // Warning, after ~20 minutes
		warning_cooldown = world.time + 2 MINUTES
		command_announcement.Announce("ATTENTION! SCP-173 containment zone is suffering from mild acidic degradation. Janitorial services involvement is required.")

/mob/living/scp_173/proc/CheckFeces(containment_zone = TRUE) // Proc that returns amount of 173 feces in the area
	var/area/A = get_area(src)
	if((A != spawn_area) && containment_zone) // Not in containment zone
		return 0
	var/feces_amount = 0
	for(var/obj/O in A)
		if(O.type in defecation_types)
			feces_amount += 1
			continue
	return feces_amount

/mob/living/scp_173/proc/BreachEffect()
	var/area/A = get_area(src)
	A.full_breach()

//
// 173 Cage
//

/obj/structure/scp173_cage
	icon = 'icons/SCP/cage.dmi'
	icon_state = "open"
	name = "SCP-173 Containment Cage"
	desc = "An empty cage for containing SCP-173."
	density = TRUE
	layer = MOB_LAYER + 0.05
	plane = OBJ_PLANE
	// Max damage state before breaking out
	var/damage_max = 5
	// Damage state of cage
	var/damage_state = 0
	// Currently held 173
	var/mob/living/scp_173/S


/obj/structure/scp173_cage/MouseDrop_T(atom/movable/dropping, mob/user) // When someone drags 173 onto the cage
	if(damage_state < damage_max)
		if(isscp173(dropping))
			visible_message(SPAN_WARNING("[user] starts to put [dropping] into the cage."))
			var/oloc = loc
			if(do_after(user, 10 SECONDS, S) && loc == oloc)
				plane = MOB_PLANE
				S = dropping
				S.forceMove(src)
				S.is_caged = TRUE
				S.cage = src
				updateIconandDesc()
				visible_message(SPAN_NOTICE("[user] puts [S] in the cage."))
				playsound(loc, 'sound/machines/bolts_down.ogg', 50, 1)
				return TRUE
			return FALSE
		if(isliving(dropping))
			to_chat(user, SPAN_WARNING("\The [dropping] won't fit in the cage."))
		return FALSE
	else
		visible_message(SPAN_WARNING("\The [src] is too damaged to operate!"))

/obj/structure/scp173_cage/attack_hand(mob/living/A) //If either a human or 173 interact with the cage
	if(!LAZYLEN(contents))
		return ..()
	if(ishuman(A))
		if(damage_state < damage_max)
			var/mob/living/carbon/human/H = A
			visible_message(SPAN_WARNING("[H] attempts to open \the [src]."))
			if(do_after(H, 5 SECONDS, src))
				visible_message(SPAN_DANGER("[H] opens \the [src]!"))
				ReleaseContents()
		else
			visible_message(SPAN_WARNING("\The [src] is too damaged to operate!"))
	else if(isscp173(A)) //Neccesary 173 checks are done from 173's side, not the cage's
		var/mob/living/scp_173/S = A
		playsound(loc, 'sound/machines/airlock_creaking.ogg', 50, 1)
		if(damage_state < damage_max)
			visible_message(SPAN_WARNING("You hear the sound of metal [pick("groaning","shearing","tearing","bending")]!"))
			damage_state += 1
			updateIconandDesc()
		else
			visible_message(SPAN_DANGER("[S] bends open \the [src]!"))
			damage_state = damage_max + 1
			ReleaseContents()

/obj/structure/scp173_cage/proc/updateIconandDesc() //Updates cage icon and description according to current damage state and contents
	underlays.Cut()

	if(damage_state == 0 && ((!LAZYLEN(contents)) || !S))
		icon_state = "open"
		desc = initial(desc)
	else if(damage_state == 0)
		icon_state = "closed"
		desc = "A cage for containing SCP-173. It is currently holding [S]."
	else if(damage_state <= 1)
		icon_state = "damage_1"
		desc = "A cage for containing SCP-173. It is currently holding [S]. It looks slightly damaged."
	else if((damage_state >= Clamp((damage_max - 1), 2, INFINITY)) && (damage_state <= damage_max)) //Dont want the damage visuals getting fucky because damage_max was too low
		icon_state = "damage_2"
		desc = "A cage for containing SCP-173. It is currently holding [S]. It looks fairly damaged."
	else if(damage_state > damage_max) //Damage state is equal to damage max last stage before breaking, so this is neccesary
		icon_state = "damage_3"
		desc = "An empty cage for containing SCP-173. It appears broken."

	if((LAZYLEN(contents)) && S)
		underlays += image(S)


/obj/structure/scp173_cage/attackby(obj/item/I, mob/user) //Gotta be able to repair the cage
	if(user.a_intent == I_HELP)
		if(isWelder(I))
			var/obj/item/weldingtool/WT = I
			if(damage_state == 0)
				to_chat(user, SPAN_NOTICE("\The [src] is not damaged."))
				return
			if(!WT.remove_fuel(0, user))
				to_chat(user, SPAN_WARNING("\The [I] must be on to complete this task."))
				return
			playsound(src.loc, 'sound/items/Welder.ogg', 50, 1)
			if(!do_after(user, (5 * damage_state), src)) //Time to repair depends on how damaged the cage is
				return
			if(!src || !WT.isOn())
				return
			visible_message(SPAN_NOTICE("\The [user] has repaired \the [src]."))
			icon_state = "open"
			damage_state = 0
			return 1
	return 0

/obj/structure/scp173_cage/proc/ReleaseContents() //Releases cage contents
	if(!LAZYLEN(contents))
		return FALSE
	if(damage_state < damage_max) //Dont want the release sound to play if 173 breaks out
		playsound(loc, 'sound/machines/bolts_up.ogg', 50, 1)
	for(var/mob/living/scp_173/L in contents)
		L.forceMove(get_turf(src))
		L?.is_caged = FALSE
		L?.cage = null
	plane = initial(plane)
	updateIconandDesc()
	return TRUE

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
			visible_message(SPAN_WARNING("Acid hits \the [src] with a sizzle!"))
		if(1 to 3)
			visible_message(SPAN_WARNING("The acid melts \the [src]!"))
		if(4)
			visible_message(SPAN_WARNING("The acid melts \the [src] away into nothing!"))
			. = TRUE
			qdel(src)
	acid_melted++

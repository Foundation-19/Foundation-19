//todo: clean this the hell up oh my god is this terrible
GLOBAL_LIST_EMPTY(scp106s)
GLOBAL_LIST_EMPTY(scp106_spawnpoints)

/mob/living/carbon/human/scp106
	desc = "A rotting, elderly old man."
	SCP = /datum/scp/scp_106
	var/mob/living/target = null
	var/last_x = -1
	var/last_y = -1
	var/last_z = -1
	var/confusing = FALSE
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7
	icon = 'icons/mob/scp106.dmi'
	icon_state = null

/mob/living/carbon/human/scp106/examine(mob/user)
	to_chat(user, "<b><span class = 'keter'><big>SCP-106</big></span></b> - [desc]")

/datum/scp/scp_106
	name = "SCP-106"
	designation = "106"
	classification = KETER

/mob/living/carbon/human/scp106/IsAdvancedToolUser()
	return FALSE

/mob/living/carbon/human/scp106/Initialize()
	. = ..()

	GLOB.moved_event.register(src, src, /mob/living/carbon/human/scp106/proc/update_stuff_PD)

	// fix names
	fully_replace_character_name("SCP-106")

	verbs += /mob/living/carbon/human/scp106/proc/phase_through_airlock
	if (!(loc in GLOB.scp106_floors))
		verbs += /mob/living/carbon/human/scp106/proc/enter_pocket_dimension

	verbs += /mob/living/carbon/human/scp106/proc/confuse_victims

	set_species("SCP-106")
	GLOB.scp106s |= src

/mob/living/carbon/human/scp106/Destroy()
	GLOB.scp106s -= src
	..()


/mob/living/carbon/human/scp106/proc/update_stuff_PD()

	if (loc in GLOB.scp106_floors)
		species.brute_mod = 0.1
		species.burn_mod = 0.1
	else
		species.brute_mod = 0.5
		species.burn_mod = 0.5


/mob/living/carbon/human/scp106/update_icons()
	return

/mob/living/carbon/human/scp106/get_pressure_weakness()
	return 0

/mob/living/carbon/human/scp106/handle_breath()
	return 1

/mob/living/carbon/human/scp106/movement_delay()
	return 2.0

/mob/living/carbon/human/scp106/say(var/message, var/datum/language/speaking = null, whispering)
	src << "<span class = 'notice'>You cannot speak.</span>"
	return 0

/mob/living/carbon/human/scp106/attack_hand(var/mob/living/L)
	if (L == src)
		return ..(L)
	visible_message("<span class = 'danger'>[L] is warped away!</span>")
	L.forceMove(pick(GLOB.scp106_floors))

/mob/living/carbon/human/scp106/on_update_icon()
	if (lying || resting)
		var/matrix/M =  matrix()
		transform = M.Turn(90)
	else
		transform = null
	return

/mob/living/carbon/human/scp106/Life()
	. = ..()

	// update confusing stuff
	if (stat == CONSCIOUS)
		if (confusing)
			for (var/client in GLOB.clients)
				var/client/C = client
				if (ishuman(C.mob) && !isscp106(C.mob))
					var/mob/living/carbon/human/H = C.mob
					if (H.stat == CONSCIOUS && (get_area(H) == get_area(GLOB.scp106_floors[1]) == get_area(src)))
						C.dir = turn(NORTH, pick(-90, -180, -270))
					else
						C.dir = NORTH
				else
					C.dir = NORTH
	else
		if (confusing)
			confusing = FALSE
			for (var/client in GLOB.clients)
				var/client/C = client
				C.dir = NORTH

// NPC stuff
/mob/living/carbon/human/scp106/proc/getTarget()

	// stupid hack
	if (client)
		target = null
		return target

	/* if we have no target, or our target is dead, or our target is a nonhuman, or our target is out of view,
	 * try to find a better one. Failing to do so just makes us continue to go after the old target */
	if (!target || target.stat == DEAD || !ishuman(target) || !(src in viewers(world.view, target)))

		var/list/possible_targets = list()
		for (var/mob/living/L in oview(world.view, src))
			if (L.stat != DEAD)
				possible_targets += L

		var/attempts = 0
		while (++attempts <= 3)
			for (var/living in possible_targets)
				var/mob/living/L = living
				switch (attempts)
					if (1)
						// pick the best target, a human in our prefered age range
						if (ishuman(L))
							var/mob/living/carbon/human/H = L
							if (H.age >= 10 && H.age <= 25)
								target = H
								return target
					if (2)
						// pick any human target
						if (ishuman(L))
							target = L
							return target
					if (3)
						// pick any target
						target = L
						return target
	return target

/mob/living/carbon/human/scp106/proc/pursueTarget()

	getTarget()

	if (!target)
		walk(src, null)
		return FALSE

	if (!(target in orange(1, src)))
		// moves slightly faster than humans
		walk_to(src, target, 1/*, 0+config.run_speed*/)
		return TRUE

	walk(src, null)

	if (!locate(/obj/item/grab) in src)
		scp106_attack(target)

	return TRUE

/mob/living/carbon/human/scp106/proc/scp106_attack(var/mob/living/target)
	var/obj/item/grab/G = locate() in src
	if (!G)
		visible_message("<span class = 'danger'><i>[name] reaches towards [target]!</i></danger>")
		G = make_grab(src, target)

		if (!(loc in GLOB.scp106_floors))
			if (G)
				G.upgrade(TRUE)
		else
			if (G)
				G.affecting = TRUE

		target.Weaken(1)
		// NPC stuff
		if (!client)
			spawn (20)
				if (G && !G.affecting)
					G.last_upgrade = -1
					G.upgrade(FALSE)

/mob/living/carbon/human/attack_hand(mob/living/carbon/M)
	if (!isscp106(M))
		return ..(M)
	var/mob/living/carbon/human/scp106/H = M
	if (isscp049(src))
		H << "<span class = \"danger\">You cannot attack SCP-049.</span>"
	else
		H.scp106_attack(src)

/mob/living/carbon/human/scp106/proc/set_last_xyz()
	last_x = x
	last_y = y
	last_z = z

/mob/living/carbon/human/scp106/proc/go_back()
	set name = "Return"
	set category = "SCP"
	set desc = "Return to the area you last teleported from."
	if (last_x != -1) // shouldn't be possible but just in case
		forceMove(locate(last_x, last_y, last_z))
	verbs -= /mob/living/carbon/human/scp106/proc/go_back
	verbs += /mob/living/carbon/human/scp106/proc/enter_pocket_dimension

#define PHASE_TIME (2 SECONDS)
/mob/living/carbon/human/scp106/var/phase_cooldown = -1
/mob/living/carbon/human/scp106/proc/phase_through_airlock()
	set name = "Phase Through Object"
	set category = "SCP"
	set desc = "Phase through an object in front of you."

	if (world.time < phase_cooldown)
		to_chat(src, "<span class = 'warning'>You can't phase again yet.</span>")
		return

	for (var/obj/O in get_step(src, dir))

		if (!isstructure(O) && !ismachinery(O))
			continue

		if (istype(O, /obj/machinery/door/airlock/vault))
			continue

		if (istype(O, /obj/machinery/camera))
			continue

		if (istype(O, /obj/machinery/shieldwall) || istype(O, /obj/machinery/shieldwallgen))
			continue

		if (istype(O, /obj/structure/cable))
			continue

		if (istype(O, /obj/structure/catwalk))
			continue

		if (istype(O, /obj/machinery/light))
			continue

		if (istype(O, /obj/machinery/power/apc))
			continue

		if (istype(O, /obj/machinery/button))
			continue

		if (istype(O, /obj/machinery/power/terminal))
			continue

		for (var/obj/OO in get_turf(O))
			if (OO.density && OO != O)
				return

		var/turf/target = get_step(O, dir)
		if (target.density)
			return

		visible_message("<span class = 'danger'>[src] starts to phase through \the [O].</span>")



		alpha = 128

		phase_cooldown = world.time + PHASE_TIME + 0.5 SECONDS

		layer = OBSERVER_LAYER

		switch(dir)
			if (NORTH, NORTHEAST, NORTHWEST)
				animate(src, pixel_y = 58, time = PHASE_TIME)
			if (SOUTH, SOUTHEAST, SOUTHWEST)
				animate(src, pixel_y = -58, time = PHASE_TIME)
			if (EAST)
				animate(src, pixel_x = 58, time = PHASE_TIME)
			if (WEST)
				animate(src, pixel_x = -58, time = PHASE_TIME)

		if (do_after(src, PHASE_TIME, O))
			forceMove(get_step(src, dir))
			visible_message("<span class = 'danger'>[src] phases through \the [O].</span>")

		alpha = 255

		layer = MOB_LAYER + 0.1
		pixel_x = 0
		pixel_y = 0

		break
#undef PHASE_TIME

/mob/living/carbon/human/scp106/proc/enter_pocket_dimension()
	set name = "Enter Pocket Dimension"
	set category = "SCP"
	set desc = "Enter your pocket dimension."
	if (do_after(src, 30, get_turf(src)))
		set_last_xyz()
		forceMove(pick(GLOB.scp106_floors))
		verbs -= /mob/living/carbon/human/scp106/proc/enter_pocket_dimension
		verbs += /mob/living/carbon/human/scp106/proc/go_back

/mob/living/carbon/human/scp106/proc/confuse_victims()
	set name = "Confuse Victims"
	set category = "SCP"
	set desc = "Confuse your victims by making them see upside-down."
	confusing = !confusing
	to_chat(src, "You are [confusing ? "now confusing" : "no longer confusing"] your victims.")
//mess. rewrite

/mob/living/carbon/human/scp106/apply_damage(var/damage = 0, var/damagetype = BRUTE, var/def_zone = null, var/blocked = 0, var/damage_flags = 0, var/obj/used_weapon = null, var/armor_pen, var/silent = FALSE, var/obj/item/organ/external/given_organ = null)
	. = ..()
	if (getBruteLoss() + getFireLoss() + getToxLoss() + getCloneLoss() >= 200)
		if (!(loc in GLOB.scp106_floors))
			to_chat(src, "<span class='danger'><i>You flee back to your pocket dimension!</i></span>")
			forceMove(pick(GLOB.scp106_floors))
			verbs -= /mob/living/carbon/human/scp106/proc/enter_pocket_dimension
			verbs += /mob/living/carbon/human/scp106/proc/go_back

// special objects
/obj/scp106_exit
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"
	anchored = 1.0
	unacidable = 1
	simulated = 0
	invisibility = 100

/obj/scp106_exit/Crossed(var/mob/living/L)
	if (!istype(L) || isscp106(L))
		return ..(L)
	visible_message("<span class = 'danger'>[L] is warped away!</span>")
	L.forceMove(pick(GLOB.simulated_turfs_scp106))

/obj/scp106_teleport
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"
	anchored = 1.0
	unacidable = 1
	simulated = 0
	invisibility = 100

/obj/scp106_teleport/Crossed(var/mob/living/L)
	if (!istype(L) || isscp106(L))
		return ..(L)
	if (prob(50))
		L.adjustBrainLoss(1000)
	else
		visible_message("<span class = 'danger'>[L] is warped away!</span>")
		L.forceMove(pick(GLOB.scp106_floors))

/obj/scp106_random
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"
	anchored = 1.0
	unacidable = 1
	simulated = 0
	invisibility = 100

/obj/scp106_random/Crossed(var/mob/living/L)
	if (!istype(L) || isscp106(L))
		return ..(L)
	// 15% chance of instant death
	else if (prob(15))
		L.adjustBrainLoss(1000)
	// 15% chance of getting back to the station
	else if (prob(15))
		visible_message("<span class = 'danger'>[L] is warped away!</span>")
		L.forceMove(pick(GLOB.simulated_turfs_scp106))
	// 70% chance of going somewhere in the PD
	else if (prob(70))
		visible_message("<span class = 'danger'>[L] is warped away!</span>")
		L.forceMove(pick(GLOB.scp106_floors))


// the femur breaker
/obj/structure/femur_breaker
	icon = 'icons/obj/femurbreaker.dmi'
	density = TRUE
	anchored = TRUE
	buckle_lying = 1
	var/spent_mobs = list()
	var/frequency = "femurbreaker"

/obj/structure/femur_breaker/Initialize()
	. = ..()

/obj/structure/femur_breaker/Destroy()
	qdel()
	return ..()

/obj/structure/femur_breaker/attackby(obj/item/W, mob/user)
	var/obj/item/grab/G = W

	if (G && istype(G) && G.affecting && ishuman(G.affecting))
		var/mob/living/carbon/human/target = G.affecting

		if (buckled_mob)
			to_chat(user, "It is already in use.")
		else if (target && user && ishuman(target))
			visible_message("<span class = 'warning'>[user] starts to put [target] onto the femur breaker...</span>")
			if (buckle_mob(user, target, 3 SECONDS))
				visible_message("<span class = 'danger'>[user] puts [target] onto the femur breaker.</span>")
				var/mob/living/carbon/human/H = target
				H.forceMove(get_turf(src))
				H.buckled = src
				buckled_mob = H

		qdel(G)

/obj/structure/femur_breaker/attack_hand(mob/user)
	if (buckled_mob && buckled_mob != user)

		visible_message("<span class = 'notice'>[user] unbuckles [buckled_mob] from the femur breaker.</span>")
		buckled_mob.buckled = null
		buckled_mob.Move(get_step(buckled_mob, buckled_mob.dir))

		var/nextdir = EAST
		var/iterations = 0
		while (buckled_mob.loc == get_turf(src))
			var/nextturf = get_step(buckled_mob, nextdir)
			buckled_mob.Move(nextturf)
			nextdir = next_in_list(nextdir, list(NORTH, EAST, SOUTH, WEST, NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST))
			if (++iterations > 20)
				break

		buckled_mob.anchored = FALSE
		buckled_mob = null

/obj/structure/femur_breaker/proc/activate()
	set waitfor = FALSE

	var/mob/living/carbon/human/H = buckled_mob

	// because monkeys are humans
	if (istype(H.species, /datum/species/monkey))
		return

	world << sound('sound/scp/machinery/femur_breaker.ogg')
	sleep(2.8 SECONDS)

	for (var/obj/item/organ/external/leg/L in H.organs)
		if (!(L.status & BROKEN))
			L.fracture()
			if (spent_mobs[H])
				return
			sleep(10 SECONDS)
			for (var/scp106 in GLOB.scp106s)
				var/atom/movable/A = scp106
				A.forceMove(GLOB.scp106_spawnpoints[1])
			sleep(40 SECONDS)
			for (var/scp106 in GLOB.scp106s)
				var/atom/movable/A = scp106
				if (get_area(A) != get_area(GLOB.scp106_spawnpoints[1]))
					if (!(A.loc in GLOB.scp106_floors))
						return // failed
			sleep(30 SECONDS)
			var/active_shield_generators = 0
			for (var/obj/machinery/shieldwallgen/G in get_area(GLOB.scp106_spawnpoints[1]))
				if (G.active)
					++active_shield_generators

			if (active_shield_generators < 4)
				return // failed

			world << sound('sound/scp/machinery/femur_breaker_success.ogg')
			spent_mobs[H] = TRUE
			return

/obj/machinery/button/femur_breaker
	name = "Femur Breaker Button"
	icon = 'icons/obj/objects.dmi'
//	frequency = "femurbreaker"
//	sleep_time = 90 SECONDS

/obj/machinery/button/femur_breaker/Initialize()
	. = ..()


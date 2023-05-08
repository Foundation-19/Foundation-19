GLOBAL_LIST_EMPTY(scp106s)

/mob/living/carbon/human/scp_106
	desc = "A rotting, elderly old man."
	SCP = /datum/scp/scp_106
	icon = 'icons/SCP/scp-106.dmi'
	icon_state = null
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7
	status_flags = NO_ANTAG
	var/mob/living/target = null
	var/last_x = -1
	var/last_y = -1
	var/last_z = -1
	var/phasing = FALSE
	var/mob/observer/eye/scp106/WallEye
	/// Turf where we were created
	var/turf/spawn_turf = null
	/// Area we spawned in
	var/area/spawn_area = null
	/// Area type of the pocket dimension to look for
	var/pocket_dimension_area_type = /area/pocketdimension

	// Cooldowns and time variables
	var/phase_cooldown
	var/phase_cooldown_time = 2 SECONDS
	var/phase_time = 2 SECONDS
	var/pocket_dimension_cooldown
	var/pocket_dimension_cooldown_time = 20 SECONDS
	var/sound_cooldown
	var/sound_cooldown_time = 4 SECONDS

/datum/scp/scp_106
	name = "SCP-106"
	designation = "106"
	classification = KETER

/mob/living/carbon/human/scp_106/Initialize(mapload, new_species = "SCP-106")
	. = ..()
	GLOB.scp106s |= src
	spawn_turf = get_turf(src)
	spawn_area = get_area(src)
	fully_replace_character_name("SCP-106")

	add_verb(src, list(
		/mob/living/carbon/human/scp_106/proc/enter_pocket_dimension,
		/mob/living/carbon/human/scp_106/proc/object_phase,
		/mob/living/carbon/human/scp_106/proc/wall_phase,
		/mob/living/carbon/human/scp_106/proc/wall_unphase,
		/mob/living/carbon/human/scp_106/proc/audible_breathe,
		/mob/living/carbon/human/scp_106/proc/audible_laugh,
	))

	add_language(LANGUAGE_EAL, FALSE)
	add_language(LANGUAGE_SKRELLIAN, FALSE)
	add_language(LANGUAGE_GUTTER, FALSE)
	add_language(LANGUAGE_SIGN, FALSE)
	add_language(LANGUAGE_ENGLISH, FALSE)

	WallEye = new(src)
	WallEye.visualnet.add_source(src)
	WallEye.visualnet.add_source(WallEye)

/mob/living/carbon/human/scp_106/Destroy()
	GLOB.scp106s -= src
	QDEL_NULL(WallEye)
	target = null
	WallEye = null
	return ..()

/mob/living/carbon/human/scp_106/update_icons()
	return

/mob/living/carbon/human/scp_106/on_update_icon()
	if(lying || resting)
		var/matrix/M =  matrix()
		transform = M.Turn(90)
	else
		transform = null
	return

/mob/living/carbon/human/scp_106/IsAdvancedToolUser()
	return FALSE

/mob/living/carbon/human/scp_106/get_pressure_weakness()
	return 0

/mob/living/carbon/human/scp_106/handle_breath()
	return TRUE

/mob/living/carbon/human/scp_106/movement_delay()
	return 4.0

/mob/living/carbon/human/scp_106/say(message, datum/language/speaking = null, whispering)
	to_chat(src, SPAN_NOTICE("You cannot speak."))
	return 0

/mob/living/carbon/human/scp_106/apply_damage(damage = 0, damagetype = BRUTE, def_zone = null, blocked = 0, damage_flags = 0, obj/used_weapon = null, armor_pen, silent = FALSE, obj/item/organ/external/given_organ = null)
	. = ..()
	if(getBruteLoss() + getFireLoss() + getToxLoss() + getCloneLoss() < 200)
		return
	if(istype(get_area(src), pocket_dimension_area_type))
		return
	to_chat(src, SPAN_DANGER("<i>You flee back to your pocket dimension!</i>"))
	enter_pocket_dimension(TRUE)

/mob/living/carbon/human/scp_106/bullet_act(obj/item/projectile/Proj)
	if(!Proj)
		return
	visible_message(SPAN_WARNING("\The [Proj] harmlessly sinks into [src]'s acidic skin!"))
	return FALSE

// Cannot get stunned normally, but we need it for the femur sequence
/mob/living/carbon/human/scp_106/handle_stunned()
	if(stunned)
		stunned = max(0, stunned - 1)
	return stunned

// So that he isn't as stealthy anymore
/mob/living/carbon/human/scp_106/play_special_footstep_sound(turf/T, volume = 30, range = 1)
	var/play_sound = pick(\
				'sound/effects/footstep/scp106/step1.ogg',
				'sound/effects/footstep/scp106/step2.ogg',
				'sound/effects/footstep/scp106/step3.ogg')
	playsound(T, play_sound, max(20, volume), TRUE, range)
	return TRUE

// This is us attacking
/mob/living/carbon/human/scp_106/UnarmedAttack(atom/A, proximity_flag)
	var/mob/living/L = A
	if(!istype(L))
		return
	if(!proximity_flag)
		return
	if(L == src)
		return
	if(L.stat == DEAD)
		return
	if(istype(L.buckled, /obj/structure/femur_breaker))
		return
	if(istype(get_area(L), pocket_dimension_area_type))
		return

	if(L.weakened || !ishuman(L) || !(L.status_flags & CANWEAKEN))
		WarpMob(L)
		return
	L.Weaken(4)
	playsound(L, pick('sound/bullets/bullet_impact2.ogg', 'sound/bullets/bullet_impact3.ogg'), rand(15, 30), TRUE)
	visible_message(SPAN_DANGER("\The [src] knocks [L] down!"))

// This is us GETTING attacked
/mob/living/carbon/human/scp_106/attack_hand(mob/living/L)
	if(L == src)
		return
	WarpMob(L)

/mob/living/carbon/human/scp_106/proc/WarpMob(mob/living/L)
	var/turf/T = pick_area_turf(pocket_dimension_area_type, list(/proc/not_turf_contains_dense_objects))
	if(!istype(T)) // Fail-safe
		T = get_turf(T)
	visible_message(SPAN_DANGER("[L] is warped away!"))
	playsound(L, pick('sound/scp/106/decay1.ogg', 'sound/scp/106/decay2.ogg', 'sound/scp/106/decay3.ogg'), 50, TRUE)
	if(L.buckled)
		L.buckled.unbuckle_mob()
	L.forceMove(T)
	L.Weaken(2)

/mob/living/carbon/human/scp_106/proc/set_last_xyz()
	last_x = x
	last_y = y
	last_z = z

/* Abilities */
// Apparently verbs can't have variables
/mob/living/carbon/human/scp_106/proc/enter_pocket_dimension()
	set name = "Enter Pocket Dimension"
	set category = "SCP"
	set desc = "Enter your pocket dimension."

	enter_pocket_dimension_proc()

/mob/living/carbon/human/scp_106/proc/enter_pocket_dimension_proc(forced = FALSE)
	if(phasing)
		return

	var/turf/my_turf = get_turf(src)
	if(istype(get_area(my_turf), pocket_dimension_area_type))
		return FALSE

	if(!forced)
		if(pocket_dimension_cooldown > world.time)
			to_chat(src, SPAN_WARNING("You are not ready to enter pocket dimension just yet."))
			return
		if(incapacitated())
			return FALSE
		pocket_dimension_cooldown = world.time + 50
		if(!do_after(src, 30, my_turf))
			return FALSE
	var/turf/T = pick_area_turf(pocket_dimension_area_type, list(/proc/not_turf_contains_dense_objects))
	if(!istype(T))
		return FALSE
	pocket_dimension_cooldown = world.time + pocket_dimension_cooldown_time
	animate(src, alpha = 0, time = 5)
	set_last_xyz()
	sleep(5) // Le cool visual effects
	animate(src, alpha = 255, time = 5)
	forceMove(T)
	remove_verb(src, /mob/living/carbon/human/scp_106/proc/enter_pocket_dimension)
	add_verb(src, /mob/living/carbon/human/scp_106/proc/go_back)
	return TRUE

/mob/living/carbon/human/scp_106/proc/go_back()
	set name = "Return"
	set category = "SCP"
	set desc = "Return to the area you last teleported from."

	if(phasing)
		return

	if(pocket_dimension_cooldown > world.time)
		to_chat(src, SPAN_WARNING("You are not ready to leave pocket dimension just yet."))
		return

	if(last_x != -1) // shouldn't be possible but just in case
		alpha = 0
		forceMove(locate(last_x, last_y, last_z))
		stunned = 5
		animate(src, alpha = 255, time = 5)
	remove_verb(src, /mob/living/carbon/human/scp_106/proc/go_back)
	add_verb(src, /mob/living/carbon/human/scp_106/proc/enter_pocket_dimension)

/mob/living/carbon/human/scp_106/proc/object_phase()
	set name = "Phase Through Object"
	set category = "SCP"
	set desc = "Phase through an object in front of you."

	if(world.time < phase_cooldown)
		to_chat(src, "<span class = 'warning'>You can't phase again yet.</span>")
		return

	var/obj/target_object = null
	for(var/obj/O in get_step(src, dir))
		// Things that we will ignore
		if(!isstructure(O) && !ismachinery(O))
			continue

		if(!O.density)
			continue

		// Things that will block our phasing
		if(istype(O, /obj/machinery/door/airlock/vault))
			to_chat(src, SPAN_WARNING("You cannot phase through [O]."))
			return

		if(istype(O, /obj/machinery/shieldwall) || istype(O, /obj/machinery/shieldwallgen))
			to_chat(src, SPAN_WARNING("You cannot phase through [O]."))
			return

		// There can be more than one available dense object, but that doesn't matter
		target_object = O

	if(!istype(target_object))
		to_chat(src, SPAN_WARNING("There's nothing to phase through in that direction."))
		return

	var/turf/target_turf = get_step(target_object, dir)
	if(target_turf.density)
		to_chat(src, SPAN_WARNING("\The [target_turf] is preventing us from phasing in that direction."))
		return

	phase_cooldown = world.time + phase_cooldown_time

	// Object effects
	target_turf.visible_message(SPAN_DANGER("[target_object] corrodes, as something starts to appear from it."))
	var/obj_old_color = target_object.color
	animate(target_object, color = "#555555", time = phase_time)

	// Mob effects
	var/old_layer = layer
	var/anim_x = 0
	var/anim_y = 0
	layer = OBSERVER_LAYER
	alpha = 128

	if(dir in list(NORTH, NORTHEAST, NORTHWEST))
		anim_y = 32
	if(dir in list(SOUTH, SOUTHEAST, SOUTHWEST))
		anim_y = -32
	if(dir in list(EAST, NORTHEAST, SOUTHEAST))
		anim_x = 32
	if(dir in list(WEST, NORTHWEST, SOUTHWEST))
		anim_x = -32
	animate(src, pixel_x = anim_x, pixel_y = anim_y, time = phase_time)

	playsound(target_object, pick('sound/scp/106/decay1.ogg', 'sound/scp/106/decay2.ogg', 'sound/scp/106/decay3.ogg'), 35, FALSE)

	if(do_after(src, phase_time, target_object))
		forceMove(get_step(src, dir))
		visible_message("<span class = 'danger'>[src] phases through \the [target_object].</span>")

	animate(target_object, color = obj_old_color, time = (20 SECONDS))

	layer = old_layer
	alpha = 255
	pixel_x = 0
	pixel_y = 0

/mob/living/carbon/human/scp_106/proc/wall_phase()
	set name = "Enter wall"
	set category = "SCP"
	set desc = "Enter the wall to reappear elsewhere"

	if(phasing)
		return

	if(!WallEye)
		return
	var/turf/step_turf = get_step(src, dir)
	if(!step_turf?.is_phasable())
		return

	var/old_layer = layer
	var/old_color = step_turf.color
	var/anim_x = 0
	var/anim_y = 0
	layer = OBSERVER_LAYER
	alpha = 128

	if(dir in list(NORTH, NORTHEAST, NORTHWEST))
		anim_y = 32
	if(dir in list(SOUTH, SOUTHEAST, SOUTHWEST))
		anim_y = -32
	if(dir in list(EAST, NORTHEAST, SOUTHEAST))
		anim_x = 32
	if(dir in list(WEST, NORTHWEST, SOUTHWEST))
		anim_x = -32

	animate(src, pixel_x = anim_x, pixel_y = anim_y, time = phase_time)
	animate(step_turf, color = "#555555", time = phase_time)
	playsound(step_turf, pick('sound/scp/106/decay1.ogg', 'sound/scp/106/decay2.ogg', 'sound/scp/106/decay3.ogg'), 35, FALSE)

	var/anim_duration = 20 SECONDS
	if(do_after(src, phase_time, step_turf))
		WallEye.possess(src)
		WallEye.forceMove(step_turf)
		forceMove(WallEye)
		phasing = TRUE
		anim_duration = 2 SECONDS

	animate(step_turf, color = old_color, time = anim_duration)
	alpha = 255
	layer = old_layer
	pixel_x = 0
	pixel_y = 0

/mob/living/carbon/human/scp_106/proc/wall_unphase()
	set name = "Leave wall"
	set category = "SCP"
	set desc = "Leave the wall to reappear in that location."

	if(!phasing)
		return

	var/turf/exit = get_turf(WallEye)
	if(!exit?.is_phasable())
		return

	var/old_color = exit.color
	playsound(exit, pick('sound/scp/106/wall_decay.ogg'), 35, FALSE)
	animate(exit, color = "#555555", time = 5 SECONDS)

	if(!do_after(src, 5 SECONDS, WallEye))
		animate(exit, color = old_color, time = 2 SECONDS)
		return

	forceMove(exit)
	WallEye.release(src)
	WallEye.forceMove(src)
	phasing = FALSE
	animate(exit, color = old_color, time = (30 SECONDS))

// Spooky sounds
/mob/living/carbon/human/scp_106/proc/audible_breathe()
	set name = "\[Sound\] Breathing"
	set category = "SCP"
	set desc = "Breathe. Creepily."

	if(world.time < sound_cooldown)
		return
	playsound(get_turf(src), 'sound/scp/106/breathing.ogg', rand(35, 65), TRUE)
	sound_cooldown = world.time + sound_cooldown_time

/mob/living/carbon/human/scp_106/proc/audible_laugh()
	set name = "\[Sound\] Laugh"
	set category = "SCP"
	set desc = "Laugh. Creepily."

	if(world.time < sound_cooldown)
		return
	playsound(get_turf(src), 'sound/scp/106/laugh.ogg', rand(35, 65), TRUE)
	sound_cooldown = world.time + sound_cooldown_time

// Special objects
/obj/scp106_random
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"
	anchored = TRUE
	acid_resistance = -1
	simulated = FALSE
	invisibility = 100

/obj/scp106_random/Crossed(mob/living/L)
	if(!istype(L) || isscp106(L))
		return ..()
	// 15% chance of instant death
	if(prob(15))
		L.adjustBrainLoss(1000)
		animate(L, color = "#999999", time = (10 SECONDS))
		return
	// 15% chance of getting back to the station
	if(prob(15))
		var/turf/T = pick_subarea_turf(/area, list(/proc/is_station_turf, /proc/not_turf_contains_dense_objects))
		if(!istype(T))
			return

		visible_message(SPAN_WARNING("[L] is warped away!"))
		playsound(L, pick('sound/scp/106/decay1.ogg', 'sound/scp/106/decay2.ogg', 'sound/scp/106/decay3.ogg'), 25, TRUE)
		playsound(T, pick('sound/scp/106/decay1.ogg', 'sound/scp/106/decay2.ogg', 'sound/scp/106/decay3.ogg'), 25, TRUE)
		L.forceMove(T)
		return
	// 70% chance of going somewhere in the PD
	if(prob(70))
		var/turf/T = pick_area_turf(/area/pocketdimension, list(/proc/not_turf_contains_dense_objects))
		if(!istype(T))
			return

		visible_message(SPAN_WARNING("[L] is warped away!"))
		playsound(L, pick('sound/scp/106/decay1.ogg', 'sound/scp/106/decay2.ogg', 'sound/scp/106/decay3.ogg'), 25, TRUE)
		playsound(T, pick('sound/scp/106/decay1.ogg', 'sound/scp/106/decay2.ogg', 'sound/scp/106/decay3.ogg'), 25, TRUE)
		L.alpha = 0
		L.forceMove(T)
		animate(L, alpha = 255, time = (2 SECONDS))
		return

// The femur breaker
GLOBAL_LIST_EMPTY(femur_breakers)

/obj/structure/femur_breaker
	icon = 'icons/obj/femurbreaker.dmi'
	density = TRUE
	anchored = TRUE
	can_buckle = TRUE
	buckle_lying = TRUE
	var/id = 2
	var/spent_mobs = list()
	var/use_cooldown
	var/use_cooldown_time = 90 SECONDS

/obj/structure/femur_breaker/Initialize()
	. = ..()
	GLOB.femur_breakers += src

/obj/structure/femur_breaker/Destroy()
	GLOB.femur_breakers -= src
	return ..()

/obj/structure/femur_breaker/attackby(obj/item/W, mob/user)
	var/obj/item/grab/G = W
	if(!istype(G) || !G.affecting || !ishuman(G.affecting))
		return ..()
	if(buckled_mob)
		to_chat(user, "It is already in use.")
		return

	var/mob/living/carbon/human/target = G.affecting
	if(user == target)
		if(user_buckle_mob(target, user))
			qdel(G)
		return

	visible_message(SPAN_WARNING("[user] starts to put [target] onto the femur breaker..."))
	if(!do_after(user, 3 SECONDS, target))
		return

	// TODO: Rework buckling code to avoid copy-pasta
	target.forceMove(get_turf(src))
	target.pixel_x = target.default_pixel_x
	target.pixel_y = target.default_pixel_y
	target.buckled = src
	target.facing_dir = null
	target.set_dir(buckle_dir ? buckle_dir : dir)
	target.UpdateLyingBuckledAndVerbStatus()
	target.update_floating()
	buckled_mob = target

	if(target == user)
		target.visible_message(\
			SPAN_NOTICE("\The [target.name] buckles themselves to \the [src]."),\
			SPAN_NOTICE("You buckle yourself to \the [src]."),\
			SPAN_NOTICE("You hear metal clanking."))
	else
		target.visible_message(\
			SPAN_DANGER("\The [target.name] is buckled to \the [src] by \the [user.name]!"),\
			SPAN_DANGER("You are buckled to \the [src] by \the [user.name]!"),\
			SPAN_NOTICE("You hear metal clanking."))

	qdel(G)

/obj/structure/femur_breaker/attack_hand(mob/user)
	if(!buckled_mob || buckled_mob == user)
		return
	if(isscp106(user))
		return
	user_unbuckle_mob(user)

/obj/structure/femur_breaker/proc/Activate()
	set waitfor = FALSE

	if(!buckled_mob)
		return

	var/mob/living/carbon/human/H = buckled_mob
	if(!istype(H))
		return

	// Because monkeys are humans
	if(istype(H.species, /datum/species/monkey))
		return

	// Has to be alive
	if(H.stat == DEAD)
		return

	if(world.time < use_cooldown)
		return

	use_cooldown = world.time + use_cooldown_time

	for(var/mob/M in GLOB.player_list)
		if(!isStationLevel(M.z))
			continue
		M.playsound_local(get_turf(M), 'sound/scp/machinery/femur_breaker.ogg', 35, FALSE)

	H.Stun(60) // Death

	sleep(3.2 SECONDS)

	playsound(H, "crack", 75, TRUE)
	for(var/obj/item/organ/external/leg/L in H.organs)
		if(!(L.status & BROKEN))
			L.fracture()
			if(H in spent_mobs)
				return

	sleep(20 SECONDS)
	var/mob/living/carbon/human/scp_106/A
	for(var/mob/living/carbon/human/scp_106/S in GLOB.scp106s)
		A = S
		break

	if(H.stat == DEAD)
		return

	if(!istype(A))
		return

	A.pocket_dimension_cooldown = world.time + 60 SECONDS
	sleep(rand(7 SECONDS, 15 SECONDS))
	if(get_area(H) != A.spawn_area) // He ran away
		return

	if(H.stat == DEAD)
		return

	if(A.phasing)
		A.wall_unphase()
	A.alpha = 0
	A.forceMove(get_step(src, EAST))
	animate(A, alpha = 255, time = 2 SECONDS)

	// The murder sequence
	for(var/mob/M in GLOB.player_list)
		if(!isStationLevel(M.z))
			continue
		M.playsound_local(get_turf(M), 'sound/scp/machinery/femur_breaker_death.ogg', 35, FALSE)
	A.stunned = 20
	sleep(7 SECONDS)
	for(var/obj/item/organ/external/E in H.organs)
		if(E.status & BROKEN)
			continue
		if(prob(75))
			continue
		E.fracture()
	sleep(4 SECONDS)
	for(var/obj/item/organ/external/E in H.organs)
		if(E.status & BROKEN)
			continue
		E.fracture()
		H.adjustBruteLoss(25)
		if(prob(15))
			new /obj/effect/gibspawner/generic(get_turf(H))
		sleep(2)
	H.adjustBruteLoss(rand(500, 1500)) // Big splash
	new /obj/effect/gibspawner/human(get_turf(H))
	sleep(2 SECONDS)
	A.WarpMob(H)
	A.enter_pocket_dimension_proc(TRUE)
	spent_mobs |= H

	sleep(5 SECONDS)

	var/active_shield_generators = 0
	for(var/obj/machinery/shieldwallgen/G in A.spawn_area)
		if(G.active)
			active_shield_generators += 1

	if(active_shield_generators < 4)
		return // failed

	for(var/mob/M in GLOB.player_list)
		if(!isStationLevel(M.z))
			continue
		M.playsound_local(get_turf(M), 'sound/scp/machinery/magnet_up.ogg', 35, FALSE)

	sleep(9 SECONDS)

	for(var/mob/M in GLOB.player_list)
		if(!isStationLevel(M.z))
			continue
		M.playsound_local(get_turf(M), 'sound/scp/machinery/femur_breaker_success.ogg', 35, FALSE)

/obj/machinery/button/femur_breaker
	name = "Femur Breaker Button"
	icon = 'icons/obj/objects.dmi'
	id_tag = 2

/obj/machinery/button/femur_breaker/activate(mob/user)
	for(var/obj/structure/femur_breaker/C in GLOB.femur_breakers)
		if(C.id == id_tag)
			C.Activate(user)

/mob/observer/eye/scp106
	name = "SCP-106 presence"
	cooldown = 5
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7

/mob/observer/eye/scp106/New()
	visualnet = new /datum/visualnet/scp106
	return ..()

/mob/observer/eye/scp106/EyeMove(direct)
	var/turf/step = get_turf(get_step(src, direct))
	if(istype(step, /turf/unsimulated)) // Mostly to prevent people from moving into/through mineral rocks
		return
	if(!step.is_phasable())
		return FALSE
	if(direct == UP && !HasAbove(z))
		return FALSE
	if(direct == DOWN && !HasBelow(z))
		return FALSE
	setLoc(step)
	return TRUE

/datum/visualnet/scp106
	valid_source_types =  list(/mob/observer/eye/scp106,/mob/living/carbon/human/scp_106) //list(/turf/simulated/wall,/turf/unsimulated/wall)
	chunk_type = /datum/chunk/scp106

/datum/chunk/scp106/acquire_visible_turfs(list/visible)
	for(var/source in sources)
		for(var/turf/T in seen_turfs_in_range(get_turf(source), 16))
			visible[T] = T

/mob/living/simple_animal/hostile/scp280
	name = "Dark Mass"
	desc = "A human shaped-like mass of darkness."
	icon = 'icons/SCP/scp-280.dmi'
	icon_state = "scp_280"
	status_flags = NO_ANTAG

	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7
	movement_cooldown = 6

	response_help = "tries to reach inside"
	response_disarm = "tries to push away"
	response_harm = "tries to punch"

	can_escape = TRUE //snip snip
	pass_flags = PASS_FLAG_TABLE
	density = FALSE

	meat_type = null
	meat_amount = 0
	skin_material = null
	skin_amount = 0
	bone_material = null
	bone_amount = 0

	maxHealth = 400
	health = 400

	ai_holder_type = /datum/ai_holder/simple_animal/melee/scp280
	say_list_type = /datum/say_list/scp017 //they have like the same saylist so...

	natural_weapon = /obj/item/natural_weapon/claws/strong

	//Mechanics

	///Our damage message cooldown
	var/damage_message_cooldown

/mob/living/simple_animal/hostile/scp280/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"dark mass", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_KETER, //Obj Class
		"280" //Numerical Designation
	)

//AI stuff

/datum/ai_holder/simple_animal/melee/scp280
	can_flee = TRUE
	flee_when_dying = TRUE
	dying_threshold = 0.5

	var/turf/shadow_target
	var/list/darkness_path = list()

/datum/ai_holder/simple_animal/melee/scp280/special_flee_check()
	var/turf/our_turf = get_turf(holder)
	if(!is_dark(our_turf))
		return TRUE

/datum/ai_holder/simple_animal/melee/scp280/proc/flee_to_darkness()
	ai_log("flee_to_darkness() : Entering.", AI_LOG_DEBUG)
	if(!shadow_target || !LAZYLEN(darkness_path))
		LAZYCLEARLIST(darkness_path)
		LAZYINITLIST(darkness_path)
		var/while_loop_timeout = world.time
		while(!LAZYLEN(darkness_path) && ((world.time - while_loop_timeout) < 5 SECONDS))
			shadow_target = pick_turf_in_range(holder.loc, 14, list(GLOBAL_PROC_REF(is_dark)))
			darkness_path = get_path_to(holder, shadow_target)
	if(!should_flee() || !shadow_target || !LAZYLEN(darkness_path) || !holder.IMove(darkness_path[1]))
		ai_log("flee_to_darkness() : Lost target to flee to.", AI_LOG_INFO)
		shadow_target = null
		LAZYCLEARLIST(darkness_path)
		set_stance(STANCE_IDLE)
		ai_log("flee_to_darkness() : Exiting.", AI_LOG_DEBUG)
		return

	ai_log("flee_to_darkness() : Stepping to shadow target.", AI_LOG_TRACE)
	for(var/steps = 0, steps < 5, steps++)
		if(!LAZYLEN(darkness_path))
			break
		step_towards(holder, darkness_path[1], vision_range)
		if(holder.loc != darkness_path[1])
			break
		LAZYREMOVE(darkness_path, darkness_path[1])
	ai_log("flee_to_darkness() : Exiting.", AI_LOG_DEBUG)

/datum/ai_holder/simple_animal/melee/scp280/flee_from_target()
	if(!target)
		flee_to_darkness()
	else
		return ..()

/datum/ai_holder/simple_animal/melee/scp280/can_attack(atom/movable/the_target, vision_required = TRUE)
	if(the_target.SCP)
		return ATTACK_FAILED
	var/turf/Tturf = get_turf(the_target)
	if(!is_dark(Tturf))
		return ATTACK_FAILED
	return ..()

//Mechanics

/mob/living/simple_animal/hostile/scp280/Life()
	. = ..()
	var/turf/our_turf = get_turf(src)
	if(!our_turf)
		return
	var/lumcount = our_turf.get_lumcount()
	if(!is_dark(our_turf))
		adjustBruteLoss(10 * lumcount)
		if((world.time - damage_message_cooldown) > 2 SECONDS)
			visible_message(SPAN_WARNING("[src] is singed by the light!"))
			damage_message_cooldown = world.time
		if(!ai_holder.target)
			ai_holder.set_stance(STANCE_FLEE)
			return

	if(lumcount >= 0.6)
		ai_holder.set_stance(STANCE_FLEE)

//Overrides

/mob/living/simple_animal/hostile/scp280/bullet_act(obj/item/projectile/Proj)
	if(Proj.damage_type == BRUTE)
		visible_message(SPAN_WARNING("The [Proj] seems to pass right through it!"))
		return PROJECTILE_CONTINUE
	return ..()

/mob/living/simple_animal/hostile/scp280/attack_hand(mob/living/carbon/human/M)
	to_chat(M, SPAN_WARNING("Your hand goes right through [src]!"))

/mob/living/simple_animal/hostile/scp280/attackby(obj/item/O, mob/user)
	to_chat(user, SPAN_WARNING("The [O] goes right through [src]!"))

/mob/living/simple_animal/hostile/scp280/IMove(turf/newloc, safety = TRUE)
	var/area/Tarea = get_area(newloc)
	var/turf/ourTurf = get_turf(src)
	var/list/turf/adjacent_turfs = ourTurf.AdjacentTurfs()

	var/dark_spot_avalible = FALSE
	for(var/turf/Tturf in adjacent_turfs)
		if(is_dark(Tturf))
			dark_spot_avalible = TRUE
			break

	if((!is_dark(newloc) || (Tarea.dynamic_lighting == 0)) && dark_spot_avalible) //We dont go to turfs which are lit unless we have no choice.
		return MOVEMENT_FAILED
	return ..()

/mob/living/simple_animal/hostile/scp280/death(gibbed, deathmessage = "dissapears in a puff of smoke", show_dead_message)
	. = ..()
	var/turf/T = get_turf(src)

	var/datum/effect/effect/system/smoke_spread/S = new/datum/effect/effect/system/smoke_spread()
	S.set_up(3,0,T)
	S.start()

	var/turf/new_target_turf = pick_turf_in_range(src, 100, list(GLOBAL_PROC_REF(isfloor), GLOBAL_PROC_REF(is_dark)))
	if(!new_target_turf)
		ghostize()
		qdel_self()
	else
		forceMove(new_target_turf)
		health = maxHealth

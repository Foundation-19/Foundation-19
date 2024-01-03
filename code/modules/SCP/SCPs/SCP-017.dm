/mob/living/simple_animal/hostile/scp017
	name = "shambling void"
	desc = "A weird shambling void. You can see nothing inside."
	icon = 'icons/SCP/scp-017.dmi'

	icon_state = "scp-017"
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

	maxHealth = 100
	health = 100

	movement_cooldown = 2

	say_list_type = /datum/say_list/scp017
	ai_holder_type = /datum/ai_holder/simple_animal/melee/scp017

	can_bleed = FALSE

	//Config

	///lumcount required for something to be considered a shadow
	var/shadow_threshold = 0.35

/mob/living/simple_animal/hostile/scp017/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"shambling void", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_KETER, //Obj Class
		"017", //Numerical Designation
	)

//Datum proc overrides and defines
/datum/ai_holder/simple_animal/melee/scp017
	cooperative = FALSE
	speak_chance = 1
	mauling = TRUE
	destructive = TRUE
	returns_home = FALSE
	can_flee = FALSE
	respect_confusion = FALSE

	///lumcount required for something to be considered a shadow. Should be identical to mob value.
	var/shadow_threshold = 0.35

/datum/ai_holder/simple_animal/melee/scp017/can_attack(atom/movable/the_target, vision_required = TRUE)
	if(!..() || the_target.SCP)
		return ATTACK_FAILED
	var/turf/Tturf = get_turf(the_target)
	var/area/Tarea = get_area(the_target)
	if(!Tturf || !Tarea)
		return ATTACK_FAILED
	if(!is_dark(Tturf, shadow_threshold) || (Tarea.dynamic_lighting == 0))
		return ATTACK_FAILED
	return ..()

/datum/say_list/scp017
	emote_hear = list("wooshes","whispers")
	emote_see = list("shambles", "shimmers")

//Mob procs
/mob/living/simple_animal/hostile/scp017/IMove(turf/newloc, safety = TRUE)
	var/area/Tarea = get_area(newloc)
	if(!is_dark(newloc, shadow_threshold) || (Tarea.dynamic_lighting == 0))
		return MOVEMENT_FAILED
	return ..()

/mob/living/simple_animal/hostile/scp017/gib()
	return FALSE

/mob/living/simple_animal/hostile/scp017/dust()
	return FALSE


//Death

/mob/living/simple_animal/hostile/scp017/death(gibbed, deathmessage = "dissapears in a puff of smoke", show_dead_message)
	. = ..()
	var/turf/T = get_turf(src)

	var/datum/effect/effect/system/smoke_spread/S = new/datum/effect/effect/system/smoke_spread()
	S.set_up(3,0,T)
	S.start()

	ghostize()
	qdel(src)

/mob/living/simple_animal/hostile/scp017/bullet_act(obj/item/projectile/Proj)
	if(Proj.damage_type == BRUTE)
		visible_message(SPAN_WARNING("The [Proj] seems to pass right through it!"))
		return PROJECTILE_CONTINUE
	return ..()

//Attack

/mob/living/simple_animal/hostile/scp017/UnarmedAttack(atom/A, bypass_checks)
	var/turf/Tturf = get_turf(A)
	if(!bypass_checks)
		if(!ismovable(A) || A.SCP)
			return FALSE
		var/area/Tarea = get_area(A)
		if(!Tturf || !Tarea)
			return FALSE
		if(!is_dark(Tturf, shadow_threshold) || (Tarea.dynamic_lighting == 0))
			return FALSE

	var/datum/effect/effect/system/smoke_spread/S = new/datum/effect/effect/system/smoke_spread()
	S.set_up(3,0,Tturf)
	S.start()

	var/death_message = pick("[A] dissapears into [src]!", "[A] is enveloped by [src]!", "[A] is absorbed by [src]!")
	visible_message(SPAN_DANGER(death_message))

	if(ismob(A))
		var/mob/target = A
		target.ghostize()
		qdel(target)
	else
		qdel(A)

/mob/living/simple_animal/hostile/scp017/attack_target(atom/A)
	return UnarmedAttack(A)

//General Interactions
/mob/living/simple_animal/hostile/scp017/attack_hand(mob/living/carbon/human/M)
	. = ..()
	switch(M.a_intent)
		if(I_HELP)
			if(prob(10))
				UnarmedAttack(M, TRUE)
		if(I_HURT)
			if(prob(80))
				UnarmedAttack(M, TRUE)

/mob/living/simple_animal/hostile/scp017/attackby(obj/item/O, mob/user)
	. = ..()
	UnarmedAttack(O, TRUE)

/mob/living/simple_animal/hostile/scp017/hitby(atom/movable/AM, datum/thrownthing/TT)
	. = ..()
	UnarmedAttack(AM, TRUE)

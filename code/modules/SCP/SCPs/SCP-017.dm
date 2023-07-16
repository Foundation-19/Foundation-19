/mob/living/simple_animal/hostile/scp_017
	name = "SCP-017"
	desc = "A weird shambling void. You can see nothing inside."
	icon = 'icons/SCP/scp-017.dmi'

	icon_state = "scp-017"
	turns_per_move = 5
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

	var/obj/item/inventory_head
	var/obj/item/inventory_mask

	///lumcount required for something to be considered a shadow
	var/shadow_threshold = 0.35

	///simplemob AI
	ai_holder_type = /datum/ai_holder/simple_animal/melee/scp_017

	///Saylist for 017
	say_list_type = /datum/say_list/scp_017

	can_bleed = FALSE //its a shadow, they dont usually bleed

/mob/living/simple_animal/hostile/scp_017/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"strange shadow", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		KETER, //Obj Class
		"017", //Numerical Designation
	)

//Datum proc overrides and defines
/datum/ai_holder/simple_animal/melee/scp_017
	cooperative = FALSE
	speak_chance = 1
	mauling = TRUE
	destructive = TRUE
	returns_home = FALSE
	can_flee = FALSE
	respect_confusion = FALSE

	///lumcount required for something to be considered a shadow. Should be identical to mob value.
	var/shadow_threshold = 0.35

/datum/ai_holder/simple_animal/melee/scp_017/can_attack(atom/movable/the_target, vision_required = TRUE)
	if(!..() || isSCP(the_target))
		return ATTACK_FAILED
	var/turf/Tturf = get_turf(the_target)
	var/area/Tarea = get_area(the_target)
	if(!Tturf || !Tarea)
		return ATTACK_FAILED
	if((Tturf.get_lumcount() > shadow_threshold) || (Tarea.dynamic_lighting == 0))
		return ATTACK_FAILED
	return ATTACK_SUCCESSFUL

/datum/say_list/scp_017
	emote_hear = list("wooshes","whispers")
	emote_see = list("shambles", "shimmers")

//Mob procs
/mob/living/simple_animal/hostile/scp_017/IMove(turf/newloc, safety = TRUE)
	var/area/Tarea = get_area(newloc)
	if((newloc.get_lumcount() > shadow_threshold) || (Tarea.dynamic_lighting == 0))
		return MOVEMENT_FAILED
	return ..()

/mob/living/simple_animal/hostile/scp_017/gib()
	return FALSE

/mob/living/simple_animal/hostile/scp_017/dust()
	return FALSE


//Death

/mob/living/simple_animal/hostile/scp_017/death(gibbed, deathmessage = "dissapears in a puff of smoke", show_dead_message)
	var/turf/T = get_turf(src)

	var/datum/effect/effect/system/smoke_spread/S = new/datum/effect/effect/system/smoke_spread()
	S.set_up(3,0,T)
	S.start()

	ghostize()
	qdel(src)

/mob/living/simple_animal/hostile/scp_017/bullet_act(obj/item/projectile/Proj)
	if(Proj.damage_type == BRUTE)
		visible_message(SPAN_WARNING("The [Proj] seems to pass right through it!"))
		return PROJECTILE_CONTINUE
	return ..()

//Attack

/mob/living/simple_animal/hostile/scp_017/UnarmedAttack(atom/A, bypass_checks)
	var/turf/Tturf = get_turf(A)
	if(!bypass_checks)
		if(!ismovable(A) || isSCP(A))
			return
		var/area/Tarea = get_area(A)
		if(!Tturf || !Tarea)
			return
		if((Tturf.get_lumcount() > shadow_threshold) || (Tarea.dynamic_lighting == 0))
			return

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

/mob/living/simple_animal/hostile/scp_017/attack_target(atom/A)
	return UnarmedAttack(A)

//General Interactions
/mob/living/simple_animal/hostile/scp_017/attack_hand(mob/living/carbon/human/M)
	. = ..()
	switch(M.a_intent)
		if(I_HELP)
			if(prob(10))
				UnarmedAttack(M, TRUE)
		if(I_HURT)
			if(prob(80))
				UnarmedAttack(M, TRUE)

// This dosent actually work since hit_with_weapon isint called correctly. Should be fixed when cheese does signal stuff and we can register the proc to it.
/mob/living/simple_animal/hostile/scp_017/hit_with_weapon(obj/item/O, mob/living/user, effective_force, hit_zone)
	UnarmedAttack(O, TRUE)

/mob/living/simple_animal/hostile/scp457
	name = "humanoid flame"
	desc = "A horrible band of fire, it somehow keeps a humanoid shape."
	icon = 'icons/SCP/scp-457.dmi'

	icon_state = "fireguy"
	icon_dead = "fireguy_dead"
	status_flags = NO_ANTAG

	health = 500
	maxHealth = 500

	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7

	can_pull_size = 3
	a_intent = "harm"
	can_be_buckled = FALSE

	ai_holder_type = /datum/ai_holder/simple_animal/melee/scp457
	say_list_type = /datum/say_list/scp457

	maxbodytemp = INFINITY

	//Config

	///Attack cooldown
	var/aflame_cooldown_time = 1.8 SECONDS
	///Door cooldown
	var/door_cooldown = 5 SECONDS

	//Mechanical

	///Tracks our door cooldown
	var/door_cooldow_track = 0
	///Tracks our attack cooldown
	var/aflame_cooldown_track = 0
	///Our spawn area
	var/area/spawn_area

/mob/living/simple_animal/hostile/scp457/Initialize()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"humanoid flame", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_EUCLID, //Obj Class
		"457", //Numerical Designation
		SCP_PLAYABLE
	)

	spawn_area = get_area(src)
	add_language(LANGUAGE_EAL, FALSE)
	add_language(LANGUAGE_SKRELLIAN, FALSE)
	add_language(LANGUAGE_GUTTER, FALSE)
	add_language(LANGUAGE_SIGN, FALSE)
	add_language(LANGUAGE_ENGLISH, TRUE)
	set_light(0.8, 0.3, 5, l_color = COLOR_ORANGE) //makes 457 emit light

	return ..()

//Ai Stuff

/datum/say_list/scp457
	emote_hear = list("crackles", "pops")
	emote_see = list("burns")

/datum/ai_holder/simple_animal/melee/scp457
	mauling = TRUE

//Mechanics

/mob/living/simple_animal/hostile/scp457/proc/OpenDoor(obj/machinery/door/A)
	if((world.time - door_cooldow_track) < door_cooldown)
		to_chat(src, SPAN_NOTICE("You cant open that right now!"))
		return

	if(!istype(A))
		return

	if(!A.density)
		return

	if(!A.Adjacent(src))
		to_chat(src, SPAN_WARNING("\The [A] is too far away."))
		return

	var/open_time = 5 SECONDS
	if(istype(A, /obj/machinery/door/blast))
		if(get_area(A) == spawn_area)
			to_chat(src, SPAN_WARNING("This blast door is too thermally protected, you cannot melt through it."))
			return
		open_time = 16 SECONDS

	if(istype(A, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/AR = A
		if(AR.locked)
			open_time += 4 SECONDS
		if(AR.welded)
			open_time += 4 SECONDS
		if(AR.secured_wires)
			open_time += 4 SECONDS

	A.visible_message(SPAN_WARNING("\The [src] begins to melt the control mechanisms on \the [A]!"))
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
	visible_message("\The [src] melts \the [A]'s controls[check ? ", and rips it open!" : ", and breaks it!"]")

/mob/living/simple_animal/hostile/scp457/proc/respawn()
	visible_message("One single flame from [src] reforms, turning itself into a humanoid form once again.")
	convertatom2type(src, /mob/living/simple_animal/hostile/scp457, force_mind = TRUE) //better way of handeling respawn since it also transfers mind.

//Overrides

/mob/living/simple_animal/hostile/scp457/UnarmedAttack(atom/A)
	if(A.SCP)
		to_chat(src, SPAN_WARNING(SPAN_ITALIC("That thing is not like the others. You know better than to mess with it.")))
		return
	if(((world.time - aflame_cooldown_track) < aflame_cooldown_time) && ishuman(A))
		to_chat(src, SPAN_WARNING("You can't attack yet."))
		return
	if(ishuman(A))
		var/mob/living/carbon/human/target = A

		if(target.stat == DEAD)
			to_chat(src, SPAN_NOTICE(SPAN_ITALIC("[target] is dead, it no longer can provide you with fuel.")))
			return

		if(target.weakened)
			var/damage_amount = clamp(target.health, 0, 25)

			target.fire_stacks += 1
			target.IgniteMob()
			target.apply_damage(damage_amount, BURN)

			adjustBruteLoss(-damage_amount)
			visible_message(SPAN_DANGER("[src] sets [A] alight!"))
		else
			visible_message(SPAN_DANGER("[src] burns [A]!"))
			target.Weaken(2)
			target.apply_damage(15, BURN)
			adjustBruteLoss(-15)
		aflame_cooldown_track = world.time
		return

	if(istype(A, /obj/machinery/door))
		OpenDoor(A)
		aflame_cooldown_track = world.time
		return

	if(istype(A, /obj) && A.can_damage_health(A.health_current, BURN))
		if(get_area(A) == spawn_area)
			to_chat(src, SPAN_NOTICE("[A] is too thermally insulated for you to damage."))
			return
		else
			A.attack_generic(src, 50, "melts")
			aflame_cooldown_track = world.time
	return

/mob/living/simple_animal/hostile/scp457/death(gibbed, deathmessage, show_dead_message)
	addtimer(CALLBACK(src, TYPE_PROC_REF(/mob/living/simple_animal/hostile/scp457, respawn)), 5 MINUTES)
	to_chat(src, SPAN_NOTICE(SPAN_BOLD("You will reform in five minutes, avoid leaving your body.")))
	return ..()

/mob/living/simple_animal/hostile/scp457/IAttack(atom/A)
	if((world.time - aflame_cooldown_track) < aflame_cooldown_time)
		return ATTACK_ON_COOLDOWN
	return ..()

/mob/living/simple_animal/hostile/scp457/do_attack(atom/A, turf/T)
	if(..())
		UnarmedAttack(A)

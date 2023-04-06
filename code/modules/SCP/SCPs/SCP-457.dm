/datum/scp/scp_457
	name = "SCP-457"
	designation = "457"
	classification = KETER

/mob/living/scp_457
	name = "SCP-457"
	desc = "A horrible band of fire, it somehow keeps a humanoid shape."
	icon = 'icons/SCP/scp-457.dmi'
	icon_state = "fireguy"
	SCP = /datum/scp/scp_457
	status_flags = NO_ANTAG
	var/door_cooldown
	health = 700
	maxHealth = 700
	var/funnymode = FALSE //this makes 457 better (for events and shit)

	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7

	can_pull_size = 3
	a_intent = "harm"
	can_be_buckled = FALSE

	var/aflame_cooldown
	var/aflame_cooldown_time = 1.8 SECONDS

	var/area/spawn_area

/mob/living/scp_457/Initialize()
	spawn_area = get_area(src)
	add_language(LANGUAGE_EAL, FALSE)
	add_language(LANGUAGE_SKRELLIAN, FALSE)
	add_language(LANGUAGE_GUTTER, FALSE)
	add_language(LANGUAGE_SIGN, FALSE)
	add_language(LANGUAGE_ENGLISH, TRUE)
	set_light(0.8, 0.3, 5, l_color = COLOR_ORANGE) //makes 457 emit light
	add_verb(src, list(
		/mob/living/scp_457/proc/checkhealth
	))

	return ..()

/mob/living/scp_457/UnarmedAttack(atom/A)
	if(ishuman(A))
		var/mob/living/carbon/human/H = A
		if(H.SCP)
			to_chat(src, SPAN_WARNING("<I>[H] is a fellow SCP!</I>"))
			return
		if(H.stat == DEAD)
			to_chat(src, SPAN_NOTICE("<I>[H] is dead, it no longer can provide you with fuel.</I>"))
			return
		if(aflame_cooldown > world.time)
			to_chat(src, SPAN_WARNING("You can't attack yet."))
			return
		if(prob(35))
			H.Weaken(35)
			H.visible_message(SPAN_WARNING("[src] claws at [H], the flame sending them to the floor!"))
			to_chat(H, SPAN_USERDANGER("IT HURTS!!!"))
			health += 50
			aflame_cooldown = world.time + aflame_cooldown_time
		else
			visible_message(SPAN_WARNING("[src] raises their arms and begins to attack [A]!"))
			if(do_after(src, 2 SECONDS, H))
				H.fire_stacks += 3
				H.IgniteMob()
				health += 125
				aflame_cooldown = world.time + aflame_cooldown_time
				visible_message(SPAN_DANGER("[src] grabs a hold of [A] setting them alight!"))
				to_chat(H, SPAN_USERDANGER("Oh god, oh god. OH GOD! IT HURTS! PLEASE!"))
			return

	if(istype(A, /obj/machinery/door))
		OpenDoor(A)
		return
	if(istype(A, /obj/structure/grille))
		playsound(get_turf(A), 'sound/effects/grillehit.ogg', 50, 1)
		qdel(A)
		return
	if(istype(A, /obj/structure/inflatable))
		var/obj/structure/inflatable/W = A
		W.deflate(violent=1)
	if(istype(A, /obj/structure/reagent_dispensers/fueltank))
		var/obj/structure/reagent_dispensers/fueltank/W = A
		src.visible_message(SPAN_NOTICE("[src] drains the [W]!"))
		src.health += 250
		qdel(W)
	return

/mob/living/scp_457/proc/OpenDoor(obj/machinery/door/A)
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
			to_chat(src, SPAN_WARNING("This blast door is too thermally protected, you cannot melt through it."))
			return
		open_time = 15 SECONDS

	if(istype(A, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/AR = A
		if(AR.locked)
			open_time += 3 SECONDS
		if(AR.welded)
			open_time += 2 SECONDS
		if(AR.secured_wires)
			open_time += 4 SECONDS

	A.visible_message(SPAN_WARNING("\The [src] begins to melt the control mechanisms on \the [A]!"))
	playsound(get_turf(A), 'sound/machines/airlock_creaking.ogg', 35, 1)
	door_cooldown = world.time + open_time // To avoid sound spam
	src.health += 10
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
	visible_message("\The [src] melts \the [A]'s controls[check ? ", and rips it open!" : ", and breaks it!"]")

/mob/living/scp_457/Life()
	if(health <= 0)
		death(FALSE, "falls on their knees, the flame withering away.")

/mob/living/scp_457/death(gibbed, deathmessage, show_dead_message)
	if(..())
		set_icon_state("fireguy_dead")
		addtimer(CALLBACK(src, /mob/living/scp_457/proc/_respawn), 5 MINUTES)

/mob/living/scp_457/proc/_respawn()
	visible_message("One single flame from [src] reforms, turning itself into a humanoid form once again.")
	new /mob/living/scp_457(get_turf(src))
	qdel(src)

/mob/living/scp_457/proc/checkhealth()
	set category = "SCP-457"
	set name = "Check Health"
	to_chat(src, "HEALTH: [health]")

GLOBAL_LIST_EMPTY(scp457s)

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
	var/fuel = 30 //unused as time of coding

	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7

	maxHealth = 2000
	health = 2000

	can_pull_size = 3
	a_intent = "harm"
	can_be_buckled = FALSE

	var/aflame_cooldown
	var/aflame_cooldown_time = 2.8 SECONDS

	var/area/spawn_area

/mob/living/scp_457/Initialize()
	GLOB.scp457s += src
	spawn_area = get_area(src)
	add_language(LANGUAGE_EAL, FALSE)
	add_language(LANGUAGE_SKRELLIAN, FALSE)
	add_language(LANGUAGE_GUTTER, FALSE)
	add_language(LANGUAGE_SIGN, FALSE)
	add_language(LANGUAGE_ENGLISH, TRUE)
	set_light(0.8, 0.3, 5, l_color = COLOR_ORANGE) //makes 457 emit light
	return ..()

/mob/living/scp_457/Destroy()
	GLOB.scp173s -= src
	return ..()

/mob/living/scp_457/UnarmedAttack(atom/A)
	var/mob/living/carbon/human/H = A
	if(istype(H))
		if(aflame_cooldown > world.time)
			to_chat(src, "<span class='warning'>You can't attack yet.</span>")
			return
		else if(aflame_cooldown < world.time)
			if(prob(35))
				H.Weaken(50)
				H.visible_message("<span class='danger'>[src] claws at [H], the flame sending them to the floor!</span>")
				to_chat(H, "<span class='userdanger'>IT HURTS!!!")
				aflame_cooldown = world.time + aflame_cooldown_time
				return
			else
				H.fire_stacks += 1
				H.IgniteMob()
				aflame_cooldown = world.time + aflame_cooldown_time
				visible_message("<span class='danger'>[src] claws at [A] setting them alight!</span>")
				to_chat(H, "<span class='userdanger'>Oh god, oh god. OH GOD! IT HURTS! PLEASE!")
				return
	if(H.SCP)
		to_chat(src, "<span class='warning'><I>[H] is a fellow SCP!</I></span>")
		return
	if(H.stat == DEAD)
		to_chat(src, "<span class='warning'><I>[H] is dead, it no longer can provide you with fuel.</I></span>")
		return
	if(istype(A, /obj/machinery/door))
		OpenDoor(A)
		return
	if(istype(A,/obj/structure/grille))
		playsound(get_turf(A), 'sound/effects/grillehit.ogg', 50, 1)
		qdel(A)
		return
	if(istype(A, /obj/structure/inflatable))
		var/obj/structure/inflatable/W = A
		W.deflate(violent=1)
	return

/mob/living/scp_457/proc/OpenDoor(obj/machinery/door/A)
	if(door_cooldown > world.time)
		return

	if(!istype(A))
		return

	if(!A.density)
		return

	if(!A.Adjacent(src))
		to_chat(src, "<span class='warning'>\The [A] is too far away.</span>")
		return

	var/open_time = 4 SECONDS
	if(istype(A, /obj/machinery/door/blast))
		if(get_area(A) == spawn_area)
			to_chat(src, "<span class='warning'>This blast door is too thermally protected, you cannot melt through it.</span>")
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
	src.visible_message("\The [src] melts \the [A]'s controls[check ? ", and rips it open!" : ", and breaks it!"]")

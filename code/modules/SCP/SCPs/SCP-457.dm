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
	health = 500
	maxHealth = 500
	var/next_emote = -1

	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7

	can_pull_size = 3
	a_intent = "harm"
	can_be_buckled = FALSE

	var/aflame_cooldown
	var/aflame_cooldown_time = 1.8 SECONDS

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
	add_verb(src, list(
		/mob/living/scp_457/proc/burn,
		/mob/living/scp_457/proc/hungryfuel,
		/mob/living/scp_457/proc/taunt1,
		/mob/living/scp_457/proc/taunt2,
		/mob/living/scp_457/proc/taunt3,
		/mob/living/scp_457/proc/no,
		/mob/living/scp_457/proc/yes,
		/mob/living/scp_457/proc/checkhealth,
	))

	. = ..()
	return

/mob/living/scp_457/Destroy()
	GLOB.scp457s -= src
	. = ..()
	return

/mob/living/scp_457/UnarmedAttack(atom/A)
	var/mob/living/carbon/human/H = A
	if(!istype(H))
		return
	if(H.SCP)
		to_chat(src, "<span class='warning'><I>[H] is a fellow SCP!</I></span>")
		return
	if(H.stat == DEAD)
		to_chat(src, "<span class='warning'><I>[H] is dead, it no longer can provide you with fuel.</I></span>")
		return
	if(istype(H))
		if(aflame_cooldown > world.time)
			to_chat(src, "<span class='warning'>You can't attack yet.</span>")
			return
		else
			if(prob(35))
				visible_message(SPAN_WARNING("[src] begins to claw at [A]!"))
				if(do_after(src, 1 SECOND, H))
					H.Weaken(10)
					H.visible_message("<span class='danger'>[src] claws at [H], the flame sending them to the floor!</span>")
					to_chat(H, "<span class='userdanger'>IT HURTS!!!</span>")
					health += 5
					aflame_cooldown = world.time + aflame_cooldown_time
				return
			else
				visible_message(SPAN_WARNING("[src] raises their firey arms and begins to attack [A]!"))
				if(do_after(src, 3 SECONDS, H))
					H.fire_stacks += 1
					H.IgniteMob()
					health += 15
					aflame_cooldown = world.time + aflame_cooldown_time
					visible_message("<span class='danger'>[src] grabs a hold of [A] setting them alight!</span>")
					to_chat(H, "<span class='userdanger'>Oh god, oh god. OH GOD! IT HURTS! PLEASE!</span>")
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

/datum/reagent/water/touch_mob(var/mob/living/scp_457/M)
    if(istype(M))
        M.adjustToxLoss(30)
        to_chat(M, "<span class='userdanger'>FUEL LESSENS, MAKE THEM PAY...</span>")

/obj/effect/landmark/respawner457
	name = "respawn"

/obj/effect/landmark/respawner457/proc/Respawn()
	new /mob/living/scp_457(src.loc)
	return

/mob/living/scp_457/Life()
	if(src.health == 0)
		var/obj/effect/landmark/respawner457/X = new /obj/effect/landmark/respawner457(loc)
		src.death(FALSE, "falls on their knees, the flame withering away.", TRUE)
		src.set_icon_state("fireguy_dead")
		sleep(300)
		X.visible_message("One single flame from [src] reforms, turning itself into a humanoid form once again.")
		X.Respawn()
		qdel(src)
		return

//457 emotes
/mob/living/scp_457/proc/burn()
	set category = "SCP-457"
	set name = "BURN!"
	if (world.time >= next_emote)
		playsound(src, 'sound/scp/voice/SCP457_burn.ogg', 30)
		next_emote = world.time + 10

/mob/living/scp_457/proc/hungryfuel()
	set category = "SCP-457"
	set name = "HUNGRY."
	if (world.time >= next_emote)
		playsound(src, 'sound/scp/voice/SCP457_hunger.ogg', 30)
		next_emote = world.time + 10

/mob/living/scp_457/proc/taunt1()
	set category = "SCP-457"
	set name = "Taunt 1"
	if (world.time >= next_emote)
		playsound(src, 'sound/scp/voice/SCP457t_1.ogg', 30)
		next_emote = world.time + 10

/mob/living/scp_457/proc/taunt2()
	set category = "SCP-457"
	set name = "Taunt 2"
	if (world.time >= next_emote)
		playsound(src, 'sound/scp/voice/SCP457t_2.ogg', 30)
		next_emote = world.time + 10

/mob/living/scp_457/proc/taunt3()
	set category = "SCP-457"
	set name = "Taunt 3"
	if (world.time >= next_emote)
		playsound(src, 'sound/scp/voice/SCP457t_3.ogg', 30)
		next_emote = world.time + 10

/mob/living/scp_457/proc/no()
	set category = "SCP-457"
	set name = "NO."
	if (world.time >= next_emote)
		playsound(src, 'sound/scp/voice/SCP457_no.ogg', 30)
		next_emote = world.time + 10

/mob/living/scp_457/proc/yes()
	set category = "SCP-457"
	set name = "YES."
	if (world.time >= next_emote)
		playsound(src, 'sound/scp/voice/SCP457_yes.ogg', 30)
		next_emote = world.time + 10

/mob/living/scp_457/proc/checkhealth()
	set category = "SCP-457"
	set name = "Check Health"
	to_chat(src, "HEALTH: [health]")

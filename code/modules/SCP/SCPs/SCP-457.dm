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

	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7

	maxHealth = 2000
	health = 2000

	can_pull_size = 0 // Can't pull things
	a_intent = "harm" // Doesn't switch places with people
	can_be_buckled = FALSE

	/// Reference to the area we were created in
	var/area/spawn_area

/mob/living/scp_457/Initialize()
	GLOB.scp457s += src
	spawn_area = get_area(src)
	add_language(LANGUAGE_EAL, FALSE)
	add_language(LANGUAGE_SKRELLIAN, FALSE)
	add_language(LANGUAGE_GUTTER, FALSE)
	add_language(LANGUAGE_SIGN, FALSE)
	add_language(LANGUAGE_ENGLISH, TRUE)
	return ..()

/mob/living/scp_457/Destroy()
	GLOB.scp173s -= src
	return ..()

/mob/living/scp_457/UnarmedAttack(atom/A)
	var/mob/living/carbon/human/H = A
	if(ishuman(A))
		if(H.fire_stacks -= 1)
			if(prob(50))
				H.Weaken(50)
				H.visible_message("<span class='danger'>[src] claws at [H]!</span>")
				to_chat(H, "<span class='userdanger'>IT HURTS!")
				return
			else
				H.fire_stacks += 1
				H.IgniteMob()
				visible_message("<span class='danger'>[src] claws at [A] setting them alight!</span>")
				return
		return
	if(H.SCP)
		to_chat(src, "<span class='warning'><I>[H] is a fellow SCP!</I></span>")
		return
	if(H.stat == DEAD)
		to_chat(src, "<span class='warning'><I>[H] is already dead!</I></span>")
		return
	if(istype(A, /obj/machinery/door))
		OpenDoor(A)
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

	var/open_time = 3 SECONDS
	if(istype(A, /obj/machinery/door/blast))
		if(get_area(A) == spawn_area)
			to_chat(src, "<span class='warning'>You cannot open blast doors in your containment zone.</span>")
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

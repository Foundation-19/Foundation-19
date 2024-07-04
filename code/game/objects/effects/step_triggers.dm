/* Simple object type, calls a proc when "stepped" on by something */

/obj/effect/step_trigger
	var/affect_ghosts = 0
	var/stopper = 1 // stops throwers
	invisibility = 101 // nope cant see this shit
	anchored = TRUE
	icon = 'icons/effects/effects.dmi'

/obj/effect/step_trigger/proc/Trigger(atom/movable/A)
	return 0

/obj/effect/step_trigger/Crossed(H as mob|obj)
	..()
	if(!H)
		return
	if(isobserver(H) && !(isghost(H) && affect_ghosts))
		return
	Trigger(H)



/* Tosses things in a certain direction */

/datum/movement_handler/no_move/toss

/obj/effect/step_trigger/thrower
	var/direction = SOUTH // the direction of throw
	var/tiles = 3	// if 0: forever until atom hits a stopper
	var/immobilize = 1 // if nonzero: prevents mobs from moving while they're being flung
	var/speed = 1	// delay of movement
	var/facedir = 0 // if 1: atom faces the direction of movement
	var/nostop = 0 // if 1: will only be stopped by teleporters
	var/list/affecting = list()
	icon_state = "ThrowerMarker"

/obj/effect/step_trigger/thrower/Trigger(atom/movable/AM)
	if(!AM || !istype(AM) || !AM.simulated)
		return
	var/curtiles = 0
	var/stopthrow = 0
	for(var/obj/effect/step_trigger/thrower/T in orange(2, src))
		if(AM in T.affecting)
			return

	if(ismob(AM))
		var/mob/M = AM
		if(immobilize)
			M.AddMovementHandler(/datum/movement_handler/no_move/toss)

	affecting.Add(AM)
	while(AM && !stopthrow)
		if(tiles)
			if(curtiles >= tiles)
				break
		if(AM.z != src.z)
			break

		curtiles++

		sleep(speed)

		// Calculate if we should stop the process
		if(!nostop)
			for(var/obj/effect/step_trigger/T in get_step(AM, direction))
				if(T.stopper && T != src)
					stopthrow = 1
		else
			for(var/obj/effect/step_trigger/teleporter/T in get_step(AM, direction))
				if(T.stopper)
					stopthrow = 1

		if(AM)
			var/predir = AM.dir
			step(AM, direction)
			if(!facedir)
				AM.setDir(predir)

	affecting.Remove(AM)

	if(ismob(AM))
		var/mob/M = AM
		if(immobilize)
			M.RemoveMovementHandler(/datum/movement_handler/no_move/toss)

/obj/effect/step_trigger/thrower/train/north
	direction = NORTH
	tiles = 0
	speed = 1

/* Stops things thrown by a thrower, doesn't do anything */

/obj/effect/step_trigger/stopper

/* Instant teleporter */

/obj/effect/step_trigger/teleporter
	var/teleport_x = 0	// teleportation coordinates (if one is null, then no teleport!)
	var/teleport_y = 0
	var/teleport_z = 0

/obj/effect/step_trigger/teleporter/Trigger(atom/movable/A)
	if(teleport_x && teleport_y && teleport_z)

		A.x = teleport_x
		A.y = teleport_y
		A.z = teleport_z

/* Random teleporter, teleports atoms to locations ranging from teleport_x - teleport_x_offset, etc */

/obj/effect/step_trigger/teleporter/random
	opacity = 1
	var/teleport_x_offset = 0
	var/teleport_y_offset = 0
	var/teleport_z_offset = 0

/obj/effect/step_trigger/teleporter/random/Trigger(atom/movable/A)
	var/turf/T = locate(rand(teleport_x, teleport_x_offset), rand(teleport_y, teleport_y_offset), rand(teleport_z, teleport_z_offset))
	if(T)
		A.forceMove(T)


//Death triggers

/obj/effect/step_trigger/death
	var/deathmessage = "You feel the life leaving your body as the realization of what just happened sets in..."
	var/deathalert = "stepped on a death trigger"
	icon_state = "DeathMarker"

/obj/effect/step_trigger/death/train/crushed/Trigger(atom/movable/A)
	if(isliving(A))
		to_chat(A, "<span class='danger'>[deathmessage]</span>")
		log_and_message_admins("[A] [deathalert]")
		var/mob/living/B = A
		B.gib() // Well what did you think would happen if you climbed off a high speed train???
		visible_message("<span class='warning'>[B] screams in agony as the trains wheels race over them!</span>")
		playsound(loc, 'sounds/effects/metalhit.ogg', 10, 0, 25) //Huh, I wonder what that was? Probably nothing..
	else
		visible_message("<span class=`warning`>[A] churns up as the train swallows it whole!</span>")
		playsound(loc, 'sounds/effects/metalscrape1.ogg', 10, 0, 4)
		qdel(A) //We don't want to qdel people, but we do want to clear their remains or items as those are much easier to churn up under a train.

/obj/effect/step_trigger/death/train/lost/Trigger(atom/movable/A) //No messages or sounds for lost triggers, as they're far enough away that it shouldn't matter.
	if(isliving(A))
		to_chat(A, "<span class='danger'>[deathmessage]</span>")
		log_and_message_admins("[A] [deathalert]")
		var/mob/living/B = A
		B.gib()
	else
		qdel(A)

/obj/effect/step_trigger/death/train/lost
	deathmessage = "You spiral down the tunnel at incredible speed feeling your body shatter as it collides with the ground multiple times.."
	deathalert = "was violently ejected from the transfer train!"

/obj/effect/step_trigger/death/train/crushed
	deathmessage = "You scream in pain as the feeling of metal races over you again and again crushing every bone in your body."
	deathalert = "was viscerally crushed to pieces by the transfer train!"

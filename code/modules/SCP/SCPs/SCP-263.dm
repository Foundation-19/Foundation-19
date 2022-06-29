/datum/scp/scp_263
	name = "SCP-263"
	designation = "263"
	classification = EUCLID

/mob/living/simple_animal/hostile/scp_263
	name = "SCP-263"
	desc = "An old black and white television, but you can't quite tell which model it is. The logo THOMSOM appears at the bottom."
	icon = 'icons/scp/scp-263.dmi'
	icon_state = "off"
	icon_living = "off"
	icon_dead = "off"
	var/next_emote = -1
	anchored = TRUE
	density = TRUE
	var/gaming = 0
	var/mob/living/carbon/human/target

/mob/living/simple_animal/hostile/scp_263/Initialize()

	..()
	add_language(/datum/language/english)


		// emotes
	verbs += list(
		/mob/living/simple_animal/hostile/scp_263/proc/On,
		/mob/living/simple_animal/hostile/scp_263/proc/Cash,
		/mob/living/simple_animal/hostile/scp_263/proc/Ash,
		/mob/living/simple_animal/hostile/scp_263/proc/Cursed,

	)

/mob/living/simple_animal/hostile/scp_263/proc/On()
	set category = "SCP-263"
	set name = "On"
	var/eye_contact = 0

	for(var/mob/living/carbon/H in viewers(src, null))
		if (world.time >= next_emote && gaming == 0)
		/*	if(H in gameshow)
				continue*/
			if(H.stat || is_blind(H))
				continue


			var/x_diff = H.x - src.x
			var/y_diff = H.y - src.y
			if(y_diff != 0 && x_diff == 0) //If we are not on the same vertical plane (up/down), mob is either above or below src
				if(y_diff < 0 && H.dir == NORTH) //Mob is below src and looking up
					if(dir == SOUTH) //src is looking down
						eye_contact = 1
						to_chat(H, "<span class='alert'>Welcome to the game show!</span>")
			if(eye_contact)
				icon_living = "animation"
				next_emote = world.time + 30
//				playsound(src, 'sound/scp/263/263-song.ogg', 30)
//				for(var/mob/living/carbon/human/M in hear(7, get_turf(src)))
//					if(M.is_deaf())
//						M << pick('sound/scp/263/263-song.ogg')
				sleep(85)
				icon_living = "on"
				gaming = 1
				target = H


/mob/living/simple_animal/hostile/scp_263/proc/Cash()
	set category = "SCP-263"
	set name = "Cash!"
	if(icon_state != "off" && world.time >= next_emote )
		icon_state = "cash"
		next_emote = world.time + 30
		gaming = 0

/mob/living/simple_animal/hostile/scp_263/proc/Ash()
	set category = "SCP-263"
	set name = "Ash!"
	if(icon_state != "off" && world.time >= next_emote )
		icon_state = "ash"
		next_emote = world.time + 30
		gaming = 0
		target.dust()

/mob/living/simple_animal/hostile/scp_263/proc/Cursed()
	set category = "SCP-263"
	set name = "Cursed"
	icon_state = "cursed"
	if (world.time >= next_emote)
		for(var/mob/living/carbon/human/M in hear(7, get_turf(src)))
			if(M.is_deaf())
//				M << pick('sound/scp/263/263-cursed.ogg')
				next_emote = world.time + 30
//		for(var/mob/living/simple_animal/hostile/scp_263/S in hear(7, get_turf(src)))
//			S << pick('sound/scp/263/263-cursed.ogg')

/*
/mob/living/simple_animal/hostile/scp263/proc/check_los()

    for(var/mob/living/carbon/H in viewers(src, null))
        if(H in gameshow)
            continue
        if(H.stat || is_blind(H))
            continue

        var/observed = 0
        var/eye_contact = 0

        var/x_diff = H.x - src.x
        var/y_diff = H.y - src.y
        if(y_diff != 0) //If we are not on the same vertical plane (up/down), mob is either above or below src
            if(y_diff < 0 && H.dir == NORTH) //Mob is below src and looking up
                observed = 1
                if(dir == SOUTH) //src is looking down
                    eye_contact = 1
            else if(y_diff > 0 && H.dir == SOUTH) //Mob is above src and looking down
                observed = 1
                if(dir == NORTH) //src is looking up
                    eye_contact = 1
        if(x_diff != 0) //If we are not on the same horizontal plane (left/right), mob is either left or right of src
            if(x_diff < 0 && H.dir == EAST) //Mob is left of src and looking right
                observed = 1
                if(dir == WEST) //src is looking left
                    eye_contact = 1
            else if(x_diff > 0 && H.dir == WEST) //Mob is right of src and looking left
                observed = 1
                if(dir == EAST) //src is looking right
                    eye_contact = 1

        if(eye_contact)
            to_chat(H, "<span class='alert'>Welcome to the game show!</span>")
            game_show_start(H)

    return */
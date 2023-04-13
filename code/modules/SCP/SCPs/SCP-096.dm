//SCP-096, nothing more need be said
#define STATE_096_DEAD -1
#define STATE_096_IDLE 0
#define STATE_096_SCREAMING 1
#define STATE_096_CHASE_START 2
#define STATE_096_CHASING 3
#define STATE_096_SLAUGHTER 4

#define CHASE_PLAYED (1<<0)
#define DOOM_PLAYED  (1<<1)

/datum/scp/scp_096
	name = "SCP-096"
	designation = "096"
	classification = EUCLID

/mob/living/simple_animal/hostile/scp096
	name = "???"
	desc = "No, no, you know not to look closely at it" //for non-targets
	SCP = /datum/scp/scp_096

	var/target_desc_1 = "A pale, emanciated figure. It looks almost human, but its limbs are long and skinny, and its face is......<span class='danger'>no. NO. NO!</span>" //for targets
	var/target_desc_2 = "<span class='danger'>NO!</span>" //on second examine

	var/scramble_desc = "A pale, emanciated figure. It looks almost human, but its limbs are long and skinny, its face <span class='info'>censored with several flashing squares.</span>"
	icon = 'icons/SCP/scp-096.dmi'
	icon_state = "scp"
	icon_living = "scp"
	icon_dead = "scp-dead"
	var/icon_idle = "scp"
	var/icon_scream = "scp-screaming"
	var/icon_chase = "scp-chasing"
	response_help  = "touches the"
	response_disarm = "pushes the"
	response_harm   = "hits the"
	anomalytype = SCP_096
	status_flags = NO_ANTAG
	ai_holder_type = /datum/ai_holder/simple_animal/inert // prevents 096 from moving

	// For scramble goggles.
	var/hud_scramble

	health = 600
	maxHealth = 600

	var/murder_sound = list('sound/voice/096-kill.ogg')
	var/hibernate = 0 //Disables SCP until toggled back to 0
	var/scare_played = 0 //Did we use the jumpscare sound yet ?

	var/list/kill_list = list() //list of people this guy is about to murder
	var/list/examine_urge_list = list() //tracks urge to examine
	var/list/satisfied_urges = list() // list of people who have satisfied their urge to check out 096's face.


	var/mob/living/carbon/target //current dude this guy is targeting
	var/list/target_blacklist = list(/mob/living/carbon/human/scp343) //List of mob types exempt from 096s targetting.
	var/target_distance_tolerance = 7

	var/current_state = STATE_096_IDLE

	var/staggered = 0

	// Play doom / chase message once to each target
	var/list/message_played_list = list()

	var/damage_state = 0

/datum/say_list/scp096
	emote_hear = list("makes a faint groaning sound")
	emote_see = list("shuffles around aimlessly", "shivers")

/mob/living/simple_animal/hostile/scp096/New()
	hud_scramble = new /image/hud_overlay('icons/SCP/hud_scramble.dmi', src, "scramble-alive")
	..()

/mob/living/simple_animal/hostile/scp096/update_icon()
	if(stat == DEAD)
		icon_state = icon_dead
	else
		switch(current_state)
			if(STATE_096_IDLE)
				icon_state = icon_idle
			if(STATE_096_SCREAMING)
				icon_state = icon_scream
			if(STATE_096_CHASING, STATE_096_CHASE_START, STATE_096_SLAUGHTER)
				icon_state = icon_chase

	if(hud_scramble)
		var/image/holder = hud_scramble
		if(stat == DEAD)
			holder.icon_state = "scramble-dead"
		else
			holder.icon_state = "scramble-alive"

		hud_scramble = holder

/mob/living/simple_animal/hostile/scp096/Destroy()
	kill_list = null
	examine_urge_list = null
	satisfied_urges = null
	examine_urge_list = null
	message_played_list = null
	return ..()

/mob/living/simple_animal/hostile/scp096/Life()
	if(hibernate)
		return

	check_los()
	staggered = max(staggered/8 - 1, 0)
	adjustBruteLoss(-5)

	update_icon()

	if(current_state == STATE_096_SCREAMING) //we're still screaming
		return

	//Pick the next target
	if(kill_list.len)
		// Sets both state and target var
		select_target()
	else
		current_state = STATE_096_IDLE
		update_icon()

	if(target && current_state == STATE_096_CHASE_START)
		handle_target(target)

//Check if any carbon mob can see us
/mob/living/simple_animal/hostile/scp096/proc/check_los()
	for(var/mob/living/carbon/human/H in viewers(src, null))
		if(H in kill_list)
			continue
		if(H in satisfied_urges)
			continue
		if(!H.can_see(src, 1)) //096 technically memetic and therefore memetic blocking apparel should blockout his face
			continue
		if(H.type in target_blacklist)
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

		if(observed)
			add_examine_urge(H)
		if(eye_contact)
			to_chat(H, SPAN_ALERT("You are facing it, and it is facing you..."))
			add_examine_urge(H)

	return

/mob/living/simple_animal/hostile/scp096/proc/add_examine_urge(mob/living/carbon/human/H)
	if(!(H in examine_urge_list))
		examine_urge_list[H] = 0

	switch(examine_urge_list[H])
		if(1)
			to_chat(H, SPAN_ALERT("You feel the urge to examine it..."))
		if(3)
			to_chat(H, SPAN_ALERT("It is becoming difficult to resist the urge to examine it ..."))
		if(5)
			to_chat(H, SPAN_ALERT("Unable to resist the urge, you look closely..."))
			spawn(10)
				specialexamine(H)
				satisfied_urges += H

	examine_urge_list[H] = min(examine_urge_list[H]+1, 5)
	addtimer(CALLBACK(src, .proc/reduce_examine_urge, H), 200 SECONDS)

/mob/living/simple_animal/hostile/scp096/proc/reduce_examine_urge(mob/living/carbon/human/H)
	if (!(H in examine_urge_list))
		return

	if (examine_urge_list[H] == 1 && !(H in kill_list))
		to_chat(H, SPAN_NOTICE("The urge fades away..."))

	examine_urge_list[H] = max(examine_urge_list[H]-1, 0)

/mob/living/simple_animal/hostile/scp096/examine(userguy)
	if(istype(userguy, /mob/living/carbon))
		return specialexamine(userguy)
	return ..()

/mob/living/simple_animal/hostile/scp096/proc/specialexamine(mob/userguy) //Snowflaked.
	if (!iscarbon(userguy))
		return
	// Do not let blind folks examine 096. Doesn't make sense.
	if(ishuman(userguy))
		var/mob/living/carbon/human/H = userguy
		if(!H.can_see(src))
			return
	// Do not let unconscious or dead people examine 096.
	// Dead as in ghost in dead body, not as in ghost
	if(userguy.stat)
		return

	satisfied_urges += userguy
	var/protected = (userguy in GLOB.scramble_hud_protected)
	var/scramblehud = (userguy in GLOB.scramble_hud_users)
	if(scramblehud)
		. = scramble_desc
		if(protected)
			return
	if (!(userguy in kill_list))
		kill_list += userguy
		message_played_list[userguy] = 0
		if(!scramblehud)
			. = target_desc_1
		if(userguy)
			addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, userguy, SPAN_ALERT("That was a mistake. Run")), 20 SECONDS)
			addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, userguy, SPAN_DANGER("RUN")), 30 SECONDS)
	else if(!scramblehud)
		. = target_desc_2

	if(current_state == STATE_096_IDLE)
		dir = SOUTH
		visible_message(SPAN_DANGER("[src] SCREAMS!"))
		playsound(get_turf(src), 'sound/voice/096-rage.ogg', 100)
		current_state = STATE_096_SCREAMING
		icon_state = "scp-screaming"
		spawn(290)
			icon_state = "scp"
			current_state = STATE_096_CHASE_START
			update_icon()
	return

/mob/living/simple_animal/hostile/scp096/proc/select_target()
	var/mob/living/carbon/human/closest_fella
	var/closest_fella_distance = 1984
	// Iterate through every mob in the kill list and get dist from them
	for(var/mob/living/carbon/H in kill_list)
		if(!H || H.stat == DEAD)
			kill_list -= H
			continue
		var/Hdist = get_dist(src, H)
		if(Hdist < closest_fella_distance)
			closest_fella = H
			closest_fella_distance = Hdist
	// Set the guy closest to us as target if our target is null, expired or too far away
	if(!target || target.stat == DEAD || get_dist(target, src) > target_distance_tolerance)
		target = closest_fella
	current_state = STATE_096_CHASE_START

/mob/living/simple_animal/hostile/scp096/proc/handle_target(mob/living/carbon/target)

	if(!target || current_state >= STATE_096_CHASING) //Sanity
		return

	if(target.stat == DEAD)
		target = null
		return

	if(buckled)
		visible_message(SPAN_DANGER("[src] breaks out of its restraints!"))
//		buckled.resist()

	var/turf/target_turf

	//Send the warning that we are is homing in
	target_turf = get_turf(target)

	if(!(message_played_list[target] | CHASE_PLAYED))
		to_chat(target, SPAN_DANGER("You saw its face"))
		message_played_list[target] |= CHASE_PLAYED

	//Rampage along a path to get to them,
	var/turf/next_turf = get_step_towards(src, target)
	var/limit = 100
	spawn()
		current_state = STATE_096_CHASING
		update_icon()
		while(get_turf(src) != target_turf && limit > 0)
			if(current_state == STATE_096_CHASING)
				target_turf = get_turf(target)

				for(var/obj/structure/window/W in next_turf)
//					W.health -= 1000
					sleep(5)
				for(var/turf/simulated/wall/E in next_turf)
					E.ex_act(1)
					sleep(5)
				for(var/obj/structure/table/O in next_turf)
					O.ex_act(1)
					sleep(5)
				for(var/obj/structure/closet/C in next_turf)
					C.ex_act(1)
					sleep(5)
				for(var/obj/structure/grille/G in next_turf)
					G.ex_act(1)
					sleep(5)
				for(var/obj/machinery/door/D in next_turf)
					if(D.density)
						D.open()
						sleep(5)
				if(!next_turf.CanPass(src, next_turf)) //Once we cleared everything we could, check one last time if we can pass
					sleep(10)

				if(!(message_played_list[target] | DOOM_PLAYED) && get_dist(src,target) < 7)
					to_chat(target, SPAN_DANGER("YOU SAW ITS FACE"))
					message_played_list[target] |= DOOM_PLAYED

				forceMove(next_turf)

				if(is_different_level(target_turf))
					next_turf = target_turf
					to_chat(target, SPAN_DANGER("DID YOU THINK YOU COULD HIDE?"))
				else
					dir = get_dir(src, target)
					next_turf = get_step(src, get_dir(next_turf,target))
			limit--
			sleep(2 + round(staggered/8))
		current_state = STATE_096_IDLE

/mob/living/simple_animal/hostile/scp096/proc/is_different_level(turf/target_turf)
	return target_turf.z != z

//This performs an immediate murder check, meant to avoid people cheesing us by just running faster than Life() refresh
/mob/living/simple_animal/hostile/scp096/proc/check_murder()
	//See if we're able to murder anyone
	for(var/mob/living/carbon/M in get_turf(src))
		if(M in kill_list)
			murder(M)
			break

/mob/living/simple_animal/hostile/scp096/forceMove(atom/destination, no_tp = 0)
	..()
	if(current_state > STATE_096_SCREAMING)
		check_murder()

/mob/living/simple_animal/hostile/scp096/proc/murder(mob/living/T)
	if(T in kill_list)
		current_state = STATE_096_SLAUGHTER
		T.loc = src.loc
		visible_message(SPAN_DANGER("[src] grabs [T]!"))
		dir = 2
		T.anchored = TRUE
		var/original_y = T.pixel_y
		T.pixel_y = 10

		for(var/mob/living/L in viewers(src, null))
			shake_camera(L, 19, 1)

		sleep(20)

		T.anchored = FALSE
		T.pixel_y = original_y
		if(ishuman(T))
			T.emote("scream")
		playsound(T.loc, pick(murder_sound), 100)

		//Warn everyone
		visible_message(SPAN_DANGER("[src] tears [T] apart!"))

		T.gib()

		//Logging stuff
		log_admin("[T] ([T.ckey]) has been torn apart by an active [src].")
		message_admins("ALERT: <A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[T.x];Y=[T.y];Z=[T.z]'>[T.real_name]</a> has been torn apart by an active [src].")
		kill_list -= T

		if (target == T)
			target = null

		current_state = STATE_096_CHASING

/mob/living/simple_animal/hostile/scp096/bullet_act(obj/item/projectile/Proj)
	if(!Proj || Proj.damage <= 0)
		return 0

	visible_message(SPAN_DANGER("[src] is staggered by [Proj]!"))
	adjustBruteLoss(Proj.damage)
	return 1

/mob/living/simple_animal/hostile/scp096/adjustBruteLoss(damage)

	health = clamp(health - damage, 0, maxHealth)

	if(damage > 0)
		staggered += damage

	var/old_damage_state = damage_state
	damage_state = round( (1-health/maxHealth) * 3.99 )

	if(old_damage_state < damage_state)
		visible_message(SPAN_DANGER("Chunks of flesh and bone are torn out of [src]!"))
	else if(old_damage_state > damage_state)
		visible_message(SPAN_DANGER("[src] regenerates some of its missing pieces!"))

//You cannot destroy us, fool!
/mob/living/simple_animal/hostile/scp096/ex_act(severity)
	var/damage = 0
	switch (severity)
		if(1.0)
			damage = 500
		if(2.0)
			damage = 60
		if(3.0)
			damage = 30
	visible_message(SPAN_DANGER("[src] is staggered by the explosion!"))
	adjustBruteLoss(damage)
	return 1

/mob/living/simple_animal/hostile/attackby(obj/item/O as obj, mob/user as mob)  //Marker -Agouri
	..()
	if(O.force)
		visible_message(SPAN_DANGER("[src] is staggered by \the [O]!"))
		adjustBruteLoss(O.force)
#undef CHASE_PLAYED
#undef DOOM_PLAYED

#undef STATE_096_DEAD
#undef STATE_096_IDLE
#undef STATE_096_SCREAMING
#undef STATE_096_CHASE_START
#undef STATE_096_CHASING
#undef STATE_096_SLAUGHTER

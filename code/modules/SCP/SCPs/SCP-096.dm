#define STATE_096_IDLE		(1<<0)
#define STATE_096_SCREAMING	(1<<1)
#define STATE_096_CHASING	(1<<2)
#define STATE_096_SLAUGHTER	(1<<3)
#define STATE_096_STAGGERED	(1<<4)

/mob/living/scp096
	name = "????"
	icon = 'icons/SCP/scp-096.dmi'

	icon_state = "scp"
	health = 2000
	maxHealth = 2000

	can_be_buckled = FALSE

	available_maneuvers = list(/decl/maneuver/leap)

	//Config

	///View probability when idle
	var/idle_view_prob = 20
	///View probability when chasing
	var/chasing_view_prob = 40
	///How long until we can emote again?
	var/emote_cooldown = 40 SECONDS
	///Speed at which we move at
	var/scp096_speed = 0.2
	///How close we have to be before we can leap at a target
	var/scp096_leap_range = 4
	///Maximium JPS distance. Dont fuck with this unless you know what you're doing.
	var/maxJPSdistance = 240

	//Mechanicial

	///Current Target
	var/mob/living/carbon/human/target
	///Possible targets we can pick from
	var/list/mob/living/carbon/human/targets
	///Individuals who were viewing us
	var/list/weakref/oldViewers

	///Our current AI state
	var/current_state = STATE_096_IDLE
	///Our description to scramblers
	var/scramble_desc
	///Emote Cooldown tracker
	var/emote_cooldown_track = 0
	///096's current pathing path. We store this to avoid calling JPS unnecesarily.
	var/list/current_path
	///Targets previous turf, this is kept in order to avoid calling JPS unnecesarily.
	var/weakref/lastTargetTurf
	///Leaping
	var/decl/maneuver/leap/leapHandler = new /decl/maneuver/leap()
	///How long 096 is staggered for
	var/stagger_counter
	var/seedarkness  =  1

/mob/living/scp096/verb/toggle_darkness()
	set name = "Toggle Darkness"
	set category = "IC"
	seedarkness = !(seedarkness)
	set_see_invisible(SEE_INVISIBLE_NOLIGHTING)
	to_chat(src, "You [(seedarkness?"now":"no longer")] see darkness.")

/mob/living/scp096/verb/stop_screaming()
	set name = "Stop scream"
	set category = "IC"

	target = null
	LAZYCLEARLIST(targets)
	current_state = STATE_096_IDLE
	icon_state = "scp"
	update_icon()
/mob/living/scp096/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"????", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_EUCLID, //Obj Class
		"096", //Numerical Designation
		SCP_MEMETIC
	)

	SCP.memeticFlags = MINSPECT|MPHOTO|MCAMERA
	SCP.memetic_proc = TYPE_PROC_REF(/mob/living/scp096, trigger)
	SCP.compInit()

	leapHandler.stamina_cost = 0
	scramble_desc = "A pale, emanciated figure. It looks almost human, but its limbs are long and skinny, its face is [SPAN_INFO("censored with several flashing squares.")]"
	desc = "A pale white figure, with lengthy arms. You slowly scan the creature bottom up, from its skinny atrophied legs to its...face. Its face. Oh god [SPAN_DANGER("its horrible [SPAN_BOLD("face")]!")]"

	LAZYINITLIST(targets)
	LAZYINITLIST(oldViewers)
	LAZYINITLIST(current_path)

/mob/living/scp096/Destroy()
	target = null
	LAZYCLEARLIST(targets)
	LAZYCLEARLIST(oldViewers)
	LAZYCLEARLIST(current_path)

	..()

//Mechanics

///Triggers 096 on a target
/mob/living/scp096/proc/trigger(mob/living/carbon/human/Ptarget)
	if(Ptarget in targets)
		return

	if(istype(Ptarget.client.eye, /obj/machinery/camera))
		to_chat(Ptarget, SPAN_DANGER("You catch a glimpse of [SPAN_BOLD("its face")] through the monitor!"))

	switch(current_state)
		if(STATE_096_IDLE)
			icon_state = "scp-screaming"
			current_state = STATE_096_SCREAMING
			update_icon()

			target = Ptarget
			targets += Ptarget

			playsound(src, 'sounds/scp/096/096-rage.ogg', 100, ignore_walls = TRUE)
			addtimer(CALLBACK(src, PROC_REF(finish_screaming)), 30 SECONDS)
		if(STATE_096_SCREAMING, STATE_096_CHASING, STATE_096_SLAUGHTER, STATE_096_STAGGERED)
			targets += Ptarget

/mob/living/scp096/proc/finish_screaming()
	current_state = STATE_096_CHASING
	icon_state = "scp-chasing"
	update_icon()
	chase_noise()

/mob/living/scp096/proc/chase_noise()
	if(current_state == STATE_096_IDLE)
		return
	playsound(src, 'sounds/scp/096/096-chase.ogg', 100, ignore_walls = TRUE)
	addtimer(CALLBACK(src, PROC_REF(chase_noise)), 10 SECONDS)

/mob/living/scp096/proc/OpenDoor(obj/machinery/door/A)
	if(!istype(A))
		return

	if(!A.density)
		return

	if(!A.Adjacent(src))
		to_chat(src, SPAN_WARNING("\The [A] is too far away."))
		return

	var/open_time = 0.5 SECOND
	if(istype(A, /obj/machinery/door/blast))
		open_time = 2.5 SECONDS

	if(istype(A, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/AR = A
		if(AR.locked)
			open_time += 0.5 SECONDS
		if(AR.welded)
			open_time += 0.5 SECONDS
		if(AR.secured_wires)
			open_time += 0.5 SECONDS

	visible_message(SPAN_WARNING("\The [src] begins to pry open \the [A]!"))
	playsound(get_turf(A), 'sounds/machines/airlock_creaking.ogg', 35, 1)
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
	A.set_broken(TRUE)
	var/check = A.open(1)
	src.visible_message("\The [src] slices \the [A]'s controls[check ? ", ripping it open!" : ", breaking it!"]")

// AI procs

///Handles 096 AI
/mob/living/scp096/get_status_tab_items()
	. = ..()
	for(var/mob/living/carbon/human/Ptarget in targets)
		if(Ptarget != null)
			. += "Real Name: [Ptarget.real_name]"
			. += "Job: [Ptarget.job]"
			. += "Locate X: [Ptarget.x]"
			. += "Locate Y: [Ptarget.y]"
			. += "Locate Z: [Ptarget.z]"
//
/mob/living/scp096/proc/handle_AI()
	switch(current_state)
		if(STATE_096_IDLE)
			if(prob(45) && ((world.time - emote_cooldown_track) > emote_cooldown))
				audible_message(pick("[src] cries.", "[src] sobs.", "[src] wails."))
				playsound(src, 'sounds/scp/096/096-idle.ogg', 80, ignore_walls = TRUE)
				emote_cooldown_track = world.time
		if(STATE_096_CHASING)
			//Find path to target
			for(var/mob/living/carbon/human/Ptarget in targets)
				if(LAZYLEN(current_path))
					break
				target = Ptarget
				lastTargetTurf = get_turf(target)
				current_path = get_path_to(src, target, maxJPSdistance)
			//If we have no more targets, we go back to idle
			if(!LAZYLEN(targets))
				current_state = STATE_096_IDLE
				icon_state = "scp"
				target = null
				current_path = null
				//This resets the screaming noise for everyone.
				for(var/mob/living/carbon/human/hearer in hearers(world.view, src))
					sound_to(hearer, sound(null))
				update_icon()
				return
			//If we havent found a path for any of our targets, we notify admins and switch ourselves to the first target in our list. Path code will also use byond's inherent pathfinding for this life call.
			if(!LAZYLEN(current_path))
				log_and_message_staff("Instance of SCP-[SCP.designation] failed to find paths for targets. Switching to byond pathfinding for current life iteration.", src, loc)
				target = targets[1]
				lastTargetTurf = get_turf(target)
			//If the target moved, we must regenerate the path list
			if(get_turf(target) != lastTargetTurf)
				current_path = get_path_to(src, target, maxJPSdistance)
				//if we cant path to target we reset the target
				if(!LAZYLEN(current_path))
					target = null
					return
				lastTargetTurf = get_turf(target)
		if(STATE_096_STAGGERED)
			if(world.time > stagger_counter)
				current_state = STATE_096_CHASING
	switch(current_state)
		if(STATE_096_IDLE)
			if(prob(45) && ((world.time - emote_cooldown_track) > emote_cooldown))
				audible_message(pick("[src] cries.", "[src] sobs.", "[src] wails."))
				playsound(src, 'sounds/scp/096/096-idle.ogg', 80, ignore_walls = TRUE)
				emote_cooldown_track = world.time
		if(STATE_096_CHASING)
			//Find path to target
			for(var/mob/living/carbon/human/Ptarget in targets)
				if(LAZYLEN(current_path))
					break
				target = Ptarget
				lastTargetTurf = get_turf(target)
				current_path = get_path_to(src, target, maxJPSdistance)
			//If we have no more targets, we go back to idle
			if(!LAZYLEN(targets))
				current_state = STATE_096_IDLE
				icon_state = "scp"
				target = null
				current_path = null
				//This resets the screaming noise for everyone.
				for(var/mob/living/carbon/human/hearer in hearers(world.view, src))
					sound_to(hearer, sound(null))
				update_icon()
				return
			//If we havent found a path for any of our targets, we notify admins and switch ourselves to the first target in our list. Path code will also use byond's inherent pathfinding for this life call.
			if(!LAZYLEN(current_path))
				log_and_message_staff("Instance of SCP-[SCP.designation] failed to find paths for targets. Switching to byond pathfinding for current life iteration.", src, loc)
				target = targets[1]
				lastTargetTurf = get_turf(target)
			//If the target moved, we must regenerate the path list
			if(get_turf(target) != lastTargetTurf)
				current_path = get_path_to(src, target, maxJPSdistance)
				//if we cant path to target we reset the target
				if(!LAZYLEN(current_path))
					target = null
					return
				lastTargetTurf = get_turf(target)
			//Gets our next step
			LAZYINITLIST(current_path)
			var/turf/next_step = LAZYLEN(current_path) ? current_path[1] : get_step_towards(src, target)
			//Get rid of obstacles
			if(next_step.contains_dense_objects())
				for(var/atom/obstacle in next_step)
					if(!obstacle.density)
						continue
					if(isturf(obstacle) && !istype(obstacle, /turf/simulated/wall))
						continue
					UnarmedAttack(obstacle)
				if(!(src in next_step))
					return
			//Murder!
			if(get_dist(src, target) <= 1)
				UnarmedAttack(target)
				return
			else if((get_dist(src, target) <= scp096_leap_range) && leapHandler.can_be_used_by(src, target, TRUE))
				leapHandler.perform(src, target, 5)
				return
			step_towards(src, next_step, scp096_speed)
			if(get_turf(src) != next_step)
				target = null
				current_path = null
				return
			current_path -= next_step
		if(STATE_096_STAGGERED)
			if(world.time > stagger_counter)
				current_state = STATE_096_CHASING

//Overrides

/mob/living/scp096/Life()
	//Sets the probability of someone seeing 096's face based on its current state
	var/probability_to_view
	switch(current_state)
		if(STATE_096_IDLE, STATE_096_SCREAMING)
			probability_to_view = idle_view_prob
		if(STATE_096_CHASING, STATE_096_SLAUGHTER, STATE_096_STAGGERED)
			probability_to_view = chasing_view_prob
	//Applies probability to each new viewer
	for(var/mob/living/carbon/human/viewer in viewers(world.view, src))
		if(viewer in oldViewers)
			continue
		if(!viewer.can_see(src, TRUE))
			continue
		var/message = "[SPAN_NOTICE("You notice [src], and instinctively look away ")]"
		if(prob(probability_to_view))
			message += "[SPAN_NOTICE("but you catch a glimpse of")] [SPAN_DANGER("its [SPAN_BOLD("face")]!")]"
			trigger(viewer)
		else
			message += "[SPAN_NOTICE("managing to avoid seeing its face.")]"

		to_chat(viewer, message)
		oldViewers += viewer

	//Now we remove any oldViewers that are no longer looking at 096
	for(var/mob/living/carbon/human/oldViewer in oldViewers)
		if(!oldViewer.can_see(src, TRUE))
			oldViewers -= oldViewer

	adjustBruteLoss(-10)
	handle_AI()

/mob/living/scp096/examine(mob/user, distance, infix, suffix)
	if(user in GLOB.scramble_hud_users)
		to_chat(user, scramble_desc)
		return TRUE
	else
		return ..()

/mob/living/scp096/update_icon()
	switch(current_state)
		if(STATE_096_IDLE)
			icon_state = "scp"
		if(STATE_096_SCREAMING)
			icon_state = "scp-screaming"
		if(STATE_096_CHASING, STATE_096_SLAUGHTER, STATE_096_STAGGERED)
			icon_state = "scp-chasing"
	..()

//Our leap range
/mob/living/scp096/get_jump_distance()
	return scp096_leap_range

/mob/living/scp096/UnarmedAttack(atom/A as obj|mob|turf)
	if(A == src)
		return

	else if(isobj(A) || istype(A, /turf/simulated/wall))
		if(istype(A, /obj/machinery/door))
			OpenDoor(A)
			return
		else
			A.attack_generic(src, rand(120,350), "smashes")
	else if(ismob(A) && (A != target))
		visible_message(SPAN_DANGER("[src] rips [A] apart trying to get at [target]!"))
		var/mob/obstacle = A
		obstacle.gib()
	else if(A == target)
		current_state = STATE_096_SLAUGHTER

		target.loc = loc
		target.anchored = TRUE //Only humans can use grab so we have to do this ugly shit
		visible_message(SPAN_DANGER("[src] grabs [target] and starts trying to pull [target.p_them()] apart!"))

		playsound(src, 'sounds/scp/096/096-kill.ogg', 100)
		target.emote("scream")

		if(!do_after(src, 2 SECONDS, target))
			target.anchored = FALSE
			return

		visible_message(SPAN_DANGER("[src] tears [target] apart!"))
		target.anchored = FALSE
		target.gib()

		log_admin("[target] ([target.ckey]) has been torn apart by an active SCP-[SCP.designation].")
		message_staff("ALERT: [target.real_name] [ADMIN_JMP(target)] has been torn apart by an active SCP-[SCP.designation].")
		targets -= target
		target = null
		current_path = null
		current_state = STATE_096_CHASING

//Lets us attack after a leap
/mob/living/scp096/post_maneuver()
	if((get_dist(src, target) <= 1) && (current_state != STATE_096_SLAUGHTER))
		UnarmedAttack(target)

/mob/living/scp096/bullet_act(obj/item/projectile/Proj)
	if(!Proj || Proj.damage <= 0)
		return
	if(Proj.damage < 100)
		visible_message(SPAN_DANGER("[src] is hit by [Proj], but the flesh regenerates and [src] seems unaffected!"))
	else if(current_state != STATE_096_IDLE)
		visible_message(SPAN_DANGER("[src] is hit by [Proj] blowing a large chunk of flesh off! [src] is momentarily staggered!"))
		if(current_state == STATE_096_STAGGERED)
			stagger_counter = stagger_counter + 1 SECOND
		else
			stagger_counter = world.time + 1 SECOND
			current_state = STATE_096_STAGGERED

/mob/living/scp096/adjustBruteLoss(damage)
	health = clamp((health - damage), 200, maxHealth)

/mob/living/scp096/ex_act(severity)
	. = ..()
	if(current_state != STATE_096_IDLE)
		visible_message(SPAN_DANGER("[src] is staggered by the explosion!"))
		if(current_state == STATE_096_STAGGERED)
			stagger_counter = stagger_counter + 5 SECOND
		else
			stagger_counter = world.time + 5 SECOND
			current_state = STATE_096_STAGGERED

/mob/living/scp096/movement_delay()
	return -2

/mob/living/scp096/get_status_tab_items()
	. = ..()
	for(var/mob/living/carbon/human/Ptarget in targets)
		if(Ptarget != null)
			. += "Real Name: [Ptarget.real_name]"
			. += "Job: [Ptarget.job]"
			. += "Locate X: [Ptarget.x]"
			. += "Locate Y: [Ptarget.y]"
			. += "Locate Z: [Ptarget.z]"

/obj/item/photo/scp096/scp096_photo
	name =  "???? photo"

/obj/item/photo/scp096/scp096_photo/examine(mob/living/user)
	. = ..()
	if(!istype(user, /mob/living/scp096))
		var/mob/living/scp096/scp_to_trigger = locate(/mob/living/scp096) in GLOB.SCP_list
		if(get_dist(user, src) <= 1 && isliving(user))
			scp_to_trigger.trigger(user)
			to_chat(user, SPAN_DANGER("You catch [scp_to_trigger]"))
		else
			to_chat(user, SPAN_NOTICE("It is too far away."))

#undef STATE_096_IDLE
#undef STATE_096_SCREAMING
#undef STATE_096_CHASING
#undef STATE_096_SLAUGHTER
#undef STATE_096_STAGGERED

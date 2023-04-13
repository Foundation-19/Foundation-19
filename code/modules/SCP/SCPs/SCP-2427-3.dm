GLOBAL_LIST_EMPTY(scp2427_3s)

/datum/scp/scp_2427_3
	name = "SCP-2427-3"
	designation = "2427-3"
	classification = EUCLID

/obj/item/natural_weapon/leg_2427_3
	name = "robotic leg"
	attack_verb = list("stabbed")
	hitsound = 'sound/scp/2427/stab.ogg'
	damtype = BRUTE
	melee_accuracy_bonus = 200
	edge = 1
	force = 36

/mob/living/simple_animal/hostile/scp_2427_3
	name = "SCP-2427-3"
	desc = "An amalgamation of exposed wires and robotic parts. It has 4 spider-like legs and a metal mask in place of the 'head'."
	icon = 'icons/SCP/scp-2427-3.dmi'
	icon_state = null
	icon_dead = "dead"
	pixel_x = -8
	default_pixel_x = -8

	SCP = /datum/scp/scp_2427_3
	status_flags = NO_ANTAG

	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7

	maxHealth = 1500
	health = 1500

	movement_cooldown = 5
	movement_sound = 'sound/mecha/mechmove04.ogg'

	a_intent = "harm"
	can_be_buckled = FALSE

	natural_weapon = /obj/item/natural_weapon/leg_2427_3
	natural_armor = list(
		melee = ARMOR_MELEE_KNIVES
		)

	var/satiety = 300
	/// How much satiety is reduced per tick
	var/satiety_reduction_per_tick = 0.5
	/// Upon going to that point or above - the mob goes into is_sleeping stage and is unable to act/speak/move for some time
	var/max_satiety = 500
	/// Upon that point, the mob is on rampage until getting above half of max satiety and can attack anything
	var/min_satiety = 0
	/// When TRUE - it ignores purity list and can attack anything
	var/enraged = FALSE
	var/is_sleeping = FALSE
	/// If is_sleeping, getting down to that health will wake us up
	var/wakeup_health = 0
	var/door_cooldown
	var/area/spawn_area = null
	// Upon encountering a mob, they are added in one of these
	var/list/purity_list = list()
	var/list/impurity_list = list()

/mob/living/simple_animal/hostile/scp_2427_3/Initialize()
	GLOB.scp2427_3s |= src
	spawn_area = get_area(src)
	add_language(LANGUAGE_ENGLISH, FALSE)
	return ..()

/mob/living/simple_animal/hostile/scp_2427_3/Destroy()
	GLOB.scp2427_3s -= src
	return ..()

/mob/living/simple_animal/hostile/scp_2427_3/Life()
	. = ..()
	if(!.)
		return
	if(!ckey)
		return
	if(is_sleeping)
		return
	if(prob(5)) // Random purity check!
		var/list/pure_check = list()
		for(var/mob/living/L in dview(7, src))
			if(L.stat)
				continue
			if((L in impurity_list) || (L in purity_list))
				continue
			if(!L.client)
				continue
			pure_check += L
		var/mob/living/L
		if(LAZYLEN(pure_check))
			L = pick(pure_check)
		CheckPurity(L)
	AdjustSatiety(-satiety_reduction_per_tick)
	if(satiety <= min_satiety) // Starvation, so you don't just run at mach 3 all the time
		adjustBruteLoss(maxHealth * 0.01)

/mob/living/simple_animal/hostile/scp_2427_3/get_status_tab_items()
	. = ..()
	if(stat == DEAD)
		. += "WE ARE REBOOTING."
	else if(is_sleeping)
		. += "WE ARE ASLEEP."

	if(satiety <= min_satiety)
		. += "Satiety: I NEED MEAT RIGHT NOW!"
	else
		. += "Satiety: [round(satiety)]/[max_satiety]"

/mob/living/simple_animal/hostile/scp_2427_3/examinate(atom/A as mob|obj|turf in view())
	if(UNLINT(..()))
		return 1

	if(isliving(A) && get_dir(A, src) == A.dir) // Looking in our direction
		CheckPurity(A)

	if(A in impurity_list)
		to_chat(src, SPAN_USERDANGER("SUBJECT IMPURE! IMPURE. IMPURE. IMPURE."))
		playsound(src, 'sound/machines/synth_no.ogg', 25, TRUE)
		return

	if(A in purity_list)
		to_chat(src, SPAN_GOOD("SUBJECT IS PURE..?"))
		playsound(src, 'sound/machines/synth_yes.ogg', 25, TRUE)
		return

/mob/living/simple_animal/hostile/scp_2427_3/updatehealth()
	. = ..()
	if(is_sleeping && stat != DEAD && health < wakeup_health)
		WakeUp()

/mob/living/simple_animal/hostile/scp_2427_3/death(gibbed, deathmessage = "falls on the ground, beginning reboot process.", show_dead_message)
	to_chat(src, SPAN_OCCULT("You begin the reboot process. Avoid leaving the body."))
	playsound(src, 'sound/mecha/lowpower.ogg', 50, FALSE)
	addtimer(CALLBACK(src, .proc/TimeRespawn), 5 MINUTES)
	return ..()

/mob/living/simple_animal/hostile/scp_2427_3/gib()
	return FALSE

/mob/living/simple_animal/hostile/scp_2427_3/dust()
	return FALSE

/mob/living/simple_animal/hostile/scp_2427_3/UnarmedAttack(atom/A)
	if(is_sleeping)
		return
	if(istype(A, /obj/machinery/door))
		OpenDoor(A)
		return
	if(A in purity_list)
		to_chat(src, SPAN_WARNING("They are pure... We will grant their wish."))
		return
	if(ishuman(A) && !IsEnraged() && !(A in impurity_list))
		to_chat(src, SPAN_WARNING("We cannot decide if they are pure or not just yet..."))
		return
	if(isliving(A))
		var/mob/living/L = A
		// Brute loss part is mainly for humans
		if((L.stat == DEAD) || (L.stat && (L.health <= L.maxHealth * 0.25 || L.getBruteLoss() >= L.maxHealth * 5)))
			var/nutr = L.mob_size
			if(istype(L, /mob/living/simple_animal/hostile/retaliate/goat)) // Likes goats
				nutr = 100
			if(ishuman(L))
				nutr = 50
			playsound(src, 'sound/scp/2427/consume.ogg', rand(15, 35), TRUE)
			visible_message(SPAN_DANGER("[src] consumes [L]!"))
			L.gib()
			AdjustSatiety(nutr)
			adjustBruteLoss(-nutr * 2)
			return
	return ..()

/mob/living/simple_animal/hostile/scp_2427_3/say(message)
	if(is_sleeping)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/scp_2427_3/Move(a,b,f)
	if(is_sleeping)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/scp_2427_3/movement_delay()
	. = ..()
	. += IsEnraged() ? -2 : 0

// Getting attacked/examined all down here
/mob/living/simple_animal/hostile/scp_2427_3/examine(mob/living/user)
	. = ..()
	if(is_sleeping)
		to_chat(user, "It is asleep now, but not for long...")
	CheckPurity(user)

/mob/living/simple_animal/hostile/scp_2427_3/attack_hand(mob/living/carbon/human/H)
	. = ..()
	if(H.a_intent == I_HURT)
		CheckPurity(H)

/mob/living/simple_animal/hostile/scp_2427_3/hit_with_weapon(obj/item/O, mob/living/user, effective_force, hit_zone)
	CheckPurity(user)

/mob/living/simple_animal/hostile/scp_2427_3/bullet_act(obj/item/projectile/Proj)
	. = ..()
	if(Proj.firer && !Proj.nodamage)
		CheckPurity(Proj.firer)

// Mob procs
/mob/living/simple_animal/hostile/scp_2427_3/proc/AdjustSatiety(amount)
	satiety = max(0, satiety + amount)
	if(!is_sleeping && satiety >= max_satiety)
		FallAsleep()

/mob/living/simple_animal/hostile/scp_2427_3/proc/IsEnraged()
	if(satiety <= min_satiety)
		return TRUE
	for(var/mob/living/L in dview(7, src))
		if(L in impurity_list)
			return TRUE
	return FALSE

/mob/living/simple_animal/hostile/scp_2427_3/proc/FallAsleep()
	if(is_sleeping)
		return
	wakeup_health = health - 50
	playsound(src, 'sound/machines/AirlockClose_heavy.ogg', 50, TRUE)
	visible_message(
		SPAN_NOTICE("[src] falls asleep."),
		SPAN_NOTICE("You fall asleep."))
	icon_state = "sleep"
	is_sleeping = TRUE
	addtimer(CALLBACK(src, .proc/WakeUp), rand((2 MINUTES), (4 MINUTES)))

/mob/living/simple_animal/hostile/scp_2427_3/proc/WakeUp()
	if(!is_sleeping)
		return
	revive()
	satiety = 300
	playsound(src, 'sound/mecha/lowpower.ogg', 50, FALSE)
	visible_message(
		SPAN_DANGER("[src] rises up once again!"),
		SPAN_NOTICE("You wake up."))
	is_sleeping = FALSE
	if(icon_state == "sleep") // If somehow we died before WakeUp got called
		icon_state = null

/mob/living/simple_animal/hostile/scp_2427_3/proc/TimeRespawn()
	if(stat != DEAD)
		return
	playsound(src, 'sound/mecha/powerup.ogg', 50, FALSE)
	visible_message(
		SPAN_DANGER("[src] rises up once again!"),
		SPAN_NOTICE("You finish the reboot process."))
	revive()
	satiety = 100
	sleep(2 SECONDS) // Give em some warning time
	icon_state = null

/mob/living/simple_animal/hostile/scp_2427_3/proc/CheckPurity(mob/living/L)
	if(L == src)
		return
	if(stat == DEAD || is_sleeping)
		return
	if((L in impurity_list) || (L in purity_list))
		return
	if(!istype(L))
		return
	if(!(L in dview(7, src)))
		return
	// Good luck, lmao
	if(rand(0, 10000) == 1)
		purity_list |= L
		to_chat(L, SPAN_GOOD("[src] looks at you surprised. It can grant any wish, right?"))
		to_chat(src, SPAN_GOOD("[uppertext(src)] IS PURE. IMPOSSIBLE? PURE."))
		playsound(src, 'sound/machines/synth_yes.ogg', 50, TRUE)
		return
	impurity_list |= L
	to_chat(L, SPAN_USERDANGER("You feel unsafe near [src]..."))
	to_chat(src, SPAN_WARNING("[uppertext(L)] IS IMPURE! IMPURE. IMPURE. IMPURE."))
	playsound(src, 'sound/machines/synth_no.ogg', 25, TRUE)

// Copied my code from 173, because it works the best
/mob/living/simple_animal/hostile/scp_2427_3/proc/OpenDoor(obj/machinery/door/A)
	if(door_cooldown > world.time)
		return

	if(!istype(A))
		return

	if(!A.density)
		return

	if(!A.Adjacent(src))
		to_chat(src, SPAN_WARNING("\The [A] is too far away."))
		return

	if(!IsEnraged() && (get_area(A) == spawn_area))
		to_chat(src, SPAN_WARNING("You cannot open blast doors in your containment zone unless enraged."))
		return

	var/open_time = istype(A, /obj/machinery/door/blast) ? 8 SECONDS : 3 SECONDS

	if(istype(A, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/AR = A
		if(AR.locked)
			open_time += 2 SECONDS
		if(AR.welded)
			open_time += 2 SECONDS
		if(AR.secured_wires)
			open_time += 2 SECONDS

	if(IsEnraged())
		open_time = max(0, open_time * 0.2)

	A.visible_message(SPAN_WARNING("\The [src] begins to pry open \the [A]!"))
	if(open_time > 0.5 SECONDS)
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
	var/check = A.open(TRUE)
	visible_message("\The [src] slices \the [A]'s controls[check ? ", ripping it open!" : ", breaking it!"]")

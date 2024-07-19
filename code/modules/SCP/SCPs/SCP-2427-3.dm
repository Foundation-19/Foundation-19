/mob/living/simple_animal/hostile/scp2427_3
	name = "mechanical spider"
	desc = "An amalgamation of exposed wires and robotic parts. It has 4 spider-like legs and a metal mask in place of the 'head'."
	icon = 'icons/SCP/scp-2427-3.dmi'
	icon_state = null
	icon_dead = "dead"
	pixel_x = -8
	default_pixel_x = -8
	can_rest = FALSE
	status_flags = NO_ANTAG

	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7

	maxHealth = 1200
	health = 1200

	movement_cooldown = 4.5
	movement_sound = 'sounds/mecha/mechmove04.ogg'

	a_intent = "harm"
	can_be_buckled = FALSE
	can_pull_mobs = 0 // RealB abused it too much

	natural_weapon = /obj/item/natural_weapon/leg_2427_3
	natural_armor = list(
		melee = ARMOR_MELEE_KNIVES
		)

	ai_holder_type = /datum/ai_holder/simple_animal/melee/s2427_3
	melee_attack_delay = 0

	var/satiety = 300
	/// How much satiety is reduced per tick
	var/satiety_reduction_per_tick = 0.5
	/// Upon going to that point or above - the mob goes into the is_sleeping stage and is unable to act/speak/move for some time
	var/max_satiety = 640
	/// Upon that point, the mob is on a rampage, allowing it to escape and move faster
	var/starvation_satiety = 80
	/// Absolute minimum, at which point you start taking damage
	var/min_satiety = 0
	/// Percentage of max HP dealt in damage when at minimum satiety
	var/starvation_damage = 0.005
	/// When TRUE - it ignores the purity list and can attack anything
	var/enraged = FALSE
	var/is_sleeping = FALSE
	/// If is_sleeping, getting down to that health will wake us up
	var/wakeup_health = 0
	var/door_cooldown
	var/area/spawn_area = null
	// Upon encountering a mob, they are added in one of these
	var/list/purity_list = list()
	var/list/impurity_list = list()

	/// If TRUE - The mob will automatically trigger attack when bumping a living mob
	var/bump_attack = TRUE

/mob/living/simple_animal/hostile/scp2427_3/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"mechanical spider", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_EUCLID, //Obj Class
		"2427-3", //Numerical Designation
		SCP_PLAYABLE
	)

	SCP.min_playercount = 30

	spawn_area = get_area(src)
	add_language(LANGUAGE_ENGLISH, FALSE)
	set_default_language(all_languages[LANGUAGE_ENGLISH])

//AI Stuff

/obj/item/natural_weapon/leg_2427_3
	name = "robotic leg"
	attack_verb = list("stabbed")
	hitsound = 'sounds/scp/2427/stab.ogg'
	damtype = BRUTE
	melee_accuracy_bonus = 200
	stun_prob = 0 // Only combat!
	edge = 1
	force = 36

/datum/ai_holder/simple_animal/melee/s2427_3
	mauling = TRUE
	handle_corpse = TRUE // Eats corpses

/datum/ai_holder/simple_animal/melee/s2427_3/can_attack(atom/movable/the_target, vision_required = TRUE)
	if(!..())
		return FALSE
	var/mob/living/simple_animal/hostile/scp2427_3/O = holder
	if(the_target in O.purity_list)
		return FALSE
	if(ishuman(the_target) && (O.satiety > O.min_satiety) && !(the_target in O.impurity_list))
		var/mob/living/carbon/human/H = the_target
		if(H.stat != DEAD)
			return FALSE
	return TRUE

//Mechanics

/mob/living/simple_animal/hostile/scp2427_3/proc/AdjustSatiety(amount)
	satiety = max(0, satiety + amount)
	if(!is_sleeping && satiety >= max_satiety)
		FallAsleep()

/mob/living/simple_animal/hostile/scp2427_3/proc/IsEnraged()
	for(var/mob/living/L in dview(7, src))
		if(L == src)
			continue
		if(L in impurity_list)
			return !L.stat && L.ckey // Conscious and is/was player controlled
		if(istype(get_area(src), spawn_area)) // Hm yes, today I will ignore all the corpses and goats around me to breach
			if(istype(L, /mob/living/simple_animal/hostile/retaliate/goat))
				return FALSE
			if(L.stat)
				return FALSE
	return (satiety <= starvation_satiety)

/mob/living/simple_animal/hostile/scp2427_3/proc/FallAsleep()
	if(is_sleeping)
		return
	wakeup_health = health - 50
	playsound(src, 'sounds/machines/AirlockClose_heavy.ogg', 75, TRUE, 4)
	visible_message(
		SPAN_NOTICE("[src] falls asleep."),
		SPAN_NOTICE("You fall asleep."))
	icon_state = "sleep"
	is_sleeping = TRUE
	addtimer(CALLBACK(src, PROC_REF(WakeUp)), rand((2 MINUTES), (4 MINUTES)))

/mob/living/simple_animal/hostile/scp2427_3/proc/WakeUp(attacked = FALSE)
	if(!is_sleeping)
		return
	revive()
	satiety = attacked ? 100 : 400 // If attacked or otherwise forced, it'll be very angry
	playsound(src, 'sounds/mecha/lowpower.ogg', 75, FALSE, 4)
	visible_message(
		SPAN_DANGER("[src] rises up once again!"),
		SPAN_NOTICE("You wake up."))
	sleep(2 SECONDS)
	is_sleeping = FALSE
	if(icon_state == "sleep") // If somehow we died before WakeUp got called
		icon_state = null

/mob/living/simple_animal/hostile/scp2427_3/proc/TimeRespawn()
	if(stat != DEAD)
		return
	playsound(src, 'sounds/mecha/powerup.ogg', 75, FALSE, 4)
	sleep(2 SECONDS) // Give em some warning time
	visible_message(
		SPAN_DANGER("[src] rises up once again!"),
		SPAN_NOTICE("You finish the reboot process."))
	revive()
	satiety = 100

/mob/living/simple_animal/hostile/scp2427_3/proc/CheckPurity(mob/living/L)
	if(!istype(L))
		return
	if(L == src)
		return
	if(L.SCP)
		return
	if(stat == DEAD || is_sleeping)
		return
	if((L in impurity_list) || (L in purity_list))
		return
	if(!(L in dview(7, src)))
		return
	listclearnulls(purity_list)
	listclearnulls(impurity_list)
	// Good luck, lmao
	if(rand(0, 10000) == 1)
		purity_list |= L
		to_chat(L, SPAN_GOOD("[src] looks at you surprised. It can grant any wish, right?"))
		to_chat(src, SPAN_GOOD("[uppertext(src)] IS PURE. IMPOSSIBLE? PURE."))
		playsound(src, 'sounds/machines/synth_yes.ogg', 50, TRUE)
		return
	impurity_list |= L
	to_chat(L, SPAN_USERDANGER("You feel unsafe near [src]..."))
	to_chat(src, SPAN_WARNING("[uppertext(L)] IS IMPURE! IMPURE. IMPURE. IMPURE."))
	playsound(src, 'sounds/machines/synth_no.ogg', 25, TRUE)

// Copied my code from 173, because it works the best
/mob/living/simple_animal/hostile/scp2427_3/proc/OpenDoor(obj/machinery/door/A)
	if(door_cooldown > world.time)
		return

	if(!istype(A))
		return

	if(!A.density)
		return

	if(!A.Adjacent(src))
		to_chat(src, SPAN_WARNING("\The [A] is too far away."))
		return

	if((!IsEnraged() || !SCP.has_minimum_players()) && (get_area(A) == spawn_area))
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
		playsound(get_turf(A), 'sounds/machines/airlock_creaking.ogg', 35, 1)
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
	A.set_broken(TRUE)
	var/check = A.open(TRUE)
	visible_message("\The [src] slices \the [A]'s controls[check ? ", ripping it open!" : ", breaking it!"]")

//Overrides

/mob/living/simple_animal/hostile/scp2427_3/Life()
	. = ..()
	if(!.)
		return
	if(!ckey)
		return
	if(is_sleeping)
		return
	if(prob(2)) // Random purity check!
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
	if(SCP.has_minimum_players())
		AdjustSatiety(-satiety_reduction_per_tick)
	if(satiety <= min_satiety) // Starvation, so you don't just run at mach 3 all the time
		adjustBruteLoss(maxHealth * starvation_damage)

/mob/living/simple_animal/hostile/scp2427_3/get_status_tab_items()
	. = ..()
	if(stat == DEAD)
		. += "WE ARE REBOOTING."
	else if(is_sleeping)
		. += "WE ARE ASLEEP."

	if(satiety <= min_satiety)
		. += "Satiety: I AM GOING TO STARVE TO DEATH!! ([round(satiety)]/[max_satiety])"
	else if(satiety <= starvation_satiety)
		. += "Satiety: I NEED MEAT RIGHT NOW! ([round(satiety)]/[max_satiety])"
	else
		. += "Satiety: [round(satiety)]/[max_satiety]"

/mob/living/simple_animal/hostile/scp2427_3/examinate(atom/A as mob|obj|turf in view())
	if(UNLINT(..()))
		return 1

	if(isliving(A) && get_dir(A, src) == A.dir) // Looking in our direction
		CheckPurity(A)

	if(A in impurity_list)
		to_chat(src, SPAN_USERDANGER("SUBJECT IMPURE! IMPURE. IMPURE. IMPURE."))
		playsound(src, 'sounds/machines/synth_no.ogg', 15, TRUE)
		return

	if(A in purity_list)
		to_chat(src, SPAN_GOOD("SUBJECT IS PURE..?"))
		playsound(src, 'sounds/machines/synth_yes.ogg', 15, TRUE)
		return

/mob/living/simple_animal/hostile/scp2427_3/updatehealth()
	. = ..()
	if(is_sleeping && stat != DEAD && health < wakeup_health)
		WakeUp(TRUE)

/mob/living/simple_animal/hostile/scp2427_3/death(gibbed, deathmessage = "falls on the ground, beginning reboot process.", show_dead_message)
	to_chat(src, SPAN_OCCULT("You begin the reboot process. Avoid leaving the body."))
	playsound(src, 'sounds/mecha/lowpower.ogg', 75, FALSE, 4)
	addtimer(CALLBACK(src, PROC_REF(TimeRespawn)), 5 MINUTES)
	return ..()

/mob/living/simple_animal/hostile/scp2427_3/gib()
	return FALSE

/mob/living/simple_animal/hostile/scp2427_3/dust()
	return FALSE

// If bump attack is enabled, we will automaticall attack mobs that we bump into
/mob/living/simple_animal/hostile/scp2427_3/Bump(atom/A)
	. = ..()
	if(bump_attack && isliving(A) && canClick())
		UnarmedAttack(A)

/mob/living/simple_animal/hostile/scp2427_3/UnarmedAttack(atom/A)
	if(is_sleeping)
		return
	if(istype(A, /obj/machinery/door))
		OpenDoor(A)
		return
	if(istype(A, /obj/machinery/power/apc))
		return // Fuck you RealB
	if(A in purity_list)
		to_chat(src, SPAN_WARNING("They are pure... We will grant their wish."))
		return
	if(ishuman(A) && (satiety >= starvation_satiety) && !(A in impurity_list) && !ismonkey(A))
		var/mob/living/carbon/human/H = A
		if(H.stat != DEAD)
			to_chat(src, SPAN_WARNING("We cannot decide if they are pure or not just yet..."))
			return
	if(isliving(A))
		var/mob/living/L = A
		// Brute loss part is mainly for humans
		if((L.stat == DEAD) || (L.stat && ((L.health <= L.maxHealth * 0.25) || (L.getBruteLoss() >= L.maxHealth * 2))))
			var/nutr = L.mob_size
			if(istype(L, /mob/living/simple_animal/hostile/retaliate/goat)) // Likes goats
				nutr = round(max_satiety * 0.5)
			if(ishuman(L))
				nutr = round(max_satiety * 0.2)
			if(ismonkey(L))
				nutr = round(max_satiety * 0.05)
			playsound(src, 'sounds/scp/2427/consume.ogg', rand(15, 35), TRUE)
			visible_message(SPAN_DANGER("[src] consumes [L]!"))
			L.gib()
			AdjustSatiety(nutr)
			adjustBruteLoss(-nutr * 1.5) // PLEASE never set this above 1.5x; else 2427 can easily push through blockades due to how efficient this was before.
			return
	return ..()

/mob/living/simple_animal/hostile/scp2427_3/say(message)
	if(is_sleeping)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/scp2427_3/SelfMove(direction)
	resting = FALSE //2427 is forced to rest on dying... So make them not rest the next time they move.
	if(is_sleeping)
		return FALSE
	return ..()

// Similar checks for the AI
/mob/living/simple_animal/hostile/scp2427_3/attack_target(atom/A)
	return UnarmedAttack(A)

/mob/living/simple_animal/hostile/scp2427_3/IMove(turf/newloc, safety = TRUE)
	if(is_sleeping)
		return MOVEMENT_ON_COOLDOWN
	return ..()

/mob/living/simple_animal/hostile/scp2427_3/movement_delay()
	. = ..()
	. += IsEnraged() ? -2 : 0

// Getting attacked/examined all down here
/mob/living/simple_animal/hostile/scp2427_3/examine(mob/living/user)
	. = ..()
	if(is_sleeping)
		to_chat(user, SPAN_NOTICE("It is asleep now, but not for long..."))
	CheckPurity(user)

/mob/living/simple_animal/hostile/scp2427_3/attack_hand(mob/living/carbon/human/H)
	. = ..()
	if(H.a_intent == I_HURT)
		CheckPurity(H)

/mob/living/simple_animal/hostile/scp2427_3/hit_with_weapon(obj/item/O, mob/living/user, effective_force, hit_zone)
	CheckPurity(user)

/mob/living/simple_animal/hostile/scp2427_3/bullet_act(obj/item/projectile/Proj)
	. = ..()
	if(Proj.firer && !Proj.nodamage)
		CheckPurity(Proj.firer)

// Someone was disappointed that you can't run 2427-3 through 914, so here we are.
/mob/living/simple_animal/hostile/scp2427_3/Conversion914(mode = MODE_ONE_TO_ONE, mob/user = usr)
	log_and_message_admins("put [src] through SCP-914 on \"[mode]\" mode.", user, src)
	switch(mode)
		if(MODE_ROUGH, MODE_COARSE) // Reset them to normal
			movement_cooldown = initial(movement_cooldown)
			var/obj/item/natural_weapon/leg_2427_3/W = get_natural_weapon()
			if(istype(W))
				W.force = initial(W.force)
			if(mode == MODE_ROUGH) // KILL!!!!
				death()
		if(MODE_FINE) // They get a bit stronger
			playsound(src, 'sounds/effects/screech.ogg', 75, FALSE, 16)
			to_chat(src, SPAN_USERDANGER("You are feeling more powerful!"))
			movement_cooldown = initial(movement_cooldown) - 1
		if(MODE_VERY_FINE) // I suggest you just end the round here and there
			playsound(src, 'sounds/effects/screech.ogg', 75, FALSE, 16)
			to_chat(src, SPAN_USERDANGER("You are unstoppable avatar of justice! PURIFY THEM ALL!!!"))
			var/obj/item/natural_weapon/leg_2427_3/W = get_natural_weapon()
			if(istype(W))
				W.force = initial(W.force) *= 2
			movement_cooldown = initial(movement_cooldown) - 2
	return src

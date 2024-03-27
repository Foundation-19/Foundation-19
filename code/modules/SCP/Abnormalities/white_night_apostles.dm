// Those are the apostles spawned by White Night on rapture.
/mob/living/simple_animal/hostile/apostle
	name = "coder apostle"
	desc = "Who the hell spawned it? Yell at admins, or coders."
	icon = 'icons/mob/48x64.dmi'
	icon_state = "apostle_scythe"
	icon_living = "apostle_scythe"
	icon_dead = "apostle_dead"
	pixel_x = -8
	default_pixel_x = -8

	faction = "apostle"

	health = 2000
	maxHealth = 2000

	movement_cooldown = 5

	status_flags = NO_ANTAG

	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7

	var/can_act = TRUE
	var/death_counter = 0

/mob/living/simple_animal/hostile/apostle/RangedAttack(atom/A)
	if(!can_act)
		return
	. = ..()
	if(client && !A.Adjacent(src))
		return PerformAbility(A)

/mob/living/simple_animal/hostile/apostle/UnarmedAttack(atom/A)
	if(!can_act)
		return
	if(isliving(A))
		var/mob/living/L = A
		if(L.faction == faction)
			return
	return ..()

// Mainly for AI
/mob/living/simple_animal/hostile/apostle/shoot_target(atom/A)
	if(!can_act)
		return
	return PerformAbility(A)

/mob/living/simple_animal/hostile/apostle/white_night/death(gibbed, deathmessage = "falls to their knees.", show_dead_message)
	return ..()

/mob/living/simple_animal/hostile/apostle/gib()
	return FALSE

/mob/living/simple_animal/hostile/apostle/dust()
	return FALSE

/mob/living/simple_animal/hostile/apostle/SelfMove(direction)
	if(!can_act)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/apostle/rejuvenate()
	.= ..()
	can_act = TRUE // In case we died while performing special attack

// Special attack of the apostle
/mob/living/simple_animal/hostile/apostle/proc/PerformAbility(atom/A)
	return

/mob/living/simple_animal/hostile/apostle/scythe
	name = "scythe apostle"
	desc = "A disformed human wielding a terrifying scythe."
	natural_weapon = /obj/item/natural_weapon/apostle_scythe
	var/scythe_cooldown
	var/scythe_cooldown_time = 10 SECONDS
	var/scythe_range = 2
	var/scythe_damage = 200

/obj/item/natural_weapon/apostle_scythe
	name = "scythe"
	attack_verb = list("slashed")
	hitsound = 'sounds/scp/abnormality/white_night/scythe.ogg'
	force = 36
	sharp = TRUE
	melee_accuracy_bonus = 200
	stun_prob = 0

/mob/living/simple_animal/hostile/apostle/scythe/PerformAbility()
	if(scythe_cooldown > world.time)
		return
	scythe_cooldown = world.time + scythe_cooldown_time
	can_act = FALSE
	for(var/turf/T in view(scythe_range, src))
		new /obj/effect/temp_visual/sparkle(T)
	SLEEP_CHECK_DEATH(10)
	var/gibbed = FALSE
	for(var/turf/T in view(scythe_range, src))
		new /obj/effect/temp_visual/smash(T)
		for(var/mob/living/L in T)
			if(L.stat == DEAD)
				continue
			if(L.faction == faction)
				continue
			L.apply_damage(scythe_damage, BRUTE, null, DAM_DISPERSED)
			// Total overkill
			if((L.stat == DEAD) || (L.getBruteLoss() >= L.maxHealth * 3))
				for(var/i = 1 to 5) // Alternative to gib()
					new /obj/effect/temp_visual/bloodsplatter(get_turf(L), pick(GLOB.alldirs), L.GetBloodColor())
				new /obj/effect/gibspawner/generic(get_turf(L))
				L.apply_damage(scythe_damage * 2, BRUTE, null, DAM_DISPERSED)
				gibbed = TRUE
	playsound(get_turf(src), (gibbed ? 'sounds/scp/abnormality/white_night/scythe_gib.ogg' : 'sounds/scp/abnormality/white_night/scythe_spell.ogg'), (gibbed ? 100 : 75), FALSE, (gibbed ? 12 : 5))
	SLEEP_CHECK_DEATH(5)
	can_act = TRUE

/mob/living/simple_animal/hostile/apostle/scythe/guardian
	name = "guardian apostle"
	icon_state = "apostle_guardian"
	icon_living = "apostle_guardian"
	natural_weapon = /obj/item/natural_weapon/apostle_scythe/guardian
	scythe_range = 3
	scythe_damage = 300

/obj/item/natural_weapon/apostle_scythe/guardian
	name = "guardian scythe"
	force = 45

/mob/living/simple_animal/hostile/apostle/spear
	name = "spear apostle"
	desc = "A disformed human wielding a spear."
	icon_state = "apostle_spear"
	icon_living = "apostle_spear"
	natural_weapon = /obj/item/natural_weapon/apostle_spear
	var/spear_cooldown
	var/spear_cooldown_time = 10 SECONDS
	var/spear_max = 50
	var/spear_damage = 300
	var/list/been_hit = list()

/obj/item/natural_weapon/apostle_spear
	name = "apostle spear"
	attack_verb = list("stabbed", "punctured")
	hitsound = 'sounds/scp/abnormality/white_night/spear.ogg'
	force = 25
	sharp = TRUE
	edge = 1
	melee_accuracy_bonus = 200
	stun_prob = 0

/mob/living/simple_animal/hostile/apostle/spear/PerformAbility(atom/target)
	if(spear_cooldown > world.time)
		return
	can_act = FALSE
	var/dir_to_target = get_dir(src, target)
	var/turf/T = get_turf(src)
	for(var/i = 1 to spear_max)
		T = get_step(T, dir_to_target)
		if(T.density)
			if(i < 4) // Mob attempted to dash into a wall too close, stop it
				can_act = TRUE
				return
			break
		new /obj/effect/temp_visual/sparkle(T)
	spear_cooldown = world.time + spear_cooldown_time
	playsound(get_turf(src), 'sounds/scp/abnormality/white_night/spear_charge.ogg', 75, 0, 5)
	SLEEP_CHECK_DEATH(22)
	been_hit = list()
	playsound(get_turf(src), 'sounds/scp/abnormality/white_night/spear_dash.ogg', 100, 0, 20)
	DoDash(dir_to_target, 0)

/mob/living/simple_animal/hostile/apostle/spear/proc/DoDash(move_dir, times_ran)
	var/stop_charge = FALSE
	if(times_ran >= spear_max)
		stop_charge = TRUE
	var/turf/T = get_step(get_turf(src), move_dir)
	if(!T)
		can_act = TRUE
		return
	if(T.density)
		stop_charge = TRUE
	for(var/obj/structure/window/W in T)
		W.shatter()
	for(var/obj/machinery/door/D in T)
		if(D.density)
			addtimer(CALLBACK (D, TYPE_PROC_REF(/obj/machinery/door, open)))
	if(stop_charge)
		can_act = TRUE
		return
	forceMove(T)
	for(var/turf/TF in view(1, T))
		new /obj/effect/temp_visual/smoke(TF)
		for(var/mob/living/L in TF)
			if(L.faction == faction)
				continue
			if(L.stat == DEAD)
				continue
			if(L in been_hit)
				continue
			visible_message(SPAN_DANGER("[src] runs through [L]!"))
			L.apply_damage(spear_damage, BRUTE, null, DAM_DISPERSED)
			new /obj/effect/temp_visual/bloodsplatter(get_turf(L), pick(GLOB.alldirs))
			been_hit |= L
	addtimer(CALLBACK(src, PROC_REF(DoDash), move_dir, (times_ran + 1)), 0.5) // SPEED

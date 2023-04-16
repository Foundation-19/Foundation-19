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

/mob/living/simple_animal/hostile/apostle/ClickOn(atom/A)
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
	hitsound = 'sound/scp/abnormality/white_night/scythe.ogg'
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
					new /obj/effect/temp_visual/bloodsplatter(get_turf(L), pick(GLOB.alldirs))
				new /obj/effect/gibspawner/generic(get_turf(L))
				L.apply_damage(scythe_damage * 2, BRUTE, null, DAM_DISPERSED)
				gibbed = TRUE
	playsound(get_turf(src), (gibbed ? 'sound/scp/abnormality/white_night/scythe_gib.ogg' : 'sound/scp/abnormality/white_night/scythe_spell.ogg'), (gibbed ? 100 : 75), FALSE, (gibbed ? 12 : 5))
	SLEEP_CHECK_DEATH(5)
	can_act = TRUE

/mob/living/simple_animal/hostile/apostle/scythe/guardian
	name = "guardian apostle"
	scythe_range = 3
	scythe_damage = 300

/obj/item/natural_weapon/apostle_scythe/guardian
	name = "guardian scythe"
	attack_verb = list("slashed")
	hitsound = 'sound/scp/abnormality/white_night/scythe.ogg'
	force = 30
	sharp = TRUE

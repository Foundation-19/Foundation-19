/mob/living/simple_animal/hostile/hivebot
	name = "hivebot"
	desc = "A junky looking robot with four spiky legs."
	icon = 'icons/mob/simple_animal/hivebot.dmi'
	icon_state = "basic"
	icon_living = "basic"
	icon_dead = "basic"
	health = 55
	maxHealth = 55
	natural_weapon = /obj/item/natural_weapon/drone_slicer
	projectiletype = /obj/item/projectile/beam/smalllaser
	projectile_dispersion = 0.5
	ranged_attack_delay = 3
	faction = "hivebot"
	min_gas = null
	max_gas = null
	minbodytemp = 0
	movement_cooldown = 4
	natural_armor = list(
		melee = ARMOR_MELEE_KNIVES
		)
	bleed_colour = SYNTH_BLOOD_COLOUR

	loot_list = list(
		/obj/item/stack/material/rods = 4,
	)

	meat_type =     null
	meat_amount =   0
	bone_material = null
	bone_amount =   0
	skin_material = null
	skin_amount =   0

	needs_reload = TRUE
	reload_max = 5
	reload_time = 2 SECONDS
	reload_sound = 'sound/effects/scanbeep.ogg'

/mob/living/simple_animal/hostile/hivebot/drop_loot()
	if(prob(25))
		loot_list += /obj/item/cell/standard
	..()

/mob/living/simple_animal/hostile/hivebot/range
	desc = "A junky looking robot with four spiky legs. It's equipped with some kind of small-bore gun."
	ranged = 1
	movement_cooldown = 5

/mob/living/simple_animal/hostile/hivebot/rapid
	ranged = 1
	rapid = 1
	ranged_attack_delay = null
	reload_max = 10

/mob/living/simple_animal/hostile/hivebot/strong
	desc = "A junky looking robot with four spiky legs - this one has thick armour plating."
	health = 120
	maxHealth = 120
	ranged = 1
	can_escape = 1
	natural_armor = list(
		melee = ARMOR_MELEE_RESISTANT
		)

/mob/living/simple_animal/hostile/hivebot/death()
	..(null, "blows apart!")
	new /obj/effect/decal/cleanable/blood/gibs/robot(src.loc)
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(3, 1, src)
	s.start()
	qdel(src)
	return

/*
Teleporter beacon, and its subtypes
*/
/mob/living/simple_animal/hostile/hivebot/tele
	name = "beacon"
	desc = "Some odd beacon thing."
	icon_state = "def_radar-off"
	icon_living = "def_radar-off"
	health = 200
	maxHealth = 200
	status_flags = 0
	anchored = TRUE

	var/bot_type = /mob/living/simple_animal/hostile/hivebot
	var/bot_amt = 5
	var/spawn_delay = 5 SECONDS
	var/activated = FALSE

	melee_attack_delay = 0
	natural_weapon = null
	projectiletype = null

	ai_holder_type = /datum/ai_holder/simple_animal/hivebot/tele

/mob/living/simple_animal/hostile/hivebot/tele/Initialize()
	. = ..()
	var/datum/effect/effect/system/smoke_spread/smoke = new /datum/effect/effect/system/smoke_spread()
	smoke.set_up(5, 0, src.loc)
	smoke.start()
	visible_message(SPAN_DANGER("\The [src] warps in!"))
	playsound(src.loc, 'sound/effects/EMPulse.ogg', 25, 1)

/mob/living/simple_animal/hostile/hivebot/tele/proc/trigger()
	if(!activated)
		visible_message("<span class='danger'>\The [src] sends a signal!</span>")
		activated = TRUE
		icon_state = "def_radar"
		playsound(src.loc, 'sound/effects/caution.ogg', 50, 1)
		addtimer(CALLBACK(src, .proc/warpbots), spawn_delay)
	return

/mob/living/simple_animal/hostile/hivebot/tele/proc/warpbots()
	var/datum/effect/effect/system/smoke_spread/smoke = new /datum/effect/effect/system/smoke_spread()
	smoke.set_up(5, 0, src.loc)
	smoke.start()
	while(bot_amt > 0 && bot_type)
		bot_amt--
		var/mob/M = new bot_type(get_turf(src))
		M.faction = faction
	playsound(src.loc, 'sound/effects/teleport.ogg', 50, 1)
	qdel(src)
	return

/mob/living/simple_animal/hostile/hivebot/tele/updatehealth()
	..()
	if((stat != DEAD) && prob(10)) // So attacking it with fast firing weapons has more chance to trigger it
		trigger()

/datum/ai_holder/simple_animal/hivebot/tele/on_engagement(atom/A) // Walking into melee range
	. = ..()
	var/mob/living/simple_animal/hostile/hivebot/tele/T = holder
	T.trigger()
	return

/mob/living/simple_animal/hostile/hivebot/tele/strong
	bot_type = /mob/living/simple_animal/hostile/hivebot/strong

/mob/living/simple_animal/hostile/hivebot/tele/range
	bot_type = /mob/living/simple_animal/hostile/hivebot/range

/mob/living/simple_animal/hostile/hivebot/tele/rapid
	bot_type = /mob/living/simple_animal/hostile/hivebot/rapid

/*
The megabot
*/
#define ATTACK_MODE_MELEE    "melee"
#define ATTACK_MODE_LASER    "laser"

/mob/living/simple_animal/hostile/hivebot/mega
	name = "hivemind"
	desc = "A huge quadruped robot equipped with a myriad of weaponry."
	icon = 'icons/mob/simple_animal/megabot.dmi'
	icon_state = "megabot"
	icon_living = "megabot"
	icon_dead = "megabot_dead"
	health = 500
	maxHealth = 500
	natural_weapon = /obj/item/natural_weapon/circular_saw
	movement_cooldown = 6
	natural_armor = list(
		melee = ARMOR_MELEE_RESISTANT,
		bullet = ARMOR_BALLISTIC_PISTOL
		)
	can_escape = TRUE
	armor_type = /datum/extension/armor/toggle
	ability_cooldown = 2 MINUTES

	pixel_x = -32
	default_pixel_x = -32

	loot_list = list(
		/obj/item/stack/material/iron = 50,
		/obj/item/stack/material/uranium = 15,
		/obj/item/stack/material/diamond = 10,
	)

	special_attack_min_range = 3
	special_attack_max_range = 12
	special_attack_cooldown = 30 SECONDS

	ranged_attack_delay = null
	needs_reload = FALSE

	movement_sound = 'sound/mecha/mechstep.ogg'
	movement_shake_radius = 7

	natural_armor = list(
		melee = ARMOR_MELEE_RESISTANT,
		bomb = ARMOR_BOMB_SHIELDED
		)

	var/attack_mode = ATTACK_MODE_MELEE
	var/num_shots
	var/deactivated
	var/obj/item/projectile/gigabeam_type = /obj/item/projectile/beam/gigabeam

/obj/item/natural_weapon/circular_saw
	name = "giant circular saw"
	attack_verb = list("sawed", "ripped")
	hitsound = 'sound/weapons/circsawhit.ogg'
	force = 30
	armor_penetration = 30
	sharp = TRUE
	edge = TRUE

/mob/living/simple_animal/hostile/hivebot/mega/Initialize()
	. = ..()
	switch_mode(ATTACK_MODE_LASER)

/mob/living/simple_animal/hostile/hivebot/mega/get_attack_speed(obj/item/W)
	if(attack_mode == ATTACK_MODE_LASER) // For faster fire rate
		return DEFAULT_QUICK_COOLDOWN
	return ..(W)

/mob/living/simple_animal/hostile/hivebot/mega/emp_act(severity)
	if(status_flags & GODMODE)
		return

	. = ..()
	if(severity >= 1)
		deactivate()

/mob/living/simple_animal/hostile/hivebot/mega/drop_loot()
	if(prob(25)) // Rare loot!
		loot_list += /obj/item/gun/energy/lasercannon
	..()

/mob/living/simple_animal/hostile/hivebot/mega/do_special_attack(atom/A)
	..()
	set_AI_busy(TRUE)
	var/turf/T = get_turf(A)
	visible_message(SPAN_MFAUNA("\The [src] raises a giant laser cannon, aiming it at \the [A]!"))
	playsound(src, 'sound/weapons/marauder.ogg', 50, 1)
	face_atom(A)
	var/obj/effect/temp_visual/decoy/D = new /obj/effect/temp_visual/decoy(loc, dir, src)
	animate(D, alpha = 0, color = "#ff0000", transform = matrix()*2, time = 5)
	addtimer(CALLBACK(src, .proc/fire_gigabeam, T), 3 SECONDS)

/mob/living/simple_animal/hostile/hivebot/mega/proc/fire_gigabeam(turf/T)
	playsound(src, 'sound/weapons/lasercannonfire.ogg', 150, 1, 4)
	var/obj/item/projectile/P = new gigabeam_type(src.loc)
	if(istype(P))
		var/selected_zone = pick(BP_ALL_LIMBS)
		P.launch(T, selected_zone, src)
	set_AI_busy(FALSE)
	return TRUE

/mob/living/simple_animal/hostile/hivebot/mega/on_update_icon()
	if(stat != DEAD)
		if(deactivated)
			icon_state = "megabot_standby"
			icon_living = "megabot_standby"
			return

		icon_state = "megabot"
		icon_living = "megabot"

		cut_overlays()
		add_overlay(image(icon, "active_indicator"))
		switch(attack_mode)
			if(ATTACK_MODE_MELEE)
				add_overlay(image(icon, "melee"))
			if(ATTACK_MODE_LASER)
				add_overlay(image(icon, "laser"))

/mob/living/simple_animal/hostile/hivebot/mega/proc/switch_mode(new_mode)
	if(!new_mode || new_mode == attack_mode)
		return

	switch(new_mode)
		if(ATTACK_MODE_MELEE)
			attack_mode = ATTACK_MODE_MELEE
			ranged = FALSE
			projectilesound = null
			projectiletype = null
			num_shots = 0
			visible_message(SPAN_MFAUNA("\The [src]'s circular saw spins up!"))
			playsound(src, 'sound/mecha/mechdrill.ogg', 50, 1)
		if(ATTACK_MODE_LASER)
			attack_mode = ATTACK_MODE_LASER
			ranged = TRUE
			projectilesound = 'sound/weapons/Laser.ogg'
			projectiletype = /obj/item/projectile/beam/smalllaser
			num_shots = 20
			fire_desc = "fires a laser"
			visible_message(SPAN_MFAUNA("\The [src] raises secondary laser cannon!"))
			playsound(src, 'sound/mecha/hydraulic.ogg', 50, 1)

	update_icon()

/mob/living/simple_animal/hostile/hivebot/mega/proc/deactivate()
	set_AI_busy(TRUE)
	deactivated = TRUE
	visible_message(SPAN_MFAUNA("\The [src] clicks loudly as its lights fade and its motors grind to a halt!"))
	var/datum/extension/armor/toggle/armor = get_extension(src, /datum/extension/armor)
	if(armor)
		armor.toggle(FALSE)
	playsound(src, 'sound/mecha/lowpower.ogg', 75, 1)
	update_icon()
	addtimer(CALLBACK(src, .proc/reactivate), 4 SECONDS)

/mob/living/simple_animal/hostile/hivebot/mega/proc/reactivate()
	set_AI_busy(FALSE)
	deactivated = FALSE
	visible_message(SPAN_MFAUNA("\The [src] whirs back to life!"))
	var/datum/extension/armor/toggle/armor = get_extension(src, /datum/extension/armor)
	if(armor)
		armor.toggle(TRUE)
	playsound(src, 'sound/mecha/powerup.ogg', 75, 1)
	update_icon()

/mob/living/simple_animal/hostile/hivebot/mega/shoot_target(target_mob)
	if(num_shots <= 0)
		if(attack_mode == ATTACK_MODE_LASER)
			if(prob(50))
				switch_mode(ATTACK_MODE_MELEE)
				addtimer(CALLBACK(src, .proc/switch_mode, ATTACK_MODE_LASER), 10 SECONDS)
			else
				deactivate()
		return
	..()

/mob/living/simple_animal/hostile/hivebot/mega/shoot(target, start, user, bullet)
	..()
	num_shots--

#undef ATTACK_MODE_MELEE
#undef ATTACK_MODE_LASER

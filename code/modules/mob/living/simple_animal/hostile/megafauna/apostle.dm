/mob/living/simple_animal/hostile/megafauna/apostle
	name = "apostle"
	desc = "The heavens' wrath. You might've fucked up real bad to summon one."
	icon = 'icons/mob/simple_animal/apostle.dmi'
	icon_state = "apostle"
	icon_living = "apostle"
	icon_dead = "apostle"
	speak_emote = list("proclaims")
	response_harm = "strikes"
	faction = "apostle"

	default_pixel_x = -16
	default_pixel_y = -16
	pixel_x = -16
	pixel_y = -16

	deathsound = 'sound/effects/apostle/mob/apostle_death.ogg'

	health = 800
	maxHealth = 800
	environment_smash = 1
	natural_weapon = /obj/item/natural_weapon/heaven
	natural_armor = list(
		melee = ARMOR_MELEE_KNIVES
		)

	mob_actions = list(
						/datum/action/megafauna/holy_revival,
						/datum/action/megafauna/fire_field,
						/datum/action/megafauna/holy_blink,
						)

	var/datum/action/megafauna/rapture/rapture_skill = new /datum/action/megafauna/rapture

	var/holy_revival_cooldown = 10 SECONDS
	var/holy_revival_cooldown_base = 10 SECONDS
	var/holy_revival_damage = 16 // Amount of damage
	var/fire_field_cooldown = 20 SECONDS
	var/fire_field_cooldown_base = 20 SECONDS
	var/field_range = 4
	var/scream_cooldown = 18 SECONDS
	var/scream_cooldown_base = 18 SECONDS
	var/scream_power = 25
	var/apostle_cooldown = 20 SECONDS //Cooldown for conversion and revival of non-apostles.
	var/apostle_cooldown_base = 20 SECONDS
	var/blink_cooldown = 6 SECONDS
	var/blink_cooldown_base = 6 SECONDS
	var/apostle_num = 1 //Number of apostles. Used for revival and finale.
	var/apostle_line
	var/apostle_prev //Used for previous apostle's name, to reference in next line.

/datum/action/megafauna/holy_revival
	name = "Holy Revival"
	button_icon_state = "magicm"
	chosen_message = "You are now reviving the dead to join your cause."
	chosen_attack_num = 1

/datum/action/megafauna/fire_field
	name = "Fire Field"
	button_icon_state = "fireball"
	chosen_message = "You are now setting the area on explosive fire."
	chosen_attack_num = 2

/datum/action/megafauna/holy_blink
	name = "Fire Field"
	button_icon_state = "jaunt"
	chosen_message = "You will now blink to your target and throw away the heretics."
	chosen_attack_num = 3

/datum/action/megafauna/rapture
	name = "Rapture"
	button_icon_state = "spell_disintegrate"
	chosen_message = "Finale..."
	chosen_attack_num = 101

/mob/living/simple_animal/hostile/megafauna/apostle/death(gibbed, deathmessage, show_dead_message)
	..(null, "evaporates in a moment, leaving heavenly light and feathers behind.")
	for(var/datum/mind/A in GLOB.apostles)
		if(!A.current || !ishuman(A.current))
			continue
		GLOB.apostle_antag.prophet_death(A.current)
	qdel(src)

/mob/living/simple_animal/hostile/megafauna/apostle/ClickOn(atom/A)
	. = ..()
	if(client && !A.Adjacent(src))
		switch(chosen_attack)
			if(1)
				revive_humans()
			if(2)
				fire_field()
			if(3)
				holy_blink(A)
			if(101)
				rapture()
		return

/mob/living/simple_animal/hostile/megafauna/apostle/proc/revive_humans()
	if(holy_revival_cooldown > world.time)
		return
	holy_revival_cooldown = (world.time + holy_revival_cooldown_base)
	playsound(src, 'sound/effects/apostle/mob/apostle_spell.ogg', 150, 1)
	for(var/i in range(3, src))
		if(isturf(i))
			new /obj/effect/temporary/sparkle(i)
			continue
		if(ishuman(i))
			var/mob/living/carbon/human/H = i
			if(H.faction != "apostle")
				if(apostle_num < 13 && H.stat == DEAD && apostle_cooldown <= world.time && H.mind && H.ckey)
					apostle_cooldown = (world.time + apostle_cooldown_base)
					if(!H.client)
						var/mob/observer/ghost/ghost = find_dead_player(H.ckey, 1)
						if(istype(ghost))
							ghost.reenter_corpse()
					H.revive()
					// Giving the fancy stuff to new apostle
					H.faction = "apostle"
					to_chat(H, SPAN_NOTICE("You are protected by the holy light!"))
					if(apostle_num < 12)
						var/image/apostle_halo = image('icons/mob/32x64.dmi', "halo") // FIX ME
						H.add_overlay(apostle_halo)
						H.queue_icon_update()
					sleep(20)
					// Executing rapture scenario
					switch(apostle_num)
						if(1)
							apostle_line = "And I tell you, you are [H.real_name] the apostle, and on this rock I will build my church, and the gates of hell shall not prevail against it."
						if(2)
							apostle_line = "Tell us, when will this happen, and what will be the sign of your coming and of the end of the age?"
						if(3)
							apostle_line = "Do you want us to call fire down from heaven to destroy them?"
							apostle_prev = H.real_name
						if(4)
							apostle_line = "[apostle_prev] the apostle and [H.real_name] the apostle, to them he gave the name Boanerges, which means \"sons of thunder\""
						if(5)
							apostle_line = "[H.real_name] the apostle said, \"Show us the Father and that will be enough for us.\""
						if(6)
							apostle_line = "He saw a human named [H.real_name] the apostle. \"Follow me.\" he told him, and [H.real_name] got up and followed him."
						if(7)
							apostle_line = "Now for some time [H.real_name] the apostle had practiced sorcery and amazed all the people."
						if(8)
							apostle_line = "Then [H.real_name] the apostle said to the rest of disciples, \"Let us also go, that we may die with him.\""
						if(9)
							apostle_line = "Then [H.real_name] the apostle declared, \"You are the son of him, you are the king.\""
						if(10)
							apostle_line = "Then [H.real_name] the apostle said, \"But why do you intend to show yourself to us and not to the world?\""
						if(11)
							apostle_line = "From now on, let no one cause me trouble, for I bear on my body the marks of him."
						if(12) //Here we go sicko mode
							apostle_line = "Have I not chosen you, the Twelve? Yet one of you is a devil."
							rapture_skill.Grant(src)
					for(var/mob/M in GLOB.player_list)
						if(M.z == z && M.client)
							to_chat(M, FONT_LARGE(SPAN_OCCULT(apostle_line)))
							M.playsound_local(get_turf(M), 'sound/effects/apostle/mob/apostle_bell.ogg', 100, 1)
							flash_color(M, flash_color = "#ff0000", flash_time = 50)
					var/mob/living/carbon/human/HM = H // Because add_antagonist works in a shitty way
					GLOB.apostle_antag.add_antagonist(HM.mind, TRUE, TRUE, FALSE, TRUE, TRUE)
					apostle_num += 1
					//natural_weapon.force += 5
					maxHealth += 100
					health = maxHealth
					holy_revival_damage += 2 // More damage and healing from AOE spell.
				else
					playsound(H.loc, 'sound/effects/apostle/mob/ark_damage.ogg', 50, TRUE, -1)
					H.adjustFireLoss(holy_revival_damage)
					H.emote("scream")
					to_chat(H, SPAN_OCCULT("The holy light... IT BURNS!!"))
			else
				if(!H.client && H.ckey)
					var/mob/observer/ghost/ghost = find_dead_player(H.ckey, 1)
					if(istype(ghost))
						ghost.reenter_corpse()
				H.revive()
				to_chat(H, SPAN_NOTICE("The holy light compels you to live!"))

/mob/living/simple_animal/hostile/megafauna/apostle/proc/fire_field()
	if(fire_field_cooldown > world.time)
		return
	var/turf/target_c = get_turf(src)
	var/list/fire_zone = list()
	fire_field_cooldown = (world.time + fire_field_cooldown_base)
	for(var/i = 1 to field_range)
		playsound(target_c, 'sound/effects/apostle/mob/fire_activate.ogg', 60, 1)
		fire_zone = spiral_range_turfs(i, target_c) - spiral_range_turfs(i-1, target_c)
		for(var/turf/simulated/floor/T in fire_zone)
			new /obj/effect/temporary/cultfloor(T)
		sleep(1.5)
	sleep(3)
	for(var/i = 1 to field_range)
		fire_zone = spiral_range_turfs(i, target_c) - spiral_range_turfs(i-1, target_c)
		playsound(target_c, 'sound/effects/apostle/mob/ark_damage.ogg', 80, 1)
		for(var/turf/simulated/floor/T in fire_zone)
			new /obj/effect/temporary/runeconvert(T)
			for(var/mob/living/L in T.contents)
				if(L.faction == "apostle")
					continue
				L.adjustFireLoss(15)
				L.Weaken(2)
				to_chat(L, SPAN_USERDANGER("You're hit by [src]'s fire field!"))
		sleep(1.5)

/mob/living/simple_animal/hostile/megafauna/apostle/proc/holy_blink(target)
	if(blink_cooldown > world.time)
		return
	blink_cooldown = (world.time + blink_cooldown_base)
	var/turf/T = get_turf(target)
	var/turf/S = get_turf(src)
	for(var/turf/a in range(1, S))
		new /obj/effect/temporary/sparkle(a)
	sleep(2.5)
	for(var/turf/b in range(1, T))
		new /obj/effect/temporary/sparkle(b)
	sleep(5)
	src.visible_message(SPAN_DANGER("[src] blinks away!"))
	for(var/turf/b in range(1, T))
		new /obj/effect/temporary/smoke(b)
		for(var/mob/living/H in b)
			if(H.faction != "apostle")
				to_chat(H, SPAN_USERDANGER("A sudden wave of wind sends you flying!"))
				H.adjustBruteLoss(10)
				H.Weaken(2)
				shake_camera(H, 2, 1)
	playsound(T, 'sound/effects/bamf.ogg', 100, 1)
	forceMove(T)

/mob/living/simple_animal/hostile/megafauna/apostle/proc/rapture()
	rapture_skill.Remove(src)
	apostle_num = 666 // This is for special stuff in attacks
	chosen_attack = 1 // To avoid rapture spam
	to_chat(src, SPAN_DANGER("You begin the final ritual..."))
	holy_revival_cooldown_base = 8 SECONDS
	fire_field_cooldown_base = 16 SECONDS
	field_range += 1 // Powercrepe
	for(var/mob/M in GLOB.player_list)
		if(M.client) // Send it to every player currently active, not just everyone on Z-level
			M.playsound_local(get_turf(M), 'sound/effects/apostle/antagonist/rapture.ogg', 50)
	sleep(30)
	for(var/datum/mind/A in GLOB.apostles)
		if(!A.current || !ishuman(A.current))
			continue
		var/mob/living/carbon/H = A.current
		if(!H.client && ckey)
			var/mob/observer/ghost/ghost = find_dead_player(H.ckey, 1)
			if(ghost)
				ghost.reenter_corpse()
		GLOB.apostle_antag.rapture(H)
		H.rejuvenate()
		shake_camera(H, 1, 1)
		var/turf/main_loc = get_step(src, pick(0,1,2,4,5,6,8,9,10)) // Add special effect for 12th apostle here.
		sleep(20)
		H.forceMove(main_loc)
		for(var/mob/M in GLOB.player_list)
			if(M.z == z && M.client)
				/*var/mod = "st"
				switch(A.number)
					if(1)
						mod = "st"
					if(2)
						mod = "nd"
					if(3)
						mod = "rd"
					else
						mod = "th"*/
				to_chat(M, FONT_LARGE(SPAN_DANGER("[H.real_name]..."))) // FIX ME
				M.playsound_local(get_turf(M), 'sound/effects/apostle/mob/apostle_bell.ogg', 100)
				flash_color(M, flash_color = "#ff0000", flash_time = 30)
		sleep(60)
	sleep(300)
	for(var/mob/M in GLOB.player_list)
		if(M.z == z && M.client)
			M.playsound_local(get_turf(M), 'sound/effects/apostle/antagonist/rapture2.ogg', 50)

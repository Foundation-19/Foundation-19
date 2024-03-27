/mob/living/simple_animal/hostile/megafauna/white_night
	name = "White Night"
	desc = "The heavens' wrath. Say your prayers, heretic, the day has come."
	icon = 'icons/mob/simple_animal/white_night.dmi'
	icon_state = "white_night"
	icon_living = "white_night"
	icon_dead = "white_night"
	speak_emote = list("proclaims")
	response_harm = "strikes"
	faction = "apostle"

	default_pixel_x = -16
	default_pixel_y = -16
	pixel_x = -16
	pixel_y = -16

	deathsound = 'sounds/scp/abnormality/white_night/apostle_death.ogg'

	health = 15000
	maxHealth = 15000

	movement_cooldown = 8
	movement_sound = 'sounds/scp/abnormality/white_night/apostle_movement.ogg'

	status_flags = NO_ANTAG

	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7

	natural_armor = list(
		melee = ARMOR_MELEE_KNIVES
		)

	mob_actions = list(
		/datum/action/megafauna/holy_revival,
		/datum/action/megafauna/charged_field,
		/datum/action/megafauna/holy_blink,
		)

	var/datum/action/megafauna/rapture/rapture_skill = new /datum/action/megafauna/rapture

	// Cooldowns
	var/holy_revival_cooldown = 10 SECONDS
	var/holy_revival_cooldown_time = 10 SECONDS
	var/holy_revival_damage = 16 // Amount of damage
	var/holy_revival_range = 6
	var/charged_field_cooldown = 20 SECONDS
	var/charged_field_cooldown_time = 20 SECONDS
	var/charged_field_damage = 60
	var/charged_field_range = 4
	var/scream_cooldown = 18 SECONDS
	var/scream_cooldown_time = 18 SECONDS
	var/scream_power = 25
	var/apostle_cooldown = 20 SECONDS // Cooldown for conversion
	var/apostle_cooldown_time = 20 SECONDS
	var/blink_cooldown = 6 SECONDS
	var/blink_cooldown_time = 6 SECONDS

	/// To prematurely stop visual effects of conversion
	var/cancel_conversion_effect = FALSE
	/// Tells us if rapture was started
	var/rapture_complete = FALSE

	/// List of apostles. Ckey = list(mob ref, name)
	/// We store ckey and name in case mob gets deleted and turned to null.
	var/list/apostles = list()
	/// Just the lines to show globally when someone is converted.
	/// %NAME% is replaced by apostle's name.
	/// %PREV% is replaced by name of previous apostle.
	var/list/apostle_lines = list(
		"And I tell you, you are %NAME% the apostle, and on this rock I will build my church, and the gates of hell shall not prevail against it.",
		"Tell us, when will this happen, and what will be the sign of your coming and of the end of the age?",
		"Do you want us to call fire down from heaven to destroy them?",
		"%PREV% the apostle and %NAME% the apostle, to them he gave the name Boanerges, which means \"sons of thunder\"",
		"%NAME% the apostle said, \"Show us the Father and that will be enough for us.\"",
		"He saw a human named %NAME% the apostle. \"Follow me.\" he told him, and %NAME% got up and followed him.",
		"Now for some time %NAME% the apostle had practiced sorcery and amazed all the people.",
		"Then %NAME% the apostle said to the rest of disciples, \"Let us also go, that we may die with him.\"",
		"Then %NAME% the apostle declared, \"You are the son of him, you are the king.\"",
		"Then %NAME% the apostle said, \"But why do you intend to show yourself to us and not to the world?\"",
		"From now on, let no one cause me trouble, for I bear on my body the marks of him.",
		"Have I not chosen you, the Twelve? Yet one of you is a devil.",
		)

/datum/action/megafauna/holy_revival
	name = "Holy Revival"
	button_icon_state = "magicm"
	chosen_message = "You are now reviving the dead and purging the heretics."
	chosen_attack_num = 1

/datum/action/megafauna/charged_field
	name = "Charged Field"
	button_icon_state = "shield"
	chosen_message = "You are now charging a heavy attack that damages the heretics near you."
	chosen_attack_num = 2

/datum/action/megafauna/holy_blink
	name = "Holy Blink"
	button_icon_state = "blink"
	chosen_message = "You will now blink to your target and throw away the heretics."
	chosen_attack_num = 3

/datum/action/megafauna/rapture
	name = "Rapture"
	button_icon_state = "knock"
	chosen_message = "Finale..."
	chosen_attack_num = 101

/mob/living/simple_animal/hostile/megafauna/white_night/death(gibbed, deathmessage = "evaporates in a moment, leaving heavenly light and feathers behind.", show_dead_message)
	for(var/mob/living/L in apostles)
		to_chat(L, SPAN_USERDANGER("The prophet is dead..."))
		L.death()
		QDEL_IN(L, 2 SECONDS) // TODO: TEMPORARY, ADD COOL DEATH EFFECT
	qdel(src)
	return ..()

/mob/living/simple_animal/hostile/megafauna/white_night/get_status_tab_items()
	.=..()
	if(LAZYLEN(apostles) && !rapture_complete)
		. += "Apostles converted: [length(apostles)]."

/mob/living/simple_animal/hostile/megafauna/white_night/UnarmedAttack(mob/living/carbon/human/H)
	if(!ishuman(H))
		return
	if(!H.ckey || !H.client)
		return
	if(H.ckey in apostles)
		return
	if(H.stat == DEAD)
		return
	InitiateConversion(H)

/mob/living/simple_animal/hostile/megafauna/white_night/RangedAttack(atom/A)
	. = ..()
	if(client && !A.Adjacent(src))
		switch(chosen_attack)
			if(1)
				HolyRevival()
			if(2)
				ChargedField()
			if(3)
				HolyBlink(A)
			if(101)
				Rapture()
		return

// Conversion ritual
/mob/living/simple_animal/hostile/megafauna/white_night/proc/InitiateConversion(mob/living/carbon/human/H)
	if(rapture_complete)
		return
	if(length(apostles) >= 12)
		to_chat(src, SPAN_WARNING("The twelve of them shall be enough for the Heavens to come unto Earth."))
		return
	if(apostle_cooldown > world.time)
		to_chat(src, SPAN_WARNING("We're not ready to convert more apostles just yet."))
		return

	apostle_cooldown = world.time + 10 SECONDS
	H.visible_message(SPAN_WARNING("Holy light envelopes \the [H]..."))
	playsound(src, 'sounds/scp/abnormality/white_night/apostle_convert.ogg', 50, FALSE, 4)
	cancel_conversion_effect = FALSE
	addtimer(CALLBACK(src, PROC_REF(ConversionVisualEffect), H))
	if(!do_after(src, 7 SECONDS, H))
		to_chat(src, SPAN_WARNING("The ritual has been interrupted!"))
		cancel_conversion_effect = TRUE
		return
	HumanConversion(H)

// Bunch of visual effects
/mob/living/simple_animal/hostile/megafauna/white_night/proc/ConversionVisualEffect(mob/living/carbon/human/H)
	for(var/i = 1 to 16)
		if(cancel_conversion_effect)
			return
		for(var/ix = 1 to rand(1, 3))
			var/turf/T = get_step(H, pick(0,1,2,4,5,6,8,9,10))
			var/obj/effect/temp_visual/sparkle/cyan/C = new (T)
			animate(C, alpha = 0, time = rand(3,6))
		SLEEP_CHECK_DEATH(4)

// Actual conversion result
/mob/living/simple_animal/hostile/megafauna/white_night/proc/HumanConversion(mob/living/carbon/human/H)
	if(length(apostles) >= 12)
		to_chat(src, SPAN_WARNING("The twelve of them shall be enough for the Heavens to come unto Earth."))
		return
	if(!H.client)
		var/mob/observer/ghost/ghost = find_dead_player(H.ckey, 1)
		if(!istype(ghost))
			return FALSE
		if(!ghost.client)
			return FALSE
		ghost.reenter_corpse()
	apostle_cooldown = world.time + apostle_cooldown_time
	H.revive()
	// Giving the fancy stuff to new apostle
	apostles[H.ckey] = list(H, H.real_name)
	H.faction = "apostle"
	to_chat(H, SPAN_NOTICE("You are protected by the holy light!"))
	if(length(apostles) < 12)
		var/image/apostle_halo = overlay_image('icons/mob/32x64.dmi', "halo")
		H.overlays_standing[27] = apostle_halo
		H.queue_icon_update()
	// Buffs
	// TODO: Species are singletons, do something that works for apostles only
	/*H.species.brute_mod *= 0.8
	H.species.burn_mod *= 0.8
	H.species.stun_mod *= 0.8
	H.species.weaken_mod *= 0.8
	H.species.slowdown -= 1*/
	SLEEP_CHECK_DEATH(2 SECONDS)
	// Spooky message
	var/apostle_line = apostle_lines[length(apostles)]
	apostle_line = replacetext(apostle_line, "%NAME%", H.real_name)
	if(findtext(apostle_line, "%PREV%"))
		var/apostle_name = apostles[apostles[length(apostles) - 1]][2]
		apostle_line = replacetext(apostle_line, "%PREV%", apostle_name)
	for(var/mob/M in GLOB.player_list)
		if((M.z in GetConnectedZlevels(z)) && M.client)
			to_chat(M, FONT_LARGE(SPAN_OCCULT(apostle_line)))
			M.playsound_local(get_turf(M), 'sounds/scp/abnormality/white_night/apostle_bell.ogg', 75, FALSE)
			flash_color(M, flash_color = "#ff0000", flash_time = 50)
	// Allows us to begin rapture
	if(apostles.len >= 12)
		rapture_skill.Grant(src)
	maxHealth += 100
	health = maxHealth
	holy_revival_damage += 2 // More damage and healing from AOE spell.
	return TRUE

/mob/living/simple_animal/hostile/megafauna/white_night/proc/HolyRevival()
	if(holy_revival_cooldown > world.time)
		return
	holy_revival_cooldown = world.time + holy_revival_cooldown_time

	playsound(src, 'sounds/scp/abnormality/white_night/apostle_spell.ogg', 100, TRUE, 7)
	var/turf/target_c = get_turf(src)
	for(var/i = 1 to holy_revival_range)
		for(var/turf/T in spiral_range_turfs(i, target_c) - spiral_range_turfs(i-1, target_c))
			new /obj/effect/temp_visual/sparkle(T)
			for(var/mob/living/L in T)
				if(L.faction != faction)
					if(L.stat == DEAD)
						continue
					playsound(L, 'sounds/scp/abnormality/white_night/ark_damage.ogg', 50, TRUE, -1)
					L.adjustFireLoss(holy_revival_damage)
					L.emote("scream")
					to_chat(L, SPAN_OCCULT("The holy light... IT BURNS!!"))
				else
					if(!L.client && L.ckey)
						var/mob/observer/ghost/ghost = find_dead_player(L.ckey, 1)
						if(istype(ghost))
							ghost.reenter_corpse()
					L.revive()
					to_chat(L, SPAN_NOTICE("The holy light compels you to live!"))
		SLEEP_CHECK_DEATH(2)

/mob/living/simple_animal/hostile/megafauna/white_night/proc/ChargedField()
	if(charged_field_cooldown > world.time)
		return
	charged_field_cooldown = world.time + charged_field_cooldown_time

	playsound(src, 'sounds/scp/abnormality/white_night/apostle_charge.ogg', 75, FALSE, 7)
	for(var/i = 1 to 2)
		var/obj/effect/temp_visual/decoy/D = new(get_turf(src), 0, src, 7)
		D.transform = matrix()*2
		D.alpha = 25
		animate(D, transform = matrix(), alpha = 175, time = 6)
		if(!do_after(src, (0.9 SECONDS), src))
			return

	// Scare everyone
	playsound(src, 'sounds/scp/abnormality/white_night/apostle_fire.ogg', 100, FALSE, 14)
	for(var/mob/living/L in range(src, 10))
		shake_camera(L, 5, 2)

	var/turf/target_c = get_turf(src)
	for(var/i = 1 to charged_field_range)
		for(var/turf/T in spiral_range_turfs(i, target_c) - spiral_range_turfs(i-1, target_c))
			for(var/ix = 1 to 3)
				var/obj/effect/temp_visual/smash/S = new(T)
				S.color = COLOR_RED
				S.pixel_x = rand(-8, 8)
				S.pixel_y = rand(-8, 8)
				animate(S, transform = matrix()*2, alpha = 0, time = 5)
			for(var/mob/living/L in T)
				if(L.faction == faction)
					continue
				if(L.stat == DEAD)
					continue
				playsound(L, 'sounds/scp/abnormality/white_night/ark_damage.ogg', 50, TRUE)
				L.adjustFireLoss(charged_field_damage)
				L.emote("scream")
				to_chat(L, SPAN_OCCULT("The holy light... IT BURNS!!"))
		SLEEP_CHECK_DEATH(1.5)

/mob/living/simple_animal/hostile/megafauna/white_night/proc/HolyBlink(target)
	if(blink_cooldown > world.time)
		return
	blink_cooldown = (world.time + blink_cooldown_time)
	var/turf/T = get_turf(target)
	var/turf/S = get_turf(src)
	for(var/turf/a in range(1, S))
		new /obj/effect/temp_visual/sparkle(a)
	SLEEP_CHECK_DEATH(2.5)
	for(var/turf/b in range(1, T))
		new /obj/effect/temp_visual/sparkle(b)
	SLEEP_CHECK_DEATH(5)
	visible_message(SPAN_DANGER("[src] blinks away!"))
	for(var/turf/b in range(1, T))
		new /obj/effect/temp_visual/smoke(b)
		for(var/mob/living/H in b)
			if(H.faction != "apostle")
				to_chat(H, SPAN_USERDANGER("A sudden wave of wind sends you flying!"))
				H.adjustBruteLoss(10)
				H.Weaken(2)
				shake_camera(H, 2, 1)
	playsound(T, 'sounds/effects/bamf.ogg', 100, 1)
	forceMove(T)

// The beginning of the end
/mob/living/simple_animal/hostile/megafauna/white_night/proc/Rapture()
	rapture_skill.Remove(src)
	rapture_complete = TRUE
	chosen_attack = 1 // To avoid rapture spam
	to_chat(src, SPAN_DANGER("You begin the final ritual..."))
	holy_revival_cooldown_time = 8 SECONDS
	holy_revival_range += 6
	charged_field_cooldown_time = 16 SECONDS
	charged_field_range += 1 // Powercrepe
	for(var/mob/M in GLOB.player_list)
		if(M.client && !isnewplayer(M)) // Send it to every player currently active(outside of lobby), not just everyone on Z-level
			M.playsound_local(get_turf(M), 'sounds/scp/abnormality/white_night/rapture.ogg', 50)
	SLEEP_CHECK_DEATH(3 SECONDS)
	for(var/i = 1 to apostles.len)
		var/apostle_key = apostles[i]
		var/mob/living/carbon/human/H = apostles[apostle_key][1]
		// Most likely the mob got gibbed.
		if(QDELETED(H))
			H = new(src)
			H.ckey = apostle_key
			H.fully_replace_character_name(apostles[apostle_key][2])
		if(!ishuman(H))
			continue
		if(!H.client && ckey)
			var/mob/observer/ghost/ghost = find_dead_player(H.ckey, 1)
			if(ghost)
				ghost.reenter_corpse()
		H.revive()
		if(i < 12)
			var/turf/main_loc = get_step(src, pick(0,1,2,4,5,6,8,9,10))
			H.forceMove(main_loc)
		SLEEP_CHECK_DEATH(2 SECONDS)
		for(var/mob/M in GLOB.player_list)
			if((M.z in GetConnectedZlevels(z)) && M.client)
				var/apostle_line = apostle_lines[i]
				apostle_line = replacetext(apostle_line, "%NAME%", H.real_name)
				if(findtext(apostle_line, "%PREV%"))
					var/apostle_name = "Unknown"
					if(islist(apostles[min(1, i - 1)]) && length(apostles[min(1, i - 1)]) >= 2)
						apostle_name = apostles[min(1, i - 1)][2]
					apostle_line = replacetext(apostle_line, "%PREV%", apostle_name)
				to_chat(M, FONT_LARGE(SPAN_DANGER(apostle_line)))
				M.playsound_local(get_turf(M), 'sounds/scp/abnormality/white_night/apostle_bell.ogg', 100)
				flash_color(M, flash_color = "#ff0000", flash_time = 30)
		apostles[i] = TurnHumanIntoApostle(H, i)
		SLEEP_CHECK_DEATH(6 SECONDS)
	SLEEP_CHECK_DEATH(30 SECONDS)
	for(var/mob/M in GLOB.player_list)
		if(M.z == z && M.client)
			M.playsound_local(get_turf(M), 'sounds/scp/abnormality/white_night/rapture2.ogg', 50)

/mob/living/simple_animal/hostile/megafauna/white_night/proc/TurnHumanIntoApostle(mob/living/carbon/human/H, number = 0)
	var/apostle_type = /mob/living/simple_animal/hostile/apostle/scythe
	switch(number)
		if(1,11)
			apostle_type = /mob/living/simple_animal/hostile/apostle/scythe/guardian
		/*if(4,5,6)
			apostle_type = /mob/living/simple_animal/hostile/apostle/staff*/
		if(7,8,9,10)
			apostle_type = /mob/living/simple_animal/hostile/apostle/spear
	var/mob/living/simple_animal/hostile/apostle/A = new apostle_type(get_turf(H))
	A.name = H.real_name
	H.mind.transfer_to(A)
	QDEL_NULL(H)
	return A

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

	deathsound = 'sound/scp/abnormality/white_night/apostle_death.ogg'

	health = 15000
	maxHealth = 15000

	natural_armor = list(
		melee = ARMOR_MELEE_KNIVES
		)

	mob_actions = list(
						/datum/action/megafauna/holy_revival,
						/datum/action/megafauna/charged_field,
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

	/// Assoc list of apostles. Mob ref = list(ckey, name).
	/// We store ckey and name in case mob gets deleted.
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
	for(var/datum/mind/A in GLOB.apostles)
		if(!A.current || !ishuman(A.current))
			continue
		GLOB.apostle_antag.prophet_death(A.current)
	qdel(src)
	return ..()

/mob/living/simple_animal/hostile/megafauna/white_night/ClickOn(atom/A)
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

/mob/living/simple_animal/hostile/megafauna/white_night/proc/HolyRevival()
	if(holy_revival_cooldown > world.time)
		return
	holy_revival_cooldown = (world.time + holy_revival_cooldown_base)
	playsound(src, 'sound/scp/abnormality/white_night/apostle_spell.ogg', 100, TRUE, 7)
	for(var/turf/T in range(3, src))
		new /obj/effect/temp_visual/sparkle(T)
	for(var/mob/living/L in range(3, src))
		if(L.faction != "apostle")
			playsound(L, 'sound/scp/abnormality/white_night/ark_damage.ogg', 50, TRUE, -1)
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

/mob/living/simple_animal/hostile/megafauna/white_night/proc/HumanConversion(mob/living/carbon/human/H)
	if(apostle_cooldown >= world.time)
		return
	if(!H.client)
		var/mob/observer/ghost/ghost = find_dead_player(H.ckey, 1)
		if(!istype(ghost))
			return
		if(!ghost.client)
			return
		ghost.reenter_corpse()
	apostle_cooldown = world.time + apostle_cooldown_base
	H.revive()
	// Giving the fancy stuff to new apostle
	apostles[H] = list(H.ckey, H.real_name)
	H.faction = "apostle"
	to_chat(H, SPAN_NOTICE("You are protected by the holy light!"))
	if(length(apostles) < 12)
		var/image/apostle_halo = overlay_image('icons/mob/32x64.dmi', "halo")
		H.overlays_standing[27] = apostle_halo
		H.queue_icon_update()
	sleep(2 SECONDS)
	// Spooky message
	to_chat(world, length(apostles))
	var/apostle_line = apostle_lines[length(apostles)]
	apostle_line = replacetext(apostle_line, "%NAME%", H.real_name)
	if(findtext(apostle_line, "%PREV%"))
		apostle_line = replacetext(apostle_line, "%PREV%", apostles[apostles.len - 1][2])
	for(var/mob/M in GLOB.player_list)
		if((M.z in GetConnectedZlevels(z)) && M.client)
			to_chat(M, FONT_LARGE(SPAN_OCCULT(apostle_line)))
			M.playsound_local(get_turf(M), 'sound/scp/abnormality/white_night/apostle_bell.ogg', 75, FALSE)
			flash_color(M, flash_color = "#ff0000", flash_time = 50)
	// Allows us to begin rapture
	if(apostles.len >= 12)
		rapture_skill.Grant(src)
	maxHealth += 100
	health = maxHealth
	holy_revival_damage += 2 // More damage and healing from AOE spell.

/mob/living/simple_animal/hostile/megafauna/white_night/proc/ChargedField()
	// ADD STUFF

/mob/living/simple_animal/hostile/megafauna/white_night/proc/HolyBlink(target)
	if(blink_cooldown > world.time)
		return
	blink_cooldown = (world.time + blink_cooldown_base)
	var/turf/T = get_turf(target)
	var/turf/S = get_turf(src)
	for(var/turf/a in range(1, S))
		new /obj/effect/temp_visual/sparkle(a)
	sleep(2.5)
	for(var/turf/b in range(1, T))
		new /obj/effect/temp_visual/sparkle(b)
	sleep(5)
	visible_message(SPAN_DANGER("[src] blinks away!"))
	for(var/turf/b in range(1, T))
		new /obj/effect/temp_visual/smoke(b)
		for(var/mob/living/H in b)
			if(H.faction != "apostle")
				to_chat(H, SPAN_USERDANGER("A sudden wave of wind sends you flying!"))
				H.adjustBruteLoss(10)
				H.Weaken(2)
				shake_camera(H, 2, 1)
	playsound(T, 'sound/effects/bamf.ogg', 100, 1)
	forceMove(T)

// The beginning of the end
/mob/living/simple_animal/hostile/megafauna/white_night/proc/Rapture()
	rapture_skill.Remove(src)
	chosen_attack = 1 // To avoid rapture spam
	to_chat(src, SPAN_DANGER("You begin the final ritual..."))
	holy_revival_cooldown_base = 8 SECONDS
	fire_field_cooldown_base = 16 SECONDS
	field_range += 1 // Powercrepe
	for(var/mob/M in GLOB.player_list)
		if(M.client && !isnewplayer(M)) // Send it to every player currently active(outside of lobby), not just everyone on Z-level
			M.playsound_local(get_turf(M), 'sound/scp/abnormality/white_night/rapture.ogg', 50)
	sleep(3 SECONDS)
	for(var/i = 1 to apostles.len)
		var/mob/living/carbon/human/H = apostles[i]
		// Most likely the mob got gibbed.
		if(QDELETED(H))
			H = new(src)
			H.ckey = apostles[i][1]
			H.fully_replace_character_name(apostles[i][2])
		if(!ishuman(H))
			continue
		if(!H.client && ckey)
			var/mob/observer/ghost/ghost = find_dead_player(H.ckey, 1)
			if(ghost)
				ghost.reenter_corpse()
		H.revive()
		sleep(2 SECONDS)
		if(i < 12)
			var/turf/main_loc = get_step(src, pick(0,1,2,4,5,6,8,9,10))
			H.forceMove(main_loc)
		for(var/mob/M in GLOB.player_list)
			if((M.z in GetConnectedZlevels(z)) && M.client)
				var/apostle_line = apostle_lines[i]
				apostle_line = replacetext(apostle_line, "%NAME%", H.real_name)
				if(findtext(apostle_line, "%PREV%"))
					apostle_line = replacetext(apostle_line, "%PREV%", apostles[i - 1][2])
				to_chat(M, FONT_LARGE(SPAN_DANGER(apostle_line)))
				M.playsound_local(get_turf(M), 'sound/scp/abnormality/white_night/apostle_bell.ogg', 100)
				flash_color(M, flash_color = "#ff0000", flash_time = 30)
		sleep(6 SECONDS)
	sleep(30 SECONDS)
	for(var/mob/M in GLOB.player_list)
		if(M.z == z && M.client)
			M.playsound_local(get_turf(M), 'sound/scp/abnormality/white_night/rapture2.ogg', 50)

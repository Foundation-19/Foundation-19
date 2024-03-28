/obj/infestation_structure/hive_heart
	name = "heart of the hive"
	desc = "A giant pulsating heart-like structure. Just looking at it makes you anxious."
	icon = 'icons/mob/simple_animal/abominable_infestation/48x48.dmi'
	icon_state = "heart_beating"

	pixel_x = -8

	light_max_bright = 0.8
	light_inner_range = 5
	light_outer_range = 20
	light_color = COLOR_MAROON

	health_max = 500
	health_min_damage = 10

	/* Mob healing effect */
	var/healing_mobs_range = 7 // Just on the screen
	/// How much health is restored every HealMobs() proc
	var/healing_mobs_strength = 50
	var/healing_mobs_cooldown = 5 SECONDS

	/* Turf conversion effect */
	var/convert_turfs_range = 24
	/// How many turfs are converted on each ConvertTurfs() proc
	var/convert_turfs_count = 4
	var/convert_turfs_cooldown = 10 SECONDS

	/* Looping sound related stuff */
	var/looping_sound = 'sounds/effects/Heart Beat.ogg'
	var/looping_sound_volume = 50
	var/sound_id
	var/datum/sound_token/sound_token

/obj/infestation_structure/hive_heart/Initialize()
	. = ..()
	// The abilities operate on timers, so we must fire them once at the start
	addtimer(CALLBACK(src, PROC_REF(HealMobs)), healing_mobs_cooldown)
	addtimer(CALLBACK(src, PROC_REF(ConvertTurfs)), convert_turfs_cooldown)
	if(!looping_sound)
		return
	sound_id = "[type]_[sequential_id(type)]"
	if(!sound_token)
		sound_token = GLOB.sound_player.PlayLoopingSound(src, sound_id, looping_sound, looping_sound_volume, 24, 3)

/obj/infestation_structure/hive_heart/Destroy()
	QDEL_NULL(sound_token)
	sound_token = null
	. = ..()

/obj/infestation_structure/hive_heart/handle_death_change(new_death_state)
	. = ..()
	if(new_death_state)
		visible_message(SPAN_DANGER("\The [src] starts beating faster as cracks appear at its surface!"))
		QDEL_NULL(sound_token)
		sound_token = null
		density = FALSE
		icon_state = "heart"
		for(var/i = 1 to 5)
			if(QDELETED(src))
				return
			AbilityEffect(50 + i*20)
			if(prob(i * 10))
				new /obj/effect/gibspawner/human(get_turf(src))
			sleep(10 - i * 2)
		for(var/ii = 1 to 5)
			new /obj/effect/gibspawner/human(get_turf(src))
		playsound(src, 'sounds/simple_mob/abominable_infestation/heart_death.ogg', 125, TRUE, 24, 3, ignore_pressure = TRUE)
		visible_message(SPAN_DANGER("\The [src] explodes in a shower of gore!"))
		QDEL_NULL(src) // "But why QDEL_NULL? Bwuhuhu" because some moron might delete it in the middle of sick animation

/* Abilities */
/obj/infestation_structure/hive_heart/proc/HealMobs()
	if(QDELETED(src) || !is_alive())
		return

	addtimer(CALLBACK(src, PROC_REF(HealMobs)), healing_mobs_cooldown)

	// Also heals itself slightly
	restore_health(20)
	AbilityEffect()
	for(var/mob/living/L in range(healing_mobs_range, src))
		if(L.faction != faction)
			continue
		if(L.stat == DEAD)
			continue
		if(L.getBruteLoss() <= 0)
			continue
		L.adjustBruteLoss(-healing_mobs_strength)
		// Essentially localized AbilityEffect()
		playsound(L, 'sounds/effects/heartbeat_low.ogg', 15, TRUE, -6)
		var/obj/effect/temp_visual/decoy/D = new(get_turf(L), 0, L, 5)
		D.dir = L.dir
		D.color = COLOR_MAROON
		animate(D, transform = matrix()*1.2, alpha = 0, time = 5, easing = SINE_EASING)

/obj/infestation_structure/hive_heart/proc/ConvertTurfs()
	if(QDELETED(src) || !is_alive())
		return

	addtimer(CALLBACK(src, PROC_REF(ConvertTurfs)), convert_turfs_cooldown)

	var/list/valid_turfs = list()
	for(var/turf/T in spiral_range_turfs(convert_turfs_range, src))
		if(length(valid_turfs) >= convert_turfs_count * 2) // Enough stuff. This also creates more sane spreading pattern..?
			break

		if(!T.is_floor())
			continue

		if(istype(T, /turf/simulated/floor/exoplanet/flesh))
			continue

		var/turf/simulated/floor/F = T
		if(istype(F.flooring, /decl/flooring/flesh))
			continue

		valid_turfs |= F

	if(!LAZYLEN(valid_turfs))
		return

	AbilityEffect()

	for(var/i = 1 to convert_turfs_count)
		if(!LAZYLEN(valid_turfs))
			return

		var/turf/simulated/floor/F = pick(valid_turfs)
		// Exoplanet turfs have their own silly update icon procs, so we just replace them entirely
		if(istype(F, /turf/simulated/floor/exoplanet))
			F.ChangeTurf(/turf/simulated/floor/exoplanet/flesh)
			continue
		F.set_flooring(decls_repository.get_decl(/decl/flooring/flesh/infested))

/obj/infestation_structure/hive_heart/proc/AbilityEffect(sound_volume = 75)
	playsound(src, 'sounds/effects/heartbeat_low.ogg', sound_volume, TRUE, 24, ignore_pressure = TRUE)
	var/obj/effect/temp_visual/decoy/D = new(get_turf(src), 0, src, 10)
	animate(D, transform = matrix()*1.5, alpha = 0, time = 10, easing = SINE_EASING)

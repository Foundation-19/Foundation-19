/mob/living/simple_animal/hostile/infestation
	name = "abominable infestation"
	desc = "AUGH! A BUG! A LITERAL ONE! REPORT TO CODERS BEFORE IT SPREADS!"
	icon = 'icons/mob/simple_animal/abominable_infestation/32x32.dmi'
	// Icon states for egg
	var/icon_egg = "egg"
	var/icon_egg_dead = "egg_dead"
	faction = "abominable_infestation"
	color = "#c84444"
	bleed_colour = COLOR_MAROON
	see_in_dark = 5
	min_gas = null
	max_gas = null
	minbodytemp = 0
	maxbodytemp = 600 // Temperatures that are too high will kill them
	status_flags = 0 // Cannot be pushed, stunned or otherwise incapacitated
	melee_attack_delay = 0
	/// Reference to structure that effectively controls the colony
	var/overmind = null
	/// World time at which we will begin transforming into another mob
	var/transformation_time
	/// Assoc list of potential transformations if none are set by outer forces. Type = Time
	var/list/transformation_types = list()
	/// Which mob we will be transformed into
	var/transformation_target_type = null
	/// If TRUE - will evolve despite having a target mob
	var/ignore_combat = FALSE
	/// Speed buff when on flesh turfs
	var/flesh_movement_bonus = 0.3

/mob/living/simple_animal/hostile/infestation/Life()
	. = ..()
	if(!.)
		return
	if(isnull(transformation_time))
		return
	if(isnull(transformation_target_type) && !LAZYLEN(transformation_types))
		return
	if(world.time >= transformation_time)
		if(istype(loc, /obj/item/organ/external))
			var/obj/item/organ/external/O = loc
			if(O.owner)
				to_chat(O.owner, SPAN_DANGER("Something has wriggled out of your body!"))
				O.createwound(PIERCE, O.min_broken_damage, FALSE)
				O.owner.Weaken(5) // Gives some time for larva to turn into egg
				O.owner.apply_damage(15, BRUTE, O.organ_tag)
			O.implants -= src
			forceMove(get_turf(O))
			playsound(src, 'sounds/effects/splat.ogg', 50, TRUE)
			return
		if(icon_state != icon_egg) // Become egg
			// We're in combat, forget evolving for a moment
			if(!ignore_combat && ai_holder.target)
				transformation_time = world.time + 10 SECONDS
				return
			BecomeEgg()
			return
		Evolve()

/mob/living/simple_animal/hostile/infestation/death()
	if(icon_state == icon_egg)
		animate(src, alpha = 0, time = (5 SECONDS))
		QDEL_IN(src, (5 SECONDS))
	return ..()

// Infestation moves faster on their territory
/mob/living/simple_animal/hostile/infestation/movement_delay()
	. = ..()
	var/turf/simulated/floor/F = get_turf(src)
	if(!istype(F))
		return

	if(istype(F, /turf/simulated/floor/exoplanet/flesh) || istype(F.flooring, /decl/flooring/flesh))
		. -= flesh_movement_bonus

// While they are "resistant" to high temperatures, they are specifically weak to fire
/mob/living/simple_animal/hostile/infestation/fire_burn_temperature()
	. = ..()
	. *= 3

/mob/living/simple_animal/hostile/infestation/proc/BecomeEgg()
	name = "egg"
	desc = "A weird egg..?"
	icon_state = icon_egg
	icon_living = icon_egg
	icon_dead = icon_egg_dead
	anchored = TRUE
	QDEL_NULL(ai_holder)
	QDEL_NULL(say_list)
	ai_holder = null
	say_list = null
	death_sounds = list()
	maxHealth = clamp(maxHealth * 2, 100, 2000)
	health = maxHealth
	if(isnull(transformation_target_type) && LAZYLEN(transformation_types))
		transformation_target_type = pick(transformation_types)
	if(transformation_target_type in transformation_types)
		transformation_time = world.time + transformation_types[transformation_target_type]
		return
	transformation_time = world.time + rand(45 SECONDS, 60 SECONDS)

/mob/living/simple_animal/hostile/infestation/proc/Evolve()
	var/mob/living/simple_animal/broodling = new transformation_target_type(get_turf(src))
	broodling.color = color
	broodling.faction = faction
	if(ckey) // We're player controlled
		broodling.ckey = ckey
	gib()
	return broodling

// Shared AI behavior
/datum/ai_holder/simple_animal/infestation
	hostile = TRUE
	retaliate = TRUE
	cooperative = TRUE
	respect_confusion = FALSE

// 1:1 - Replaces the mob with random one with similar characteristics
// Fine - Instantly evolves, if possible, otherwise gets revived
// Very fine - Turns into a heart of the hive with a pool of larvas & random infestation mobs
/mob/living/simple_animal/hostile/infestation/Conversion914(mode = MODE_ONE_TO_ONE, mob/user = usr)
	switch(mode)
		if(MODE_ONE_TO_ONE)
			var/list/potential_mobs = list()
			for(var/infestation_type in subtypesof(/mob/living/simple_animal/hostile/infestation))
				var/mob/living/simple_animal/hostile/infestation/I = infestation_type
				if(initial(I.maxHealth) > maxHealth * 2 || initial(I.maxHealth) < maxHealth * 0.5)
					continue
				if(initial(I.movement_cooldown) > movement_cooldown + 2 || initial(I.movement_cooldown) < movement_cooldown - 2)
					continue
				potential_mobs += infestation_type
			if(!LAZYLEN(potential_mobs))
				return src
			var/picked_mob = pick(potential_mobs)
			return picked_mob
		if(MODE_FINE)
			if(!stat) // Alive and well
				if(isnull(transformation_target_type) && LAZYLEN(transformation_types))
					transformation_target_type = pick(transformation_types)
				if(transformation_target_type)
					return Evolve()
			revive()
			return src
		if(MODE_VERY_FINE)
			var/turf/T = get_turf(src)
			var/list/random_mobs = list(
				/mob/living/simple_animal/hostile/infestation/larva/implant/implanter,
				/mob/living/simple_animal/hostile/infestation/broodling,
				/mob/living/simple_animal/hostile/infestation/floatfly,
				/mob/living/simple_animal/hostile/infestation/spitter,
				)
			for(var/i = 1 to rand(3, 9))
				new /mob/living/simple_animal/hostile/infestation/larva(T)
			for(var/i = 1 to rand(3, 9))
				var/rand_mob = pick(random_mobs)
				new rand_mob(T)
			return /obj/infestation_structure/hive_heart
	return ..()

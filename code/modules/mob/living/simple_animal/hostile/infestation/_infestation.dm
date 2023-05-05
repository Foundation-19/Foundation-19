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
	status_flags = CANPUSH // Cannot be stunned or otherwise incapacitated
	melee_attack_delay = 0
	/// Reference to structure that effectively controls the colony
	var/overmind = null
	/// World time at which we will begin transforming into another mob
	var/transformation_time
	/// Assoc list of potential transformations if none are set by outer forces. Type = Time
	var/list/transformation_types = list()
	/// Which mob we will be transformed into
	var/transformation_target_type = null

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
			playsound(src, 'sound/effects/splat.ogg', 50, TRUE)
			return
		if(icon_state != icon_egg) // Become egg
			// We're in combat, forget evolving for a moment
			if(ai_holder.target)
				transformation_time = world.time + 10 SECONDS
				return
			BecomeEgg()
			return
		Evolve()

/mob/living/simple_animal/hostile/infestation/death()
	if(icon_state == icon_egg)
		animate(src, alpha = 0, time = 25)
		QDEL_IN(src, 25)
	return ..()

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
	maxHealth *= 2
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

// Shared AI behavior
/datum/ai_holder/simple_animal/infestation
	hostile = TRUE
	retaliate = TRUE
	cooperative = TRUE
	respect_confusion = FALSE

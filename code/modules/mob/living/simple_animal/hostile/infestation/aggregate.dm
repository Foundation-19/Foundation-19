// Enormous damage, Very high health, Very low mobility.
// Spawns small "meat chips" when damaged.
// Constantly regenerates health.
// Recommended strategy is using flamethrower and stay AT LEAST 4-5 tiles away from it.
// DO NOT stop fighting it, as it will inevitably regenerate all health if you leave it alone for too long.
/mob/living/simple_animal/hostile/infestation/aggregate
	name = "aggregate"
	desc = "A repulsive mass of flesh that is constantly regenerating itself."
	icon = 'icons/mob/simple_animal/abominable_infestation/48x48.dmi'
	icon_state = "aggregate"
	icon_living = "aggregate"
	icon_dead = "aggregate_dead"
	mob_size = MOB_LARGE
	default_pixel_x = -8
	pixel_x = -8
	movement_cooldown = 8

	// A giant fuck-off bite attack; Don't come close to this thing
	natural_weapon = /obj/item/natural_weapon/bite/aggregate

	health = 1200
	maxHealth = 1200

	meat_type = /obj/item/reagent_containers/food/snacks/abominationmeat
	meat_amount = 15
	skin_material = MATERIAL_SKIN_CHITIN
	skin_amount = 10
	bone_material = MATERIAL_BONE_CARTILAGE
	bone_amount = 2

	death_sounds = list('sounds/simple_mob/abominable_infestation/aggregate/death.ogg')

	/// Percent of max HP restored every Life() tick
	var/regeneration_speed = 0.005
	/// How much health should we have before throwing a new meatchip
	var/spawn_health = 0
	/// How much percents of max HP is reduced from spawn_health on each new meatchip spawn
	var/spawn_health_reduction = 0.03

/obj/item/natural_weapon/bite/aggregate
	name = "malformed teeth"
	attack_verb = list("bitten with many of its deformed teeth")
	hitsound = 'sounds/simple_mob/abominable_infestation/aggregate/attack.ogg'
	force = 100 // Yes. A hundred. Do NOT fight it in melee.
	armor_penetration = 20
	melee_accuracy_bonus = 50 // Three bites, less miss chance :)
	attack_cooldown = DEFAULT_WEAPON_COOLDOWN * 1.5

// Show the foolish mortals just how deadly this attack was!
/obj/item/natural_weapon/bite/aggregate/apply_hit_effect(mob/living/target, mob/living/user, hit_zone)
	. = ..()
	for(var/i = 1 to 3)
		addtimer(CALLBACK(src, PROC_REF(SpawnBiteEffect), target), i-1)

/obj/item/natural_weapon/bite/aggregate/proc/SpawnBiteEffect(mob/living/target)
	if(QDELETED(target))
		return
	var/obj/effect/temp_visual/bite/B = new (get_turf(target))
	B.color = pick(COLOR_MAROON, COLOR_RED, COLOR_RED_GRAY)
	B.pixel_x = rand(-8, 8)
	B.pixel_y = rand(-8, 8)

/mob/living/simple_animal/hostile/infestation/aggregate/Initialize()
	. = ..()
	spawn_health = round(maxHealth * (1 - spawn_health_reduction))

/mob/living/simple_animal/hostile/infestation/aggregate/Life()
	. = ..()
	if(!.)
		return
	if(health <= maxHealth)
		adjustBruteLoss(-round(maxHealth * regeneration_speed))
		// While regenerating, it will restore its ability to fire meatchips
		spawn_health = min(spawn_health + round(maxHealth * regeneration_speed), round(maxHealth * (1 - spawn_health_reduction)))

/mob/living/simple_animal/hostile/infestation/aggregate/updatehealth()
	. = ..()
	if(stat == DEAD || health <= 0)
		return
	if(health > spawn_health)
		return
	addtimer(CALLBACK(src, PROC_REF(SpawnMeatChip)), rand(1, 4))

/mob/living/simple_animal/hostile/infestation/aggregate/proc/SpawnMeatChip()
	if(stat == DEAD || health <= 0)
		return
	spawn_health -= round(maxHealth * spawn_health_reduction)
	var/list/potential_targets = list()
	for(var/mob/living/L in view(7, src))
		if(L.stat)
			continue
		if(L.faction == faction)
			continue
		potential_targets += L
	var/atom/throw_target = null
	if(LAZYLEN(potential_targets))
		throw_target = pick(potential_targets)
	visible_message(SPAN_WARNING("A tiny creature flies off the [src]!"))
	playsound(src, 'sounds/simple_mob/abominable_infestation/aggregate/spawn_meatchip.ogg', 50, TRUE)
	var/mob/living/simple_animal/hostile/infestation/meatchip/M = new(get_turf(src))
	if(!throw_target)
		throw_target = pick(getcircle(get_turf(src), 3))
	M.throw_at(get_turf(throw_target), 3, 1, src)
	addtimer(CALLBACK(M, TYPE_PROC_REF(/mob/living/simple_animal/hostile/infestation/meatchip, TimedDeath)), 15 SECONDS)

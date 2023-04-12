// A random hostile mob that will receive equally random abiltiies(from a list)
/mob/living/simple_animal/hostile/random_monster
	name = "random monster" // Generated on Initialize
	desc = "A rare kind of monster. So rare, that you, in fact, don't even know what it really does."

	icon = 'icons/mob/simple_animal/random_monster.dmi'
	icon_state = "spider"
	icon_living = "spider"
	icon_dead = "spider_dead"

	faction = "hostile"
	maxHealth = 100
	health = 100

	movement_cooldown = 4

	special_attack_min_range = 0
	special_attack_max_range = 14
	special_attack_cooldown = 10

	natural_weapon = /obj/item/natural_weapon/bite/spider

	/// The abilities mob can't roll for
	var/list/banned_abilities = list(/datum/random_ability/active, /datum/random_ability/death, /datum/random_ability/death/mitosis/repeat)
	/// What abilities the mob MUST spawn with
	var/list/musthave_abilities = list()
	/// What abilities it can choose from. If it's empty - it will generate a list
	var/list/potential_abilities = list()
	/// Currently available abilities
	var/list/abilities = list()
	/// How much abilities we can roll for
	var/abilities_amount = 2
	/// What overlays will be drawn on the mob
	var/list/overlay_types = list()

/* Initializations */
/mob/living/simple_animal/hostile/random_monster/Initialize()
	. = ..()
	InitAbilities()
	InitName()
	InitStats()
	InitAppearance()

/mob/living/simple_animal/hostile/random_monster/proc/InitAbilities()
	if(!LAZYLEN(potential_abilities))
		potential_abilities = (subtypesof(/datum/random_ability) - banned_abilities - musthave_abilities)
	for(var/mhra in musthave_abilities)
		var/datum/random_ability/choice = mhra
		abilities += new choice
	for(var/i=1 to abilities_amount)
		if(!LAZYLEN(potential_abilities))
			break
		var/datum/random_ability/choice = pick(potential_abilities)
		abilities += new choice
		potential_abilities -= choice

/mob/living/simple_animal/hostile/random_monster/proc/InitName()
	var/list/name_list = list()
	for(var/datum/random_ability/ra in abilities)
		if(ra.added_name)
			name_list += ra.added_name
	if(!LAZYLEN(name_list))
		name_list += "alien monster"
	name = pick(name_list)

/mob/living/simple_animal/hostile/random_monster/proc/InitStats()
	var/list/possible_weapons = list(/obj/item/natural_weapon/bite, /obj/item/natural_weapon/claws)
	natural_weapon = pick(possible_weapons)
	for(var/datum/random_ability/ra in abilities)
		maxHealth += ra.health_mod
		movement_cooldown += ra.speed_mod

/mob/living/simple_animal/hostile/random_monster/proc/InitAppearance()
	for(var/datum/random_ability/ra in abilities)
		if((ra.overlay_type == null) || (ra.overlay_type in overlay_types))
			continue
		overlay_types += ra.overlay_type
	update_icon()

/mob/living/simple_animal/hostile/random_monster/on_update_icon()
	overlays.Cut()
	if(stat != DEAD)
		for(var/ov in overlay_types)
			overlays += image(icon, ov)

/* Using abilities */
/mob/living/simple_animal/hostile/random_monster/do_special_attack(atom/A)
	. = ..()
	var/list/possible_abilities = list()
	for(var/datum/random_ability/active/ara in abilities)
		if(ara.CanUse(src))
			possible_abilities += ara
	if(LAZYLEN(possible_abilities))
		var/datum/random_ability/active/abil = pick(possible_abilities)
		abil.perform(src, A)

/* Death */
/mob/living/simple_animal/hostile/random_monster/death(gibbed, deathmessage = "dies!", show_dead_message)
	. = ..()
	if(!.) // Mob was already dead; I.e. it got gibbed while dead
		return
	for(var/datum/random_ability/death/dra in abilities)
		if(dra.CanUse(src, gibbed))
			dra.perform(src, null)

/* Destroy */
// Here we clean up the abilities list
/mob/living/simple_animal/hostile/random_monster/Destroy()
	for(var/datum/D in abilities)
		qdel(D)
	return ..()


// *** Preset types ***//
// Mitosis
/mob/living/simple_animal/hostile/random_monster/mitosis
	abilities_amount = 1
	musthave_abilities = list(/datum/random_ability/death/mitosis)

/mob/living/simple_animal/hostile/random_monster/mitosis/repeat
	musthave_abilities = list(/datum/random_ability/death/mitosis/repeat)

// Everything
/mob/living/simple_animal/hostile/random_monster/everything
	abilities_amount = 10

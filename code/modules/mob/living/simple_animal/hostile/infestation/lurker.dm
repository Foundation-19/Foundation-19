// High ranged damage, Medium health, Low mobility.
// Recommended strategy is to rush it, as its melee damage is subpar and has no armor penetration.
/mob/living/simple_animal/hostile/infestation/lurker
	name = "lurker"
	desc = "A spider-like creature with multiple spikes protruding from its \"legs\"."
	icon = 'icons/mob/simple_animal/abominable_infestation/48x48.dmi'
	// !!!! I am not a very good spriter, please update it later !!!!
	icon_state = "eviscerator"
	icon_living = "eviscerator"
	icon_dead = "eviscerator_dead"
	mob_size = MOB_MEDIUM
	movement_cooldown = 5

	natural_weapon = /obj/item/natural_weapon/claws/abomination_lurker

	base_attack_cooldown = 1 SECONDS
	ranged_attack_cooldown = 3 SECONDS

	special_attack_min_range = 2
	special_attack_max_range = 6
	special_attack_cooldown = 2 SECONDS

	health = 400
	maxHealth = 400

	meat_type = /obj/item/reagent_containers/food/snacks/abominationmeat
	meat_amount = 6
	skin_material = MATERIAL_SKIN_CHITIN
	skin_amount = 4
	bone_material = MATERIAL_BONE_CARTILAGE
	bone_amount = 10

	ai_holder_type = /datum/ai_holder/simple_animal/infestation/lurker
	say_list_type = /datum/say_list/infestation_lurker
	death_sounds = list('sounds/simple_mob/abominable_infestation/lurker/death.ogg')

	var/spike_damage = 35
	/// Sleep time between each new spike
	var/spike_delay = 1.5

/obj/item/natural_weapon/claws/abomination_lurker
	force = 10
	armor_penetration = 10
	hitsound = 'sounds/simple_mob/abominable_infestation/eviscerator/attack.ogg'

/datum/say_list/infestation_lurker
	emote_hear = list("gurgles")

	emote_hear_sounds = list(
		'sounds/simple_mob/abominable_infestation/lurker/ambient_1.ogg',
		)

/datum/ai_holder/simple_animal/infestation/lurker
	returns_home = FALSE
	home_low_priority = TRUE
	speak_chance = 2
	wander = TRUE
	base_wander_delay = 15

/datum/ai_holder/simple_animal/infestation/lurker/closest_distance(atom/movable/AM)
	return holder.special_attack_min_range

/datum/ai_holder/simple_animal/infestation/lurker/max_range(atom/movable/AM)
	return holder.special_attack_max_range

/mob/living/simple_animal/hostile/infestation/lurker/do_special_attack(atom/A)
	set waitfor = FALSE
	set_AI_busy(TRUE)
	face_atom(A)

	var/list/attack_line = getline(get_step(src, get_dir(src, A)), A)
	for(var/turf/T in attack_line)
		sleep(spike_delay)
		SpikeTurf(T)

	set_AI_busy(FALSE)

/mob/living/simple_animal/hostile/infestation/lurker/proc/SpikeTurf(turf/T)
	if(QDELETED(src))
		return FALSE

	new /obj/effect/temp_visual/infestation_spike(T, get_dir(src, T), spike_damage)

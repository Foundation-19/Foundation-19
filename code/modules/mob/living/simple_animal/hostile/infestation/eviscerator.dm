/mob/living/simple_animal/hostile/infestation/eviscerator
	name = "eviscerator"
	desc = "A large monster with very sharp spear-like limbs. You better start running..."
	icon = 'icons/mob/simple_animal/abominable_infestation/48x48.dmi'
	icon_state = "eviscerator"
	icon_living = "eviscerator"
	icon_dead = "eviscerator_dead"
	mob_size = MOB_MEDIUM
	default_pixel_x = -8
	pixel_x = -8

	natural_weapon = /obj/item/natural_weapon/claws/strong/eviscerator

	health = 300
	maxHealth = 300

	movement_cooldown = 3.5
	movement_sound = 'sound/simple_mob/abominable_infestation/eviscerator/step.ogg'

	meat_type = /obj/item/reagent_containers/food/snacks/abominationmeat
	meat_amount = 6
	skin_material = MATERIAL_SKIN_CHITIN
	skin_amount = 4
	bone_material = MATERIAL_BONE_CARTILAGE
	bone_amount = 4

	ai_holder_type = /datum/ai_holder/simple_animal/infestation/eviscerator
	//say_list_type = /datum/say_list/infestation_eviscerator
	death_sounds = list(
		'sound/simple_mob/abominable_infestation/eviscerator/death_1.ogg',
		'sound/simple_mob/abominable_infestation/eviscerator/death_2.ogg',
		)

/obj/item/natural_weapon/claws/strong/eviscerator
	armor_penetration = 10
	hitsound = 'sound/simple_mob/abominable_infestation/eviscerator/attack.ogg'

/datum/ai_holder/simple_animal/infestation/eviscerator
	returns_home = FALSE
	home_low_priority = TRUE
	speak_chance = 1
	wander = TRUE
	base_wander_delay = 5
	var/list/aggro_sounds = list(
		'sound/simple_mob/abominable_infestation/eviscerator/aggro_1.ogg',
		'sound/simple_mob/abominable_infestation/eviscerator/aggro_2.ogg',
		'sound/simple_mob/abominable_infestation/eviscerator/aggro_3.ogg',
		)

/datum/ai_holder/simple_animal/infestation/eviscerator/give_target(new_target, urgent = FALSE)
	. = ..()
	if(. && prob(30))
		playsound(holder, pick(aggro_sounds), rand(35,75), TRUE)

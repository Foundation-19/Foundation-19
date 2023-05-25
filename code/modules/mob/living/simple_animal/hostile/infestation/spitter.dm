/mob/living/simple_animal/hostile/infestation/spitter
	name = "spitter"
	desc = "A weird wriggling creature. Some sort of corrosive substance is dripping from its maw."
	icon_state = "spitter"
	icon_living = "spitter"
	icon_dead = "spitter_dead"
	mob_size = MOB_SMALL
	movement_cooldown = 3

	natural_weapon = /obj/item/natural_weapon/bite/abomination_spitter

	base_attack_cooldown = 1 SECONDS
	ranged_attack_cooldown = 3 SECONDS

	ranged = TRUE
	projectiletype = /obj/item/projectile/energy/acid_spit
	projectilesound = 'sound/weapons/alien_spit.ogg'
	fire_desc = "spits acid"

	health = 150
	maxHealth = 150

	meat_type = /obj/item/reagent_containers/food/snacks/abominationmeat
	meat_amount = 4
	skin_material = MATERIAL_SKIN_CHITIN
	skin_amount = 2
	bone_material = MATERIAL_BONE_CARTILAGE
	bone_amount = 2

	ai_holder_type = /datum/ai_holder/simple_animal/infestation/spitter
	say_list_type = /datum/say_list/infestation_spitter
	death_sounds = list('sound/simple_mob/abominable_infestation/spitter/death.ogg')

/obj/item/natural_weapon/bite/abomination_spitter
	hitsound = 'sound/simple_mob/abominable_infestation/spitter/attack.ogg'

/datum/say_list/infestation_spitter
	emote_hear = list("gurgles")
	emote_see = list("looks around", "wriggles around")

	emote_hear_sounds = list(
		'sound/simple_mob/abominable_infestation/spitter/ambient_1.ogg',
		'sound/simple_mob/abominable_infestation/spitter/ambient_2.ogg',
		)
	emote_see_sounds = list(
		'sound/simple_mob/abominable_infestation/spitter/ambient_1.ogg',
		'sound/simple_mob/abominable_infestation/spitter/ambient_2.ogg',
		)

/datum/ai_holder/simple_animal/infestation/spitter
	returns_home = FALSE
	home_low_priority = TRUE
	speak_chance = 2
	wander = TRUE
	base_wander_delay = 15

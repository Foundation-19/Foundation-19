/mob/living/simple_animal/hostile/infestation/broodling
	name = "broodling"
	desc = "An abominable creature, fast and vicious."
	icon_state = "broodling"
	icon_living = "broodling"
	icon_dead = "broodling_dead"
	mob_size = MOB_SMALL
	movement_cooldown = 2

	natural_weapon = /obj/item/natural_weapon/claws/broodling
	melee_attack_delay = 0

	health = 100
	maxHealth = 100

	meat_type = /obj/item/reagent_containers/food/snacks/abominationmeat
	meat_amount = 2
	skin_material = MATERIAL_SKIN_CHITIN
	skin_amount = 1
	bone_material = MATERIAL_BONE_CARTILAGE
	bone_amount = 1

	ai_holder_type = /datum/ai_holder/simple_animal/infestation/broodling
	say_list_type = /datum/say_list/infestation_broodling
	death_sounds = list('sound/simple_mob/abominable_infestation/broodling/death.ogg')

/obj/item/natural_weapon/claws/broodling
	force = 7
	armor_penetration = 10
	hitsound = 'sound/weapons/slashmiss.ogg'
	attack_cooldown = 2

/datum/say_list/infestation_broodling
	emote_hear = list("hisses", "attempts to bark", "breathes heavily", "gurgles")
	emote_see = list("jumps from place to place")

	emote_hear_sounds = list(
		'sound/simple_mob/abominable_infestation/broodling/ambient_1.ogg',
		'sound/simple_mob/abominable_infestation/broodling/ambient_2.ogg',
		)
	emote_see_sounds = list(
		'sound/simple_mob/abominable_infestation/broodling/ambient_1.ogg',
		'sound/simple_mob/abominable_infestation/broodling/ambient_2.ogg',
		)

/datum/ai_holder/simple_animal/infestation/broodling
	returns_home = FALSE
	home_low_priority = TRUE
	speak_chance = 3
	wander = TRUE
	base_wander_delay = 1

/datum/ai_holder/simple_animal/infestation/broodling/post_melee_attack(atom/A)
	if(holder.Adjacent(A))
		holder.IMove(get_step(holder, pick(GLOB.alldirs)))
		holder.face_atom(A)

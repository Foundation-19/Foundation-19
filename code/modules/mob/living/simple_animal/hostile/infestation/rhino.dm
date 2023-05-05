/mob/living/simple_animal/hostile/infestation/rhino
	name = "rhino"
	desc = "A large heavily-armored monster."
	icon = 'icons/mob/simple_animal/abominable_infestation/48x48.dmi'
	icon_state = "rhino"
	icon_living = "rhino"
	icon_dead = "rhino_dead"
	mob_size = MOB_MEDIUM
	default_pixel_x = -8
	pixel_x = -8

	natural_weapon = /obj/item/natural_weapon/hooves/rhino

	health = 1000
	maxHealth = 1000
	resistance = 15

	movement_cooldown = 5
	movement_sound = 'sound/simple_mob/abominable_infestation/rhino/step.ogg'
	movement_shake_radius = 3

	meat_type = /obj/item/reagent_containers/food/snacks/abominationmeat
	meat_amount = 6
	skin_material = MATERIAL_SKIN_CHITIN
	skin_amount = 8
	bone_material = MATERIAL_BONE_CARTILAGE
	bone_amount = 8

	ai_holder_type = /datum/ai_holder/simple_animal/infestation/rhino
	death_sounds = list('sound/simple_mob/abominable_infestation/rhino/death.ogg')

	/// Grants increased movement speed
	var/enraged = FALSE
	var/enraged_end_time
	var/enraged_cooldown
	var/enraged_cooldown_time = 20 SECONDS
	var/enraged_movement_sound = 'sound/simple_mob/abominable_infestation/rhino/step_angry.ogg'

/obj/item/natural_weapon/hooves/rhino
	force = 50
	armor_penetration = 10
	hitsound = 'sound/weapons/heavysmash.ogg'

/mob/living/simple_animal/hostile/infestation/rhino/Life()
	. = ..()
	if(!.)
		return
	if(enraged && world.time > enraged_end_time)
		enraged = FALSE
		visible_message(SPAN_WARNING("\The [src] calms down."))

/mob/living/simple_animal/hostile/infestation/rhino/movement_delay()
	. = ..()
	. -= enraged * 2

/mob/living/simple_animal/hostile/infestation/rhino/PlayMovementSound()
	if(enraged)
		playsound(src, enraged_movement_sound, 75, 1, 3)
		return
	return ..()

/datum/ai_holder/simple_animal/infestation/rhino
	returns_home = TRUE
	home_low_priority = TRUE
	wander = TRUE
	base_wander_delay = 10

/datum/ai_holder/simple_animal/infestation/rhino/give_target(new_target, urgent = FALSE)
	. = ..()
	var/mob/living/simple_animal/hostile/infestation/rhino/R = holder
	if(. && prob(25) && world.time > R.enraged_cooldown)
		R.enraged_cooldown = world.time + R.enraged_cooldown_time
		R.enraged_end_time = world.time + 10 SECONDS
		R.enraged = TRUE
		playsound(holder, 'sound/simple_mob/abominable_infestation/rhino/roar.ogg', 75, TRUE, 6)
		holder.visible_message(SPAN_DANGER("\The [holder] charges at [new_target]!"))

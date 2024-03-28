// Medium damage, Low health, Very high mobility.
// Ignores gravity and can "fly", temporarily turning non-dense
// When attacked, can change its pixel position slightly, making it more difficult to hit

/mob/living/simple_animal/hostile/infestation/floatfly
	name = "floatfly"
	desc = "A flesh creature resembling a big fly."
	icon_state = "fly"
	icon_living = "fly"
	icon_dead = "fly_dead"
	mob_size = MOB_SMALL
	movement_cooldown = 2.7

	natural_weapon = /obj/item/natural_weapon/claws/floatfly

	health = 80
	maxHealth = 80

	meat_type = /obj/item/reagent_containers/food/snacks/abominationmeat
	meat_amount = 3
	skin_material = MATERIAL_SKIN_CHITIN
	skin_amount = 1
	bone_material = MATERIAL_BONE_CARTILAGE
	bone_amount = 1

	ai_holder_type = /datum/ai_holder/simple_animal/infestation/floatfly
	say_list_type = /datum/say_list/infestation_floatfly
	death_sounds = list('sounds/simple_mob/abominable_infestation/floatfly/death.ogg')

	var/fly_cooldown
	var/fly_cooldown_time = 5 SECONDS
	var/fly_duration = 5 SECONDS

/obj/item/natural_weapon/claws/floatfly
	force = 14
	armor_penetration = 10
	hitsound = 'sounds/weapons/alien_claw_flesh1.ogg'

/datum/say_list/infestation_floatfly
	emote_hear = list("buzzes", "hisses")
	emote_see = list("flies all over the place")

	emote_hear_sounds = list()
	emote_see_sounds = list()

/mob/living/simple_animal/hostile/infestation/floatfly/death()
	animate(src, pixel_z = 0, time = 3)
	return ..()

/mob/living/simple_animal/hostile/infestation/floatfly/movement_delay()
	. = ..()
	// Faster while flying
	if(!density)
		. -= 0.5

/mob/living/simple_animal/hostile/infestation/floatfly/adjustBruteLoss(amount)
	. = ..()
	if(!stat && world.time > fly_cooldown && prob(amount * 5))
		animate(src, pixel_x = default_pixel_x + rand(-10, 10), pixel_y = default_pixel_y + rand(-10, 10), time = 2)

/mob/living/simple_animal/hostile/infestation/floatfly/Allow_Spacemove()
	return TRUE

/mob/living/simple_animal/hostile/infestation/floatfly/proc/StartFlight()
	if(!density || fly_cooldown >= world.time)
		return FALSE
	density = FALSE
	playsound(src, 'sounds/simple_mob/abominable_infestation/floatfly/fly.ogg', 75, TRUE, 6)
	visible_message(SPAN_DANGER("\The [src] flies upwards!"))
	animate(src, pixel_z = 16, time = 5)
	default_pixel_z = 16
	addtimer(CALLBACK(src, PROC_REF(EndFlight)), fly_duration)

/mob/living/simple_animal/hostile/infestation/floatfly/proc/EndFlight()
	if(QDELETED(src) || stat == DEAD)
		return FALSE
	fly_cooldown = world.time + fly_cooldown_time
	density = TRUE
	visible_message(SPAN_WARNING("\The [src] stops its flight."))
	animate(src, pixel_z = 0, time = 5)
	default_pixel_z = 0

/datum/ai_holder/simple_animal/infestation/floatfly
	returns_home = FALSE
	home_low_priority = TRUE
	speak_chance = 3
	wander = TRUE
	base_wander_delay = 1

/datum/ai_holder/simple_animal/infestation/floatfly/give_target(new_target, urgent = FALSE)
	. = ..()
	var/mob/living/simple_animal/hostile/infestation/floatfly/F = holder
	if(. && prob(25) && world.time > F.fly_cooldown)
		F.StartFlight()

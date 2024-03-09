// The tiny and fast annoying enemies spawned by aggregate.
// Their hilariously low health means they will most likely die in one tick of fire damage.
/mob/living/simple_animal/hostile/infestation/meatchip
	name = "meatchip"
	desc = "A tiny, digusting creature."
	icon_state = "meatchip"
	icon_living = "meatchip"
	icon_dead = "meatchip_dead"
	mob_size = MOB_TINY
	density = FALSE
	layer = LYING_MOB_LAYER
	movement_cooldown = 1.2

	natural_weapon = /obj/item/natural_weapon/claws/meatchip
	melee_attack_delay = 0

	health = 30
	maxHealth = 30

	meat_type = /obj/item/reagent_containers/food/snacks/abominationmeat
	meat_amount = 1
	skin_material = MATERIAL_SKIN_CHITIN
	skin_amount = 1
	bone_material = MATERIAL_BONE_CARTILAGE
	bone_amount = 1

	death_sounds = list('sounds/simple_mob/abominable_infestation/meatchip/death.ogg')

/obj/item/natural_weapon/claws/meatchip
	force = 5
	armor_penetration = 15
	hitsound = 'sounds/weapons/slashmiss.ogg'
	attack_cooldown = 1

/mob/living/simple_animal/hostile/infestation/meatchip/Initialize()
	. = ..()
	default_pixel_x = rand(-6, 6)
	default_pixel_y = rand(-6, 6)
	pixel_x = default_pixel_x
	pixel_y = default_pixel_y

/mob/living/simple_animal/hostile/infestation/meatchip/proc/TimedDeath()
	if(QDELETED(src) || stat == DEAD)
		return
	death()

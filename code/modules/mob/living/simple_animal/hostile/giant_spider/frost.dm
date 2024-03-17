// Frost spiders inject cryotoxin, slowing people down (which is very bad if trying to run from spiders).

/mob/living/simple_animal/hostile/giant_spider/frost
	desc = "Bright Orange and Red, it makes you shudder to look at it. This one has brilliant eyes full of power, and flashes with unstable potential..."

	icon_state = "pit"
	icon_living = "pit"
	icon_dead = "pit_dead"

	maxHealth = 175
	health = 175

	poison_per_bite = 5
	poison_type = /datum/reagent/random //Oopsies!

	natural_weapon = /obj/item/natural_weapon/bite/spider/frost

/obj/item/natural_weapon/bite/spider/frost
	force = 15

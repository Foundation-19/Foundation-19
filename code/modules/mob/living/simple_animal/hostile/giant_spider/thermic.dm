// Thermic spiders inject a special variant of thermite that burns someone from the inside.

/mob/living/simple_animal/hostile/giant_spider/thermic
	desc = "Mirage-cloaked and black, it makes you shudder to look at it. This one has simmering eyes promising pain..."

	icon_state = "black"
	icon_living = "black"
	icon_dead = "black_dead"

	maxHealth = 175
	health = 175

	heat_resist = 0.75
	cold_resist = -0.50

	poison_chance = 30
	poison_per_bite = 1
	poison_type = /datum/reagent/capsaicin/condensed //We do a little bit of pain damage

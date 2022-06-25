/mob/living/simple_animal/friendly/snek
	name = "snek"
	desc = "Cute snake that needs a little boop."
	icon_state = "snek"
	icon_living = "snek_dead"
	speak_emote = list("flicks")
	health = 20
	maxHealth = 20
	natural_weapon = /obj/item/natural_weapon/bite/weak
	response_help = "boops"
	response_disarm = "shoos"
	response_harm = "kicks"
	mob_size = MOB_SMALL
	possession_candidate = 1
	can_escape = TRUE
	pass_flags = PASS_FLAG_TABLE
	density = FALSE

	meat_amount = 1
	bone_amount = 1
	skin_amount = 1
	skin_material = MATERIAL_SKIN_LIZARD

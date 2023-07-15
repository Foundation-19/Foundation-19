/mob/living/simple_animal/hostile/retaliate/tegu
	name = "tegu"
	desc = "Thats a tegu."
	icon_state = "tegu"
	icon_living = "tegu"
	icon_dead ="tegu_dead"
	speak_emote = list("hisses")
	turns_per_move = 5
	response_help = "pets the"
	response_disarm = "rolls over the"
	response_harm = "kicks the"
	a_intent = I_HURT
	natural_weapon = /obj/item/natural_weapon/bite/medium
	health = 80
	maxHealth = 80
	movement_cooldown = 4
	pry_time = 7 SECONDS
	pry_desc = "biting"
	ai_holder_type = /datum/ai_holder/simple_animal/retaliate

/mob/living/simple_animal/hostile/retaliate/tegu/atlas
	name = "Atlas"
	desc = "That's the captain's small, but mighty pet tegu. They may or may not have the blood of several crewmembers on them."
	gender = MALE
	ai_holder_type = /datum/ai_holder/simple_animal/retaliate/guard

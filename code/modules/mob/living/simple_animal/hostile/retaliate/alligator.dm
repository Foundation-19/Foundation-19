/mob/living/simple_animal/hostile/retaliate/gator
	name = "alligator"
	desc = "Thats an alligator. Probably shouldn't wrestle it."
	icon_state = "gator"
	icon_living = "gator"
	icon_dead ="gator_dead"
	turns_per_move = 5
	speak_emote = list("hisses", "snaps")
	response_help = "pets the"
	response_disarm = "rolls over the"
	response_harm = "kicks the"
	a_intent = I_HURT
	health = 125
	maxHealth = 125
	speed = 5
	glide_size = 2
	natural_weapon = /obj/item/natural_weapon/bite/medium
	pry_time = 6 SECONDS
	pry_desc = "biting"
	ai_holder_type = /datum/ai_holder/simple_animal/retaliate

/mob/living/simple_animal/hostile/retaliate/gator/steppy
	name = "Steppy"
	desc = "Cargo's pet gator. Is he being detained!?"
	gender = MALE
	ai_holder_type = /datum/ai_holder/simple_animal/retaliate/guard

/mob/living/simple_animal/hostile/retaliate/gator/steppy/cool
	name = "Cool Steppy"
	desc = "Cargo's pet gator. Looks like nobody can detain him now."
	speak_emote = list("snaps menacingly")
	icon_state = "gator_cool"
	icon_living = "gator_cool"
	health = 150
	maxHealth = 150

/mob/living/simple_animal/hostile/retaliate/gator/steppy/cool/death(gibbed, deathmessage, show_dead_message)
	..(gibbed, deathmessage, show_dead_message)
	new /obj/item/clothing/glasses/sunglasses/sechud(src)

/mob/living/simple_animal/hostile/retaliate/gator/steppy/Initialize(mapload)
	. = ..()
	var/turf/T = get_turf(src)
	if(prob(5))
		new /mob/living/simple_animal/hostile/retaliate/gator/steppy/cool(T)
		return INITIALIZE_HINT_QDEL

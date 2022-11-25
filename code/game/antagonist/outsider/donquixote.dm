GLOBAL_DATUM_INIT(quixotes, /datum/antagonist/donquixote, new)

/datum/antagonist/donquixote
	id = MODE_DONQUIXOTE
	landmark_id = "don quixote"
	role_text = "Don Quixote"
	role_text_plural = "Don Quixote"
	welcome_text = "You are Don Quixote, gallant knight. Bring justice to those who deserve it."
	flags = ANTAG_RANDOM_EXCEPTED | ANTAG_PATAPHYSICS

	hard_cap = 1
	hard_cap_round = 1
	initial_spawn_req = 1
	initial_spawn_target = 1

/datum/antagonist/donquixote/equip(var/mob/living/carbon/human/player)
	player.add_language(LANGUAGE_ENGLISH)
	player.equip_to_slot_or_del(new /obj/item/clothing/under/bluetunic(player), slot_w_uniform)
	player.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots/medievalboots(player), slot_shoes)
	player.equip_to_slot_or_del(new /obj/item/clothing/suit/champarmor(player), slot_wear_suit)
	player.equip_to_slot_or_del(new /obj/item/material/sword(player), slot_belt)

/datum/antagonist/donquixote/update_antag_mob(var/datum/mind/player)
	..()
	var/datum/preferences/A = new() //Randomize appearance for the commando.
	A.randomize_appearance_and_body_for(player.current)

	player.name = "Don Quixote"
	player.current.real_name = player.name
	player.current.SetName(player.current.name)

	var/mob/living/carbon/human/H = player.current
	if(istype(H))
		H.gender = MALE
		H.age = rand(25,45)
		H.dna.ready_dna(H)


GLOBAL_DATUM_INIT(murphys, /datum/antagonist/murphylaw, new)

/datum/antagonist/murphylaw
	id = MODE_MURPHYLAW
	landmark_id = "murphy law"
	role_text = "Murphy Law"
	role_text_plural = "Murphy Law"
	welcome_text = "You are Murphy Law, Private Investigator. Solve crime and bring justice to those who deserve it. Act like a film noir detective."
	id_type = /obj/item/card/id/murphylaw
	flags = ANTAG_RANDOM_EXCEPTED | ANTAG_PATAPHYSICS

	hard_cap = 1
	hard_cap_round = 1
	initial_spawn_req = 1
	initial_spawn_target = 1

/datum/antagonist/murphylaw/equip(var/mob/living/carbon/human/player)
	player.add_language(LANGUAGE_ENGLISH)
	player.equip_to_slot_or_del(new /obj/item/clothing/under/det(player), slot_w_uniform)
	player.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(player), slot_shoes)
	player.equip_to_slot_or_del(new /obj/item/clothing/head/det(player), slot_head)
	player.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/det_trench(player), slot_wear_suit)
	player.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses(player), slot_glasses)
	player.equip_to_slot_or_del(new /obj/item/storage/briefcase/crimekit, slot_in_backpack)
	player.equip_to_slot_or_del(new /obj/item/storage/backpack, slot_back)
	player.equip_to_slot_or_del(new /obj/item/storage/belt/holster/security/fullmateba(player), slot_belt)

	create_id("Private Investigator", player)

/datum/antagonist/murphylaw/update_antag_mob(var/datum/mind/player)
	..()
	var/datum/preferences/A = new() //Randomize appearance for the commando.
	A.randomize_appearance_and_body_for(player.current)

	player.name = "Murphy Law"
	player.current.real_name = player.name
	player.current.SetName(player.current.name)

	var/mob/living/carbon/human/H = player.current
	if(istype(H))
		H.gender = MALE
		H.age = rand(25,45)
		H.dna.ready_dna(H)


GLOBAL_DATUM_INIT(operatives, /datum/antagonist/sharkpunchingcentre, new)

/datum/antagonist/sharkpunchingcentre
	id = MODE_SHARKPUNCHINGCENTRE
	landmark_id = "centre operative"
	role_text = "Shark Punching Centre Operative"
	role_text_plural = "Shark Punching Centre Operatives"
	welcome_text = "You are a Shark Punching Centre Operative, puncher of sharks. Go fucking punch some sharks."
	flags = ANTAG_RANDOM_EXCEPTED | ANTAG_PATAPHYSICS

	hard_cap = 1
	hard_cap_round = 1
	initial_spawn_req = 1
	initial_spawn_target = 1

/datum/antagonist/sharkpunchingcentre/equip(var/mob/living/carbon/human/player)
	player.add_language(LANGUAGE_ENGLISH)
	player.equip_to_slot_or_del(new /obj/item/device/radio/headset/ert(player), slot_l_ear)
	player.equip_to_slot_or_del(new /obj/item/clothing/under/ert(player), slot_w_uniform)
	player.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(player), slot_shoes)
	player.equip_to_slot_or_del(new /obj/item/clothing/gloves/boxing(player), slot_gloves)
	player.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/scp/eta(player), slot_head)
	player.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/scp/medarmor/eta(player), slot_wear_suit)


/datum/antagonist/sharkpunchingcentre/update_antag_mob(var/datum/mind/player)

	..()
	var/datum/preferences/A = new() //Randomize appearance for the commando.
	A.randomize_appearance_and_body_for(player.current)

	player.name = "PUGILIST-FIVE"
	player.current.real_name = player.name
	player.current.SetName(player.current.name)

	var/mob/living/carbon/human/H = player.current
	if(istype(H))
		H.gender = MALE
		H.age = rand(25,45)
		H.dna.ready_dna(H)

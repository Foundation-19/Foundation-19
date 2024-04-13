/obj/item/clothing/suit/armor/vest/scp/medarmor/MTFlight
	name = "Tactical light vest"
	desc = "A light tactical vest used by the MTF."
	icon = 'mod_celadon/objects/icons/obj/clothing/obj_suit.dmi'
	item_icons = list(
		slot_wear_suit_str = 'mod_celadon/objects/icons/mob/onmob/onmob_suit.dmi',
		slot_l_hand_str = 'mod_celadon/objects/icons/mob/onmob/lefthand.dmi',	// Поменяй это, пожалуйста.
		slot_r_hand_str = 'mod_celadon/objects/icons/mob/onmob/righthand.dmi')	// Поменяй это, пожалуйста.
	icon_state = "policevest"
	body_parts_covered = UPPER_TORSO | LOWER_TORSO | LEGS | ARMS
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | ARMS
	armor = list(melee = 80, bullet = 85, laser = 65, energy = 15, bomb = 80, bio = 40, rad = 60)
	acid_resistance = 1.5

/obj/item/clothing/suit/armor/vest/scp/medarmor/MTFmedium
	name = "Tactical medium vest"
	desc = "A medium tactical vest used by the MTF."
	icon = 'mod_celadon/objects/icons/obj/clothing/obj_suit.dmi'
	item_icons = list(slot_wear_suit_str = 'mod_celadon/objects/icons/mob/onmob/onmob_suit.dmi',
		slot_l_hand_str = 'mod_celadon/objects/icons/mob/onmob/lefthand.dmi',	// Поменяй это, пожалуйста.
		slot_r_hand_str = 'mod_celadon/objects/icons/mob/onmob/righthand.dmi')	// Поменяй это, пожалуйста.
	icon_state = "mediumvest"
	body_parts_covered = UPPER_TORSO | LOWER_TORSO | LEGS | ARMS
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | ARMS
	armor = list(melee = 85, bullet = 90, laser = 65, energy = 15, bomb = 80, bio = 40, rad = 60)
	acid_resistance = 1.5

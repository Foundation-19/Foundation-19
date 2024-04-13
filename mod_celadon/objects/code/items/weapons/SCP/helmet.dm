/obj/item/clothing/head/helmet/scp/lwh_helmet
	name = "Tactical Helmet"
	desc = "An ordinary tactical helmet."
	item_icons = list(slot_head_str = 'mod_celadon/objects/icons/mob/onmob/onmob_head.dmi',
		slot_l_hand_str = 'mod_celadon/objects/icons/mob/onmob/lefthand_hats.dmi',	// Поменяй это, пожалуйста.
		slot_r_hand_str = 'mod_celadon/objects/icons/mob/onmob/righthand_hats.dmi')	// Поменяй это, пожалуйста.
	icon = 'mod_celadon/objects/icons/obj/clothing/obj_head.dmi'
	icon_state = "lwh_black"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|BLOCKHAIR
	body_parts_covered = HEAD|EYES
	cold_protection = HEAD|EYES
	permeability_coefficient = 0.5
	armor = list(melee = 80, bullet = 83, laser = 50,energy = 25, bomb = 50, bio = 100, rad = 60)
	acid_resistance = 1.5

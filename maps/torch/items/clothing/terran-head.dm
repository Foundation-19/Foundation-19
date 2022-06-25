/obj/item/clothing/head/terran
	name = "master TerraGov hat"
	icon = 'maps/torch/icons/obj/obj_head_terran.dmi'
	item_icons = list(slot_head_str = 'maps/torch/icons/mob/onmob_head_terran.dmi')
	siemens_coefficient = 0.9

/obj/item/clothing/head/terran/navy/service
	name = "TerraGov service cover"
	desc = "A service uniform cover, worn by low-ranking crew within the Terran Navy."
	icon_state = "terranservice"
	item_state = "terranservice"
	item_state_slots = list(
		slot_l_hand_str = "helmet",
		slot_r_hand_str = "helmet")
	body_parts_covered = 0

/obj/item/clothing/head/terran/navy/service/command
	name = "TerraGov command service cover"
	desc = "A service uniform cover, worn by high-ranking crew within the Terran Navy."
	icon_state = "terranservice_comm"
	item_state = "terranservice_comm"

/obj/item/clothing/head/terran/beret
	name = "Red TerraGov Beret"
	desc = "A red Terran Navy Beret. It bears the crest of the TerraGov on the front."
	icon_state = "terranberet-red"
	item_state = "terranberet-red"
	item_state_slots = list(
		slot_l_hand_str = "helmet",
		slot_r_hand_str = "helmet")
	body_parts_covered = 0


/obj/item/clothing/head/terran/beret/grey
	name = "Grey TerraGov Beret"
	desc = "A grey Terran Navy Beret. It bears the crest of the TerraGov on the front."
	icon_state = "terranberet-grey"
	item_state = "terranberet-grey"

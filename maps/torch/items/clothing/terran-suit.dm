/obj/item/clothing/suit/storage/terran
	name = "master TerraGov jacket"
	icon = 'maps/torch/icons/obj/obj_suit_terran.dmi'
	item_icons = list(slot_wear_suit_str = 'maps/torch/icons/mob/onmob_suit_terran.dmi')

//Service

/obj/item/clothing/suit/storage/terran/service/navy
	name = "TerraGov coat"
	desc = "A Terran Navy service coat. Black and undecorated."
	icon_state = "terranservice"

/obj/item/clothing/suit/storage/terran/service/navy/command
	name = "indie command coat"
	desc = "An Terran Navy service command coat. White and undecorated."
	icon_state = "terranservice_comm"

//dress

/obj/item/clothing/suit/dress/terran
	name = "dress jacket"
	desc = "A uniform dress jacket, fancy."
	icon_state = "terrandress"
	icon = 'maps/torch/icons/obj/obj_suit_terran.dmi'
	item_icons = list(slot_wear_suit_str = 'maps/torch/icons/mob/onmob_suit_terran.dmi')
	body_parts_covered = UPPER_TORSO|ARMS
	siemens_coefficient = 0.9
	allowed = list(/obj/item/tank/emergency,/obj/item/device/flashlight,/obj/item/clothing/head/soft,/obj/item/clothing/head/beret,/obj/item/device/radio,/obj/item/pen)
	valid_accessory_slots = list(ACCESSORY_SLOT_MEDAL,ACCESSORY_SLOT_RANK)

/obj/item/clothing/suit/dress/terran/navy
	name = "TerraGov dress cloak"
	desc = "A black Terran Navy dress cloak with red detailing. So sexy it hurts."
	icon_state = "terrandress"

/obj/item/clothing/suit/dress/terran/navy/officer
	name = "TerraGov officer's dress cloak"
	desc = "A black Terran Navy dress cloak with gold detailing. Smells like ceremony."
	icon_state = "terrandress_off"

/obj/item/clothing/suit/dress/terran/navy/command
	name = "TerraGov command dress cloak"
	desc = "A black Terran Navy dress cloak with royal detailing. Smells like ceremony."
	icon_state = "terrandress_comm"

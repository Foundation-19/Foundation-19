/obj/item/clothing/head/bio_hazmat
	icon_state = "hazmat_yellow_head"
	name = "hazmat helmet"
	item_state_slots = list(
		slot_l_hand_str = "bio_hood",
		slot_r_hand_str = "bio_hood",
		)
	desc = "A yellow colored heavy-duty hazmat helmet. Usually comes with a suit."
	permeability_coefficient = 0
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 100, rad = 100)
	flags_inv = HIDEEARS|BLOCKHAIR
	body_parts_covered = HEAD|FACE|EYES
	item_flags = ITEM_FLAG_THICKMATERIAL | ITEM_FLAG_PHORONGUARD

/obj/item/clothing/suit/bio_hazmat
	icon_state = "hazmat_yellow"
	item_state = "hazmat_yellow"
	name = "hazmat suit"
	item_state_slots = list(
		slot_l_hand_str = "bio_suit",
		slot_r_hand_str = "bio_suit",
	)
	w_class = ITEM_SIZE_HUGE//bulky item
	desc = "A yellow colored heavy-duty hazmat suit. It has a small Foundation logo on the front."
	gas_transfer_coefficient = 0
	permeability_coefficient = 0
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS
	flags_inv = HIDEJUMPSUIT|HIDEEARS|BLOCKHAIR
	item_flags = ITEM_FLAG_THICKMATERIAL | ITEM_FLAG_PHORONGUARD
	allowed = list(/obj/item/weapon/tank/emergency,/obj/item/weapon/pen,/obj/item/device/flashlight/pen,/obj/item/device/healthanalyzer,/obj/item/device/ano_scanner,/obj/item/clothing/head/bio_hood,/obj/item/clothing/mask/gas)
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 100, rad = 100)

/obj/item/clothing/suit/bio_hazmat/New()
	..()
	slowdown_per_slot[slot_wear_suit] = 1.0


/obj/item/clothing/suit/bio_hazmat/white
	icon_state = "hazmat_white"
	item_state = "hazmat_white"
	desc = "A white colored heavy-duty hazmat suit. It has a small Foundation logo on the front."

/obj/item/clothing/head/bio_hazmat/white
	icon_state = "hazmat_white_head"
	desc = "A white colored heavy-duty hazmat helmet. Usually comes with a suit."

/obj/item/clothing/suit/bio_hazmat/cmo
	icon_state = "hazmat_cmo"
	item_state = "hazmat_cmo"
	desc = "A blue colored heavy-duty hazmat suit. It has a small Foundation logo on the front."

/obj/item/clothing/head/bio_hazmat/cmo
	icon_state = "hazmat_cmo_head"
	desc = "A blue colored heavy-duty hazmat helmet. Usually comes with a suit."

/obj/item/clothing/suit/bio_hazmat/cyan
	icon_state = "hazmat_cyan"
	item_state = "hazmat_cyan"
	desc = "A cyan colored heavy-duty hazmat suit. It has a small Foundation logo on the front."

/obj/item/clothing/head/bio_hazmat/cyan
	icon_state = "hazmat_cyan_head"
	desc = "A cyan colored heavy-duty hazmat helmet. Usually comes with a suit."

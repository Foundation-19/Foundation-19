// SCP-1499

/obj/item/clothing/mask/gas/scp1499
	name = "SCP-1499"
	desc = "An old soviet gasmask."
	icon = 'icons/SCP/scp-1499.dmi'
	icon_state = "scp-1499"
	item_state = "scp-1499"
	siemens_coefficient = 0.7
	armor = list(
		melee = ARMOR_MELEE_SMALL,
		bullet = ARMOR_BALLISTIC_SMALL,
		laser = ARMOR_LASER_MINOR,
		bio = ARMOR_BIO_STRONG
		)
	hidden_from_codex = TRUE

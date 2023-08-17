/obj/item/clothing/mask/gas/scp1499
	name = "soviet gasmask"
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

/obj/item/clothing/mask/gas/scp1499/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"soviet gasmask", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SAFE, //Obj Class
		"1499", //Numerical Designation
		SCP_PLACEHOLDER
	)

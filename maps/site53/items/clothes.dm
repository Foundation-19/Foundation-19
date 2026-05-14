/obj/item/clothing/under/scp/lcz
	name = "LCZ Guard security uniform"
	desc = "A sterile white uniform. Currently issued to LCZ Guard personnel."
	icon_state = "white_lcz"
	item_flags = ITEM_FLAG_THICKMATERIAL

/obj/item/clothing/under/scp/lcz/armband
	starting_accessories = list(/obj/item/clothing/accessory/armband)

/obj/item/clothing/under/scp/lcz/sergeant
	name = "LCZ Officer security uniform"
	desc = "A sterile white uniform. Currently issued to the LCZ officer."
	icon_state = "white_sergeant_lcz"

/obj/item/clothing/under/scp/lcz/sergeant/armband
	starting_accessories = list(/obj/item/clothing/accessory/armband)

/obj/item/clothing/under/scp/hcz
	item_flags = ITEM_FLAG_THICKMATERIAL

/obj/item/clothing/under/scp/hcz/white
	name = "HCZ Guard security uniform"
	desc = "A sterile white uniform. Currently issued to HCZ Guard personnel."
	icon_state = "white_hcz"

/obj/item/clothing/under/scp/hcz/white/sergeant
	name = "HCZ Officer security uniform"
	desc = "A sterile white uniform. Currently issued to the HCZ officer."
	icon_state = "white_sergeant_hcz"

/obj/item/clothing/under/scp/hcz/dark
	name = "Security Tactical Jumpsuit"
	desc = "Issued to SD Rapid Response Teams and high security area guards."
	icon_state = "jumpsuit"
	item_state = "jumpsuit"
	worn_state = "jumpsuit"
	gender_icons = 1
	color = "#3d3d3d"

/obj/item/clothing/under/scp/hcz/dark/armband
	starting_accessories = list(/obj/item/clothing/accessory/armband)

/obj/item/clothing/gloves/tactical/scp
	desc = "These grey tactical gloves are made from a durable synthetic, and have hardened knuckles."
	name = "tactical gloves"
	icon_state = "scpgloves"
	item_state = "scpgloves"
	force = 5
	body_parts_covered = HANDS
	siemens_coefficient = 0.50
	permeability_coefficient = 0.05
	armor = list(melee = ARMOR_MELEE_MAJOR, bullet = ARMOR_BALLISTIC_MID, laser = ARMOR_LASER_SMALL_MID, energy = ARMOR_ENERGY_SMALL, bomb = ARMOR_BOMB_PADDED, bio = ARMOR_BIO_MINOR, rad = 0)

/obj/item/clothing/gloves/tactical/alpha
	desc = "These grey tactical gloves are made from a durable synthetic, and have hardened knuckles."
	name = "tactical gloves"
	icon_state = "alpha-gloves"
	item_state = "alpha-gloves"
	force = 5
	body_parts_covered = HANDS
	siemens_coefficient = 0.50
	permeability_coefficient = 0.05
	armor = list(melee = ARMOR_MELEE_VERY_VERY_HIGH, bullet = ARMOR_BALLISTIC_RIFLE, laser = ARMOR_MELEE_SMALL_HIGH, energy = ARMOR_ENERGY_RESISTANT, bomb = ARMOR_BOMB_RESISTANT, bio = ARMOR_BIO_MINOR, rad = 0)

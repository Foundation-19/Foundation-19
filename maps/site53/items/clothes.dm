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
	armor = list(melee = 50, bullet = 40, laser = 30, energy = 25, bomb = 30, bio = 10, rad = 0)

/obj/item/clothing/gloves/tactical/alpha
	desc = "These grey tactical gloves are made from a durable synthetic, and have hardened knuckles."
	name = "tactical gloves"
	icon_state = "alpha-gloves"
	item_state = "alpha-gloves"
	force = 5
	body_parts_covered = HANDS
	siemens_coefficient = 0.50
	permeability_coefficient = 0.05
	armor = list(melee = 80, bullet = 80, laser = 60, energy = 30, bomb = 50, bio = 10, rad = 0)
/obj/item/clothing/suit/armor/vest/scp/medarmorchaos
	name = "armored vest"
	desc = "A synthetic armor vest."
	icon_state = "chaos-armor"
	body_parts_covered = UPPER_TORSO | LOWER_TORSO | LEGS | ARMS
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | ARMS
	armor = list(melee = 40, bullet = 85, laser = 40, energy = 25, bomb = 30, bio = 15, rad = 10)

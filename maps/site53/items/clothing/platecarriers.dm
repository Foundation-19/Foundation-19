//MTF
/obj/item/clothing/accessory/armorplate/medium
	name = "medium armor plate"
	desc = "A plasteel-reinforced synthetic armor plate, providing good protection. Attaches to a plate carrier."
	icon_state = "armor_medium"
	armor = list(melee = ARMOR_MELEE_VVRESISTANT, bullet = ARMOR_BALLISTIC_PISTOL, laser = ARMOR_LASER_HANDGUNS, energy = ARMOR_ENERGY_SMALL, bomb = ARMOR_BOMB_PADDED, bio = 0, rad = 0)

/obj/item/clothing/head/helmet/mtfheavy //BULLDOZER IN THE HOUSE
	name = "combined heavy assault helmet"
	desc = "A quad-layered heavy composite helmet with titanium strut supports made solely so it doesn't crush one's heavy with the weight."
	icon_state = "mtf-heavy-helmet"
	armor = list(melee = ARMOR_MELEE_SHIELDED, bullet = ARMOR_BALLISTIC_HEAVY, laser = ARMOR_LASER_HEAVY, energy = ARMOR_ENERGY_SHIELDED, bomb = ARMOR_BOMB_SHIELDED, bio = ARMOR_BIO_SHIELDED, rad = ARMOR_RAD_SHIELDED)
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELMET_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = FIRE_HELMET_MAX_HEAT_PROTECTION_TEMPERATURE
	max_pressure_protection = FIRESUIT_MAX_PRESSURE
	item_flags = ITEM_FLAG_THICKMATERIAL|ITEM_FLAG_PHORONGUARD|ITEM_FLAG_AIRTIGHT
	item_flags = ITEM_FLAG_THICKMATERIAL|ITEM_FLAG_AIRTIGHT
	body_parts_covered = HEAD|FACE|EYES
	siemens_coefficient = 0.5
	permeability_coefficient = 0

/obj/item/clothing/head/helmet/scp/security/mtftactical
	name = "tactical helmet"
	desc = "An armored helmet usually worn by Mobile Task Forces, dawned with SCP logos, and insignia."
	icon_state = "mtf-tactical-helmet"
	body_parts_covered = HEAD|EYES
	armor = list(melee = ARMOR_MELEE_SMALL_HIGH, bullet = ARMOR_BALLISTIC_RIFLE, laser = ARMOR_LASER_MAJOR, energy = ARMOR_ENERGY_MINOR, bomb = ARMOR_BOMB_RESISTANT, bio = ARMOR_BIO_SMALL, rad = ARMOR_RAD_MINOR)
	acid_resistance = 1.5
	cold_protection = HEAD
	flags_inv = HIDEEARS|BLOCKHAIR
	action_button_name = "Toggle Visor"

/obj/item/clothing/head/helmet/mtftactical
	name = "tactical helmet"
	desc = "An armored helmet usually worn by Mobile Task Forces, dawned with SCP logos, and insignia."
	icon_state = "mtf-bland-helmet"
	armor = list(melee = ARMOR_MELEE_MAJOR, bullet = ARMOR_BALLISTIC_VRESISTANT, laser = ARMOR_LASER_RIFLES, energy = ARMOR_ENERGY_SMALL, bomb = ARMOR_BOMB_RESISTANT, bio = ARMOR_BIO_SMALL, rad = ARMOR_RAD_MINOR)
	cold_protection = HEAD
	flags_inv = HIDEEARS|BLOCKHAIR
	body_parts_covered = HEAD

/obj/item/clothing/suit/armor/mtfheavy //YOU'RE UP AGAINST THE WALL AND *I AM THE FUCKING WALL*
	name = "combined heavy assault suit"
	desc = "A multi-layered composite armor suit with ballistic weave underpadding and a kevlar undersuit, fitted with it's own cooling unit and exoskeleton supports. 'Nu-7' is emblazoned on the collar, and 'Hammer Down' is sewed into the back of it."
	icon_state = "mtf-heavy"
	item_state = "mtf-heavy"
	permeability_coefficient = 0
	gas_transfer_coefficient = 0
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE
	max_pressure_protection = FIRESUIT_MAX_PRESSURE
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	cold_protection = HEAD
	item_flags = ITEM_FLAG_THICKMATERIAL|ITEM_FLAG_PHORONGUARD|ITEM_FLAG_AIRTIGHT
	armor = list(melee = ARMOR_MELEE_SHIELDED, bullet = ARMOR_BALLISTIC_HEAVY, laser = ARMOR_LASER_HEAVY, energy = ARMOR_ENERGY_SHIELDED, bomb = ARMOR_BOMB_SHIELDED, bio = ARMOR_BIO_SHIELDED, rad = ARMOR_RAD_SHIELDED)

/obj/item/clothing/suit/armor/mtftactical
	name = "tactical vest"
	desc = "An advanced multi-plated composite vest with kevlar lining and plenty of room to move. 'E-11' is sewn into the left pauldron, and 'Nine Tailed Fox' is sewn into the right."
	icon_state = "mtf-tactical"
	item_state = "mtf-tactical"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	armor = list(melee = ARMOR_MELEE_SMALL_HIGH, bullet = ARMOR_BALLISTIC_RIFLE, laser = ARMOR_LASER_RIFLES, energy = ARMOR_ENERGY_MINOR, bomb = ARMOR_BOMB_RESISTANT, bio = ARMOR_BIO_SMALL, rad = ARMOR_RAD_MINOR)

/obj/item/clothing/suit/armor/mtfmedic
	name = "tactical medical vest"
	desc = "An advanced multi-plated composite vest with lessened kevlar lining than other models, and still plenty of room to move. 'E-11' is sewn into the left pauldron, and 'Nine Tailed Fox' is sewn into the right, which is white in color and dawned with the red cross of medics."
	icon_state = "mtf-medic"
	item_state = "mtf-medic"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	armor = list(melee = ARMOR_MELEE_MAJOR, bullet = ARMOR_BALLISTIC_VRESISTANT, laser = ARMOR_LASER_RIFLES, energy = ARMOR_ENERGY_SMALL, bomb = ARMOR_BOMB_RESISTANT, bio = ARMOR_BIO_SMALL, rad = ARMOR_RAD_MINOR)

/obj/item/clothing/suit/armor/mtfmedium
	name = "heavy tactical vest"
	desc = "An extremely advanced multi-plated composite vest with kevlar lining, added additional plating, and more body coverage and plenty of room to move. 'E-11' is sewn into the left pauldron, and 'Nine Tailed Fox' is sewn into the right."
	icon_state = "mtf-medium"
	item_state = "mtf-medium"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS|HANDS
	armor = list(melee = ARMOR_MELEE_VERY_HIGH, bullet = ARMOR_BALLISTIC_RIFLE, laser = ARMOR_LASER_RIFLES, energy = ARMOR_ENERGY_MINOR, bomb = ARMOR_BOMB_RESISTANT, bio = ARMOR_BIO_SMALL, rad = ARMOR_RAD_MINOR)

/obj/item/clothing/suit/armor/mtfscout
	name = "compact scout vest"
	desc = "An advanced multi-plated composite vest with lessened kevlar lining than other models, and still plenty of room to move. Compact, and easy to move in."
	icon_state = "mtf-scout"
	item_state = "mtf-scout"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	armor = list(melee = ARMOR_MELEE_VVRESISTANT, bullet = ARMOR_BALLISTIC_PISTOL, laser = ARMOR_LASER_HANDGUNS_PLUS, energy = ARMOR_ENERGY_MINOR, bomb = ARMOR_BOMB_PADDED, bio = ARMOR_BIO_MINOR, rad = ARMOR_RAD_MINOR)

/obj/item/clothing/suit/armor/mtfalpha1
	name = "'Red Right Hand' heavy compact vest"
	desc = "An extremely advanced multi-plated composite vest with extremely toughened kevlar lining, added additional plating, and more body coverage and plenty of room to move. 'A-1' is sewn onto the torso in red."
	icon_state = "mtf-alpha1"
	item_state = "mtf-alpha1"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	armor = list(melee = ARMOR_MELEE_VERY_VERY_HIGH, bullet = ARMOR_BALLISTIC_AP, laser = ARMOR_LASER_RIFLES, energy = ARMOR_ENERGY_SMALL, bomb = ARMOR_BOMB_RESISTANT, bio = ARMOR_BIO_SMALL, rad = ARMOR_RAD_MINOR)

/obj/item/clothing/suit/armor/mtfomega1
	name = "'Laws Left Hand' heavy compact vest"
	desc = "An extremely advanced multi-plated composite vest with extremely toughened kevlar lining, added additional plating, and more body coverage and plenty of room to move. 'O-1' is sewn onto the torso in white."
	icon_state = "mtf-omega1"
	item_state = "mtf-omega1"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	armor = list(melee = ARMOR_MELEE_VERY_VERY_HIGH, bullet = ARMOR_BALLISTIC_AP, laser = ARMOR_LASER_RIFLES, energy = ARMOR_ENERGY_SMALL, bomb = ARMOR_BOMB_RESISTANT, bio = ARMOR_BIO_SMALL, rad = ARMOR_RAD_MINOR)

//GOC
/obj/item/clothing/suit/armor/goc
	name = "Global Occult Coalition armored vest"
	desc = "A black standard issue lightweight armored vest, denoting the initials of the United Nations, but of course they're the Global Occult Coalition."
	icon_state = "goc_vest"
	item_state = "goc_vest"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	armor = list(melee = ARMOR_MELEE_VVRESISTANT, bullet = ARMOR_BALLISTIC_PISTOLP, laser = ARMOR_LASER_HANDGUNS_PLUS, energy = ARMOR_ENERGY_MINOR, bomb = ARMOR_BOMB_PADDED)
	allowed = list(/obj/item/gun/energy,/obj/item/device/radio,/obj/item/reagent_containers/spray/pepper,/obj/item/gun/projectile,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/melee/baton,/obj/item/handcuffs,/obj/item/gun/magnetic,/obj/item/clothing/head/helmet,/obj/item/device/flashlight, /obj/item/gun/launcher/grenade/thumper)

/obj/item/clothing/suit/armor/goc/heavy
	name = "Global Occult Coalition heavy-plating armored vest"
	desc = "A black heavily armored vest, denoting the initials of the United Nations, but of course they're the Global Occult Coalition."
	icon_state = "goc_heavy_vest"
	item_state = "goc_heavy_vest"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS
	armor = list(melee = ARMOR_MELEE_SHIELDED, bullet = ARMOR_BALLISTIC_HEAVY, laser = ARMOR_LASER_RIFLES, energy = ARMOR_ENERGY_MINOR, bomb = ARMOR_ENERGY_SHIELDED)

//MTF
/obj/item/clothing/accessory/armorplate/medium
	name = "medium armor plate"
	desc = "A plasteel-reinforced synthetic armor plate, providing good protection. Attaches to a plate carrier."
	icon_state = "armor_medium"
	armor = list(melee = 40, bullet = 50, laser = 40, energy = 25, bomb = 30, bio = 0, rad = 0)

/obj/item/clothing/head/helmet/mtfheavy //BULLDOZER IN THE HOUSE
	name = "combined heavy assault helmet"
	desc = "A quad-layered heavy composite helmet with titanium strut supports made solely so it doesn't crush one's heavy with the weight."
	icon_state = "mtf-heavy-helmet"
	armor = list(melee = 100, bullet = 100, laser = 100, energy = 100, bomb = 100, bio = 100, rad = 100)
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
	armor = list(melee = 60, bullet = 80, laser = 65, energy = 15, bomb = 60, bio = 20, rad = 15)
	acid_resistance = 1.5
	cold_protection = HEAD
	flags_inv = HIDEEARS|BLOCKHAIR
	action_button_name = "Toggle Visor"

/obj/item/clothing/head/helmet/mtftactical
	name = "tactical helmet"
	desc = "An armored helmet usually worn by Mobile Task Forces, dawned with SCP logos, and insignia."
	icon_state = "mtf-bland-helmet"
	armor = list(melee = 50, bullet = 75, laser = 70, energy = 25, bomb = 50, bio = 35, rad = 15)
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
	armor = list(melee = 100, bullet = 100, laser = 100, energy = 100, bomb = 100, bio = 100, rad = 100)

/obj/item/clothing/suit/armor/mtftactical
	name = "tactical vest"
	desc = "An advanced multi-plated composite vest with kevlar lining and plenty of room to move. 'E-11' is sewn into the left pauldron, and 'Nine Tailed Fox' is sewn into the right."
	icon_state = "mtf-tactical"
	item_state = "mtf-tactical"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	armor = list(melee = 60, bullet = 80, laser = 65, energy = 15, bomb = 60, bio = 20, rad = 15)

/obj/item/clothing/suit/armor/mtfmedic
	name = "tactical medical vest"
	desc = "An advanced multi-plated composite vest with lessened kevlar lining than other models, and still plenty of room to move. 'E-11' is sewn into the left pauldron, and 'Nine Tailed Fox' is sewn into the right, which is white in color and dawned with the red cross of medics."
	icon_state = "mtf-medic"
	item_state = "mtf-medic"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	armor = list(melee = 55, bullet = 75, laser = 70, energy = 25, bomb = 50, bio = 35, rad = 15)

/obj/item/clothing/suit/armor/mtfmedium
	name = "heavy tactical vest"
	desc = "An extremely advanced multi-plated composite vest with kevlar lining, added additional plating, and more body coverage and plenty of room to move. 'E-11' is sewn into the left pauldron, and 'Nine Tailed Fox' is sewn into the right."
	icon_state = "mtf-medium"
	item_state = "mtf-medium"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS|HANDS
	armor = list(melee = 70, bullet = 85, laser = 75, energy = 15, bomb = 70, bio = 25, rad = 15)

/obj/item/clothing/suit/armor/mtfscout
	name = "compact scout vest"
	desc = "An advanced multi-plated composite vest with lessened kevlar lining than other models, and still plenty of room to move. Compact, and easy to move in."
	icon_state = "mtf-scout"
	item_state = "mtf-scout"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	armor = list(melee = 45, bullet = 55, laser = 45, energy = 15, bomb = 45, bio = 15, rad = 15)

/obj/item/clothing/suit/armor/mtfalpha1
	name = "'Red Right Hand' heavy compact vest"
	desc = "An extremely advanced multi-plated composite vest with extremely toughened kevlar lining, added additional plating, and more body coverage and plenty of room to move. 'A-1' is sewn onto the torso in red."
	icon_state = "mtf-alpha1"
	item_state = "mtf-alpha1"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	armor = list(melee = 80, bullet = 95, laser = 80, energy = 25, bomb = 70, bio = 25, rad = 15)

/obj/item/clothing/suit/armor/mtfomega1
	name = "'Laws Left Hand' heavy compact vest"
	desc = "An extremely advanced multi-plated composite vest with extremely toughened kevlar lining, added additional plating, and more body coverage and plenty of room to move. 'O-1' is sewn onto the torso in white."
	icon_state = "mtf-omega1"
	item_state = "mtf-omega1"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	armor = list(melee = 80, bullet = 95, laser = 80, energy = 25, bomb = 70, bio = 25, rad = 15)

//GOC
/obj/item/clothing/suit/armor/goc
	name = "Global Occult Coalition armored vest"
	desc = "A black standard issue lightweight armored vest, denoting the initials of the United Nations, but of course they're the Global Occult Coalition."
	icon_state = "goc_vest"
	item_state = "goc_vest"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	armor = list(melee = 90, bullet = 90, laser = 65, energy = 15, bomb = 80)
	allowed = list(/obj/item/gun/energy,/obj/item/device/radio,/obj/item/reagent_containers/spray/pepper,/obj/item/gun/projectile,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/melee/baton,/obj/item/handcuffs,/obj/item/gun/magnetic,/obj/item/clothing/head/helmet,/obj/item/device/flashlight, /obj/item/gun/launcher/grenade/thumper)

/obj/item/clothing/suit/armor/goc/heavy
	name = "Global Occult Coalition heavy-plating armored vest"
	desc = "A black heavily armored vest, denoting the initials of the United Nations, but of course they're the Global Occult Coalition."
	icon_state = "goc_heavy_vest"
	item_state = "goc_heavy_vest"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS
	armor = list(melee = 95, bullet = 95, laser = 65, energy = 15, bomb = 90)

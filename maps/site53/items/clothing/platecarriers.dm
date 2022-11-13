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

/obj/item/clothing/head/helmet/mtftactical
	name = "tactical composite helmet"
	desc = "An armored composite helmet with night vision goggles attached."
	icon_state = "mtf-tactical-helmetON"
	permeability_coefficient = 0
	gas_transfer_coefficient = 0
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE
	max_pressure_protection = FIRESUIT_MAX_PRESSURE
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	item_flags = ITEM_FLAG_THICKMATERIAL|ITEM_FLAG_PHORONGUARD|ITEM_FLAG_AIRTIGHT
	armor = list(melee = 80, bullet = 83, laser = 50,energy = 25, bomb = 50, bio = 100, rad = 60)
	cold_protection = HEAD
	item_flags = ITEM_FLAG_THICKMATERIAL|ITEM_FLAG_AIRTIGHT
	body_parts_covered = HEAD|FACE|EYES

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
	name = "tactical armor suit"
	desc = "An advanced multi-plated composite vest with kevlar lining and plenty of room to move. 'E-11' is sewn into the left pauldron, and 'Nine Tailed Fox' is sewn into the right."
	icon_state = "mtf-tactical"
	item_state = "mtf-tactical"
	permeability_coefficient = 0
	gas_transfer_coefficient = 0
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE
	max_pressure_protection = FIRESUIT_MAX_PRESSURE
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	item_flags = ITEM_FLAG_THICKMATERIAL|ITEM_FLAG_PHORONGUARD|ITEM_FLAG_AIRTIGHT
	armor = list(melee = 80, bullet = 85, laser = 65, energy = 15, bomb = 80, bio = 40, rad = 60)

//GOC
/obj/item/clothing/suit/armor/goc
	name = "GOC armored vest"
	desc = "A standard issue lightweight armored vest given to soldiers of the GOC."
	icon_state = "goc-vest"
	item_state = "goc-vest"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	armor = list(melee = 90, bullet = 90, laser = 65, energy = 15, bomb = 80)

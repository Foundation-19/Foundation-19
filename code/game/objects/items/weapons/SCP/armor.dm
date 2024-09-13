/obj/item/clothing/suit/armor/pcarrier/scp/medium
	starting_accessories = list(/obj/item/clothing/accessory/armorplate/medium, /obj/item/clothing/accessory/storage/pouches, /obj/item/clothing/accessory/armor/tag/scp)

/obj/item/clothing/suit/armor/pcarrier/scp/tactical
	starting_accessories = list(/obj/item/clothing/accessory/armorplate/tactical, /obj/item/clothing/accessory/storage/pouches, /obj/item/clothing/accessory/armor/tag/scp, /obj/item/clothing/accessory/armguards, /obj/item/clothing/accessory/legguards)

/obj/item/clothing/suit/armor/pcarrier/green/scp/mtf_epsilon
	starting_accessories = list(/obj/item/clothing/accessory/armorplate/tactical/mtf, /obj/item/clothing/accessory/storage/pouches, /obj/item/clothing/accessory/armor/tag/scp, /obj/item/clothing/accessory/armguards, /obj/item/clothing/accessory/legguards, /obj/item/clothing/accessory/storage/pouches/green)

/obj/item/clothing/suit/armor/vest/scp
	w_class = ITEM_SIZE_HUGE
	valid_accessory_slots = list(ACCESSORY_SLOT_INSIGNIA, ACCESSORY_SLOT_ARMOR_M)

/obj/item/clothing/suit/armor/vest/scp/lightarmor
	name = "light armored vest"
	desc = "A light synthetic armor vest."
	icon_state = "guard-armor"
	w_class = ITEM_SIZE_NORMAL
	body_parts_covered = UPPER_TORSO | LOWER_TORSO | LEGS | ARMS
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | ARMS
	armor = list(melee = ARMOR_MELEE_MID, bullet = ARMOR_BALLISTIC_SMALL, laser = ARMOR_LASER_SMALL_MID, energy = ARMOR_ENERGY_RESISTANT, bomb = ARMOR_BOMB_PADDED, bio = ARMOR_BIO_MINOR, rad = ARMOR_RAD_MINOR)
	acid_resistance = 1.3

/obj/item/clothing/suit/armor/vest/scp/medarmor
	name = "foundation security vest"
	desc = "A heavy armored vest. Worn by facility security, it has some durathread plating in it to make it durable against melee, sadly not much else though."
	icon_state = "guard-armor"
	body_parts_covered = UPPER_TORSO | LOWER_TORSO
	cold_protection = UPPER_TORSO | LOWER_TORSO
	armor = list(melee = ARMOR_MELEE_SMALL_HIGH, bullet = ARMOR_BALLISTIC_SMALL_MID, laser = ARMOR_LASER_MID, energy = ARMOR_ENERGY_SMALL, bomb = ARMOR_BOMB_PADDED, bio = ARMOR_BIO_MINOR, rad = ARMOR_RAD_MINOR)
	acid_resistance = 1.5

/obj/item/clothing/suit/armor/vest/scp/medarmor/ruined
	name = "ruined foundation security vest"
	desc = "A heavy, wrecked armored vest. Worn by facility security, it has some durathread plating in it to make it durable against melee, which of itself has degraded due to age. Not to mention the two massive holes in the vest, whoever wore this definitely isn't alive anymore."
	icon_state = "forgotten-guard-armor"
	body_parts_covered = UPPER_TORSO | LOWER_TORSO
	cold_protection = UPPER_TORSO | LOWER_TORSO
	armor = list(melee = ARMOR_MELEE_RESISTANT, bullet = ARMOR_BALLISTIC_VVSMALL, laser = ARMOR_LASER_VERY_SMALL, energy = ARMOR_ENERGY_MINOR, bomb = ARMOR_BOMB_MINOR, bio = 0, rad = ARMOR_RAD_MINOR)
	acid_resistance = 1.5

/obj/item/clothing/suit/armor/vest/scp/medarmor/medic
	name = "foundation security medical vest"
	desc = "A light armored vest, with a medical pauldron. Worn by facility security in the Combat Medic division. This one's armor padding has been lessened to cope with faster response."
	icon_state = "combatmedic"
	body_parts_covered = UPPER_TORSO | LOWER_TORSO | ARMS
	cold_protection = UPPER_TORSO | LOWER_TORSO | ARMS
	armor = list(melee = ARMOR_MELEE_VRESISTANT, bullet = ARMOR_BALLISTIC_MID, laser = ARMOR_LASER_HANDGUNS, energy = ARMOR_ENERGY_RESISTANT, bomb = ARMOR_BOMB_MINOR, bio = ARMOR_BIO_RESISTANT, rad = ARMOR_RAD_RESISTANT)
	acid_resistance = 1.5

/obj/item/clothing/suit/armor/vest/scp/medarmor/recontain
	name = "foundation security response vest"
	desc = "A heavy armored vest, with added kneepads. It has a Recontainment Unit insignia on the chest. Worn by facility security in the Riot Control Unit division. Universally defensive."
	icon_state = "reconguard"
	body_parts_covered = UPPER_TORSO | LOWER_TORSO | LEGS
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS
	armor = list(melee = ARMOR_MELEE_VRESISTANT, bullet = ARMOR_BALLISTIC_PISTOL, laser = ARMOR_LASER_HANDGUNS_PLUS, energy = ARMOR_ENERGY_SMALL, bomb = ARMOR_BOMB_PADDED, bio = ARMOR_BIO_MINOR, rad = ARMOR_RAD_MINOR)
	acid_resistance = 1.5

/obj/item/clothing/suit/armor/vest/scp/medarmor/riot
	name = "foundation security riot vest"
	desc = "A heavy armored vest, with added arm armor, and kneepads for full body coverage. Worn by facility security in the Riot Control Unit division, it has some durathread plating in it to make it durable against melee, sadly not much else though. It looks extremely durable from impacts, but in return is fragile towards bullets."
	icon_state = "riotguard"
	body_parts_covered = UPPER_TORSO | LOWER_TORSO | ARMS | LEGS
	cold_protection = UPPER_TORSO | LOWER_TORSO | ARMS | LEGS
	armor = list(melee = ARMOR_MELEE_VERY_HIGH, bullet = ARMOR_BALLISTIC_VVSMALL, laser = ARMOR_LASER_SMALL, energy = ARMOR_ENERGY_SMALL, bomb = ARMOR_BOMB_RESISTANT, bio = ARMOR_BIO_MINOR, rad = ARMOR_RAD_MINOR)
	acid_resistance = 1.5

/obj/item/clothing/suit/armor/vest/scp/medarmor/cadet
	name = "foundation security trainee rig"
	desc = "A lightly armored rig. Worn by facility security in training, it's nimble plating, and defensive properties make it faster to manuever in than a normal ol' vest."
	icon_state = "cadetarmor"
	body_parts_covered = UPPER_TORSO | LOWER_TORSO
	cold_protection = UPPER_TORSO | LOWER_TORSO
	armor = list(melee = ARMOR_MELEE_VRESISTANT, bullet = ARMOR_BALLISTIC_VERY_SMALL, laser = ARMOR_LASER_VERY_SMALL, energy = ARMOR_ENERGY_MINOR, bomb = ARMOR_BOMB_MINOR, bio = ARMOR_BIO_MINOR, rad = ARMOR_RAD_MINOR)
	acid_resistance = 1.5
	flags_inv = 0

/obj/item/clothing/suit/armor/vest/scp/isd
	name = "Internal Security trenchcoat"
	desc = "A durable coat used by the Internal Security Department, there isn't much to note about it except for the golden SCP logo on the shoulder, and wrist designs."
	icon_state = "isd_trenchcoat"
	body_parts_covered = UPPER_TORSO | LOWER_TORSO | ARMS
	cold_protection = UPPER_TORSO | LOWER_TORSO | ARMS
	armor = list(melee = ARMOR_MELEE_VVRESISTANT, bullet = ARMOR_BALLISTIC_PISTOLP, laser = ARMOR_LASER_SMALL_MID, energy = ARMOR_ENERGY_SMALL, bomb = ARMOR_BOMB_PADDED, bio = ARMOR_BIO_MINOR, rad = ARMOR_RAD_MINOR)
	acid_resistance = 1.5

/obj/item/clothing/suit/armor/vest/scp/lczcomm
	name = "heavy-plated foundation security armored vest"
	desc = "A heavy armored vest, with added arm armor, and kneepads for full body coverage. Worn by the facility's LCZ Lieutenant, it has some durathread plating in it to make it durable against melee, and slightly in some other damage types."
	icon_state = "heavy-guard-armor"
	body_parts_covered = UPPER_TORSO | LOWER_TORSO | LEGS | ARMS
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | ARMS
	armor = list(melee = ARMOR_MELEE_HIGH, bullet = ARMOR_BALLISTIC_MID_PLUS, laser = ARMOR_LASER_SMALL_MID, energy = ARMOR_ENERGY_RESISTANT, bomb = ARMOR_BOMB_PADDED, bio = ARMOR_BIO_MINOR, rad = ARMOR_RAD_MINOR)
	acid_resistance = 1.5

/obj/item/clothing/suit/armor/vest/scp/medarmor/chaos
	name = "Chaos Insurgency armored vest"
	desc = "A heavy tan russian type ballistic vest, mainly protecting against bullets, and not much else. It's usually used by russian military forces, but is used by the Chaos Insurgency."
	icon_state = "ci_vest"
	body_parts_covered = UPPER_TORSO | LOWER_TORSO | LEGS | ARMS
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | ARMS
	armor = list(melee = ARMOR_MELEE_VVRESISTANT, bullet = ARMOR_BALLISTIC_RESISTANT, laser = ARMOR_LASER_HANDGUNS, energy = ARMOR_ENERGY_SMALL, bomb = ARMOR_BOMB_PADDED, bio = ARMOR_BIO_MINOR, rad = ARMOR_RAD_MINOR)
	acid_resistance = 1.5

/obj/item/clothing/suit/armor/vest/scp/medarmor/chaos/pilot
	name = "Chaos Insurgency pilot vest"
	desc = "A light, agile-purposed vest with barely any plating, meant for pilots who need the manueverability, but also need protection. It's usually used by russian military forces, but is used by the Chaos Insurgency."
	icon_state = "ci_pilot_vest"
	body_parts_covered = UPPER_TORSO | LOWER_TORSO
	cold_protection = UPPER_TORSO | LOWER_TORSO
	armor = list(melee = ARMOR_MELEE_KNIVES, bullet = ARMOR_BALLISTIC_SMALL, laser = ARMOR_LASER_MINOR, energy = 0, bomb = 0, bio = 0, rad = ARMOR_RAD_MINOR)

/obj/item/clothing/suit/armor/vest/scp/medarmor/eta
	name = "armored vest"
	desc = "A synthetic armor vest designed for MTF unit Eta-10."
	icon_state = "eta-armor"
	body_parts_covered = UPPER_TORSO | LOWER_TORSO | LEGS | FEET | ARMS | HANDS
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | FEET | ARMS | HANDS
	armor = list(melee = ARMOR_MELEE_VERY_HIGH, bullet = ARMOR_BALLISTIC_VRESISTANT, laser = ARMOR_LASER_RIFLES, energy = ARMOR_ENERGY_STRONG, bomb = ARMOR_BOMB_PADDED, bio = ARMOR_BIO_MINOR, rad = ARMOR_RAD_MINOR)
	acid_resistance = 1.5

/obj/item/clothing/suit/armor/vest/scp/medarmor/beta
	name = "armored suit"
	desc = "A synthetic armor vest designed for MTF unit Beta-7. Provides heavy protection against biologic and radioactive threats."
	icon_state = "beta-armor"
	body_parts_covered = UPPER_TORSO | LOWER_TORSO | LEGS | FEET | ARMS | HANDS
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | FEET | ARMS | HANDS
	permeability_coefficient = 0.5
	armor = list(melee = ARMOR_MELEE_VERY_VERY_HIGH, bullet = ARMOR_BALLISTIC_RIFLE, laser = ARMOR_LASER_HANDGUNS, energy = ARMOR_ENERGY_SMALL, bomb = ARMOR_BOMB_PADDED, bio = ARMOR_BIO_SHIELDED, rad = ARMOR_RAD_SHIELDED)
	acid_resistance = 5

/obj/item/clothing/head/hcz_hazmat
	name = "combat hazmat helmet"
	icon_state = "hcz-hazard-helmet"
	item_state = "hcz-hazard-helmet"
	desc = "A helmet that protects the head and face from biological comtaminants, heavy acids, high temperatures, and bullets."
	permeability_coefficient = 0
	armor = list(
		melee = ARMOR_MELEE_RESISTANT,
		bullet = ARMOR_BALLISTIC_PISTOL,
		laser = ARMOR_LASER_HANDGUNS,
		energy = ARMOR_ENERGY_RESISTANT,
		bomb = ARMOR_BOMB_RESISTANT,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_SHIELDED
		)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|BLOCKHAIR
	min_cold_protection_temperature = SPACE_HELMET_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = FIRE_HELMET_MAX_HEAT_PROTECTION_TEMPERATURE
	max_pressure_protection = FIRESUIT_MAX_PRESSURE
	item_flags = ITEM_FLAG_THICKMATERIAL|ITEM_FLAG_PHORONGUARD|ITEM_FLAG_AIRTIGHT
	body_parts_covered = HEAD|FACE|EYES
	siemens_coefficient = 0.5
	acid_resistance = 6

/obj/item/clothing/suit/hcz_hazmat
	name = "combat hazmat suit"
	desc = "An armored suit that protects against biological contamination, heavy acids, and high temperatures."
	icon_state = "hcz-hazard"
	item_state = "hcz-hazard"
	w_class = ITEM_SIZE_HUGE
	gas_transfer_coefficient = 0
	permeability_coefficient = 0
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE
	max_pressure_protection = FIRESUIT_MAX_PRESSURE
	item_flags = ITEM_FLAG_THICKMATERIAL|ITEM_FLAG_PHORONGUARD|ITEM_FLAG_AIRTIGHT
	allowed = list(/obj/item/tank/emergency,/obj/item/gun/energy,/obj/item/device/radio,/obj/item/reagent_containers/spray/pepper,/obj/item/gun/projectile,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/melee/baton,/obj/item/handcuffs,/obj/item/gun/magnetic,/obj/item/clothing/head/helmet,/obj/item/device/flashlight,/obj/item/clothing/head/hcz_hazmat,/obj/item/clothing/mask/gas)
	armor = list(
		melee = ARMOR_MELEE_RESISTANT,
		bullet = ARMOR_BALLISTIC_PISTOL,
		laser = ARMOR_LASER_HANDGUNS,
		energy = ARMOR_ENERGY_RESISTANT,
		bomb = ARMOR_BOMB_RESISTANT,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_SHIELDED
		)
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETAIL
	siemens_coefficient = 0.5
	acid_resistance = 6

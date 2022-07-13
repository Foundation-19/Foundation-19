
/obj/item/clothing/suit/space/void/swat
	name = "\improper SWAT suit"
	desc = "A heavily armored suit that protects against moderate damage. Used in special operations."
	icon_state = "deathsquad"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS
	allowed = list(/obj/item/gun,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/melee/baton,/obj/item/handcuffs,/obj/item/tank)
	armor = list(
		melee = ARMOR_MELEE_RESISTANT,
		bullet = ARMOR_BALLISTIC_RESISTANT,
		laser = ARMOR_LASER_MAJOR,
		energy = ARMOR_ENERGY_MINOR,
		bomb = ARMOR_BOMB_PADDED,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_SMALL
		)
	flags_inv = HIDESHOES|HIDEJUMPSUIT
	siemens_coefficient = 0.6

/obj/item/clothing/suit/space/void/swat/Initialize()
	. = ..()
	slowdown_per_slot[slot_wear_suit] = 1

//Skrell space gear. Sleek like a wetsuit.
/obj/item/clothing/head/helmet/space/void/skrell
	name = "Skrellian helmet"
	desc = "Smoothly contoured and polished to a shine. Still looks like a fishbowl."
	armor = list(
		melee = ARMOR_MELEE_KNIVES,
		bullet = ARMOR_BALLISTIC_PISTOL,
		laser = ARMOR_LASER_MAJOR,
		energy = ARMOR_ENERGY_STRONG,
		bomb = ARMOR_BOMB_RESISTANT,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_SHIELDED
		)
	max_heat_protection_temperature = SPACE_SUIT_MAX_HEAT_PROTECTION_TEMPERATURE
	species_restricted = list(SPECIES_SKRELL,SPECIES_HUMAN)

/obj/item/clothing/head/helmet/space/void/skrell/white
	icon_state = "skrell_helmet_white"

/obj/item/clothing/head/helmet/space/void/skrell/black
	icon_state = "skrell_helmet_black"

/obj/item/clothing/suit/space/void/skrell
	name = "Skrellian voidsuit"
	desc = "Seems like a wetsuit with reinforced plating seamlessly attached to it. Very chic."
	armor = list(
		melee = ARMOR_MELEE_KNIVES,
		bullet = ARMOR_BALLISTIC_PISTOL,
		laser = ARMOR_LASER_MAJOR,
		energy = ARMOR_ENERGY_STRONG,
		bomb = ARMOR_BOMB_RESISTANT,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_SHIELDED
		)
	allowed = list(/obj/item/device/flashlight,/obj/item/tank,/obj/item/storage/ore,/obj/item/device/t_scanner,/obj/item/pickaxe,/obj/item/rcd,/obj/item/rpd)
	heat_protection = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_HEAT_PROTECTION_TEMPERATURE
	species_restricted = list(SPECIES_SKRELL,SPECIES_HUMAN)

/obj/item/clothing/suit/space/void/skrell/white
	icon_state = "skrell_suit_white"

/obj/item/clothing/suit/space/void/skrell/black
	icon_state = "skrell_suit_black"

/obj/item/clothing/head/helmet/space/void/dohruk/
	name = "\improper Unathi helmet"
	desc = "A bulky helmet with padding to protect from the collisions wearing this can cause."
	species_restricted = list(SPECIES_UNATHI)
	armor = list(
		melee = ARMOR_MELEE_RESISTANT,
		bullet = ARMOR_BALLISTIC_MINOR,
		laser = ARMOR_LASER_MINOR,
		energy = ARMOR_ENERGY_MINOR,
		bomb = ARMOR_BOMB_PADDED,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_RESISTANT
		)
	icon_state = "rig0-dohruk"
	item_state = "dohruk_helm"

/obj/item/clothing/head/helmet/space/void/dohruk/heavy
	name = "heavy Unathi helmet"
	desc = "A thick helmet for the intellectual who needs to headbutt people safely."
	armor = list(
		melee = ARMOR_MELEE_MAJOR,
		bullet = ARMOR_BALLISTIC_SMALL,
		laser = ARMOR_LASER_SMALL,
		energy = ARMOR_ENERGY_SMALL,
		bomb = ARMOR_BOMB_RESISTANT,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_RESISTANT
		)
	siemens_coefficient = 0.3
	icon_state = "rig0-dohrukheavy"
	item_state = "dohruk_heavy_helm"
	max_pressure_protection = ENG_VOIDSUIT_MAX_PRESSURE

/obj/item/clothing/suit/space/void/dohruk/
	name = "\improper Unathi voidsuit"
	desc = "A dull voidsuit with thick but uneven padding. Perfect for those lacking other options."
	species_restricted = list(SPECIES_UNATHI)
	armor = list(
		melee = ARMOR_MELEE_RESISTANT,
		bullet = ARMOR_BALLISTIC_MINOR,
		laser = ARMOR_LASER_MINOR,
		energy = ARMOR_ENERGY_MINOR,
		bomb = ARMOR_BOMB_PADDED,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_RESISTANT
		)
	icon_state = "rig-dohruk"

/obj/item/clothing/suit/space/void/dohruk/heavy
	name = "heavy Unathi voidsuit"
	desc = "This suit tries to compensate for poor material quality with flashes of color and excessive padding."
	armor = list(
		melee = ARMOR_MELEE_MAJOR,
		bullet = ARMOR_BALLISTIC_SMALL,
		laser = ARMOR_LASER_SMALL,
		energy = ARMOR_ENERGY_SMALL,
		bomb = ARMOR_BOMB_RESISTANT,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_RESISTANT
		)
	siemens_coefficient = 0.3
	icon_state = "rig-dohrukheavy"
	max_pressure_protection = ENG_VOIDSUIT_MAX_PRESSURE

/obj/item/clothing/suit/space/void/dohruk/prepared
	helmet = /obj/item/clothing/head/helmet/space/void/dohruk
	boots = /obj/item/clothing/shoes/magboots
	tank = /obj/item/tank/oxygen

/obj/item/clothing/suit/space/void/dohruk/heavy/prepared
	helmet = /obj/item/clothing/head/helmet/space/void/dohruk/heavy
	boots = /obj/item/clothing/shoes/magboots
	tank = /obj/item/tank/oxygen

/obj/item/clothing/suit/space/void/dohruk/heavy/New()
	..()
	slowdown_per_slot[slot_wear_suit] = 2

// Cybersun
/obj/item/clothing/head/helmet/space/void/cybersun
	name = "cybersun voidsuit helmet"
	desc = "Prototype voidsuit helmet with experimental armor plates that protect against laser and energy weaponry very well, while giving limited protection against anything else."
	icon_state = "cybersun"
	item_state = "cybersun"
	armor = list(
		melee = ARMOR_MELEE_KNIVES,
		bullet = ARMOR_BALLISTIC_PISTOL,
		laser = ARMOR_LASER_RIFLES,
		energy =  ARMOR_ENERGY_STRONG,
		bomb = ARMOR_BOMB_PADDED,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_RESISTANT
		)
	siemens_coefficient = 0.3
	light_overlay = "helmet_light_dual"

/obj/item/clothing/suit/space/void/cybersun
	name = "cybersun voidsuit"
	desc = "Prototype voidsuit with experimental armor plates that protect from laser-based weapons very well, while giving limited protection against anything else."
	icon_state = "cybersun"
	item_state_slots = list(
		slot_l_hand_str = "syndie_voidsuit",
		slot_r_hand_str = "syndie_voidsuit",
	)
	w_class = ITEM_SIZE_LARGE
	armor = list(
		melee = ARMOR_MELEE_KNIVES,
		bullet = ARMOR_BALLISTIC_PISTOL,
		laser = ARMOR_LASER_RIFLES,
		energy =  ARMOR_ENERGY_STRONG,
		bomb = ARMOR_BOMB_PADDED,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_RESISTANT
		)
	allowed = list(/obj/item/device/flashlight,/obj/item/tank,/obj/item/device/suit_cooling_unit,/obj/item/gun,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/melee/baton,/obj/item/melee/energy/sword,/obj/item/handcuffs)
	siemens_coefficient = 0.3

/obj/item/clothing/suit/space/void/cybersun/New()
	..()
	slowdown_per_slot[slot_wear_suit] = 1

/obj/item/clothing/suit/space/void/cybersun/prepared
	helmet = /obj/item/clothing/head/helmet/space/void/cybersun
	tank = /obj/item/tank/oxygen

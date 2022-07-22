/obj/item/clothing/accessory/armorplate/get_fibers()
	return null	//plates do not shed

/obj/item/clothing/accessory/armorplate/medium
	name = "medium armor plate"
	desc = "A plasteel-reinforced synthetic armor plate, providing good protection. Attaches to a plate carrier."
	icon_state = "armor_medium"
	armor = list(melee = 40, bullet = 80, laser = 40, energy = 25, bomb = 30, bio = 0, rad = 0)

/obj/item/clothing/accessory/armor_tag/scp
	name = "\improper SCP tag"
	desc = "An armor tag with the word SCP printed in white lettering on it."
	icon_state = "presstag"

/obj/item/clothing/suit/armor/pcarrier/scp
	name = "plate carrier"

/obj/item/clothing/suit/armor/pcarrier/scp/medium
	starting_accessories = list(/obj/item/clothing/accessory/armorplate/tactical, /obj/item/clothing/accessory/storage/pouches, /obj/item/clothing/accessory/armor_tag/scp)

/obj/item/clothing/suit/armor/pcarrier/scp/tactical
	starting_accessories = list(/obj/item/clothing/accessory/armorplate/tactical, /obj/item/clothing/accessory/storage/pouches, /obj/item/clothing/accessory/armor_tag/scp, /obj/item/clothing/accessory/armguards, /obj/item/clothing/accessory/legguards)


/obj/item/clothing/suit/armor/pcarrier/green/scp/mtf_epsilon
	starting_accessories = list(/obj/item/clothing/accessory/storage/pouches/green)

/obj/item/clothing/suit/armor/vest/scp
	w_class = ITEM_SIZE_HUGE
	valid_accessory_slots = list(ACCESSORY_SLOT_INSIGNIA, ACCESSORY_SLOT_ARMOR_M)

/obj/item/clothing/suit/armor/vest/scp/lightarmor
	name = "Armored anti-stab vest"
	desc = "A synthetic armor vest, this one works well against cuts and bruises."
	icon_state = "guard-armor"
	w_class = ITEM_SIZE_NORMAL
	body_parts_covered = UPPER_TORSO | LOWER_TORSO | LEGS | ARMS
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | ARMS
	armor = list(melee = 70, bullet = 40, laser = 30, energy = 35, bomb = 35, bio = 15, rad = 10)

/obj/item/clothing/suit/armor/vest/scp/medarmor
	name = "Armored vest"
	desc = "A synthetic armor vest."
	icon_state = "guard-armor"
	body_parts_covered = UPPER_TORSO | LOWER_TORSO | LEGS | ARMS
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | ARMS
	armor = list(melee = 40, bullet = 60, laser = 40, energy = 25, bomb = 30, bio = 15, rad = 10)

/obj/item/clothing/suit/armor/vest/scp/russcom
	name = "Commander armor vest"
	desc = "A synthetic armor vest. This one is for Commander."
	icon_state = "heavy-guard-armor"
	body_parts_covered = UPPER_TORSO | LOWER_TORSO | LEGS | ARMS
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | ARMS
	armor = list(melee = 40, bullet = 70, laser = 40, energy = 40, bomb = 40, bio = 15, rad = 10)

/obj/item/clothing/suit/armor/vest/scp/lczcomm
	name = "Heavy-plated armor vest"
	desc = "A synthetic armor vest. This one is for Commander."
	icon_state = "donate_sec"
	body_parts_covered = UPPER_TORSO | LOWER_TORSO | LEGS | ARMS
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | ARMS
	armor = list(melee = 40, bullet = 90, laser = 40, energy = 40, bomb = 40, bio = 15, rad = 10)

/obj/item/clothing/suit/armor/vest/scp/commandervest
	name = "armored vest"
	desc = "A synthetic armor vest. This one is for Commander."
	icon_state = "don_sec"
	body_parts_covered = UPPER_TORSO | LOWER_TORSO
	cold_protection = UPPER_TORSO | LOWER_TORSO
	armor = list(melee = 40, bullet = 90, laser = 40, energy = 25, bomb = 30, bio = 15, rad = 10)

/obj/item/clothing/suit/armor/vest/scp/combatexo
	name = "Combat exosuit"
	desc = "Another Synthetic armor vest."
	icon_state = "donor_sec"
	body_parts_covered = UPPER_TORSO | LOWER_TORSO | LEGS | ARMS
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | ARMS
	armor = list(melee = 40, bullet = 80, laser = 40, energy = 25, bomb = 30, bio = 15, rad = 10)

/obj/item/clothing/suit/armor/vest/scp/medarmor/chaos
	name = "armored vest"
	desc = "A synthetic armor vest."
	icon_state = "chaos-armor"
	body_parts_covered = UPPER_TORSO | LOWER_TORSO | LEGS | ARMS
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | ARMS
	armor = list(melee = 40, bullet = 85, laser = 40, energy = 25, bomb = 30, bio = 15, rad = 10)

/obj/item/clothing/suit/armor/vest/scp/medarmor/eta
	name = "armored vest"
	desc = "A synthetic armor vest designed for MTF unit Eta-10."
	icon_state = "eta-armor"
	body_parts_covered = UPPER_TORSO | LOWER_TORSO | LEGS | FEET | ARMS | HANDS
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | FEET | ARMS | HANDS
	armor = list(melee = 70, bullet = 70, laser = 70, energy = 70, bomb = 30, bio = 15, rad = 10)

/obj/item/clothing/suit/armor/vest/scp/medarmor/beta
	name = "armored suit"
	desc = "A synthetic armor vest designed for MTF unit Beta-7."
	icon_state = "beta-armor"
	body_parts_covered = UPPER_TORSO | LOWER_TORSO | LEGS | FEET | ARMS | HANDS
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | FEET | ARMS | HANDS
	armor = list(melee = 90, bullet = 70, laser = 40, energy = 25, bomb = 30, bio = 90, rad = 90)

/obj/item/clothing/suit/armor/vest/scp/medarmor/alpha
	name = "armored vest"
	desc = "A synthetic armor vest designed for MTF unit Alpha-1."
	icon_state = "alpha-armor"
	body_parts_covered = UPPER_TORSO | LOWER_TORSO | LEGS
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS
	armor = list(melee = 100, bullet = 100, laser = 90, energy = 95, bomb = 90, bio = 90, rad = 0)

/obj/item/clothing/head/bio_hood/hcz
	name = "combat hazmat helmet"
	icon_state = "hcz-hazard-helmet"
	item_state = "hcz-hazard-helmet"
	desc = "A helmet that protects the head and face from biological comtaminants, high temperatures, and bullets."
	permeability_coefficient = 0
	armor = list(
		melee = 40,
		bullet = 60,
		laser = 40,
		energy = 25,
		bomb = ARMOR_BOMB_PADDED,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_SHIELDED
		)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|BLOCKHAIR
	min_cold_protection_temperature = SPACE_HELMET_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = FIRE_HELMET_MAX_HEAT_PROTECTION_TEMPERATURE
	max_pressure_protection = FIRESUIT_MAX_PRESSURE
	item_flags = ITEM_FLAG_THICKMATERIAL|ITEM_FLAG_PHORONGUARD|ITEM_FLAG_AIRTIGHT
	body_parts_covered = HEAD|FACE|EYES
	siemens_coefficient = 0.9

/obj/item/clothing/suit/bio_suit/hcz
	name = "combat hazmat suit"
	desc = "An armored suit that protects against biological contamination and high temperatures."
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
	allowed = list(/obj/item/tank/emergency,/obj/item/gun/energy,/obj/item/device/radio,/obj/item/reagent_containers/spray/pepper,/obj/item/gun/projectile,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/melee/baton,/obj/item/handcuffs,/obj/item/gun/magnetic,/obj/item/clothing/head/helmet,/obj/item/device/flashlight,/obj/item/clothing/head/bio_hood/hcz,/obj/item/clothing/mask/gas)
	armor = list(
		melee = 40,
		bullet = 60,
		laser = 40,
		energy = 25,
		bomb = ARMOR_BOMB_PADDED,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_SHIELDED
		)
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETAIL
	siemens_coefficient = 0.9
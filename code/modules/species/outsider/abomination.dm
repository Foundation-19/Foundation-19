// Human subspecies that were essentially produced(assimilated?) by the infestation.
// Very resistant to most damage sources except for burn.
// Very incomplete at the moment and not really used anywhere

/datum/species/human/abomination
	name = SPECIES_ABOMINATION
	name_plural = "Abominations"
	description = "A sub-product of bio-engineered species known as the \"Infestation\" or \"Abominations\". \
		Very dangerous and resistant to everything outside of burning things and high temperatures. \
		In the complex caste system of the Swarm, they are known to be among the highest-ranking leaders, \
		usually employed for more sophisticated tasks, such as infiltration and operating captured worlds."
	show_ssd = "hybernating"
	blood_color = COLOR_MAROON
	flesh_color = COLOR_MAROON

	speech_chance = 50
	speech_sounds = list(
		'sound/voice/abomination1.ogg',
		'sound/voice/abomination2.ogg',
		'sound/voice/abomination3.ogg',
		'sound/voice/abomination4.ogg',
		'sound/voice/abomination5.ogg',
		'sound/voice/abomination6.ogg',
		'sound/voice/abomination7.ogg',
		'sound/voice/abomination8.ogg',
	)

	unarmed_types = list(
		/datum/unarmed_attack/claws/strong/abomination,
		/datum/unarmed_attack/bite/sharp,
		)

	darksight_range = 7
	breath_pressure = 5
	max_pressure_diff = 500

	cold_level_1 = 60
	cold_level_2 = 30
	cold_level_3 = 0
	heat_level_1 = 330
	heat_level_2 = 360
	heat_level_3 = 600
	body_temperature = 290
	heat_discomfort_level = 305
	cold_discomfort_level = 75

	natural_armour_values = list(
		melee = ARMOR_MELEE_RESISTANT,
		bullet = ARMOR_BALLISTIC_PISTOL,
		laser = ARMOR_LASER_MAJOR,
		energy = ARMOR_ENERGY_RESISTANT,
		bomb = ARMOR_BOMB_PADDED,
		bio = ARMOR_BIO_SHIELDED,
		rad = ARMOR_RAD_SHIELDED
		)

	flash_mod = 0.5
	oxy_mod = 0.1
	toxins_mod = 0.2
	burn_mod = 2

	hunger_factor = DEFAULT_HUNGER_FACTOR * 20 // Very hungry
	thirst_factor = DEFAULT_THIRST_FACTOR
	taste_sensitivity = TASTE_DULL
	rarity_value = 10
	gluttonous = 2
	strength = STR_VHIGH
	sexybits_location = null
	vision_flags = SEE_SELF | SEE_MOBS

	has_organ = list(
		BP_HEART =    /obj/item/organ/internal/heart,
		BP_STOMACH =  /obj/item/organ/internal/stomach,
		BP_LUNGS =    /obj/item/organ/internal/lungs,
		BP_LIVER =    /obj/item/organ/internal/liver,
		BP_KIDNEYS =  /obj/item/organ/internal/kidneys,
		BP_BRAIN =    /obj/item/organ/internal/brain,
		BP_APPENDIX = /obj/item/organ/internal/appendix,
		BP_EYES =     /obj/item/organ/internal/eyes,
		BP_LARVA =    /obj/item/organ/internal/larva_producer
		)

	appearance_flags = HAS_HAIR_COLOR | HAS_SKIN_TONE_SPCR | HAS_LIPS | HAS_UNDERWEAR | HAS_EYE_COLOR
	species_flags = SPECIES_FLAG_NO_SCAN  | SPECIES_FLAG_NO_SLIP | SPECIES_FLAG_NO_MINOR_CUT
	spawn_flags = SPECIES_IS_RESTRICTED | SPECIES_NO_FBP_CONSTRUCTION | SPECIES_NO_FBP_CHARGEN

/datum/species/human/abomination/attempt_grab(mob/living/carbon/human/user, mob/living/target)
	return ..(user, target, GRAB_ABOMINATION)

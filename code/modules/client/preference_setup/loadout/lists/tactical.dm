/datum/gear/tactical/
	sort_category = "Tactical Equipment"
	category = /datum/gear/tactical/
	slot = slot_tie
	whitelist_department_flags = SEC

/datum/gear/tactical/armor_deco
	display_name = "armor customization"
	path = /obj/item/clothing/accessory/armor/tag
	flags = GEAR_HAS_SUBTYPE_SELECTION

//leaving this in, tho keep in mind many of them are not lore friendly due to baystation names and descriptions.
/datum/gear/tactical/helm_covers
	display_name = "helmet covers"
	path = /obj/item/clothing/accessory/armor/helmcover
	flags = GEAR_HAS_SUBTYPE_SELECTION


//Why not, tho colour customization would be too visible
/datum/gear/tactical/kneepads
	display_name = "kneepads"
	path = /obj/item/clothing/accessory/kneepads
//	flags = GEAR_HAS_COLOR_SELECTION

//fairly useless because they already spawn with an holster, but lets leave the option
/datum/gear/tactical/holster
	display_name = "holster selection"
	path = /obj/item/clothing/accessory/storage/holster
	cost = 3


//no harm done here, but useless without a machette
/datum/gear/tactical/sheath
	display_name = "machete sheath"
	path = /obj/item/clothing/accessory/storage/holster/machete


// Useless without a knife, but no harm done
/datum/gear/tactical/knife_sheath
	display_name = "knife sheath selection"
	description = "A leg strapped knife sheath."
	path = /obj/item/clothing/accessory/storage/holster/knife
	flags = GEAR_HAS_TYPE_SELECTION

//Guards already spawn with one, but no harm leaving this here
/datum/gear/tactical/balaclava
	display_name = "balaclava"
	path = /obj/item/clothing/mask/balaclava

//Combat knifes can be printed at a hacked autolathe with ease, high point penalty for spawning with one round start
/datum/gear/tactical/cknife
	display_name = "combat knife"
	path = /obj/item/material/knife/combat
	cost = 8

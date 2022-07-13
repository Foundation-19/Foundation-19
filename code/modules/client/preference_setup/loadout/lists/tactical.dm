/datum/gear/tactical/
	sort_category = "Tactical Equipment"
	category = /datum/gear/tactical/
	slot = slot_tie
	allowed_branches = list(/datum/mil_branch/security)

// Not allowed because: access to non lore-friendly tags at the moment (as well as ability to choose Zone Commander tags etc)
///datum/gear/tactical/armor_deco
	display_name = "armor customization"
	path = /obj/item/clothing/accessory/armor/tag
	flags = GEAR_HAS_SUBTYPE_SELECTION

//Some of the offered covers are non lore friendly. Also, kind of defeat the purpose of uniformization
/*/datum/gear/tactical/helm_covers
	display_name = "helmet covers"
	path = /obj/item/clothing/accessory/armor/helmcover
	flags = GEAR_HAS_SUBTYPE_SELECTION
*/

//Yes, why not
/datum/gear/tactical/kneepads
	display_name = "kneepads"
	path = /obj/item/clothing/accessory/kneepads
	flags = GEAR_HAS_COLOR_SELECTION

//Guard lockers already spawn with a thigh holster, and all of them spawn with a belt holster
/* /datum/gear/tactical/holster
	display_name = "holster selection"
	path = /obj/item/clothing/accessory/storage/holster
	cost = 3
*/

// Replaces belt slot, and useless
/*datum/gear/tactical/sheath
	display_name = "machete sheath"
	path = /obj/item/clothing/accessory/storage/holster/machete
*/

//Good option for guards
/datum/gear/tactical/knife_sheath
	display_name = "knife sheath selection"
	description = "A leg strapped knife sheath."
	path = /obj/item/clothing/accessory/storage/holster/knife
	flags = GEAR_HAS_TYPE_SELECTION

// No, not lore friendly and replaces basic uniform
/*/datum/gear/tactical/tacticool
	display_name = "tacticool turtleneck"
	path = /obj/item/clothing/under/syndicate/tacticool
	slot = slot_w_uniform
*/

//Guards already spawn with one, but no harm leaving this here
/datum/gear/tactical/balaclava
	display_name = "balaclava"
	path = /obj/item/clothing/mask/balaclava

/datum/gear/suit/lab_xyn_machine
	allowed_branches = CIVILIAN_BRANCHES

/datum/gear/gloves/dress/modified
	display_name = "modified gloves, dress"
	path = /obj/item/clothing/gloves/color/white/modified
	sort_category = "Xenowear"
	whitelisted = list(SPECIES_UNATHI)

/datum/gear/gloves/duty/modified
	display_name = "modified gloves, duty"
	path = /obj/item/clothing/gloves/thick/duty/modified
	sort_category = "Xenowear"
	whitelisted = list(SPECIES_UNATHI)

/datum/gear/suit/unathi/savage_hunter
	allowed_branches = CIVILIAN_BRANCHES

/datum/gear/head/skrell_helmet
	allowed_roles = ARMORED_ROLES

/datum/gear/uniform/harness
	allowed_branches = null

// Vox
/datum/gear/uniform/vox_robes
	display_name = "vox robes"
	path = /obj/item/clothing/under/vox/vox_robes
	sort_category = "Xenowear"
	whitelisted = list(SPECIES_VOX)
	allowed_branches = list(/datum/mil_branch/civilian, /datum/mil_branch/alien)

/datum/gear/uniform/vox_casual
	display_name = "vox casual clothes"
	path = /obj/item/clothing/under/vox/vox_casual
	sort_category = "Xenowear"
	whitelisted = list(SPECIES_VOX)
	allowed_branches = list(/datum/mil_branch/civilian, /datum/mil_branch/alien)

// Patches
/datum/gear/accessory/cultex_patch
	display_name = "Cultural Exchange patch"
	path = /obj/item/clothing/accessory/solgov/cultex_patch
	description = "A shoulder patch representing the Expeditionary Corps."
	allowed_branches = list(/datum/mil_branch/expeditionary_corps)
	whitelisted = list(SPECIES_SKRELL, SPECIES_UNATHI, SPECIES_YEOSA, SPECIES_IPC)
	sort_category = "Xenowear"
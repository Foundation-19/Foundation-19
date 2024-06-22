
/datum/gear/accessory
	sort_category = "Accessories"
	category = /datum/gear/accessory
	slot = slot_tie
	denied_roles = list(/datum/job/classd)

//guards don't wear ties
/datum/gear/accessory/tie
	display_name = "tie selection"
	path = /obj/item/clothing/accessory
	blacklist_department_flags = SEC


/datum/gear/accessory/tie/New()
	..()
	var/ties = list()
	ties["blue tie"] = /obj/item/clothing/accessory/blue
	ties["red tie"] = /obj/item/clothing/accessory/red
	ties["blue tie, clip"] = /obj/item/clothing/accessory/blue_clip
	ties["red long tie"] = /obj/item/clothing/accessory/red_long
	ties["black tie"] = /obj/item/clothing/accessory/black
	ties["yellow tie"] = /obj/item/clothing/accessory/yellow
	ties["navy tie"] = /obj/item/clothing/accessory/navy
	ties["horrible tie"] = /obj/item/clothing/accessory/horrible
	ties["brown tie"] = /obj/item/clothing/accessory/brown
	gear_tweaks += new/datum/gear_tweak/path(ties)

/datum/gear/accessory/tie_color
	display_name = "colored tie"
	path = /obj/item/clothing/accessory
	flags = GEAR_HAS_COLOR_SELECTION
	blacklist_department_flags = SEC

/datum/gear/accessory/tie_color/New()
	..()
	var/ties = list()
	ties["tie"] = /obj/item/clothing/accessory
	ties["striped tie"] = /obj/item/clothing/accessory/long
	gear_tweaks += new/datum/gear_tweak/path(ties)

/datum/gear/accessory/locket
	display_name = "locket"
	path = /obj/item/clothing/accessory/locket

/datum/gear/accessory/necklace
	display_name = "necklace, colour select"
	path = /obj/item/clothing/accessory/necklace
	flags = GEAR_HAS_COLOR_SELECTION

/datum/gear/accessory/bowtie
	display_name = "bowtie, horrible"
	path = /obj/item/clothing/accessory/bowtie/ugly
	blacklist_department_flags = SEC

/datum/gear/accessory/bowtie/color
	display_name = "bowtie, colour select"
	path = /obj/item/clothing/accessory/bowtie/color
	flags = GEAR_HAS_COLOR_SELECTION
	blacklist_department_flags = SEC

/datum/gear/accessory/armband_security
	display_name = "security armband"
	path = /obj/item/clothing/accessory/armband
	whitelist_department_flags = SEC

/datum/gear/accessory/armband_security/cargo
	display_name = "cargo armband"
	path = /obj/item/clothing/accessory/armband/cargo
	whitelist_department_flags = SEC | SUP

/datum/gear/accessory/armband_security/medical
	display_name = "medical armband"
	path = /obj/item/clothing/accessory/armband/med
	whitelist_department_flags = SEC | MED

/datum/gear/accessory/armband_security/emt
	display_name = "EMT armband"
	path = /obj/item/clothing/accessory/armband/medgreen
	whitelist_department_flags = SEC | MED

/datum/gear/accessory/armband_security/engineering
	display_name = "engineering armband"
	path = /obj/item/clothing/accessory/armband/engine
	whitelist_department_flags = SEC | ENG

/datum/gear/accessory/armband_security/hydro
	display_name = "hydroponics armband"
	path = /obj/item/clothing/accessory/armband/hydro
	whitelist_department_flags = SEC | SRV

/datum/gear/accessory/chaplaininsignia
	display_name = "chaplain insignia"
	path = /obj/item/clothing/accessory/chaplaininsignia
	cost = 1
	allowed_roles = list(/datum/job/chaplain)

/datum/gear/accessory/chaplaininsignia/New()
	..()
	var/insignia = list()
	insignia["chaplain insignia (christianity)"] = /obj/item/clothing/accessory/chaplaininsignia
	insignia["chaplain insignia (judaism)"] = /obj/item/clothing/accessory/chaplaininsignia/judaism
	insignia["chaplain insignia (islam)"] = /obj/item/clothing/accessory/chaplaininsignia/islam
	insignia["chaplain insignia (buddhism)"] = /obj/item/clothing/accessory/chaplaininsignia/buddhism
	insignia["chaplain insignia (hinduism)"] = /obj/item/clothing/accessory/chaplaininsignia/hinduism
	insignia["chaplain insignia (sikhism)"] = /obj/item/clothing/accessory/chaplaininsignia/sikhism
	insignia["chaplain insignia (baha'i faith)"] = /obj/item/clothing/accessory/chaplaininsignia/bahaifaith
	insignia["chaplain insignia (jainism)"] = /obj/item/clothing/accessory/chaplaininsignia/jainism
	insignia["chaplain insignia (taoism)"] = /obj/item/clothing/accessory/chaplaininsignia/taoism
	gear_tweaks += new/datum/gear_tweak/path(insignia)

/datum/gear/accessory/bracelet
	display_name = "bracelet, color select"
	path = /obj/item/clothing/accessory/bracelet
	cost = 1
	flags = GEAR_HAS_COLOR_SELECTION

/datum/gear/accessory/wristwatches
	display_name = "wrist watch selection"
	path = /obj/item/clothing/accessory/wristwatches
	cost = 1
	flags = GEAR_HAS_TYPE_SELECTION

/datum/gear/accessory/pronouns
	display_name = "pronoun badge selection"
	path = /obj/item/clothing/accessory/pronouns
	flags = GEAR_HAS_TYPE_SELECTION

/datum/gear/accessory/identitypins
	display_name = "identity pin selection"
	path = /obj/item/clothing/accessory/identitypins
	flags = GEAR_HAS_TYPE_SELECTION

/datum/gear/accessory/neckerchief
	display_name = "neckerchief, colour select"
	description = "A piece of cloth tied around the neck. A favorite of Sailors and Partisans everywhere."
	path = /obj/item/clothing/accessory/neckerchief
	flags = GEAR_HAS_COLOR_SELECTION

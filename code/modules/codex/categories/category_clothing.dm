/datum/codex_category/clothing
	name = "Clothing"
	desc = "Dress wear, protective suits, and military armor, among other things."
	var/list/armor_to_descriptive_term = list(
		"melee" = "blunt force",
		"bullet" = "ballistics",
		"laser" = "lasers",
		"energy" = "energy",
		"bomb" = "explosions",
		"bio" = "biohazards",
		"rad" = "radiation"
		)	// not the best way to do this, but whatever

/datum/codex_category/clothing/Initialize()
	for(var/thing in subtypesof(/obj/item/clothing))
		var/obj/item/clothing/clothing = thing
		if(initial(clothing.hidden_from_codex))
			continue
		var/datum/codex_entry/entry = new( \
		_display_name = "[initial(clothing.name)] (clothing)", \
		_associated_paths = list(clothing), \
		_lore_text = initial(clothing.desc), \
		_mechanics_text = "")

		var/list/traits = list()

		var/obj/item/clothing/temp_obj = new thing()	// this is the only way to get list vars. KILL ME NOW PLEASE
		var/list/armor = temp_obj.armor
		qdel(temp_obj)
		for(var/armor_type in armor_to_descriptive_term)
			if(LAZYACCESS(armor, armor_type))
				switch(armor[armor_type])
					if(1 to 20)
						traits += "It barely protects against [armor_to_descriptive_term[armor_type]]."
					if(21 to 30)
						traits += "It provides a very small defense against [armor_to_descriptive_term[armor_type]]."
					if(31 to 40)
						traits += "It offers a small amount of protection against [armor_to_descriptive_term[armor_type]]."
					if(41 to 50)
						traits += "It offers a moderate defense against [armor_to_descriptive_term[armor_type]]."
					if(51 to 60)
						traits += "It provides a strong defense against [armor_to_descriptive_term[armor_type]]."
					if(61 to 70)
						traits += "It is very strong against [armor_to_descriptive_term[armor_type]]."
					if(71 to 80)
						traits += "This gives a very robust defense against [armor_to_descriptive_term[armor_type]]."
					if(81 to 100)
						traits += "Wearing this would make you nigh-invulerable against [armor_to_descriptive_term[armor_type]]."

		if(initial(clothing.item_flags) & ITEM_FLAG_AIRTIGHT)
			traits += "It is airtight."

		if(initial(clothing.min_pressure_protection) == 0)
			traits += "Wearing this will protect you from a complete vacuum."
		else if(initial(clothing.min_pressure_protection) != null)
			traits += "Wearing this will protect you from low pressures, but not a complete vacuum."

		if(initial(clothing.max_pressure_protection) != null)
			traits += "It is rated for pressures up to [initial(clothing.max_pressure_protection)] kPa."

		if(initial(clothing.item_flags) & ITEM_FLAG_THICKMATERIAL)
			traits += "The material is exceptionally thick."

		if(initial(clothing.max_heat_protection_temperature) >= FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE)
			traits += "It offers hefty protection from impossibly high temperatures."
		else if(initial(clothing.max_heat_protection_temperature) >= SPACE_SUIT_MAX_HEAT_PROTECTION_TEMPERATURE)
			traits += "It provides good protection against fire and heat."

		if(!isnull(initial(clothing.min_cold_protection_temperature)) && initial(clothing.min_cold_protection_temperature) <= SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE)
			traits += "It provides very good protection against very cold temperatures."

		var/list/covers = list()
		var/list/slots = list()
		for(var/name in string_part_flags)
			if(initial(clothing.body_parts_covered) & string_part_flags[name])
				covers += name
		for(var/name in string_slot_flags)
			if(initial(clothing.slot_flags) & string_slot_flags[name])
				slots += name

		if(covers.len)
			traits += "It covers the [english_list(covers)]."
		if(slots.len)
			traits += "It can be worn on your [english_list(slots)]."

		traits += initial(clothing.codex_special_info)

		entry.mechanics_text += jointext(traits, "<br>")
		entry.update_links()
		SScodex.add_entry_by_string(entry.display_name, entry)
		items += entry.display_name

	..()

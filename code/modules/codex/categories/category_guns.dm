/datum/codex_category/guns
	name = "Guns"
	desc = "Paratechnology allows for a wide variety of guns and similar weapons."

/datum/codex_category/guns/Initialize()
	for(var/thing in subtypesof(/datum/codex_category/gun_cat))
		var/datum/codex_category/guns/category = thing
		items += "[initial(category.name)] (category)"

	..()

// since gun_cat has no items, it also doesn't generate an entry
/datum/codex_category/gun_cat/proc/generate_common_info(obj/gun)
	var/list/traits = list()

	var/obj/item/gun/gun_type = gun

	if(initial(gun_type.one_hand_penalty))
		traits += "It's best fired with a two-handed grip."

	if(initial(gun_type.has_safety))
		traits += "It has a safety switch. Control-Click it to toggle safety."

	// can't call object functions on paths, woop de fucking do.
	if(initial(length(gun_type.req_access)))
		traits += "It's fitted with a secure registration chip. Swipe an ID on it to register."

	if(initial(gun_type.scope_zoom))
		traits += "It has a magnifying optical scope. The scope can be toggled with Use Scope verb."

	if(LAZYLEN(initial(gun_type.firemodes)) > 1)
		traits += "It has multiple firemodes. Use it in hand to cycle between them."

	return traits

/datum/codex_category/gun_cat/projectile
	name = "Ballistic Weapons"
	desc = "Ballistic weapons are commonly used by civilians, mundane militaries, and paranormal organizations alike. \
			Even stranger organizations that possess suitable replacements commonly fall back on traditional weaponry \
			when the anomalous fails them. Usage of ballistic weaponry is discouraged in non-emergency situations, \
			as a missed shot or careless use of automatic fire could destroy fundamental infrastructure or injure bystanders with ease."

/datum/codex_category/gun_cat/projectile/Initialize()
	for(var/thing in subtypesof(/obj/item/gun/projectile))
		var/obj/item/gun/projectile/gun = thing
		var/datum/codex_entry/entry = new( \
			_display_name = "[initial(gun.name)] (gun)", \
			_associated_paths = list(gun), \
			_lore_text = "This weapon is a ballistic weapon; it fires solid shots using a magazine or loaded rounds of ammunition. You can \
			unload it by holding it and clicking it with an empty hand, and reload it by clicking it with a magazine, or in the case of \
			shotguns or some rifles, by opening the breech and clicking it with individual rounds."\
		)

		var/list/traits = list()

		if(initial(gun.codex_special_info))
			traits += initial(gun.codex_special_info)

		traits += generate_common_info(gun)

		traits += "It accepts the following caliber: [initial(gun.caliber)]"

		var/list/loading_ways = list()

		if(initial(gun.load_method) & SINGLE_CASING)
			loading_ways += "loose [initial(gun.caliber)] rounds"
		if(initial(gun.load_method) & SPEEDLOADER)
			loading_ways += "speedloaders"
		if(initial(gun.load_method) & MAGAZINE)
			loading_ways += "magazines"

		traits += "It can be loaded using [english_list(loading_ways)], and holds up to a maximum of [initial(gun.max_shells)] rounds."

		if(initial(gun.jam_chance))
			traits += "It is prone to jamming."

		entry.mechanics_text += jointext(traits, "<br>")
		entry.update_links()
		SScodex.add_entry_by_string(entry.display_name, entry)
		items += entry.display_name

	..()

/datum/codex_category/gun_cat/energy
	name = "Energy Guns"
	desc = "Mundane lasers produce nowhere near enough energy to cause lasting damage (barring vision loss), but advances\
	in paratechnology allow organizations with anomalous knowhow to produce specially designed energy-based weaponry."

/datum/codex_category/gun_cat/energy/Initialize()
	for(var/thing in subtypesof(/obj/item/gun/energy))
		var/obj/item/gun/energy/gun = thing
		var/datum/codex_entry/entry = new( \
			_display_name = "[initial(gun.name)] (gun)", \
			_associated_paths = list(gun), \
			_lore_text = "This weapon is an energy weapon; it runs on battery charge rather than traditional ammunition.<br>\
			You can recharge it by placing it in a wall-mounted or table-mounted charger, such as those found in the Armory or around the site.<br>\
			Additionally, as an energy weapon it can go straight through windows and hit whatever is on the other side, \
			and is hitscan, making it accurate and useful against distant targets."\
		)

		var/list/traits = list()

		if(initial(gun.codex_special_info))
			traits += initial(gun.codex_special_info)

		traits += generate_common_info(gun)

		traits += "Its maximum capacity is [initial(gun.max_shots)] shots worth of power."

		if(initial(gun.self_recharge))
			traits += "It recharges itself over time."

		entry.mechanics_text += jointext(traits, "<br>")
		entry.update_links()
		SScodex.add_entry_by_string(entry.display_name, entry)
		items += entry.display_name

	..()

/datum/codex_category/gun_cat/magnetic
	name = "Railguns"
	desc = "While railguns aren't viable for use in the mundane world, some anomalies require the usage of electromagnetically-delivered payloads. \
	Thankfully, technological developments have made powerful and (relatively) cheap para-railguns to rival these anomalies."

/datum/codex_category/gun_cat/magnetic/Initialize()
	for(var/thing in subtypesof(/obj/item/gun/magnetic))
		var/obj/item/gun/magnetic/gun = thing
		var/datum/codex_entry/entry = new( \
			_display_name = "[initial(gun.name)] (gun)", \
			_associated_paths = list(gun), \
			_lore_text = "This weapon is a magnetic weapon; it fires solid projectiles using a capacitive charge and magnets.<br>\
			You can unload it by holding it and using it with an empty hand, and reload it by using it with any items the weapon accepts as ammunition.<br>\
			Each shot not only uses ammunition, but also drains the gun's capacitor. The capacitor recharges from the inserted power cell."\
		)

		var/list/traits = list()

		if(initial(gun.codex_special_info))
			traits += initial(gun.codex_special_info)

		traits += generate_common_info(gun)

		if (initial(gun.removable_components))
			traits += "Its cell and capacitor can be removed and replaced. You can remove the components by clicking the gun with an empty hand while it's unloaded."

		if (initial(gun.load_type))
			var/obj/load_item = initial(gun.load_type)
			traits += "It accepts [initial(load_item.name)](s) as ammunition, with a maximum capacity of [initial(gun.load_sheet_max)]."

		if (initial(gun.gun_unreliable))
			traits += "This weapon is unreliable and has a chance of exploding in your hands when you fire it."

		entry.mechanics_text += jointext(traits, "<br>")
		entry.update_links()
		SScodex.add_entry_by_string(entry.display_name, entry)
		items += entry.display_name

	..()

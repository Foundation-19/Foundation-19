// Assoc list of spell types and their categories
GLOBAL_LIST_EMPTY(spells_by_categories)

// Does exactly what it says: Unless dispelled, only wizards can use it.
#define WIZARD_ONLY 1
// Only apprentices can use it
#define APPRENTICE_ONLY 2
// Anyone can use it, owner won't be selected
#define NO_OWNER 4

/obj/item/spellbook
	name = "spell book"
	desc = "A rare magical artifact that engraves spells in the mind of its user."
	icon = 'icons/obj/library.dmi'
	icon_state = "book"
	throw_speed = 1
	throw_range = 3
	w_class = ITEM_SIZE_NORMAL
	var/temp = null
	/// Currently selected spell in the tgui interface.
	var/selected_spell = null
	var/book_flags = 0
	/// Current owner of the book, none other than them can use it; Can be dispelled to remove that and other locks.
	var/mob/owner = null
	/// List of shown spells.
	var/list/allowed_spells = list()
	/// Currently applied spell categories that will be shown; If none - all spells are shown.
	var/list/spell_categories = list()
	/// Defines how strong the dispell must be to successfuly remove the restrictions.
	var/dispell_resistance = 0
	/// List of people that contributed to the list of spells in it.
	var/list/authors = list()

/obj/item/spellbook/Initialize()
	. = ..()
	// Create the global list if empty
	if(!LAZYLEN(GLOB.spells_by_categories))
		for(var/spell_type in subtypesof(/datum/spell))
			var/datum/spell/S = new spell_type()
			GLOB.spells_by_categories[S.type] = S.categories
			qdel(S)

/obj/item/spellbook/Destroy()
	RemoveOwner()
	return ..()

/obj/item/spellbook/attack_self(mob/living/user)
	if(!user.mind)
		return
	if(!user.mind.mana)
		to_chat(user, SPAN_WARNING("You cannot see anything in the book..."))
		return
	if(user.mind.special_role != ANTAG_WIZARD && (book_flags & WIZARD_ONLY))
		to_chat(user, SPAN_WARNING("The book refuses to open for you!"))
		return
	if(user.mind.special_role != ANTAG_APPRENTICE && (book_flags & APPRENTICE_ONLY))
		to_chat(user, SPAN_WARNING("The book refuses to open for you!"))
		return
	if(!(book_flags & NO_OWNER) && owner && user != owner)
		to_chat(user, SPAN_WARNING("The book refuses to open for you!"))
		return
	if(!owner && !(book_flags & NO_OWNER))
		to_chat(user, SPAN_NOTICE("The book starts to glow..."))
		if(!do_after(user, 5 SECONDS, src))
			to_chat(user, SPAN_NOTICE("The book falls silent."))
			return
		to_chat(user, SPAN_NOTICE("The spell book is now bound to your soul!"))
		SetOwner(user)
		return

	tgui_interact(user)

/obj/item/spellbook/examine(mob/user)
	. = ..()
	if(LAZYLEN(authors))
		to_chat(user, SPAN_NOTICE("The book was written by [english_list(authors)]."))

/obj/item/spellbook/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Spellbook", "Spell Book")
		ui.open()

/obj/item/spellbook/tgui_data(mob/user)
	var/list/data = list()
	data["spell_points"] = user.mind.mana.spell_points
	data["mana_level"] = user.mind.mana.mana_level
	data["mana_level_max"] = user.mind.mana.mana_level_max
	data["categories"] = english_list(spell_categories, "None")
	var/list/spell_list = list()
	for(var/spell_type in allowed_spells)
		var/datum/spell/S = spell_type
		var/list/combined_list = GLOB.spells_by_categories[spell_type] & spell_categories
		if(LAZYLEN(spell_categories) && !LAZYLEN(combined_list))
			continue
		spell_list += list(list("name" = initial(S.name), "path" = "[spell_type]"))
	data["spells"] = spell_list
	if(selected_spell && ispath(selected_spell, /datum/spell))
		var/datum/spell/S = selected_spell
		var/datum/spell/OS = locate(S) in user.mind.learned_spells
		var/list/selected = list()
		selected["name"] = initial(S.name)
		selected["desc"] = initial(S.desc)
		selected["path"] = "[S]"
		selected["mana_cost"] = initial(S.mana_cost)
		selected["categories"] = english_list(GLOB.spells_by_categories[S], "None")
		selected["needs_clothes"] = (initial(S.spell_flags) & NEEDSCLOTHES) ? TRUE : FALSE
		selected["no_somatic"] = (initial(S.spell_flags) & NO_SOMATIC) ? TRUE : FALSE
		if(!istype(OS))
			selected["learned"] = FALSE
			selected["purchase_cost"] = initial(S.spell_cost)
		else
			selected["learned"] = TRUE
			var/up_count = 0
			for(var/up_type in OS.spell_levels)
				up_count += OS.spell_levels[up_type]
			selected["used_upgrades"] = up_count
			selected["max_upgrades"] = OS.level_max[UPGRADE_TOTAL]
			selected["has_upgrades"] = OS.level_max[UPGRADE_TOTAL] > 0
			var/list/upgrades = list()
			for(var/upgrade_type in OS.spell_levels)
				if(OS.level_max[upgrade_type] <= 0)
					continue
				upgrades += list(list(
					"type" = upgrade_type,
					"level" = OS.spell_levels[upgrade_type],
					"max" = OS.level_max[upgrade_type],
					"can_improve" = OS.CanImprove(upgrade_type),
					"cost" = OS.upgrade_cost[upgrade_type],
				))
			selected["upgrades"] = upgrades
		data["selected"] = selected
	return data

/obj/item/spellbook/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	switch(action)
		if("spell")
			var/datum/spell/S = text2path(params["path"])
			if(!ispath(S, /datum/spell))
				return TRUE
			if(!(S in allowed_spells))
				return TRUE
			selected_spell = S
			return TRUE
		if("back")
			selected_spell = null
			return TRUE
		if("purchase")
			var/path = text2path(params["path"])
			if(!ispath(path, /datum/spell))
				return TRUE
			if(!(path in allowed_spells))
				return TRUE
			if(locate(path) in usr.mind.learned_spells)
				return TRUE
			SendFeedback(path) //feedback stuff
			to_chat(usr, AddSpell(usr, path))
			selected_spell = path
			return TRUE
		if("upgrade")
			var/spell_path = text2path(params["path"])
			if(!ispath(spell_path, /datum/spell))
				return TRUE
			if(!(spell_path in allowed_spells))
				return TRUE
			var/upgrade_return = UpgradeSpell(usr, spell_path, params["upgrade_type"])
			if(istext(upgrade_return))
				to_chat(usr, upgrade_return)
			return TRUE
		if("categories")
			var/option = "Add"
			if(LAZYLEN(spell_categories))
				option = input(usr, "What do you want to do?", "Options") as anything in list("Add", "Remove", "Clear")
			switch(option)
				if("Add")
					var/list/add_list = list("-- None --") + GLOB.spell_categories - spell_categories
					var/cat = input(usr, "What category do you want to add?", "Add Category") as anything in add_list
					if(cat && !(cat in spell_categories) && (cat in GLOB.spell_categories))
						spell_categories |= cat
				if("Remove")
					var/list/rem_list = list("-- None --") + spell_categories
					var/cat = input(usr, "What category do you want to remove?", "Remove Category") as anything in rem_list
					if(cat && (cat in spell_categories))
						spell_categories -= cat
				if("Clear")
					spell_categories = list()
			return TRUE
	return FALSE

/obj/item/spellbook/attackby(obj/item/P, mob/user)
	. = ..()
	if(istype(P, /obj/item/pen/fancy/quill/magic))
		if(!LAZYLEN(user.mind.learned_spells))
			to_chat(user, SPAN_WARNING("You know no spells, and therefore, cannot write in \the [src]..."))
			return
		var/datum/mana/ML = GetManaDatum(user)
		if(!istype(ML))
			// It could happen so that the quill itself has mana, let's try it
			ML = GetManaDatum(P)
			if(!istype(ML))
				return

		var/list/valid_spells = list("-- None --")
		for(var/datum/spell/SM in user.mind.learned_spells)
			if(SM.type in allowed_spells)
				continue
			valid_spells |= SM
		var/datum/spell/S = input(user, "Which spell do you want to engrave?", "Options") as anything in valid_spells
		if(!istype(S))
			return
		if(!(S in user.mind.learned_spells))
			return
		if(S.type in allowed_spells)
			to_chat(user, SPAN_WARNING("[S.name] spell is already written in [src]!"))
			return
		// You need to have enough mana for the spell
		if(!ML.UseMana(user, S.mana_cost))
			to_chat(user, SPAN_WARNING("You do not have enough mana to engrave [S.name] into \the [src]!"))
			return

		// There we add the spell, at last
		allowed_spells |= S.type
		authors |= user.real_name
		user.visible_message(
			SPAN_NOTICE("[user] writes something in \the [src]!"),
			SPAN_NOTICE("<b>You've engraved <i>[S.name]</i> spell in \the [src]!</b>"),
			SPAN_NOTICE("You hear someone writing in a book."),
			)
		playsound(get_turf(user),'sounds/effects/pen1.ogg', 50, 1)
		return

/obj/item/spellbook/CanUseTopic(mob/M)
	if(!istype(M))
		return STATUS_CLOSE

	if(!istype(M.mind))
		return STATUS_CLOSE

	if((book_flags & WIZARD_ONLY) && M.mind.special_role != ANTAG_WIZARD)
		return STATUS_CLOSE

	if((book_flags & APPRENTICE_ONLY) && M.mind.special_role != ANTAG_APPRENTICE)
		return STATUS_CLOSE

	if(!(book_flags & NO_OWNER) && owner && M != owner)
		return STATUS_CLOSE

	return ..()

// Being hit with any source of dispell releases any locks
/obj/item/spellbook/Dispell(dispell_strength = DISPELL_WEAK)
	. = ..()
	if(!istype(owner) && !(book_flags & WIZARD_ONLY) && !(book_flags & APPRENTICE_ONLY))
		return
	if(dispell_resistance > dispell_strength)
		visible_message(SPAN_WARNING("\The [src] repels the surrounding dispelling magic!"))
		return
	visible_message(SPAN_NOTICE("\The [src] fizzles and sparks!"))
	RemoveOwner()
	owner = null
	book_flags &= ~WIZARD_ONLY
	book_flags &= ~APPRENTICE_ONLY

/obj/item/spellbook/proc/SetOwner(mob/new_owner)
	if(!istype(new_owner))
		return
	RegisterSignal(new_owner, COMSIG_PARENT_QDELETING, PROC_REF(RemoveOwner))
	owner = new_owner

/obj/item/spellbook/proc/RemoveOwner()
	if(!istype(owner))
		return
	UnregisterSignal(owner, COMSIG_PARENT_QDELETING)
	// We set it to random text to prevent people from using the book after gibbing the owner
	owner = "Dead owner"

/obj/item/spellbook/proc/SendFeedback(path)
	if(ispath(path, /datum/spell))
		var/datum/spell/S = path
		SSstatistics.add_field_details("wizard_spell_learned","[initial(S.name)]")
	else if(ispath(path, /obj))
		var/obj/O = path
		SSstatistics.add_field_details("wizard_spell_learned","[initial(O.name)]")

/obj/item/spellbook/proc/UpgradeSpell(mob/living/user, spell_path, upgrade_type = UPGRADE_POWER)
	// TODO: Remove hardcoded upgrade types, and instead make it spell dependent
	for(var/datum/spell/S in user.mind.learned_spells)
		if(!istype(S, spell_path))
			continue
		if(user.mind.mana.spell_points < S.upgrade_cost[upgrade_type])
			return SPAN_WARNING("Not enough spell points!")
		if(!S.CanImprove(upgrade_type))
			return SPAN_WARNING("Cannot upgrade the spell!")
		user.mind.mana.spell_points -= S.upgrade_cost[upgrade_type]
		S.total_points_used += S.upgrade_cost[upgrade_type]
		return S.ImproveSpell(upgrade_type)
	return SPAN_DANGER("Could not locate the spell!")

/obj/item/spellbook/proc/AddSpell(mob/living/user, spell_path)
	var/datum/spell/SP = spell_path
	if(user.mind.mana.spell_points < initial(SP.spell_cost))
		return SPAN_WARNING("Not enough points!")

	var/datum/spell/S = new spell_path()
	user.add_spell(S)
	user.mind.mana.spell_points -= S.spell_cost
	return SPAN_NOTICE("You learn the spell [S]")

/* Subtypes */
// A spell book with EVERY spell available
/obj/item/spellbook/all_spells/Initialize()
	. = ..()
	for(var/spell_type in subtypesof(/datum/spell))
		var/datum/spell/S = spell_type
		if(isnull(initial(S.name)))
			continue
		allowed_spells |= S

// All spells available via spell book
/obj/item/spellbook/all_book_spells/Initialize()
	. = ..()
	for(var/spell_type in GLOB.spells_by_categories)
		var/datum/spell/S = spell_type
		if(isnull(initial(S.name)))
			continue
		if(initial(S.spell_book_visible))
			allowed_spells |= spell_type

// A book spawned to wizard apprentices
/obj/item/spellbook/apprentice
	allowed_spells = list(
		/datum/spell/aoe_turf/knock,
		/datum/spell/targeted/ethereal_jaunt,
		/datum/spell/targeted/projectile/magic_missile,
		)

// Free for all spell book that contains low-end spells that do not require wizard robes.
/obj/item/spellbook/minor_free
	book_flags = NO_OWNER
	allowed_spells = list(
		/datum/spell/aoe_turf/knock,
		/datum/spell/aoe_turf/random_blink,
		/datum/spell/aimed/blink,
		/datum/spell/aimed/heal_target,
		/datum/spell/aoe_turf/exchange_wounds,
		/datum/spell/aoe_turf/smoke,
		)

// Most healing-related spells, any user
/obj/item/spellbook/healing
	book_flags = NO_OWNER
	allowed_spells = list(
		/datum/spell/hand/analyze_health,
		/datum/spell/aimed/heal_target,
		/datum/spell/aimed/heal_target,
		/datum/spell/aimed/heal_target/major,
		/datum/spell/aimed/heal_target/trance,
		/datum/spell/aimed/heal_target/sacrifice,
		)

// List of spells per categories, to prevent generating it all the time
GLOBAL_LIST_EMPTY(random_categories_spells)

// Randomly chosen spells by category, if any
/obj/item/spellbook/random
	name = "minor spell tome"
	desc = "A small magic tome with a tiny assortment of spells."
	book_flags = NO_OWNER
	var/list/random_categories = list()
	/// How many spells are randomly chosen on creation
	var/random_count = 3

/obj/item/spellbook/random/Initialize()
	. = ..()
	var/list/valid_spells = list()
	if(LAZYLEN(random_categories) && (english_list(random_categories) in GLOB.random_categories_spells))
		var/list/glob_list = GLOB.random_categories_spells[english_list(random_categories)]
		valid_spells = glob_list.Copy()
	else
		for(var/spell_type in GLOB.spells_by_categories)
			if(LAZYLEN(random_categories))
				var/list/combined_list = GLOB.spells_by_categories[spell_type] & random_categories
				if(!LAZYLEN(combined_list))
					continue
			valid_spells += spell_type
		GLOB.random_categories_spells[english_list(random_categories)] = valid_spells.Copy()
	for(var/i = 1 to random_count)
		if(!LAZYLEN(valid_spells))
			return
		var/chosen_spell = pick(valid_spells)
		allowed_spells += chosen_spell
		valid_spells -= chosen_spell

/obj/item/spellbook/random/healing
	name = "minor healing tome"
	desc = "A small magic tome with a tiny assortment of healing spells."
	random_categories = list(SPELL_CATEGORY_HEALING)

/obj/item/spellbook/random/healing/medium
	name = "healing tome"
	desc = "A small magic tome with an assortment of healing spells."
	random_count = 6

/obj/item/spellbook/random/fire
	name = "minor fire tome"
	desc = "A small magic tome with a tiny assortment of fire spells."
	random_categories = list(SPELL_CATEGORY_FIRE)

/obj/item/spellbook/random/fire/medium
	name = "fire tome"
	desc = "A small magic tome with an assortment of fire spells."
	random_count = 6

/obj/item/spellbook/random/antimagic
	name = "antimagic tome"
	desc = "A small tome containing techniques and spells used to supress magic and arcane powers."
	random_categories = list(SPELL_CATEGORY_ANTIMAGIC)

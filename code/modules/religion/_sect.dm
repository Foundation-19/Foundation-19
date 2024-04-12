/**
 * # Religious Sects
 *
 * Religious Sects are a way to convert the fun of having an active 'god' (admin) to code-mechanics so you aren't having to press adminwho.
 *
 * Sects are not meant to overwrite the fun of choosing a custom god/religion, but meant to enhance it.
 * The idea is that Space Jesus (or whoever you worship) can be an evil bloodgod who takes the lifeforce out of people, a nature lover, or all things righteous and good. You decide!
 *
 */
/datum/sect
	abstract_type = /datum/sect
	/// Name of the religious sect
	var/name = "Unset Sect Name - Contact a coder"
	/// Flavorful quote given about the sect, used in tgui
	var/quote = "Unset sect quote - Contact a coder."
	/// Opening message when someone gets converted
	var/desc = "Oh My! What Do We Have Here?!!?!?!?"
	/// Tgui icon used by this sect - https://fontawesome.com/icons/
	var/tgui_icon = "bug"
	/// Does this require something before being available as an option?
	var/starter = TRUE
	/// The Sect's 'Mana'
	var/favor = 0 //MANA!
	/// The max amount of favor the sect can have
	var/max_favor = 1000
	/// The default value for an item that can be sacrificed
	var/default_item_favor = 5
	/// Turns into 'desired_items_typecache', and is optionally assoc'd to sacrifice instructions if needed.
	var/list/desired_items
	/// Autopopulated by `desired_items`
	var/list/desired_items_typecache
	/// Lists of rites by type. Converts itself into a list of rites with "name - desc (favor_cost)" = type
	var/list/rites_list
	/// Changes the Altar of Gods icon
	var/altar_icon
	/// Changes the Altar of Gods icon_state
	var/altar_icon_state
	/// Currently Active (non-deleted) rites
	var/list/active_rites
	/// Chance that we fail a bible blessing.
	var/smack_chance = DEFAULT_SMACK_CHANCE
	/// Whether the structure has CANDLE OVERLAYS!
	var/candle_overlay = TRUE

/datum/sect/New()
	. = ..()
	if(desired_items)
		desired_items_typecache = typecacheof(desired_items)
	on_select()

/// Activates once selected
/datum/sect/proc/on_select()
	SHOULD_CALL_PARENT(TRUE)

/// Activates once selected and on newjoins, oriented around people who become holy.
/datum/sect/proc/on_conversion(mob/living/chap)
	SHOULD_CALL_PARENT(TRUE)
	to_chat(chap, SPAN_BOLDNOTICE("\"[quote]\""))
	to_chat(chap, SPAN_NOTICE("[desc]"))

/// Activates if religious sect is reset by admins, should clean up anything you added on conversion.
/datum/sect/proc/on_deconversion(mob/living/chap)
	SHOULD_CALL_PARENT(TRUE)
	to_chat(chap, SPAN_BOLDNOTICE("You have lost the approval of \the [name]."))
	if(chap.mind.holy_role == HOLY_ROLE_HIGHPRIEST)
		to_chat(chap, SPAN_NOTICE("Return to an altar to reform your sect."))

/// Returns TRUE if the item can be sacrificed. Can be modified to fit item being tested as well as person offering. Returning TRUE will stop the attackby sequence and proceed to on_sacrifice.
/datum/sect/proc/can_sacrifice(obj/item/sacrifice, mob/living/chap)
	. = TRUE
	if(chap.mind.holy_role == HOLY_ROLE_DEACON)
		to_chat(chap, SPAN_WARNING("You are merely a deacon of [GLOB.deity], and therefore cannot perform rites."))
		return
	if(!is_type_in_typecache(sacrifice, desired_items_typecache))
		return FALSE

/// Activates when the sect sacrifices an item. This proc has NO bearing on the attackby sequence of other objects when used in conjunction with the religious_tool component.
/datum/sect/proc/on_sacrifice(obj/item/sacrifice, mob/living/chap)
	return adjust_favor(default_item_favor, chap)

/// Returns a description for religious tools
/datum/sect/proc/tool_examine(mob/living/holy_creature)
	return "You are currently at [round(favor)] favor with [GLOB.deity]."

/// Adjust Favor by a certain amount. Can provide optional features based on a user. Returns actual amount added/removed
/datum/sect/proc/adjust_favor(amount = 0, mob/living/chap)
	. = amount
	if(favor + amount < 0)
		. = favor //if favor = 5 and we want to subtract 10, we'll only be able to subtract 5
	if((favor + amount > max_favor))
		. = (max_favor-favor) //if favor = 5 and we want to add 10 with a max of 10, we'll only be able to add 5
	favor = clamp(0, max_favor, favor+amount)

/// Sets favor to a specific amount. Can provide optional features based on a user.
/datum/sect/proc/set_favor(amount = 0, mob/living/chap)
	favor = clamp(0,max_favor,amount)
	return favor

/// Activates when an individual uses a rite. Can provide different/additional benefits depending on the user.
/datum/sect/proc/on_riteuse(mob/living/user, atom/religious_tool)

/// Replaces the bible's bless mechanic. Return TRUE if you want to not do the brain hit.
/datum/sect/proc/sect_bless(mob/living/target, mob/living/chap)
	if(!ishuman(target))
		return FALSE
	var/mob/living/carbon/human/blessed = target
	for(var/obj/item/bodypart/bodypart as anything in blessed.bodyparts)
		if(IS_ROBOTIC_LIMB(bodypart))
			to_chat(chap, SPAN_WARNING("[GLOB.deity] refuses to heal this metallic taint!"))
			return TRUE

	var/heal_amt = 10
	var/list/hurt_limbs = blessed.get_damaged_bodyparts(1, 1, BODYTYPE_ORGANIC)

	if(hurt_limbs.len)
		for(var/X in hurt_limbs)
			var/obj/item/bodypart/affecting = X
			if(affecting.heal_damage(heal_amt, heal_amt, required_bodytype = BODYTYPE_ORGANIC))
				blessed.update_damage_overlays()
		blessed.visible_message(SPAN_NOTICE("[chap] heals [blessed] with the power of [GLOB.deity]!"))
		to_chat(blessed, SPAN_BOLDNOTICE("May the power of [GLOB.deity] compel you to be healed!"))
		playsound(chap, SFX_PUNCH, 25, TRUE, -1)
	return TRUE

/// What happens if we bless a corpse? By default just do the default smack behavior
/datum/sect/proc/sect_dead_bless(mob/living/target, mob/living/chap)
	return FALSE

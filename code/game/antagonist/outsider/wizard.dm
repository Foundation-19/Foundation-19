GLOBAL_DATUM_INIT(wizards, /datum/antagonist/wizard, new)

/datum/antagonist/wizard
	id = MODE_WIZARD
	role_text = ANTAG_WIZARD
	role_text_plural = ANTAG_WIZARD + "s"
	landmark_id = "wizard"
	welcome_text = "You will find a list of available spells in your spell book. Choose your magic arsenal carefully.<br>In your pockets you will find a teleport scroll. Use it as needed."
	flags = ANTAG_OVERRIDE_JOB | ANTAG_OVERRIDE_MOB | ANTAG_CLEAR_EQUIPMENT | ANTAG_CHOOSE_NAME | ANTAG_VOTABLE | ANTAG_SET_APPEARANCE
	antaghud_indicator = "hudwizard"

	hard_cap = 1
	hard_cap_round = 3
	initial_spawn_req = 1
	initial_spawn_target = 1
	min_player_age = 18

	faction = "wizard"
	base_to_load = /datum/map_template/ruin/antag_spawn/wizard

/datum/antagonist/wizard/create_objectives(datum/mind/wizard)

	if(!..())
		return

	var/kill = FALSE
	var/escape = FALSE
	var/steal = FALSE
	var/hijack = FALSE

	switch(rand(1,100))
		if(1 to 30)
			escape = TRUE
			kill = TRUE
		if(31 to 60)
			escape = TRUE
			steal = TRUE
		if(61 to 99)
			kill = TRUE
			steal = TRUE
		else
			hijack = TRUE

	if(kill)
		var/datum/objective/assassinate/kill_objective = new
		kill_objective.owner = wizard
		kill_objective.find_target()
		wizard.objectives |= kill_objective
	if(steal)
		var/datum/objective/steal/steal_objective = new
		steal_objective.owner = wizard
		steal_objective.find_target()
		wizard.objectives |= steal_objective
	if(escape)
		var/datum/objective/survive/survive_objective = new
		survive_objective.owner = wizard
		wizard.objectives |= survive_objective
	if(hijack)
		var/datum/objective/hijack/hijack_objective = new
		hijack_objective.owner = wizard
		wizard.objectives |= hijack_objective
	return

/datum/antagonist/wizard/update_antag_mob(datum/mind/wizard)
	..()
	wizard.StoreMemory("<B>Remember:</B> do not forget to prepare your spells.", /decl/memory_options/system)
	wizard.current.real_name = "[pick(GLOB.wizard_first)] [pick(GLOB.wizard_second)]"
	wizard.current.SetName(wizard.current.real_name)

/datum/antagonist/wizard/equip(mob/living/carbon/human/wizard_mob)

	if(!..())
		return FALSE

	var/outfit_type = pick(subtypesof(/decl/hierarchy/outfit/wizard))
	var/decl/hierarchy/outfit/wizard_outfit = outfit_by_type(outfit_type)
	wizard_outfit.equip(wizard_mob)

	// Gives high mana & spell points
	wizard_mob.mind.mana.mana_level_max = 100
	wizard_mob.mind.mana.mana_level = 100
	wizard_mob.mind.mana.mana_recharge_speed = 2
	wizard_mob.mind.mana.spell_points = 15 // Should allow wizard to buy 2-3 dangerous spells, or a bunch of small stuff

	return TRUE

/datum/antagonist/wizard/print_player_summary()
	..()
	for(var/p in current_antagonists)
		var/datum/mind/player = p
		var/text = "<b>[player.name]'s spells were:</b>"
		if(!player.learned_spells || !player.learned_spells.len)
			text += "<br>None!"
		else
			for(var/s in player.learned_spells)
				var/datum/spell/spell = s
				text += "<br><b>[spell.name]</b> - "
				text += "Speed: [spell.spell_levels["speed"]] Power: [spell.spell_levels["power"]]"
		text += "<br>"
		to_world(text)


//To batch-remove wizard spells. Linked to mind.dm.
/mob/proc/spellremove()
	if(!mind || !mind.learned_spells)
		return
	for(var/datum/spell/spell_to_remove in mind.learned_spells)
		remove_spell(spell_to_remove)

/obj/item/clothing
	var/wizard_garb = FALSE

// Does this clothing slot count as wizard garb?
/proc/is_wiz_garb(obj/item/clothing/C)
	return istype(C) && C.wizard_garb

// Checks if the wizard is wearing the proper attire.
// Made a proc so this is not repeated 14 (or more) times.
/mob/proc/wearing_wiz_garb()
	to_chat(src, "Silly creature, you're not a human. Only humans can cast this spell.")
	return FALSE

/mob/living/carbon/human/wearing_wiz_garb()
	if(!is_wiz_garb(wear_suit) && (!species.hud || (slot_wear_suit in species.hud.equip_slots)))
		to_chat(src, SPAN_WARNING("I don't feel strong enough without my robe."))
		return FALSE
	if(!is_wiz_garb(head) && (!species.hud || (slot_head in species.hud.equip_slots)))
		to_chat(src, SPAN_WARNING("I don't feel strong enough without my hat."))
		return FALSE
	return TRUE

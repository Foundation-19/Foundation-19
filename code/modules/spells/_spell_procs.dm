/datum/mind
	var/list/learned_spells = list()
	var/datum/spell/last_used_spell = null

/mob/Stat()
	. = ..()
	if(. && ability_master && ability_master.spell_objects)
		for(var/atom/movable/screen/ability/spell/screen in ability_master.spell_objects)
			var/datum/spell/S = screen.spell
			if(!istype(S))
				ability_master.remove_ability(screen)
				continue
			if((!S.connected_button) || !statpanel(S.panel))
				continue // Not showing the noclothes spell
			switch(S.charge_type)
				if(SPELL_RECHARGE)
					statpanel(S.panel,"[S.charge_counter/10.0]/[S.charge_max/10]",S.connected_button)
				if(SPELL_CHARGES)
					statpanel(S.panel,"[S.charge_counter]/[S.charge_max]",S.connected_button)
				if(SPELL_HOLDVAR)
					statpanel(S.panel,"[S.holder_var_type] [S.holder_var_amount]",S.connected_button)

//A fix for when a spell is created before a mob is created
/mob/Login()
	. = ..()
	if(mind)
		if(!mind.learned_spells)
			mind.learned_spells = list()
		if(ability_master && ability_master.spell_objects)
			for(var/atom/movable/screen/ability/spell/screen in ability_master.spell_objects)
				var/datum/spell/S = screen.spell
				mind.learned_spells |= S

/proc/restore_spells(mob/H)
	if(H.mind && H.mind.learned_spells)
		var/list/spells = list()
		for(var/datum/spell/spell_to_remove in H.mind.learned_spells) //remove all the spells from other people.
			if(istype(spell_to_remove.holder,/mob))
				var/mob/M = spell_to_remove.holder
				spells += spell_to_remove
				M.remove_spell(spell_to_remove, FALSE)

		for(var/datum/spell/spell_to_add in spells)
			H.add_spell(spell_to_add)
	H.ability_master.update_abilities(0,H)

/mob/proc/add_spell(datum/spell/spell_to_add, spell_base = "wiz_spell_ready")
	if(!ability_master)
		ability_master = new()
	spell_to_add.holder = src
	if(mind)
		if(!mind.learned_spells)
			mind.learned_spells = list()
		mind.learned_spells |= spell_to_add
	ability_master.add_spell(spell_to_add, spell_base)
	return 1

/mob/proc/remove_spell(datum/spell/spell_to_remove, should_delete = TRUE)
	if(!spell_to_remove || !istype(spell_to_remove))
		return

	if(mind)
		mind.learned_spells -= spell_to_remove
	if(ability_master)
		ability_master.remove_ability(ability_master.get_ability_by_spell(spell_to_remove))
	if(should_delete)
		QDEL_NULL(spell_to_remove)
	return 1

/mob/proc/silence_spells(amount = 0)
	if(!amount)
		return

	if(!ability_master)
		return

	ability_master.silence_spells(amount)

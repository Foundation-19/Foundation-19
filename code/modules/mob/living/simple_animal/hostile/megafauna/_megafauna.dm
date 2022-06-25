// Mobs with plenty of special abilities and other stuff.
/mob/living/simple_animal/hostile/megafauna
	mob_size = MOB_LARGE
	status_flags = 0 // Can't be pushed, stunned or otherwise
	min_gas = null // Immune to atmos damage
	max_gas = null
	minbodytemp = 0 // Immune to temperature
	maxbodytemp = 500000
	var/chosen_attack = 1
	var/deathsound
	var/list/mob_actions = list()
	var/list/loot_drop = list()

/mob/living/simple_animal/hostile/megafauna/Initialize()
	. = ..()
	for(var/action_type in mob_actions)
		var/datum/action/megafauna/attack_action = new action_type()
		attack_action.Grant(src)

/mob/living/simple_animal/hostile/megafauna/death(gibbed, deathmessage, show_dead_message)
	for(var/obj/item/loot in loot_drop)
		new loot (loc)
	if(deathsound)
		playsound(src, deathsound, 50, 1)

/datum/action/megafauna
	var/chosen_message
	var/chosen_attack_num

/datum/action/megafauna/Trigger()
	to_chat(owner, FONT_LARGE(SPAN_DANGER(chosen_message)))
	if(istype(owner, /mob/living/simple_animal/hostile/megafauna))
		var/mob/living/simple_animal/hostile/megafauna/mf = owner
		mf.chosen_attack = chosen_attack_num
	return

/datum/reward/skills
	var/decl/hierarchy/skill/buff_skill = null	// what skill we're going to buff
	var/buff_level = null 	// how high we're going to buff it
	var/buff_timer = null	// how long we're gonna buff it

/datum/reward/skills/New(datum/goal/_goal, reward_success = TRUE, _buff_skill, _buff_level, _buff_timer)
	buff_skill = _buff_skill
	buff_level = _buff_level
	buff_timer = _buff_timer

	var/buff_level_name
	switch(buff_level)
		if(SKILL_UNTRAINED)
			buff_level_name = "Untrained"
		if(SKILL_BASIC)
			buff_level_name = "Basic"
		if(SKILL_TRAINED)
			buff_level_name = "Trained"
		if(SKILL_EXPERIENCED)
			buff_level_name = "Experienced"
		if(SKILL_MASTER)
			buff_level_name = "Master"

	description = "[initial(buff_skill.name)] is increased to [buff_level_name] for [buff_timer / (1 MINUTE)] minutes."
	. = ..(_goal, reward_success)

/datum/reward/skills/handle_behavior()
	var/datum/component/goalcontainer/C = attached_goal.container
	var/datum/mind/MI = C.parent
	var/mob/M = MI.current

	// do NOT remove the parenthesis around buff_skill. BYOND reads it as "buff_skill" (as in a text var) if you remove them
	M.buff_skill(list((buff_skill) = (buff_level - SKILL_MIN)), buff_timer)

/datum/reward/sanity
	var/sanity_damage = null	// how much sanity we lose/get

/datum/reward/sanity/New(datum/goal/_goal, reward_success = TRUE, _sanity_damage)
	sanity_damage = _sanity_damage

	description = "Sanity is [SIMPLE_SIGN(sanity_damage) == 1 ? "decreased" : "increased"] by [abs(sanity_damage)]."
	. = ..(_goal, reward_success)

/datum/reward/sanity/handle_behavior()
	var/datum/component/goalcontainer/C = attached_goal.container
	var/datum/mind/M = C.parent
	var/mob/living/carbon/LC = M.current
	var/obj/item/organ/internal/brain/B = LC.internal_organs_by_name[BP_BRAIN]
	B.take_sanity_damage(sanity_damage, TRUE)	// silent, since the goal automatically to_chat's the mob

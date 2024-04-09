//basic transformation spell. Should work for most simple_animals

/datum/spell/targeted/shapeshift
	desc = "This spell transforms the target into something else for a short while."


	charge_type = SPELL_RECHARGE
	charge_max = 600

	duration = 0 //set to 0 for permanent.

	var/list/possible_transformations = list()
	var/list/newVars = list() //what the variables of the new created thing will be.

	cast_sound = 'sounds/magic/charge.ogg'
	var/revert_sound = 'sounds/magic/charge.ogg' //the sound that plays when something gets turned back.
	var/share_damage = 1 //do we want the damage we take from our new form to move onto our real one? (Only counts for finite duration)
	var/drop_items = FALSE //do we want to drop all our items when we transform?
	var/toggle = 0 //Can we toggle this?
	var/list/transformed_dudes = list() //Who we transformed. Transformed = Transformation. Both mobs.

/datum/spell/targeted/shapeshift/cast(list/targets, mob/user)
	for(var/m in targets)
		var/mob/living/M = m
		if(M.stat == DEAD)
			to_chat(user, "[name] can only transform living targets.")
			continue
		if(M.buckled)
			M.buckled.unbuckle_mob()
		if(toggle && transformed_dudes.len && stop_transformation(M))
			continue
		var/new_mob = pick(possible_transformations)

		var/mob/living/trans = new new_mob(get_turf(M))
		for(var/varName in newVars) //stolen shamelessly from Conjure
			if(varName in trans.vars)
				trans.vars[varName] = newVars[varName]
		//Give them our languages
		for(var/l in M.languages)
			var/datum/language/L = l
			trans.add_language(L.name)

		trans.SetName("[trans.name] ([M])")
		if(istype(M,/mob/living/carbon/human) && drop_items)
			for(var/obj/item/I in M.contents)
				M.drop_from_inventory(I)
		if(M.mind)
			M.mind.transfer_to(trans)
		else
			trans.key = M.key
		new /obj/effect/temp_visual/temporary(get_turf(M), 5, 'icons/effects/effects.dmi', "summoning")

		M.forceMove(trans) //move inside the new dude to hide him.
		M.status_flags |= GODMODE //don't want him to die or breathe or do ANYTHING
		transformed_dudes[trans] = M
		RegisterSignal(trans, COMSIG_ADD_TO_DEAD_MOB_LIST, TYPE_PROC_REF(/datum/spell/targeted/shapeshift, stop_transformation))
		RegisterSignal(trans, COMSIG_PARENT_QDELETING, TYPE_PROC_REF(/datum/spell/targeted/shapeshift, stop_transformation))
		RegisterSignal(M, COMSIG_PARENT_QDELETING, TYPE_PROC_REF(/datum/spell/targeted/shapeshift, destroyed_transformer))
		if(duration)
			spawn(duration)
				stop_transformation(trans)

/datum/spell/targeted/shapeshift/proc/destroyed_transformer(mob/target) //Juuuuust in case
	var/mob/current = transformed_dudes[target]
	to_chat(current, "<span class='danger'>You suddenly feel as if this transformation has become permanent...</span>")
	remove_target(target)

/datum/spell/targeted/shapeshift/proc/stop_transformation(mob/living/target)
	var/mob/living/transformer = transformed_dudes[target]
	if(!transformer)
		return FALSE
	transformer.status_flags &= ~GODMODE
	if(share_damage)
		var/ratio = target.health/target.maxHealth
		var/damage = transformer.maxHealth - round(transformer.maxHealth*(ratio))
		for(var/i in 1 to ceil(damage/10))
			transformer.adjustBruteLoss(10)
	if(target.mind)
		target.mind.transfer_to(transformer)
	else
		transformer.key = target.key
	playsound(get_turf(target), revert_sound, 50, 1)
	transformer.forceMove(get_turf(target))
	remove_target(target)
	qdel(target)
	return TRUE

/datum/spell/targeted/shapeshift/proc/remove_target(mob/living/target)
	var/mob/current = transformed_dudes[target]
	UnregisterSignal(target, COMSIG_PARENT_QDELETING)
	UnregisterSignal(current, COMSIG_ADD_TO_DEAD_MOB_LIST)
	UnregisterSignal(current, COMSIG_PARENT_QDELETING)
	transformed_dudes[target] = null
	transformed_dudes -= target

/datum/spell/targeted/shapeshift/baleful_polymorph
	name = "Baleful Polymorth"
	desc = "This spell transforms its target into a small, furry animal."
	possible_transformations = list(/mob/living/simple_animal/friendly/lizard,/mob/living/simple_animal/friendly/mouse,/mob/living/simple_animal/friendly/corgi)

	share_damage = 0
	invocation = "Yo'balada!"
	invocation_type = INVOKE_SHOUT
	spell_flags = NEEDSCLOTHES | SELECTABLE
	range = 3
	duration = 150 //15 seconds.
	cooldown_min = 200 //20 seconds

	level_max = list(UPGRADE_TOTAL = 2, UPGRADE_SPEED = 2, UPGRADE_POWER = 2)

	newVars = list("health" = 50, "maxHealth" = 50)

	hud_state = "wiz_poly"

	spell_cost = 1
	mana_cost = 3

/datum/spell/targeted/shapeshift/baleful_polymorph/ImproveSpellPower()
	if(!..())
		return 0

	duration += 50

	return "Your target will now stay in their polymorphed form for [duration/10] seconds."

/datum/spell/targeted/shapeshift/avian
	name = "Polymorph"
	desc = "This spell transforms the wizard into the common parrot."
	possible_transformations = list(/mob/living/simple_animal/hostile/retaliate/parrot)

	share_damage = 0
	invocation = "Poli'crakata!"
	invocation_type = INVOKE_SHOUT
	spell_flags = INCLUDEUSER
	range = -1
	duration = 150
	charge_max = 600
	cooldown_min = 300
	level_max = list(UPGRADE_TOTAL = 1, UPGRADE_SPEED = 1, UPGRADE_POWER = 0)
	hud_state = "wiz_parrot"

	spell_cost = 1
	mana_cost = 3

/datum/spell/targeted/shapeshift/corrupt_form
	name = "Corrupt Form"
	desc = "This spell shapes the wizard into a terrible, terrible beast."
	possible_transformations = list(/mob/living/simple_animal/hostile/faithless)

	invocation = "mutters something dark and twisted as their form begins to twist..."
	invocation_type = INVOKE_EMOTE
	spell_flags = INCLUDEUSER
	range = -1
	duration = 150
	charge_max = 1200
	cooldown_min = 600

	share_damage = 0
	level_max = list(UPGRADE_TOTAL = 3, UPGRADE_SPEED = 2, UPGRADE_POWER = 2)

	newVars = list("name" = "corrupted soul")

	hud_state = "wiz_corrupt"
	cast_sound = 'sounds/magic/disintegrate.ogg'

	spell_cost = 2
	mana_cost = 10

/datum/spell/targeted/shapeshift/corrupt_form/ImproveSpellPower()
	if(!..())
		return 0

	switch(spell_levels[UPGRADE_POWER])
		if(1)
			duration *= 2
			return "You will now stay corrupted for [duration/10] seconds."
		if(2)
			newVars = list("name" = "\proper corruption incarnate",
						"melee_damage_upper" = 25,
						"resistance" = 6,
						"health" = 125,
						"maxHealth" = 125)
			duration = 0
			return "You revel in the corruption. There is no turning back."

/datum/spell/targeted/shapeshift/familiar
	name = "Transform"
	desc = "Transform into a familiar form. Literally."
	possible_transformations = list()

	invocation_type = INVOKE_EMOTE
	invocation = "'s body dissipates into a pale mass of light, then reshapes!"
	range = -1
	spell_flags = INCLUDEUSER
	duration = 0
	charge_max = 2 MINUTES
	toggle = 1

	hud_state = "wiz_carp"

	spell_cost = 2
	mana_cost = 5

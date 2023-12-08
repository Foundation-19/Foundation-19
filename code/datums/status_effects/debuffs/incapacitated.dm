/// The damage healed per tick while sleeping without any modifiers
#define HEALING_SLEEP_DEFAULT 0.2
/// The sleep healing multipler for organ passive healing (since organs heal slowly)
#define HEALING_SLEEP_ORGAN_MULTIPLIER 5

//STUN EFFECTS
/datum/status_effect/incapacitating
	tick_interval = 0
	status_type = STATUS_EFFECT_REPLACE
	alert_type = null
	remove_on_fullheal = TRUE
	//heal_flag_necessary = HEAL_CC_STATUS
	var/needs_update_stat = FALSE

/datum/status_effect/incapacitating/on_creation(mob/living/new_owner, set_duration)
	if(isnum(set_duration))
		duration = set_duration
	return ..()

//STUN
/datum/status_effect/incapacitating/stun
	id = "stun"

/datum/status_effect/incapacitating/stun/on_apply()
	. = ..()
	if(!.)
		return
	owner.add_traits(list(TRAIT_INCAPACITATED, TRAIT_HANDS_BLOCKED), TRAIT_STATUS_EFFECT(id))

/datum/status_effect/incapacitating/stun/on_remove()
	owner.remove_traits(list(TRAIT_INCAPACITATED, TRAIT_HANDS_BLOCKED), TRAIT_STATUS_EFFECT(id))
	return ..()

//INCAPACITATED
/// This status effect represents anything that leaves a character unable to perform basic tasks (interrupting do-afters, for example), but doesn't incapacitate them further than that (no stuns etc..)
/datum/status_effect/incapacitating/incapacitated
	id = "incapacitated"

// What happens when you get the incapacitated status. You get TRAIT_INCAPACITATED added to you for the duration of the status effect.
/datum/status_effect/incapacitating/incapacitated/on_apply()
	. = ..()
	if(!.)
		return
	ADD_TRAIT(owner, TRAIT_INCAPACITATED, TRAIT_STATUS_EFFECT(id))

// When the status effect runs out, your TRAIT_INCAPACITATED is removed.
/datum/status_effect/incapacitating/incapacitated/on_remove()
	REMOVE_TRAIT(owner, TRAIT_INCAPACITATED, TRAIT_STATUS_EFFECT(id))
	return ..()

//SLEEPING
/datum/status_effect/incapacitating/sleeping
	id = "sleeping"
	alert_type = /atom/movable/screen/alert/status_effect/asleep
	needs_update_stat = TRUE
	tick_interval = 2 SECONDS

/datum/status_effect/incapacitating/sleeping/tick()
	if(owner.maxHealth)
		var/health_ratio = owner.health / owner.maxHealth
		var/healing = HEALING_SLEEP_DEFAULT

		// having high spirits helps us recover
		/*if(owner.mob_mood)
			switch(owner.mob_mood.sanity_level)
				if(SANITY_LEVEL_GREAT)
					healing = 0.2
				if(SANITY_LEVEL_NEUTRAL)
					healing = 0.1
				if(SANITY_LEVEL_DISTURBED)
					healing = 0
				if(SANITY_LEVEL_UNSTABLE)
					healing = 0
				if(SANITY_LEVEL_CRAZY)
					healing = -0.1
				if(SANITY_LEVEL_INSANE)
					healing = -0.2*/

		var/turf/rest_turf = get_turf(owner)
		var/is_sleeping_in_darkness = rest_turf.get_lumcount() <= LIGHTING_TILE_IS_DARK

		if(ishuman(owner))
			var/mob/living/carbon/human/H = owner

			// sleeping with a blindfold or in the dark helps us rest
			if(H.equipment_tint_total != TINT_BLIND || is_sleeping_in_darkness)
				healing += 0.1

		// sleeping in silence is always better
		if(HAS_TRAIT(owner, TRAIT_DEAF))
			healing += 0.1

		// check for beds
		if((locate(/obj/structure/bed) in owner.loc))
			healing += 0.2
		else if((locate(/obj/structure/table) in owner.loc))
			healing += 0.1

		// don't forget the bedsheet
		if(locate(/obj/item/bedsheet) in owner.loc)
			healing += 0.1

		if(healing > 0)
			if(health_ratio > 0.8) // only heals minor physical damage
				owner.adjustBruteLoss(-1 * healing)
				owner.adjustFireLoss(-1 * healing)
				owner.adjustToxLoss(-1 * healing * 0.5)
	// Drunkenness gets reduced by 0.3% per tick (6% per 2 seconds)
	owner.set_drunk_effect(owner.get_drunk_amount() * 0.997)

	if(prob(2))
		owner.emote("snore")

/atom/movable/screen/alert/status_effect/asleep
	name = "Asleep"
	desc = "You've fallen asleep. Wait a bit and you should wake up. Unless you don't, considering how helpless you are."
	icon_state = "asleep"

#undef HEALING_SLEEP_DEFAULT
#undef HEALING_SLEEP_ORGAN_MULTIPLIER

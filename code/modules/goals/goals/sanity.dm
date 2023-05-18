// goals that reward RP behavior with sanity increases

/datum/goal/sanity
	abstract_type = /datum/goal/sanity
	var/default_sanity_damage = null	// default values for the sanity reward (if autofilled). should be negative here

/datum/goal/sanity/autofill_rewards()
	var/datum/reward/sanity/R = new(_goal = src, reward_success = TRUE, _sanity_damage = default_sanity_damage)
	rewards += R

/datum/goal/sanity/drink
	default_sanity_damage = -10
	success_message = "Ahh, that hit the spot!"
	var/datum/reagent/drink/drink_type

/datum/goal/sanity/drink/New()
	var/datum/reagent/drink/D = pick(subtypesof(/datum/reagent/drink))
	drink_type = D
	description = "Take a sip of \a [initial(drink_type.name)]."
	success_description = "Drank \a [initial(drink_type.name)]."
	. = ..()
	var/datum/mind/M = container.parent
	RegisterSignal(M.current, COMSIG_REAGENT_INGESTED_ + "[drink_type]", .proc/handle_progress)

/datum/goal/sanity/drink/proc/handle_progress()
	var/datum/mind/M = container.parent
	UnregisterSignal(M.current, COMSIG_REAGENT_INGESTED_ + "[drink_type]")
	goal_finish(TRUE)

/datum/goal/sanity/give_hug
	default_sanity_damage = -5
	description = "Give someone a hug."
	success_message = "You made someone's day a little brighter."

/datum/goal/sanity/give_hug/New()
	. = ..()
	var/datum/mind/M = container.parent
	RegisterSignal(M.current, COMSIG_GAVE_HUG, .proc/handle_progress)

/datum/goal/sanity/give_hug/proc/handle_progress(mob/living/carbon/human/H, mob/living/target)
	success_description = "Gave \the [target.name] a hug."
	var/datum/mind/M = container.parent
	UnregisterSignal(M.current, COMSIG_GAVE_HUG)
	goal_finish(TRUE)

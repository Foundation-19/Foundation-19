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
	var/drink_type

/datum/goal/sanity/drink/New()
	var/datum/reagent/drink/D = pick(subtypesof(/datum/reagent/drink))
	drink_type = D
	description = "Take a sip of \a [initial(D.name)]."
	success_description = "Drank \a [initial(D.name)]."
	. = ..()
	var/datum/mind/M = container.parent
	RegisterSignal(M.current, COMSIG_REAGENT_INGESTED, PROC_REF(handle_progress))

/datum/goal/sanity/drink/proc/handle_progress(mob/living/carbon/M, datum/reagent/R)
	if(R == drink_type)
		UnregisterSignal(M, COMSIG_REAGENT_INGESTED)
		goal_finish(TRUE)

/datum/goal/sanity/give_hug
	default_sanity_damage = -5
	description = "Give someone a hug."
	success_message = "You made someone's day a little brighter."

/datum/goal/sanity/give_hug/New()
	. = ..()
	var/datum/mind/M = container.parent
	RegisterSignal(M.current, COMSIG_GAVE_HUG, PROC_REF(handle_progress))

/datum/goal/sanity/give_hug/proc/handle_progress(mob/living/carbon/human/H, mob/living/target)
	success_description = "Gave \the [target.name] a hug."
	var/datum/mind/M = container.parent
	UnregisterSignal(M.current, COMSIG_GAVE_HUG)
	goal_finish(TRUE)

/datum/goal/sanity/smoke
	default_sanity_damage = -8
	description = "Smoke something, anything."
	success_message = "You know it's not healthy, but it feels so good..."

/datum/goal/sanity/smoke/New()
	. = ..()
	var/datum/mind/M = container.parent
	RegisterSignal(M.current, COMSIG_SMOKED_SMOKABLE, PROC_REF(handle_progress))

/datum/goal/sanity/smoke/proc/handle_progress(smoker, obj/item/clothing/mask/smokable/smokable, amount)
	success_description = "Smoke a [smokable.name]."
	var/datum/mind/M = container.parent
	UnregisterSignal(M.current, COMSIG_SMOKED_SMOKABLE)
	goal_finish(TRUE)

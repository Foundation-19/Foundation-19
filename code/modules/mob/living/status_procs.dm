/**
 * Adjust the "drunk value" the mob is currently experiencing,
 * or applies a drunk effect if the mob isn't currently drunk (or tipsy)
 *
 * The drunk effect doesn't have a set duration, like dizziness or drugginess,
 * but instead relies on a value that decreases every status effect tick (2 seconds) by:
 * 4% the current drunk_value + 0.01
 *
 * A "drunk value" of 6 is the border between "tipsy" and "drunk".
 *
 * amount - the amount of "drunkness" to apply to the mob.
 * down_to - the lower end of the clamp, when adding the value
 * up_to - the upper end of the clamp, when adding the value
 */
/mob/living/proc/adjust_drunk_effect(amount, down_to = 0, up_to = INFINITY)
	if(!isnum(amount))
		CRASH("adjust_drunk_effect: called with an invalid amount. (Got: [amount])")

	var/datum/status_effect/inebriated/inebriation = has_status_effect(/datum/status_effect/inebriated)
	if(inebriation)
		inebriation.set_drunk_value(clamp(inebriation.drunk_value + amount, down_to, up_to))
	else if(amount > 0)
		apply_status_effect(/datum/status_effect/inebriated/tipsy, amount)


/**
 * Directly sets the "drunk value" the mob is currently experiencing to the passed value,
 * or applies a drunk effect with the passed value if the mob isn't currently drunk
 *
 * set_to - the amount of "drunkness" to set on the mob.
 */
/mob/living/proc/set_drunk_effect(set_to)
	if(!isnum(set_to) || set_to < 0)
		CRASH("set_drunk_effect: called with an invalid value. (Got: [set_to])")

	var/datum/status_effect/inebriated/inebriation = has_status_effect(/datum/status_effect/inebriated)
	if(inebriation)
		inebriation.set_drunk_value(set_to)
	else if(set_to > 0)
		apply_status_effect(/datum/status_effect/inebriated/tipsy, set_to)

/// Helper to get the amount of drunkness the mob's currently experiencing.
/mob/living/proc/get_drunk_amount()
	var/datum/status_effect/inebriated/inebriation = has_status_effect(/datum/status_effect/inebriated)
	return inebriation?.drunk_value || 0

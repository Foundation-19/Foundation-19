/**
 * Adjusts a timed status effect on the mob,taking into account any existing timed status effects.
 * This can be any status effect that takes into account "duration" with their initialize arguments.
 *
 * Positive durations will add deciseconds to the duration of existing status effects
 * or apply a new status effect of that duration to the mob.
 *
 * Negative durations will remove deciseconds from the duration of an existing version of the status effect,
 * removing the status effect entirely if the duration becomes less than zero (less than the current world time).
 *
 * duration - the duration, in deciseconds, to add or remove from the effect
 * effect - the type of status effect being adjusted on the mob
 * max_duration - optional - if set, positive durations will only be added UP TO the passed max duration
 */
/mob/living/proc/adjust_timed_status_effect(duration, effect, max_duration)
	if(!isnum(duration))
		CRASH("adjust_timed_status_effect: called with an invalid duration. (Got: [duration])")

	if(!ispath(effect, /datum/status_effect))
		CRASH("adjust_timed_status_effect: called with an invalid effect type. (Got: [effect])")

	// If we have a max duration set, we need to check our duration does not exceed it
	if(isnum(max_duration))
		if(max_duration <= 0)
			CRASH("adjust_timed_status_effect: Called with an invalid max_duration. (Got: [max_duration])")

		if(duration >= max_duration)
			duration = max_duration

	var/datum/status_effect/existing = has_status_effect(effect)
	if(existing)
		if(isnum(max_duration) && duration > 0)
			// Check the duration remaining on the existing status effect
			// If it's greater than / equal to our passed max duration, we don't need to do anything
			var/remaining_duration = existing.duration - world.time
			if(remaining_duration >= max_duration)
				return

			// Otherwise, add duration up to the max (max_duration - remaining_duration),
			// or just add duration if it doesn't exceed our max at all
			existing.duration += min(max_duration - remaining_duration, duration)

		else
			existing.duration += duration

		// If the duration was decreased and is now less 0 seconds,
		// qdel it / clean up the status effect immediately
		// (rather than waiting for the process tick to handle it)
		if(existing.duration <= world.time)
			qdel(existing)

	else if(duration > 0)
		apply_status_effect(effect, duration)

/**
 * Sets a timed status effect of some kind on a mob to a specific value.
 * If only_if_higher is TRUE, it will only set the value up to the passed duration,
 * so any pre-existing status effects of the same type won't be reduced down
 *
 * duration - the duration, in deciseconds, of the effect. 0 or lower will either remove the current effect or do nothing if none are present
 * effect - the type of status effect given to the mob
 * only_if_higher - if TRUE, we will only set the effect to the new duration if the new duration is longer than any existing duration
 */
/mob/living/proc/set_timed_status_effect(duration, effect, only_if_higher = FALSE)
	if(!isnum(duration))
		CRASH("set_timed_status_effect: called with an invalid duration. (Got: [duration])")

	if(!ispath(effect, /datum/status_effect))
		CRASH("set_timed_status_effect: called with an invalid effect type. (Got: [effect])")

	var/datum/status_effect/existing = has_status_effect(effect)
	if(existing)
		// set_timed_status_effect to 0 technically acts as a way to clear effects,
		// though remove_status_effect would achieve the same goal more explicitly.
		if(duration <= 0)
			qdel(existing)
			return

		if(only_if_higher)
			// If the existing status effect has a higher remaining duration
			// than what we aim to set it to, don't downgrade it - do nothing (return)
			var/remaining_duration = existing.duration - world.time
			if(remaining_duration >= duration)
				return

		// Set the duration accordingly
		existing.duration = world.time + duration

	else if(duration > 0)
		apply_status_effect(effect, duration)

/**
 * Gets how many deciseconds are remaining in
 * the duration of the passed status effect on this mob.
 *
 * If the mob is unaffected by the passed effect, returns 0.
 */
/mob/living/proc/get_timed_status_effect_duration(effect)
	if(!ispath(effect, /datum/status_effect))
		CRASH("get_timed_status_effect_duration: called with an invalid effect type. (Got: [effect])")

	var/datum/status_effect/existing = has_status_effect(effect)
	if(!existing)
		return 0
	// Infinite duration status effects technically are not "timed status effects"
	// by name or nature, but support is included just in case.
	if(existing.duration == -1)
		return INFINITY

	return existing.duration - world.time


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

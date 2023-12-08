/// Called on [/mob/living/Initialize(mapload)], for the mob to register to relevant signals.
/mob/living/proc/register_init_signals()
	RegisterSignals(src, list(
		SIGNAL_ADDTRAIT(TRAIT_CRITICAL_CONDITION),
		SIGNAL_REMOVETRAIT(TRAIT_CRITICAL_CONDITION),
	), .proc/update_succumb_action)

	RegisterSignal(src, SIGNAL_ADDTRAIT(TRAIT_HANDS_BLOCKED), PROC_REF(on_handsblocked_trait_gain))

/**
 * Called when traits that alter succumbing are added/removed.
 *
 * Will show or hide the succumb alert prompt.
 */
/mob/living/proc/update_succumb_action()
	SIGNAL_HANDLER
	if (CAN_SUCCUMB(src))
		throw_alert("succumb", /atom/movable/screen/alert/succumb)
	else
		clear_alert("succumb")

/// Called when [TRAIT_HANDS_BLOCKED] is added to the mob.
/mob/living/proc/on_handsblocked_trait_gain(datum/source)
	SIGNAL_HANDLER
	drop_all_held_items()

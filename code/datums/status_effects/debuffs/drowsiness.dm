/datum/status_effect/drowsiness
	id = "drowsiness"
	tick_interval = 2 SECONDS
	alert_type = null
	remove_on_fullheal = TRUE

/datum/status_effect/drowsiness/on_creation(mob/living/new_owner, duration = 10 SECONDS)
	src.duration = duration
	return ..()

/datum/status_effect/drowsiness/on_apply()
	// Do robots dream of electric sheep?
	if(issilicon(owner))
		return FALSE

	return TRUE

/datum/status_effect/drowsiness/tick(seconds_per_tick)
	// You do not feel drowsy while unconscious
	if(owner.stat >= UNCONSCIOUS)
		return

	// Resting helps against drowsiness
	// While resting, we lose 4 seconds of duration (2 additional ticks) per tick
	if(owner.resting && remove_duration(2 * initial(tick_interval)))
		return

	owner.set_eye_blur_if_lower(4 SECONDS)
	if(prob(5))
		owner.AdjustSleeping(10 SECONDS)

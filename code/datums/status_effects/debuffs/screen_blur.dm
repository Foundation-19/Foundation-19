/// Applies a blur to the user's screen, increasing in strength depending on duration remaining.
/datum/status_effect/eye_blur
	id = "eye_blur"
	tick_interval = 1 SECONDS
	alert_type = null
	remove_on_fullheal = TRUE

/datum/status_effect/eye_blur/on_creation(mob/living/new_owner, duration = 10 SECONDS)
	src.duration = duration
	return ..()

/datum/status_effect/eye_blur/on_apply()

	// Refresh the blur when a client jumps into the mob, in case we get put on a clientless mob with no hud
	RegisterSignal(owner, COMSIG_MOB_LOGIN, PROC_REF(update_blur))
	// Apply initial blur
	update_blur()
	return TRUE

/datum/status_effect/eye_blur/on_remove()
	UnregisterSignal(owner, COMSIG_MOB_LOGIN)
	if(!owner.hud_used)
		return

	owner.clear_fullscreen("blurry")

/datum/status_effect/eye_blur/tick(seconds_per_tick, times_fired)
	// Blur lessens the closer we are to expiring, so we update per tick.
	update_blur()

/// Updates the blur of the owner of the status effect.
/// Also a signal proc for [COMSIG_MOB_LOGIN], to trigger then when the mob gets a client.
/datum/status_effect/eye_blur/proc/update_blur(datum/source)
	SIGNAL_HANDLER

	if(!owner.hud_used)
		return

	owner.set_fullscreen(TRUE, "blurry", /atom/movable/screen/fullscreen/blurry)

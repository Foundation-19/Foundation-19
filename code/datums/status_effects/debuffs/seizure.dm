/datum/status_effect/seizure
	id = "seizure"
	tick_interval = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/seizure

/datum/status_effect/seizure/on_apply()
	if(!iscarbon(owner))
		return FALSE
	var/amplitude = rand(1 SECONDS, 3 SECONDS)
	duration = amplitude
	owner.set_jitter_if_lower(100 SECONDS)
	owner.SetParalysis(duration)
	owner.visible_message(SPAN_WARNING("[owner] drops to the ground as [owner.p_they()] start seizing up."), \
	SPAN_WARNING("[pick("You can't collect your thoughts...", "You suddenly feel extremely dizzy...", "You cant think straight...","You can't move your face properly anymore...")]"))
	return TRUE

/atom/movable/screen/alert/status_effect/seizure
	name = "Seizure"
	desc = "FJOIWEHUWQEFGYUWDGHUIWHUIDWEHUIFDUWGYSXQHUIODSDBNJKVBNKDML <--- this is you right now"
	icon_state = "paralysis"

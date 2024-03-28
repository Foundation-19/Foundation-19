/datum/status_effect/good_music
	id = "Good Music"
	alert_type = null
	duration = 6 SECONDS
	tick_interval = 1 SECONDS
	status_type = STATUS_EFFECT_REFRESH

/datum/status_effect/good_music/tick()
	if(owner.can_hear())
		owner.adjust_dizzy(-4 SECONDS)
		owner.adjust_jitter(-4 SECONDS)
		owner.adjust_confusion(-1 SECONDS)
		//owner.add_mood_event("goodmusic", /datum/mood_event/goodmusic)

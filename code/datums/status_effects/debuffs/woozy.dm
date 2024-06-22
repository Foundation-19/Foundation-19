/datum/status_effect/woozy
	id = "woozy"
	tick_interval = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/woozy

/datum/status_effect/woozy/on_apply()
	. = ..()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/status_effect/woozy)
	owner.add_actionspeed_modifier(/datum/actionspeed_modifier/status_effect/woozy)

/datum/status_effect/woozy/on_remove()
	. = ..()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/status_effect/woozy)
	owner.remove_actionspeed_modifier(/datum/actionspeed_modifier/status_effect/woozy)

/atom/movable/screen/alert/status_effect/woozy
	name = "Woozy"
	desc = "You feel a bit slower than usual, it seems doing things with your hands takes longer than it usually does."
	icon_state = "woozy"

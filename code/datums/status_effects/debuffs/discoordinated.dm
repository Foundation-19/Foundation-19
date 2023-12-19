/datum/status_effect/discoordinated
	id = "discoordinated"
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/discoordinated

/atom/movable/screen/alert/status_effect/discoordinated
	name = "Discoordinated"
	desc = "You can't seem to properly use anything..."
	icon_state = "convulsing"

/datum/status_effect/discoordinated/on_apply()
	ADD_TRAIT(owner, TRAIT_DISCOORDINATED_TOOL_USER, TRAIT_STATUS_EFFECT(id))
	return ..()

/datum/status_effect/discoordinated/on_remove()
	REMOVE_TRAIT(owner, TRAIT_DISCOORDINATED_TOOL_USER, TRAIT_STATUS_EFFECT(id))
	return ..()

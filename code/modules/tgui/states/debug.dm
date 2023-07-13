GLOBAL_DATUM_INIT(debug_tgui_state, /datum/tgui_state/debug_state, new)

/datum/tgui_state/debug_state/can_use_tgui_topic(src_object, mob/user)
	if(check_rights(R_DEBUG, FALSE, user.client))
		return UI_INTERACTIVE
	return UI_CLOSE

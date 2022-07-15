/*!
 * Copyright (c) 2020 Aleksej Komarov
 * SPDX-License-Identifier: MIT
 */

/**
 * tgui state: conscious_state
 *
 * Only checks if the user is conscious.
 */

GLOBAL_DATUM_INIT(conscious_tgui_state, /datum/tgui_state/conscious_state, new)

/datum/tgui_state/conscious_state/can_use_tgui_topic(src_object, mob/user)
	if(user.stat == CONSCIOUS)
		return UI_INTERACTIVE
	return UI_CLOSE

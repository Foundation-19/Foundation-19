/*!
 * Copyright (c) 2020 Aleksej Komarov
 * SPDX-License-Identifier: MIT
 */

/**
 * tgui state: always_state
 *
 * Always grants the user UI_INTERACTIVE. Period.
 */

GLOBAL_DATUM_INIT(always_tgui_state, /datum/tgui_state/always_state, new)

/datum/tgui_state/always_state/can_use_tgui_topic(src_object, mob/user)
	return UI_INTERACTIVE

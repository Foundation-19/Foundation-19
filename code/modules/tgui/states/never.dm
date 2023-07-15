/*!
 * Copyright (c) 2021 Arm A. Hammer
 * SPDX-License-Identifier: MIT
 */

/**
 * tgui state: never_state
 *
 * Always closes the UI, no matter what. See the ui_state in religious_tool.dm to see an example
 */

GLOBAL_DATUM_INIT(never_tgui_state, /datum/tgui_state/never_state, new)

/datum/tgui_state/never_state/can_use_tgui_topic(src_object, mob/user)
	return UI_CLOSE

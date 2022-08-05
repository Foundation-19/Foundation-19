/*!
 * Copyright (c) 2020 Aleksej Komarov
 * SPDX-License-Identifier: MIT
 */

/**
 * tgui state: inventory_state
 *
 * Checks that the src_object is in the user's top-level
 * (hand, ear, pocket, belt, etc) inventory.
 */

GLOBAL_DATUM_INIT(inventory_tgui_state, /datum/tgui_state/inventory_state, new)

/datum/tgui_state/inventory_state/can_use_tgui_topic(src_object, mob/user)
	if(!(src_object in user))
		return UI_CLOSE
	return user.shared_ui_interaction(src_object)

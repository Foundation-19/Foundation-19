/*!
 * Copyright (c) 2020 Aleksej Komarov
 * SPDX-License-Identifier: MIT
 */

/**
 * tgui state: always_state
 *
 * Always grants the user UI_INTERACTIVE. Period.
 *
 * EXCEPTION: regular ghosts are look-only (UI_UPDATE). Several
 * player-facing systems (radio modules, preferences, votes, tgui_input)
 * rely on this state, and without the gate ghosts could freely toggle
 * headset channels and act on every such UI. Admin ghosts keep full
 * interaction — their admin tools rely on it.
 */

GLOBAL_DATUM_INIT(always_tgui_state, /datum/tgui_state/always_state, new)

/datum/tgui_state/always_state/can_use_tgui_topic(src_object, mob/user)
	if(isobserver(user) && !user.can_admin_interact())
		return UI_UPDATE
	return UI_INTERACTIVE

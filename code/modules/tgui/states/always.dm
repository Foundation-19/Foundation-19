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

/**
 * tgui state: input_modal_state
 *
 * UI_INTERACTIVE for everyone, ghosts included. Used by the tgui_input
 * prompt datums (alert / list / text / number): these are personal
 * windows that exist solely to collect the user's own response, so the
 * always_state ghost gate (which fixed ghost radio-channel toggling)
 * also killed every prompt for regular ghosts — orange eye, dead
 * submit/cancel.
 */
GLOBAL_DATUM_INIT(input_modal_tgui_state, /datum/tgui_state/input_modal_state, new)

/datum/tgui_state/input_modal_state/can_use_tgui_topic(src_object, mob/user)
	return UI_INTERACTIVE

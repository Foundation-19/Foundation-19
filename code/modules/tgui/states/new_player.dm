/**
 * tgui state: new_player_state
 *
 * Checks that the user is a new_player, or if user is an admin
 */

GLOBAL_DATUM_INIT(new_player_tgui_state, /datum/tgui_state/new_player_state, new)

/datum/tgui_state/new_player_state/can_use_tgui_topic(src_object, mob/user)
	if(isnewplayer(user) || check_rights(R_ADMIN, FALSE, user.client))
		return UI_INTERACTIVE
	return UI_CLOSE


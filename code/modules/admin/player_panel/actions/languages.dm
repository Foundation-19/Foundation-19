/datum/player_action/toggle_language
	action_tag = "toggle_language"
	name = "Toggle Language"
	permissions_required = R_SPAWN

/datum/player_action/toggle_language/act(client/user, mob/target, list/params)
	var/datum/language/L = all_languages[params["language_name"]]
	if(!L)
		return

	if(L in target.languages)
		if(!target.remove_language(params["language_name"]))
			to_chat(user, "Failed to remove language '[params["language_name"]]' from \the [target]!")
	else
		if(!target.add_language(params["language_name"]))
			to_chat(user, "Failed to add language '[params["language_name"]]' from \the [target]!")

	return TRUE

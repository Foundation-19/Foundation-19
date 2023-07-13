/datum/player_action/fun
	action_tag = "fun"
	name = "Fun"
	permissions_required = R_FUN

/datum/player_action/fun/narrate
	action_tag = "mob_narrate"
	name = "Narrate"

/datum/player_action/fun/narrate/act(var/client/user, var/mob/target, var/list/params)
	if(!params["to_narrate"]) return

	to_chat(target, params["to_narrate"])
	message_staff("DirectNarrate: [key_name_admin(user)] to ([key_name_admin(target)]): [params["to_narrate"]]")
	return TRUE

/datum/player_action/fun/explode
	action_tag = "mob_explode"
	name = "Explode"

/datum/player_action/fun/explode/act(var/client/user, var/mob/target, var/list/params)
	message_staff("[key_name_admin(user)] dropped a custom cell bomb on [target.name]!")
	user.cmd_admin_explosion(target)
	return TRUE

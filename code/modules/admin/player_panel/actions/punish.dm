/datum/player_action/ban
	action_tag = "mob_ban"
	name = "Ban"
	permissions_required = R_BAN

/datum/player_action/ban/act(var/client/user, var/mob/target, var/list/params)
	user.cmd_admin_do_ban(target)
	return TRUE


/datum/player_action/jobban
	action_tag = "mob_jobban"
	name = "Job-ban"
	permissions_required = R_BAN

/datum/player_action/jobban/act(var/client/user, var/mob/target, var/list/params)
	user.cmd_admin_job_ban(target)
	return TRUE

/datum/player_action/mute
	action_tag = "mob_mute"
	name = "Mute"


/datum/player_action/mute/act(var/client/user, var/mob/target, var/list/params)
	if(!target.client)
		return

	target.client.prefs.muted = text2num(params["mute_flag"])
	log_admin("[key_name(user)] set the mute flags for [key_name(target)] to [target.client.prefs.muted].")
	return TRUE

/datum/player_action/show_notes
	action_tag = "show_notes"
	name = "Show Notes"

/datum/player_action/show_notes/act(var/client/user, var/mob/target, var/list/params)
	user.holder.show_player_info(target.ckey)
	return TRUE

/datum/player_action/warn
	action_tag = "mob_warn"
	name = "Warn"

/datum/player_action/warn/act(client/user, mob/target, list/params)
	user.warn(target.ckey)
	return TRUE

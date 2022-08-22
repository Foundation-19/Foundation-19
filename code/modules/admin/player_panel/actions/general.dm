// DAMAGE
/datum/player_action/rejuvenate
	action_tag = "mob_rejuvenate"
	name = "Rejuvenate"

/datum/player_action/rejuvenate/act(var/client/user, var/mob/target, var/list/params)
	user.cmd_admin_rejuvenate(target)
	return TRUE


/datum/player_action/kill
	action_tag = "mob_kill"
	name = "Kill"

/datum/player_action/kill/act(var/client/user, var/mob/target, var/list/params)
	target.death()
	message_staff("[key_name_admin(user)] killed [key_name_admin(target)].")
	return TRUE


/datum/player_action/gib
	action_tag = "mob_gib"
	name = "Gib"
	permissions_required = R_FUN

/datum/player_action/gib/act(var/client/user, var/mob/target, var/list/params)
	target.gib("[user.key]")
	message_staff("[key_name_admin(user)] gibbed [key_name_admin(target)].")
	return TRUE

// MISC
/datum/player_action/mob_sleep
	action_tag = "mob_sleep"
	name = "Toggle Sleeping"

/datum/player_action/mob_sleep/act(var/client/user, var/mob/target, var/list/params)
	if (!params["sleep"]) //if they're already slept, set their sleep to zero and remove the icon
		target.sleeping = 0
	else
		target.sleeping = 9999999 //if they're not, sleep them and add the sleep icon, so other marines nearby know not to mess with them.

	message_staff("[key_name_admin(user)] toggled sleep on [key_name_admin(target)].")

	return TRUE


/datum/player_action/send_to_lobby
	action_tag = "send_to_lobby"
	name = "Send To Lobby"

/datum/player_action/send_to_lobby/act(var/client/user, var/mob/target, var/list/params)
	if(!isghost(target))
		to_chat(user, SPAN_NOTICE("You can only send ghost players back to the Lobby."))
		return

	if(!target.client)
		to_chat(user, SPAN_WARNING("[target.name] doesn't seem to have an active client."))
		return

	if(tgui_alert(user, "Send [key_name(target)] back to Lobby?", "Message", list("Yes", "No")) != "Yes")
		return

	message_staff("[key_name_admin(user)] has sent [key_name_admin(target)] back to the Lobby.")

	var/mob/new_player/NP = new()

	if(!target.mind)
		target.mind_initialize()

	target.mind.transfer_to(NP)

	qdel(target)
	return TRUE


/datum/player_action/force_say
	action_tag = "mob_force_say"
	name = "Force Say"
	permissions_required = R_FUN

/datum/player_action/force_say/act(var/client/user, var/mob/target, var/list/params)
	if(!params["to_say"]) return

	target.say(params["to_say"])

	message_staff("[key_name_admin(user)] forced [key_name_admin(target)] to say: [sanitize(params["to_say"])]")

	return TRUE


/datum/player_action/force_emote
	action_tag = "mob_force_emote"
	name = "Force Emote"
	permissions_required = R_FUN

/datum/player_action/force_emote/act(var/client/user, var/mob/target, var/list/params)
	if(!params["to_emote"]) return

	target.custom_emote(1, params["to_emote"], TRUE)

	message_staff("[key_name_admin(user)] forced [key_name_admin(target)] to emote: [sanitize(params["to_emote"])]")
	return TRUE

// MESSAGE
/datum/player_action/narrate_message
	action_tag = "narrate_message"
	name = "Direct Narrate"

/datum/player_action/narrate_message/act(var/client/user, var/mob/target, var/list/params)
	user.cmd_admin_direct_narrate(target)
	return TRUE


/datum/player_action/private_message
	action_tag = "private_message"
	name = "Private Message"

/datum/player_action/private_message/act(var/client/user, var/mob/target, var/list/params)
	if(!target.client)
		return

	user.cmd_admin_pm(target.client)
	return TRUE

/datum/player_action/alert_message
	action_tag = "alert_message"
	name = "Alert Message"

/datum/player_action/alert_message/act(var/client/user, var/mob/target, var/list/params)
	if(!target.client)
		return

	user.cmd_admin_alert_message(target)
	return TRUE

// SET NAME/CKEY
/datum/player_action/set_name
	action_tag = "set_name"
	name = "Set Name"

/datum/player_action/set_name/act(var/client/user, var/mob/target, var/list/params)
	if(target.name != params["name"])
		target.fully_replace_character_name(params["name"])
		message_staff("[key_name_admin(user)] set [key_name_admin(target)]'s name to [params["name"]]")
		return TRUE

/datum/player_action/set_ckey
	action_tag = "set_ckey"
	name = "Set ckey"

/datum/player_action/set_ckey/act(var/client/user, var/mob/target, var/list/params)
	if(params["ckey"] == "")
		params["ckey"] = " "

	if(QDELETED(target))
		return //mob was garbage collected

	if (target.client)
		target.ghostize(FALSE)

	message_staff("[key_name_admin(usr)] modified [key_name(target)]'s ckey to [params["ckey"]]", 1)
	target.ckey = params["ckey"]

	return TRUE

// TELEPORTATION
/datum/player_action/bring
	action_tag = "mob_bring"
	name = "Bring"


/datum/player_action/bring/act(var/client/user, var/mob/target, var/list/params)
	var/mob/M = user.mob

	target.forceMove(M.loc)
	message_staff("[key_name_admin(user)] teleported [key_name_admin(target)] to themselves.", M.loc.x, M.loc.y, M.loc.z)
	return TRUE

/datum/player_action/follow
	action_tag = "mob_follow"
	name = "Follow"

/datum/player_action/follow/act(var/client/user, var/mob/target, var/list/params)
	if(istype(user.mob, /mob/observer/ghost))
		var/mob/observer/ghost/O = user.mob
		O.follow(target)
		return TRUE
	else
		to_chat(user, SPAN_WARNING("You must be a ghost to do this."))

	return FALSE

/datum/player_action/jump_to
	action_tag = "jump_to"
	name = "Jump To"


/datum/player_action/jump_to/act(var/client/user, var/mob/target, var/list/params)
	user.jumptomob(target)
	return TRUE

/datum/player_action/send_to
	action_tag = "send_to"
	name = "Send To"

/datum/player_action/send_to/act(client/user, mob/target, list/params)
	user.sendmob(target)
	return TRUE

// VIEW VARIABLES
/datum/player_action/access_variables
	action_tag = "access_variables"
	name = "Access Variables"


/datum/player_action/access_variables/act(var/client/user, var/mob/target, var/list/params)
	user.debug_variables(target)
	return TRUE

/datum/player_action/change_perms
	action_tag = "change_perms"
	name = "Change Permissions"

/datum/player_action/change_perms/act(var/client/user, var/mob/target, var/list/params)
	if(!target.client?.holder)
		return

	user.holder.edit_admin_permissions()
	return TRUE

/datum/player_action/check_logs
	action_tag = "check_logs"
	name = "Open Logs"

/datum/player_action/check_logs/act(client/user, mob/target, list/params)
	if(!target.client)
		to_chat(user.mob, SPAN_NOTICE("You can't see logs if player is offline."))
		return

	var/list/dat = list()
	switch(params["log_type"])
		if("say")
			for(var/log in target.client.say_log)
				dat += log
				dat += "<br>"
		if("emote")
			for(var/log in target.client.emote_log)
				dat += log
				dat += "<br>"
		if("ooc")
			for(var/log in target.client.ooc_log)
				dat += log
				dat += "<br>"
		if("dsay")
			for(var/log in target.client.dsay_log)
				dat += log
				dat += "<br>"
		if("interact")
			for(var/log in target.client.interact_log)
				dat += log
				dat += "<br>"
		else
			return
	var/datum/browser/popup = new(usr, "admin_log_panel_log", "Logs", 700, 700)
	popup.set_content(JOINTEXT(dat))
	popup.open()
	return TRUE

/datum/player_action/traitor_panel
	name = "Traitor Panel"
	action_tag = "traitor_panel"

/datum/player_action/traitor_panel/act(client/user, mob/target, list/params)
	if(!user?.holder)
		return

	user.holder.show_traitor_panel(target)
	return TRUE

/datum/player_action/ban
	action_tag = "mob_ban"
	name = "Ban"
	permissions_required = R_BAN

/datum/player_action/ban/act(client/user, mob/target, list/params)
	if(target.client?.holder)
		return	//admins cannot be banned. Even if they could, the ban doesn't affect them anyway

	var/given_key = target.ckey
	if(!given_key)
		to_chat(user, SPAN_DANGER("This mob has no known last occupant and cannot be banned."))
		return

	switch(tgui_alert(user.mob, "Temporary Ban?", "Ban", list("Yes","No", "Cancel")))
		if("Yes")
			var/mins = tgui_input_number(user.mob, "How long (in minutes)", "Ban time", 1440, 525599, 0)
			if(!mins)
				return
			if(mins >= 525600)
				mins = 525599
			var/reason = tgui_input_text(user.mob, "Reason?", "Reason", "Griefer")
			if(!reason)
				return
			var/mob_key = LAST_CKEY(target)
			if(mob_key != given_key)
				to_chat(user.mob, SPAN_DANGER("This mob's occupant has changed from [given_key] to [mob_key]. Please try again."))
				return
			AddBan(mob_key, target.computer_id, reason, user.ckey, 1, mins)
			var/mins_readable = minutes_to_readable(mins)
			ban_unban_log_save("[user.ckey] has banned [mob_key]. - Reason: [reason] - This will be removed in [mins_readable].")
			notes_add(mob_key,"[user.ckey] has banned [mob_key]. - Reason: [reason] - This will be removed in [mins_readable].", user.mob)
			to_chat(target, "<span class='danger'>You have been banned by [user.ckey].\nReason: [reason].</span>")
			to_chat(target, "<span class='warning'>This is a temporary ban, it will be removed in [mins_readable].</span>")
			SSstatistics.add_field("ban_tmp",1)
			user.holder.DB_ban_record(BANTYPE_TEMP, target, mins, reason)
			SSstatistics.add_field("ban_tmp_mins",mins)
			if(config.banappeals)
				to_chat(target, "<span class='warning'>To try to resolve this matter head to [config.banappeals]</span>")
			else
				to_chat(target, "<span class='warning'>No ban appeals URL has been set.</span>")
			log_and_message_admins("has banned [mob_key].\nReason: [reason]\nThis will be removed in [mins_readable].")

			qdel(target.client)

		if("No")
			var/reason = tgui_input_text(user.mob, "Reason?", "Reason", "Griefer")
			if(!reason)
				return
			var/mob_key = LAST_CKEY(target)
			if(mob_key != given_key)
				to_chat(user.mob, SPAN_DANGER("This mob's occupant has changed from [given_key] to [mob_key]. Please try again."))
				return
			switch(tgui_alert(user.mob,"IP ban?", "Ban type", list("Yes","No","Cancel")))
				if("Yes")
					AddBan(mob_key, target.computer_id, reason, user.ckey, 0, 0, target.lastKnownIP)
				if("No")
					AddBan(mob_key, target.computer_id, reason, user.ckey, 0, 0)
				else
					return
			to_chat(target, "<span class='danger'>You have been banned by [user.ckey].\nReason: [reason].</span>")
			to_chat(target, "<span class='warning'>This is a ban until appeal.</span>")
			if(config.banappeals)
				to_chat(target, "<span class='warning'>To try to resolve this matter head to [config.banappeals]</span>")
			else
				to_chat(target, "<span class='warning'>No ban appeals URL has been set.</span>")
			ban_unban_log_save("[user.ckey] has permabanned [mob_key]. - Reason: [reason] - This is a ban until appeal.")
			notes_add(mob_key,"[user.ckey] has permabanned [mob_key]. - Reason: [reason] - This is a ban until appeal.",user.mob)
			log_and_message_admins("has banned [mob_key].\nReason: [reason]\nThis is a ban until appeal.")
			SSstatistics.add_field("ban_perma",1)
			user.holder.DB_ban_record(BANTYPE_PERMA, target, -1, reason)

			qdel(target.client)
		else
			return
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

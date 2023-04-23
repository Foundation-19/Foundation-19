//STRIKE TEAMS
//Thanks to Kilakk for the admin-button portion of this code.

var/global/send_emergency_team = 0 // Used for automagic response teams
								   // 'admin_emergency_team' for admin-spawned response teams

/client/proc/response_team()
	set name = "Dispatch Emergency Response Team"
	set category = "Special Verbs"
	set desc = "Send an emergency response team"

	if(!holder)
		to_chat(usr, SPAN_DANGER("Only administrators may use this command."))
		return
	if(GAME_STATE < RUNLEVEL_GAME)
		to_chat(usr, SPAN_DANGER("The game hasn't started yet!"))
		return
	if(send_emergency_team)
		to_chat(usr, SPAN_DANGER("[GLOB.using_map.boss_name] has already dispatched an emergency response team!"))
		return
	if(alert("Do you want to dispatch an Emergency Response Team?",,"Yes","No") != "Yes")
		return

	var/decl/security_state/security_state = decls_repository.get_decl(GLOB.using_map.security_state)
	if(security_state.current_security_level_is_lower_than(security_state.severe_security_level)) // Allow admins to reconsider if the alert level is below High
		switch(alert("Current security level lower than [security_state.severe_security_level.name]. Do you still want to dispatch a response team?",,"Yes","No"))
			if("No")
				return

	var/reason = input("What is the reason for dispatching this Emergency Response Team?", "Dispatching Emergency Response Team")

	if(!reason && alert("You did not input a reason. Continue anyway?",,"Yes", "No") != "Yes")
		return

	if(send_emergency_team)
		to_chat(usr, SPAN_DANGER("Looks like someone beat you to it!"))
		return

	if(reason)
		message_staff("[key_name_admin(usr)] is dispatching an Emergency Response Team for the reason: [reason]", 1)
	else
		message_staff("[key_name_admin(usr)] is dispatching an Emergency Response Team.", 1)

	log_admin("[key_name(usr)] used Dispatch Response Team.")
	trigger_armed_response_team(reason)

/client/verb/JoinResponseTeam()

	set name = "Join Response Team"
	set category = "IC"

	if(!MayRespawn(1))
		to_chat(usr, SPAN_WARNING("You cannot join the response team at this time."))
		return

	if(isghost(usr) || isnewplayer(usr))
		if(!send_emergency_team)
			to_chat(usr, "No emergency response team is currently being sent.")
			return
		if(jobban_isbanned(usr, MODE_ERT) || jobban_isbanned(usr, "Security Officer"))
			to_chat(usr, SPAN_DANGER("You are jobbanned from the emergency reponse team!"))
			return
		if(GLOB.ert.current_antagonists.len >= GLOB.ert.hard_cap)
			to_chat(usr, "The emergency response team is already full!")
			return
		GLOB.ert.create_default(usr)
	else
		to_chat(usr, "You need to be an observer or new player to use this.")

/proc/trigger_armed_response_team(reason = "")
	if(send_emergency_team)
		return

	command_announcement.Announce("It would appear that an emergency response team was requested for [station_name()]. We will prepare and send one as soon as possible.", "[GLOB.using_map.boss_name]")

	GLOB.ert.reason = reason //Set it even if it's blank to clear a reason from a previous ERT

	send_emergency_team = 1

	sleep(600 * 5)
	send_emergency_team = 0 // Can no longer join the ERT.

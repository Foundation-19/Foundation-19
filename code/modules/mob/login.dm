//handles setting lastKnownIP and computer_id for use by the ban systems as well as checking for multikeying
/mob/proc/update_Login_details()
	//Multikey checks and logging
	lastKnownIP	= client.address
	computer_id	= client.computer_id
	last_ckey = ckey
	log_access("Login: [key_name(src)] from [lastKnownIP ? lastKnownIP : "localhost"]-[computer_id] || BYOND v[client.byond_version]")
	if(config.log_access)
		var/is_multikeying = 0
		for(var/mob/M in GLOB.player_list)
			if(M == src)	continue
			if( M.key && (M.key != key) )
				var/matches
				if( (M.lastKnownIP == client.address) )
					matches += "IP ([client.address])"
				if( (client.connection != "web") && (M.computer_id == client.computer_id) )
					if(matches)	matches += " and "
					matches += "ID ([client.computer_id])"
					is_multikeying = 1
				if(matches)
					if(M.client)
						message_staff("[SPAN_DANGER("<B>Notice:</B>")] [SPAN_INFO("[key_name_admin(src)] [ADMIN_PM(src)] has the same [matches] as [key_name_admin(M)] [ADMIN_PM(M)].")]", 1)
						log_access("Notice: [key_name(src)] has the same [matches] as [key_name(M)].")
					else
						message_staff("[SPAN_DANGER("<B>Notice:</B>")] [SPAN_INFO("[key_name_admin(src)] [ADMIN_PM(src)] has the same [matches] as [key_name_admin(M)] (no longer logged in).")]", 1)
						log_access("Notice: [key_name(src)] has the same [matches] as [key_name(M)] (no longer logged in).")
		if(is_multikeying && !client.warned_about_multikeying)
			client.warned_about_multikeying = 1
			spawn(1 SECOND)
				to_chat(src, "<b>WARNING:</b> It would seem that you are sharing connection or computer with another player. If you haven't done so already, please contact the staff via the Adminhelp verb to resolve this situation. Failure to do so may result in administrative action. You have been warned.")

	if(config.login_export_addr)
		spawn(-1)
			var/list/params = new
			params["login"] = 1
			params["key"] = client.key
			if(isnum(client.player_age))
				params["server_age"] = client.player_age
			params["ip"] = client.address
			params["clientid"] = client.computer_id
			params["roundid"] = game_id
			params["name"] = real_name || name
			world.Export("[config.login_export_addr]?[list2params(params)]", null, 1)

/mob/proc/maybe_send_staffwarns(action)
	if(client?.staffwarn)
		for(var/client/C in GLOB.admins)
			send_staffwarn(C, action)

/mob/proc/send_staffwarn(client/C, action, noise = 1)
	if(check_rights((R_ADMIN|R_MOD),0,C))
		to_chat(C,SPAN_CLASS("staffwarn","StaffWarn: [client.ckey] [action]</span><br><span class='notice'>[client.staffwarn]"))
		if(noise && C.get_preference_value(/datum/client_preference/staff/play_adminhelp_ping) == GLOB.PREF_HEAR)
			sound_to(C, 'sound/effects/adminhelp.ogg')

/mob
	var/client/my_client // Need to keep track of this ourselves, since by the time Logout() is called the client has already been nulled

/mob/Login()

	// Add to player list if missing
	if (!list_find(GLOB.player_list, src))
		ADD_SORTED(GLOB.player_list, src, /proc/cmp_mob_key)

	update_Login_details()
	world.update_status()

	maybe_send_staffwarns("joined the round")

	client.images = null				//remove the images such as AIs being unable to see runes
	client.screen = list()				//remove hud items just in case
	InitializeHud()

	next_move = 1
	set_sight(sight|SEE_SELF)
	..()

	my_client = client

	if(loc && !isturf(loc))
		client.eye = loc
		client.perspective = EYE_PERSPECTIVE
	else
		client.eye = src
		client.perspective = MOB_PERSPECTIVE

	if(eyeobj)
		eyeobj.possess(src)

	l_plane = new()
	l_general = new()
	client.screen += l_plane
	client.screen += l_general
	client.init_verbs()

	refresh_client_images()
	reload_fullscreen() // Reload any fullscreen overlays this mob has.
	add_click_catcher()
	update_action_buttons()
	update_mouse_pointer()

/mob/living/carbon/Login()
	. = ..()
	if(internals && internal)
		internals.icon_state = "internal1"

//admin verb groups - They can overlap if you so wish. Only one of each verb will exist in the verbs list regardless
var/list/admin_verbs_default = list(
	/datum/admins/proc/show_player_panel, //shows an interface for individual players, with various links (links require additional flags), right-click player panel,
	TYPE_PROC_REF(/client, list_players),
	TYPE_PROC_REF(/client, secrets),
	TYPE_PROC_REF(/client, deadmin_self),			//destroys our own admin datum so we can play as a regular player,
	TYPE_PROC_REF(/client, hide_verbs),			//hides all our adminverbs,
	TYPE_PROC_REF(/client, hide_most_verbs),		//hides all our hideable adminverbs,
	TYPE_PROC_REF(/client, debug_variables),		//allows us to -see- the variables of any instance in the game. +VAREDIT needed to modify,
	TYPE_PROC_REF(/client, watched_variables),
	TYPE_PROC_REF(/client, debug_global_variables),//as above but for global variables,
//	TYPE_PROC_REF(/client, check_antagonists),		//shows all antags,
	TYPE_PROC_REF(/client, cmd_check_new_players),
	TYPE_PROC_REF(/client, fix_air)				// fix air in certain range,
//	TYPE_PROC_REF(/client, deadchat)				//toggles deadchat on/off,
	)
var/list/admin_verbs_admin = list(
	TYPE_PROC_REF(/client, invisimin),				//allows our mob to go invisible/visible,
//	TYPE_PROC_REF(/datum/admins, show_traitor_panel),	//interface which shows a mob's mind, -Removed due to rare practical use. Moved to debug verbs ~Errorage,
	TYPE_PROC_REF(/datum/admins, show_game_mode),  //Configuration window for the current game mode.,
	TYPE_PROC_REF(/datum/admins, force_mode_latespawn), //Force the mode to try a latespawn proc,
	TYPE_PROC_REF(/datum/admins, force_antag_latespawn), //Force a specific template to try a latespawn proc,
	TYPE_PROC_REF(/datum/admins, toggleenter),		//toggles whether people can join the current game,
	TYPE_PROC_REF(/datum/admins, toggleguests),	//toggles whether guests can join the current game,
	TYPE_PROC_REF(/datum/admins, announce),		//priority announce something to all clients.,
	TYPE_PROC_REF(/client, colorooc),				//allows us to set a custom colour for everythign we say in ooc,
	TYPE_PROC_REF(/client, admin_ghost),			//allows us to ghost/reenter body at will,
	TYPE_PROC_REF(/client, toggle_view_range),		//changes how far we can see,
	TYPE_PROC_REF(/datum/admins, view_txt_log),    //shows the server log for today,
	TYPE_PROC_REF(/client, cmd_admin_pm_context),	//right-click adminPM interface,
	TYPE_PROC_REF(/client, cmd_admin_pm_panel),	//admin-pm list,
	TYPE_PROC_REF(/client, cmd_admin_delete),		//delete an instance/object/mob/etc,
	TYPE_PROC_REF(/client, cmd_admin_check_contents),	//displays the contents of an instance,
	TYPE_PROC_REF(/datum/admins, access_news_network),	//allows access of newscasters,
	TYPE_PROC_REF(/client, jumptocoord),			//we ghost and jump to a coordinate,
	TYPE_PROC_REF(/client, getserverlog),          //allows us to fetch server logs for other days,
	TYPE_PROC_REF(/client, Getmob),				//teleports a mob to our location,
	TYPE_PROC_REF(/client, Getkey),				//teleports a mob with a certain ckey to our location,
//	TYPE_PROC_REF(/client, sendmob),				//sends a mob somewhere, -Removed due to it needing two sorting procs to work, which were executed every time an admin right-clicked. ~Errorage,
	TYPE_PROC_REF(/client, Jump),
	TYPE_PROC_REF(/client, jumptokey),				//allows us to jump to the location of a mob with a certain ckey,
	TYPE_PROC_REF(/client, jumptomob),				//allows us to jump to a specific mob,
	TYPE_PROC_REF(/client, jumptoturf),			//allows us to jump to a specific turf,
	TYPE_PROC_REF(/client, admin_call_shuttle),	//allows us to call the emergency shuttle,
	TYPE_PROC_REF(/client, admin_cancel_shuttle),	//allows us to cancel the emergency shuttle, sending it back to centcomm,
	TYPE_PROC_REF(/client, cmd_admin_narrate),
	TYPE_PROC_REF(/client, cmd_admin_direct_narrate),	//send text directly to a player with no padding. Useful for narratives and fluff-text,
	TYPE_PROC_REF(/client, cmd_admin_visible_narrate),
	TYPE_PROC_REF(/client, cmd_admin_audible_narrate),
	TYPE_PROC_REF(/client, cmd_admin_local_narrate),
	TYPE_PROC_REF(/client, cmd_admin_world_narrate),	//sends text to all players with no padding,
	TYPE_PROC_REF(/client, cmd_admin_create_centcom_report),
	TYPE_PROC_REF(/client, check_ai_laws),			//shows AI and borg laws,
	TYPE_PROC_REF(/client, rename_silicon),		//properly renames silicons,
	TYPE_PROC_REF(/client, manage_silicon_laws),	// Allows viewing and editing silicon laws. ,
	TYPE_PROC_REF(/client, check_antagonists),
	TYPE_PROC_REF(/client, admin_memo),			//admin memo system. show/delete/write. +SERVER needed to delete admin memos of others,
	TYPE_PROC_REF(/client, mentor_memo),			//Ditto but for mentors,
	TYPE_PROC_REF(/client, dsay),					//talk in deadchat using our ckey
//	TYPE_PROC_REF(/client, toggle_hear_deadcast),	//toggles whether we hear deadchat,
	TYPE_PROC_REF(/client, investigate_show),		//various admintools for investigation. Such as a singulo grief-log,
	TYPE_PROC_REF(/datum/admins, toggleooc),		//toggles ooc on/off for everyone,
	TYPE_PROC_REF(/datum/admins, toggleaooc),		//toggles aooc on/off for everyone,
	TYPE_PROC_REF(/datum/admins, togglelooc),		//toggles looc on/off for everyone,
	TYPE_PROC_REF(/datum/admins, toggleoocdead),	//toggles ooc on/off for everyone who is dead,
	TYPE_PROC_REF(/datum/admins, toggledsay),		//toggles dsay on/off for everyone,
	TYPE_PROC_REF(/datum/admins, toggletimelocks),	//toggles timelocks on jobs for the server. DOES NOT TURN OFF TIME TRACKING,
	TYPE_PROC_REF(/datum/admins, togglecrosscomms), //toggles cross-server communications,
	TYPE_PROC_REF(/client, game_panel),			//game panel, allows to change game-mode etc,
	TYPE_PROC_REF(/client, cmd_admin_say),			//admin-only ooc chat,
	TYPE_PROC_REF(/datum/admins, togglehubvisibility), //toggles visibility on the BYOND Hub,
	TYPE_PROC_REF(/datum/admins, PlayerNotes),
	TYPE_PROC_REF(/client, cmd_mentor_say),
	TYPE_PROC_REF(/datum/admins, show_player_info),
	TYPE_PROC_REF(/client, free_slot_submap),
	TYPE_PROC_REF(/client, free_slot_crew),			//frees slot for chosen job,
	TYPE_PROC_REF(/client, cmd_admin_change_custom_event),
	TYPE_PROC_REF(/client, cmd_admin_rejuvenate),
	TYPE_PROC_REF(/client, toggleghostwriters),
	TYPE_PROC_REF(/client, toggledrones),
	TYPE_PROC_REF(/datum/admins, show_skills), //Right click skill menu,
	TYPE_PROC_REF(/client, man_up),
	TYPE_PROC_REF(/client, global_man_up),
	TYPE_PROC_REF(/client, response_team), // Response Teams admin verb,
	TYPE_PROC_REF(/client, toggle_antagHUD_use),
	TYPE_PROC_REF(/client, toggle_antagHUD_restrictions),
	TYPE_PROC_REF(/client, allow_character_respawn),    // Allows a ghost to respawn ,
	TYPE_PROC_REF(/client, event_manager_panel),
	TYPE_PROC_REF(/client, empty_ai_core_toggle_latejoin),
	TYPE_PROC_REF(/client, empty_ai_core_toggle_latejoin),
	TYPE_PROC_REF(/client, aooc),
	TYPE_PROC_REF(/client, change_human_appearance_admin),	// Allows an admin to change the basic appearance of human-based mobs ,
	TYPE_PROC_REF(/client, change_human_appearance_self),	// Allows the human-based mob itself change its basic appearance ,
	TYPE_PROC_REF(/client, change_security_level),
	TYPE_PROC_REF(/client, view_chemical_reaction_logs),
	TYPE_PROC_REF(/client, makePAI),
	TYPE_PROC_REF(/client, fixatmos),
	TYPE_PROC_REF(/client, list_traders),
	TYPE_PROC_REF(/client, add_trader),
	TYPE_PROC_REF(/client, remove_trader),
	TYPE_PROC_REF(/datum/admins, sendFax),
	TYPE_PROC_REF(/client, check_fax_history),
	TYPE_PROC_REF(/client, cmd_admin_notarget)
)
var/list/admin_verbs_ban = list(
	TYPE_PROC_REF(/client, unban_panel),
	TYPE_PROC_REF(/client, jobbans),
	TYPE_PROC_REF(/client, ban_panel),
	TYPE_PROC_REF(/client, BCCM_toggle),
	TYPE_PROC_REF(/client, BCCM_WhitelistPanel)
	)
var/list/admin_verbs_sounds = list(
	TYPE_PROC_REF(/client, play_local_sound),
	TYPE_PROC_REF(/client, play_sound),
	TYPE_PROC_REF(/client, play_server_sound)
	)

var/list/admin_verbs_fun = list(
	TYPE_PROC_REF(/client, object_talk),
	TYPE_PROC_REF(/datum/admins, cmd_admin_dress),
	TYPE_PROC_REF(/client, cmd_admin_gib_self),
	TYPE_PROC_REF(/client, drop_bomb),
	TYPE_PROC_REF(/client, cinematic),
	TYPE_PROC_REF(/client, cmd_admin_add_freeform_ai_law),
	TYPE_PROC_REF(/client, toggle_random_events),
	TYPE_PROC_REF(/client, editappear),
	TYPE_PROC_REF(/client, roll_dices),
	TYPE_PROC_REF(/datum/admins, call_supply_drop),
	TYPE_PROC_REF(/datum/admins, call_drop_pod),
	TYPE_PROC_REF(/client, create_dungeon),
	TYPE_PROC_REF(/datum/admins, ai_hologram_set),
	TYPE_PROC_REF(/client, smite)
	)

var/list/admin_verbs_spawn = list(
	TYPE_PROC_REF(/datum/admins, spawn_fruit),
	TYPE_PROC_REF(/datum/admins, spawn_fluid_verb),
	TYPE_PROC_REF(/datum/admins, spawn_custom_item),
	TYPE_PROC_REF(/datum/admins, check_custom_items),
	TYPE_PROC_REF(/datum/admins, spawn_plant),
	TYPE_PROC_REF(/datum/admins, spawn_atom),		// allows us to spawn instances,
	TYPE_PROC_REF(/datum/admins, spawn_artifact),
	TYPE_PROC_REF(/datum/admins, mass_debug_closet_icons)
	)
var/list/admin_verbs_server = list(
	TYPE_PROC_REF(/datum/admins, capture_map_part),
	TYPE_PROC_REF(/datum/admins, startnow),
	TYPE_PROC_REF(/datum/admins, endnow),
	TYPE_PROC_REF(/datum/admins, restart),
	TYPE_PROC_REF(/datum/admins, delay),
	TYPE_PROC_REF(/datum/admins, toggleaban),
	TYPE_PROC_REF(/client, toggle_log_hrefs),
	TYPE_PROC_REF(/datum/admins, immreboot),
	TYPE_PROC_REF(/client, cmd_admin_delete),		// delete an instance/object/mob/etc,
	TYPE_PROC_REF(/client, cmd_debug_del_all),
	TYPE_PROC_REF(/datum/admins, adrev),
	TYPE_PROC_REF(/datum/admins, adspawn),
	TYPE_PROC_REF(/datum/admins, adjump),
	TYPE_PROC_REF(/client, toggle_random_events),
	TYPE_PROC_REF(/client, nanomapgen_DumpImage),
	TYPE_PROC_REF(/client, panicbunker),
	TYPE_PROC_REF(/client, panicbunker_ckey_bypass),
	TYPE_PROC_REF(/datum/admins, shutdown_server),
	TYPE_PROC_REF(/client, BCCM_ASNPanel)
	)
var/list/admin_verbs_debug = list(
	TYPE_PROC_REF(/datum/admins, jump_to_fluid_source),
	TYPE_PROC_REF(/datum/admins, jump_to_fluid_active),
	TYPE_PROC_REF(/client, cmd_admin_list_open_jobs),
	TYPE_PROC_REF(/client, ZASSettings),
	TYPE_PROC_REF(/client, cmd_debug_make_powernets),
	TYPE_PROC_REF(/client, debug_controller),
	TYPE_PROC_REF(/client, debug_antagonist_template),
	TYPE_PROC_REF(/client, pathfind),
	TYPE_PROC_REF(/client, cmd_debug_mob_lists),
	TYPE_PROC_REF(/client, cmd_admin_delete),
	TYPE_PROC_REF(/client, cmd_debug_del_all),
	TYPE_PROC_REF(/client, air_report),
	TYPE_PROC_REF(/client, reload_admins),
	TYPE_PROC_REF(/client, restart_controller),
	TYPE_PROC_REF(/client, print_random_map),
	TYPE_PROC_REF(/client, create_random_map),
	TYPE_PROC_REF(/client, apply_random_map),
	TYPE_PROC_REF(/client, overlay_random_map),
	TYPE_PROC_REF(/client, delete_random_map),
	TYPE_PROC_REF(/datum/admins, submerge_map),
	TYPE_PROC_REF(/datum/admins, map_template_load),
	TYPE_PROC_REF(/datum/admins, map_template_load_new_z),
	TYPE_PROC_REF(/datum/admins, map_template_upload),
	TYPE_PROC_REF(/client, enable_debug_verbs),
	TYPE_PROC_REF(/client, callproc),
	TYPE_PROC_REF(/client, callproc_target),
	TYPE_PROC_REF(/client, SDQL_query),
	TYPE_PROC_REF(/client, SDQL2_query),
	TYPE_PROC_REF(/client, Jump),
	TYPE_PROC_REF(/client, jumptomob),
	TYPE_PROC_REF(/client, jumptocoord),
	TYPE_PROC_REF(/client, dsay),
	TYPE_PROC_REF(/datum/admins, run_unit_test),
	TYPE_PROC_REF(/turf, view_chunk),
	TYPE_PROC_REF(/turf, update_chunk),
	TYPE_PROC_REF(/datum/admins, capture_map),
	TYPE_PROC_REF(/datum/admins, view_runtimes),
	TYPE_PROC_REF(/client, cmd_analyse_health_context),
	TYPE_PROC_REF(/client, cmd_analyse_health_panel),
	TYPE_PROC_REF(/client, visualpower),
	TYPE_PROC_REF(/client, visualpower_remove),
	TYPE_PROC_REF(/client, ping_webhook),
	TYPE_PROC_REF(/client, reload_webhooks),
	TYPE_PROC_REF(/client, toggle_planet_repopulating),
	TYPE_PROC_REF(/client, spawn_exoplanet)
	)

var/list/admin_verbs_paranoid_debug = list(
	TYPE_PROC_REF(/client, callproc),
	TYPE_PROC_REF(/client, callproc_target),
	TYPE_PROC_REF(/client, debug_controller)
	)

var/list/admin_verbs_possess = list(
	/proc/possess,
	/proc/release
	)
var/list/admin_verbs_permissions = list(
	TYPE_PROC_REF(/client, edit_admin_permissions)
	)
var/list/admin_verbs_rejuv = list(
	)

//verbs which can be hidden - needs work
var/list/admin_verbs_hideable = list(
	TYPE_PROC_REF(/client, deadmin_self),
//	TYPE_PROC_REF(/client, deadchat),
	TYPE_PROC_REF(/datum/admins, show_traitor_panel),
	TYPE_PROC_REF(/datum/admins, toggleenter),
	TYPE_PROC_REF(/datum/admins, toggleguests),
	TYPE_PROC_REF(/datum/admins, announce),
	TYPE_PROC_REF(/client, colorooc),
	TYPE_PROC_REF(/client, admin_ghost),
	TYPE_PROC_REF(/client, toggle_view_range),
	TYPE_PROC_REF(/datum/admins, view_txt_log),
	TYPE_PROC_REF(/client, cmd_admin_check_contents),
	TYPE_PROC_REF(/datum/admins, access_news_network),
	TYPE_PROC_REF(/client, admin_call_shuttle),
	TYPE_PROC_REF(/client, admin_cancel_shuttle),
	TYPE_PROC_REF(/client, cmd_admin_narrate),
	TYPE_PROC_REF(/client, cmd_admin_direct_narrate),
	TYPE_PROC_REF(/client, cmd_admin_visible_narrate),
	TYPE_PROC_REF(/client, cmd_admin_audible_narrate),
	TYPE_PROC_REF(/client, cmd_admin_local_narrate),
	TYPE_PROC_REF(/client, cmd_admin_world_narrate),
	TYPE_PROC_REF(/client, play_local_sound),
	TYPE_PROC_REF(/client, play_sound),
	TYPE_PROC_REF(/client, play_server_sound),
	TYPE_PROC_REF(/client, object_talk),
	TYPE_PROC_REF(/datum/admins, cmd_admin_dress),
	TYPE_PROC_REF(/client, cmd_admin_gib_self),
	TYPE_PROC_REF(/client, drop_bomb),
	TYPE_PROC_REF(/client, cinematic),
	TYPE_PROC_REF(/client, cmd_admin_add_freeform_ai_law),
	TYPE_PROC_REF(/client, cmd_admin_create_centcom_report),
	TYPE_PROC_REF(/client, toggle_random_events),
	TYPE_PROC_REF(/datum/admins, startnow),
	TYPE_PROC_REF(/datum/admins, endnow),
	TYPE_PROC_REF(/datum/admins, restart),
	TYPE_PROC_REF(/datum/admins, delay),
	TYPE_PROC_REF(/datum/admins, toggleaban),
	TYPE_PROC_REF(/client, toggle_log_hrefs),
	TYPE_PROC_REF(/datum/admins, immreboot),
	TYPE_PROC_REF(/datum/admins, adrev),
	TYPE_PROC_REF(/datum/admins, adspawn),
	TYPE_PROC_REF(/datum/admins, adjump),
	TYPE_PROC_REF(/client, restart_controller),
	TYPE_PROC_REF(/client, cmd_admin_list_open_jobs),
	TYPE_PROC_REF(/client, callproc),
	TYPE_PROC_REF(/client, callproc_target),
	TYPE_PROC_REF(/client, reload_admins),
	TYPE_PROC_REF(/client, cmd_debug_make_powernets),
	TYPE_PROC_REF(/client, debug_controller),
	TYPE_PROC_REF(/client, startSinglo),
	TYPE_PROC_REF(/client, cmd_debug_mob_lists),
	TYPE_PROC_REF(/client, cmd_debug_del_all),
	TYPE_PROC_REF(/client, air_report),
	TYPE_PROC_REF(/client, enable_debug_verbs),
	TYPE_PROC_REF(/client, roll_dices),
	/proc/possess,
	/proc/release,
	TYPE_PROC_REF(/client, cmd_admin_notarget)
	)
var/list/admin_verbs_mod = list(
	TYPE_PROC_REF(/client, cmd_admin_pm_context),	// right-click adminPM interface,
	TYPE_PROC_REF(/client, cmd_admin_pm_panel),	// admin-pm list,
	TYPE_PROC_REF(/client, debug_variables),		// allows us to -see- the variables of any instance in the game.,
	TYPE_PROC_REF(/client, watched_variables),
	TYPE_PROC_REF(/client, debug_global_variables),// as above but for global variables,
	TYPE_PROC_REF(/datum/admins, PlayerNotes),
	TYPE_PROC_REF(/client, admin_ghost),			// allows us to ghost/reenter body at will,
	TYPE_PROC_REF(/client, cmd_mentor_say),
	TYPE_PROC_REF(/datum/admins, show_player_info),
	TYPE_PROC_REF(/client, dsay),
	TYPE_PROC_REF(/datum/admins, show_skills),	// Right-click skill menu,
	TYPE_PROC_REF(/datum/admins, show_player_panel),// right-click player panel,
	TYPE_PROC_REF(/client, check_antagonists),
	TYPE_PROC_REF(/client, cmd_admin_narrate),
	TYPE_PROC_REF(/client, cmd_admin_direct_narrate),
	TYPE_PROC_REF(/client, aooc),
	TYPE_PROC_REF(/datum/admins, sendFax),
	TYPE_PROC_REF(/client, check_fax_history),
	TYPE_PROC_REF(/datum/admins, paralyze_mob), // right-click paralyze ,
	TYPE_PROC_REF(/client, cmd_admin_say),
	TYPE_PROC_REF(/client, investigate_show),
	TYPE_PROC_REF(/datum/admins, view_txt_log),
	TYPE_PROC_REF(/client, game_panel),
	TYPE_PROC_REF(/client, free_slot_crew),
	TYPE_PROC_REF(/client, cmd_admin_create_centcom_report),
	TYPE_PROC_REF(/datum/admins, DressUpMob),
)
var/list/admin_verbs_mentors = list(
	TYPE_PROC_REF(/client, cmd_mentor_say),
	TYPE_PROC_REF(/client, mentorpm_mob),
	TYPE_PROC_REF(/client, mentorpm_panel),
	TYPE_PROC_REF(/client, mentor_memo),
	TYPE_PROC_REF(/client, deadmin_self)
)

/client/proc/add_admin_verbs()
	if(holder)
		if(holder.rights && holder.rights != R_MENTOR) //If we ONLY have mentor rights then we don't deserve the default perms
			add_verb(src, admin_verbs_default)
		if(holder.rights & R_BUILDMODE)
			add_verb(src, TYPE_PROC_REF(/client, togglebuildmodeself))
		if(holder.rights & R_ADMIN)
			add_verb(src, admin_verbs_admin)
		if(holder.rights & R_BAN)
			add_verb(src, admin_verbs_ban)
		if(holder.rights & R_FUN)
			add_verb(src, admin_verbs_fun)
		if(holder.rights & R_SERVER)
			add_verb(src, admin_verbs_server)
		if(holder.rights & R_DEBUG)
			add_verb(src, admin_verbs_debug)
			if(config.debugparanoid && !(holder.rights & R_ADMIN))
				remove_verb(src, admin_verbs_paranoid_debug) //Right now it's just callproc but we can easily add others later on.
		if(holder.rights & R_POSSESS)
			add_verb(src, admin_verbs_possess)
		if(holder.rights & R_PERMISSIONS)
			add_verb(src, admin_verbs_permissions)
		if(holder.rights & R_STEALTH)
			add_verb(src, TYPE_PROC_REF(/client, stealth))
		if(holder.rights & R_REJUVINATE)
			add_verb(src, admin_verbs_rejuv)
		if(holder.rights & R_SOUNDS)
			add_verb(src, admin_verbs_sounds)
		if(holder.rights & R_SPAWN)
			add_verb(src, admin_verbs_spawn)
		if(holder.rights & R_MOD)
			add_verb(src, admin_verbs_mod)
		if(holder.rights & R_MENTOR)
			add_verb(src, admin_verbs_mentors)

/client/proc/remove_admin_verbs()
	remove_verb(src, list(
		admin_verbs_default,
		TYPE_PROC_REF(/client, togglebuildmodeself),
		admin_verbs_admin,
		admin_verbs_ban,
		admin_verbs_fun,
		admin_verbs_server,
		admin_verbs_debug,
		admin_verbs_possess,
		admin_verbs_permissions,
		TYPE_PROC_REF(/client, stealth),
		admin_verbs_rejuv,
		admin_verbs_sounds,
		admin_verbs_spawn,
		admin_verbs_mod,
		admin_verbs_mentors,
		debug_verbs,
		))

/client/proc/hide_most_verbs()//Allows you to keep some functionality while hiding some verbs
	set name = "Adminverbs - Hide Most"
	set category = "Admin"

	remove_verb(src, TYPE_PROC_REF(/client, hide_most_verbs))
	remove_verb(src, admin_verbs_hideable)
	add_verb(src, TYPE_PROC_REF(/client, show_verbs))

	to_chat(src, SPAN_CLASS("interface","Most of your adminverbs have been hidden."))
	SSstatistics.add_field_details("admin_verb","HMV") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	return

/client/proc/hide_verbs()
	set name = "Adminverbs - Hide All"
	set category = "Admin"

	remove_admin_verbs()
	add_verb(src, TYPE_PROC_REF(/client, show_verbs))

	to_chat(src, SPAN_CLASS("interface","Almost all of your adminverbs have been hidden."))
	SSstatistics.add_field_details("admin_verb","TAVVH") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	return

/client/proc/show_verbs()
	set name = "Adminverbs - Show"
	set category = "Admin"

	remove_verb(src, TYPE_PROC_REF(/client, show_verbs))
	add_admin_verbs()

	to_chat(src, SPAN_CLASS("interface","All of your adminverbs are now visible."))
	SSstatistics.add_field_details("admin_verb","TAVVS") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!





/client/proc/admin_ghost()
	set category = "Admin"
	set name = "Aghost"
	if(!check_rights(R_ADMIN|R_MOD, FALSE))	return
	if(isghost(mob))
		var/mob/observer/ghost/ghost = mob
		ghost.reenter_corpse()
		SSstatistics.add_field_details("admin_verb","P") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

	else if(istype(mob,/mob/new_player))
		to_chat(src, FONT_COLORED("red","Error: Aghost: Can't admin-ghost whilst in the lobby. Join or Observe first."))
	else
		//ghostize
		var/mob/body = mob
		var/mob/observer/ghost/ghost = body.ghostize(1)
		if (!ghost)
			to_chat(src, FONT_COLORED("red", "You are already admin-ghosted."))
			return
		ghost.client?.init_verbs()
		log_and_message_staff("has admin ghosted.", usr)
		ghost.admin_ghosted = 1
		if(body)
			body.teleop = ghost
			if(!body.key)
				body.key = "@[key]"	//Haaaaaaaack. But the people have spoken. If it breaks; blame adminbus
		SSstatistics.add_field_details("admin_verb","O") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/invisimin()
	set name = "Invisimin"
	set category = "Admin"
	set desc = "Toggles ghost-like invisibility (Don't abuse this)"
	if(check_rights(R_ADMIN|R_MOD, FALSE) && mob)
		if(mob.invisibility == INVISIBILITY_OBSERVER)
			mob.set_invisibility(initial(mob.invisibility))
			to_chat(mob, SPAN_DANGER("Invisimin off. Invisibility reset."))
			mob.alpha = max(mob.alpha + 100, 255)
		else
			mob.set_invisibility(INVISIBILITY_OBSERVER)
			to_chat(mob, SPAN_NOTICE("Invisimin on. You are now as invisible as a ghost."))
			mob.alpha = max(mob.alpha - 100, 0)

/client/proc/check_antagonists()
	set name = "Check Antagonists"
	set category = "Admin"
	if(check_rights(R_ADMIN|R_MOD, FALSE))
		holder.check_antagonists()
		log_admin("[key_name(usr)] checked antagonists.")	//for tsar~
	SSstatistics.add_field_details("admin_verb","CHA") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	return

/client/proc/jobbans()
	if(check_rights(R_BAN))
		if(config.ban_legacy_system)
			holder.Jobbans()
		else
			holder.DB_ban_panel()
	SSstatistics.add_field_details("admin_verb","VJB") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	return

/client/proc/unban_panel()
	if(check_rights(R_BAN))
		if(config.ban_legacy_system)
			holder.unbanpanel()
		else
			holder.DB_ban_panel()
	SSstatistics.add_field_details("admin_verb","UBP") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	return

/client/proc/ban_panel()
	set name = "Ban Panel"
	set category = "Admin"
	if(check_rights(R_BAN))
		if(config.ban_legacy_system)
			to_chat(usr, SPAN_NOTICE("Server is using legacy ban system, DB ban panel is unavailable."))
			return
		else
			holder.DB_ban_panel()
	SSstatistics.add_field_details("admin_verb","DBP")
	return

/client/proc/game_panel()
	set name = "Game Panel"
	set category = "Admin"
	if(check_rights(R_ADMIN|R_MOD, FALSE))
		holder.Game()
	SSstatistics.add_field_details("admin_verb","GP") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	return

/client/proc/secrets()
	set name = "Secrets"
	set category = "Admin"
	if (check_rights(R_ADMIN|R_MOD, FALSE))
		holder.Secrets()
	SSstatistics.add_field_details("admin_verb","S") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	return

/client/proc/colorooc()
	set category = "Fun"
	set name = "OOC Text Color"
	if(!check_rights(R_ADMIN|R_MOD, FALSE))	return
	var/response = alert(src, "Please choose a distinct color that is easy to read and doesn't mix with all the other chat and radio frequency colors.", "Change own OOC color", "Pick new color", "Reset to default", "Cancel")
	if(response == "Pick new color")
		prefs.ooccolor = input(src, "Please select your OOC colour.", "OOC colour") as color
	else if(response == "Reset to default")
		prefs.ooccolor = initial(prefs.ooccolor)
	SScharacter_setup.queue_preferences_save(prefs)

	SSstatistics.add_field_details("admin_verb","OC") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	return

#define MAX_WARNS 3
#define AUTOBANTIME 10

/client/proc/warn(warned_ckey)
	if(!check_rights(R_ADMIN))	return

	if(!warned_ckey || !istext(warned_ckey))	return
	if(warned_ckey in GLOB.admin_datums)
		to_chat(usr, FONT_COLORED("red","Error: warn(): You can't warn admins."))
		return

	var/datum/preferences/D
	var/client/C = GLOB.ckey_directory[warned_ckey]
	if(C)	D = C.prefs
	else	D = SScharacter_setup.preferences_datums[warned_ckey]

	if(!D)
		to_chat(src, FONT_COLORED("red","Error: warn(): No such ckey found."))
		return

	if(++D.warns >= MAX_WARNS)					//uh ohhhh...you'reee iiiiin trouuuubble O:)
		var/mins_readable = minutes_to_readable(AUTOBANTIME)
		ban_unban_log_save("[ckey] warned [warned_ckey], resulting in a [mins_readable] autoban.")
		if(C)
			message_staff("[key_name_admin(src)] has warned [key_name_admin(C)] resulting in a [mins_readable] ban.")
			to_chat(C, FONT_COLORED("red","<BIG><B>You have been autobanned due to a warning by [ckey].</B></BIG><br>This is a temporary ban, it will be removed in [mins_readable]."))
			qdel(C)
		else
			message_staff("[key_name_admin(src)] has warned [warned_ckey] resulting in a [mins_readable] ban.")
		AddBan(warned_ckey, D.last_id, "Autobanning due to too many formal warnings", ckey, 1, AUTOBANTIME)
		SSstatistics.add_field("ban_warn",1)
	else
		if(C)
			to_chat(C, FONT_COLORED("red","<BIG><B>You have been formally warned by an administrator.</B></BIG><br>Further warnings will result in an autoban."))
			message_staff("[key_name_admin(src)] has warned [key_name_admin(C)]. They have [MAX_WARNS-D.warns] strikes remaining.")
		else
			message_staff("[key_name_admin(src)] has warned [warned_ckey] (DC). They have [MAX_WARNS-D.warns] strikes remaining.")

	SSstatistics.add_field_details("admin_verb","WARN") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

#undef MAX_WARNS
#undef AUTOBANTIME

/client/proc/drop_bomb() // Some admin dickery that can probably be done better -- TLE
	set category = "Special Verbs"
	set name = "Drop Bomb"
	set desc = "Cause an explosion of varying strength at your location."
	if(!check_rights(R_FUN)) return

	var/turf/epicenter = mob.loc
	var/list/choices = list("Small Bomb", "Medium Bomb", "Big Bomb", "Custom Bomb")
	var/choice = input("What size explosion would you like to produce?") as null | anything in choices
	switch(choice)
		if (null)
			return
		if("Small Bomb")
			explosion(epicenter, 1, 2, 3, 3)
		if("Medium Bomb")
			explosion(epicenter, 2, 3, 4, 4)
		if("Big Bomb")
			explosion(epicenter, 3, 5, 7, 5)
		if("Custom Bomb")
			var/devastation_range = input("Devastation range (in tiles):") as num|null
			if (isnull(devastation_range))
				return
			var/heavy_impact_range = input("Heavy impact range (in tiles):") as num|null
			if (isnull(heavy_impact_range))
				return
			var/light_impact_range = input("Light impact range (in tiles):") as num|null
			if (isnull(light_impact_range))
				return
			var/flash_range = input("Flash range (in tiles):") as num|null
			if (isnull(flash_range))
				return
			explosion(epicenter, devastation_range, heavy_impact_range, light_impact_range, flash_range)
	log_and_message_staff("created an admin explosion at [epicenter.loc].")
	SSstatistics.add_field_details("admin_verb","DB") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/togglebuildmodeself()
	set name = "Toggle Build Mode Self"
	set category = "Special Verbs"

	if(!check_rights(R_ADMIN))
		return

	if(!usr.RemoveClickHandler(/datum/click_handler/build_mode))
		usr.PushClickHandler(/datum/click_handler/build_mode)
	SSstatistics.add_field_details("admin_verb","TBMS") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/object_talk(msg as text) // -- TLE
	set category = "Special Verbs"
	set name = "oSay"
	set desc = "Display a message to everyone who can hear the target"
	if(mob.control_object)
		if(!msg)
			return
		for (var/mob/V in hearers(mob.control_object))
			V.show_message("<b>[mob.control_object.name]</b> says: \"" + msg + "\"", 2)
	SSstatistics.add_field_details("admin_verb","OT") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/readmin_self()
	set name = "Re-Admin self"
	set category = "Admin"

	if(deadmin_holder)
		deadmin_holder.reassociate()
		log_admin("[src] re-admined themself.")
		message_staff("[src] re-admined themself.", 1)
		to_chat(src, SPAN_CLASS("interface","You now have the keys to control the planet, or at least [GLOB.using_map.full_name]."))
		remove_verb(src, TYPE_PROC_REF(/client, readmin_self))

/client/proc/deadmin_self()
	set name = "De-admin self"
	set category = "Admin"

	if(holder)
		if(alert("Confirm self-deadmin for the round? You can re-admin yourself at any time.",,"Yes","No") == "Yes")
			log_admin("[src] deadmined themself.")
			message_staff("[src] deadmined themself.", 1)
			deadmin()
			to_chat(src, SPAN_CLASS("interface","You are now a normal player."))
			add_verb(src, TYPE_PROC_REF(/client, readmin_self))
	SSstatistics.add_field_details("admin_verb","DAS") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/toggle_log_hrefs()
	set name = "Toggle href logging"
	set category = "Server"
	if(!check_rights(R_SERVER))	return
	if(config)
		if(config.log_hrefs)
			config.log_hrefs = 0
			to_chat(src, "<b>Stopped logging hrefs</b>")
		else
			config.log_hrefs = 1
			to_chat(src, "<b>Started logging hrefs</b>")

/client/proc/check_ai_laws()
	set name = "Check AI Laws"
	set category = "Admin"
	if(holder)
		src.holder.output_ai_laws()

/client/proc/rename_silicon()
	set name = "Rename Silicon"
	set category = "Admin"

	if(!check_rights(R_ADMIN)) return

	var/mob/living/silicon/S = input("Select silicon.", "Rename Silicon.") as null|anything in GLOB.silicon_mob_list
	if(!S) return

	var/new_name = sanitizeSafe(input(src, "Enter new name. Leave blank or as is to cancel.", "[S.real_name] - Enter new silicon name", S.real_name))
	if(new_name && new_name != S.real_name)
		log_and_message_staff("has renamed the silicon '[S.real_name]' to '[new_name]'")
		S.fully_replace_character_name(new_name)
	SSstatistics.add_field_details("admin_verb","RAI") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/manage_silicon_laws()
	set name = "Manage Silicon Laws"
	set category = "Admin"

	if(!check_rights(R_ADMIN)) return

	var/mob/living/silicon/S = input("Select silicon.", "Manage Silicon Laws") as null|anything in GLOB.silicon_mob_list
	if(!S) return

	var/datum/nano_module/law_manager/L = new(S)
	L.ui_interact(usr, state = GLOB.admin_state)
	log_and_message_staff("has opened [S]'s law manager.")
	SSstatistics.add_field_details("admin_verb","MSL") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/change_human_appearance_admin()
	set name = "Change Mob Appearance - Admin"
	set desc = "Allows you to change the mob appearance"
	set category = "Admin"

	if(!check_rights(R_FUN)) return

	var/mob/living/carbon/human/H = input("Select mob.", "Change Mob Appearance - Admin") as null|anything in GLOB.human_mob_list
	if(!H) return

	log_and_message_staff("is altering the appearance of [H].")
	H.change_appearance(APPEARANCE_ALL, FALSE, usr, state = GLOB.admin_state)
	SSstatistics.add_field_details("admin_verb","CHAA") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/change_human_appearance_self()
	set name = "Change Mob Appearance - Self"
	set desc = "Allows the mob to change its appearance"
	set category = "Admin"

	if(!check_rights(R_FUN)) return

	var/mob/living/carbon/human/H = input("Select mob.", "Change Mob Appearance - Self") as null|anything in GLOB.human_mob_list
	if(!H) return

	if(!H.client)
		to_chat(usr, "Only mobs with clients can alter their own appearance.")
		return

	switch(alert("Do you wish for [H] to be allowed to select non-whitelisted races?","Alter Mob Appearance","Yes","No","Cancel"))
		if("Yes")
			log_and_message_staff("has allowed [H] to change \his appearance, including races that requires whitelisting")
			H.change_appearance(APPEARANCE_COMMON, FALSE)
		if("No")
			log_and_message_staff("has allowed [H] to change \his appearance, excluding races that requires whitelisting.")
			H.change_appearance(APPEARANCE_COMMON, TRUE)
	SSstatistics.add_field_details("admin_verb","CMAS") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/change_security_level()
	set name = "Set security level"
	set desc = "Sets the security level"
	set category = "Admin"

	if(!check_rights(R_ADMIN))	return

	var/decl/security_state/security_state = decls_repository.get_decl(GLOB.using_map.security_state)

	var/decl/security_level/new_security_level = input(usr, "It's currently [security_state.current_security_level.name].", "Select Security Level")  as null|anything in (security_state.all_security_levels - security_state.current_security_level)
	if(!new_security_level)
		return

	if(alert("Switch from [security_state.current_security_level.name] to [new_security_level.name]?","Change security level?","Yes","No") == "Yes")
		security_state.set_security_level(new_security_level, TRUE)


//---- bs12 verbs ----

/client/proc/mod_panel()
	set name = "Moderator Panel"
	set category = "Admin"
/*	if(holder)
		holder.mod_panel()*/
//	SSstatistics.add_field_details("admin_verb","MP") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	return

/client/proc/editappear()
	set name = "Edit Appearance"
	set category = "Fun"

	if(!check_rights(R_FUN))	return

	var/mob/living/carbon/human/M = input("Select mob.", "Edit Appearance") as null|anything in GLOB.human_mob_list

	if(!istype(M, /mob/living/carbon/human))
		to_chat(usr, SPAN_WARNING("You can only do this to humans!"))
		return
	switch(alert("Are you sure you wish to edit this mob's appearance? Skrell, Unathi and Vox can result in unintended consequences.",,"Yes","No"))
		if("No")
			return
	var/new_facial = input("Please select facial hair color.", "Character Generation") as color
	if(new_facial)
		M.r_facial = hex2num(copytext(new_facial, 2, 4))
		M.g_facial = hex2num(copytext(new_facial, 4, 6))
		M.b_facial = hex2num(copytext(new_facial, 6, 8))

	var/new_hair = input("Please select hair color.", "Character Generation") as color
	if(new_facial)
		M.r_hair = hex2num(copytext(new_hair, 2, 4))
		M.g_hair = hex2num(copytext(new_hair, 4, 6))
		M.b_hair = hex2num(copytext(new_hair, 6, 8))

	var/new_eyes = input("Please select eye color.", "Character Generation") as color
	if(new_eyes)
		M.r_eyes = hex2num(copytext(new_eyes, 2, 4))
		M.g_eyes = hex2num(copytext(new_eyes, 4, 6))
		M.b_eyes = hex2num(copytext(new_eyes, 6, 8))
		M.update_eyes()

	var/new_skin = input("Please select body color. This is for Unathi, and Skrell only!", "Character Generation") as color
	if(new_skin)
		M.r_skin = hex2num(copytext(new_skin, 2, 4))
		M.g_skin = hex2num(copytext(new_skin, 4, 6))
		M.b_skin = hex2num(copytext(new_skin, 6, 8))

	var/new_tone = input("Please select skin tone level: 1-220 (1=albino, 35=caucasian, 150=black, 220='very' black)", "Character Generation")  as text

	if (new_tone)
		M.s_tone = max(min(round(text2num(new_tone)), 220), 1)
		M.s_tone =  -M.s_tone + 35

	// hair
	var/new_hstyle = input(usr, "Select a hair style", "Grooming")  as null|anything in GLOB.hair_styles_list
	if(new_hstyle)
		M.h_style = new_hstyle

	// facial hair
	var/new_fstyle = input(usr, "Select a facial hair style", "Grooming")  as null|anything in GLOB.facial_hair_styles_list
	if(new_fstyle)
		M.f_style = new_fstyle

	var/new_gender = alert(usr, "Please select gender.", "Character Generation", "Male", "Female", "Neuter")
	if (new_gender)
		if(new_gender == "Male")
			M.gender = MALE
		else if (new_gender == "Female")
			M.gender = FEMALE
		else
			M.gender = NEUTER

	M.update_hair()
	M.update_body()
	M.check_dna(M)

/client/proc/playernotes()
	set name = "Show Player Info"
	set category = "Admin"
	if(check_rights(R_ADMIN|R_MOD, FALSE))
		holder.PlayerNotes()
	return

/client/proc/free_slot_submap()
	set name = "Free Job Slot (Submap)"
	set category = "Admin"
	if(!check_rights(R_ADMIN|R_MOD, FALSE)) return

	var/list/jobs = list()
	for(var/thing in SSmapping.submaps)
		var/datum/submap/submap = thing
		for(var/otherthing in submap.jobs)
			var/datum/job/submap/job = submap.jobs[otherthing]
			if(!job.is_position_available())
				jobs["[job.title] - [submap.name]"] = job

	if(!LAZYLEN(jobs))
		to_chat(usr, "There are no fully staffed offsite jobs.")
		return

	var/job_name = input("Please select job slot to free", "Free job slot")  as null|anything in jobs
	if(job_name)
		var/datum/job/submap/job = jobs[job_name]
		if(istype(job) && !job.is_position_available())
			job.make_position_available()
			message_staff("An offsite job slot for [job_name] has been opened by [key_name_admin(usr)]")

/client/proc/free_slot_crew()
	set name = "Free Job Slot (Crew)"
	set category = "Admin"
	if(check_rights(R_ADMIN|R_MOD, FALSE))
		var/list/jobs = list()
		for (var/datum/job/J in SSjobs.primary_job_datums)
			if(!J.is_position_available())
				jobs[J.title] = J
		if (!jobs.len)
			to_chat(usr, "There are no fully staffed jobs.")
			return
		var/job_title = input("Please select job slot to free", "Free job slot")  as null|anything in jobs
		var/datum/job/job = jobs[job_title]
		if(job && !job.is_position_available())
			job.make_position_available()
			message_staff("A job slot for [job_title] has been opened by [key_name_admin(usr)]")
			return

/client/proc/toggleghostwriters()
	set name = "Toggle ghost writers"
	set category = "Server"
	if(!check_rights(R_ADMIN|R_MOD, FALSE))	return
	if(config)
		if(config.cult_ghostwriter)
			config.cult_ghostwriter = 0
			to_chat(src, "<b>Disallowed ghost writers.</b>")
			message_staff("Admin [key_name_admin(usr)] has disabled ghost writers.", 1)
		else
			config.cult_ghostwriter = 1
			to_chat(src, "<b>Enabled ghost writers.</b>")
			message_staff("Admin [key_name_admin(usr)] has enabled ghost writers.", 1)

/client/proc/toggledrones()
	set name = "Toggle maintenance drones"
	set category = "Server"
	if(!check_rights(R_ADMIN|R_MOD, FALSE))	return
	if(config)
		if(config.allow_drone_spawn)
			config.allow_drone_spawn = 0
			to_chat(src, "<b>Disallowed maint drones.</b>")
			message_staff("Admin [key_name_admin(usr)] has disabled maint drones.", 1)
		else
			config.allow_drone_spawn = 1
			to_chat(src, "<b>Enabled maint drones.</b>")
			message_staff("Admin [key_name_admin(usr)] has enabled maint drones.", 1)

/client/proc/man_up(mob/T as mob in SSmobs.mob_list)
	set popup_menu = FALSE
	set category = "Fun"
	set name = "Man Up"
	set desc = "Tells mob to man up and deal with it."

	if(!check_rights(R_FUN)) return

	to_chat(T, SPAN_NOTICE("<b><font size=3>Man up and deal with it.</font></b>"))
	to_chat(T, SPAN_NOTICE("Move on."))

	log_and_message_staff("told [key_name(T)] to man up and deal with it.")

/client/proc/global_man_up()
	set category = "Fun"
	set name = "Man Up Global"
	set desc = "Tells everyone to man up and deal with it."

	if(!check_rights(R_FUN)) return

	for (var/mob/T as mob in SSmobs.mob_list)
		to_chat(T, "<br><center><span class='notice'><b><font size=4>Man up.<br> Deal with it.</font></b><br>Move on.</span></center><br>")
		sound_to(T, 'sounds/voice/ManUp1.ogg')

	log_and_message_staff("told everyone to man up and deal with it.")

/client/proc/give_spell(mob/T as mob in SSmobs.mob_list) // -- Urist
	set category = "Fun"
	set name = "Give Spell"
	set desc = "Gives a spell to a mob."

	if(!check_rights(R_FUN)) return

	var/datum/spell/S = input("Choose the spell to give to that guy", "ABRAKADABRA") as null|anything in spells
	if(!S) return
	T.add_spell(new S)
	SSstatistics.add_field_details("admin_verb","GS") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	log_and_message_staff("gave [key_name(T)] the spell [S].")

// Right click panel
/datum/admins/proc/DressUpMob(mob/M as mob in GLOB.player_list)
	set category = null
	set name = "Dressup"
	set desc = "Changes outfit of a target mob. If it is a ghost - spawns their character first."

	if(!check_rights(R_SPAWN))
		return

	DressUpMobTarget(M)

/proc/DressUpMobTarget(mob/M)
	if(!check_rights(R_SPAWN))
		return

	if(!ishuman(M) && !isghost(M))
		to_chat(usr, SPAN_DANGER("This can only be used on instances of type /mob/living/carbon/human or /mob/observer/ghost"))
		return

	var/decl/hierarchy/outfit/outfit = input("Select outfit.", "Select equipment.") as null|anything in outfits()
	if(!outfit)
		return

	if(QDELETED(M) || isnull(M))
		to_chat(usr, SPAN_DANGER("The target mob has been deleted while you were choosing the outfit!"))
		return

	if(isghost(M))
		if(!M.client)
			M = new /mob/living/carbon/human(get_turf(M))
		else
			M = M.client.SpawnPrefsCharacter(get_turf(M))

	dressup_human(M, outfit, TRUE)

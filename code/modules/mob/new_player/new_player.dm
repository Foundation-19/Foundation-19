/mob/new_player
	universal_speak = TRUE
	invisibility = 101
	density = FALSE
	stat = DEAD
	movement_handlers = list()
	anchored = TRUE	//  don't get pushed around
	virtual_mob = null // Hear no evil, speak no evil

	var/ready = 0
	var/respawned_time = 0
	//Referenced when you want to delete the new_player later on in the code.
	var/spawning = 0
	///Player counts for the Lobby tab
	var/totalPlayers = 0
	var/totalPlayersReady = 0
	var/show_invalid_jobs = 0
	var/datum/new_player_panel/npp = null
	/// One-time lobby intro (title music, alert level notice) already played by deferred_login
	var/deferred_login_intro_done = FALSE
	/// The lobby menu UI has successfully opened at least once. Prevents the
	/// SScharacter_setup retry loop from force-reopening a menu the player closed.
	var/lobby_menu_opened = FALSE

/mob/new_player/Initialize()
	add_verb(src, /mob/proc/toggle_antag_pool)
	if(length(GLOB.new_player))
		forceMove(pick(GLOB.new_player))
	npp = new(src)
	return ..()

/mob/new_player/Destroy()
	QDEL_NULL(npp)
	return ..()

/mob/new_player/get_status_tab_items()
	.=..()
	if(check_rights(R_ADMIN|R_MOD, 0, src))
		. += "Game Mode: [SSticker.mode ? SSticker.mode.name : SSticker.master_mode] ([SSticker.master_mode])"
		var/extra_antags = list2params(additional_antag_types)
		. += "Added Antagonists: [extra_antags ? extra_antags : "None"]"
	else
		. += "Game Mode: [PUBLIC_GAME_MODE]"

	. += "Initial Continue Vote: [round(config.vote_autotransfer_initial / 600, 1)] minutes"
	. += "Additional Vote Every: [round(config.vote_autotransfer_interval / 600, 1)] minutes"

	if(SSticker.HasRoundStarted())
		. += "Next Continue Vote: [max(round(transfer_controller.time_till_transfer_vote() / 600, 1), 0)] minutes"
		return

	. += "Time To Start: [round(SSticker.pregame_timeleft/10)][SSticker.round_progressing ? "" : " (DELAYED)"]"
	. += "Players: [totalPlayers]"
	. += "Players Ready: [totalPlayersReady]"
	totalPlayers = 0
	totalPlayersReady = 0
	for(var/mob/new_player/player in GLOB.player_list)
		var/highjob
		if(player.client)
			var/show_ready = player.client.get_preference_value(/datum/client_preference/show_ready) == GLOB.PREF_SHOW
			if(player.client.prefs?.job_high)
				highjob = " as [player.client.prefs.job_high]"
			if(!player.is_stealthed())
				. += "[player.key] [(player.ready && show_ready) ? "Playing[highjob]" : null]"
		totalPlayers++
		if(player.ready)
			totalPlayersReady++

/mob/new_player/tgui_state(mob/user)
	return GLOB.always_tgui_state

/mob/new_player/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "LateJoin", "Choose Profession", 450, 640)
		ui.open()

/mob/new_player/tgui_data(mob/user)
	var/list/data = list()

	data["round_duration"] = DisplayTimeText(world.time - SSticker.round_start_time)
	data["station_name"] = station_name()

	if(evacuation_controller.has_evacuated())
		data["evacuation_status"] = "evacuated"
	else if(evacuation_controller.is_evacuating())
		if(evacuation_controller.emergency_evacuation)
			data["evacuation_status"] = "emergency"
		else
			data["evacuation_status"] = "transfer"

	data["show_invalid_jobs"] = show_invalid_jobs
	data["player_name"] = client.prefs.be_random_name ? "friend" : client.prefs.real_name

	var/list/categories = list()
	var/list/hidden_reasons = list()

	for(var/datum/job/job in SSjobs.primary_job_datums)
		if(!job.is_available(client) && !show_invalid_jobs)
			for(var/raisin in job.get_unavailable_reasons(client))
				hidden_reasons[raisin] = TRUE
			continue

		var/list/job_data = list()
		job_data["title"] = job.title
		job_data["available"] = job.is_available(client)
		job_data["head_position"] = job.head_position
		job_data["current_positions"] = job.current_positions
		job_data["total_positions"] = job.total_positions

		var/list/reasons = job.get_unavailable_reasons(client)
		if(length(reasons))
			job_data["unavailable_reasons"] = reasons

		var/category_key = job.department ? job.department : "No Department"
		if(!categories[category_key])
			categories[category_key] = list()
		if(job.head_position)
			var/list/cat = categories[category_key]
			cat.Insert(1, list(job_data))
		else
			categories[category_key] += list(job_data)

		if(!job.is_available(client))
			for(var/raisin in job.get_unavailable_reasons(client))
				hidden_reasons[raisin] = TRUE

	data["categories"] = categories
	data["hidden_reasons"] = hidden_reasons

	var/list/submaps = list()
	for(var/thing in SSmapping.submaps)
		var/datum/submap/submap = thing
		if(submap && submap.available())
			var/list/submap_data = list()
			submap_data["name"] = submap.name
			submap_data["descriptor"] = submap.archetype.descriptor
			var/list/submap_jobs = list()
			for(var/otherthing in submap.jobs)
				var/datum/job/job = submap.jobs[otherthing]
				if(!job.is_available(client) && !show_invalid_jobs)
					continue
				var/list/job_data = list()
				job_data["title"] = otherthing
				job_data["available"] = job.is_available(client)
				job_data["current_positions"] = job.current_positions
				job_data["total_positions"] = job.total_positions
				submap_jobs += list(job_data)
			submap_data["jobs"] = submap_jobs
			if(length(submap_jobs))
				submaps += list(submap_data)
	data["submaps"] = submaps

	return data

/mob/new_player/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(usr != src)
		return TOPIC_NOACTION
	if(!client)
		return TOPIC_NOACTION

	if(action == "SelectedJob")
		var/datum/job/job = SSjobs.get_by_title(params["SelectedJob"])

		if(!SSjobs.check_general_join_blockers(src, job))
			return FALSE

		var/datum/species/S = all_species[client.prefs.species]
		if(!check_species_allowed(S))
			return FALSE

		if(client.prefs.organ_data[BP_CHEST] == "cyborg")
			if(!whitelist_lookup(SPECIES_FBP, client.ckey) && client.prefs.species != SPECIES_IPC)
				tgui_alert(client, "You are currently not whitelisted to play as FBP.", null, list("Ok"))
				return FALSE

		var/should_warn = TRUE
		if(client.prefs.job_high == job.title)
			should_warn = FALSE
		else if(job.title in client.prefs.job_medium)
			should_warn = FALSE
		else if(job.title in client.prefs.job_low)
			should_warn = FALSE
		else if(job.is_restricted(client.prefs))
			should_warn = FALSE

		if(should_warn)
			if(tgui_alert(client, "You don't have any preferences set for [job.title]. Are you sure you want to join as it?", "Confirm Job Selection", list("Yes", "No")) != "Yes")
				return FALSE

		AttemptLateSpawn(job, client.prefs.spawnpoint)
		return TRUE

	if(action == "invalid_jobs")
		show_invalid_jobs = !show_invalid_jobs
		return TRUE

	if(!ready && action == "preference")
		if(client)
			client.prefs.process_link(src, params)
		return TRUE

/mob/new_player/proc/LateChoices()
	tgui_interact(src)

/mob/new_player/proc/AttemptLateSpawn(datum/job/job, spawning_at)
	if(src != usr)
		return FALSE
	if(GAME_STATE != RUNLEVEL_GAME)
		to_chat(usr, SPAN_WARNING("The round is either not ready, or has already finished..."))
		return FALSE
	if(!config.enter_allowed)
		to_chat(usr, SPAN_NOTICE("There is an administrative lock on entering the game!"))
		return FALSE

	if(!job || !job.is_available(client))
		tgui_alert(client, "[job.title] is not available. Please try another.", null, list("Ok"))
		return FALSE
	if(job.is_restricted(client.prefs, src))
		return

	var/datum/spawnpoint/spawnpoint = job.get_spawnpoint(client)
	var/turf/spawn_turf = pick(spawnpoint.turfs)
	if(job.latejoin_at_spawnpoints)
		var/obj/S = job.get_roundstart_spawnpoint()
		spawn_turf = get_turf(S)

	if(!SSjobs.check_unsafe_spawn(src, spawn_turf))
		return

	// Just in case someone stole our position while we were waiting for input from alert() proc
	if(!job || !job.is_available(client))
		tgui_alert(client, "[job.title] is not available. Please try another.", null, list("Ok"))
		return FALSE

	SSjobs.assign_role(src, job.title, 1)

	var/mob/living/character = create_character(spawn_turf)	//creates the human and transfers vars and mind
	if(!character)
		return FALSE

	character = SSjobs.equip_rank(character, job.title, 1)					//equips the human

	// AIs don't need a spawnpoint, they must spawn at an empty core
	if(character.mind.assigned_role == "AIC")

		character = character.AIize(move = FALSE) // AIize the character, but don't move them yet

		// is_available for AI checks that there is an empty core available in this list
		var/obj/structure/AIcore/deactivated/C = empty_playable_ai_cores[1]
		empty_playable_ai_cores -= C

		character.forceMove(C.loc)
		var/mob/living/silicon/ai/A = character
		A.on_mob_init()
		A.client.init_verbs()

		AnnounceCyborg(character, job.title, "has been downloaded to the empty core in \the [character.loc.loc]")
		SSticker.mode.handle_latejoin(character)

		qdel(C)
		qdel(src)
		return

	SSticker.mode.handle_latejoin(character)
	GLOB.universe.OnPlayerLatejoin(character)
	spawnpoint.after_join(character)
	character.client.init_verbs()
	if(job.create_record)
		if(character.mind.assigned_role != "Robot")
			character.CreateModularRecord()
			SSticker.minds += character.mind//Cyborgs and AIs handle this in the transform proc.	//TODO!!!!! ~Carn
			AnnounceArrival(character, job, spawnpoint.msg)
		else
			AnnounceCyborg(character, job, spawnpoint.msg)
	log_and_message_staff("has joined the round as [character.mind.assigned_role][character.mind.role_alt_title == character.mind.assigned_role ? "" : " ([character.mind.role_alt_title])"].", character)

	if(character.needs_wheelchair())
		equip_wheelchair(character)

	qdel(src)

/mob/new_player/proc/AnnounceCyborg(mob/living/character, rank, join_message)
	if(GAME_STATE == RUNLEVEL_GAME)
		if(character.mind.role_alt_title)
			rank = character.mind.role_alt_title
		GLOB.global_announcer.autosay("A new[rank ? " [rank]" : " visitor" ] [join_message ? join_message : "has arrived"].", "Arrivals Announcement Computer")

/mob/new_player/proc/setupcharacter()
	client.prefs.open_setup_window(src)
	return TRUE

/mob/new_player/proc/create_character(turf/spawn_turf)
	spawning = TRUE
	if(client.prefs.organ_data[BP_CHEST] == "cyborg")
		if(!whitelist_lookup(SPECIES_FBP, client.ckey) && client.prefs.species != SPECIES_IPC)
			tgui_alert(client, "You are currently not whitelisted to play as FBP.", null, list("Ok"))
			spawning = FALSE
			return
	close_spawn_windows()

	var/mob/living/carbon/human/new_character

	var/datum/species/chosen_species
	if(client.prefs.species)
		chosen_species = all_species[client.prefs.species]

	if(!spawn_turf)
		var/datum/job/job = SSjobs.get_by_title(mind.assigned_role)
		if(!job)
			job = SSjobs.get_by_title(GLOB.using_map.default_assistant_title)
		var/datum/spawnpoint/spawnpoint = job.get_spawnpoint(client, client.prefs.ranks[job.title])
		spawn_turf = pick(spawnpoint.turfs)

	if(chosen_species)
		if(!check_species_allowed(chosen_species))
			spawning = FALSE //abort
			return null
		new_character = new(spawn_turf, chosen_species.name)
		if(chosen_species.has_organ[BP_POSIBRAIN] && client && client.prefs.is_shackled)
			var/obj/item/organ/internal/posibrain/B = new_character.internal_organs_by_name[BP_POSIBRAIN]
			if(B)	B.shackle(client.prefs.get_lawset())

	if(!new_character)
		new_character = new(spawn_turf)

	new_character.lastarea = get_area(spawn_turf)

	client.prefs.copy_to(new_character)

	sound_to(src, sound(null, repeat = 0, wait = 0, volume = 85, channel = GLOB.lobby_sound_channel))// MAD JAMS cant last forever yo

	if(mind)
		mind.active = FALSE //we wish to transfer the key manually
		mind.original = new_character
		if(client.prefs.memory)
			mind.StoreMemory(client.prefs.memory)
		mind.transfer_to(new_character)					//won't transfer key since the mind is not active

	new_character.dna.ready_dna(new_character)
	new_character.dna.b_type = client.prefs.b_type
	new_character.sync_organ_dna()
	if(client.prefs.char_nearsighted)
		new_character.become_nearsighted(ROUNDSTART_TRAIT)

	// Do the initial caching of the player's body icons.
	new_character.force_update_limbs()
	new_character.update_eyes()
	new_character.regenerate_icons()

	new_character.key = key		//Manually transfer the key to log them in
	new_character.client.init_verbs()
	return new_character

/mob/new_player/proc/ViewManifest()
	var/dat = "<div align='center'>"
	dat += html_crew_manifest(OOC = 1)
	//show_browser(src, dat, "window=manifest;size=370x420;can_close=1")
	var/datum/browser/popup = new(src, "Crew Manifest", "Crew Manifest", 370, 420, src)
	popup.set_content(dat)
	popup.open()

/mob/new_player/Move()
	return FALSE

/mob/new_player/proc/close_spawn_windows()
	SStgui.close_user_uis(src)

/mob/new_player/proc/check_species_allowed(datum/species/S, show_alert = TRUE)
	if(!S.is_available_for_join() && !has_admin_rights())
		if(show_alert)
			tgui_alert(client, "Your current species, [client.prefs.species], is not available for play.", null, list("Ok"))
		return FALSE
	if(!is_alien_whitelisted(src, S))
		if(show_alert)
			tgui_alert(client, "You are currently not whitelisted to play [client.prefs.species].", null, list("Ok"))
		return FALSE
	return TRUE

/mob/new_player/get_species()
	var/datum/species/chosen_species
	if(client.prefs.species)
		chosen_species = all_species[client.prefs.species]

	if(!chosen_species || !check_species_allowed(chosen_species, 0))
		return SPECIES_HUMAN

	return chosen_species.name

/mob/new_player/get_gender()
	if(!client || !client.prefs)
		return ..()

	return client.prefs.gender

/mob/new_player/is_ready()
	return ready && ..()

/mob/new_player/hear_say(message, verb = "says", datum/language/language = null, alt_name = "",italics = 0, mob/speaker = null)
	return

/mob/new_player/hear_radio(message, verb="says", datum/language/language=null, part_a, part_b, part_c, mob/speaker = null, hard_to_hear = 0)
	return

/mob/new_player/show_message(msg, type, alt, alt_type)
	return

/mob/new_player/MayRespawn()
	return TRUE

/mob/new_player/touch_map_edge()
	return

/mob/new_player/say(message)
	sanitize_and_communicate(/decl/communication_channel/ooc, client, message)

/mob/new_player/verb/next_lobby_track()
	set name = "Play Different Lobby Track"
	set category = "OOC"

	if(get_preference_value(/datum/client_preference/play_lobby_music) == GLOB.PREF_NO)
		return
	var/decl/audio/track/track = GLOB.using_map.get_lobby_track(GLOB.using_map.lobby_track.type)
	sound_to(src, track.get_sound())
	to_chat(src, track.get_info())

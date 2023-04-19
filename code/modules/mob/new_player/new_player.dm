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

/mob/new_player/Initialize()
	add_verb(src, /mob/proc/toggle_antag_pool)
	if(length(GLOB.new_player))
		forceMove(pick(GLOB.new_player))
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

/mob/new_player/Topic(href, href_list) // This is a full override; does not call parent.
	if(usr != src)
		return TOPIC_NOACTION
	if(!client)
		return TOPIC_NOACTION

	if(href_list["SelectedJob"])
		var/datum/job/job = SSjobs.get_by_title(href_list["SelectedJob"])

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
			should_warn = FALSE // If it isn't available there will be its own message.

		if(should_warn)
			if(tgui_alert(client, "You don't have any preferences set for [job.title]. Are you sure you want to join as it?", "Confirm Job Selection", list("Yes", "No")) != "Yes")
				return FALSE

		AttemptLateSpawn(job, client.prefs.spawnpoint)
		return

	if(href_list["invalid_jobs"])
		show_invalid_jobs = !show_invalid_jobs
		LateChoices() // Update the window

	if(!ready && href_list["preference"])
		if(client)
			client.prefs.process_link(src, href_list)

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
	SScustomitems.equip_custom_items(character)

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
	log_and_message_admins("has joined the round as [character.mind.assigned_role].", character)

	if(character.needs_wheelchair())
		equip_wheelchair(character)

	qdel(src)

/mob/new_player/proc/AnnounceCyborg(mob/living/character, rank, join_message)
	if(GAME_STATE == RUNLEVEL_GAME)
		if(character.mind.role_alt_title)
			rank = character.mind.role_alt_title
		// can't use their name here, since cyborg namepicking is done post-spawn, so we'll just say "A new Cyborg has arrived"/"A new Android has arrived"/etc.
		GLOB.global_announcer.autosay("A new[rank ? " [rank]" : " visitor" ] [join_message ? join_message : "has arrived"].", "Arrivals Announcement Computer")

/mob/new_player/proc/LateChoices()
	var/name = client.prefs.be_random_name ? "friend" : client.prefs.real_name
	var/list/header = list("<html><body><center>")

	header += "<b>Welcome, [name].<br></b>"
	header += "Round Duration: [DisplayTimeText(world.time - SSticker.round_start_time)]<br>"

	if(evacuation_controller.has_evacuated())
		header += "<font color='red'><b>\The [station_name()] has been evacuated.</b></font><br>"
	else if(evacuation_controller.is_evacuating())
		if(evacuation_controller.emergency_evacuation) // Emergency shuttle is past the point of no recall
			header += "<font color='red'>\The [station_name()] is currently undergoing evacuation procedures.</font><br>"
		else                                           // Crew transfer initiated
			header += "<font color='red'>\The [station_name()] is currently undergoing crew transfer procedures.</font><br>"

	var/list/dat = list()
	dat += "Choose from the following open/valid positions:<br>"
	dat += "<a href='byond://?src=\ref[src];invalid_jobs=1'>[show_invalid_jobs ? "Hide":"Show"] unavailable jobs</a><br>"
	dat += "<table>"
	dat += "<tr><td colspan = 3><b>[GLOB.using_map.station_name]:</b></td></tr>"

	// TORCH JOBS
	var/list/job_summaries
	var/list/hidden_reasons = list()
	for(var/datum/job/job in SSjobs.primary_job_datums)
		var/summary = job.get_join_link(client, "byond://?src=\ref[src];SelectedJob=[job.title]", show_invalid_jobs)
		if(summary && summary != "")
			LAZYADD(job_summaries, summary)
		else
			for(var/raisin in job.get_unavailable_reasons(client))
				hidden_reasons[raisin] = TRUE

	if(LAZYLEN(job_summaries))
		dat += job_summaries
	else
		dat += "<tr><td>No available positions.</td></tr>"
	// END TORCH JOBS

	// SUBMAP JOBS
	for(var/thing in SSmapping.submaps)
		var/datum/submap/submap = thing
		if(submap && submap.available())
			dat += "<tr><td colspan = 3><b>[submap.name] ([submap.archetype.descriptor]):</b></td></tr>"
			job_summaries = list()
			for(var/otherthing in submap.jobs)
				var/datum/job/job = submap.jobs[otherthing]
				var/summary = job.get_join_link(client, "byond://?src=\ref[submap];joining=\ref[src];join_as=[otherthing]", show_invalid_jobs)
				if(summary && summary != "")
					LAZYADD(job_summaries, summary)
				else
					for(var/raisin in job.get_unavailable_reasons(client))
						hidden_reasons[raisin] = TRUE

			if(LAZYLEN(job_summaries))
				dat += job_summaries
			else
				dat += "No available positions."
	// END SUBMAP JOBS

	dat += "</table></center>"
	if(LAZYLEN(hidden_reasons))
		var/list/additional_dat = list("<br><b>Some roles have been hidden from this list for the following reasons:</b><br>")
		for(var/raisin in hidden_reasons)
			additional_dat += "[raisin]<br>"
		additional_dat += "<br>"
		dat = additional_dat + dat
	dat = header + dat
	var/datum/browser/popup = new(src, "latechoices", "Choose Profession", 450, 640)
	popup.set_content(jointext(dat, null))
	popup.open(0)

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
	if(client.prefs.disabilities)
		// Set defer to 1 if you add more crap here so it only recalculates struc_enzymes once. - N3X
		new_character.dna.SetSEState(GLOB.GLASSESBLOCK,1,0)
		new_character.disabilities |= NEARSIGHTED

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
	close_browser(src, "window=latechoices") //closes late choices window

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

SUBSYSTEM_DEF(character_setup)
	name = "Character Setup"
	init_order = SS_INIT_CHAR_SETUP
	priority = SS_PRIORITY_CHAR_SETUP
	flags = SS_BACKGROUND
	wait = 1 SECOND
	runlevels = RUNLEVEL_LOBBY | RUNLEVELS_DEFAULT

	var/list/prefs_awaiting_setup = list()
	var/list/preferences_datums = list()
	var/list/newplayers_requiring_init = list()

	var/list/save_queue = list()

/datum/controller/subsystem/character_setup/Initialize()
	while(prefs_awaiting_setup.len)
		var/datum/preferences/prefs = prefs_awaiting_setup[prefs_awaiting_setup.len]
		prefs_awaiting_setup.len--
		prefs.setup()
	// Do NOT flush newplayers_requiring_init here. Clients that connected
	// during world startup re-login mid-initialization; a deferred_login
	// issued now lands on a client whose browse channel isn't live yet and
	// is silently dropped, and consuming the queue entry here would leave
	// them with no lobby and no retries. Leave them queued — fire() (once
	// the MC starts ticking) retries until their LobbyMenu window is live.
	. = ..()

/datum/controller/subsystem/character_setup/fire(resumed = FALSE)
	// Retry deferred logins for clients that connected during world startup
	// (e.g. users who stayed connected through a server restart). Their
	// deferred_login can silently fail while the client handshake is still
	// settling, leaving them stuck at a black lobby with no menu.
	//
	// A player stays queued until they have a live LobbyMenu window (or until
	// they leave the lobby entirely) — a single popped retry is not enough:
	// both the immediate attempt and one retry can land mid-handshake.
	if(length(newplayers_requiring_init))
		for(var/mob/new_player/new_player in newplayers_requiring_init.Copy())
			if(QDELETED(new_player) || !new_player.client)
				newplayers_requiring_init -= new_player
				continue
			// They're in the game now — no lobby to open.
			if(new_player.spawning)
				newplayers_requiring_init -= new_player
				continue
			var/has_lobby = FALSE
			for(var/datum/tgui/ui in new_player.tgui_open_uis)
				if(ui.src_object == new_player.npp)
					has_lobby = TRUE
					break
			if(has_lobby)
				// Lobby is up; also handle round-start (menu switches tabs).
				newplayers_requiring_init -= new_player
				continue
			// No live lobby window yet: (re)attempt the login.
			new_player.deferred_login()
			// Leave them queued; next tick retries until the window lives.

	while(save_queue.len)
		var/datum/preferences/prefs = save_queue[save_queue.len]
		save_queue.len--

		if(!QDELETED(prefs))
			prefs.save_preferences()

		if(MC_TICK_CHECK)
			return

/datum/controller/subsystem/character_setup/proc/queue_preferences_save(datum/preferences/prefs)
	save_queue |= prefs

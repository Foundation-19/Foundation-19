SUBSYSTEM_DEF(character_setup)
	name = "Character Setup"
	init_order = SS_INIT_CHAR_SETUP
	priority = SS_PRIORITY_CHAR_SETUP
	flags = SS_BACKGROUND
	wait = 1 SECOND
	runlevels = RUNLEVEL_LOBBY | RUNLEVELS_DEFAULT

	var/list/prefs_awaiting_setup = list()
	var/list/jobtime_awaiting_setup = list()
	var/list/preferences_datums = list()
	var/list/jobtime_datums = list()
	var/list/newplayers_requiring_init = list()

	var/list/save_queue_pref = list()
	var/list/save_queue_jobtime = list()

/datum/controller/subsystem/character_setup/Initialize()
	while(prefs_awaiting_setup.len)
		var/datum/preferences/prefs = prefs_awaiting_setup[prefs_awaiting_setup.len]
		prefs_awaiting_setup.len--
		prefs.setup()
	while(jobtime_awaiting_setup.len)
		var/datum/jobtime/jobtimes = jobtime_awaiting_setup[jobtime_awaiting_setup.len]
		jobtime_awaiting_setup.len--
		jobtimes.setup()
	while(newplayers_requiring_init.len)
		var/mob/new_player/new_player = newplayers_requiring_init[newplayers_requiring_init.len]
		newplayers_requiring_init.len--
		new_player.deferred_login()
	. = ..()

/datum/controller/subsystem/character_setup/fire(resumed = FALSE)
	while(save_queue_pref.len)
		var/datum/preferences/prefs = save_queue_pref[save_queue_pref.len]
		save_queue_pref.len--

		if(!QDELETED(prefs))
			prefs.save_preferences()

		if(MC_TICK_CHECK)
			return
	while(save_queue_jobtime.len)
		var/datum/jobtime/jobtimes = save_queue_jobtime[save_queue_jobtime.len]
		save_queue_jobtime.len--

		if(!QDELETED(jobtimes))
			jobtimes.save_job_time()

		if(MC_TICK_CHECK)
			return

/datum/controller/subsystem/character_setup/proc/queue_preferences_save(datum/preferences/prefs)
	save_queue_pref |= prefs

/datum/controller/subsystem/character_setup/proc/queue_jobtime_save(datum/jobtime/jobtimes)
	save_queue_jobtime |= jobtimes

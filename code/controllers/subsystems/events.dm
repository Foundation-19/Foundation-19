SUBSYSTEM_DEF(events)
	name = "Events"
	priority = SS_PRIORITY_EVENTS
	init_order = SS_INIT_EVENTS
	flags = SS_NO_INIT|SS_BACKGROUND
	runlevels = RUNLEVEL_GAME
	wait = 2 SECONDS

/datum/controller/subsystem/events/fire()
	for(var/last_object in GLOB.event_manager.active_events)
		var/datum/event/E = last_object
		E.process()
		CHECK_TICK

	for(var/i = EVENT_LEVEL_MUNDANE to EVENT_LEVEL_MAJOR)
		var/list/datum/event_container/EC = GLOB.event_manager.event_containers[i]
		EC.process()
		CHECK_TICK
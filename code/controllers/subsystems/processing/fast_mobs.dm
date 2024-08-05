PROCESSING_SUBSYSTEM_DEF(fast_mobs)
	name = "Fast mobs"
	priority = SS_PRIORITY_FAST_MOB
	flags = SS_KEEP_TIMING|SS_NO_INIT
	runlevels = RUNLEVEL_GAME|RUNLEVEL_POSTGAME
	wait = 0.4 SECONDS

	process_proc = TYPE_PROC_REF(/mob, Life)

	var/list/mob_list

/datum/controller/subsystem/processing/fast_mobs/PreInit()
	mob_list = processing // Simply setups a more recognizable var name than "processing"

/var/global/spacevines_spawned = 0

/datum/event/spacevine
	announceWhen	= 60

/datum/event/spacevine/start()
	spacevine_infestation()
	spacevines_spawned = 1

/datum/event/spacevine/announce()
	GLOB.using_map.level_x_biohazard_announcement(7)

/var/global/spacevines_spawned = 0

/datum/event/spacevine

/datum/event/spacevine/start()
	announceWhen = rand(60, 120)
	spacevine_infestation()
	spacevines_spawned++

/datum/event/spacevine/announce()
	GLOB.using_map.level_x_biohazard_announcement(rand(6,8))

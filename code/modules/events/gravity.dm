/datum/event/gravity
	announceWhen = 5
	var/list/gravity_status = list()

/datum/event/gravity/setup()
	endWhen = rand(15, 60)

/datum/event/gravity/announce()
	command_announcement.Announce("Containment breach of object class Euclid detected. Recontainment procedures initiated.", "Containment Failure", zlevels = affecting_z)

/datum/event/gravity/start()
	for (var/area/A in world)
		if (A.has_gravity() && (A.z in affecting_z))
			gravity_status += A
			A.gravitychange(TRUE)

/datum/event/gravity/end()
	for (var/area/A in gravity_status)
		if (!A.has_gravity() && (A.z in affecting_z))
			A.gravitychange(TRUE)
	gravity_status.Cut()
	command_announcement.Announce("Object recontained. Amnestics available upon request.", "Object Contained", zlevels = affecting_z)

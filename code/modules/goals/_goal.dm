/datum/goal
	abstract_type = /datum/goal
	var/datum/component/goalcontainer/container	// the goal component we're held in
	var/description
	var/no_duplicates = 1	// whether we can have several of this type of goal
	var/completed = GOAL_UNFINISHED

/datum/goal/New(_container)
	container = _container
	return ..()

/datum/goal/Destroy()
	container = null
	return ..()

/datum/goal/proc/is_valid()	// return false if the goal is not mechanically possible or unsafe balance-wise
	return TRUE

/datum/goal/proc/goal_finish(success = TRUE)	// if we fail/succeed the goal
	if(completed != GOAL_UNFINISHED)	// already finished, return
		return

	if(success)
		completed = GOAL_SUCCEEDED
		SEND_SIGNAL(src, COMSIG_GOAL_SUCCEEDED)
	else
		completed = GOAL_FAILED
		SEND_SIGNAL(src, COMSIG_GOAL_FAILED)

	finish_behaviour(success)

/datum/goal/proc/finish_behaviour(success = TRUE)	// base proc thats overridden for custom reward/punishment behaviour
	return

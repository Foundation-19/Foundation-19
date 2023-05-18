/datum/goal
	abstract_type = /datum/goal
	var/datum/component/goalcontainer/container	// the goal component we're held in
	var/list/rewards = list()	// all the rewards that we have
	var/description
	var/success_description	// what description we use in the goal history
	var/success_message		// message is sent to the mob on completion
	var/failure_description	// ditto, but for failure
	var/failure_message
	var/no_duplicates = 1	// whether we can have several of this type of goal
	var/completed = GOAL_STAT_UNFINISHED

/datum/goal/New(_container)
	container = _container
	RegisterSignal(container, COMSIG_PARENT_QDELETING, /datum/proc/qdel_self)
	return ..()

/datum/goal/Destroy()
	container = null
	return ..()

/datum/goal/proc/is_valid()	// is the goal mechanically viable?
	return TRUE

/datum/goal/proc/is_autofill_reward_valid()	// is the reward we autofill in valid?
	return TRUE

/datum/goal/proc/autofill_rewards()	// override to create the "default" rewards, if desired
	return FALSE

/datum/goal/proc/goal_finish(success = TRUE)	// if we fail/succeed the goal
	if(completed != GOAL_STAT_UNFINISHED)	// already finished, return
		return

	var/datum/mind/M = container.parent
	if(success)
		completed = GOAL_STAT_SUCCEEDED
		SEND_SIGNAL(src, COMSIG_GOAL_SUCCEEDED)	// reward hooks itself onto these signals when its created
		to_chat(M.current, success_message)
	else
		completed = GOAL_STAT_FAILED
		SEND_SIGNAL(src, COMSIG_GOAL_FAILED)
		to_chat(M.current, failure_message)

	container.recalculate_goals()

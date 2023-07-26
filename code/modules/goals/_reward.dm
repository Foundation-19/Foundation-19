/datum/reward	// also covers punishment for failing a goal
	abstract_type = /datum/reward
	var/datum/goal/attached_goal	// reference to the goal we're attached to
	var/on_success		// TRUE if we're called on success, FALSE if we're called on failure
	var/description = "You shouldn't be seeing this; tell a coder that the reward system is bugged."

/datum/reward/New(datum/goal/_goal, reward_success = TRUE)	// reward_success denotes whether we're activating on goal completion or failure
	if(isnull(_goal))	// someone goofed somewhere
		log_and_message_staff("Warning: Reward of type [src.type] instantiated without a goal.")
		return FALSE

	attached_goal = _goal

	on_success = reward_success
	RegisterSignal(attached_goal, COMSIG_PARENT_QDELETING, /datum/proc/qdel_self)
	if(reward_success)
		RegisterSignal(attached_goal, COMSIG_GOAL_SUCCEEDED, .proc/handle_behavior)
	else
		RegisterSignal(attached_goal, COMSIG_GOAL_FAILED, .proc/handle_behavior)

/datum/reward/proc/handle_behavior()	// rewards override this, container is so the reward can grab the mob
	log_and_message_staff("Warning: Reward of type [src.type] called default handle_behaviour().")
	return FALSE

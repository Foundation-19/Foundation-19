/datum/goal/personal
	abstract_type = /datum/goal/personal

// TEMPORARY LOCATION, REMEMBER TO MOVE
/datum/goal/personal/weights
	description = "Lift some weights at the weightlifting machine.<br>Reward: Increased hand-to-hand combat skill for 30 minutes."
	var/reps = 0
	var/rep_goal

/datum/goal/personal/weights/Initialize()
	RegisterSignal(container.parent, COMSIG_HUMAN_LIFT_WEIGHT, ./proc/handle_progress)
	return ..()

/datum/goal/personal/weights/New()
	need_reps = rand(10,40)
	return ..()

/datum/goal/personal/weights/is_valid()
	return !container.parent.current.skill_check(SKILL_COMBAT, SKILL_TRAINED)

/datum/goal/personal/weights/proc/handle_progress()
	reps++
	if(reps >= rep_goal)
		goal_finish(TRUE)

/datum/goal/personal/weights/finish_behaviour(success = TRUE)
	container.parent.current.buff_skill(list(SKILL_COMBAT = SKILL_TRAINED), 30 MINUTES)

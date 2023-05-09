/datum/goal/skills
	abstract_type = /datum/goal/skills

/datum/goal/skills/weights
	description = "Lift some weights at the weightlifting machine.<br>Reward: Increased hand-to-hand combat skill for 30 minutes."
	var/reps = 0
	var/rep_goal

/datum/goal/skills/weights/Initialize()
	RegisterSignal(container.parent, COMSIG_HUMAN_LIFT_WEIGHT, ./proc/handle_progress)
	return ..()

/datum/goal/skills/weights/New()
	need_reps = rand(10,40)
	return ..()

/datum/goal/skills/weights/is_valid()
	return !container.parent.current.skill_check(SKILL_COMBAT, SKILL_TRAINED)

/datum/goal/skills/weights/proc/handle_progress()
	reps++
	if(reps >= rep_goal)
		goal_finish(TRUE)

/datum/goal/skills/weights/finish_behaviour(success = TRUE)
	container.parent.current.buff_skill(list(SKILL_COMBAT = SKILL_TRAINED), 30 MINUTES)

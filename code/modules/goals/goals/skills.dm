// goals that generally require you to do a skill-specific task in exchange for temporarily buffing that skill

/datum/goal/skills
	abstract_type = /datum/goal/skills
	var/default_buff_skill = null
	var/default_buff_level = null	// default values for the skill reward (if autofilled)
	var/default_buff_timer = null

/datum/goal/skills/is_autofill_reward_valid()
	var/datum/mind/MI = container.parent
	var/mob/M = MI.current
	return !M.skill_check(default_buff_skill, default_buff_level)

/datum/goal/skills/autofill_rewards()
	var/datum/reward/skills/R = new(_goal = src, reward_success = TRUE, _buff_skill = default_buff_skill, _buff_level = default_buff_level, _buff_timer = default_buff_timer)
	rewards += R

/datum/goal/skills/weights
	default_buff_skill = SKILL_COMBAT
	default_buff_level = SKILL_TRAINED
	default_buff_timer = 30 MINUTES
	success_message = "Getting FIT!"
	var/reps = 0
	var/rep_goal

/datum/goal/skills/weights/New()
	rep_goal = rand(10,40)
	description = "Lift some weights at the weightlifting machine. Do [rep_goal] reps!"
	success_description = "Lifted weights [rep_goal] times."
	. = ..()
	var/datum/mind/M = container.parent
	RegisterSignal(M.current, COMSIG_HUMAN_LIFT_WEIGHT, .proc/handle_progress)

/datum/goal/skills/weights/proc/handle_progress()
	reps++
	if(reps >= rep_goal)
		var/datum/mind/M = container.parent
		UnregisterSignal(M.current, COMSIG_HUMAN_LIFT_WEIGHT)
		goal_finish(TRUE)

/datum/goal/skills/walk
	default_buff_skill = SKILL_HAULING
	default_buff_level = SKILL_TRAINED
	default_buff_timer = 45 MINUTES
	success_message = "It sure feels good to stretch your legs."
	var/steps
	var/step_goal

/datum/goal/skills/walk/New()
	step_goal = rand(2500,3500)
	description = "Go for a nice walk; at least [step_goal] steps."
	success_description = "Walked for [step_goal] steps."
	. = ..()
	var/datum/mind/M = container.parent
	RegisterSignal(M.current, COMSIG_ATOM_MOVABLE_MOVED, .proc/handle_progress)

/datum/goal/skills/walk/proc/handle_progress()
	steps++
	if(steps >= step_goal)
		var/datum/mind/M = container.parent
		UnregisterSignal(M.current, COMSIG_HUMAN_LIFT_WEIGHT)
		goal_finish(TRUE)

/datum/goal/skills/email
	default_buff_skill = SKILL_COMPUTER
	default_buff_level = SKILL_TRAINED
	default_buff_timer = 20 MINUTES
	success_message = "Hopefully you'll get one in return."
	description = "Send someone an email."
	success_description = "Sent an email."

/datum/goal/skills/email/New()
	. = ..()
	var/datum/mind/M = container.parent
	RegisterSignal(M.current, COMSIG_SENT_EMAIL, .proc/handle_progress)

/datum/goal/skills/email/proc/handle_progress()
	var/datum/mind/M = container.parent
	UnregisterSignal(M.current, COMSIG_SENT_EMAIL)
	goal_finish(TRUE)

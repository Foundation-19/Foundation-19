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

// General

/datum/goal/skills/walk
	default_buff_skill = SKILL_HAULING
	default_buff_level = SKILL_TRAINED
	default_buff_timer = 45 MINUTES
	success_message = "It sure feels good to stretch your legs."
	var/steps
	var/step_goal

/datum/goal/skills/walk/New()
	step_goal = rand(2000,3000)
	description = "Go for a nice walk; at least [step_goal] steps."
	success_description = "Walked for [step_goal] steps."
	. = ..()
	var/datum/mind/M = container.parent
	RegisterSignal(M.current, COMSIG_MOVED, PROC_REF(handle_progress))

/datum/goal/skills/walk/proc/handle_progress()
	steps++
	if(steps >= step_goal)
		var/datum/mind/M = container.parent
		UnregisterSignal(M.current, COMSIG_MOVED)
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
	RegisterSignal(M.current, COMSIG_SENT_EMAIL, PROC_REF(handle_progress))

/datum/goal/skills/email/proc/handle_progress()
	var/datum/mind/M = container.parent
	UnregisterSignal(M.current, COMSIG_SENT_EMAIL)
	goal_finish(TRUE)

/datum/goal/skills/deposit
	default_buff_skill = SKILL_FINANCE
	default_buff_level = SKILL_TRAINED
	default_buff_timer = 15 MINUTES
	success_message = "A dollar saved is a dollar earned!"
	description = "Deposit money into your bank account."
	success_description = "Deposited money into bank account."

/datum/goal/skills/deposit/New()
	. = ..()
	var/datum/mind/M = container.parent
	RegisterSignal(M.initial_account, COMSIG_MONEY_DEPOSITED, PROC_REF(handle_progress))

/datum/goal/skills/deposit/proc/handle_progress()
	var/datum/mind/M = container.parent
	UnregisterSignal(M.initial_account, COMSIG_MONEY_DEPOSITED)
	goal_finish(TRUE)

// Service

/datum/goal/skills/butcher
	default_buff_skill = SKILL_COOKING
	default_buff_level = SKILL_EXPERIENCED
	default_buff_timer = 30 MINUTES
	success_message = "Cleaned and gutted."
	description = "Butcher something."
	success_description = "Butchered something."

/datum/goal/skills/butcher/New()
	. = ..()
	var/datum/mind/M = container.parent
	RegisterSignal(M.initial_account, COMSIG_BUTCHERED, PROC_REF(handle_progress))

/datum/goal/skills/butcher/proc/handle_progress()
	var/datum/mind/M = container.parent
	UnregisterSignal(M.initial_account, COMSIG_BUTCHERED)
	goal_finish(TRUE)

// Security

/datum/goal/skills/weights
	default_buff_skill = SKILL_COMBAT
	default_buff_level = SKILL_TRAINED
	default_buff_timer = 30 MINUTES
	success_message = "Getting FIT!"
	var/reps = 0
	var/rep_goal

/datum/goal/skills/weights/New()
	rep_goal = rand(5,15)
	description = "Lift some weights at the weightlifting machine. Do [rep_goal] reps!"
	success_description = "Lifted weights [rep_goal] times."
	. = ..()
	var/datum/mind/M = container.parent
	RegisterSignal(M.current, COMSIG_HUMAN_LIFT_WEIGHT, PROC_REF(handle_progress))

/datum/goal/skills/weights/proc/handle_progress()
	reps++
	if(reps >= rep_goal)
		var/datum/mind/M = container.parent
		UnregisterSignal(M.current, COMSIG_HUMAN_LIFT_WEIGHT)
		goal_finish(TRUE)

/datum/goal/skills/evidence_bagging
	default_buff_skill = SKILL_FORENSICS
	default_buff_level = SKILL_TRAINED
	default_buff_timer = 30 MINUTES
	success_message = "Good work, detective."
	description = "Bag some evidence."
	success_description = "Bagged evidence."

/datum/goal/skills/evidence_bagging/New()
	. = ..()
	var/datum/mind/M = container.parent
	RegisterSignal(M.current, COMSIG_BAGGED_EVIDENCE, PROC_REF(handle_progress))

/datum/goal/skills/evidence_bagging/proc/handle_progress()
	var/datum/mind/M = container.parent
	UnregisterSignal(M.current, COMSIG_BAGGED_EVIDENCE)
	goal_finish(TRUE)

// Engineering

/datum/goal/skills/construct_recipe
	default_buff_skill = SKILL_CONSTRUCTION
	default_buff_level = SKILL_TRAINED
	default_buff_timer = 20 MINUTES
	success_message = "DIY!"
	description = "Construct something."
	success_description = "Constructed something."

/datum/goal/skills/construct_recipe/New()
	. = ..()
	var/datum/mind/M = container.parent
	RegisterSignal(M.current, COMSIG_PRODUCED_RECIPE, PROC_REF(handle_progress))

/datum/goal/skills/construct_recipe/proc/handle_progress()
	var/datum/mind/M = container.parent
	UnregisterSignal(M.current, COMSIG_PRODUCED_RECIPE)
	goal_finish(TRUE)

/datum/goal/skills/cut_wires
	default_buff_skill = SKILL_ELECTRICAL
	default_buff_level = SKILL_TRAINED
	default_buff_timer = 20 MINUTES
	success_message = "Sometimes it's necessary to break into things."
	description = "Cut a wire."
	success_description = "Cut a wire."

/datum/goal/skills/cut_wires/New()
	. = ..()
	var/datum/mind/M = container.parent
	RegisterSignal(M.current, COMSIG_CUT_WIRE, PROC_REF(handle_progress))

/datum/goal/skills/cut_wires/proc/handle_progress()
	var/datum/mind/M = container.parent
	UnregisterSignal(M.current, COMSIG_CUT_WIRE)
	goal_finish(TRUE)

// Research

// Medical

/datum/goal/skills/check_pulse
	default_buff_skill = SKILL_MEDICAL
	default_buff_level = SKILL_BASIC
	default_buff_timer = 15 MINUTES
	success_message = "It's important to check up on people's health."
	description = "Manually check someone's pulse."
	success_description = "Checked someone's pulse."

/datum/goal/skills/check_pulse/New()
	. = ..()
	var/datum/mind/M = container.parent
	RegisterSignal(M.current, COMSIG_CHECKED_PULSE, PROC_REF(handle_progress))

/datum/goal/skills/check_pulse/proc/handle_progress()
	var/datum/mind/M = container.parent
	UnregisterSignal(M.current, COMSIG_CHECKED_PULSE)
	goal_finish(TRUE)

/datum/goal/skills/grinding
	default_buff_skill = SKILL_CHEMISTRY
	default_buff_level = SKILL_TRAINED
	default_buff_timer = 30 MINUTES
	success_message = "Chemistry is fun!"
	description = "Grind something up in a reagent grinder."
	success_description = "Ground something up."

/datum/goal/skills/grinding/New()
	. = ..()
	var/datum/mind/M = container.parent
	RegisterSignal(M.current, COMSIG_GRINDING, PROC_REF(handle_progress))

/datum/goal/skills/grinding/proc/handle_progress()
	var/datum/mind/M = container.parent
	UnregisterSignal(M.current, COMSIG_GRINDING)
	goal_finish(TRUE)

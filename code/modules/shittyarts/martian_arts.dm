/mob/living/carbon/human
	var/datum/martial_art/martial_art

//Nanite ones will be vunerable to EMP, non-nanite still can be injected but will be EMP-proof in cost of efficiency

/datum/martial_art
	var/name = "Martial Art"
	var/id = ""

	var/desc = ""

	//COMBO SYSTEM

	var/streak = ""
	var/max_streak_length = 5
	var/current_target

	//COMBAT MODIFIERS

	var/block_modifier = 1 //20% if 1.
	var/additional_hit_damage = 0 //Will be used for pain attacks
	var/additional_hit_type = PAIN //Or toxin one if it will be nanite-based martial art
	var/speedboost = 0

	//SPECIAL POWERS !!!DO NOT USE IN USUAL COMBAT STYLES!!!

	var/ignor_psishields = 0 //Can user attack psionics?
	var/reflect_prob = 0 //Probability of user dodging projectiles. If 0 wont work
	var/noshooting = 0 //If 1, user cant shoot guns

/datum/martial_art/proc/add_to_streak(var/mob/living/carbon/human/owner, var/intent, var/mob/living/carbon/human/D)
	if(D != current_target)
		streak = ""
		current_target = D
	streak = streak + intent
	if(length(streak) > max_streak_length)
		streak = copytext(streak, 1 + length(streak[1]))

	//if(handle_streak(owner, D))
		//streak = ""

/datum/martial_art/proc/handle_help(var/mob/living/carbon/human/owner, var/mob/living/carbon/human/victim)
	if(handle_streak(owner, victim))
		streak = ""
		return TRUE
	return FALSE

/datum/martial_art/proc/handle_disarm(var/mob/living/carbon/human/owner, var/mob/living/carbon/human/victim)
	if(handle_streak(owner, victim))
		streak = ""
		return TRUE
	return FALSE

/datum/martial_art/proc/handle_harm(var/mob/living/carbon/human/owner, var/mob/living/carbon/human/victim)
	if(handle_streak(owner, victim))
		streak = ""
		return TRUE
	return FALSE

/datum/martial_art/proc/handle_grab(var/mob/living/carbon/human/owner, var/mob/living/carbon/human/victim)
	if(handle_streak(owner, victim))
		streak = ""
		return TRUE
	return FALSE

//Magic will be done down here

/datum/martial_art/proc/handle_streak(var/mob/living/carbon/human/owner, var/mob/living/carbon/human/D)
	return FALSE

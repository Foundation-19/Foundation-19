/// Opiates
/datum/addiction/opiate
	name = "Opiates"
	withdrawal_stage_messages = list("I feel aches in my bodies..", "I need some pain relief...", "It aches all over...I need some opiates!")

/datum/addiction/opiate/WithdrawalStage1Process(mob/living/carbon/victim, delta_time)
	. = ..()
	if(prob(10))
		victim.emote("yawn")

/datum/addiction/opiate/WithdrawalStage2Process(mob/living/carbon/victim, delta_time)
	. = ..()
	if(prob(2) && ishuman(victim))
		var/mob/living/carbon/human/H = victim
		H.vomit(2)
	victim.adjust_dizzy_up_to(3 SECONDS * delta_time, 50 SECONDS)

/datum/addiction/opiate/WithdrawalStage3Process(mob/living/carbon/victim, delta_time)
	. = ..()
	if(prob(5) && ishuman(victim))
		var/mob/living/carbon/human/H = victim
		H.vomit(3)
	victim.adjust_dizzy_up_to(5 SECONDS * delta_time, 100 SECONDS)
	victim.jitteriness = clamp(victim.jitteriness + 15 * delta_time, victim.jitteriness, 250)

/// Nicotine
/datum/addiction/nicotine
	name = "Nicotine"
	withdrawal_stage_messages = list("Feel like having a smoke...", "Getting antsy. Really need a smoke now.", "I can't take it! Need a smoke NOW!")
	// Since we get it from cigarettes, which inject it very slowly
	addiction_relief_treshold = 0.02

/datum/addiction/nicotine/WithdrawalStage1Process(mob/living/carbon/victim, delta_time)
	. = ..()
	if(prob(20))
		victim.jitteriness = clamp(victim.jitteriness + 5 * delta_time, victim.jitteriness, 10)

/datum/addiction/nicotine/WithdrawalStage2Process(mob/living/carbon/victim, delta_time)
	. = ..()
	victim.jitteriness = clamp(victim.jitteriness + 5 * delta_time, victim.jitteriness, 20)
	if(prob(7))
		victim.emote("cough")

/datum/addiction/nicotine/WithdrawalStage3Process(mob/living/carbon/victim, delta_time)
	. = ..()
	victim.jitteriness = clamp(victim.jitteriness + 10 * delta_time, victim.jitteriness, 100)
	if(prob(15))
		victim.emote("cough")

// Psionics
/datum/addiction/psionics
	name = "Psionics"
	withdrawal_stage_messages = list("My mind aches.", "My mind wants more power...", "My head will explode! I need more power!")

/datum/addiction/psionics/WithdrawalStage1Process(mob/living/carbon/victim, delta_time)
	. = ..()
	// Deplete the psi stamina
	if(victim.psi && victim.psi.stamina > 5)
		victim.psi.spend_power(0.5 * delta_time)

/datum/addiction/psionics/WithdrawalStage2Process(mob/living/carbon/victim, delta_time)
	. = ..()
	if(victim.psi && victim.psi.stamina > 5)
		victim.psi.stamina -= 1 * delta_time
	if(victim.getBrainLoss() < 120)
		victim.adjustBrainLoss(1 * delta_time)
	victim.hallucination(10, 50)

/datum/addiction/psionics/WithdrawalStage3Process(mob/living/carbon/victim, delta_time)
	. = ..()
	if(victim.psi && victim.psi.stamina > 5)
		victim.psi.stamina -= 2 * delta_time
	if(victim.getBrainLoss() < 180) // This alone won't kill you, hopefuly
		victim.adjustBrainLoss(2 * delta_time)
	victim.hallucination(30, 100)

/datum/addiction/psionics/LoseAddiction(mob/living/carbon/victim)
	// BLAST THEM!!!
	if(victim.psi)
		victim.psi.suppressed = FALSE // Have to make it unsupressed for this
		victim.psi.spend_power(victim.psi.stamina)
	return ..()

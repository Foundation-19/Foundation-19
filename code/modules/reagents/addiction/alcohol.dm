/// Alcohol
/datum/addiction/alcohol
	name = "Alcohol"
	withdrawal_stage_messages = list("I could use a drink...", "Maybe the bar is still open?..", "God I need a drink!")

/datum/addiction/alcohol/WithdrawalStage1Process(mob/living/carbon/victim, delta_time)
	. = ..()
	victim.adjust_jitter_up_to(5 SECONDS * delta_time, 1 MINUTE)

/datum/addiction/alcohol/WithdrawalStage2Process(mob/living/carbon/victim, delta_time)
	. = ..()
	victim.adjust_jitter_up_to(10 SECONDS * delta_time, 2 MINUTES)
	victim.adjust_hallucination(1, 1)

/datum/addiction/alcohol/WithdrawalStage3Process(mob/living/carbon/victim, delta_time)
	. = ..()
	victim.adjust_jitter_up_to(15 SECONDS * delta_time, 4 MINUTES)
	victim.adjust_hallucination(2, 2)

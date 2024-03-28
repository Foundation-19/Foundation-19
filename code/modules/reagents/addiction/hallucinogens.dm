// Hallucinogens
/datum/addiction/hallucinogens
	name = "Hallucinogens"
	withdrawal_stage_messages = list("I feel so empty...", "I wonder what the machine elves are up to?..", "I need to see the beautiful colors again!!")

/datum/addiction/hallucinogens/WithdrawalStage1Process(mob/living/carbon/victim, delta_time)
	. = ..()
	if(prob(15))
		victim.emote(pick("twitch", "drool"))

/datum/addiction/hallucinogens/WithdrawalStage2Process(mob/living/carbon/victim, delta_time)
	. = ..()
	victim.hallucination(20, 20)
	if(prob(4))
		victim.Weaken(3)
		to_chat(victim, SPAN_WARNING("You feel as if your legs fell off..."))
	else if(prob(2))
		victim.Paralyse(2)
		to_chat(victim, SPAN_DANGER(pick("The voices won't stop!!", "Ugh, it's too difficult to stay awake...", "What is going on?!")))

/datum/addiction/hallucinogens/WithdrawalStage3Process(mob/living/carbon/victim, delta_time)
	. = ..()
	victim.hallucination(50, 50)
	victim.adjust_eye_blur_up_to(3 SECONDS * delta_time, 1 MINUTE)
	if(prob(6))
		victim.Weaken(6)
		to_chat(victim, SPAN_WARNING("Your legs feel unreal..."))
	else if(prob(2))
		victim.Paralyse(4)
		to_chat(victim, SPAN_DANGER(pick("The voices won't stop!!", "Ugh, it's too difficult to stay awake...", "What is going on?!")))

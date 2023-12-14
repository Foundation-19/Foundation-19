// Amnestics
/datum/addiction/amnestics
	name = "Amnestics"
	withdrawal_stage_messages = list("What was I thinking about..?.", "I need to forget that...", "I can't take this anymore, I can't keep remembering things!")
	/// So that we don't spam accidentaly
	var/nostalgia_cooldown

/datum/addiction/amnestics/WithdrawalStage1Process(mob/living/carbon/victim, delta_time)
	. = ..()
	victim.adjust_hallucination(1, 1)
	if(prob(5) && nostalgia_cooldown >= world.time)
		nostalgia_cooldown = world.time + 10 SECONDS
		victim.visible_message(SPAN_WARNING("[victim] looks confused for a moment."))
		to_chat(victim, SPAN_USERDANGER(pick("I forgot something important..?", "Did I just...", "Did I really do that..?", "Was that...")))
		victim.playsound_local(get_turf(victim), 'sounds/effects/nostalgia1.ogg', 10, FALSE)
		flash_color(victim, flash_color="#FFBBBB", flash_time=5)
		victim.adjust_confusion_up_to(5 SECONDS, 20 SECONDS)

/datum/addiction/amnestics/WithdrawalStage2Process(mob/living/carbon/victim, delta_time)
	. = ..()
	victim.adjust_hallucination(2, 2)
	if(prob(7) && nostalgia_cooldown >= world.time)
		nostalgia_cooldown = world.time + 10 SECONDS
		victim.visible_message(SPAN_WARNING("[victim] looks confused for a moment."))
		to_chat(victim, SPAN_USERDANGER(pick("My mind feels blank.", "The memories keep flooding in!", "My past is no more!", "My future is... no, that was yesterday..?")))
		victim.playsound_local(get_turf(victim), pick('sounds/effects/nostalgia2.ogg', 'sounds/effects/nostalgia3.ogg'), 25, FALSE)
		victim.adjust_confusion_up_to(10 SECONDS, 40 SECONDS)

/datum/addiction/amnestics/WithdrawalStage3Process(mob/living/carbon/victim, delta_time)
	. = ..()
	victim.adjust_hallucination(3, 3)
	if(prob(9) && nostalgia_cooldown >= world.time)
		nostalgia_cooldown = world.time + 10 SECONDS
		victim.visible_message(SPAN_WARNING("[victim] looks really confused for a moment."))
		to_chat(victim, SPAN_USERDANGER(pick("Future, past and present, all lie intertwined...", "The memories hold no meaning anymore.", "What did I do today? What will I do tomorrow?", "Nothing really matters anymore.")))
		victim.playsound_local(get_turf(victim), pick('sounds/effects/nostalgia4.ogg', 'sounds/effects/nostalgia5.ogg'), 50, FALSE)
		victim.adjust_confusion_up_to(15 SECONDS, 60 SECONDS)

/datum/addiction/amnestics/LoseAddiction(mob/living/carbon/victim)
	to_chat(victim, SPAN_GOOD("I can see it all clearly now..."))
	victim.playsound_local(get_turf(victim), 'sounds/effects/nostalgia5B.ogg', 50, FALSE)
	victim.adjust_hallucination(-100, -100)
	return ..()

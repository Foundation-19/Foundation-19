//For handling effects of various SCPs


//Blue lady aka SCP-013
GLOBAL_LIST_EMPTY(scp_013_1s)
/mob/living/carbon/human/proc/update_013_status(affected)
	if(scp_013_stage >= 8) //5g forced feminization complete
		if(prob(5))
			to_chat(src, SPAN_NOTICE("<i>I miss her...</i>"))
			return
		if(prob(5))
			to_chat(src, SPAN_NOTICE("<i>Where did she go...</i>"))
			return
		if(prob(5))
			to_chat(src, SPAN_NOTICE("You spot a glimpse of <i>her</i> in a nearby reflection..."))
			return
		if(prob(5))
			to_chat(src, SPAN_NOTICE("<i>I know her I just can't remember...</i>"))
			return
		if(prob(5))
			to_chat(src, SPAN_NOTICE("<i>I love her... Where did she go?</i>"))
			return
		addtimer(CALLBACK(src, .proc/update_013_status), 25 SECONDS)
		return

	scp_013_stage += 1
	if(scp_013_stage == 1)
		to_chat(src, SPAN_NOTICE("You can't remember what you did this morning, or the day before..."))
		scp_013_instance = TRUE
		GLOB.scp_013_1s += src
		addtimer(CALLBACK(src, .proc/update_013_status), 100 SECONDS)
	if(scp_013_stage == 2)
		to_chat(src, SPAN_NOTICE("You remember now, you were looking in the mirror as you painted your lips blue."))
		addtimer(CALLBACK(src, .proc/update_013_status), 150 SECONDS)
	if(scp_013_stage == 3)
		to_chat(src, SPAN_NOTICE("Briefly, she fades from your mind. You miss her already."))
		addtimer(CALLBACK(src, .proc/update_013_status), 100 SECONDS)
	if(scp_013_stage == 4)
		to_chat(src, SPAN_NOTICE("You put the blue dress on, that's all you can recall. How did you get here?"))
		addtimer(CALLBACK(src, .proc/update_013_status), 150 SECONDS)
	if(scp_013_stage == 5)
		to_chat(src, SPAN_NOTICE("Who were you? You try to remember in more detail..."))
		addtimer(CALLBACK(src, .proc/update_013_status), 100 SECONDS)
	if(scp_013_stage == 6)
		to_chat(src, SPAN_NOTICE("<i>I can't live without her...</i>"))
		addtimer(CALLBACK(src, .proc/update_013_status), 150 SECONDS)
	if(scp_013_stage == 7)
		if(gender == MALE)
			to_chat(src, SPAN_WARNING("You feel dysphoric about your appearance... Starting to feel more like the woman you truly are inside."))
			gender = FEMALE
			addtimer(CALLBACK(src, .proc/update_013_status), 10 SECONDS) //now go to the effects

// SCP-173 manual blinking
/mob/living/carbon/human/verb/manual_blink()
	set name = "Blink"
	set desc = "Your eyes will close for a moment, giving them some rest."
	set category = "IC"

	for(var/mob/living/scp_173/S in view(7, src))
		S.CauseBlink(src)

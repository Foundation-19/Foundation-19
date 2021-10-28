//For handling effects of various SCPs


//Blue lady aka SCP-013
/mob/living/carbon/human/proc/update_013_status(mob/living/carbon/human/affected)
	if(!affected.scp_013_stage) //setup the party
		affected.set_species("SCP-013-1")
	affected.scp_013_stage += 1

	if(affected.scp_013_stage == 1)
		to_chat(affected, "<span class='notice'>You can't remember what she did this morning, or the day before...</span>")
		addtimer(CALLBACK(affected, .proc/update_013_status), 2)
	if(affected.scp_013_stage == 2)
		to_chat(affected, "<span class='notice'>You remember now, looking in the mirror as you painted your lips blue.</span>")
		affected.lip_style = "blue"
		addtimer(CALLBACK(affected, .proc/update_013_status), 2)
	if(affected.scp_013_stage == 3)
		to_chat(affected, "<span class='notice'>Briefly, she fades from your mind. You miss her already.</span>")
		affected.lip_style = "[initial(lip_style)]"
		addtimer(CALLBACK(affected, .proc/update_013_status), 2)
	if(affected.scp_013_stage == 4)
		to_chat(affected, "<span class='notice'>You put the blue dress on, that's all you can recall. How did you get here?</span>")
		affected.color = "blue"
		affected.real_name = "The Blue Lady"
		addtimer(CALLBACK(src, .proc/update_013_status), 2)
	if(affected.scp_013_stage == 5)
		to_chat(affected, "<span class='notice'>Who were you? You try to remember in more detail...</span>")
		addtimer(CALLBACK(src, .proc/update_013_status), 2)
	if(affected.scp_013_stage == 6)
		to_chat(affected, "<span class='notice'>You need to find out.</span>")
		addtimer(CALLBACK(src, .proc/update_013_status), 2)
	if(affected.scp_013_stage == 7)
		if (affected.gender == MALE)
			to_chat(affected, "<span class='warning'>You feel dysphoric about your appearance... Like you're in the wrong body.</span>")
			affected.gender = FEMALE

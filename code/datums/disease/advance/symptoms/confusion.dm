/*
//////////////////////////////////////

Confusion

	Hidden.
	Lowers resistance.
	Decreases stage speed.
	Slightly transmissibile.
	Intense Level.

Bonus
	Makes the affected mob be confused for short periods of time.

//////////////////////////////////////
*/

/datum/symptom/confusion
	name = "Confusion"
	desc = "The virus interferes with the proper function of the neural system, leading to bouts of confusion and erratic movement."
	stealth = 2
	resistance = -1
	stage_speed = -3
	transmittable = 1
	level = 4
	severity = 2
	base_message_chance = 25
	symptom_delay_min = 10
	symptom_delay_max = 30
	threshold_descs = list(
		"Stealth 4" = "The symptom remains hidden until active.",
		"Transmission 6" = "Increases confusion duration and strength.",
	)

/datum/symptom/confusion/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.properties["transmittable"] >= 6)
		power = 1.5
	if(A.properties["stealth"] >= 4)
		suppress_warning = TRUE

/datum/symptom/confusion/End(datum/disease/advance/A)
	A.affected_mob.adjust_confusion(-10 * power SECONDS)
	return ..()

/datum/symptom/confusion/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/carbon/M = A.affected_mob
	switch(A.stage)
		if(1, 2, 3, 4)
			if(prob(base_message_chance) && !suppress_warning)
				to_chat(M, "<span class='warning'>[pick("Your head hurts.", "Your mind blanks for a moment.")]</span>")
		else
			to_chat(M, "<span class='userdanger'>You can't think straight!</span>")
			M.adjust_confusion(8 * power SECONDS)
	return

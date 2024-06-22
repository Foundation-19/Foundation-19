/*
//////////////////////////////////////

Dizziness

	Hidden.
	Lowers resistance considerably.
	Decreases stage speed.
	Increases transmittability
	Intense Level.

Bonus
	Shakes the affected mob's screen for short periods.

//////////////////////////////////////
*/

/datum/symptom/dizzy // Not the egg

	name = "Dizziness"
	desc = "The virus causes inflammation of the vestibular system, leading to bouts of dizziness."
	stealth = 1
	resistance = -2
	stage_speed = -3
	transmittable = 1
	level = 4
	severity = 2
	base_message_chance = 50
	symptom_delay_min = 15
	symptom_delay_max = 30
	threshold_descs = list(
		"Stealth 4" = "The symptom remains hidden until active.",
		"Transmission 6" = "Also causes druggy vision.",
	)

/datum/symptom/dizzy/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.properties["stealth"] >= 4)
		suppress_warning = TRUE
	if(A.properties["transmittable"] >= 6) // Druggy
		power = 2

/datum/symptom/dizzy/End(datum/disease/advance/A)
	A.affected_mob.adjust_dizzy(-30 SECONDS)
	A.affected_mob.adjust_drugginess(-30 SECONDS)
	return ..()

/datum/symptom/dizzy/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/M = A.affected_mob
	switch(A.stage)
		if(1, 2, 3, 4)
			if(prob(base_message_chance) && !suppress_warning)
				to_chat(M, SPAN_WARNING("[pick("You feel dizzy.", "Your head spins.")]"))
		else
			to_chat(M, "<span class='userdanger'>A wave of dizziness washes over you!</span>")
			M.set_dizzy_if_lower(30 SECONDS)
			if(power >= 2)
				M.set_drugginess_if_lower(30 SECONDS)

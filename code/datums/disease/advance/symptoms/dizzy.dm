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
	A.affected_mob.dizziness = max(0, A.affected_mob.dizziness - 30)
	A.affected_mob.druggy = max(0, A.affected_mob.druggy - 30)
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
			M.dizziness += max(0, 30 - M.dizziness)
			if(power >= 2)
				M.druggy += max(0, 30 - M.druggy)

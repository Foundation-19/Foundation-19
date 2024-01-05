/*
//////////////////////////////////////

Vomiting

	Very Very Noticable.
	Decreases resistance.
	Doesn't increase stage speed.
	Little transmissibility.
	Medium Level.

Bonus
	Forces the affected mob to vomit!
	Meaning your disease can spread via
	people walking on vomit.
	Makes the affected mob lose nutrition and
	heal toxin damage.

//////////////////////////////////////
*/

/datum/symptom/vomit
	name = "Vomiting"
	desc = "The virus causes nausea and irritates the stomach, causing occasional vomit."
	stealth = -2
	resistance = -1
	stage_speed = -1
	transmittable = 2
	level = 3
	severity = 3
	base_message_chance = 100
	symptom_delay_min = 25
	symptom_delay_max = 80
	var/vomit_blood = FALSE
	var/blood_count = 15
	threshold_descs = list(
		"Stealth 4" =  "The symptom remains hidden until active.",
		"Stage Speed 8" = "Causes the host to vomit blood,",
		"Stage Speed 14" = "Increases the amount of blood vomited.",
	)

/datum/symptom/vomit/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.properties["stealth"] >= 4)
		suppress_warning = TRUE
	if(A.properties["stage_rate"] >= 8)
		vomit_blood = TRUE
	if(A.properties["stage_rate"] >= 14)
		blood_count = 30

/datum/symptom/vomit/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/M = A.affected_mob
	switch(A.stage)
		if(1, 2, 3, 4)
			if(prob(base_message_chance) && !suppress_warning)
				to_chat(M, SPAN_WARNING(pick("You feel nauseated.", "You feel like you're going to throw up!")))
		else
			vomit(M)

/datum/symptom/vomit/proc/vomit(mob/living/carbon/M)
	M.empty_stomach(vomit_blood, blood_count)

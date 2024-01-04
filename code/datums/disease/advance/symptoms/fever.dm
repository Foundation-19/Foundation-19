/*
//////////////////////////////////////

Fever

	No change to hidden.
	Increases resistance.
	Increases stage speed.
	Little transmittable.
	Low level.

Bonus
	Heats up your body.
	Causes dehydration.

//////////////////////////////////////
*/

/datum/symptom/fever
	name = "Fever"
	desc = "The virus causes a febrile response from the host, raising its body temperature."
	stealth = 0
	resistance = 3
	stage_speed = 3
	transmittable = 2
	level = 2
	severity = 2
	base_message_chance = 10
	symptom_delay_min = 5
	symptom_delay_max = 10
	var/unsafe = FALSE //over the heat threshold
	var/dehydrate = FALSE
	threshold_descs = list(
		"Resistance 5" = "Increases fever intensity, fever can overheat and harm the host.",
		"Resistance 10" = "Further increases fever intensity.",
		"Stage Speed 8" = "Causes dehydration."
	)

/datum/symptom/fever/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.properties["resistance"] >= 5) //dangerous fever
		power = 2
		unsafe = TRUE
	if(A.properties["resistance"] >= 10)
		power = 3
	if(A.properties["stage_speed"] >= 8)
		dehydrate = TRUE

/datum/symptom/fever/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/carbon/human/H = A.affected_mob
	if(prob(base_message_chance))
		if(!unsafe || A.stage < 4)
			to_chat(H, SPAN_WARNING(pick("You feel hot.", "You feel like you're burning.")))
		else
			to_chat(H, SPAN_USERDANGER(pick("You feel too hot.", "You feel like your blood is boiling.")))
	if(dehydrate)
		H.adjust_hydration(-round(A.stage * 1.5))
	SetBodyTemp(H, A)

/**
 * SetBodyTemp Sets the body temp change
 *
 * Sets the body temp change to the mob based on the stage and resistance of the disease
 * arguments:
 * * mob/living/M The mob to apply changes to
 * * datum/disease/advance/A The disease applying the symptom
 */
/datum/symptom/fever/proc/SetBodyTemp(mob/living/carbon/human/H, datum/disease/advance/A)
	var/change_limit = H.species.heat_level_2
	if(unsafe) // when unsafe the fever can go to the heat_level_3
		change_limit += H.species.heat_level_3
	H.bodytemperature = min(H.bodytemperature + 5 * power * A.stage, change_limit)

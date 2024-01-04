/*
//////////////////////////////////////

Necrotizing Fasciitis (AKA Flesh-Eating Disease)

	Very very noticable.
	Lowers resistance.
	No changes to stage speed.
	Decreases transmittablity.
	Fatal Level.

Bonus
	Deals brute damage over time.

//////////////////////////////////////
*/

/datum/symptom/flesh_eating
	name = "Necrotizing Fasciitis"
	desc = "The virus aggressively attacks body cells, necrotizing tissues and organs."
	stealth = -3
	resistance = -3
	stage_speed = 0
	transmittable = -2
	level = 6
	severity = 5
	base_message_chance = 50
	symptom_delay_min = 20
	symptom_delay_max = 30
	threshold_descs = list(
		"Resistance 12" = "Symptom's activation delay decreases.",
		"Stage Speed 16" = "The amount of damage done by necrosis increases drastically.",
	)

/datum/symptom/flesh_eating/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.properties["resistance"] >= 12) // Faster activation
		symptom_delay_min = 10
		symptom_delay_max = 20
	if(A.properties["stage_rate"] >= 16) // More damage
		power = 2

/datum/symptom/flesh_eating/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/carbon/C = A.affected_mob
	switch(A.stage)
		if(2,3)
			if(prob(base_message_chance))
				to_chat(C, SPAN_WARNING("[pick("You feel a sudden pain across your body.", "Drops of blood appear suddenly on your skin.")]"))
		if(4,5)
			C.custom_pain(pick("You cringe as a violent pain takes over your body.", "It feels like your body is eating itself inside out.", "IT HURTS."), 15) // Just a tiny bit of pain :)
			FleshEat(C, A)

/datum/symptom/flesh_eating/proc/FleshEat(mob/living/carbon/C, datum/disease/advance/A)
	var/get_damage = rand(10, 15) * power * max(1, A.stage - 3.5)
	C.take_overall_damage(get_damage)
	return TRUE

/*
//////////////////////////////////////

Brittle Bones

	Slightly stealthy.
	Increases resistance.
	Decreases stage speed.
	Decreases transmittability.
	Medium level.

Bonus
	Can randomly break bones

//////////////////////////////////////
*/

/datum/symptom/brittle_bones
	name = "Brittle Bones"
	desc = "The virus causes a drain of collagen from the bones of host's body, causing frequent fractures."
	stealth = 1
	resistance = 2
	stage_speed = -3
	transmittable = -2
	level = 6
	severity = 4
	base_message_chance = 30
	symptom_delay_min = 35
	symptom_delay_max = 50
	/// Chance on each activation to actually try and break bones
	var/break_chance = 50
	var/random_break = FALSE
	threshold_descs = list(
		"Stealth 8" = "Symptoms remain hidden until active.",
		"Stage Speed 10" = "Bones may fracture on their own, even without damage.",
	)

/datum/symptom/brittle_bones/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.properties["stealth"] >= 8)
		base_message_chance = 0
	if(A.properties["stage_rate"] >= 10) // Randomly break bones even without damage
		random_break = TRUE

/datum/symptom/brittle_bones/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/carbon/human/H = A.affected_mob
	switch(A.stage)
		if(1,2,3,4)
			if(prob(base_message_chance))
				to_chat(H, SPAN_WARNING(pick("Your bones feel lighter than usual.", "Your bones hurt a little.", "Your bones are shaking.")))
		if(5)
			if(!prob(break_chance))
				return
			var/list/available_organs = list()
			for(var/obj/item/organ/external/E in H.organs)
				if(E.status & ORGAN_BROKEN)
					continue
				if(!random_break && E.get_damage() < E.min_broken_damage * 0.5)
					continue
				available_organs += E
			if(!LAZYLEN(available_organs))
				return
			var/obj/item/organ/external/BONE = pick(available_organs)
			BONE.fracture()

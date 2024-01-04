/*
//////////////////////////////////////

Choking

	Noticable.
	Increases resistance.
	Decreases stage speed.
	Decreases transmittablity
	Moderate Level.

Bonus
	Inflicts spikes of oxyloss
	Inflicts lungs damage

//////////////////////////////////////
*/

/datum/symptom/choking
	name = "Choking"
	desc = "The virus causes inflammation of the host's air conduits, leading to intermittent choking."
	stealth = -2
	resistance = 1
	stage_speed = -2
	transmittable = -2
	level = 4
	severity = 4
	base_message_chance = 15
	symptom_delay_min = 20
	symptom_delay_max = 30
	threshold_descs = list(
		"Resistance 10" = "Slowly damages respiratory organs.",
		"Stage Speed 8" = "Causes choking more frequently.",
		"Stealth 4" = "The symptom remains hidden until active."
	)

	var/damage_lungs = FALSE

/datum/symptom/choking/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.properties["resistance"] >= 10)
		damage_lungs = TRUE
	if(A.properties["stage_rate"] >= 8)
		symptom_delay_min = 15
		symptom_delay_max = 25
	if(A.properties["stealth"] >= 4)
		suppress_warning = TRUE

/datum/symptom/choking/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/carbon/human/H = A.affected_mob
	switch(A.stage)
		if(1, 2)
			if(prob(base_message_chance) && !suppress_warning)
				to_chat(H, SPAN_WARNING(pick("You're having difficulty breathing.", "Your breathing becomes heavy.")))

		if(3, 4)
			if(!suppress_warning)
				to_chat(H, SPAN_WARNING(pick("Your windpipe feels like a straw.", "Your breathing becomes tremendously difficult.")))
			else
				to_chat(H, SPAN_WARNING("You feel very [pick("dizzy","woozy","faint")].")) // Fake bloodloss messages
			H.adjustOxyLoss(rand(5, 15))
			if(!(CE_STABLE in H.chem_effects))
				H.losebreath = max(H.losebreath + 2, H.losebreath)
			H.emote("gasp")
			if(damage_lungs && prob(10))
				var/obj/item/organ/internal/I = H.internal_organs_by_name[H.species.breathing_organ]
				if(!I.is_bruised())
					I.take_general_damage(I.min_bruised_damage * pick(0.05, 0.1))
					var/obj/item/organ/external/parent = H.get_organ(I.parent_organ)
					if(istype(parent))
						H.custom_pain("You feel a stabbing pain in your [parent.name]!", 10, affecting = parent)

		if(5)
			to_chat(H, SPAN_USERDANGER("[pick("You're choking!", "You can't breathe!")]"))
			H.adjustOxyLoss(rand(10, 20))
			if(!(CE_STABLE in H.chem_effects))
				H.losebreath = max(H.losebreath + 4, H.losebreath)
			H.emote("gasp")
			if(damage_lungs && prob(15))
				var/obj/item/organ/internal/I = H.internal_organs_by_name[H.species.breathing_organ]
				if(!I.is_bruised())
					I.take_general_damage(I.min_bruised_damage * pick(0.1, 0.2, 0.3))
					var/obj/item/organ/external/parent = H.get_organ(I.parent_organ)
					if(istype(parent))
						H.custom_pain("You feel a stabbing pain in your [parent.name]!", 25, affecting = parent)

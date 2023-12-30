/datum/symptom/heal
	name = "Basic Healing (does nothing)" //warning for adminspawn viruses
	desc = "You should not be seeing this."
	stealth = 0
	resistance = 0
	stage_speed = 0
	transmittable = 0
	level = 0 //not obtainable
	base_message_chance = 20 //here used for the overlays
	symptom_delay_min = 1
	symptom_delay_max = 1
	var/passive_message = "" //random message to infected but not actively healing people
	threshold_descs = list(
		"Stage Speed 6" = "Doubles healing speed.",
	)

/datum/symptom/heal/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.properties["stage_rate"] >= 6) //stronger healing
		power = 2

/datum/symptom/heal/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/M = A.affected_mob
	switch(A.stage)
		if(4, 5)
			var/effectiveness = CanHeal(A)
			if(!effectiveness)
				if(passive_message && prob(2) && PassiveMessageCondition(M))
					to_chat(M, passive_message)
				return
			else
				Heal(M, A, effectiveness)
	return

/datum/symptom/heal/proc/CanHeal(datum/disease/advance/A)
	return power

/datum/symptom/heal/proc/Heal(mob/living/M, datum/disease/advance/A, actual_power)
	return TRUE

/datum/symptom/heal/proc/PassiveMessageCondition(mob/living/M)
	return TRUE



/datum/symptom/heal/starlight
	name = "Starlight Condensation"
	desc = "The virus reacts to direct starlight, producing regenerative chemicals. Works best against toxin-based damage."
	stealth = -1
	resistance = -2
	stage_speed = 0
	transmittable = 1
	level = 6
	passive_message = "<span class='notice'>You miss the feeling of starlight on your skin.</span>"
	threshold_descs = list(
		"Stage Speed 6" = "Increases healing speed.",
		"Transmission 6" = "Removes penalty for only being close to space.",
	)
	var/nearspace_penalty = 0.3

/datum/symptom/heal/starlight/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.properties["stage_rate"] >= 6)
		power = 2
	if(A.properties["transmittable"] >= 6)
		nearspace_penalty = 1

/datum/symptom/heal/starlight/CanHeal(datum/disease/advance/A)
	var/mob/living/M = A.affected_mob
	if(istype(get_turf(M), /turf/space))
		return power
	else
		for(var/turf/T in view(M, 2))
			if(istype(T, /turf/space))
				return power * nearspace_penalty

/datum/symptom/heal/starlight/Heal(mob/living/carbon/M, datum/disease/advance/A, actual_power)
	var/heal_amt = actual_power
	if(M.getToxLoss() && prob(5))
		to_chat(M, SPAN_NOTICE("Your skin tingles as the starlight seems to heal you."))

	M.adjustToxLoss(-(4 * heal_amt)) //most effective on toxins
	M.heal_organ_damage(2 * heal_amt, 2 * heal_amt)

	return 1

/datum/symptom/heal/starlight/PassiveMessageCondition(mob/living/M)
	if(M.getBruteLoss() || M.getFireLoss() || M.getToxLoss())
		return TRUE
	return FALSE


/datum/symptom/heal/water
	name = "Tissue Hydration"
	desc = "The virus uses excess water inside and outside the body to repair damaged tissue cells. More effective when using holy water and against burns."
	stealth = 0
	resistance = -1
	stage_speed = 0
	transmittable = 1
	level = 6
	passive_message = "<span class='notice'>Your skin feels oddly dry...</span>"
	var/absorption_coeff = 1
	threshold_descs = list(
		"Resistance 5" = "Water is consumed at a much slower rate.",
		"Stage Speed 7" = "Increases healing speed.",
	)

/datum/symptom/heal/water/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.properties["stage_rate"] >= 7)
		power = 2
	if(A.properties["resistance"] >= 5)
		absorption_coeff = 0.25

/datum/symptom/heal/water/CanHeal(datum/disease/advance/A)
	. = 0
	var/mob/living/M = A.affected_mob
	if(!M.getBruteLoss() && !M.getFireLoss())
		return FALSE

	if(M.fire_stacks > 0)
		M.adjust_fire_stacks(round(-1 / absorption_coeff))
		. += power
	if(M.reagents.has_reagent(/datum/reagent/water/holywater, 0.5 * absorption_coeff))
		M.reagents.remove_reagent(/datum/reagent/water/holywater, 0.5 * absorption_coeff)
		. += power * 0.75
	else if(M.reagents.has_reagent(/datum/reagent/water, 0.5 * absorption_coeff))
		M.reagents.remove_reagent(/datum/reagent/water, 0.5 * absorption_coeff)
		. += power * 0.5

/datum/symptom/heal/water/Heal(mob/living/carbon/M, datum/disease/advance/A, actual_power)
	var/heal_amt = 2 * actual_power
	if(prob(5))
		to_chat(M, "<span class='notice'>You feel yourself absorbing the water around you to soothe your damaged skin.</span>")

	M.heal_organ_damage(2 * heal_amt, 2 * heal_amt)

	return 1

/datum/symptom/heal/water/PassiveMessageCondition(mob/living/M)
	if(M.getBruteLoss() || M.getFireLoss())
		return TRUE
	return FALSE

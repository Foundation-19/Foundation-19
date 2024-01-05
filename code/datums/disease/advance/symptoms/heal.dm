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


/datum/symptom/heal/organ
	name = "Autophagic Tissuegrafting"
	desc = "The virus uses soft tissue of the host's body to regenerate internal organs."
	stealth = -2
	resistance = 0
	stage_speed = 0
	transmittable = -2
	level = 7
	/// Organ damage healed translates to brute damage dealt, multiplied by this coefficient
	var/damage_coeff = 3
	threshold_descs = list(
		"Resistance 7" = "Decreases amount of brute damage done.",
		"Resistance 14" = "Virus ceases to deal any brute damage.",
		"Stage Speed 8" = "Increases healing speed.",
	)

/datum/symptom/heal/organ/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.properties["resistance"] >= 7)
		damage_coeff = 1.5
	if(A.properties["resistance"] >= 14)
		damage_coeff = 0
	if(A.properties["stage_rate"] >= 8)
		power = 2

/datum/symptom/heal/organ/CanHeal(datum/disease/advance/A)
	var/mob/living/carbon/human/H = A.affected_mob
	for(var/obj/item/organ/internal/I in H.internal_organs)
		if(BP_IS_ROBOTIC(I))
			continue
		if(I.organ_tag == BP_BRAIN)
			continue
		if(I.is_broken())
			continue
		if(!I.damage)
			continue
		return TRUE
	return FALSE

/datum/symptom/heal/organ/Heal(mob/living/carbon/human/H, datum/disease/advance/A)
	if(prob(5))
		to_chat(H, SPAN_WARNING("You feel your innards moving around!"))

	for(var/obj/item/organ/internal/I in H.internal_organs)
		if(BP_IS_ROBOTIC(I))
			continue
		if(I.organ_tag == BP_BRAIN)
			continue
		I.heal_damage(power)
		var/obj/item/organ/external/BP = H.get_organ(I.parent_organ)
		if(istype(BP))
			BP.take_external_damage(power * damage_coeff)

	return TRUE

/datum/symptom/heal/organ/PassiveMessageCondition(mob/living/M)
	return FALSE


/datum/symptom/heal/hemostasis
	name = "Hemostasis"
	desc = "The virus restores damaged blood vessels, stopping the external bleeding."
	stealth = 1
	resistance = -3
	stage_speed = -2
	transmittable = -3
	level = 4
	symptom_delay_min = 30
	symptom_delay_max = 40
	base_message_chance = 20
	threshold_descs = list(
		"Resistance 8" = "Restores missing blood volume.",
		"Stage Speed 6" = "Increases healing speed.",
		"Stage Speed 12" = "Prevents internal bleeding.",
	)
	var/blood_restore = FALSE
	var/heal_internal = FALSE

/datum/symptom/heal/hemostasis/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.properties["resistance"] >= 8)
		blood_restore = TRUE
	if(A.properties["stage_rate"] >= 6)
		symptom_delay_min = 10
		symptom_delay_max = 20
	if(A.properties["stage_rate"] >= 12)
		heal_internal = TRUE

/datum/symptom/heal/hemostasis/CanHeal(datum/disease/advance/A)
	. = FALSE
	var/mob/living/carbon/human/H = A.affected_mob
	if(LAZYLEN(ListWounds(H)))
		. = TRUE
	if(blood_restore && H.vessel.get_reagent_amount(/datum/reagent/blood) < H.species.blood_volume)
		. = TRUE
	if(heal_internal && LAZYLEN(ListInternalBleeds(H)))
		. = TRUE

/datum/symptom/heal/hemostasis/Heal(mob/living/carbon/human/H, datum/disease/advance/A)
	if(prob(5))
		to_chat(H, SPAN_NOTICE("The blood stops flowing out from your wounds..."))

	for(var/datum/wound/W in ListWounds(H))
		W.bleed_timer = max(0, W.bleed_timer - rand(10, 20))
		W.parent_organ.update_damages()

	if(blood_restore)
		H.regenerate_blood(round(H.species.blood_volume * 0.05))

	if(heal_internal)
		for(var/obj/item/organ/external/E in ListInternalBleeds(H))
			E.status &= ~ORGAN_ARTERY_CUT

	return TRUE

/datum/symptom/heal/hemostasis/PassiveMessageCondition(mob/living/M)
	return FALSE

/datum/symptom/heal/hemostasis/proc/ListWounds(mob/living/carbon/human/H)
	. = list()
	for(var/obj/item/organ/external/E in H.organs)
		for(var/datum/wound/W in E.wounds)
			if(!W.bleeding())
				continue
			. += W

/datum/symptom/heal/hemostasis/proc/ListInternalBleeds(mob/living/carbon/human/H)
	. = list()
	for(var/obj/item/organ/external/E in H.organs)
		if(!(E.status & ORGAN_ARTERY_CUT))
			continue
		. += E

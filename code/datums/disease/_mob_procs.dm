/mob/living/proc/HasDisease(datum/disease/D)
	for(var/thing in diseases)
		var/datum/disease/DD = thing
		if(D.IsSame(DD))
			return TRUE
	return FALSE

/mob/living/proc/CanContractDisease(datum/disease/D)
	if(status_flags & GODMODE)
		return FALSE

	if(stat == DEAD && !D.process_dead)
		return FALSE

	if(isSynthetic())
		return FALSE

	if(D.GetDiseaseID() in disease_resistances)
		return FALSE

	if(HasDisease(D))
		return FALSE

	if(!D.IsViableMobtype(type))
		return FALSE

	return TRUE

/mob/living/proc/CanSpreadAirborneDisease()
	return TRUE

/mob/living/carbon/human/CanSpreadAirborneDisease()
	return !((head && ((head.item_flags & ITEM_FLAG_AIRTIGHT) || (head.body_parts_covered & FACE))) || \
			(wear_mask && ((wear_mask.item_flags & ITEM_FLAG_AIRTIGHT) || (wear_mask.body_parts_covered & FACE))))

/mob/living/proc/ContactContractDisease(datum/disease/D)
	if(!CanContractDisease(D))
		return FALSE
	D.TryInfect(src)

/mob/living/carbon/human/ContactContractDisease(datum/disease/D, target_zone)
	if(!CanContractDisease(D))
		return FALSE

	var/obj/item/clothing/Cl = null
	var/passed = TRUE

	var/head_ch = 80
	var/body_ch = 100
	var/hands_ch = 35
	var/feet_ch = 15

	if(prob(15/D.permeability_mod))
		return

	if(nutrition>250 && prob(nutrition/10))
		return

	//Lefts and rights do not matter for arms and legs, they both run the same checks
	if(!target_zone)
		target_zone = pick(head_ch;BP_HEAD,body_ch;BP_CHEST,hands_ch;BP_L_HAND,feet_ch;BP_L_LEG)
	else
		target_zone = check_zone(target_zone)

	switch(target_zone)
		if(BP_HEAD)
			if(isobj(head) && !istype(head, /obj/item/paper))
				Cl = head
				passed = prob((Cl.permeability_coefficient*100) - 1)
			if(passed && isobj(wear_mask))
				Cl = wear_mask
				passed = prob((Cl.permeability_coefficient*100) - 1)

		if(BP_CHEST)
			if(isobj(wear_suit))
				Cl = wear_suit
				passed = prob((Cl.permeability_coefficient*100) - 1)
			if(passed && isobj(w_uniform))
				Cl = w_uniform
				passed = prob((Cl.permeability_coefficient*100) - 1)

		if(BP_L_HAND, BP_R_HAND)
			if(isobj(wear_suit) && wear_suit.body_parts_covered&HANDS)
				Cl = wear_suit
				passed = prob((Cl.permeability_coefficient*100) - 1)

			if(passed && isobj(gloves))
				Cl = gloves
				passed = prob((Cl.permeability_coefficient*100) - 1)

		if(BP_L_LEG, BP_R_LEG)
			if(isobj(wear_suit) && wear_suit.body_parts_covered&FEET)
				Cl = wear_suit
				passed = prob((Cl.permeability_coefficient*100) - 1)

			if(passed && isobj(shoes))
				Cl = shoes
				passed = prob((Cl.permeability_coefficient*100) - 1)

	if(passed)
		D.TryInfect(src)

/mob/living/proc/AirborneContractDisease(datum/disease/D, force_spread)
	if(((D.spread_flags & DISEASE_SPREAD_AIRBORNE) || force_spread) && CanSpreadAirborneDisease() && prob((50*D.permeability_mod) - 1))
		ForceContractDisease(D)

//Proc to use when you 100% want to try to infect someone (ignoreing protective clothing and such), as long as they aren't immune
/mob/living/proc/ForceContractDisease(datum/disease/D, make_copy = TRUE, del_on_fail = FALSE)
	if(!CanContractDisease(D))
		if(del_on_fail)
			qdel(D)
		return FALSE
	if(!D.TryInfect(src, make_copy))
		if(del_on_fail)
			qdel(D)
		return FALSE
	return TRUE

/mob/living/carbon/human/CanContractDisease(datum/disease/D)
	if(species)
		if(species.species_flags & SPECIES_FLAG_NO_DISEASE)
			return FALSE

	for(var/thing in D.required_organs)
		if(!(locate(thing) in organs))
			return FALSE
	return ..()

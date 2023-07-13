// Medicines in this file are simple to make and have straightforward effects.
// They include things like bicaridine, dexalin, and so on.
// Even medicines that don't have huge effects could go here. As a rule of thumb, if a CMO might want it made at roundstart, you can consider it a core chem.

/datum/reagent/medicine/inaprovaline
	name = "Inaprovaline"
	description = "Inaprovaline is a multipurpose neurostimulant and cardioregulator. Commonly used to slow bleeding and stabilize patients."
	color = "#00bfff"
	metabolism = REM * 0.5
	overdose = REAGENTS_OVERDOSE * 2
	value = 3.5

/datum/reagent/medicine/inaprovaline/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien != IS_DIONA)
		M.add_chemical_effect(CE_STABLE)
		M.add_chemical_effect(CE_PAINKILLER, 10)

/datum/reagent/medicine/inaprovaline/overdose(mob/living/carbon/M, alien)
	M.add_chemical_effect(CE_SLOWDOWN, 1)
	if (prob(5))
		M.slurring = max(M.slurring, 10)
	if (prob(2))
		M.drowsyness = max(M.drowsyness, 5)



/datum/reagent/medicine/bicaridine
	name = "Bicaridine"
	description = "Bicaridine is a fast-acting medication to treat physical trauma."
	color = "#bf0000"
	value = 4.9

/datum/reagent/medicine/bicaridine/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien != IS_DIONA)
		M.heal_organ_damage(6 * removed, 0)
		M.add_chemical_effect(CE_PAINKILLER, 10)

/datum/reagent/medicine/bicaridine/overdose(mob/living/carbon/M, alien)
	..()
	if (ishuman(M))
		M.add_chemical_effect(CE_BLOCKAGE, (15 + volume - overdose)/100)
		var/mob/living/carbon/human/H = M
		for (var/obj/item/organ/external/E in H.organs)
			if (E.status & ORGAN_ARTERY_CUT && prob(2))
				E.status &= ~ORGAN_ARTERY_CUT



/datum/reagent/medicine/kelotane
	name = "Kelotane"
	description = "Kelotane is a drug used to treat burns."
	color = "#ffa800"
	value = 2.9

/datum/reagent/medicine/kelotane/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien != IS_DIONA)
		M.heal_organ_damage(0, 6 * removed)



/datum/reagent/medicine/dermaline
	name = "Dermaline"
	description = "Dermaline is the next step in burn medication. Works twice as good as kelotane and enables the body to restore even the direst heat-damaged tissue."
	color = "#ff8000"
	overdose = REAGENTS_OVERDOSE * 0.5
	value = 3.9

/datum/reagent/medicine/dermaline/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien != IS_DIONA)
		M.heal_organ_damage(0, 12 * removed)

/datum/reagent/medicine/meraline
	name = "Meraline"
	description = "Meraline is an advanced medicine used for treating severe physical trauma. Works twice as good as bicaridine but lacks its painkilling properties."
	color = "#e6666c"
	overdose = REAGENTS_OVERDOSE * 0.5
	value = 3.9

/datum/reagent/medicine/meraline/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien != IS_DIONA)
		M.heal_organ_damage(12 * removed, 0)

/datum/reagent/medicine/dylovene
	name = "Dylovene"
	description = "Dylovene is a broad-spectrum antitoxin used to neutralize poisons before they can do significant harm."
	taste_description = "a roll of gauze"
	color = "#00a000"
	overdose = 0
	value = 2.1

	/// Whether or not this reagent removes drowsiness and hallucinations, and causes an antitox effect.
	var/remove_generic = TRUE
	/// Reagents in this list will be removed from the holder's body each time this reagent ticks.
	var/list/remove_toxins = list(
		/datum/reagent/toxin/zombie_powder
	)

/datum/reagent/medicine/dylovene/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_DIONA)
		return

	if (remove_generic)
		M.drowsyness = max(0, M.drowsyness - 6 * removed)
		M.adjust_hallucination(-9 * removed)
		M.add_up_to_chemical_effect(CE_ANTITOX, 1)

	var/removing = (4 * removed)
	var/datum/reagents/ingested = M.get_ingested_reagents()
	for (var/datum/reagent/R in ingested.reagent_list)
		if ((remove_generic && istype(R, /datum/reagent/toxin)) || (R.type in remove_toxins))
			ingested.remove_reagent(R.type, removing)
			return
	for (var/datum/reagent/R in M.reagents.reagent_list)
		if ((remove_generic && istype(R, /datum/reagent/toxin)) || (R.type in remove_toxins))
			M.reagents.remove_reagent(R.type, removing)
			return



/datum/reagent/medicine/dexalin
	name = "Dexalin"
	description = "Dexalin is used in the treatment of oxygen deprivation."
	color = "#0080ff"
	value = 2.4

/datum/reagent/medicine/dexalin/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_VOX)
		M.adjustToxLoss(removed * 6)
	else if (alien != IS_DIONA && alien != IS_MANTID)
		M.add_chemical_effect(CE_OXYGENATED, 1)
	holder.remove_reagent(/datum/reagent/lexorin, 2 * removed)



/datum/reagent/medicine/dexalin_plus
	name = "Dexalin Plus"
	description = "Dexalin Plus is used in the treatment of oxygen deprivation. It is highly effective."
	color = "#0040ff"
	value = 3.7
	overdose = REAGENTS_OVERDOSE * 0.5

/datum/reagent/medicine/dexalin_plus/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_VOX)
		M.adjustToxLoss(removed * 9)
	else if (alien != IS_DIONA && alien != IS_MANTID)
		M.add_chemical_effect(CE_OXYGENATED, 2)
	holder.remove_reagent(/datum/reagent/lexorin, 3 * removed)



/datum/reagent/medicine/tricordrazine
	name = "Tricordrazine"
	description = "Tricordrazine is a highly potent stimulant, originally derived from cordrazine. Can be used to treat a wide range of injuries."
	taste_description = "grossness"
	color = "#8040ff"
	overdose = 0 // Tricordrazine doesn't OD
	value = 6

/datum/reagent/medicine/tricordrazine/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien != IS_DIONA)
		M.heal_organ_damage(3 * removed, 3 * removed)



/datum/reagent/medicine/dylovene/venaxilin
	name = "Venaxilin"
	description = "Venixalin is a strong, specialised antivenom for dealing with advanced toxins and venoms."
	taste_description = "overpowering sweetness"
	color = "#dadd98"
	metabolism = REM * 2
	remove_generic = FALSE
	remove_toxins = list(
		/datum/reagent/toxin/venom,
		/datum/reagent/toxin/carpotoxin
	)



/datum/reagent/medicine/hyronalin
	name = "Hyronalin"
	description = "Hyronalin is a medicinal drug used to counter the effect of radiation poisoning."
	color = "#408000"
	metabolism = REM * 0.25
	value = 2.3

/datum/reagent/medicine/hyronalin/affect_blood(mob/living/carbon/M, alien, removed)
	M.radiation = max(M.radiation - 30 * removed, 0)



/datum/reagent/medicine/arithrazine
	name = "Arithrazine"
	description = "Arithrazine is an unstable medication used for the most extreme cases of radiation poisoning."
	color = "#008000"
	metabolism = REM * 0.25
	value = 2.7

/datum/reagent/medicine/arithrazine/affect_blood(mob/living/carbon/M, alien, removed)
	M.radiation = max(M.radiation - 70 * removed, 0)
	M.adjustToxLoss(-10 * removed)
	if (prob(60))
		M.take_organ_damage(4 * removed, 0, ORGAN_DAMAGE_FLESH_ONLY)



/datum/reagent/medicine/peridaxon
	name = "Peridaxon"
	description = "Used to encourage recovery of internal organs and nervous systems. Medicate cautiously."
	color = "#561ec3"
	overdose = REAGENTS_OVERDOSE / 3
	value = 6

/datum/reagent/medicine/peridaxon/affect_blood(mob/living/carbon/M, alien, removed)
	if (ishuman(M))
		var/mob/living/carbon/human/H = M
		for (var/obj/item/organ/internal/I in H.internal_organs)
			if (!BP_IS_ROBOTIC(I))
				if (I.organ_tag == BP_BRAIN)
					// if we have located an organic brain, apply side effects
					H.confused++
					H.drowsyness++
					// peridaxon only heals minor brain damage
					if (I.damage >= I.min_bruised_damage)
						continue
				I.heal_damage(removed)



/datum/reagent/medicine/alkysine
	name = "Alkysine"
	description = "Alkysine is a drug used to lessen the damage to neurological tissue after a injury. Can aid in healing brain tissue."
	color = "#ffff66"
	metabolism = REM * 0.25
	value = 5.9

/datum/reagent/medicine/alkysine/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_DIONA)
		return
	M.add_chemical_effect(CE_PAINKILLER, 10)
	M.add_chemical_effect(CE_BRAIN_REGEN, 1)
	if (ishuman(M))
		var/mob/living/carbon/human/H = M
		H.confused++
		H.drowsyness++



// "Why is this core", you may be asking?
// Splended question, voice in my brain! Nanoblood is species-agnostic and type-agnostic.
// Carrying blood bags of several types for several species massively increases the logistical requirements of doctors.
// We don't endeavor to make that a big concern right now, so instead we make it easy to get and provide nanoblood easily.
/datum/reagent/medicine/nanoblood
	name = "Nanoblood"
	description = "A stable hemoglobin-based nanoparticle oxygen carrier, used to rapidly replace lost blood. Toxic unless injected in small doses. Does not contain white blood cells."
	taste_description = "blood with bubbles"
	color = "#c10158"
	overdose = 5
	metabolism = 1

/datum/reagent/medicine/nanoblood/affect_blood(var/mob/living/carbon/human/M, alien, removed)
	if (!M.should_have_organ(BP_HEART)) // We want the var for safety but we can do without the actual blood.
		return
	if (M.regenerate_blood(4 * removed))
		M.immunity = max(M.immunity - 0.75, 0)
		if (M.chem_doses[type] > M.species.blood_volume / 8) // half of blood was replaced with us, rip white bodies
			M.immunity = max(M.immunity - 3, 0)

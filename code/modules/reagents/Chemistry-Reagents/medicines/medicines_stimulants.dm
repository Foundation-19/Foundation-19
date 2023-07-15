/*
 * For our purposes, a "stimulant" is any medicine that reduces stuns, speeds you up, and generally makes you zoomy.
 * These can be very touchy for balance, which is why we categorize them so specifically.
 * Stimulants generally metabolize extremely slowly and have a low overdose threshold.
 */
/datum/reagent/medicine/stimulant
	metabolism = REM * 0.05
	overdose = REAGENTS_OVERDOSE * 0.5

/datum/reagent/medicine/stimulant/synaptizine
	name = "Synaptizine"
	description = "Synaptizine is a strong neuromuscular stimulant. It is potent, but also very toxic to the body, especially in doses higher than a few units."
	color = "#99ccff"
	overdose = REAGENTS_OVERDOSE / 6
	value = 4.6

/datum/reagent/medicine/stimulant/synaptizine/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_DIONA)
		return
	M.drowsyness = max(M.drowsyness - 5, 0)
	M.AdjustParalysis(-1)
	M.AdjustStunned(-1)
	M.AdjustWeakened(-1)
	holder.remove_reagent(/datum/reagent/mindbreaker_toxin, 5)
	M.adjust_hallucination(-10)
	M.add_chemical_effect(CE_HALLUCINATION, 2)
	M.adjustToxLoss(5 * removed) // It used to be incredibly deadly due to an oversight. Not anymore!
	M.add_chemical_effect(CE_PAINKILLER, 20)
	M.add_chemical_effect(CE_STIMULANT, 10)



/datum/reagent/medicine/stimulant/hyperzine
	name = "Hyperzine"
	description = "Hyperzine is a highly effective, long lasting muscle stimulant."
	taste_description = "acid"
	color = "#ff3300"
	metabolism = REM * 0.15
	value = 3.9

/datum/reagent/medicine/stimulant/hyperzine/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_DIONA)
		return
	if (prob(5))
		M.emote(pick("twitch", "blink_r", "shiver"))
	M.add_chemical_effect(CE_SPEEDBOOST, 1)
	M.add_chemical_effect(CE_PULSE, 3)
	M.add_chemical_effect(CE_STIMULANT, 4)

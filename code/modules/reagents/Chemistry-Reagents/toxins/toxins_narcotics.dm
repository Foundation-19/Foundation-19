// Narcotics cause confusion, dizziness, or other effects. This may be a misnomer, but screw it.

/datum/reagent/cryptobiolin
	name = "Cryptobiolin"
	description = "Cryptobiolin causes confusion and dizzyness."
	taste_description = "sourness"
	reagent_state = LIQUID
	color = "#000055"
	metabolism = REM * 0.5
	overdose = REAGENTS_OVERDOSE
	heating_point = 61 CELSIUS
	heating_products = list(/datum/reagent/potassium, /datum/reagent/acetone, /datum/reagent/sugar)
	heating_prod_english = "potassium, acetone, and sugar"
	value = 2

/datum/reagent/cryptobiolin/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_DIONA)
		return
	var/drug_strength = 4
	if (alien == IS_SKRELL)
		drug_strength = drug_strength * 0.8
	M.make_dizzy(drug_strength)
	M.confused = max(M.confused, drug_strength * 5)



/datum/reagent/impedrezene // Impairs mental function correctly, takes an overwhelming dose to kill.
	name = "Impedrezene"
	description = "Impedrezene is a narcotic that impedes one's ability by slowing down the higher brain cell functions."
	taste_description = "numbness"
	reagent_state = LIQUID
	color = "#c8a5dc"
	overdose = REAGENTS_OVERDOSE
	value = 1.8

/datum/reagent/impedrezene/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_DIONA)
		return
	M.jitteriness = max(M.jitteriness - 5, 0)
	M.add_chemical_effect(M.add_chemical_effect(CE_SLOWDOWN, 1))

	if (prob(80))
		M.confused = max(M.confused, 10)
	if (prob(50))
		M.drowsyness = max(M.drowsyness, 3)
	if (prob(10))
		M.emote("drool")
		M.apply_effect(STUTTER, 3)

	if (M.getBrainLoss() < 60)
		M.adjustBrainLoss(14 * removed)
	else
		M.adjustBrainLoss(7 * removed)

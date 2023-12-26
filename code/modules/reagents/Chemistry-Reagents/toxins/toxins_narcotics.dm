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
	heating_prod_english = "<span codexlink='potassium (chemical)'>potassium</span>, <span codexlink='acetone (chemical)'>acetone</span>, and <span codexlink='sugar (chemical)'>sugar</span>"
	value = 2

/datum/reagent/cryptobiolin/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_DIONA)
		return
	var/drug_strength = 4 SECONDS
	if (alien == IS_SKRELL)
		drug_strength = drug_strength * 0.8
	M.adjust_dizzy(drug_strength)
	M.set_confusion_if_lower(drug_strength * 3)



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
	M.adjust_jitter(-5 SECONDS * removed)
	M.add_chemical_effect(M.add_chemical_effect(CE_SLOWDOWN, 1))

	if (prob(80))
		M.set_confusion_if_lower(10 SECONDS)
	if (prob(50))
		M.set_drowsiness_if_lower(3 SECONDS)
	if (prob(10))
		M.emote("drool")
		M.apply_effect(STUTTER, 3)

	if (M.getBrainLoss() < 60)
		M.adjustBrainLoss(14 * removed)
	else
		M.adjustBrainLoss(7 * removed)

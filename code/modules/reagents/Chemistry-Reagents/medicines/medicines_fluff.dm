
// Reagents in this file should have little to no mechanical effect, and instead be focused on roleplay!

/datum/reagent/medicine/fluff
	metabolism = REM * 0.1
	overdose = 0 // No risk of OD from fluff chems
	data = 0

// Antidexafen technically has antiviral effects, but viruses don't currently exist, making it do nothing.
// The painkiller value is very very low, too, so it's only for boo-boos and not for that sucking chest wound.
/datum/reagent/medicine/fluff/antidexafen
	name = "Antidexafen"
	description = "All-in-one cold medicine. Fever, cough, sneeze, safe for babies."
	taste_description = "cough syrup"
	color = "#c8a5dc"

/datum/reagent/medicine/fluff/antidexafen/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_DIONA)
		return
	M.add_chemical_effect(CE_PAINKILLER, 5)
	M.add_chemical_effect(CE_ANTIVIRAL, 1)

// We classify nicotine and tobacco as a medicine for ease of coding, and because we can't simulate lung cancer after several years of use.
/datum/reagent/medicine/fluff/nicotine
	name = "Nicotine"
	description = "A sickly yellow liquid sourced from tobacco leaves. Stimulates and relaxes the mind and body."
	taste_description = "peppery bitterness"
	color = "#efebaa"
	overdose = REAGENTS_OVERDOSE / 6
	data = 0
	value = 2

/datum/reagent/medicine/fluff/nicotine/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_DIONA)
		return
	if (prob(volume * 20))
		M.add_chemical_effect(CE_PULSE, 1)
	if (volume <= 0.02 && M.chem_doses[type] >= 0.05 && world.time > data + ANTIDEPRESSANT_MESSAGE_DELAY * 0.3)
		data = world.time
		to_chat(M, SPAN_WARNING("You feel antsy, your concentration wavers..."))
	else
		if (world.time > data + ANTIDEPRESSANT_MESSAGE_DELAY * 0.3)
			data = world.time
			to_chat(M, SPAN_NOTICE("You feel invigorated and calm."))

/datum/reagent/medicine/fluff/nicotine/overdose(mob/living/carbon/M, alien)
	..()
	M.add_chemical_effect(CE_PULSE, 2)

/datum/reagent/medicine/fluff/tobacco
	name = "Tobacco"
	description = "Cut and processed tobacco leaves."
	taste_description = "tobacco"
	reagent_state = SOLID
	color = "#684b3c"
	value = 3
	scent = "cigarette smoke"
	scent_descriptor = SCENT_DESC_ODOR
	scent_range = 4

	/// Each time tobacco ticks, it will add this amount of nicotine to its consumer's body.
	var/nicotine_ratio = REM * 0.2

/datum/reagent/medicine/fluff/tobacco/affect_blood(mob/living/carbon/M, alien, removed)
	..()
	M.reagents.add_reagent(/datum/reagent/medicine/fluff/nicotine, nicotine_ratio)

/datum/reagent/medicine/fluff/tobacco/fine
	name = "Fine Tobacco"
	taste_description = "fine tobacco"
	value = 5
	scent = "fine tobacco smoke"
	scent_descriptor = SCENT_DESC_FRAGRANCE

/datum/reagent/medicine/fluff/tobacco/bad
	name = "Terrible Tobacco"
	taste_description = "acrid smoke"
	value = 0
	scent = "acrid tobacco smoke"
	scent_intensity = /decl/scent_intensity/strong
	scent_descriptor = SCENT_DESC_ODOR

/datum/reagent/medicine/fluff/tobacco/liquid
	name = "Nicotine Solution"
	description = "A diluted nicotine solution."
	taste_mult = 0
	color = "#fcfcfc"
	nicotine_ratio = REM * 0.1
	scent = null
	scent_intensity = null
	scent_descriptor = null
	scent_range = null

/datum/reagent/medicine/fluff/menthol
	name = "Menthol"
	description = "Tastes naturally minty, and imparts a very mild numbing sensation."
	taste_description = "mint"
	color = "#80af9c"
	data = 0

/datum/reagent/medicine/fluff/menthol/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_DIONA)
		return
	if (world.time > data + ANTIDEPRESSANT_MESSAGE_DELAY * 0.35)
		data = world.time
		to_chat(M, SPAN_NOTICE("You feel faintly sore in the throat."))

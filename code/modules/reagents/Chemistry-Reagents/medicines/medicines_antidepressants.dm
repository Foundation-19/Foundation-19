#define ANTIDEPRESSANT_MESSAGE_DELAY 5 MINUTES
/**
 * Antidepressants are meant to primarily heal sanity damage dealt to one's mind
 * although over some time.
 * Other effects depend on subtype.
 */

/datum/reagent/medicine/antidepressant
	ingest_met = REM
	metabolism = REM
	overdose = 10


/datum/reagent/medicine/antidepressant/citalopram
	name = "Citalopram"
	description = "Stabilizes the mind a little."
	color = "#ff80ff"
	value = 6

/datum/reagent/medicine/antidepressant/citalopram/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_DIONA)
		return
	M.add_chemical_effect(CE_SANITY, 1) // about 120u required to go from insane to full sane
	if (volume <= 0.1 && M.chem_doses[type] >= 0.5 && world.time > data + ANTIDEPRESSANT_MESSAGE_DELAY)
		data = world.time
		to_chat(M, SPAN_WARNING("Your mind feels a little less stable..."))
		M.add_chemical_effect(CE_SANITY, -2)
	else
		M.add_chemical_effect(CE_HALLUCINATION, 1)
		if (world.time > data + ANTIDEPRESSANT_MESSAGE_DELAY)
			data = world.time
			to_chat(M, SPAN_NOTICE("Your mind feels stable... a little stable."))

/datum/reagent/medicine/antidepressant/paroxetine
	name = "Paroxetine"
	description = "Stabilizes the mind greatly, but has a chance of adverse effects."
	color = "#ff80bf"
	value = 3.5

/datum/reagent/medicine/antidepressant/paroxetine/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_DIONA)
		return
	M.add_chemical_effect(CE_SANITY, 2)
	if (volume <= 0.1 && M.chem_doses[type] >= 0.5 && world.time > data + ANTIDEPRESSANT_MESSAGE_DELAY)
		data = world.time
		to_chat(M, SPAN_WARNING("Your mind feels much less stable..."))
		M.add_chemical_effect(CE_SANITY, -4)
	else
		M.add_chemical_effect(CE_HALLUCINATION, 2)
		if (world.time > data + ANTIDEPRESSANT_MESSAGE_DELAY)
			data = world.time
			if (prob(99))
				to_chat(M, SPAN_NOTICE("Your mind feels much more stable."))
			else
				to_chat(M, SPAN_WARNING("Your mind breaks apart..."))
				M.add_chemical_effect(CE_SANITY, -30)
				M.hallucination(200, 100)

/datum/reagent/medicine/antidepressant/methylphenidate
	name = "Methylphenidate"
	description = "Improves the ability to concentrate."
	taste_description = "sourness"
	color = "#bf80bf"
	value = 6

/datum/reagent/medicine/antidepressant/methylphenidate/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_DIONA)
		return
	if (volume <= 0.1 && M.chem_doses[type] >= 0.5 && world.time > data + ANTIDEPRESSANT_MESSAGE_DELAY)
		data = world.time
		to_chat(M, SPAN_WARNING("You lose focus..."))
		M.add_chemical_effect(CE_SANITY, -3)
	else
		if (world.time > data + ANTIDEPRESSANT_MESSAGE_DELAY)
			data = world.time
			to_chat(M, SPAN_NOTICE("Your mind feels focused and undivided."))
			M.add_chemical_effect(CE_SANITY, 6)

/datum/reagent/medicine/antidepressant/anomalous_happiness
	name = "Anomalous happiness"
	description = "Poorly-understood parachemicals produced while around certain anomalies."
	taste_description = "happiness"
	color = "#f7f97a"
	value = 10

/datum/reagent/medicine/antidepressant/anomalous_happiness/affect_blood(mob/living/carbon/M, alien, removed)
	M.add_chemical_effect(CE_SANITY, 2)
	if (world.time > data + 1 MINUTE)
		data = world.time
		M.emote(pick("smile","grin"))

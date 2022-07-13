/**
 * Painkillers have unified effects in that they all nullify pain to some degree.
 * By default, painkillers metabolize a quarter as fast as other medicines.
 * As with any reagent, other effects depend on subtype.
 */
/datum/reagent/medicine/painkiller
	ingest_met = REM * 0.25
	metabolism = REM * 0.25

	/// Opiates don't mix with alcohol, and will cause adverse effects if taken with them.
	var/is_opiate = FALSE
	/// This reagent will apply a CE_PAINKILLER effect of this magnitude when it processes.
	var/current_painkiller_strength = 10
	/// Certain medicines may "ramp up" to maximum strength, which is defined by this value.
	var/target_painkiller_strength = 10

/datum/reagent/medicine/painkiller/affect_blood(mob/living/carbon/M, alien, removed)
	calculate_strength(M, alien, removed)
	M.add_chemical_effect(CE_PAINKILLER, current_painkiller_strength)
	handle_effects(M, alien, removed)
	var/booze_factor = is_boozed(M)
	if (is_opiate && booze_factor)
		handle_alcohol_poisoning(M, alien, removed, booze_factor)

/// Used to adjust the medicine's current strength relative to its target strength. By default, painkillers are instantly at full effectiveness.
/datum/reagent/medicine/painkiller/proc/calculate_strength(mob/living/carbon/M, alien, removed)
	current_painkiller_strength = target_painkiller_strength

/// Called whenever this medicine ticks. Runs after `calculate_strength`.
/datum/reagent/medicine/painkiller/proc/handle_effects(mob/living/carbon/M, alien, removed)
	return

/// Handles adverse effects caused by mixing this painkiller with alcohol.
/datum/reagent/medicine/painkiller/proc/handle_alcohol_poisoning(mob/living/carbon/M, alien, removed, booze_factor = 1)
	M.add_chemical_effect(CE_ALCOHOL_TOXIC, 1)
	M.add_chemical_effect(CE_BREATHLOSS, 0.1 * booze_factor)

/// Returns 0 if the patient has no alcohol in their body, 1 if they have some alcohol, and 2 if they have strong alcohol.
/datum/reagent/medicine/painkiller/proc/is_boozed(mob/living/carbon/M)
	. = 0
	var/datum/reagents/ingested = M.get_ingested_reagents()
	if (ingested)
		var/list/pool = M.reagents.reagent_list | ingested.reagent_list
		for (var/datum/reagent/ethanol/booze in pool)
			if (M.chem_doses[booze.type] < 2) //let them experience false security at first
				continue
			. = 1
			if (booze.strength < 40) //liquor stuff hits harder
				return 2



/datum/reagent/medicine/painkiller/paracetamol
	name = "Paracetamol"
	description = "A medication that treats fever, soreness, and mild pain."
	taste_description = "sickness"
	color = "#c8a5dc"
	overdose = REAGENTS_OVERDOSE * 2
	value = 3.3
	target_painkiller_strength = 35

/datum/reagent/medicine/painkiller/paracetamol/overdose(mob/living/carbon/M, alien)
	M.add_chemical_effect(CE_TOXIN, 1)
	M.druggy = max(M.druggy, 2)
	M.add_chemical_effect(CE_PAINKILLER, 10)



/datum/reagent/medicine/painkiller/tramadol
	name = "Tramadol"
	description = "A simple, yet effective painkiller. Don't mix with alcohol."
	taste_description = "sourness"
	color = "#cb68fc"
	value = 3.1
	is_opiate = TRUE
	target_painkiller_strength = 80
	/// Tramadol and its derivatives process this many units before reaching maximum strength.
	var/effective_dose = 0.5

/datum/reagent/medicine/painkiller/tramadol/calculate_strength(mob/living/carbon/M, alien, removed)
	var/effectiveness = 1
	if (M.chem_doses[type] < effective_dose) //some ease-in ease-out for the effect
		effectiveness = M.chem_doses[type] / effective_dose
	else if (volume < effective_dose)
		effectiveness = volume / effective_dose
	current_painkiller_strength = (target_painkiller_strength * effectiveness)

/datum/reagent/medicine/painkiller/tramadol/handle_effects(mob/living/carbon/M, alien, removed)
	if (M.chem_doses[type] > 0.5 * overdose)
		M.add_chemical_effect(CE_SLOWDOWN, 1)
		if (prob(1))
			M.slurring = max(M.slurring, 10)
	if (M.chem_doses[type] > 0.75 * overdose)
		M.add_chemical_effect(CE_SLOWDOWN, 1)
		if (prob(5))
			M.slurring = max(M.slurring, 20)

/datum/reagent/medicine/painkiller/tramadol/overdose(mob/living/carbon/M, alien)
	..()
	M.add_chemical_effect(CE_SLOWDOWN, 1)
	M.slurring = max(M.slurring, 30)
	M.hallucination(120, 30)
	M.druggy = max(M.druggy, 10)
	M.add_chemical_effect(CE_PAINKILLER, current_painkiller_strength * 0.5) //extra painkilling for extra trouble
	M.add_chemical_effect(CE_BREATHLOSS, 0.6) // Have trouble breathing, need more air
	if (is_boozed(M))
		M.add_chemical_effect(CE_BREATHLOSS, 0.2) //Don't drink and OD on opiates folks
	if (prob(1))
		M.Weaken(2)
		M.drowsyness = max(M.drowsyness, 5)



/datum/reagent/medicine/painkiller/tramadol/oxycodone
	name = "Oxycodone"
	description = "An effective and very addictive painkiller. Don't mix with alcohol."
	taste_description = "bitterness"
	color = "#800080"
	metabolism = REM * 0.1
	target_painkiller_strength = 200
	effective_dose = 2



/datum/reagent/medicine/painkiller/deletrathol
	name = "Deletrathol"
	description = "An effective painkiller that causes confusion."
	taste_description = "confusion"
	color = "#800080"
	metabolism = REM * 0.1
	overdose = REAGENTS_OVERDOSE * 0.5
	target_painkiller_strength = 80

/datum/reagent/medicine/painkiller/deletrathol/handle_effects(mob/living/carbon/M, alien, removed)
	M.add_chemical_effect(CE_SLOWDOWN, 1)
	M.make_dizzy(2)
	if (prob(75))
		M.drowsyness++
	if (prob(25))
		M.confused++

/datum/reagent/medicine/painkiller/deletrathol/overdose(mob/living/carbon/M, alien)
	..()
	M.druggy = max(M.druggy, 2)
	M.add_chemical_effect(CE_PAINKILLER, 10)

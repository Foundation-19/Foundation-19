// Medicines in this file have no obvious other place to go.
// It differs from medicines_special.dm in that they just don't have a place, instead of being very unique.

/datum/reagent/medicine/noexcutite
	name = "Noexcutite"
	description = "A thick, syrupy liquid that has a lethargic effect. Used to cure cases of jitteriness."
	taste_description = "numbing coldness"
	color = "#bc018a"

/datum/reagent/medicine/noexcutite/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien != IS_DIONA)
		M.adjust_jitter(-50 SECONDS * removed)


/datum/reagent/medicine/ethylredoxrazine
	name = "Ethylredoxrazine"
	description = "A powerful oxidizer that reacts with ethanol."
	reagent_state = SOLID
	color = "#605048"
	value = 3.1

/datum/reagent/medicine/ethylredoxrazine/affect_blood(mob/living/carbon/M, alien, removed)
	if(alien == IS_DIONA)
		return

	M.adjust_dizzy(-10 SECONDS * removed)
	M.adjust_drowsiness(-10 SECONDS * removed)
	M.adjust_stutter(-10 SECONDS * removed)
	M.adjust_confusion(-5 SECONDS * removed)
	var/datum/reagents/ingested = M.get_ingested_reagents()
	if(ingested)
		for(var/datum/reagent/R in ingested.reagent_list)
			if(istype(R, /datum/reagent/ethanol))
				M.chem_doses[R.type] = max(M.chem_doses[R.type] - removed * 5, 0)
	// Helps with alcohol addiction slightly
	M.RemoveAddictionPoints(/datum/addiction/alcohol, removed * 5)

/datum/reagent/medicine/naltrexone
	name = "Naltrexone"
	description = "A medication primarily used to manage alcohol, opioid and other minor drug addictions. Should not be taken in cases of liver damage."
	reagent_state = LIQUID
	color = "#f0e962"
	value = 3.1
	/// List of addiction type paths and amount of points it will remove from them per unit
	var/list/affected_addictions = list(
		/datum/addiction/alcohol = 3,
		/datum/addiction/opiate = 3,
		/datum/addiction/hallucinogens = 3,
		)

/datum/reagent/medicine/naltrexone/affect_blood(mob/living/carbon/M, alien, removed)
	if(alien == IS_DIONA)
		return

	// Side effects
	if(prob(15))
		M.adjust_dizzy_up_to(15 SECONDS, 50 SECONDS)
	if(prob(15))
		M.adjust_confusion_up_to(5 SECONDS, 50 SECONDS)
	// With liver damage, it will worsen it
	var/obj/item/organ/internal/liver/L = M.internal_organs_by_name[BP_LIVER]
	if(istype(L) && L.damage >= 5)
		L.take_general_damage(min(2, L.damage * 0.1))
	// At small doses, acts as minor painkiller
	if(volume <= 5)
		M.add_chemical_effect(CE_PAINKILLER, 10)
	// Helps with various addictions
	for(var/addiction_type in affected_addictions)
		M.RemoveAddictionPoints(addiction_type, removed * affected_addictions[addiction_type])

/datum/reagent/medicine/varenicline
	name = "Varenicline"
	description = "A medication used for smoking cessation and for the treatment of blurry vision."
	reagent_state = LIQUID
	color = "#c0e1ed"
	value = 3.1

/datum/reagent/medicine/varenicline/affect_blood(mob/living/carbon/M, alien, removed)
	if(alien == IS_DIONA)
		return

	// Side effects
	if(prob(15))
		M.adjust_drugginess_up_to(15 SECONDS, 50 SECONDS)
	if(prob(1) && ishuman(M))
		var/mob/living/carbon/human/H = M
		H.vomit()
	// Fluff messages
	if(prob(3))
		to_chat(M, SPAN_WARNING("Your head hurts!"))
	// Slightly helps fix blurry vision
	M.adjust_eye_blur(-2 SECONDS * removed)
	// Helps with nicotine addiction
	M.RemoveAddictionPoints(/datum/addiction/nicotine, removed * 5)

/datum/reagent/medicine/imidazoline
	name = "Imidazoline"
	description = "A compound that treats damage to the eyes and ocular nerves. Since it treats the underlying tissue, it can heal synthetic eyes as well as organic ones."
	taste_description = "dull toxin"
	color = "#c8a5dc"
	value = 4.2

/datum/reagent/medicine/imidazoline/affect_blood(mob/living/carbon/M, alien, removed)
	M.adjust_eye_blur(-5 SECONDS * removed)
	M.adjust_temp_blindness(-5 SECONDS)
	if (ishuman(M))
		var/mob/living/carbon/human/H = M
		var/obj/item/organ/internal/eyes/E = H.internal_organs_by_name[BP_EYES]
		if (E && istype(E))
			if (E.damage > 0)
				E.damage = max(E.damage - 5 * removed, 0)

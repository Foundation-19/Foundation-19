// Medicines in this file have no obvious other place to go.
// It differs from medicines_special.dm in that they just don't have a place, instead of being very unique.

/datum/reagent/medicine/noexcutite
	name = "Noexcutite"
	description = "A thick, syrupy liquid that has a lethargic effect. Used to cure cases of jitteriness."
	taste_description = "numbing coldness"
	color = "#bc018a"

/datum/reagent/medicine/noexcutite/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien != IS_DIONA)
		M.make_jittery(-50)



/datum/reagent/medicine/ethylredoxrazine
	name = "Ethylredoxrazine"
	description = "A powerful oxidizer that reacts with ethanol."
	reagent_state = SOLID
	color = "#605048"
	value = 3.1

/datum/reagent/medicine/ethylredoxrazine/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_DIONA)
		return
	M.dizziness = 0
	M.drowsyness = 0
	M.stuttering = 0
	M.confused = 0
	var/datum/reagents/ingested = M.get_ingested_reagents()
	if (ingested)
		for (var/datum/reagent/R in ingested.reagent_list)
			if (istype(R, /datum/reagent/ethanol))
				M.chem_doses[R.type] = max(M.chem_doses[R.type] - removed * 5, 0)



/datum/reagent/medicine/imidazoline
	name = "Imidazoline"
	description = "A compound that treats damage to the eyes and ocular nerves. Since it treats the underlying tissue, it can heal synthetic eyes as well as organic ones."
	taste_description = "dull toxin"
	color = "#c8a5dc"
	value = 4.2

/datum/reagent/medicine/imidazoline/affect_blood(mob/living/carbon/M, alien, removed)
	M.eye_blurry = max(M.eye_blurry - 5, 0)
	M.eye_blind = max(M.eye_blind - 5, 0)
	if (ishuman(M))
		var/mob/living/carbon/human/H = M
		var/obj/item/organ/internal/eyes/E = H.internal_organs_by_name[BP_EYES]
		if (E && istype(E))
			if (E.damage > 0)
				E.damage = max(E.damage - 5 * removed, 0)

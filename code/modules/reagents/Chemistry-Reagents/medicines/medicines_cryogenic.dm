/**
 * Cryogenic reagents only work at extremely low body temperatures.
 * This is 170K by default (-153F or -103C) but can be configured by subtypes.
 * By default, cryogenic reagents cannot overdose, and metabolize more slowly.
 */
/datum/reagent/medicine/cryogenic
	metabolism = REM * 0.5
	overdose = 0
	/// Minimum body temperature (in Kelvin) required for this chemical to take its unique effects.
	var/temperature_threshold = 170

/datum/reagent/medicine/cryogenic/affect_blood(mob/living/carbon/M, alien, removed)
	M.add_chemical_effect(CE_CRYO, 1)
	if (M.bodytemperature < temperature_threshold)
		handle_effects(M, alien, removed)

/// Called each time the medicine ticks when the mob's body temperature is below `temperature_threshold`.
/datum/reagent/medicine/cryogenic/proc/handle_effects(mob/living/carbon/M, alien, removed)
	return



/datum/reagent/medicine/cryogenic/cryoxadone
	name = "Cryoxadone"
	description = "A chemical mixture with extremely potent regenerative capabilities. Its main limitation is that a patient's body temperature must be under 170 degrees Kelvin for it to take effect."
	taste_description = "sludge"
	color = "#8080ff"
	value = 3.9

/datum/reagent/medicine/cryogenic/cryoxadone/handle_effects(mob/living/carbon/M, alien, removed)
	M.adjustCloneLoss(-100 * removed)
	M.add_chemical_effect(CE_OXYGENATED, 1)
	M.heal_organ_damage(30 * removed, 30 * removed)
	M.add_chemical_effect(CE_PULSE, -2)
	if (ishuman(M))
		var/mob/living/carbon/human/H = M
		for (var/obj/item/organ/internal/I in H.internal_organs)
			if (!BP_IS_ROBOTIC(I))
				I.heal_damage(20 * removed)



/datum/reagent/medicine/cryogenic/clonexadone
	name = "Clonexadone"
	description = "Cryoxadone that has been chemically refined and concentrated. It is especially effective at treating genetic degredation."
	taste_description = "slime"
	color = "#80bfff"
	heating_products = list(/datum/reagent/medicine/cryogenic/cryoxadone, /datum/reagent/sodium)
	heating_prod_english = "cryoxadone and sodium"
	heating_point = 50 CELSIUS
	heating_message = "turns back to sludge."
	value = 5.5

/datum/reagent/medicine/cryogenic/clonexadone/handle_effects(mob/living/carbon/M, alien, removed)
	M.adjustCloneLoss(-300 * removed)
	M.add_chemical_effect(CE_OXYGENATED, 2)
	M.heal_organ_damage(50 * removed, 50 * removed)
	M.add_chemical_effect(CE_PULSE, -2)
	if (ishuman(M))
		var/mob/living/carbon/human/H = M
		for (var/obj/item/organ/internal/I in H.internal_organs)
			if (!BP_IS_ROBOTIC(I))
				I.heal_damage(30 * removed)



/datum/reagent/medicine/cryogenic/nanite_fluid
	name = "Nanite Fluid"
	description = "A solution of repair nanites used to repair robotic organs. Due to the nature of the small magnetic fields used to guide the nanites, it must be used in temperatures below 170K."
	taste_description = "metallic sludge"
	color = "#c2c2d6"

/datum/reagent/medicine/cryogenic/nanite_fluid/handle_effects(mob/living/carbon/M, alien, removed)
	M.heal_organ_damage(30 * removed, 30 * removed, affect_robo = TRUE)
	if (ishuman(M))
		var/mob/living/carbon/human/H = M
		for (var/obj/item/organ/internal/I in H.internal_organs)
			if (BP_IS_ROBOTIC(I))
				I.heal_damage(20 * removed)

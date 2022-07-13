/**
 * Template reagent used for toxins, poisons, venoms, and so on.
 * This particular subtype deals toxin damage to the body's organs.
 * Many "toxic" reagents don't actually deal straight toxin damage, so only the minority of reagents actually use this subtype.
 *
 * Of note: Unlike `/datum/reagent/medicine`, this type is not just for inheritance, and it can be found in a few different places.
 */
/datum/reagent/toxin
	name = "Toxin"
	description = "A toxic chemical."
	taste_description = "bitterness"
	taste_mult = 1.2
	reagent_state = LIQUID
	color = "#cf3600"
	metabolism = REM * 0.25 // 0.05 by default. They last a while and slowly kill you.
	heating_products = list(/datum/reagent/toxin/denatured)
	heating_point = 100 CELSIUS
	heating_message = "goes clear."
	value = 2
	should_admin_log = TRUE

	/// If applicable, a specific organ that this toxin will target, dealing extra damage to it directly.
	var/target_organ
	/// How much toxin damage this chemicals deals per unit.
	var/strength = 4

/datum/reagent/toxin/affect_blood(mob/living/carbon/M, alien, removed)
	if (strength && alien != IS_DIONA)
		M.add_chemical_effect(CE_TOXIN, strength)
		var/dam = (strength * removed)
		if (target_organ && ishuman(M))
			var/mob/living/carbon/human/H = M
			var/obj/item/organ/internal/I = H.internal_organs_by_name[target_organ]
			if (I)
				var/can_damage = I.max_damage - I.damage
				if (can_damage > 0)
					if (dam > can_damage)
						I.take_internal_damage(can_damage, silent = TRUE)
						dam -= can_damage
					else
						I.take_internal_damage(dam, silent = TRUE)
						dam = 0
		if (dam)
			M.adjustToxLoss(target_organ ? (dam * 0.75) : dam)

/// Denatured toxin is a special toxin that doesn't actually do anything, and is created by heating other poisons to high temperatures.
/datum/reagent/toxin/denatured
	name = "Denatured Toxin"
	description = "This is the remnants of a chemical that was once toxic, but has been rendered harmless, usually by high temperatures."
	taste_description = null
	taste_mult = null
	color = "#808080"
	metabolism = REM
	heating_products = null
	heating_point = null

	target_organ = null
	strength = 0

/*
	Because of the wide range of awful things reagents can do to you, "toxin" is just a blanket term for reagents that are generally harmful.
	As a result, we have a lot of subfiles under this folder, only a few of which contain the kinds of poisons that kill you dead.
	Further reagent types are sorted into subfiles in this folder.

	toxins_acids.dm - Corrosive liquids that cause heavy burn damage and melt objects.
	toxins_botany.dm - Reagents used in plant care that also happen to be toxic.
	toxins_drugs.dm - Drugs that are either negative to health or would, in-character, impair function.
	toxins_misc.dm - Things that are toxic, but don't fit anywhere else.
	toxins_mutagens.dm - Chemicals that cause physical mutations in their victims.
	toxins_narcotics.dm - Reagents that affect movement or the brain.
	toxins_poisons.dm - Horrible things that cause other horrible things to happen.
	toxins_sedatives.dm - Chemicals that are primarily used to incapacitate or put people to sleep.
*/

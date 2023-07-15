// Medicines that deviate from the norm in their effects. They might manipulate the immune system, or so on.

// Adrenaline is technically a stimulant, but it's special because humans produce it on their own when taking high damage.
/datum/reagent/medicine/adrenaline
	name = "Adrenaline"
	description = "Adrenaline is a hormone used as a drug to treat cardiac arrest and other cardiac dysrhythmias resulting in diminished or absent cardiac output."
	taste_description = "rush"
	color = "#c8a5dc"
	metabolism = REM * 0.5
	value = 2

/datum/reagent/medicine/adrenaline/affect_blood(mob/living/carbon/human/M, alien, removed)
	if (alien == IS_DIONA)
		return

	if (M.chem_doses[type] < 0.2)	//not that effective after initial rush
		M.add_chemical_effect(CE_PAINKILLER, min(30 * volume, 80))
		M.add_chemical_effect(CE_PULSE, 1)
	else if (M.chem_doses[type] < 1)
		M.add_chemical_effect(CE_PAINKILLER, min(10 * volume, 20))
	M.add_chemical_effect(CE_PULSE, 2)
	M.add_chemical_effect(CE_STIMULANT, 2)
	if (M.chem_doses[type] > 10)
		M.make_jittery(5)
	if (volume >= 5 && M.is_asystole())
		remove_self(5)
		if (M.resuscitate())
			var/obj/item/organ/internal/heart = M.internal_organs_by_name[BP_HEART]
			heart.take_internal_damage(heart.max_damage * 0.075)



/datum/reagent/lactic_acid
	name = "Lactic Acid"
	description = "Also called lactate, lactic acid is produced by the body during strenuous exercise. It often correlates with elevated heart rate, shortness of breath, and general exhaustion."
	taste_description = "sourness"
	color = "#eeddcc"

/datum/reagent/lactic_acid/affect_blood(mob/living/carbon/human/M, alien, removed)
	if (alien == IS_DIONA)
		return
	M.add_chemical_effect(CE_PULSE, 1)
	M.add_chemical_effect(CE_BREATHLOSS, 0.02 * volume)
	if (volume >= 5)
		M.add_chemical_effect(CE_PULSE, 1)
		M.add_chemical_effect(CE_SLOWDOWN, (volume / 5) ** 2)
	else if (M.chem_doses[type] > 20) //after prolonged exertion
		M.make_jittery(10)



/datum/reagent/medicine/spaceacillin
	name = "Spaceacillin"
	description = "An all-purpose antiviral agent."
	color = "#c1c1c1"
	metabolism = REM * 0.1
	overdose = REAGENTS_OVERDOSE * 0.5
	value = 2.5

/datum/reagent/medicine/spaceacillin/affect_blood(mob/living/carbon/M, alien, removed)
	M.immunity = max(M.immunity - 0.1, 0)
	M.add_chemical_effect(CE_ANTIVIRAL, VIRUS_COMMON)
	M.add_chemical_effect(CE_ANTIBIOTIC, 1)
	if (volume > 10)
		M.immunity = max(M.immunity - 0.3, 0)
		M.add_chemical_effect(CE_ANTIVIRAL, VIRUS_ENGINEERED)
	if (M.chem_doses[type] > 15)
		M.immunity = max(M.immunity - 0.25, 0)

/datum/reagent/medicine/spaceacillin/overdose(mob/living/carbon/M, alien)
	..()
	M.immunity = max(M.immunity - 0.25, 0)
	M.add_chemical_effect(CE_ANTIVIRAL, VIRUS_EXOTIC)
	if (prob(2))
		M.immunity_norm = max(M.immunity_norm - 1, 0)



/datum/reagent/medicine/immunobooster
	name = "Immunobooster"
	description = "A drug that helps restore the immune system. Will not replace a normal immunity, and is toxic when taken with spaceacillin."
	taste_description = "chalk"
	color = "#ffc0cb"
	value = 1.5

/datum/reagent/medicine/immunobooster/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_DIONA)
		return
	if (volume < REAGENTS_OVERDOSE && !M.chem_effects[CE_ANTIVIRAL])
		M.immunity = min(M.immunity_norm * 0.5, removed + M.immunity) // Rapidly brings someone up to half immunity.
	if (M.chem_effects[CE_ANTIVIRAL]) // don't take with 'cillin
		M.add_chemical_effect(CE_TOXIN, 4) // as strong as taking vanilla 'toxin'

/datum/reagent/medicine/immunobooster/overdose(mob/living/carbon/M, alien)
	..()
	M.add_chemical_effect(CE_TOXIN, 1)
	M.immunity -= 0.5 // inverse effects when abused



/datum/reagent/medicine/leporazine
	name = "Leporazine"
	description = "Leporazine can be use to stabilize an individuals body temperature."
	color = "#c8a5dc"
	chilling_products = list(/datum/reagent/medicine/leporazine/cold)
	chilling_prod_english = "<span codexlink='cryogenic leporazine (chemical)'>cryogenic leporazine</span>"
	chilling_point = -10 CELSIUS
	chilling_message = "Takes on the consistency of slush."
	heating_products = list(/datum/reagent/medicine/leporazine/hot)
	heating_prod_english = "<span codexlink='pyrogenic leporazine (chemical)'>pyrogenic leporazine</span>"
	heating_point = 110 CELSIUS
	heating_message = "starts swirling, glowing occasionally."
	value = 2

/datum/reagent/medicine/leporazine/affect_blood(mob/living/carbon/M, alien, removed)
	if (M.bodytemperature > 310)
		M.bodytemperature = max(310, M.bodytemperature - (40 * TEMPERATURE_DAMAGE_COEFFICIENT))
	else if (M.bodytemperature < 311)
		M.bodytemperature = min(310, M.bodytemperature + (40 * TEMPERATURE_DAMAGE_COEFFICIENT))

/datum/reagent/medicine/leporazine/hot
	name = "Pyrogenic Leporazine"
	chilling_products = list(/datum/reagent/medicine/leporazine)
	chilling_prod_english = "<span codexlink='leporazine (chemical)'>leporazine</span>"
	chilling_point = 0 CELSIUS
	chilling_message = "Stops swirling and glowing."
	heating_products = null
	heating_point = null
	heating_message = null

/datum/reagent/medicine/leporazine/hot/affect_blood(mob/living/carbon/M, alien, removed)
	if (M.bodytemperature < 330)
		M.bodytemperature = min(330, M.bodytemperature + (40 * TEMPERATURE_DAMAGE_COEFFICIENT))

/datum/reagent/medicine/leporazine/cold
	name = "Cryogenic Leporazine"
	chilling_products = null
	chilling_point = null
	chilling_message = null
	heating_products = list(/datum/reagent/medicine/leporazine)
	heating_prod_english = "<span codexlink='leporazine (chemical)'>leporazine</span>"
	heating_point = 100 CELSIUS
	heating_message = "Becomes clear and smooth."

/datum/reagent/medicine/leporazine/cold/affect_blood(mob/living/carbon/M, alien, removed)
	if (M.bodytemperature > 290)
		M.bodytemperature = max(290, M.bodytemperature - (40 * TEMPERATURE_DAMAGE_COEFFICIENT))



/datum/reagent/medicine/ryetalyn
	name = "Ryetalyn"
	description = "Ryetalyn can cure all genetic abnomalities via a catalytic process."
	taste_description = "acid"
	reagent_state = SOLID
	color = "#004000"
	value = 3.6

/datum/reagent/medicine/ryetalyn/affect_blood(mob/living/carbon/M, alien, removed)
	var/needs_update = M.mutations.len > 0

	M.disabilities = 0
	M.sdisabilities = 0

	if (needs_update && ishuman(M))
		M.dna.ResetUI()
		M.dna.ResetSE()
		domutcheck(M, null, MUTCHK_FORCED)



/datum/reagent/medicine/rezadone
	name = "Rezadone"
	description = "A powder with almost magical properties, this substance can effectively treat genetic damage in humanoids, though excessive consumption has side effects."
	taste_description = "sickness"
	reagent_state = SOLID
	color = "#669900"
	value = 5

/datum/reagent/medicine/rezadone/affect_blood(mob/living/carbon/M, alien, removed)
	M.adjustCloneLoss(-20 * removed)
	M.adjustOxyLoss(-2 * removed)
	M.heal_organ_damage(20 * removed, 20 * removed)
	M.adjustToxLoss(-20 * removed)
	if (M.chem_doses[type] > 3 && ishuman(M))
		var/mob/living/carbon/human/H = M
		for (var/obj/item/organ/external/E in H.organs)
			E.status |= ORGAN_DISFIGURED //currently only matters for the head, but might as well disfigure them all.
	if (M.chem_doses[type] > 10)
		M.make_dizzy(5)
		M.make_jittery(5)

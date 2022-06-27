// Poisons are chemicals aimed primarily at hurting or killing people by directly damaging their body.
// This file also includes venoms, because they're also technically poisons.

/datum/reagent/toxin/venom
	name = "Spider Venom"
	description = "A deadly necrotic toxin produced by giant spiders to disable their prey."
	taste_description = "absolutely vile"
	color = "#91d895"
	target_organ = BP_LIVER
	strength = 5

/datum/reagent/toxin/venom/affect_blood(mob/living/carbon/M, alien, removed)
	if (prob(volume*2))
		M.confused = max(M.confused, 3)
	..()

/// Amatoxin is a delayed action poison. On its own, all it does is the Amaspores reagent to its holder mob.
/datum/reagent/toxin/amatoxin
	name = "Amatoxin"
	description = "A powerful poison derived from certain species of mushroom."
	taste_description = "mushroom"
	reagent_state = LIQUID
	metabolism = REM * 0.5
	color = "#792300"

/datum/reagent/toxin/amatoxin/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_DIONA)
		return
	M.reagents.add_reagent(/datum/reagent/toxin/amaspores, 2 * removed)

/// Sister reagent to Amatoxin. Does nothing at first, but causes very rapid damage once no Amatoxin is left in the body.
/datum/reagent/toxin/amaspores
	name = "Amaspores"
	description = "The secondary component to amatoxin poisoning, remaining dormant for a time before causing rapid organ and tissue decay."
	taste_description = "dusty dirt"
	reagent_state = LIQUID
	metabolism = REM * 4 // Extremely quick to act once the amatoxin has left the body
	color = "#330e00"

/datum/reagent/toxin/amaspores/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_DIONA)
		return

	if (M.chem_doses[/datum/reagent/toxin/amatoxin] > 0)
		M.reagents.add_reagent(/datum/reagent/toxin/amaspores, metabolism) // The spores lay dormant for as long as any traces of amatoxin remain
		if (prob(5))
			to_chat(M, SPAN_DANGER("Everything itches, how uncomfortable!"))
		if (prob(10))
			to_chat(M, SPAN_WARNING("Your eyes are watering, it's hard to see!"))
			M.eye_blurry = max(M.eye_blurry, 10)
		if (prob(10))
			to_chat(M, SPAN_DANGER("Your throat itches uncomfortably!"))
			M.custom_emote(2, "coughs!")
		return

	M.add_chemical_effect(CE_SLOWDOWN, 1)

	if (prob(15))
		M.Weaken(5)
		M.add_chemical_effect(CE_VOICELOSS, 5)
	if (prob(30))
		M.eye_blurry = max(M.eye_blurry, 10)

	M.take_organ_damage(3 * removed, 0, ORGAN_DAMAGE_FLESH_ONLY)
	M.adjustToxLoss(5 * removed, 0, ORGAN_DAMAGE_FLESH_ONLY)



/datum/reagent/toxin/carpotoxin
	name = "Carpotoxin"
	description = "A neurotoxin found in the flesh of space carp. It causes artery blockages that disrupt blood circulation."
	taste_description = "fish"
	reagent_state = LIQUID
	color = "#003333"
	target_organ = BP_BRAIN // heads up: this doesn't actually get run due to lack of a ..() call in affect_blood. this should be fixed in its own PR
	strength = 10

/datum/reagent/toxin/carpotoxin/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_DIONA)
		return

	var/effectiveness = 1
	var/effective_dose = 2

	if (M.chem_doses[type] < effective_dose)
		effectiveness = M.chem_doses[type]/effective_dose
	else if (volume < effective_dose)
		effectiveness = volume/effective_dose
	M.add_chemical_effect(CE_BLOCKAGE, (80 * effectiveness)/100)



/datum/reagent/toxin/cyanide
	name = "Cyanide"
	description = "An extremely toxic chemical that causes rapid heart failure in most humanoids."
	taste_mult = 0.6
	reagent_state = LIQUID
	color = "#cf3600"
	strength = 20
	metabolism = REM * 2
	target_organ = BP_HEART
	heating_point = null
	heating_products = null

/datum/reagent/toxin/cyanide/affect_blood(mob/living/carbon/M, alien, removed)
	..()
	M.sleeping += 1



/datum/reagent/toxin/taxine
	name = "Taxine"
	description = "A potent cardiotoxin found in nearly every part of the common yew."
	taste_description = "intense bitterness"
	color = "#6b833b"
	strength = 16
	overdose = REAGENTS_OVERDOSE / 3
	metabolism = REM * 2
	target_organ = BP_HEART
	heating_point = null
	heating_products = null

/datum/reagent/toxin/taxine/affect_blood(mob/living/carbon/M, alien, removed)
	..()
	M.confused += 1.5

/datum/reagent/toxin/taxine/overdose(var/mob/living/carbon/M, var/alien)
	..()
	if (ishuman(M))
		var/mob/living/carbon/human/H = M
		if (H.stat != UNCONSCIOUS)
			H.Weaken(8)
		M.add_chemical_effect(CE_NOPULSE, 1)



/datum/reagent/toxin/potassium_chloride
	name = "Potassium Chloride"
	description = "A delicious salt that stops the heart in high doses."
	taste_description = "salt"
	reagent_state = SOLID
	color = "#ffffff"
	strength = 0
	overdose = REAGENTS_OVERDOSE
	heating_point = null
	heating_products = null

/datum/reagent/toxin/potassium_chloride/overdose(var/mob/living/carbon/M, var/alien)
	..()
	if (ishuman(M))
		var/mob/living/carbon/human/H = M
		if (H.stat != UNCONSCIOUS)
			if (H.losebreath >= 10)
				H.losebreath = max(10, H.losebreath - 10)
			H.adjustOxyLoss(2)
			H.Weaken(10)
		M.add_chemical_effect(CE_NOPULSE, 1)



/datum/reagent/toxin/potassium_chlorophoride
	name = "Potassium Chlorophoride"
	description = "A specific chemical based on potassium chloride to stop the heart for surgery. Not safe to eat!"
	taste_description = "salt"
	reagent_state = SOLID
	color = "#ffffff"
	strength = 10
	overdose = 20
	heating_point = null
	heating_products = null

/datum/reagent/toxin/potassium_chlorophoride/affect_blood(mob/living/carbon/M, alien, removed)
	..()
	if (ishuman(M))
		var/mob/living/carbon/human/H = M
		if (H.stat != UNCONSCIOUS)
			if (H.losebreath >= 10)
				H.losebreath = max(10, M.losebreath-10)
			H.adjustOxyLoss(2)
			H.Weaken(10)
		M.add_chemical_effect(CE_NOPULSE, 1)



/datum/reagent/lexorin
	name = "Lexorin"
	description = "Lexorin temporarily stops respiration, and causes heavy tissue damage."
	taste_description = "acid"
	reagent_state = LIQUID
	color = "#c8a5dc"
	metabolism = REM * 0.5
	overdose = REAGENTS_OVERDOSE
	value = 2.4

/datum/reagent/lexorin/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_DIONA || alien == IS_VOX) // Lexorin focuses on removing oxygen from the blood, it wouldn't make sense that these two races are affected
		return
	if (alien == IS_SKRELL)
		M.take_organ_damage(8 * removed, 0, ORGAN_DAMAGE_FLESH_ONLY)
		if (prob(10))
			M.visible_message(
				SPAN_WARNING("\The [M]'s skin fizzles and flakes away!"),
				SPAN_DANGER("Your skin fizzles and flakes away!")
			)
		if (M.losebreath < 45)
			M.losebreath++
	else
		M.take_organ_damage(10 * removed, 0, ORGAN_DAMAGE_FLESH_ONLY)
		if (prob(10))
			M.visible_message(
				SPAN_WARNING("\The [M]'s skin fizzles and flakes away!"),
				SPAN_DANGER("Your skin fizzles and flakes away!")
			)
		if (M.losebreath < 30)
			M.losebreath++
	M.adjustOxyLoss(15 * removed)

/datum/reagent/lexorin/affect_touch(mob/living/carbon/M, alien, removed)
	if (alien == IS_DIONA || alien == IS_VOX)
		return

	touch_met = volume // immediately permiates the skin, also avoids bugs with chemical duplication.

	// The warning messages should only display once per splash, all of the chemicals upon the skin should be absorbed in one tick.
	M.visible_message(
		SPAN_WARNING("\The [M]'s skin fizzles and flakes on contact with the liquid!"),
		SPAN_DANGER("You feel a painful fizzling and your skin begins to flake!")
	)

	if (alien == IS_SKRELL) // Skrell breathe through their skin, seems logical that this would be more effective
		M.reagents.add_reagent(/datum/reagent/lexorin, 0.75 * removed)
	else
		M.reagents.add_reagent(/datum/reagent/lexorin, 0.5 * removed)



/datum/reagent/slime_jelly
	name = "Slime Jelly"
	description = "A gooey semi-liquid produced from one of the deadliest lifeforms in existence. SO REAL."
	taste_description = "slime"
	taste_mult = 1.3
	reagent_state = LIQUID
	color = "#801e28"
	value = 1.2
	should_admin_log = TRUE

/datum/reagent/slime_jelly/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_DIONA)
		return
	if (prob(10))
		to_chat(M, SPAN_DANGER("Your insides are burning!"))
		M.adjustToxLoss(rand(100, 300) * removed)
	else if (prob(40))
		M.heal_organ_damage(25 * removed, 0)

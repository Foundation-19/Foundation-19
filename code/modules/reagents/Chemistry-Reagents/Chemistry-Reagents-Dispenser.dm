#define DISPENSER_REAGENT_VALUE 0.2

/datum/reagent/acetone
	name = "Acetone"
	description = "A colorless liquid solvent used in chemical synthesis."
	taste_description = "acid"
	reagent_state = LIQUID
	color = "#808080"
	metabolism = REM * 0.2
	value = DISPENSER_REAGENT_VALUE
	accelerant_quality = 3

/datum/reagent/acetone/affect_blood(mob/living/carbon/M, alien, removed)
	if(alien == IS_NABBER)
		return

	M.adjustToxLoss(removed * 3)

/datum/reagent/acetone/touch_obj(obj/O)	//I copied this wholesale from ethanol and could likely be converted into a shared proc. ~Techhead
	if(istype(O, /obj/item/paper))
		var/obj/item/paper/paperaffected = O
		paperaffected.clearpaper()
		to_chat(usr, "The solution dissolves the ink on the paper.")
		return
	if(istype(O, /obj/item/book))
		if(volume < 5)
			return
		if(istype(O, /obj/item/book/tome))
			to_chat(usr, SPAN_NOTICE("The solution does nothing. Whatever this is, it isn't normal ink."))
			return
		var/obj/item/book/affectedbook = O
		affectedbook.dat = null
		to_chat(usr, SPAN_NOTICE("The solution dissolves the ink on the book."))
	return

/datum/reagent/aluminium
	name = "Aluminium"
	taste_description = "metal"
	taste_mult = 1.1
	description = "A silvery white and ductile member of the boron group of chemical elements."
	reagent_state = SOLID
	color = "#a8a8a8"
	value = DISPENSER_REAGENT_VALUE

/datum/reagent/ammonia
	name = "Ammonia"
	taste_description = "mordant"
	taste_mult = 2
	description = "A caustic substance commonly used in fertilizer or household cleaners."
	reagent_state = LIQUID
	color = "#404030"
	metabolism = REM * 0.5
	overdose = 5
	value = DISPENSER_REAGENT_VALUE

/datum/reagent/ammonia/affect_blood(mob/living/carbon/M, alien, removed)
	if(alien == IS_VOX)
		M.add_chemical_effect(CE_OXYGENATED, 2)
	else if(alien != IS_DIONA)
		M.adjustToxLoss(removed * 1.5)

/datum/reagent/ammonia/overdose(mob/living/carbon/M, alien)
	if(alien != IS_VOX || overdose_percentage() > 6)
		..()

/datum/reagent/carbon
	name = "Carbon"
	description = "A chemical element, the building block of life."
	taste_description = "sour chalk"
	taste_mult = 1.5
	reagent_state = SOLID
	color = "#1c1300"
	ingest_met = REM * 5
	value = DISPENSER_REAGENT_VALUE

/datum/reagent/carbon/affect_ingest(mob/living/carbon/M, alien, removed)
	if(alien == IS_DIONA)
		return
	var/datum/reagents/ingested = M.get_ingested_reagents()
	if(ingested && ingested.reagent_list.len > 1) // Need to have at least 2 reagents - cabon and something to remove
		var/effect = 1 / (ingested.reagent_list.len - 1)
		for(var/datum/reagent/R in ingested.reagent_list)
			if(R == src)
				continue
			ingested.remove_reagent(R.type, removed * effect)

/datum/reagent/carbon/touch_turf(turf/T)
	if(!isspaceturf(T))
		var/obj/effect/decal/cleanable/dirt/dirtoverlay = locate(/obj/effect/decal/cleanable/dirt, T)
		if (!dirtoverlay)
			dirtoverlay = new/obj/effect/decal/cleanable/dirt(T)
			dirtoverlay.alpha = volume * 30
		else
			dirtoverlay.alpha = min(dirtoverlay.alpha + volume * 30, 255)

/datum/reagent/copper
	name = "Copper"
	description = "A highly ductile metal."
	taste_description = "copper"
	color = "#6e3b08"
	value = DISPENSER_REAGENT_VALUE

/datum/reagent/ethanol
	name = "Ethanol" //Parent class for all alcoholic reagents.
	description = "A well-known alcohol with a variety of applications."
	taste_description = "pure alcohol"
	reagent_state = LIQUID
	color = "#404030"
	alpha = 180
	touch_met = 5
	var/nutriment_factor = 0
	var/hydration_factor = 0
	var/strength = 10 // This is, essentially, units between stages - the lower, the stronger. Less fine tuning, more clarity.
	var/toxicity = 1

	var/adj_druggy = 0
	var/adj_temp = 0
	var/targ_temp = 310
	var/halluci = 0

	/**
	 * Boozepower Chart
	 *
	 * Higher numbers equal higher hardness, higher hardness equals more intense alcohol poisoning
	 *
	 * Note that all higher effects of alcohol poisoning will inherit effects for smaller amounts
	 * (i.e. light poisoning inherts from slight poisoning)
	 * In addition, severe effects won't always trigger unless the drink is poisonously strong
	 * All effects don't start immediately, but rather get worse over time; the rate is affected by the imbiber's alcohol tolerance
	 * (see [/datum/status_effect/inebriated])
	 *
	 * * 0: Non-alcoholic
	 * * 1-10: Barely classifiable as alcohol - occassional slurring
	 * * 11-20: Slight alcohol content - slurring
	 * * 21-30: Below average - imbiber begins to look slightly drunk
	 * * 31-40: Just below average - no unique effects
	 * * 41-50: Average - mild disorientation, imbiber begins to look drunk
	 * * 51-60: Just above average - disorientation, vomiting, imbiber begins to look heavily drunk
	 * * 61-70: Above average - small chance of blurry vision, imbiber begins to look smashed
	 * * 71-80: High alcohol content - blurry vision, imbiber completely shitfaced
	 * * 81-90: Extremely high alcohol content - heavy toxin damage, passing out
	 * * 91-100: Dangerously toxic - swift death
	 */
	var/boozepower = 65

	glass_name = "ethanol"
	glass_desc = "A well-known alcohol with a variety of applications."
	value = DISPENSER_REAGENT_VALUE
	accelerant_quality = 5

/datum/reagent/ethanol/New()
	addiction_types = list(/datum/addiction/alcohol = max(0.5, 50 / strength)) // Higher strength is somehow weaker, go figure
	return ..()

/datum/reagent/ethanol/touch_mob(mob/living/L, amount)
	if(istype(L))
		L.adjust_fire_stacks(amount / 15)

/datum/reagent/ethanol/affect_blood(mob/living/carbon/M, alien, removed)
	M.adjustToxLoss(removed * 2 * toxicity)
	return

/datum/reagent/ethanol/affect_ingest(mob/living/carbon/M, alien, removed)
	M.adjust_nutrition(nutriment_factor * removed)
	M.adjust_hydration(hydration_factor * removed)

	var/adjusted_boozepower = boozepower
	if(alien == IS_SKRELL)
		adjusted_boozepower *= 5
	if(alien == IS_DIONA)
		adjusted_boozepower = 0

	// Short sips of light cocktails won't get you blackout drunk, no matter how many of them you have. Negative boozepower (i.e. getting LESS drunk) always works though.
	if(M.get_drunk_amount() < volume * adjusted_boozepower || adjusted_boozepower < 0)
		// Volume, power, and server alcohol rate effect how quickly one gets drunk
		M.adjust_drunk_effect(sqrt(volume) * adjusted_boozepower * removed * ALCOHOL_RATE)

	if(adj_druggy != 0)
		M.set_drugginess_if_lower(adj_druggy)

	if(adj_temp > 0 && M.bodytemperature < targ_temp) // 310 is the normal bodytemp. 310.055
		M.bodytemperature = min(targ_temp, M.bodytemperature + (adj_temp * TEMPERATURE_DAMAGE_COEFFICIENT))
	if(adj_temp < 0 && M.bodytemperature > targ_temp)
		M.bodytemperature = min(targ_temp, M.bodytemperature - (adj_temp * TEMPERATURE_DAMAGE_COEFFICIENT))

	if(halluci)
		M.adjust_hallucination(halluci, halluci)

/datum/reagent/ethanol/touch_obj(obj/O)
	if(istype(O, /obj/item/paper))
		var/obj/item/paper/paperaffected = O
		paperaffected.clearpaper()
		to_chat(usr, "The solution dissolves the ink on the paper.")
		return
	if(istype(O, /obj/item/book))
		if(volume < 5)
			return
		if(istype(O, /obj/item/book/tome))
			to_chat(usr, SPAN_NOTICE("The solution does nothing. Whatever this is, it isn't normal ink."))
			return
		var/obj/item/book/affectedbook = O
		affectedbook.dat = null
		to_chat(usr, SPAN_NOTICE("The solution dissolves the ink on the book."))
	return

/datum/reagent/hydrazine
	name = "Hydrazine"
	description = "A toxic, colorless, flammable liquid with a strong ammonia-like odor, in hydrate form."
	taste_description = "sweet tasting metal"
	reagent_state = LIQUID
	color = "#808080"
	metabolism = REM * 0.2
	touch_met = 5
	value = DISPENSER_REAGENT_VALUE

/datum/reagent/hydrazine/affect_blood(mob/living/carbon/M, alien, removed)
	M.adjustToxLoss(4 * removed)

/datum/reagent/hydrazine/affect_touch(mob/living/carbon/M, alien, removed) // Hydrazine is both toxic and flammable.
	M.adjust_fire_stacks(removed / 12)
	M.adjustToxLoss(0.2 * removed)

/datum/reagent/hydrazine/touch_turf(turf/T)
	new /obj/effect/decal/cleanable/liquid_fuel(T, volume)
	remove_self(volume)
	return

/datum/reagent/iron
	name = "Iron"
	description = "Pure iron is a metal."
	taste_description = "metal"
	reagent_state = SOLID
	color = "#353535"
	value = DISPENSER_REAGENT_VALUE

/datum/reagent/iron/affect_ingest(mob/living/carbon/M, alien, removed)
	if(alien != IS_DIONA)
		M.add_chemical_effect(CE_BLOODRESTORE, 8 * removed)

/datum/reagent/lithium
	name = "Lithium"
	description = "A chemical element, used as antidepressant."
	taste_description = "metal"
	reagent_state = SOLID
	color = "#808080"
	value = DISPENSER_REAGENT_VALUE

/datum/reagent/lithium/affect_blood(mob/living/carbon/M, alien, removed)
	if(alien != IS_DIONA)
		if(isspaceturf(M.loc))
			M.SelfMove(pick(GLOB.cardinal))
		if(prob(5))
			M.emote(pick("twitch", "drool", "moan"))

/datum/reagent/mercury
	name = "Mercury"
	description = "A chemical element."
	taste_mult = 0 //mercury apparently is tasteless. IDK
	reagent_state = LIQUID
	color = "#484848"
	value = DISPENSER_REAGENT_VALUE

/datum/reagent/mercury/affect_blood(mob/living/carbon/M, alien, removed)
	if(alien != IS_DIONA)
		if(isspaceturf(M.loc))
			M.SelfMove(pick(GLOB.cardinal))
		if(prob(5))
			M.emote(pick("twitch", "drool", "moan"))
		M.adjustBrainLoss(0.1)

/datum/reagent/phosphorus
	name = "Phosphorus"
	description = "A chemical element, the backbone of biological energy carriers."
	taste_description = "vinegar"
	reagent_state = SOLID
	color = "#832828"
	value = DISPENSER_REAGENT_VALUE

/datum/reagent/potassium
	name = "Potassium"
	description = "A soft, low-melting solid that can easily be cut with a knife. Reacts violently with water."
	taste_description = "sweetness" //potassium is bitter in higher doses but sweet in lower ones.
	reagent_state = SOLID
	color = "#a0a0a0"
	value = DISPENSER_REAGENT_VALUE
	should_admin_log = TRUE

/datum/reagent/potassium/affect_blood(mob/living/carbon/M, alien, removed)
	if(volume > 3)
		M.add_chemical_effect(CE_PULSE, 1)
	if(volume > 10)
		M.add_chemical_effect(CE_PULSE, 1)

/datum/reagent/radium
	name = "Radium"
	description = "Radium is an alkaline earth metal. It is extremely radioactive."
	taste_description = "the color blue, and regret"
	reagent_state = SOLID
	color = "#c7c7c7"
	value = DISPENSER_REAGENT_VALUE
	should_admin_log = TRUE

/datum/reagent/radium/affect_blood(mob/living/carbon/M, alien, removed)
	M.apply_damage(10 * removed, IRRADIATE, armor_pen = 100) // Radium may increase your chances to cure a disease

/datum/reagent/radium/touch_turf(turf/T)
	if(volume >= 3)
		if(!isspaceturf(T))
			var/obj/effect/decal/cleanable/greenglow/glow = locate(/obj/effect/decal/cleanable/greenglow, T)
			if(!glow)
				new /obj/effect/decal/cleanable/greenglow(T)
			return

/datum/reagent/silicon
	name = "Silicon"
	description = "A tetravalent metalloid, silicon is less reactive than its chemical analog carbon."
	reagent_state = SOLID
	color = "#a8a8a8"
	value = DISPENSER_REAGENT_VALUE

/datum/reagent/sodium
	name = "Sodium"
	description = "A chemical element, readily reacts with water."
	taste_description = "salty metal"
	reagent_state = SOLID
	color = "#808080"
	value = DISPENSER_REAGENT_VALUE

// code for SCP-3349
/datum/reagent/sodium/affect_blood(mob/living/carbon/M, alien, removed)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if((H.chem_doses[GLOB.scp3349_precedent] > 4.4) && (H.chem_doses[GLOB.scp3349_fake_precedent] < 0.6))
			H.RegisterSignal(H, COMSIG_CARBON_LIFE, TYPE_PROC_REF(/mob/living/carbon/human, handle_3349), TRUE)

			var/obj/item/organ/internal/heart/heart = H.internal_organs_by_name[BP_HEART]
			heart.SCP = new /datum/scp(
				src, // Ref to actual SCP atom
				"", //Name (Should not be the scp desg, more like what it can be described as to viewers)
				SCP_KETER, //Obj Class
				"3349-1" //Numerical Designation
			)

/datum/reagent/sugar
	name = "Sugar"
	description = "The organic compound commonly known as table sugar and sometimes called saccharose. This white, odorless, crystalline powder has a pleasing, sweet taste."
	taste_description = "sugar"
	taste_mult = 3
	reagent_state = SOLID
	color = "#ffffff"
	scannable = 1

	glass_name = "sugar"
	glass_desc = "The organic compound commonly known as table sugar and sometimes called saccharose. This white, odorless, crystalline powder has a pleasing, sweet taste."
	glass_icon = DRINK_ICON_NOISY
	value = DISPENSER_REAGENT_VALUE

/datum/reagent/sugar/affect_blood(mob/living/carbon/human/M, alien, removed)
	M.adjust_nutrition(removed * 3)

	if(alien == IS_UNATHI)
		var/datum/species/unathi/S = M.species
		S.handle_sugar(M,src)

/datum/reagent/sulfur
	name = "Sulfur"
	description = "A chemical element with a pungent smell."
	taste_description = "old eggs"
	reagent_state = SOLID
	color = "#bf8c00"
	value = DISPENSER_REAGENT_VALUE

/datum/reagent/tungsten
	name = "Tungsten"
	description = "A chemical element, and a strong oxidising agent."
	taste_mult = 0 //no taste
	reagent_state = SOLID
	color = "#dcdcdc"
	value = DISPENSER_REAGENT_VALUE

#undef DISPENSER_REAGENT_VALUE

// Things that are toxic enough to be considered toxins but have niche uses go here, such as plasticide and methyl bromide's reagent form.

/datum/reagent/toxin/plasticide
	name = "Plasticide"
	description = "Liquid plastic, do not eat."
	taste_description = "plastic"
	reagent_state = LIQUID
	color = "#cf3600"
	strength = 5
	heating_point = null
	heating_products = null



/datum/reagent/toxin/chlorine
	name = "Chlorine"
	description = "A highly poisonous liquid. Smells strongly of bleach."
	reagent_state = LIQUID
	taste_description = "bleach"
	color = "#707c13"
	strength = 15
	metabolism = REM
	heating_point = null
	heating_products = null



/datum/reagent/toxin/phoron
	name = "Phoron"
	description = "Phoron in its liquid form."
	taste_mult = 1.5
	reagent_state = LIQUID
	color = "#ff3300"
	strength = 30
	touch_met = 5
	var/fire_mult = 5
	heating_point = null
	heating_products = null

/datum/reagent/toxin/phoron/touch_mob(mob/living/L, amount)
	if (istype(L))
		L.adjust_fire_stacks(amount / fire_mult)

/datum/reagent/toxin/phoron/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_NABBER)
		return
	..()

/datum/reagent/toxin/phoron/affect_touch(mob/living/carbon/M, alien, removed)
	M.take_organ_damage(0, removed * 0.1) //being splashed directly with phoron causes minor chemical burns
	if (prob(10 * fire_mult))
		M.pl_effects()

/datum/reagent/toxin/phoron/touch_turf(turf/simulated/T)
	if (!istype(T))
		return
	T.assume_gas(GAS_PHORON, volume, T20C)
	remove_self(volume)



// Produced during deuterium synthesis. Super poisonous, SUPER flammable (doesn't need oxygen to burn).
/datum/reagent/toxin/phoron/oxygen
	name = "Oxyphoron"
	description = "An exceptionally flammable molecule formed from deuterium synthesis."
	strength = 15
	fire_mult = 15

/datum/reagent/toxin/phoron/oxygen/touch_turf(turf/simulated/T)
	if (!istype(T))
		return
	T.assume_gas(GAS_OXYGEN, ceil(volume/2), T20C)
	T.assume_gas(GAS_PHORON, ceil(volume/2), T20C)
	remove_self(volume)



/datum/reagent/toxin/hair_remover
	name = "Hair Remover"
	description = "An extremely effective chemical depilator. Do not ingest."
	taste_description = "acid"
	reagent_state = LIQUID
	color = "#d9ffb3"
	strength = 1
	overdose = REAGENTS_OVERDOSE
	heating_products = null
	heating_point = null

/datum/reagent/toxin/hair_remover/affect_touch(mob/living/carbon/human/M, alien, removed)
	if (alien == IS_SKRELL)	//skrell can't have hair unless you hack it in, also to prevent tentacles from falling off
		return
	M.species.set_default_hair(M)
	to_chat(M, SPAN_WARNING("You feel a chill and your skin feels lighter."))
	remove_self(volume)



/datum/reagent/toxin/bromide
	name = "Bromide"
	description = "A dark, nearly opaque, red-orange, toxic element."
	taste_description = "pestkiller"
	reagent_state = LIQUID
	color = "#4c3b34"
	strength = 3
	heating_products = null
	heating_point = null

/datum/reagent/toxin/bromide/affect_touch(mob/living/carbon/M, alien, removed)
	if (alien != IS_MANTID)
		. = ..()

/datum/reagent/toxin/bromide/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_MANTID)
		M.add_chemical_effect(CE_OXYGENATED, 1)
	else
		..()

/datum/reagent/toxin/bromide/affect_ingest(mob/living/carbon/M, alien, removed)
	if (alien != IS_MANTID)
		. = ..()



/datum/reagent/toxin/methyl_bromide
	name = "Methyl Bromide"
	description = "A fumigant derived from bromide."
	taste_description = "pestkiller"
	reagent_state = LIQUID
	color = "#4c3b34"
	strength = 5
	heating_products = null
	heating_point = null

/datum/reagent/toxin/methyl_bromide/affect_touch(mob/living/carbon/M, alien, removed)
	. = (alien != IS_MANTID && alien != IS_NABBER && ..())

/datum/reagent/toxin/methyl_bromide/affect_ingest(mob/living/carbon/M, alien, removed)
	. = (alien != IS_MANTID && alien != IS_NABBER && ..())

/datum/reagent/toxin/methyl_bromide/touch_turf(turf/simulated/T)
	if (istype(T))
		T.assume_gas(GAS_METHYL_BROMIDE, volume, T20C)
		remove_self(volume)

/datum/reagent/toxin/methyl_bromide/affect_blood(mob/living/carbon/M, alien, removed)
	. = (alien != IS_MANTID && alien != IS_NABBER && ..())
	if (istype(M))
		for(var/obj/item/organ/external/E in M.organs)
			if (LAZYLEN(E.implants))
				for(var/obj/effect/spider/spider in E.implants)
					if (prob(25))
						E.implants -= spider
						M.visible_message(SPAN_NOTICE("The dying form of \a [spider] emerges from inside \the [M]'s [E.name]."))
						qdel(spider)
						break



/datum/reagent/toxin/tar
	name = "Tar"
	description = "A dark, viscous liquid."
	taste_description = "petroleum"
	color = "#140b30"
	strength = 4
	heating_products = list(/datum/reagent/acetone, /datum/reagent/carbon, /datum/reagent/ethanol)
	heating_point = 145 CELSIUS
	heating_message = "separates."



/datum/reagent/toxin/boron
	name = "Boron"
	description = "A chemical that is highly valued for its potential in fusion energy."
	taste_description = "metal"
	reagent_state = SOLID
	color = "#837e79"
	value = 4
	strength = 7

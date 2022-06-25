// These chemicals are specifically used primarily in hydroponics/plant care, and aren't intentionally poisonous.

/datum/reagent/toxin/fertilizer //Reagents used for plant fertilizers.
	name = "Fertilizer"
	description = "A chemical mix good for growing plants with."
	taste_description = "plant food"
	taste_mult = 0.5
	reagent_state = LIQUID
	strength = 0.5 // It's not THAT poisonous.
	color = "#664330"
	heating_point = null
	heating_products = null

/datum/reagent/toxin/fertilizer/ez_nutrient
	name = "EZ Nutrient"

/datum/reagent/toxin/fertilizer/left_4_zed
	name = "Left-4-Zed"

/datum/reagent/toxin/fertilizer/robust_harvest
	name = "Robust Harvest"



/datum/reagent/toxin/plant_b_gone
	name = "Plant-B-Gone"
	description = "A harmful toxic mixture to kill plantlife. Do not ingest!"
	taste_mult = 1
	reagent_state = LIQUID
	color = "#49002e"
	strength = 4
	heating_products = list(/datum/reagent/toxin, /datum/reagent/water)

/datum/reagent/toxin/plant_b_gone/touch_turf(turf/T)
	if (istype(T, /turf/simulated/wall))
		var/turf/simulated/wall/W = T
		if (locate(/obj/effect/overlay/wallrot) in W)
			for(var/obj/effect/overlay/wallrot/E in W)
				qdel(E)
			W.visible_message(SPAN_NOTICE("The fungi are completely dissolved by the solution!"))

/datum/reagent/toxin/plant_b_gone/touch_obj(obj/O, volume)
	if (istype(O, /obj/effect/vine))
		qdel(O)

/datum/reagent/toxin/plant_b_gone/affect_blood(mob/living/carbon/M, alien, removed)
	..()
	if (alien == IS_DIONA)
		M.adjustToxLoss(50 * removed)

/datum/reagent/toxin/plant_b_gone/affect_touch(mob/living/carbon/M, alien, removed)
	..()
	if (alien == IS_DIONA)
		M.adjustToxLoss(50 * removed)

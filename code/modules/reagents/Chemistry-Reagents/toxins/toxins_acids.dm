/**
 * Acids metabolize quickly and are very corrosive, causing objects to melt when acid is splashed on them.
 * They are always liquids, and typically have a high touch metabolization ratio.
 */
/datum/reagent/acid
	taste_description = "acid"
	reagent_state = LIQUID
	metabolism = REM * 2
	touch_met = 50 // It's acid!
	should_admin_log = TRUE

	/// An arbitrary number measuring the strength of this acid. Per tick in the blood, organisms take burn damage equal to this value times `removed`.
	var/acid_power = 5
	/// How many units of acid are needed to melt an object.
	var/meltdose = 10
	/// Acid won't deal damage in one splash that exceeds this amount, no matter how much is used.
	var/max_damage = 40

/datum/reagent/acid/affect_blood(mob/living/carbon/M, alien, removed)
	M.take_organ_damage(0, removed * acid_power)

/datum/reagent/acid/affect_touch(mob/living/carbon/M, alien, removed) // This is the most interesting

	M.visible_message(
		SPAN_WARNING("\The [M]'s skin sizzles and burns on contact with the liquid!"),
		SPAN_DANGER("Your skin sizzles and burns!")
		)

	if (ishuman(M))
		var/mob/living/carbon/human/H = M
		if (H.head)
			if (H.head.unacidable)
				to_chat(H, SPAN_WARNING("Your [H.head] protects you from the liquid."))
				remove_self(volume)
				return
			else if (removed > meltdose)
				to_chat(H, SPAN_DANGER("Your [H.head] melts away!"))
				qdel(H.head)
				H.update_inv_head(1)
				H.update_hair(1)
				removed -= meltdose
		if (removed <= 0)
			return

		if (H.wear_mask)
			if (H.wear_mask.unacidable)
				to_chat(H, SPAN_DANGER("Your [H.wear_mask] protects you from the acid."))
				remove_self(volume)
				return
			else if (removed > meltdose)
				to_chat(H, SPAN_DANGER("Your [H.wear_mask] melts away!"))
				qdel(H.wear_mask)
				H.update_inv_wear_mask(1)
				H.update_hair(1)
				removed -= meltdose
		if (removed <= 0)
			return

		if (H.glasses)
			if (H.glasses.unacidable)
				to_chat(H, SPAN_WARNING("Your [H.glasses] partially protect you from the liquid!"))
				removed /= 2
			else if (removed > meltdose)
				to_chat(H, SPAN_DANGER("Your [H.glasses] melt away!"))
				qdel(H.glasses)
				H.update_inv_glasses(1)
				removed -= meltdose / 2
		if (removed <= 0)
			return

	if (M.unacidable)
		return

	if (removed < meltdose) // Not enough to melt anything
		M.take_organ_damage(0, min(removed * acid_power * 0.1, max_damage)) //burn damage, since it causes chemical burns. Acid doesn't make bones shatter, like brute trauma would.
	else
		M.take_organ_damage(0, min(removed * acid_power * 0.2, max_damage))
		if (ishuman(M)) // Applies disfigurement
			var/mob/living/carbon/human/H = M
			var/screamed
			for(var/obj/item/organ/external/affecting in H.organs)
				if (!screamed && affecting.can_feel_pain())
					screamed = TRUE
					H.emote("scream")
				affecting.status |= ORGAN_DISFIGURED

/datum/reagent/acid/touch_obj(obj/O)
	if (O.unacidable)
		return
	if ((istype(O, /obj/item) || istype(O, /obj/effect/vine)) && (volume > meltdose))
		var/obj/effect/decal/cleanable/molten_item/I = new/obj/effect/decal/cleanable/molten_item(O.loc)
		I.desc = "Looks like this was \an [O] some time ago."
		for(var/mob/M in viewers(5, O))
			to_chat(M, SPAN_WARNING("\The [O] melts."))
		qdel(O)
		remove_self(meltdose) // 10 units of acid will not melt EVERYTHING on the tile



/datum/reagent/acid/sulphuric
	name = "Sulphuric Acid"
	description = "A very corrosive mineral acid with the molecular formula H2SO4."
	color = "#db5008"
	value = 0.2



/datum/reagent/acid/hydrochloric //Like sulfuric, but less toxic and more acidic.
	name = "Hydrochloric Acid"
	description = "A very corrosive mineral acid with the molecular formula HCl."
	taste_description = "metallic acid"
	color = "#808080"
	acid_power = 3
	meltdose = 8
	max_damage = 30
	value = 0.4



/datum/reagent/acid/polytrinic
	name = "Polytrinic Acid"
	description = "Polytrinic acid is a an extremely corrosive chemical substance."
	color = "#8e18a9"
	acid_power = 10
	meltdose = 4
	max_damage = 60



/datum/reagent/acid/stomach
	name = "Stomach Acid"
	description = "A weakly acidic substance found in the human stomach."
	taste_description = "coppery foulness"
	acid_power = 2
	color = "#d8ff00"

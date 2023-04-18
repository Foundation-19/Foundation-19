/*
Handles checks to see if a human can see or hear something based on various factors.
Also handles the blinking mechanics.

Made by TheDarkElites
*/
#define AUDIBLE_RANGE_FULL       14
#define AUDIBLE_RANGE_DECREASED  2
#define AUDIBLE_RANGE_NONE       -1 //Prevent it from being heard even on the same tile

//Maximium lum count before we no longer consider it dark. Should be a value between 0 and 1.
var/dark_maximium = 0.05

//View distance debuffs for sizes of objects/mobs passed through can_identify
var/debuff_small = 1
var/debuff_tiny = 2
var/debuff_miniscule = 3

// AUDIO MEMETICS

/mob/living/carbon/human/can_hear(atom/origin, var/return_granulated = 0, var/range_override = null) //Checks if a human can hear something. If theres no origin, just checks if the human can hear. Return granulated returns a number from 0-100 on how much something can be heard.
	var/hearable_range

	switch(get_audio_insul())
		if(A_INSL_PERFECT) hearable_range = AUDIBLE_RANGE_NONE
		if(A_INSL_IMPERFECT) hearable_range = range_override ? range_override : AUDIBLE_RANGE_DECREASED
		if(A_INSL_NONE) hearable_range = range_override ? range_override : AUDIBLE_RANGE_FULL

	if(!origin)
		if(hearable_range == AUDIBLE_RANGE_NONE)
			if(return_granulated)
				return 0
			return FALSE
		else
			if(return_granulated)
				return 100
			return TRUE

	if(!isturf(origin.loc)) //Are we inside something that may decrease our audio range?
		if(hearable_range > AUDIBLE_RANGE_DECREASED)
			hearable_range = AUDIBLE_RANGE_DECREASED

	if(return_granulated)
		var/cut_off = hearable_range //How far before we begin to drop off granulated amount based on distance
		if(hearable_range == AUDIBLE_RANGE_FULL) //Adjusts cut-off to make results consistent with non-granulated checks.
			cut_off -= 4
		else if(hearable_range == AUDIBLE_RANGE_DECREASED)
			cut_off -= 1
		var/distance_from_origin = range_override ? range_override : get_dist(src, origin)
		if(hearable_range == AUDIBLE_RANGE_NONE || AUDIBLE_RANGE_FULL < get_dist_euclidian(get_turf(src), get_turf(origin)))
			return 0
		if(distance_from_origin <= cut_off)
			return 100
		return clamp((((AUDIBLE_RANGE_FULL - clamp((distance_from_origin - cut_off)**2, 0, AUDIBLE_RANGE_FULL))/AUDIBLE_RANGE_FULL)  * 100), 0, 100)
	else
		if(hearable_range <= get_dist_euclidian(get_turf(src), get_turf(origin)))
			return TRUE
		else
			return FALSE

/mob/living/carbon/human/proc/get_audio_insul() //gets total insulation from clothing/disabilities without any calculations.
	if((sdisabilities & DEAFENED) || ear_deaf || incapacitated(INCAPACITATION_KNOCKOUT)) // cant hear if you're deaf.
		return A_INSL_PERFECT
	return audible_insulation

// VISUAL MEMETICS

/mob/living/carbon/human/can_see(atom/origin, var/visual_memetic = 0) //Checks if origin can be seen by a human. visiual_memetics should be one if you're checking for a visual memetic hazard as opposed to say someone looking at scp 173. If origin is null, checks for if the human can see in general.
	var/turf/origin_turf
	var/area/origin_area
	if(eye_blind > 0) //this is different from blinded check as blinded is changed in the same way eye_blind is, meaning there can be a siutation where eye_blind is in effect but blinded is not set to true. Therefore, this check is neccesary as a pre-caution.
		return FALSE
	if(stat) //Unconscious humans cant see.
		return FALSE
	if(origin)
		if(!ismovable(origin) || (origin.get_holder_or_object() == src)) //We can always see turf (and other immovable atoms) and ourselves. We can also see stuff on us (not really 'see' but you can feel a headset in your hands even if its pitch black).
			return TRUE
		if(origin.InCone(src, turn(src.dir, 180))) // Cant see whats behind you.
			return FALSE
		if(istype(origin.loc, /obj/item/storage)) //Cant see stuff in a backpack or hidden in a container
			return FALSE
		if(!(origin.get_holder_or_object() in dview(7, src))) //Cant see whats not in view. View dosent pick up stuff worn or held by mobs. Therefore, if origin is is held or worn by a mob it checks if we can see the mob instead.
			return FALSE

		origin_turf = get_turf(origin)
		origin_area = get_area(origin)

		if((origin_turf.get_lumcount() <= dark_maximium) && (see_in_dark <= 2) && (see_invisible != SEE_INVISIBLE_NOLIGHTING) && (origin_area.dynamic_lighting != 0)) //Cant see whats in the dark (unless you have nightvision). Also regular view does check light level, but here we do it ourselves to allow flexibility for what we consider dark + integration with night vision goggles, etc.
			return FALSE
		if(ismob(origin))
			var/mob/origin_mob = origin
			if(origin_mob.is_invisible_to(src)) //self explanitory
				return FALSE

	var/visual_insulation_calculated = get_visual_insul()
	if(!visual_memetic) //If not memetic, we should still see objects even if wearing something with memetic insulation but no tint.
		if((equipment_tint_total != TINT_BLIND) && (visual_insulation_calculated == V_INSL_PERFECT))
			visual_insulation_calculated = V_INSL_NONE

	if(visual_insulation_calculated == V_INSL_PERFECT)
		return FALSE

	return TRUE

/mob/living/carbon/human/proc/can_identify(atom/movable/origin, var/visual_memetic = 0) //Like can_see but takes into account distance, nearsightedness, and other factors. Meant to be used for if you can actually decipher what an object is or read it rather than just see it. visual_memetic is same as in can_see.
	if(!can_see(origin, visual_memetic)) //cant read or otherwise identify something if you cant see it
		return FALSE
	if(!(isobj(origin) || ismob(origin)))
		return TRUE //if its not an object or mob it can always be identified/read (technically this should never happen but better safe than sorry)

	var/viewdistance = 7 - get_how_nearsighted() //cant read if you're nearsighted and without prescription
	var/visual_insulation_calculated = get_visual_insul()
	if(!visual_memetic) //If not memetic, we should still see objects even if wearing something with memetic insulation but no tint.
		if((equipment_tint_total == TINT_NONE) && (visual_insulation_calculated != V_INSL_NONE))
			visual_insulation_calculated = V_INSL_NONE

	viewdistance -= equipment_tint_total //Higher tint lowers viewdistance

	var/size_class
	if(isobj(origin))
		var/obj/origin_Obj = origin
		size_class = origin_Obj.w_class
		switch(size_class)
			if(ITEM_SIZE_SMALL) viewdistance -= debuff_small
			if(ITEM_SIZE_TINY) viewdistance -= debuff_tiny
	else if(ismob(origin))
		var/mob/origin_Mob = origin
		size_class = origin_Mob.mob_size
		switch(size_class)
			if(MOB_SMALL) viewdistance -= debuff_small
			if(MOB_TINY) viewdistance -= debuff_tiny
			if(MOB_MINISCULE) viewdistance -= debuff_miniscule

	if(get_dist_euclidian(get_turf(src), get_turf(origin)) <= clamp(viewdistance, 0, 7))
		if((visual_insulation_calculated == V_INSL_IMPERFECT) && visual_memetic)
			return prob(40) //If its a memetic check and your protection is imperfect/faulty there is a 40% chance of you being affected by a memetic hazard
		return TRUE

	return FALSE

/mob/living/carbon/human/proc/get_visual_insul(var/include_tint = 1) //gets total insulation from clothing/disabilities without any calculations. Include_tint is for if you want to include tints in your insulation.
	if((sdisabilities & BLINDED) || blinded || incapacitated(INCAPACITATION_KNOCKOUT)) // cant see if you're blind.
		return V_INSL_PERFECT
	if(include_tint)
		if(equipment_tint_total >= TINT_BLIND) //Checks tints. Tints are different from insulation in that they graphicaly obstruct your view, whereas insulation just insulates you from memetic hazards without obstructing your view.
			return V_INSL_PERFECT
	return visual_insulation

/mob/living/carbon/human/proc/get_how_nearsighted() //Stolen from species.dm
	var/prescriptions = 0
	if(disabilities & NEARSIGHTED)
		prescriptions += 7
	if(equipment_prescription)
		prescriptions -= equipment_prescription
	return clamp(prescriptions,0,7)

// BLINK MECHANICS

/mob/living/carbon/human/proc/enable_blink(atom/movable/blink_reason) //blink_reason is usually src from whatever is calling this proc. Example, if 173 calls this on a human, blink_reason should be 173.
	if(!(blink_reason in blink_causers))
		if(!is_blinking)
			is_blinking = TRUE
			add_verb(src, /mob/living/carbon/human/verb/manual_blink)
		blink_causers += blink_reason

/mob/living/carbon/human/proc/disable_blink(atom/movable/blink_reason)
	if(blink_reason in blink_causers)
		blink_causers -= blink_reason
	if(!LAZYLEN(blink_causers))
		is_blinking = FALSE
		remove_verb(src, /mob/living/carbon/human/verb/manual_blink)

/mob/living/carbon/human/proc/cause_blink() //This cant be handled in the eyes as eye processing and human life() processing are out of sync, causing weird bugs.
	eye_blind += 2
	visible_message(SPAN_NOTICE("[src] blinks."), SPAN_NOTICE("You blink."))
	to_chat(src, SPAN_NOTICE("You blink.")) //Cant use visible_message's self function as you're technically blind when blinking.
	BITSET(hud_updateflag, BLINK_HUD)
	if(is_blinking)
		blink_total = rand(8, 10)
		blink_current = blink_total





/*
Handles checks to see if a human can see or hear something based on various factors.
Also handles the blinking mechanics.

Made by TheDarkElites
*/
#define AUDIBLE_RANGE_FULL       7
#define AUDIBLE_RANGE_DECREASED  2
#define AUDIBLE_RANGE_NONE       -1 //Prevent it from being heard even on the same tile

var/dark_maximium = 0.1 //Maximium lum count before we no longer consider it dark. Should be a value between 0 and 1.

/mob/living/carbon/human/proc/can_hear(atom/movable/origin = null) //if no origin is provided, calculations are less complex and use probability, please AVOID using without passing an origin.
	var/hearable_range

	switch(get_audio_insul())
		if(A_INSL_PERFECT) hearable_range = AUDIBLE_RANGE_NONE
		if(A_INSL_IMPERFECT) hearable_range = AUDIBLE_RANGE_DECREASED
		if(A_INSL_NONE) hearable_range = AUDIBLE_RANGE_FULL

	if(origin == null) // This is for when we have no origin, we must then use probabilites and absolutes.
		if(hearable_range == AUDIBLE_RANGE_NONE)
			return FALSE
		else if(hearable_range == AUDIBLE_RANGE_DECREASED)
			return prob(30)
		else
			return TRUE

	if((src in hear(hearable_range, origin)) && (loc == origin.loc)) //area is checked as a way to simulate walls and doors dampening hearing ability
		return TRUE

	return FALSE

/mob/living/carbon/human/proc/can_see(atom/movable/origin, var/visual_memetic = 0) //Checks if origin can be seen by a human. visiual_memetics should be one if you're checking for a visual memetic hazard as opposed to say someone looking at scp 173.
	if(origin.InCone(src, turn(src.dir, 180))) // Cant see whats behind you.
		return FALSE
	if(!(origin in view_nolight(7,src))) //Cant see whats not in view.
		return FALSE
	if(eye_blind > 0) //Cant see if you're blinking or otherwise temporarily blinded.
		return FALSE
	var/turf/origin_turf = get_turf(origin)
	if((origin_turf.get_lumcount() <= dark_maximium) && (see_in_dark <= 2) && (see_invisible != SEE_INVISIBLE_NOLIGHTING)) //Cant see whats in the dark (unless you have nightvision). Also regular view does check light level, but here we do it ourselves to allow flexibility for what we consider dark + integration with night vision goggles, etc.
		return FALSE
	if(stat) //Unconscious humans cant see.
		return FALSE
	if(origin.is_invisible_to(src)) //self explanitory
		return FALSE

	var/visual_insulation_calculated = get_visual_insul()
	if(!visual_memetic) //If not memetic, we should still see objects even if wearing something with memetic insulation but no tint.
		if((equipment_tint_total != TINT_BLIND) && (visual_insulation_calculated == V_INSL_PERFECT))
			visual_insulation_calculated = V_INSL_NONE

	if(visual_insulation_calculated == V_INSL_PERFECT)
		return FALSE

	return TRUE

/mob/living/carbon/human/proc/get_audio_insul() //gets total insulation from clothing/disabilities without any calculations.
	if(is_deaf()) // cant hear if you're deaf.
		return A_INSL_PERFECT
	return audible_insulation

/mob/living/carbon/human/proc/get_visual_insul(var/include_tint = 1) //gets total insulation from clothing/disabilities without any calculations. Include_tint is for if you want to include tints in your insulation.
	if(is_blind()) // cant see if you're blind.
		return V_INSL_PERFECT
	if(include_tint)
		if(equipment_tint_total >= TINT_BLIND) //Checks tints, technically we dont need to have a seperate visual insulation var when we have tint, but since tint is also used for graphical calulcations I would rather have them seperate incase we have a future item that can block visual memetics but dosent impair your vision.
			return V_INSL_PERFECT
		if(equipment_tint_total > TINT_NONE)
			return V_INSL_IMPERFECT
	return visual_insulation


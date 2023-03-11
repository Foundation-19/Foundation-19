/*
Handles checks to see if a human can see or hear something based on various factors.
Also handles the blinking mechanics.
*/
#define AUDIBLE_RANGE_FULL       7
#define AUDIBLE_RANGE_DECREASED  2
#define AUDIBLE_RANGE_NONE       -1 //Prevent it from being heard even on the same tile

/mob/living/carbon/human/proc/can_hear(atom/movable/origin = null) //DO NOT USE THE can_hear() proc WITHOUT PROVIDING AN ORIGIN, THIS IS ONLY FOR THE show_message() proc.
	var/hearable_range

	switch(get_audio_insul())
		if(A_INSL_PERFECT) hearable_range = AUDIBLE_RANGE_NONE
		if(A_INSL_IMPERFECT) hearable_range = AUDIBLE_RANGE_DECREASED
		if(A_INSL_NONE) hearable_range = AUDIBLE_RANGE_FULL

	if(origin == null) // This is for exclusive use with show_message() as the orgin is not sent through the args. As such, probability is used to calculate imperfect hearing protection and absolutes are used for the other two scenarios.
		if(hearable_range == AUDIBLE_RANGE_NONE)
			return FALSE
		else if(hearable_range == AUDIBLE_RANGE_DECREASED)
			return prob(30)
		else
			return TRUE

	if((src in hear(hearable_range, origin)) && (loc == origin.loc)) //area is checked as a way to simulate walls and doors dampening hearing ability
		return TRUE

	return FALSE

/mob/living/carbon/human/proc/get_audio_insul()
	if(is_deaf()) // cant hear if you're deaf
		return A_INSL_PERFECT
	to_world_log("Audible insulation is [audible_insulation]")
	return audible_insulation


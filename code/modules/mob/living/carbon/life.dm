/mob/living/carbon/Life()
	if(!..())
		return

	SEND_SIGNAL(src, COMSIG_CARBON_LIFE)

	UpdateStasis()

	// Increase germ_level regularly
	if(germ_level < GERM_LEVEL_AMBIENT && prob(30))	//if you're just standing there, you shouldn't get more germs beyond an ambient level
		germ_level++

	if(!InStasis())
		//Chemicals in the body
		handle_chemicals_in_body()

	if(stat != DEAD && !InStasis())
		//Breathing, if applicable
		handle_breathing()

		//Random events (vomiting etc)
		handle_random_events()

		// eye, ear, brain damages
		handle_disabilities()

		//all special effects, stunned, weakened, hallucination, sleeping, etc
		handle_statuses()

		handle_viruses()

		// Handle addictions
		for(var/key in addiction_points)
			var/datum/addiction/addiction = SSaddiction.all_addictions[key]
			addiction.ProcessAddiction(src)

		. = 1

		if(!client && (!mind || ghosted) && species)
			species.handle_npc(src)

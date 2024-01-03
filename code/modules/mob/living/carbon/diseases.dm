/mob/living/carbon/handle_diseases()
	for(var/datum/disease/D in diseases)
		if(prob(D.infectivity))
			D.Spread()

		if(stat != DEAD || D.process_dead)
			D.StageAct()

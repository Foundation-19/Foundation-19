/datum/event/disease_outbreak
	announceWhen = 100

	var/virus_type
	// Affects the maximum amount of symptoms and level of symptoms in advanced diseases
	var/max_severity = 3

/datum/event/disease_outbreak/announce()
	GLOB.using_map.level_x_biohazard_announcement(7)

/datum/event/disease_outbreak/setup()
	announceWhen = rand(100, 250)

/datum/event/disease_outbreak/start()
	var/advanced_virus = FALSE
	max_severity = severity * 2 + prob(50)
	if(!virus_type && prob(20 + (10 * max_severity)))
		advanced_virus = TRUE

	if(!virus_type && !advanced_virus)
		switch(severity)
			if(EVENT_LEVEL_MAJOR) // TODO: Somewhat dangerous non-advanced diseases
				// virus_type = pick()
				advanced_virus = TRUE
			if(EVENT_LEVEL_MODERATE)
				virus_type = pick(/datum/disease/cold, /datum/disease/advance/conspiracy)
			if(EVENT_LEVEL_MUNDANE)
				virus_type = pick(/datum/disease/advance/flu, /datum/disease/advance/cold)

	var/datum/disease/D
	if(!advanced_virus)
		D = new virus_type()
	else
		D = new /datum/disease/advance/random(max_severity, max_severity)

	for(var/mob/living/carbon/human/H in shuffle(SSmobs.mob_list))
		var/turf/T = get_turf(H)
		if(!T)
			continue
		if(!(T.z in affecting_z))
			continue
		if(!H.client)
			continue
		if(H.stat == DEAD)
			continue
		// don't infect someone that already has a disease
		if(LAZYLEN(H.diseases))
			continue
		if(!H.CanContractDisease(D))
			continue

		H.ForceContractDisease(D, FALSE, TRUE)

		if(advanced_virus)
			var/datum/disease/advance/A = D
			var/list/name_symptoms = list() //for feedback
			for(var/datum/symptom/S in A.symptoms)
				name_symptoms += S.name
			message_admins("An event has triggered a random advanced virus outbreak on [key_name_admin(H)]! It has these symptoms: [english_list(name_symptoms)]")
			log_game("An event has triggered a random advanced virus outbreak on [key_name(H)]! It has these symptoms: [english_list(name_symptoms)]")
		else
			message_admins("An event has triggered a virus outbreak on [key_name_admin(H)]! Disease type is: [D.type]")
			log_game("An event has triggered a virus outbreak on [key_name(H)]! Disease type is: [D.type]")
		break

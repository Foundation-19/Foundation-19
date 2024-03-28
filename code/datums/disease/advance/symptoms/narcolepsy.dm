/*
//////////////////////////////////////
Narcolepsy
	Noticeable.
	Lowers resistance
	Decreases stage speed tremendously.
	Decreases transmittablity tremendously.

Bonus
	Causes drowsiness and sleep.

//////////////////////////////////////
*/

/datum/symptom/narcolepsy
	name = "Narcolepsy"
	desc = "The virus causes a hormone imbalance, making the host sleepy and narcoleptic."
	stealth = -1
	resistance = -2
	stage_speed = -3
	transmittable = 0
	level = 6
	symptom_delay_min = 20
	symptom_delay_max = 30
	severity = 4
	var/yawning = FALSE
	threshold_descs = list(
		"Stealth 4" = "The symptom remains hidden until active.",
		"Transmission 4" = "Causes the host to periodically emit a yawn that spreads the virus in a manner similar to that of a sneeze.",
		"Stage Speed 10" = "Causes narcolepsy more often, increasing the chance of the host falling asleep.",
	)

/datum/symptom/narcolepsy/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.properties["stealth"] >= 4)
		suppress_warning = TRUE
	if(A.properties["transmittable"] >= 4) //yawning (mostly just some copy+pasted code from sneezing, with a few tweaks)
		yawning = TRUE
	if(A.properties["stage_speed"] >= 10) //act more often
		symptom_delay_min = 10
		symptom_delay_max = 20

/datum/symptom/narcolepsy/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/M = A.affected_mob
	switch(A.stage)
		if(1)
			if(!suppress_warning && prob(50))
				to_chat(M, "<span class='warning'>You feel tired.</span>")
		if(2)
			if(!suppress_warning && prob(50))
				to_chat(M, "<span class='warning'>You feel very tired.</span>")
		if(3)
			if(!suppress_warning && prob(50))
				to_chat(M, "<span class='warning'>You try to focus on staying awake.</span>")
			M.adjust_drowsiness(5 SECONDS)
		if(4)
			if(!suppress_warning && prob(50))
				if(yawning)
					to_chat(M, "<span class='warning'>You try and fail to suppress a yawn.</span>")
				else
					to_chat(M, "<span class='warning'>You nod off for a moment.</span>") //you can't really yawn while nodding off, can you?
			M.adjust_drowsiness(10 SECONDS)
			if(yawning)
				M.emote("yawn")
				if(M.CanSpreadAirborneDisease())
					A.Spread(6)
		if(5)
			if(prob(50))
				to_chat(M, "<span class='warning'>[pick("So tired...","You feel very sleepy.","You have a hard time keeping your eyes open.","You try to stay awake.")]</span>")
			M.adjust_drowsiness(15 SECONDS)
			if(yawning)
				M.emote("yawn")
				if(M.CanSpreadAirborneDisease())
					A.Spread(6)

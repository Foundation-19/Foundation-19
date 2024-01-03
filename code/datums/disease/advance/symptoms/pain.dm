/*
//////////////////////////////////////

Pain Jolts

	Noticable.
	Increases resistance.
	Doesn't increase stage speed.
	Decreases transmittability.
	High Level.

Bonus
	Increases amount of pain done
	Stuns the host

//////////////////////////////////////
*/

/datum/symptom/pain
	name = "Pain Jolts"
	desc = "The virus causes nerves of the host to spontaneously activate, causing painful sensations."
	stealth = -2
	resistance = 4
	stage_speed = 0
	transmittable = -1
	level = 5
	severity = 4
	symptom_delay_min = 15
	symptom_delay_max = 30
	threshold_descs = list(
		"Resistance 10" = "Makes pain jolts more severe.",
		"Stealth 5" = "The symptom remains hidden until active.",
		"Stage Speed 10" = "Stuns the host for a short period of time."
	)
	/// Amount of pain done on each custom_pain call. This is multiplied with each stage!
	var/pain_amount = 10
	var/stun_host = FALSE

/datum/symptom/pain/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.properties["resistance"] >= 10) // More pain
		pain_amount = 20
	if(A.properties["stealth"] >= 5)
		suppress_warning = TRUE
	if(A.properties["stage_rate"] >= 17) // Stuns the host with damage, so long as painkillers don't overpower it
		stun_host = TRUE

/datum/symptom/pain/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/carbon/C = A.affected_mob
	switch(A.stage)
		if(1, 2)
			if(!suppress_warning)
				C.emote(pick("shiver", "twitch"))
		else
			DoPain(A, C)

/datum/symptom/pain/proc/DoPain(datum/disease/advance/A, mob/living/carbon/C)
	var/pain_done = pain_amount * (A.stage - 2) // At stage 3 multiplied by 1, then increases
	switch(pain_done)
		if(5 to 15)
			C.custom_pain("Your body stings slightly.", pain_done)
		if(15 to 30)
			C.custom_pain("Your body stings.", pain_done)
		if(30 to 45)
			C.custom_pain("Your body stings strongly.", pain_done)
		if(45 to 60)
			C.custom_pain("Your whole body hurts badly.", pain_done)
		if(60 to 100)
			C.custom_pain("Your body aches all over, it's driving you mad.", pain_done)
	if(stun_host && !C.paralysis && C.chem_effects[CE_PAINKILLER] < pain_done)
		var/stun_duration = round(pain_done / 15 - C.chem_effects[CE_PAINKILLER] / 2)
		if(stun_duration < 1)
			return
		C.Paralyse(stun_duration)
		to_chat(C, SPAN_USERDANGER("The pain paralyzes you!"))

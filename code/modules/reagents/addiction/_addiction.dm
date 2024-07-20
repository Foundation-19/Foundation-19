/// Base class for addiction, handles when you become addicted and what the effects of that are. By default you become addicted when you hit a certain threshold, and stop being addicted once you go below another one.
/datum/addiction
	/// Name of this addiction
	var/name = "Unknown Addiction"
	/// Higher threshold, when you start being addicted
	var/addiction_gain_threshold = 600
	/// Lower threshold, when you stop being addicted
	var/addiction_loss_threshold = 400
	/// Messages for each stage of addictions.
	var/list/withdrawal_stage_messages = list()
	/// Rates at which you lose addiction (in units/second) if you are not on the drug at that time per stage
	var/addiction_loss_per_stage = list(0.5, 0.5, 1, 1.5)
	/// Amount of drugs you need in your system to be satisfied
	var/addiction_relief_treshold = MIN_ADDICTION_REAGENT_AMOUNT

/// Called when you gain addiction points somehow. Takes a carbon mob as argument and sees if you gained the addiction
/datum/addiction/proc/OnGainAddictionPoints(mob/living/carbon/victim)
	var/current_addiction_point_amount = victim.addiction_points[type]
	if(current_addiction_point_amount < addiction_gain_threshold) //Not enough to become addicted
		return
	if(LAZYACCESS(victim.active_addictions, type)) //Already addicted
		return
	BecomeAddicted(victim)

///Called when you become addicted
/datum/addiction/proc/BecomeAddicted(mob/living/carbon/victim)
	LAZYSET(victim.active_addictions, type, 1) // Start at first cycle.
	log_game("[key_name(victim)] has become addicted to [name].")

/// Called when you lose addiction points somehow. Takes a mind as argument and sees if you lost the addiction
/datum/addiction/proc/OnLoseAddictionPoints(mob/living/carbon/victim)
	var/current_addiction_point_amount = victim.addiction_points[type]
	if(!LAZYACCESS(victim.active_addictions, type)) // Not addicted
		return FALSE
	if(current_addiction_point_amount > addiction_loss_threshold) // Not enough to stop being addicted
		return FALSE
	LoseAddiction(victim)
	return TRUE

/datum/addiction/proc/LoseAddiction(mob/living/carbon/victim)
	LAZYREMOVE(victim.active_addictions, type)


/datum/addiction/proc/ProcessAddiction(mob/living/carbon/victim, delta_time = 2)
	var/current_addiction_cycle = LAZYACCESS(victim.active_addictions, type) // If this is null, we're not addicted
	for(var/drug_type in victim.chem_doses) // Go through the drugs in our system
		var/datum/reagent/R = drug_type
		for(var/addiction in initial(R.addiction_types)) // And check all of their addiction types
			if(addiction == type && victim.chem_doses[drug_type] >= addiction_relief_treshold) // If one of them matches, and we have enough of it in our system, we're not losing addiction
				if(current_addiction_cycle)
					LAZYSET(victim.active_addictions, type, 1) // Keeps withdrawal inactive for a while
				return

	var/withdrawal_stage
	switch(current_addiction_cycle)
		if(WITHDRAWAL_STAGE1_START_CYCLE to WITHDRAWAL_STAGE1_END_CYCLE)
			withdrawal_stage = 1
		if(WITHDRAWAL_STAGE2_START_CYCLE to WITHDRAWAL_STAGE2_END_CYCLE)
			withdrawal_stage = 2
		if(WITHDRAWAL_STAGE3_START_CYCLE to INFINITY)
			withdrawal_stage = 3
		else
			withdrawal_stage = 0

	if(victim.RemoveAddictionPoints(type, addiction_loss_per_stage[withdrawal_stage + 1] * delta_time)) // If true was returned, we lost the addiction!
		return

	if(!current_addiction_cycle) // Dont do the effects if were not on drugs
		return FALSE

	switch(current_addiction_cycle)
		if(WITHDRAWAL_STAGE1_START_CYCLE)
			WithdrawalEntersStage1(victim)
		if(WITHDRAWAL_STAGE2_START_CYCLE)
			WithdrawalEntersStage2(victim)
		if(WITHDRAWAL_STAGE3_START_CYCLE)
			WithdrawalEntersStage3(victim)

	///One cycle is 2 seconds
	switch(withdrawal_stage)
		if(1)
			WithdrawalStage1Process(victim, delta_time)
		if(2)
			WithdrawalStage3Process(victim, delta_time)
		if(3)
			WithdrawalStage3Process(victim, delta_time)

	LAZYADDASSOC(victim.active_addictions, type, 1 * delta_time) //Next cycle!

/// Called when addiction enters stage 1
/datum/addiction/proc/WithdrawalEntersStage1(mob/living/carbon/victim)
	return

/// Called when addiction enters stage 2
/datum/addiction/proc/WithdrawalEntersStage2(mob/living/carbon/victim)
	return

/// Called when addiction enters stage 3
/datum/addiction/proc/WithdrawalEntersStage3(mob/living/carbon/victim)
	return


/// Called when addiction is in stage 1 every process
/datum/addiction/proc/WithdrawalStage1Process(mob/living/carbon/victim, delta_time)
	if(prob(5))
		to_chat(victim, SPAN_DANGER("[withdrawal_stage_messages[1]]"))

/// Called when addiction is in stage 2 every process
/datum/addiction/proc/WithdrawalStage2Process(mob/living/carbon/victim, delta_time)
	if(prob(10))
		to_chat(victim, SPAN_DANGER("[withdrawal_stage_messages[2]]"))


/// Called when addiction is in stage 3 every process
/datum/addiction/proc/WithdrawalStage3Process(mob/living/carbon/victim, delta_time)
	if(prob(15))
		to_chat(victim, SPAN_DANGER("[withdrawal_stage_messages[3]]"))

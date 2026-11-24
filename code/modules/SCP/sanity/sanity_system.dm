// Sanity System for Foundation-19.
// Ported from daedalusdock code/datums/sanity_system.dm (AGPL), adapted:
//  - uses F19 SSmobs processing pattern via Life() calls instead of SSobj datum
//    processing (datum processing here lacks a per-datum processor)
//  - hallucinations ride F19's existing adjust_hallucination() pipeline
//  - medications hook into existing reagents/amnestics
//  - no TG quirks/mood dependencies

#define SANITY_NEUTRAL "neutral"
#define SANITY_GOOD "good"
#define SANITY_STRESSED "stressed"
#define SANITY_DISTRESSED "distressed"
#define SANITY_PANIC "panic"
#define SANITY_INSANE "insane"
#define SANITY_CATASTROPHIC "catastrophic"

#define TRAUMA_SCP_EXPOSURE "scp_exposure"
#define TRAUMA_VIOLENCE "violence"
#define TRAUMA_DEATH "death"
#define TRAUMA_ISOLATION "isolation"
#define TRAUMA_PSYCHOLOGICAL "psychological"
#define TRAUMA_PHYSICAL "physical"

#define INSANITY_PARANOIA "paranoia"
#define INSANITY_DELUSIONS "delusions"
#define INSANITY_AGGRESSION "aggression"
#define INSANITY_DEPRESSION "depression"
#define INSANITY_ANXIETY "anxiety"
#define INSANITY_DISSOCIATION "dissociation"

// Core sanity datum, attached to humans on init.
/datum/sanity
	var/mob/living/carbon/human/owner
	var/sanity_level = 100
	var/max_sanity = 100
	var/min_sanity = 0

	var/current_sanity_state = SANITY_NEUTRAL
	var/previous_sanity_state = SANITY_NEUTRAL

	var/sanity_recovery_rate = 0.5
	var/environmental_sanity_drain = 0
	var/last_sanity_change = 0

	// Trauma system: type -> severity (0..100). Higher severity = slower recovery.
	var/list/traumas = list()
	var/list/trauma_resistances = list()

	// Hallucination pressure (0..100); feeds into F19 hallucinations when high.
	var/hallucination_level = 0
	var/hallucination_cooldown = 0

	// Insanity: 0..100, unlocks effects at thresholds.
	var/insanity_level = 0
	var/list/active_insanity_effects = list()

	// SCP exposure tracking
	var/list/scp_exposures = list()
	var/scp_exposure_multiplier = 1.0

	// Social isolation 0..100
	var/social_isolation = 0

	// Medication: reagent name -> remaining effect ticks
	var/list/active_medications = list()

	// Stats
	var/total_sanity_lost = 0
	var/total_sanity_gained = 0
	var/sanity_breakdowns = 0

/datum/sanity/New(mob/living/carbon/human/H)
	. = ..()
	owner = H
	trauma_resistances = list(
		TRAUMA_SCP_EXPOSURE = 1.0,
		TRAUMA_VIOLENCE = 1.0,
		TRAUMA_DEATH = 1.0,
		TRAUMA_ISOLATION = 1.0,
		TRAUMA_PSYCHOLOGICAL = 1.0,
		TRAUMA_PHYSICAL = 1.0
	)

/datum/sanity/Destroy()
	owner = null
	return ..()

// Called from the owner's Life() in human_life.dm.
/datum/sanity/proc/process_sanity()
	if(!owner || owner.stat == DEAD)
		return
	update_environmental_factors()
	update_sanity()
	update_hallucinations()
	update_insanity_effects()
	check_sanity_state_change()
	apply_behavioral_effects()

/datum/sanity/proc/update_environmental_factors()
	environmental_sanity_drain = 0
	var/area/A = get_area(owner)
	if(A)
		// Darkness erodes nerves.
		var/turf/T = get_turf(owner)
		if(T && T.get_lumcount() < 0.2)
			environmental_sanity_drain += 0.15
	// SCPs within sight are deeply stressful.
	for(var/atom/scp_atom in view(7, owner))
		if(scp_atom.SCP)
			environmental_sanity_drain += 0.3 * scp_exposure_multiplier
			// record exposure for trauma accumulation
			var/desg = scp_atom.SCP.designation || "unknown"
			scp_exposures[desg] = (scp_exposures[desg] || 0) + 1
			if(scp_exposures[desg] > 30)
				add_trauma(TRAUMA_SCP_EXPOSURE, 2)
				scp_exposures[desg] = 0

/datum/sanity/proc/update_sanity()
	var/sanity_change = sanity_recovery_rate

	// Traumas throttle recovery and add drain proportional to severity.
	for(var/trauma_type in traumas)
		var/severity = traumas[trauma_type]
		var/resist = trauma_resistances[trauma_type] || 1.0
		sanity_change -= (severity / 100) * 0.2 * resist

	environmental_sanity_drain = clamp(environmental_sanity_drain, 0, 10)
	sanity_change -= environmental_sanity_drain

	// Isolation gnaws at the mind.
	if(social_isolation > 50)
		sanity_change -= (social_isolation - 50) * 0.01

	// Medications offset drain.
	for(var/med in active_medications)
		sanity_change += 1.0
		active_medications[med]--
		if(active_medications[med] <= 0)
			active_medications -= med

	adjust_sanity(sanity_change)

/datum/sanity/proc/adjust_sanity(amount, source)
	var/old = sanity_level
	sanity_level = clamp(sanity_level + amount, min_sanity, max_sanity)
	if(sanity_level < old)
		total_sanity_lost += (old - sanity_level)
	else if(sanity_level > old)
		total_sanity_gained += (sanity_level - old)

/datum/sanity/proc/add_trauma(trauma_type, severity)
	var/effective = severity * (trauma_resistances[trauma_type] || 1.0)
	traumas[trauma_type] = clamp((traumas[trauma_type] || 0) + effective, 0, 100)
	insanity_level = clamp(insanity_level + effective * 0.3, 0, 100)

/datum/sanity/proc/remove_trauma(trauma_type, amount)
	if(traumas[trauma_type])
		traumas[trauma_type] = max(0, traumas[trauma_type] - amount)
		if(traumas[trauma_type] == 0)
			traumas -= trauma_type
	// Therapy/medication also heals insanity slowly.
	insanity_level = clamp(insanity_level - amount * 0.2, 0, 100)

// Public entry points used by SCP interactions and events.
/datum/sanity/proc/on_scp_exposure(designation, severity = 10)
	// Site tech tree (Cognitive branch) reduces SCP exposure severity.
	if(GLOB.scp_research_director)
		severity = round(severity * (1 - GLOB.scp_research_director.tech_tree.get_sanity_resist()), 1)
		if(severity <= 0)
			return
	add_trauma(TRAUMA_SCP_EXPOSURE, severity)
	hallucination_level = clamp(hallucination_level + severity, 0, 100)
	adjust_sanity(-severity * scp_exposure_multiplier)

/datum/sanity/proc/on_witness_death(severity = 15)
	add_trauma(TRAUMA_DEATH, severity)
	adjust_sanity(-severity)

/datum/sanity/proc/on_violence_witnessed(severity = 8)
	add_trauma(TRAUMA_VIOLENCE, severity)
	adjust_sanity(-severity)

/datum/sanity/proc/on_prolonged_isolation(ticks)
	social_isolation = clamp(ticks / 10, 0, 100)

/datum/sanity/proc/on_social_contact(amount = 2)
	social_isolation = max(0, social_isolation - amount)

/datum/sanity/proc/apply_medication(med_name, ticks)
	active_medications[med_name] = max(active_medications[med_name] || 0, ticks)
	// Amnestics and mood stabilizers also clear some trauma.
	remove_trauma(TRAUMA_PSYCHOLOGICAL, 10)

/datum/sanity/proc/update_hallucinations()
	// High hallucination pressure bleeds into F19's native hallucination system.
	if(hallucination_level > 40 && world.time > hallucination_cooldown)
		if(owner.stat == CONSCIOUS)
			owner.adjust_hallucination(20 SECONDS, hallucination_level / 10)
			hallucination_cooldown = world.time + 30 SECONDS
	// Pressure decays as sanity recovers.
	if(sanity_level > 70)
		hallucination_level = max(0, hallucination_level - 0.5)

/datum/sanity/proc/update_insanity_effects()
	active_insanity_effects.Cut()
	if(insanity_level >= 30)
		active_insanity_effects += INSANITY_PARANOIA
	if(insanity_level >= 50)
		active_insanity_effects += INSANITY_ANXIETY
	if(insanity_level >= 70)
		active_insanity_effects += pick(INSANITY_AGGRESSION, INSANITY_DEPRESSION, INSANITY_DISSOCIATION)
	if(insanity_level >= 90)
		active_insanity_effects += INSANITY_DELUSIONS

/datum/sanity/proc/check_sanity_state_change()
	previous_sanity_state = current_sanity_state
	switch(sanity_level)
		if(85 to 100)
			current_sanity_state = SANITY_GOOD
		if(65 to 84)
			current_sanity_state = SANITY_NEUTRAL
		if(45 to 64)
			current_sanity_state = SANITY_STRESSED
		if(30 to 44)
			current_sanity_state = SANITY_DISTRESSED
		if(15 to 29)
			current_sanity_state = SANITY_PANIC
		if(5 to 14)
			current_sanity_state = SANITY_INSANE
		else
			current_sanity_state = SANITY_CATASTROPHIC
	if(current_sanity_state == SANITY_CATASTROPHIC && previous_sanity_state != SANITY_CATASTROPHIC)
		sanity_breakdowns++
		owner.visible_message(SPAN_DANGER("[owner] breaks down completely, screaming and clawing at the air!"))
		owner.emote("scream")

/datum/sanity/proc/apply_behavioral_effects()
	if(INSANITY_AGGRESSION in active_insanity_effects)
		if(prob(1) && owner.stat == CONSCIOUS)
			owner.visible_message(SPAN_WARNING("[owner] lashes out at nothing!"))
	if(INSANITY_DISSOCIATION in active_insanity_effects)
		if(prob(0.5))
			owner.adjust_dizzy(10 SECONDS)
	if(current_sanity_state == SANITY_PANIC || current_sanity_state == SANITY_INSANE)
		owner.hallucination_duration = max(owner.hallucination_duration, 5)

/datum/sanity/proc/get_data()
	return list(
		"sanity_level" = round(sanity_level),
		"state" = current_sanity_state,
		"insanity" = round(insanity_level),
		"traumas" = traumas.Copy(),
		"hallucination" = round(hallucination_level)
	)

// ---------------------------------------------------------------------------
// Hooks into human Life.

/mob/living/carbon/human/var/datum/sanity/sanity

/mob/living/carbon/human/New()
	sanity = new /datum/sanity(src)
	return ..()

/mob/living/carbon/human/Destroy()
	QDEL_NULL(sanity)
	return ..()

/mob/living/carbon/human/Life()
	if(sanity)
		sanity.process_sanity()
	return ..()

// SCP proximity/interaction exposure entry points.
/mob/living/carbon/human/proc/adjust_sanity(amount, source)
	if(sanity)
		sanity.adjust_sanity(amount, source)

/mob/living/carbon/human/proc/traumatize(trauma_type, severity)
	if(sanity)
		sanity.add_trauma(trauma_type, severity)

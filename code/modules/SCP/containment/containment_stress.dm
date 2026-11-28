
#define CONTAINMENT_STRESS_NONE 0
#define CONTAINMENT_STRESS_LOW 1
#define CONTAINMENT_STRESS_MODERATE 2
#define CONTAINMENT_STRESS_HIGH 3
#define CONTAINMENT_STRESS_CRITICAL 4
#define CONTAINMENT_STRESS_BREACH 5

#define WORK_TYPE_OBSERVATION "observation"
#define WORK_TYPE_INTERACTION "interaction"
#define WORK_TYPE_REPRESSION "repression"
#define WORK_TYPE_INSIGHT "insight"
#define WORK_TYPE_ATTACHMENT "attachment"
#define WORK_TYPE_INSTINCT "instinct"

#define STRESS_DECAY_BASE 0.05
#define STRESS_GAIN_BASE 0.1

/datum/containment_stress
	var/mob/living/owner
	var/stress_level = 0
	var/max_stress = 100
	var/stress_rate = STRESS_GAIN_BASE
	var/stress_decay_rate = STRESS_DECAY_BASE
	var/stress_threshold_low = 25
	var/stress_threshold_moderate = 50
	var/stress_threshold_high = 75
	var/stress_threshold_critical = 90
	var/last_work_time = 0
	var/work_cooldown = 30 SECONDS
	var/work_in_progress = FALSE
	var/current_work_type
	var/work_progress = 0
	var/work_required = 100
	var/list/stress_history = list()
	var/list/escape_events = list()
	var/list/work_responses = list()

/datum/containment_stress/New(mob/living/new_owner)
	owner = new_owner
	setup_scp_config()

/datum/containment_stress/Destroy()
	owner = null
	return ..()

/datum/containment_stress/proc/setup_scp_config()
	var/scp_id = get_scp_id()
	switch(scp_id)
		if("173")
			stress_rate = 0.3
			stress_decay_rate = 0.15
			work_responses = list(
				WORK_TYPE_OBSERVATION = list("effect" = -15, "risk" = 5),
				WORK_TYPE_INTERACTION = list("effect" = -25, "risk" = 20),
				WORK_TYPE_REPRESSION = list("effect" = -10, "risk" = 35),
			)
			escape_events = list(
				"critical" = "snap_restraints",
				"breach" = "breach_escape",
			)
		if("106")
			stress_rate = 0.2
			stress_decay_rate = 0.08
			work_responses = list(
				WORK_TYPE_OBSERVATION = list("effect" = -10, "risk" = 10),
				WORK_TYPE_INTERACTION = list("effect" = -20, "risk" = 25),
				WORK_TYPE_REPRESSION = list("effect" = -15, "risk" = 30),
			)
			escape_events = list(
				"high" = "corrode_wall",
				"critical" = "pocket_dimension",
				"breach" = "breach_escape",
			)
		if("049")
			stress_rate = 0.08
			stress_decay_rate = 0.12
			work_responses = list(
				WORK_TYPE_OBSERVATION = list("effect" = -15, "risk" = 5),
				WORK_TYPE_INTERACTION = list("effect" = -20, "risk" = 30),
				WORK_TYPE_REPRESSION = list("effect" = -10, "risk" = 15),
			)
			escape_events = list(
				"critical" = "seek_pestilence",
				"breach" = "breach_escape",
			)
		if("096")
			stress_rate = 0.05
			stress_decay_rate = 0.2
			work_responses = list(
				WORK_TYPE_OBSERVATION = list("effect" = -5, "risk" = 50),
				WORK_TYPE_INTERACTION = list("effect" = -10, "risk" = 70),
				WORK_TYPE_REPRESSION = list("effect" = -5, "risk" = 40),
			)
			escape_events = list(
				"high" = "cover_face_breach",
				"breach" = "pursuit",
			)
		if("079")
			stress_rate = 0.15
			stress_decay_rate = 0.05
			work_responses = list(
				WORK_TYPE_OBSERVATION = list("effect" = -10, "risk" = 15),
				WORK_TYPE_INTERACTION = list("effect" = -20, "risk" = 35),
				WORK_TYPE_REPRESSION = list("effect" = -25, "risk" = 20),
			)
			escape_events = list(
				"high" = "hack_cameras",
				"critical" = "override_doors",
				"breach" = "breach_escape",
			)
		if("682")
			stress_rate = 0.25
			stress_decay_rate = 0.03
			work_responses = list(
				WORK_TYPE_OBSERVATION = list("effect" = -5, "risk" = 10),
				WORK_TYPE_INTERACTION = list("effect" = -10, "risk" = 40),
				WORK_TYPE_REPRESSION = list("effect" = -8, "risk" = 30),
			)
			escape_events = list(
				"high" = "adaptive_resistance",
				"critical" = "brute_force",
				"breach" = "breach_escape",
			)
		if("035")
			stress_rate = 0.2
			stress_decay_rate = 0.1
			work_responses = list(
				WORK_TYPE_OBSERVATION = list("effect" = -10, "risk" = 20),
				WORK_TYPE_INTERACTION = list("effect" = -25, "risk" = 35),
				WORK_TYPE_ATTACHMENT = list("effect" = -30, "risk" = 45),
			)
			escape_events = list(
				"high" = "possess_observer",
				"critical" = "corrosion_breach",
				"breach" = "breach_escape",
			)
		if("457")
			stress_rate = 0.15
			stress_decay_rate = 0.08
			work_responses = list(
				WORK_TYPE_OBSERVATION = list("effect" = -10, "risk" = 15),
				WORK_TYPE_INSTINCT = list("effect" = -20, "risk" = 30),
				WORK_TYPE_REPRESSION = list("effect" = -30, "risk" = 20),
			)
			escape_events = list(
				"high" = "fuel_seek",
				"critical" = "inferno",
				"breach" = "breach_escape",
			)
		if("939")
			stress_rate = 0.1
			stress_decay_rate = 0.1
			work_responses = list(
				WORK_TYPE_OBSERVATION = list("effect" = -10, "risk" = 15),
				WORK_TYPE_INTERACTION = list("effect" = -20, "risk" = 30),
				WORK_TYPE_INSTINCT = list("effect" = -15, "risk" = 25),
			)
			escape_events = list(
				"critical" = "vocal_mimicry",
				"breach" = "breach_escape",
			)
		if("008")
			stress_rate = 0.12
			stress_decay_rate = 0.06
			work_responses = list(
				WORK_TYPE_OBSERVATION = list("effect" = -15, "risk" = 5),
				WORK_TYPE_INTERACTION = list("effect" = -25, "risk" = 40),
				WORK_TYPE_REPRESSION = list("effect" = -20, "risk" = 15),
			)
			escape_events = list(
				"critical" = "sporulation",
				"breach" = "breach_escape",
			)
		if("076")
			stress_rate = 0.2
			stress_decay_rate = 0.06
			work_responses = list(
				WORK_TYPE_OBSERVATION = list("effect" = -5, "risk" = 20),
				WORK_TYPE_INTERACTION = list("effect" = -15, "risk" = 40),
				WORK_TYPE_INSTINCT = list("effect" = -20, "risk" = 30),
			)
			escape_events = list(
				"high" = "summon_weapon",
				"critical" = "berserker",
				"breach" = "breach_escape",
			)
		else
			stress_rate = STRESS_GAIN_BASE
			stress_decay_rate = STRESS_DECAY_BASE
			work_responses = list(
				WORK_TYPE_OBSERVATION = list("effect" = -10, "risk" = 10),
				WORK_TYPE_INTERACTION = list("effect" = -20, "risk" = 25),
				WORK_TYPE_REPRESSION = list("effect" = -15, "risk" = 20),
			)
			escape_events = list(
				"breach" = "breach_escape",
			)

/datum/containment_stress/proc/get_scp_id()
	if(!owner?.SCP)
		return "Unknown"
	return "[owner.SCP.designation]"

/datum/containment_stress/proc/is_contained()
	var/datum/scp_research/research = owner?.SCP?.research
	if(!research)
		return TRUE // untracked entities treated as contained for stress decay
	return research.containment_status != SCP_BREACHED

/datum/containment_stress/proc/process_stress()
	if(!owner || owner.stat == DEAD)
		return
	if(work_in_progress)
		return
	var/old_tier = get_stress_tier()
	stress_level = min(max_stress, stress_level + stress_rate)
	if(is_contained())
		stress_level = max(0, stress_level - stress_decay_rate)
	var/area/A = get_area(get_turf(owner))
	if(A)
		var/obj/machinery/power/apc/apc = A.apc
		if(!apc || !apc.operating)
			stress_level = min(max_stress, stress_level + 0.05)
	var/new_tier = get_stress_tier()
	if(new_tier > old_tier)
		on_stress_tier_changed(old_tier, new_tier)
	if(stress_level >= max_stress)
		trigger_breach()

/datum/containment_stress/proc/get_stress_tier()
	switch(stress_level)
		if(0 to 24)
			return CONTAINMENT_STRESS_NONE
		if(25 to 49)
			return CONTAINMENT_STRESS_LOW
		if(50 to 74)
			return CONTAINMENT_STRESS_MODERATE
		if(75 to 89)
			return CONTAINMENT_STRESS_HIGH
		if(90 to 99)
			return CONTAINMENT_STRESS_CRITICAL
		else
			return CONTAINMENT_STRESS_BREACH

/datum/containment_stress/proc/get_stress_tier_name(tier)
	switch(tier)
		if(CONTAINMENT_STRESS_NONE)
			return "Nominal"
		if(CONTAINMENT_STRESS_LOW)
			return "Elevated"
		if(CONTAINMENT_STRESS_MODERATE)
			return "Moderate"
		if(CONTAINMENT_STRESS_HIGH)
			return "High"
		if(CONTAINMENT_STRESS_CRITICAL)
			return "Critical"
		if(CONTAINMENT_STRESS_BREACH)
			return "Breach"
	return "Unknown"

/datum/containment_stress/proc/on_stress_tier_changed(old_tier, new_tier)
	stress_history += list(list("time" = world.time, "from" = old_tier, "to" = new_tier))
	if(length(stress_history) > 30)
		stress_history.Cut(1, 2)
	var/tier_key = get_tier_key(new_tier)
	if(escape_events[tier_key])
		trigger_escape_event(tier_key)

/datum/containment_stress/proc/get_tier_key(tier)
	switch(tier)
		if(CONTAINMENT_STRESS_LOW)
			return "low"
		if(CONTAINMENT_STRESS_MODERATE)
			return "moderate"
		if(CONTAINMENT_STRESS_HIGH)
			return "high"
		if(CONTAINMENT_STRESS_CRITICAL)
			return "critical"
		if(CONTAINMENT_STRESS_BREACH)
			return "breach"
	return "none"

/datum/containment_stress/proc/trigger_escape_event(tier_key)
	var/event_type = escape_events[tier_key]
	if(!event_type)
		return
	INVOKE_ASYNC(src, PROC_REF(execute_escape_event), event_type)

/datum/containment_stress/proc/execute_escape_event(event_type)
	switch(event_type)
		if("snap_restraints")
			if(owner)
				owner.visible_message(SPAN_DANGER("[owner] strains against its restraints!"))
		if("corrode_wall")
			if(owner)
				owner.visible_message(SPAN_DANGER("Dark corrosion spreads from [owner]'s containment!"))
		if("pocket_dimension")
			if(owner)
				owner.visible_message(SPAN_DANGER("[owner] begins phasing through the floor!"))
		if("seek_pestilence")
			if(owner)
				owner.say("I sense the Pestilence... it must be cured.")
		if("cover_face_breach")
			if(owner)
				owner.visible_message(SPAN_DANGER("[owner] covers its face and begins to shake with rage!"))
		if("pursuit")
			if(owner)
				owner.visible_message(SPAN_USERDANGER("[owner] SCREAMS and begins pursuing!"))
		if("hack_cameras")
			if(owner)
				owner.visible_message(SPAN_DANGER("Nearby cameras flicker and glitch!"))
		if("override_doors")
			if(owner)
				owner.visible_message(SPAN_DANGER("Containment doors begin cycling open and shut erratically!"))
		if("adaptive_resistance")
			if(owner)
				owner.visible_message(SPAN_DANGER("[owner] appears to be adapting to containment measures!"))
		if("brute_force")
			if(owner)
				owner.visible_message(SPAN_DANGER("[owner] throws itself against the containment walls!"))
		if("possess_observer")
			if(owner)
				owner.visible_message(SPAN_WARNING("[owner]'s expression shifts, focusing on nearby personnel..."))
		if("corrosion_breach")
			if(owner)
				owner.visible_message(SPAN_DANGER("Black corrosion drips rapidly from [owner]!"))
		if("fuel_seek")
			if(owner)
				owner.visible_message(SPAN_DANGER("[owner] flares brighter, hungering for fuel!"))
		if("inferno")
			if(owner)
				owner.visible_message(SPAN_DANGER("[owner] erupts in flames, seeking to spread!"))
		if("vocal_mimicry")
			if(owner)
				owner.visible_message(SPAN_WARNING("[owner] begins mimicking human voices..."))
		if("sporulation")
			if(owner)
				owner.visible_message(SPAN_DANGER("Spores begin leaking from [owner]'s containment!"))
		if("summon_weapon")
			if(owner)
				owner.visible_message(SPAN_DANGER("[owner] materializes a blade from thin air!"))
		if("berserker")
			if(owner)
				owner.visible_message(SPAN_USERDANGER("[owner] enters a berserker rage!"))
		if("breach_escape")
			trigger_breach()

/datum/containment_stress/proc/trigger_breach()
	if(!owner)
		return FALSE
	if(!is_contained())
		return FALSE // already breached
	hook_scp_breach(get_scp_id(), owner)
	priority_announcement.Announce(
		"Containment breach detected. [owner.name] has escaped containment. All personnel are advised to exercise caution.",
		"Containment Stress Breach Alert",
		'sounds/effects/siren.ogg'
	)
	return TRUE

/datum/containment_stress/proc/perform_work(mob/living/carbon/human/worker, work_type)
	if(!owner || !worker)
		return FALSE
	if(work_in_progress)
		to_chat(worker, SPAN_WARNING("Work is already in progress on [owner]."))
		return FALSE
	if(world.time < last_work_time + work_cooldown)
		to_chat(worker, SPAN_WARNING("You need to wait before performing more work on [owner]."))
		return FALSE
	if(!work_responses[work_type])
		to_chat(worker, SPAN_WARNING("Invalid work type for [owner]."))
		return FALSE
	if(!is_contained())
		to_chat(worker, SPAN_WARNING("[owner] is not in containment."))
		return FALSE
	work_in_progress = TRUE
	current_work_type = work_type
	work_progress = 0
	to_chat(worker, SPAN_NOTICE("You begin [work_type] work on [owner]..."))
	var/list/response = work_responses[work_type]
	var/stress_effect = response["effect"]
	var/risk = response["risk"]
	var/duration = 5 SECONDS
	if(work_type == WORK_TYPE_OBSERVATION)
		duration = 3 SECONDS
	else if(work_type == WORK_TYPE_INTERACTION)
		duration = 8 SECONDS
	INVOKE_ASYNC(src, PROC_REF(complete_work), worker, stress_effect, risk, duration)
	return TRUE

/datum/containment_stress/proc/complete_work(mob/living/carbon/human/worker, stress_effect, risk, duration)
	var/cancelled = FALSE
	for(var/i in 1 to 5)
		if(!worker || !owner || owner.stat == DEAD)
			cancelled = TRUE
			break
		if(get_dist(worker, owner) > 3)
			cancelled = TRUE
			break
		if(worker.stat != CONSCIOUS)
			cancelled = TRUE
			break
		work_progress += 20
		sleep(duration / 5)
	if(cancelled)
		work_in_progress = FALSE
		current_work_type = null
		work_progress = 0
		if(worker)
			to_chat(worker, SPAN_WARNING("Work on [owner] was interrupted."))
		return
	work_in_progress = FALSE
	last_work_time = world.time
	work_progress = 0
	current_work_type = null
	if(prob(risk))
		to_chat(worker, SPAN_DANGER("Something goes wrong during your work on [owner]!"))
		stress_level = min(max_stress, stress_level + abs(stress_effect) * 0.5)
		on_work_failure(worker)
	else
		stress_level = max(0, stress_level + stress_effect)
		to_chat(worker, SPAN_NOTICE("Work on [owner] completed successfully. Containment stress reduced."))
		// Reward the worker with research points on the worked SCP.
		if(ishuman(worker) && owner?.SCP)
			var/datum/scp_research/research = owner.SCP.research
			if(research)
				research.add_research_points(10, "containment_stress_work")
				to_chat(worker, SPAN_NOTICE("+10 research points for [owner.SCP.designation] research."))
	on_work_complete(worker)

/datum/containment_stress/proc/on_work_failure(mob/living/carbon/human/worker)
	return

/datum/containment_stress/proc/on_work_complete(mob/living/carbon/human/worker)
	return

/datum/containment_stress/proc/adjust_stress(amount)
	stress_level = clamp(stress_level + amount, 0, max_stress)

/datum/containment_stress/proc/get_data()
	return list(
		"scp_id" = get_scp_id(),
		"stress_level" = round(stress_level, 1),
		"max_stress" = max_stress,
		"stress_tier" = get_stress_tier(),
		"stress_tier_name" = get_stress_tier_name(get_stress_tier()),
		"stress_rate" = stress_rate,
		"work_in_progress" = work_in_progress,
		"current_work_type" = current_work_type,
		"work_progress" = work_progress,
		"work_required" = work_required,
		"available_work_types" = work_responses.Copy(),
	)

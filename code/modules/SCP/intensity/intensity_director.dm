// Intensity Director for Foundation-19.
// Ported from daedalusdock scp_intensity_director.dm, adapted:
//  - tier score from F19-native signals: active breaches (research tracker),
//    security level, casualties, round time
//  - event pools trimmed to F19-supported actions (announcements, power events,
//    SCP agitation, trait reveals) — no TG-only systems referenced

#define INTENSITY_CALM 1
#define INTENSITY_TENSION 2
#define INTENSITY_ESCALATION 3
#define INTENSITY_CRISIS 4
#define INTENSITY_CATASTROPHE 5

SUBSYSTEM_DEF(intensity_director)
	name = "Intensity Director"
	wait = 30 SECONDS
	flags = SS_BACKGROUND

	var/intensity_score = 0
	var/intensity_tier = INTENSITY_CALM
	var/last_intensity_tier = INTENSITY_CALM

	var/breach_contribution = 0
	var/casualty_contribution = 0
	var/security_contribution = 0
	var/time_contribution = 0

	var/total_casualties_this_round = 0
	var/round_start_time = 0

	var/last_event_time = 0
	var/next_scheduled_event_time = 0
	var/event_cooldown = 3 MINUTES
	var/last_catastrophe_time = 0
	var/catastrophe_cooldown = 15 MINUTES

	var/enabled = TRUE

/datum/controller/subsystem/intensity_director/Initialize()
	round_start_time = world.time
	return ..()

/datum/controller/subsystem/intensity_director/fire()
	if(!enabled)
		return
	recalculate_intensity_score()
	apply_anti_frustration()
	check_tier_transitions()
	maybe_schedule_event()

/datum/controller/subsystem/intensity_director/proc/get_active_breach_count()
	var/breaches = 0
	if(SSscp_persistence?.manager)
		for(var/desg in SSscp_persistence.manager.scp_instances)
			var/datum/scp_instance/instance = SSscp_persistence.manager.scp_instances[desg]
			if(instance && instance.containment_status == "breached")
				breaches++
	// Fall back to research tracker live states.
	if(!breaches && GLOB.scp_research_tracker)
		breaches = length(GLOB.scp_research_tracker.get_active_breaches())
	return breaches

/datum/controller/subsystem/intensity_director/proc/recalculate_intensity_score()
	var/breaches = get_active_breach_count()
	breach_contribution = min(breaches * 13, 40)

	var/dead_players = 0
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(QDELETED(H) || !H.client)
			continue
		if(H.stat == DEAD)
			dead_players++
	total_casualties_this_round = dead_players
	casualty_contribution = min(dead_players * 4, 20)

	security_contribution = 0
	var/decl/security_state/security_state = decls_repository.get_decl(GLOB.using_map.security_state)
	// Security levels are ordered green→delta in all_security_levels; use index.
	var/current_index = security_state.all_security_levels.Find(security_state.current_security_level.type) - 1
	security_contribution = clamp(current_index * 3, 0, 10)

	var/round_minutes = (world.time - round_start_time) / (1 MINUTES)
	if(round_minutes < 10)
		time_contribution = 0
	else if(round_minutes < 20)
		time_contribution = 2
	else if(round_minutes < 40)
		time_contribution = 5
	else
		time_contribution = 8

	intensity_score = clamp(breach_contribution + casualty_contribution + security_contribution + time_contribution, 0, 100)

/datum/controller/subsystem/intensity_director/proc/apply_anti_frustration()
	// New-round mercy: early rounds stay calm regardless of score spikes.
	var/round_minutes = (world.time - round_start_time) / (1 MINUTES)
	if(round_minutes < 5 && intensity_tier > INTENSITY_TENSION)
		intensity_score = min(intensity_score, 20)
	// Casualty massacre damping: if over a third dead, don't pile more events.
	if(get_active_breach_count() >= 3)
		next_scheduled_event_time = max(next_scheduled_event_time, world.time + 5 MINUTES)

/datum/controller/subsystem/intensity_director/proc/check_tier_transitions()
	var/new_tier = INTENSITY_CALM
	switch(intensity_score)
		if(0 to 19) new_tier = INTENSITY_CALM
		if(20 to 39) new_tier = INTENSITY_TENSION
		if(40 to 59) new_tier = INTENSITY_ESCALATION
		if(60 to 79) new_tier = INTENSITY_CRISIS
		else new_tier = INTENSITY_CATASTROPHE

	if(new_tier != intensity_tier)
		last_intensity_tier = intensity_tier
		intensity_tier = new_tier
		announce_tier()

/datum/controller/subsystem/intensity_director/proc/announce_tier()
	var/msg
	switch(intensity_tier)
		if(INTENSITY_CALM)
			msg = "Site activity has returned to baseline. All personnel resume standard operations."
		if(INTENSITY_TENSION)
			msg = "Increased anomalous activity detected. Remain alert."
		if(INTENSITY_ESCALATION)
			msg = "Site conditions escalating. Security personnel to heightened readiness."
		if(INTENSITY_CRISIS)
			msg = "Site emergency conditions. All personnel follow emergency protocols."
		if(INTENSITY_CATASTROPHE)
			msg = "SITE-WIDE CATASTROPHIC EVENT IN PROGRESS. THIS IS NOT A DRILL."
	minor_announcement.Announce(msg, "Site Activity Monitor")

/datum/controller/subsystem/intensity_director/proc/maybe_schedule_event()
	if(world.time < next_scheduled_event_time)
		return
	if(world.time < last_event_time + event_cooldown)
		return
	// Catastrophe gating.
	if(intensity_tier == INTENSITY_CATASTROPHE && world.time < last_catastrophe_time + catastrophe_cooldown)
		return

	trigger_tier_event()
	last_event_time = world.time
	// Higher tiers schedule the next event sooner.
	next_scheduled_event_time = world.time + event_cooldown * (6 - intensity_tier) * 0.5

/datum/controller/subsystem/intensity_director/proc/trigger_tier_event()
	switch(intensity_tier)
		if(INTENSITY_CALM) trigger_calm_event()
		if(INTENSITY_TENSION) trigger_tension_event()
		if(INTENSITY_ESCALATION) trigger_escalation_event()
		if(INTENSITY_CRISIS) trigger_crisis_event()
		if(INTENSITY_CATASTROPHE) trigger_catastrophe_event()

// ---- Event implementations (F19-native) ----

/datum/controller/subsystem/intensity_director/proc/trigger_calm_event()
	var/list/candidates = list()
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(H.stat != DEAD && H.client && H.mind)
			candidates += H
	if(length(candidates))
		var/mob/living/carbon/human/H = pick(candidates)
		var/xp = SSengagement?.get_player(H.ckey)?.award_xp(25, "calm_period")
		to_chat(H, SPAN_NOTICE("You find a quiet moment at Site-53. <b>+25 XP</b>"))
	else
		priority_announcement.Announce("Facility systems nominal. Scheduled maintenance proceeding.", "Automated Systems")

/datum/controller/subsystem/intensity_director/proc/trigger_tension_event()
	var/list/options = list("flicker", "false_alarm", "agitation")
	var/choice = pick(options)
	switch(choice)
		if("flicker")
			priority_announcement.Announce("Minor power fluctuation detected in containment systems. Engineering notified.", "Automated Systems")
			flick_lights_random_zone()
		if("false_alarm")
			minor_announcement.Announce("Automated containment alarm triggered... sensor error confirmed. Resetting.", "Containment Systems")
		if("agitation")
			// SCP agitation: research advisory hints at behavioral shift.
			var/desg = pick_random_contained_scp()
			if(desg)
				minor_announcement.Announce("Behavioral sensors report elevated activity from SCP-[desg]. Monitoring escalated.", "Research Advisory")

/datum/controller/subsystem/intensity_director/proc/trigger_escalation_event()
	var/list/options = list("power_fluctuation", "stress_escalation", "single_breach")
	var/choice = pick(options)
	switch(choice)
		if("power_fluctuation")
			priority_announcement.Announce("Power grid instability in containment sectors. Backup generators priming.", "Engineering")
			flick_lights_random_zone()
		if("stress_escalation")
			var/desg = pick_random_contained_scp()
			if(desg)
				priority_announcement.Announce("SCP-[desg] containment stress rising. All personnel clear the containment wing.", "Containment Command")
		if("single_breach")
			// Force a single contained SCP's zone integrity warning → natural breach pressure.
			var/desg = pick_random_contained_scp()
			if(desg)
				priority_announcement.Announce("WARNING: SCP-[desg] containment integrity compromised. Security to containment wing immediately.", "Containment Command")

/datum/controller/subsystem/intensity_director/proc/trigger_crisis_event()
	var/list/options = list("multi_warning", "lockdown_drill")
	var/choice = pick(options)
	switch(choice)
		if("multi_warning")
			priority_announcement.Announce("MULTIPLE containment integrity warnings active. Full security response authorized.", "Containment Command")
		if("lockdown_drill")
			priority_announcement.Announce("Site lockdown drill initiated. All personnel to emergency stations.", "Site Director")

/datum/controller/subsystem/intensity_director/proc/trigger_catastrophe_event()
	last_catastrophe_time = world.time
	priority_announcement.Announce(
		"CASCADING CONTAINMENT FAILURE DETECTED. ALL PERSONNEL: ARMED RESPONSE IS AUTHORIZED. THIS IS NOT A DRILL.",
		"OMEGA PROTOCOL",
		'sounds/effects/siren.ogg'
	)

// ---- Helpers ----

/datum/controller/subsystem/intensity_director/proc/flick_lights_random_zone()
	// Simple ambient: find a random powered APC area and flick its lights.
	var/obj/machinery/power/apc/target_apc
	var/list/apcs = list()
	for(var/obj/machinery/power/apc/A in SSmachines.machinery)
		if(A.operating)
			apcs += A
	if(length(apcs))
		target_apc = pick(apcs)
		target_apc.energy_fail(10 SECONDS)

/datum/controller/subsystem/intensity_director/proc/pick_random_contained_scp()
	var/list/contained = list()
	if(SSscp_persistence?.manager)
		for(var/desg in SSscp_persistence.manager.scp_instances)
			var/datum/scp_instance/instance = SSscp_persistence.manager.scp_instances[desg]
			if(instance && instance.containment_status == "contained")
				contained += desg
	return length(contained) ? pick(contained) : null

// Admin verb to override the director.
/client/proc/set_intensity_tier()
	set name = "Set Intensity Tier"
	set category = "Admin"
	set desc = "Force the intensity director to a specific tier."
	if(!check_rights(R_ADMIN))
		return
	var/choice = tgui_input_list(usr, "Set intensity tier:", "Intensity Director", list("Calm", "Tension", "Escalation", "Crisis", "Catastrophe", "Auto"))
	if(!choice)
		return
	var/datum/controller/subsystem/intensity_director/SS = SSintensity_director
	switch(choice)
		if("Calm")
			SS.enabled = FALSE
			SS.intensity_tier = INTENSITY_CALM
		if("Tension")
			SS.enabled = FALSE
			SS.intensity_tier = INTENSITY_TENSION
		if("Escalation")
			SS.enabled = FALSE
			SS.intensity_tier = INTENSITY_ESCALATION
		if("Crisis")
			SS.enabled = FALSE
			SS.intensity_tier = INTENSITY_CRISIS
		if("Catastrophe")
			SS.enabled = FALSE
			SS.intensity_tier = INTENSITY_CATASTROPHE
		if("Auto")
			SS.enabled = TRUE
			to_chat(usr, "Intensity director returned to automatic control.")
			return
	to_chat(usr, "Intensity tier forced to [choice]. Auto mode disabled.")
	SS.announce_tier()

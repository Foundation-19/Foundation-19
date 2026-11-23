var/datum/controller/subsystem/scp_security/SSscp_security

/datum/controller/subsystem/scp_security
	name = "SCP Security"
	flags = SS_NO_FIRE
	var/list/tracked_breaches = list()
	var/breach_escalation_cooldown = 2 MINUTES
	var/auto_mtf_call_timer
	var/auto_mtf_delay = 5 MINUTES

/datum/controller/subsystem/scp_security/New()
	NEW_SS_GLOBAL(SSscp_security)

/datum/controller/subsystem/scp_security/Initialize(start_timeofday)
	RegisterSignal(GLOB.scp_research_tracker, COMSIG_CONTAINMENT_BREACH, PROC_REF(on_breach))
	. = ..()

/datum/controller/subsystem/scp_security/fire(resumed = FALSE)
	check_breach_status()

/datum/controller/subsystem/scp_security/proc/on_breach(datum/source, datum/scp_research/research, datum/scp/scp_datum)
	SIGNAL_HANDLER
	if(!scp_datum)
		return
	tracked_breaches["[scp_datum.designation]"] = world.time
	INVOKE_ASYNC(src, PROC_REF(escalate_security), scp_datum)

/datum/controller/subsystem/scp_security/proc/escalate_security(datum/scp/scp_datum)
	var/decl/security_state/security_state = decls_repository.get_decl(GLOB.using_map.security_state)
	if(!security_state)
		return
	var/target_level = calculate_target_security_level()
	if(!target_level)
		return
	if(security_state.current_security_level_is_lower_than(target_level))
		security_state.set_security_level(target_level)
		check_auto_mtf_call()

/datum/controller/subsystem/scp_security/proc/calculate_target_security_level()
	var/active_keter = 0
	var/active_euclid = 0
	var/active_safe = 0
	for(var/key in tracked_breaches)
		var/datum/scp_research/research = GLOB.scp_research_tracker.get_research(key)
		if(!research || research.containment_status != SCP_BREACHED)
			tracked_breaches -= key
			continue
		if(!research.parent)
			continue
		switch(research.parent.classification)
			if(SCP_KETER)
				active_keter++
			if(SCP_EUCLID)
				active_euclid++
			if(SCP_SAFE)
				active_safe++
	if(active_keter >= 2)
		return /decl/security_level/code_delta
	if(active_keter >= 1)
		return /decl/security_level/code_black
	if(active_euclid >= 2)
		return /decl/security_level/code_black
	if(active_euclid >= 1)
		return /decl/security_level/code_red
	if(active_safe >= 2)
		return /decl/security_level/code_yellow
	if(active_safe >= 1)
		return /decl/security_level/code_yellow
	return null

/datum/controller/subsystem/scp_security/proc/check_breach_status()
	var/any_breached = FALSE
	for(var/key in tracked_breaches)
		var/datum/scp_research/research = GLOB.scp_research_tracker.get_research(key)
		if(!research || research.containment_status != SCP_BREACHED)
			tracked_breaches -= key
			continue
		any_breached = TRUE
	if(!any_breached)
		var/decl/security_state/security_state = decls_repository.get_decl(GLOB.using_map.security_state)
		if(security_state && security_state.current_security_level_is_same_or_higher_than(/decl/security_level/code_red))
			security_state.decrease_security_level()

/datum/controller/subsystem/scp_security/proc/check_auto_mtf_call()
	if(auto_mtf_call_timer)
		return
	var/decl/security_state/security_state = decls_repository.get_decl(GLOB.using_map.security_state)
	if(!security_state)
		return
	if(security_state.current_security_level_is_same_or_higher_than(/decl/security_level/code_black))
		auto_mtf_call_timer = addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(call_mtf)), auto_mtf_delay, TIMER_STOPPABLE)

/proc/call_mtf()
	priority_announcement.Announce(
		"Multiple containment breaches confirmed. Mobile Task Force Epsilon-11 has been dispatched to assist with recontainment operations.",
		"MTF Dispatch Authorization",
		'sounds/effects/siren.ogg'
	)
	trigger_armed_response_team("SCP containment breach")

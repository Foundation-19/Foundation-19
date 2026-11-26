GLOBAL_DATUM_INIT(scp_research_tracker, /datum/scp_research_tracker, new)

/datum/scp_research_tracker
	var/list/research_datums = list()
	var/list/breach_log = list()
	var/list/test_log = list()
	var/total_breaches_this_round = 0

/datum/scp_research_tracker/proc/get_research(designation)
	return research_datums["[designation]"]

/datum/scp_research_tracker/proc/register_scp(datum/scp/scp_datum)
	if(!scp_datum || !scp_datum.designation)
		return
	var/key = "[scp_datum.designation]"
	if(research_datums[key])
		return
	var/datum/scp_research/research = new(scp_datum)
	research_datums[key] = research
	return research

/datum/scp_research_tracker/proc/log_breach(datum/scp/scp_datum, area/breached_from)
	if(!scp_datum)
		return
	total_breaches_this_round++
	breach_log += list(list(
		"designation" = scp_datum.designation,
		"name" = scp_datum.name,
		"classification" = scp_datum.classification,
		"time" = station_time_timestamp(),
		"world_time" = world.time,
		"area" = breached_from ? breached_from.name : "Unknown"
	))

/datum/scp_research_tracker/proc/log_test(datum/scp/scp_datum, mob/tester, test_type, result_summary)
	if(!scp_datum)
		return
	test_log += list(list(
		"designation" = scp_datum.designation,
		"name" = scp_datum.name,
		"tester" = tester ? tester.name : "Unknown",
		"test_type" = test_type,
		"result" = result_summary,
		"time" = station_time_timestamp(),
		"world_time" = world.time
	))

/datum/scp_research_tracker/proc/get_all_scp_data()
	var/list/data = list()
	for(var/key in research_datums)
		var/datum/scp_research/research = research_datums[key]
		data += list(research.get_data())
	return data

/datum/scp_research_tracker/proc/get_active_breaches()
	var/list/breaches = list()
	for(var/key in research_datums)
		var/datum/scp_research/research = research_datums[key]
		if(research.containment_status == SCP_BREACHED)
			breaches += list(research.get_data())
	return breaches

/datum/scp_research
	var/datum/scp/parent
	var/designation
	var/research_level = SCP_RESEARCH_NONE
	var/research_points = 0
	var/containment_status = SCP_UNKNOWN
	var/times_breached = 0
	var/last_breach_time = 0
	var/last_test_time = 0
	var/test_cooldown = 2 MINUTES
	var/containment_rating = SCP_RATING_A
	var/list/containment_history = list()
	var/list/discovered_interactions = list()
	var/last_contained_time = 0
	var/total_time_breached = 0
	var/breach_start_time = 0

/datum/scp_research/New(datum/scp/scp_datum)
	if(!scp_datum)
		return
	parent = scp_datum
	designation = scp_datum.designation
	containment_status = SCP_UNKNOWN

/datum/scp_research/Destroy()
	parent = null
	return ..()

/datum/scp_research/proc/add_research_points(amount, source)
	if(research_level >= SCP_RESEARCH_FULL)
		return
	research_points += amount
	check_tier_upgrade()
	// Site research overhaul: all point earnings also feed the site pool
	// and any active research projects targeting this SCP.
	if(GLOB.scp_research_director)
		GLOB.scp_research_director.on_points_earned(src, amount, source)

/datum/scp_research/proc/check_tier_upgrade()
	var/next_tier = research_level + 1
	if(next_tier > SCP_RESEARCH_FULL)
		return
	var/threshold = SCP_RESEARCH_THRESHOLDS[next_tier]
	if(research_points >= threshold)
		research_level = next_tier
		SEND_SIGNAL(parent, COMSIG_SCP_RESEARCH_UPDATE, src)
		if(parent && parent.parent)
			log_and_message_staff("SCP-[designation] research has advanced to [SCP_RESEARCH_TIER_NAME(research_level)] tier!")
			for(var/mob/living/carbon/human/H in GLOB.human_mob_list)
				var/datum/job/job = SSjobs.get_by_title(H.job)
				if(job && (job.department_flag & SCI))
					to_chat(H, SPAN_NOTICE("<b>Research Alert:</b> SCP-[designation] research has advanced to [SCP_RESEARCH_TIER_NAME(research_level)] tier."))

/datum/scp_research/proc/can_test()
	return world.time >= (last_test_time + test_cooldown)

/datum/scp_research/proc/perform_test(mob/tester, test_type, risk_level)
	if(!can_test())
		return FALSE
	last_test_time = world.time
	var/point_multiplier = 1
	switch(test_type)
		if("observation")
			point_multiplier = 0.5
		if("passive")
			point_multiplier = 1
		if("interaction")
			point_multiplier = 2
		if("dclass")
			point_multiplier = 3
		if("crosstest")
			point_multiplier = 4
	switch(risk_level)
		if("low")
			point_multiplier *= 1
		if("medium")
			point_multiplier *= 1.5
		if("high")
			point_multiplier *= 2
		if("extreme")
			point_multiplier *= 3
	var/points = round(25 * point_multiplier)
	add_research_points(points, "test_[test_type]")
	GLOB.scp_research_tracker.log_test(parent, tester, test_type, "+[points] points ([risk_level] risk)")
	// Codex: tests advance personal knowledge to detailed.
	codex_on_test(designation, tester, CODEX_DETAILED)
	// Cross-SCP interactions: testing an SCP may discover a hidden pairing.
	if(SSscp_cross_interactions && SSscp_cross_interactions.setup_complete && tester)
		SSscp_cross_interactions.try_discover_interaction(designation, tester.ckey)
	// Safety: extreme-risk tests damage the site safety rating.
	if(risk_level == "extreme" && GLOB.scp_research_director)
		GLOB.scp_research_director.on_extreme_test(designation)
	return points

/datum/scp_research/proc/set_containment_status(new_status)
	var/old_status = containment_status
	if(old_status == new_status)
		return
	containment_status = new_status
	containment_history += list(list(
		"status" = new_status,
		"time" = station_time_timestamp(),
		"world_time" = world.time
	))
	if(new_status == SCP_BREACHED)
		times_breached++
		last_breach_time = world.time
		breach_start_time = world.time
		var/area/A = parent ? get_area(parent.parent) : null
		GLOB.scp_research_tracker.log_breach(parent, A)
		SEND_SIGNAL(parent, COMSIG_CONTAINMENT_BREACH, src, parent)
		// The hook expects the SCP ATOM (it reads atom.SCP for the
		// classification); parent is the /datum/scp — pass parent.parent.
		hook_scp_breach(designation, parent?.parent)
		update_containment_rating()
	else if(new_status == SCP_CONTAINED && old_status == SCP_BREACHED)
		last_contained_time = world.time
		if(breach_start_time)
			total_time_breached += (world.time - breach_start_time)
			breach_start_time = 0
		add_research_points(50, "breach_resolution")
		SEND_SIGNAL(parent, COMSIG_CONTAINMENT_RECONTAINED, src, parent)
		hook_scp_recontained(designation, parent)
		update_containment_rating()

/datum/scp_research/proc/update_containment_rating()
	if(times_breached == 0)
		containment_rating = SCP_RATING_A
		return
	var/avg_response_time = total_time_breached / max(times_breached, 1)
	switch(times_breached)
		if(1)
			if(avg_response_time < 5 MINUTES)
				containment_rating = SCP_RATING_B
			else
				containment_rating = SCP_RATING_C
		if(2)
			if(avg_response_time < 5 MINUTES)
				containment_rating = SCP_RATING_C
			else
				containment_rating = SCP_RATING_D
		if(3 to 5)
			containment_rating = SCP_RATING_D
		else
			containment_rating = SCP_RATING_F

/datum/scp_research/proc/get_data()
	return list(
		"designation" = designation,
		"name" = parent ? parent.name : "Unknown",
		"classification" = parent ? parent.classification : "Unknown",
		"research_level" = research_level,
		"research_points" = research_points,
		"next_threshold" = (research_level < SCP_RESEARCH_FULL) ? SCP_RESEARCH_THRESHOLDS[research_level + 1] : 0,
		"containment_status" = containment_status,
		"times_breached" = times_breached,
		"containment_rating" = containment_rating,
		"can_test" = can_test(),
		"test_cooldown_remaining" = max(0, (last_test_time + test_cooldown) - world.time)
	)

/datum/scp_research/proc/get_tier_name()
	return SCP_RESEARCH_TIER_NAME(research_level)

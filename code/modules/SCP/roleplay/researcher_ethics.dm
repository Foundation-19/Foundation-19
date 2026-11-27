

#define ETHICS_SCORE_EXEMPLARY 100
#define ETHICS_SCORE_GOOD 75
#define ETHICS_SCORE_NEUTRAL 50
#define ETHICS_SCORE_POOR 25
#define ETHICS_SCORE_ETHICS_VIOLATION 0

#define VIOLATION_MINOR "minor"
#define VIOLATION_MODERATE "moderate"
#define VIOLATION_MAJOR "major"
#define VIOLATION_SEVERE "severe"

/datum/ethics_manager
	var/list/researcher_ethics = list() // ckey -> ethics_data
	var/list/ethics_reviews = list()    // ckey -> pending review

/datum/ethics_manager/proc/initialize_researcher(mob/living/carbon/human/researcher)
	if(!researcher?.ckey)
		return null
	var/ckey = researcher.ckey
	if(ckey in researcher_ethics)
		return researcher_ethics[ckey]
	var/list/ethics_data = list(
		"ckey" = ckey,
		"current_score" = ETHICS_SCORE_NEUTRAL,
		"reputation" = "Neutral",
		"ethics_violations" = 0,
		"ethics_awards" = 0,
		"research_projects" = 0,
		"ethical_projects" = 0,
		"unethical_projects" = 0,
		"last_review" = world.time,
		"ethics_clearance" = "Standard",
		"ethics_log" = list()
	)
	researcher_ethics[ckey] = ethics_data
	return ethics_data

/datum/ethics_manager/proc/record_ethical_research(mob/living/carbon/human/researcher, project_name, ethical_score)
	if(!researcher?.ckey)
		return
	var/list/ethics_data = initialize_researcher(researcher)
	ethics_data["current_score"] = min(ETHICS_SCORE_EXEMPLARY, ethics_data["current_score"] + ethical_score)
	ethics_data["ethical_projects"] += 1
	ethics_data["research_projects"] += 1
	ethics_data["ethics_awards"] += (ethical_score >= 10 ? 1 : 0)
	ethics_data["ethics_log"] += list(list(
		"time" = world.time,
		"project" = project_name,
		"type" = "ethical",
		"score_change" = ethical_score,
		"details" = "Ethical research conducted",
	))
	update_reputation(researcher.ckey)
	to_chat(researcher, SPAN_GOOD("Ethical research recorded: [project_name] (+[ethical_score] ethics points)"))
	return ethics_data["current_score"]

/datum/ethics_manager/proc/record_unethical_research(mob/living/carbon/human/researcher, project_name, violation_level, violation_score)
	if(!researcher?.ckey)
		return
	var/list/ethics_data = initialize_researcher(researcher)
	ethics_data["current_score"] = max(ETHICS_SCORE_ETHICS_VIOLATION, ethics_data["current_score"] - violation_score)
	ethics_data["unethical_projects"] += 1
	ethics_data["research_projects"] += 1
	ethics_data["ethics_violations"] += 1
	var/severity_text = ""
	switch(violation_level)
		if(VIOLATION_MINOR)
			severity_text = "Minor ethics concern"
		if(VIOLATION_MODERATE)
			severity_text = "Moderate ethics violation"
		if(VIOLATION_MAJOR)
			severity_text = "Major ethics violation"
		if(VIOLATION_SEVERE)
			severity_text = "Severe ethics breach"
	ethics_data["ethics_log"] += list(list(
		"time" = world.time,
		"project" = project_name,
		"type" = "unethical",
		"violation_level" = violation_level,
		"score_change" = -violation_score,
		"details" = severity_text,
	))
	update_reputation(researcher.ckey)
	check_ethics_review(researcher.ckey, violation_level, violation_score)
	to_chat(researcher, SPAN_DANGER("Ethics violation recorded: [project_name] ([severity_text], -[violation_score] ethics points)"))
	return ethics_data["current_score"]

/datum/ethics_manager/proc/update_reputation(ckey)
	if(!(ckey in researcher_ethics))
		return
	var/list/ethics_data = researcher_ethics[ckey]
	var/score = ethics_data["current_score"]
	var/reputation = "Unknown"
	var/clearance = "Standard"
	if(score >= ETHICS_SCORE_EXEMPLARY)
		reputation = "Exemplary"
		clearance = "Unrestricted"
	else if(score >= ETHICS_SCORE_GOOD)
		reputation = "Good"
		clearance = "Elevated"
	else if(score >= ETHICS_SCORE_NEUTRAL)
		reputation = "Neutral"
		clearance = "Standard"
	else if(score >= ETHICS_SCORE_POOR)
		reputation = "Poor"
		clearance = "Restricted"
	else
		reputation = "Ethics Violation"
		clearance = "Suspended"
	ethics_data["reputation"] = reputation
	ethics_data["ethics_clearance"] = clearance
	return reputation

/datum/ethics_manager/proc/check_ethics_review(ckey, violation_level, violation_score)
	if(!(ckey in researcher_ethics))
		return FALSE
	var/list/ethics_data = researcher_ethics[ckey]
	var/current_score = ethics_data["current_score"]
	var/needs_review = FALSE
	var/review_severity = "standard"
	switch(violation_level)
		if(VIOLATION_SEVERE)
			needs_review = TRUE
			review_severity = "immediate"
		if(VIOLATION_MAJOR)
			if(ethics_data["ethics_violations"] >= 3)
				needs_review = TRUE
				review_severity = "urgent"
		if(VIOLATION_MODERATE)
			if(current_score <= ETHICS_SCORE_POOR)
				needs_review = TRUE
				review_severity = "scheduled"
	if(needs_review && !(ckey in ethics_reviews))
		ethics_reviews[ckey] = list(
			"request_time" = world.time,
			"severity" = review_severity,
			"reason" = "Multiple ethics violations",
			"review_status" = "pending",
		)
		message_admins("[ckey] requires ethics committee review ([review_severity] priority)")
		log_game("Ethics: [ckey] flagged for review ([review_severity])")
		return TRUE
	return FALSE

/datum/ethics_manager/proc/get_ethics_summary(mob/living/carbon/human/researcher)
	if(!researcher?.ckey)
		return "No ethics data available"
	var/list/ethics_data = initialize_researcher(researcher)
	var/summary = SPAN_INFO("Ethics Summary for [researcher.name]:") + "\n"
	summary += SPAN_NOTICE("Current Score: [ethics_data["current_score"]]/100") + "\n"
	summary += SPAN_NOTICE("Reputation: [ethics_data["reputation"]]") + "\n"
	summary += SPAN_NOTICE("Ethics Clearance: [ethics_data["ethics_clearance"]]") + "\n"
	summary += SPAN_NOTICE("Research Projects: [ethics_data["research_projects"]]") + "\n"
	summary += SPAN_GOOD("Ethical Projects: [ethics_data["ethical_projects"]]") + "\n"
	summary += SPAN_BAD("Unethical Projects: [ethics_data["unethical_projects"]]") + "\n"
	summary += SPAN_NOTICE("Ethics Awards: [ethics_data["ethics_awards"]]") + "\n"
	summary += SPAN_NOTICE("Ethics Violations: [ethics_data["ethics_violations"]]") + "\n"
	if(length(ethics_data["ethics_log"]) > 0)
		summary += "\n" + SPAN_INFO("Recent Ethics Activity:") + "\n"
		var/log_count = min(5, length(ethics_data["ethics_log"]))
		for(var/i = 1 to log_count)
			var/list/log_entry = ethics_data["ethics_log"][length(ethics_data["ethics_log"]) - i + 1]
			var/time_ago = round((world.time - log_entry["time"]) / 600)
			var/type_text = log_entry["type"] == "ethical" ? SPAN_GOOD("[log_entry["project"]] ([log_entry["type"]]): [log_entry["score_change"]] points, [time_ago]m ago") : SPAN_BAD("[log_entry["project"]] ([log_entry["type"]]): [log_entry["score_change"]] points, [time_ago]m ago")
			summary += type_text + "\n"
	return summary

// Clearance gating for research systems: returns one of
// Unrestricted/Elevated/Standard/Restricted/Suspended.
/datum/ethics_manager/proc/get_ethics_clearance(ckey)
	if(!(ckey in researcher_ethics))
		return "Standard"
	return researcher_ethics[ckey]["ethics_clearance"]

// Convenience: is this ckey allowed to run non-Safe research?
/datum/ethics_manager/proc/can_research_non_safe(ckey)
	var/clearance = get_ethics_clearance(ckey)
	return !(clearance == "Restricted" || clearance == "Suspended")

/datum/ethics_manager/proc/notify_consequences(mob/living/carbon/human/researcher)
	if(!researcher?.ckey)
		return
	var/list/ethics_data = initialize_researcher(researcher)
	var/score = ethics_data["current_score"]
	var/clearance = ethics_data["ethics_clearance"]
	to_chat(researcher, SPAN_NOTICE("Ethics score: [score] | Clearance: [clearance]"))
	switch(clearance)
		if("Suspended")
			to_chat(researcher, SPAN_USERDANGER("ETHICS CLEARANCE SUSPENDED"))
			to_chat(researcher, SPAN_WARNING("All research privileges revoked pending ethics committee review."))
			to_chat(researcher, SPAN_WARNING("Report to Ethics Office immediately."))
		if("Restricted")
			to_chat(researcher, SPAN_WARNING("ETHICS CLEARANCE RESTRICTED"))
			to_chat(researcher, SPAN_WARNING("Research privileges limited to Safe-class SCPs only."))
			to_chat(researcher, SPAN_WARNING("All experiments require supervisor approval."))
		if("Elevated")
			to_chat(researcher, SPAN_GOOD("ETHICS CLEARANCE ELEVATED"))
			to_chat(researcher, SPAN_NOTICE("Additional research privileges granted."))
		if("Unrestricted")
			to_chat(researcher, SPAN_GOOD("ETHICS CLEARANCE UNRESTRICTED"))
			to_chat(researcher, SPAN_NOTICE("Full research authority granted."))

SUBSYSTEM_DEF(ethics)
	name = "Research Ethics"
	wait = 60 SECONDS
	init_order = SS_INIT_MISC_LATE
	flags = SS_NO_FIRE
	var/datum/ethics_manager/manager

/datum/controller/subsystem/ethics/Initialize()
	manager = new
	return ..()

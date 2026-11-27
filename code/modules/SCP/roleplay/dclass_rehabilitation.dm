
#define REHAB_TIER_0 "tier_0"
#define REHAB_TIER_1 "tier_1"
#define REHAB_TIER_2 "tier_2"
#define REHAB_TIER_3 "tier_3"
#define REHAB_TIER_4 "tier_4"

/datum/rehabilitation_manager
	var/list/player_rehab_data = list() // ckey -> rehab_data
	var/list/promotion_queue = list()   // players queued for promotion review

/datum/rehabilitation_manager/proc/initialize_player(mob/living/carbon/human/player)
	if(!player?.ckey)
		return null
	var/ckey = player.ckey
	if(ckey in player_rehab_data)
		return player_rehab_data[ckey]
	var/list/rehab_data = list(
		"ckey" = ckey,
		"current_tier" = REHAB_TIER_0,
		"good_behavior_points" = 0,
		"bad_behavior_points" = 0,
		"days_served" = 0,
		"sentence_reduction_days" = 0,
		"last_evaluation" = world.time,
		"promotion_eligible" = FALSE,
		"rehab_completed" = FALSE,
		"behavior_log" = list()
	)
	player_rehab_data[ckey] = rehab_data
	return rehab_data

/datum/rehabilitation_manager/proc/award_good_behavior(mob/living/carbon/human/player, reason, points = 1)
	if(!player?.ckey)
		return
	var/list/rehab_data = initialize_player(player)
	rehab_data["good_behavior_points"] += points
	rehab_data["behavior_log"] += list(list("time" = world.time, "reason" = reason, "points" = points, "type" = "good"))
	check_tier_promotion(player.ckey)
	to_chat(player, SPAN_GOOD("Good behavior noted: [reason] (+[points] rehabilitation points)"))
	return rehab_data["good_behavior_points"]

/datum/rehabilitation_manager/proc/record_bad_behavior(mob/living/carbon/human/player, reason, points = 1)
	if(!player?.ckey)
		return
	var/list/rehab_data = initialize_player(player)
	rehab_data["bad_behavior_points"] += points
	rehab_data["behavior_log"] += list(list("time" = world.time, "reason" = reason, "points" = points, "type" = "bad"))
	check_tier_demotion(player.ckey)
	to_chat(player, SPAN_DANGER("Bad behavior recorded: [reason] (+[points] demerit points)"))
	return rehab_data["bad_behavior_points"]

/datum/rehabilitation_manager/proc/check_tier_promotion(ckey)
	if(!(ckey in player_rehab_data))
		return FALSE
	var/list/rehab_data = player_rehab_data[ckey]
	var/current_tier = rehab_data["current_tier"]
	var/rehab_score = rehab_data["good_behavior_points"] - (rehab_data["bad_behavior_points"] * 2)
	var/new_tier = current_tier
	switch(current_tier)
		if(REHAB_TIER_0)
			if(rehab_score >= 10 && rehab_data["days_served"] >= 1)
				new_tier = REHAB_TIER_1
		if(REHAB_TIER_1)
			if(rehab_score >= 25 && rehab_data["days_served"] >= 3)
				new_tier = REHAB_TIER_2
		if(REHAB_TIER_2)
			if(rehab_score >= 50 && rehab_data["days_served"] >= 7 && rehab_data["bad_behavior_points"] <= 5)
				new_tier = REHAB_TIER_3
		if(REHAB_TIER_3)
			if(rehab_score >= 100 && rehab_data["days_served"] >= 14 && rehab_data["bad_behavior_points"] <= 10)
				new_tier = REHAB_TIER_4
				rehab_data["promotion_eligible"] = TRUE
				add_to_promotion_queue(ckey)
	if(new_tier != current_tier)
		rehab_data["current_tier"] = new_tier
		var/reduction_days = 0
		switch(new_tier)
			if(REHAB_TIER_1)
				reduction_days = 1
			if(REHAB_TIER_2)
				reduction_days = 3
			if(REHAB_TIER_3)
				reduction_days = 7
			if(REHAB_TIER_4)
				reduction_days = 14
		rehab_data["sentence_reduction_days"] += reduction_days
		award_tier_promotion(ckey, new_tier)
		return TRUE
	return FALSE

/datum/rehabilitation_manager/proc/check_tier_demotion(ckey)
	if(!(ckey in player_rehab_data))
		return FALSE
	var/list/rehab_data = player_rehab_data[ckey]
	var/current_tier = rehab_data["current_tier"]
	var/bad_points = rehab_data["bad_behavior_points"]
	var/new_tier = current_tier
	switch(current_tier)
		if(REHAB_TIER_1)
			if(bad_points >= 10)
				new_tier = REHAB_TIER_0
		if(REHAB_TIER_2)
			if(bad_points >= 15)
				new_tier = REHAB_TIER_1
		if(REHAB_TIER_3)
			if(bad_points >= 20)
				new_tier = REHAB_TIER_2
		if(REHAB_TIER_4)
			if(bad_points >= 25)
				new_tier = REHAB_TIER_3
				rehab_data["promotion_eligible"] = FALSE
	if(new_tier != current_tier)
		rehab_data["current_tier"] = new_tier
		apply_tier_demotion(ckey, new_tier)
		return TRUE
	return FALSE

/datum/rehabilitation_manager/proc/get_mob_by_key(ckey)
	for(var/mob/M in GLOB.player_list)
		if(M.ckey == ckey)
			return M
	return null

/datum/rehabilitation_manager/proc/award_tier_promotion(ckey, new_tier)
	var/mob/living/player = get_mob_by_key(ckey)
	if(!player)
		return
	var/tier_name = "Unknown"
	var/list/rewards = list()
	switch(new_tier)
		if(REHAB_TIER_1)
			tier_name = "Basic Privileges"
			rewards = list("Access to recreational areas", "Reduced monitoring", "1-day sentence reduction")
		if(REHAB_TIER_2)
			tier_name = "Trusted Worker"
			rewards = list("Access to workshop areas", "Assigned work tasks", "3-day sentence reduction")
		if(REHAB_TIER_3)
			tier_name = "Rehabilitation Candidate"
			rewards = list("Access to library/education", "Mentor new D-Class", "7-day sentence reduction")
		if(REHAB_TIER_4)
			tier_name = "Promotion Eligible"
			rewards = list("Staff position consideration", "14-day sentence reduction", "Security clearance upgrade")
	to_chat(player, SPAN_BOLD("=== REHABILITATION PROMOTION ==="))
	to_chat(player, SPAN_NOTICE("You have been promoted to: [tier_name]"))
	to_chat(player, SPAN_NOTICE("Rewards:"))
	for(var/reward in rewards)
		to_chat(player, SPAN_GOOD("- [reward]"))
	to_chat(player, SPAN_NOTICE("Continue good behavior for further promotions."))

/datum/rehabilitation_manager/proc/apply_tier_demotion(ckey, new_tier)
	var/mob/living/player = get_mob_by_key(ckey)
	if(!player)
		return
	var/tier_name = "Unknown"
	var/list/restrictions = list()
	switch(new_tier)
		if(REHAB_TIER_0)
			tier_name = "New Arrival"
			restrictions = list("Basic cell access only", "Constant monitoring", "Restricted movement")
		if(REHAB_TIER_1)
			tier_name = "Basic Privileges"
			restrictions = list("Limited area access", "Increased monitoring")
		if(REHAB_TIER_2)
			tier_name = "Trusted Worker"
			restrictions = list("Work task reassignment", "Increased supervision")
		if(REHAB_TIER_3)
			tier_name = "Rehabilitation Candidate"
			restrictions = list("Mentor privileges revoked", "Education access restricted")
	to_chat(player, SPAN_USERDANGER("=== REHABILITATION DEMOTION ==="))
	to_chat(player, SPAN_WARNING("You have been demoted to: [tier_name]"))
	to_chat(player, SPAN_WARNING("Restrictions:"))
	for(var/restriction in restrictions)
		to_chat(player, SPAN_BAD("- [restriction]"))
	to_chat(player, SPAN_WARNING("Improve your behavior to regain privileges."))

/datum/rehabilitation_manager/proc/add_to_promotion_queue(ckey)
	if(!(ckey in promotion_queue))
		promotion_queue += ckey
		message_admins("[ckey] is eligible for D-Class promotion review.")
		log_game("Rehabilitation: [ckey] added to promotion queue")

/datum/rehabilitation_manager/proc/process_promotion_queue()
	if(!length(promotion_queue))
		return
	var/ckey = promotion_queue[1]
	promotion_queue -= ckey
	if(!(ckey in player_rehab_data))
		return
	var/list/rehab_data = player_rehab_data[ckey]
	var/mob/living/player = get_mob_by_key(ckey)
	if(!player)
		// Player offline; keep in queue for the next check.
		promotion_queue += ckey
		return
	if(rehab_data["promotion_eligible"] && rehab_data["current_tier"] == REHAB_TIER_4)
		offer_promotion(player, rehab_data)

/datum/rehabilitation_manager/proc/offer_promotion(mob/living/player, list/rehab_data)
	if(!player || !rehab_data)
		return
	to_chat(player, SPAN_BOLD("=== PROMOTION OFFER ==="))
	to_chat(player, SPAN_NOTICE("Congratulations! Your rehabilitation progress has qualified you for promotion to Foundation staff."))
	to_chat(player, SPAN_NOTICE("Available positions:"))
	var/list/positions = list("Janitorial Staff", "Kitchen Staff", "Maintenance Technician")
	for(var/position in positions)
		to_chat(player, SPAN_GOOD("- [position]"))
	rehab_data["promotion_offer"] = list(
		"positions" = positions,
		"offer_time" = world.time,
		"expires" = world.time + (5 MINUTES),
	)

/datum/rehabilitation_manager/proc/accept_promotion(mob/living/carbon/human/player, choice)
	if(!player?.ckey)
		return FALSE
	var/list/rehab_data = player_rehab_data[player.ckey]
	if(!rehab_data || !rehab_data["promotion_offer"])
		return FALSE
	var/list/offer = rehab_data["promotion_offer"]
	if(world.time > offer["expires"])
		to_chat(player, SPAN_WARNING("Your promotion offer has expired."))
		rehab_data -= "promotion_offer"
		return FALSE
	var/list/positions = offer["positions"]
	if(!(choice in positions))
		return FALSE
	// Map the chosen staff title to a job datum.
	var/job_title = null
	switch(choice)
		if("Janitorial Staff")
			job_title = "Janitor"
		if("Kitchen Staff")
			job_title = "Chef"
		if("Maintenance Technician")
			job_title = "Junior Engineer"
	var/datum/job/new_job = job_title ? SSjobs.get_by_title(job_title) : null
	if(new_job && player.mind)
		player.mind.assigned_role = new_job.title
	to_chat(player, SPAN_GOOD("Congratulations! You have been promoted to [choice]!"))
	to_chat(player, SPAN_NOTICE("Report to your new assignment immediately."))
	rehab_data -= "promotion_offer"
	rehab_data["rehab_completed"] = TRUE
	log_game("Rehabilitation: [player.ckey] promoted to [choice]")
	message_admins("[player.ckey] accepted D-Class rehabilitation promotion to [choice].")
	return TRUE

// === Player Verbs ===

/mob/living/carbon/human/proc/check_rehabilitation_status()
	set name = "Check Rehabilitation Status"
	set category = "IC"
	set desc = "Check your rehabilitation progress and sentence reduction"

	if(!SSrehabilitation?.manager)
		to_chat(src, SPAN_WARNING("Rehabilitation system not available."))
		return
	var/list/rehab_data = SSrehabilitation.manager.initialize_player(src)
	var/message = SPAN_INFO("Rehabilitation Status:") + "\n"
	message += SPAN_NOTICE("Current Tier: [rehab_data["current_tier"]]") + "\n"
	message += SPAN_NOTICE("Good Behavior Points: [rehab_data["good_behavior_points"]]") + "\n"
	message += SPAN_NOTICE("Bad Behavior Points: [rehab_data["bad_behavior_points"]]") + "\n"
	message += SPAN_NOTICE("Days Served: [rehab_data["days_served"]]") + "\n"
	message += SPAN_NOTICE("Sentence Reduction: [rehab_data["sentence_reduction_days"]] days") + "\n"
	if(rehab_data["promotion_eligible"])
		message += SPAN_GOOD("PROMOTION ELIGIBLE: You qualify for staff promotion!") + "\n"
	var/requirements = ""
	switch(rehab_data["current_tier"])
		if(REHAB_TIER_0)
			requirements = "10 good points, 1 day served for Tier 1"
		if(REHAB_TIER_1)
			requirements = "25 good points, 3 days served for Tier 2"
		if(REHAB_TIER_2)
			requirements = "50 good points, 7 days served, 5 or fewer bad points for Tier 3"
		if(REHAB_TIER_3)
			requirements = "100 good points, 14 days served, 10 or fewer bad points for Tier 4 (Promotion)"
	if(requirements)
		message += SPAN_NOTICE("Next Tier: [requirements]") + "\n"
	if(rehab_data["promotion_offer"])
		message += SPAN_GOOD("PROMOTION OFFER PENDING — 'Accept Promotion Offer' verb available.") + "\n"
	to_chat(src, message)

/mob/living/carbon/human/verb/accept_promotion_offer()
	set name = "Accept Promotion Offer"
	set category = "IC"
	set desc = "Accept your promotion to Foundation staff"

	if(!SSrehabilitation?.manager || !ckey)
		to_chat(src, SPAN_WARNING("Rehabilitation system not available."))
		return
	var/list/rehab_data = SSrehabilitation.manager.player_rehab_data[ckey]
	if(!rehab_data || !rehab_data["promotion_offer"])
		to_chat(src, SPAN_WARNING("No promotion offer available."))
		return
	var/list/offer = rehab_data["promotion_offer"]
	if(world.time > offer["expires"])
		to_chat(src, SPAN_WARNING("Your promotion offer has expired."))
		rehab_data -= "promotion_offer"
		return
	var/list/positions = offer["positions"]
	var/choice = input(src, "Select a staff position to accept:", "Promotion Acceptance") as null|anything in positions
	if(!choice)
		to_chat(src, SPAN_NOTICE("Promotion offer declined."))
		rehab_data -= "promotion_offer"
		return
	SSrehabilitation.manager.accept_promotion(src, choice)

// === Subsystem ===
SUBSYSTEM_DEF(rehabilitation)
	name = "Rehabilitation"
	wait = 600
	init_order = SS_INIT_MISC_LATE
	var/datum/rehabilitation_manager/manager

/datum/controller/subsystem/rehabilitation/Initialize()
	manager = new /datum/rehabilitation_manager()
	log_game("Rehabilitation Subsystem: Initialized")
	return ..()

/datum/controller/subsystem/rehabilitation/fire()
	if(!manager)
		return
	manager.process_promotion_queue()
	for(var/client/C in GLOB.clients)
		var/mob/living/carbon/human/H = C.mob
		if(istype(H) && H.mind && H.mind.assigned_role == "Class D")
			var/list/rehab_data = manager.initialize_player(H)
			rehab_data["days_served"] += 0.001

// === Integration hooks for other systems ===

/proc/rehabilitation_good_behavior(mob/living/carbon/human/player, reason, points = 1)
	if(SSrehabilitation?.manager)
		SSrehabilitation.manager.award_good_behavior(player, reason, points)

/proc/rehabilitation_bad_behavior(mob/living/carbon/human/player, reason, points = 1)
	if(SSrehabilitation?.manager)
		SSrehabilitation.manager.record_bad_behavior(player, reason, points)

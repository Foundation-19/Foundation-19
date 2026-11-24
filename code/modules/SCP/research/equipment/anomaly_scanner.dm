/obj/item/device/scp_anomaly_scanner
	name = "anomalous object scanner"
	desc = "A specialized scanner for detecting and analyzing anomalous phenomena. Grants research data when used on SCP objects."
	icon = 'icons/obj/machines/scp_anomaly_scanner.dmi'
	icon_state = "scanner"
	item_state = "scp_scanner"
	w_class = ITEM_SIZE_SMALL
	slot_flags = SLOT_BELT
	var/scan_cooldown = 10 SECONDS
	var/last_scan_time = 0
	var/scan_range = 5
	var/points_per_scan = 1
	var/accumulated_points = 0
	var/points_to_award = 10

/obj/item/device/scp_anomaly_scanner/afterattack(atom/target, mob/user, proximity)
	if(!proximity)
		return
	if(world.time < last_scan_time + scan_cooldown)
		to_chat(user, SPAN_WARNING("\The [src] is recharging."))
		return
	if(!target.SCP)
		to_chat(user, SPAN_NOTICE("No anomalous signature detected."))
		return
	last_scan_time = world.time
	var/datum/scp/scp_datum = target.SCP
	var/datum/scp_research/research = scp_datum.research
	if(!research)
		to_chat(user, SPAN_WARNING("Unable to connect to research database."))
		return
	accumulated_points += points_per_scan
	if(accumulated_points >= points_to_award)
		research.add_research_points(accumulated_points, "scanner_observation")
		accumulated_points = 0
	// Cross-SCP interactions: sustained observation may discover a hidden pairing.
	if(SSscp_cross_interactions && SSscp_cross_interactions.setup_complete && user)
		SSscp_cross_interactions.try_discover_interaction(scp_datum.designation, user.ckey)
	var/tier_name = research.get_tier_name()
	var/status = research.containment_status
	to_chat(user, SPAN_NOTICE("<b>Scan Result - SCP-[scp_datum.designation]</b>"))
	to_chat(user, SPAN_NOTICE("Classification: [scp_datum.classification]"))
	to_chat(user, SPAN_NOTICE("Research Tier: [tier_name] (Level [research.research_level])"))
	to_chat(user, SPAN_NOTICE("Research Points: [research.research_points]/[(research.research_level < SCP_RESEARCH_FULL) ? SCP_RESEARCH_THRESHOLDS[research.research_level + 1] : "---"]"))
	to_chat(user, SPAN_NOTICE("Containment Status: [status]"))
	if(research.research_level >= SCP_RESEARCH_BASIC)
		to_chat(user, SPAN_NOTICE("Times Breached: [research.times_breached]"))
		to_chat(user, SPAN_NOTICE("Containment Rating: [research.containment_rating]"))
	if(research.research_level >= SCP_RESEARCH_ADVANCED)
		to_chat(user, SPAN_NOTICE("Breach Probability: [estimate_breach_probability(scp_datum, research)]%"))
	// Behavioral trait discovery: requires at least Basic tier.
	if(research.research_level >= SCP_RESEARCH_BASIC)
		SSscp_personality?.scan_for_trait(user, scp_datum.designation)
	playsound(loc, 'sounds/machines/ping.ogg', 30, 1)

/obj/item/device/scp_anomaly_scanner/proc/estimate_breach_probability(datum/scp/scp_datum, datum/scp_research/research)
	if(!scp_datum || !scp_datum.parent)
		return 0
	var/breach_prob = 0
	if(research.containment_status == SCP_BREACHED)
		return 100
	if(ismob(scp_datum.parent))
		var/mob/M = scp_datum.parent
		if(M.client)
			breach_prob += 30
	switch(scp_datum.classification)
		if(SCP_KETER)
			breach_prob += 40
		if(SCP_EUCLID)
			breach_prob += 20
		if(SCP_SAFE)
			breach_prob += 5
	breach_prob += research.times_breached * 10
	return min(breach_prob, 100)

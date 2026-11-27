// Shared helpers for the ported daedalusdock SCP systems.
// F19 has no global research pool: points live on per-SCP research datums
// (GLOB.scp_research_tracker) and the site pool is fed from those via
// GLOB.scp_research_director. These helpers resolve a loose SCP id
// ("SCP-457", "457") to a research datum, falling back to the most
// recently breached SCP so system rewards still land somewhere useful.

/proc/scp_systems_resolve_research(scp_text)
	if(!scp_text)
		return null
	var/des = "[scp_text]"
	des = replacetext(des, "SCP-", "")
	des = replacetext(des, "scp-", "")
	des = trim(des)
	if(!des || !GLOB.scp_research_tracker)
		return null
	return GLOB.scp_research_tracker.get_research(des)

// Awards [amount] research points. Order of preference:
// 1. research datum matching scp_text
// 2. most recently breached SCP's research datum
// Returns TRUE if points were awarded.
/proc/scp_systems_award_research(amount, source, scp_text)
	if(!GLOB.scp_research_tracker || amount <= 0)
		return FALSE
	var/datum/scp_research/research = scp_systems_resolve_research(scp_text)
	if(!research)
		var/datum/scp_research/best
		var/best_time = -1
		for(var/key in GLOB.scp_research_tracker.research_datums)
			var/datum/scp_research/R = GLOB.scp_research_tracker.research_datums[key]
			if(R.containment_status == SCP_BREACHED && R.last_breach_time > best_time)
				best_time = R.last_breach_time
				best = R
		if(!best)
			return FALSE
		research = best
	research.add_research_points(amount, source)
	return TRUE

// Security console access gate shared by the systems consoles.
// Returns the operating human, or null (with a denial message) on failure.
/proc/scp_systems_check_access(mob/living/carbon/human/H, required_access)
	if(!istype(H))
		return null
	if(!required_access)
		return H
	var/obj/item/card/id/id_card = H.GetIdCard()
	if(!id_card || !(required_access in id_card.access))
		to_chat(H, SPAN_WARNING("Access denied."))
		return null
	return H

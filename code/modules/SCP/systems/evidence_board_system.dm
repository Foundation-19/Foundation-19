// Evidence Board — forensic evidence submission, verification and
// investigations. Ported from daedalusdock, adapted to F19:
//  - research rewards via scp_systems_award_research
//  - zone defaults via get_area_name (exists in F19 _helpers/game.dm)

SUBSYSTEM_DEF(evidence_board)
	name = "Evidence Board"
	wait = 30 SECONDS
	init_order = SS_INIT_MISC_LATE
	flags = SS_NO_FIRE

	var/list/evidence_entries = list()
	var/list/investigations = list()
	var/total_evidence = 0

/datum/controller/subsystem/evidence_board/proc/submit_evidence(mob/living/carbon/human/submitter, evidence_type, description, zone)
	if(!istype(submitter) || !description)
		return FALSE
	var/evidence_id = "evi_[world.time]_[submitter.ckey]"
	evidence_entries += list(list(
		"evidence_id" = evidence_id,
		"submitter" = submitter.real_name,
		"submitter_ckey" = submitter.ckey,
		"type" = evidence_type || "observation",
		"description" = description,
		"zone" = zone || get_area_name(submitter),
		"time" = time2text(world.time, "hh:mm:ss"),
		"timestamp" = world.time,
		"linked_investigation" = null,
		"verified" = FALSE,
	))
	total_evidence++
	if(scp_systems_award_research(8, "evidence_submitted:[evidence_type]", null))
		to_chat(submitter, SPAN_NOTICE("Evidence submitted: [description]."))
	return evidence_id

/datum/controller/subsystem/evidence_board/proc/verify_evidence(evidence_id, mob/living/carbon/human/verifier)
	if(!evidence_id)
		return FALSE
	for(var/list/ev in evidence_entries)
		if(ev["evidence_id"] == evidence_id && !ev["verified"])
			ev["verified"] = TRUE
			if(scp_systems_award_research(12, "evidence_verified", null))
				to_chat(verifier, SPAN_NOTICE("Evidence verified."))
			return TRUE
	return FALSE

/datum/controller/subsystem/evidence_board/proc/create_investigation(mob/living/carbon/human/investigator, title, scp_id)
	if(!istype(investigator) || !title)
		return FALSE
	var/investigation_id = "inv_[world.time]_[investigator.ckey]"
	investigations[investigation_id] = list(
		"id" = investigation_id,
		"title" = title,
		"scp_id" = scp_id || "Unknown",
		"investigator" = investigator.real_name,
		"investigator_ckey" = investigator.ckey,
		"start_time" = world.time,
		"evidence_count" = 0,
		"status" = "active",
		"conclusion" = null,
	)
	to_chat(investigator, SPAN_NOTICE("Investigation created: [title]. ID: [investigation_id]"))
	return investigation_id

/datum/controller/subsystem/evidence_board/proc/link_evidence(investigation_id, evidence_id)
	if(!investigations[investigation_id] || !evidence_id)
		return FALSE
	for(var/list/ev in evidence_entries)
		if(ev["evidence_id"] == evidence_id)
			ev["linked_investigation"] = investigation_id
			var/list/inv = investigations[investigation_id]
			inv["evidence_count"]++
			return TRUE
	return FALSE

/datum/controller/subsystem/evidence_board/proc/close_investigation(investigation_id, conclusion, mob/living/carbon/human/closer)
	if(!investigations[investigation_id] || !conclusion)
		return FALSE
	var/list/inv = investigations[investigation_id]
	inv["status"] = "closed"
	inv["conclusion"] = conclusion
	var/evidence_count = inv["evidence_count"]
	var/reward = 20 + (evidence_count * 5)
	if(scp_systems_award_research(reward, "investigation_closed:[inv["scp_id"]]", inv["scp_id"]))
		to_chat(closer, SPAN_NOTICE("Investigation closed. [evidence_count] evidence linked."))
	return TRUE

/obj/machinery/evidence_board_console
	name = "Evidence board console"
	desc = "A console for submitting, reviewing, and managing forensic evidence and investigations."
	icon = 'icons/obj/computer.dmi'
	icon_state = "security"
	anchored = TRUE
	density = TRUE
	use_power = POWER_USE_IDLE
	idle_power_usage = 300
	active_power_usage = 500
	var/required_access = ACCESS_SECURITY_LVL2

/obj/machinery/evidence_board_console/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ScpEvidenceBoardProgram", "Evidence Board")
		ui.set_autoupdate(FALSE)
		ui.open()

/obj/machinery/evidence_board_console/tgui_state(mob/user)
	return GLOB.physical_tgui_state

/obj/machinery/evidence_board_console/tgui_data(mob/user)
	var/list/data = list()
	var/list/evidence = SSevidence_board.evidence_entries
	data["evidence"] = evidence.Copy(max(1, length(evidence) - 29), 0)
	data["investigations"] = list()
	for(var/inv_id in SSevidence_board.investigations)
		var/list/inv = SSevidence_board.investigations[inv_id]
		data["investigations"] += list(list(
			"id" = inv_id,
			"title" = inv["title"],
			"scp_id" = inv["scp_id"],
			"investigator" = inv["investigator"],
			"evidence_count" = inv["evidence_count"],
			"status" = inv["status"],
			"conclusion" = inv["conclusion"],
		))
	data["total_evidence"] = SSevidence_board.total_evidence
	return data

/obj/machinery/evidence_board_console/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	var/mob/living/carbon/human/H = scp_systems_check_access(ui?.user || usr, required_access)
	if(!H)
		return
	switch(action)
		if("submit_evidence")
			SSevidence_board.submit_evidence(H, params["evidence_type"] || "observation", params["description"] || "No description", params["zone"])
			return TRUE
		if("verify_evidence")
			SSevidence_board.verify_evidence(params["evidence_id"], H)
			return TRUE
		if("create_investigation")
			SSevidence_board.create_investigation(H, params["title"] || "Investigation", params["scp_id"])
			return TRUE
		if("link_evidence")
			SSevidence_board.link_evidence(params["investigation_id"], params["evidence_id"])
			return TRUE
		if("close_investigation")
			SSevidence_board.close_investigation(params["investigation_id"], params["conclusion"] || "Resolved", H)
			return TRUE
	return FALSE

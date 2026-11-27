// Breach Aftermath — post-breach structural repair, decontamination,
// lessons learned and debriefs. Ported from daedalusdock, adapted to F19:
//  - research rewards go through scp_systems_award_research (per-SCP datums)
//  - aftermath records are created automatically from hook_scp_breach
//    and stamped on recontainment via hook_scp_recontained

SUBSYSTEM_DEF(breach_aftermath)
	name = "Breach Aftermath"
	wait = 30 SECONDS
	init_order = SS_INIT_MISC_LATE
	flags = SS_NO_FIRE

	var/list/active_aftermaths = list()
	var/list/aftermath_log = list()
	var/total_debriefs = 0

/datum/controller/subsystem/breach_aftermath/proc/log_event(list/entry)
	aftermath_log += list(entry)
	if(length(aftermath_log) > 200)
		aftermath_log.Cut(1, 50)

// Called from hook_scp_breach. Creates (or reuses) an aftermath record.
/datum/controller/subsystem/breach_aftermath/proc/on_breach(scp_id, zone)
	if(!scp_id)
		return
	for(var/a_id in active_aftermaths)
		var/list/a = active_aftermaths[a_id]
		if(a["scp_id"] == scp_id)
			return
	create_aftermath(scp_id, zone, 0)

// Called from hook_scp_recontained. Stamps the elapsed breach duration
// onto any open aftermath record for this SCP.
/datum/controller/subsystem/breach_aftermath/proc/on_recontained(scp_id)
	if(!scp_id)
		return
	for(var/a_id in active_aftermaths)
		var/list/a = active_aftermaths[a_id]
		if(a["scp_id"] == scp_id && !a["breach_duration"])
			a["breach_duration"] = round((world.time - a["start_time"]) / 600, 1)
			log_event(list(
				"id" = a_id,
				"event" = "recontained",
				"scp_id" = scp_id,
				"duration_min" = a["breach_duration"],
				"time" = time2text(world.time, "hh:mm:ss"),
			))

/datum/controller/subsystem/breach_aftermath/proc/create_aftermath(scp_id, zone, breach_duration)
	var/aftermath_id = "after_[world.time]_[scp_id]"
	active_aftermaths[aftermath_id] = list(
		"id" = aftermath_id,
		"scp_id" = scp_id,
		"zone" = zone || "unknown",
		"breach_duration" = breach_duration,
		"start_time" = world.time,
		"structural_damage" = rand(10, 50),
		"contamination_level" = rand(0, 30),
		"personnel_casualties" = rand(0, 3),
		"lessons_learned" = list(),
		"repairs_done" = 0,
		"debrief_done" = FALSE,
	)
	log_event(list(
		"id" = aftermath_id,
		"event" = "created",
		"scp_id" = scp_id,
		"zone" = zone || "unknown",
		"time" = time2text(world.time, "hh:mm:ss"),
	))
	return aftermath_id

/datum/controller/subsystem/breach_aftermath/proc/repair_damage(aftermath_id, amount, mob/living/carbon/human/engineer)
	if(!active_aftermaths[aftermath_id] || !istype(engineer))
		return FALSE
	var/list/aftermath = active_aftermaths[aftermath_id]
	amount = clamp(amount, 1, 50)
	aftermath["structural_damage"] = max(0, aftermath["structural_damage"] - amount)
	aftermath["repairs_done"] += amount
	scp_systems_award_research(amount, "aftermath_repair", aftermath["scp_id"])
	to_chat(engineer, SPAN_NOTICE("Structural repairs: -[amount] damage. Remaining: [aftermath["structural_damage"]]."))
	return TRUE

/datum/controller/subsystem/breach_aftermath/proc/decontaminate(aftermath_id, amount, mob/living/carbon/human/medic)
	if(!active_aftermaths[aftermath_id] || !istype(medic))
		return FALSE
	var/list/aftermath = active_aftermaths[aftermath_id]
	amount = clamp(amount, 1, 50)
	aftermath["contamination_level"] = max(0, aftermath["contamination_level"] - amount)
	scp_systems_award_research(amount, "aftermath_decon", aftermath["scp_id"])
	to_chat(medic, SPAN_NOTICE("Decontamination: -[amount]. Remaining: [aftermath["contamination_level"]]."))
	return TRUE

/datum/controller/subsystem/breach_aftermath/proc/submit_lesson(aftermath_id, lesson_text, mob/living/carbon/human/submitter)
	if(!active_aftermaths[aftermath_id] || !lesson_text || !istype(submitter))
		return FALSE
	var/list/aftermath = active_aftermaths[aftermath_id]
	aftermath["lessons_learned"] += list(list(
		"lesson" = lesson_text,
		"author" = submitter.real_name,
		"time" = time2text(world.time, "hh:mm:ss"),
	))
	if(scp_systems_award_research(8, "aftermath_lesson", aftermath["scp_id"]))
		to_chat(submitter, SPAN_NOTICE("Lesson learned submitted: [lesson_text]."))
	return TRUE

/datum/controller/subsystem/breach_aftermath/proc/complete_debrief(aftermath_id, mob/living/carbon/human/officer)
	if(!active_aftermaths[aftermath_id] || !istype(officer))
		return FALSE
	var/list/aftermath = active_aftermaths[aftermath_id]
	aftermath["debrief_done"] = TRUE
	total_debriefs++
	var/lesson_count = length(aftermath["lessons_learned"])
	var/reward = 20 + (lesson_count * 5) + aftermath["repairs_done"]
	if(scp_systems_award_research(reward, "aftermath_debrief:[aftermath["scp_id"]]", aftermath["scp_id"]))
		to_chat(officer, SPAN_NOTICE("Debrief completed for SCP-[aftermath["scp_id"]]. [lesson_count] lessons, [aftermath["repairs_done"]] repairs."))
	else
		to_chat(officer, SPAN_NOTICE("Debrief completed for SCP-[aftermath["scp_id"]]. No active research target for reward."))
	if(SSdepartment_reputation)
		SSdepartment_reputation.adjust_reputation("Security", 3, "debrief_completed")
		SSdepartment_reputation.adjust_reputation("Science", 2, "debrief_lessons")
	log_event(list(
		"id" = aftermath_id,
		"event" = "debriefed",
		"scp_id" = aftermath["scp_id"],
		"zone" = aftermath["zone"],
		"lessons" = lesson_count,
		"time" = time2text(world.time, "hh:mm:ss"),
	))
	active_aftermaths -= aftermath_id
	return TRUE

/obj/machinery/breach_aftermath_console
	name = "Breach aftermath console"
	desc = "A console for managing post-breach repairs, decontamination, and debriefs."
	icon = 'icons/obj/computer.dmi'
	icon_state = "security"
	anchored = TRUE
	density = TRUE
	use_power = POWER_USE_IDLE
	idle_power_usage = 300
	active_power_usage = 500
	var/required_access = ACCESS_SECURITY_LVL2

/obj/machinery/breach_aftermath_console/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ScpAftermathProgram", "Breach Aftermath")
		ui.set_autoupdate(FALSE)
		ui.open()

/obj/machinery/breach_aftermath_console/tgui_state(mob/user)
	return GLOB.physical_tgui_state

/obj/machinery/breach_aftermath_console/tgui_data(mob/user)
	var/list/data = list()
	data["active_aftermaths"] = list()
	for(var/a_id in SSbreach_aftermath.active_aftermaths)
		var/list/a = SSbreach_aftermath.active_aftermaths[a_id]
		data["active_aftermaths"] += list(list(
			"id" = a_id,
			"scp_id" = a["scp_id"],
			"zone" = a["zone"],
			"breach_duration" = a["breach_duration"],
			"structural_damage" = a["structural_damage"],
			"contamination_level" = a["contamination_level"],
			"personnel_casualties" = a["personnel_casualties"],
			"lessons_count" = length(a["lessons_learned"]),
			"repairs_done" = a["repairs_done"],
			"debrief_done" = a["debrief_done"],
		))
	data["total_debriefs"] = SSbreach_aftermath.total_debriefs
	var/list/log = SSbreach_aftermath.aftermath_log
	data["log"] = log.Copy(max(1, length(log) - 14), 0)
	return data

/obj/machinery/breach_aftermath_console/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	var/mob/living/carbon/human/H = scp_systems_check_access(ui?.user || usr, required_access)
	if(!H)
		return
	switch(action)
		if("repair")
			SSbreach_aftermath.repair_damage(params["aftermath_id"], text2num(params["amount"]) || 10, H)
			return TRUE
		if("decontaminate")
			SSbreach_aftermath.decontaminate(params["aftermath_id"], text2num(params["amount"]) || 10, H)
			return TRUE
		if("submit_lesson")
			SSbreach_aftermath.submit_lesson(params["aftermath_id"], params["lesson"] || "Observation noted.", H)
			return TRUE
		if("complete_debrief")
			SSbreach_aftermath.complete_debrief(params["aftermath_id"], H)
			return TRUE
		if("create_aftermath")
			SSbreach_aftermath.create_aftermath(params["scp_id"] || "Unknown", params["zone"] || "HCZ", text2num(params["duration"]) || 0)
			to_chat(H, SPAN_NOTICE("Aftermath record created."))
			return TRUE
	return FALSE

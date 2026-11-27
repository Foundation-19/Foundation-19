// D-Class Behavior — per-player compliance/trust/defiance tracking for
// Class-D personnel. Ported from daedalusdock, adapted to F19:
//  - find_mob_by_ckey replaced with a GLOB.player_list scan

SUBSYSTEM_DEF(dclass_behavior)
	name = "D-Class Behavior"
	wait = 30 SECONDS
	init_order = SS_INIT_MISC_LATE
	flags = SS_NO_FIRE

	var/list/player_behavior = list()
	var/list/behavior_log = list()

/datum/controller/subsystem/dclass_behavior/proc/new_behavior_record()
	return list("compliance" = 50, "defiance" = 0, "trust" = 0, "incident_count" = 0, "cooperation_streak" = 0, "last_action" = world.time)

/datum/controller/subsystem/dclass_behavior/proc/get_behavior(ckey)
	if(!ckey || !player_behavior[ckey])
		return new_behavior_record()
	return player_behavior[ckey]

/datum/controller/subsystem/dclass_behavior/proc/adjust_compliance(ckey, amount, source)
	if(!ckey)
		return
	if(!player_behavior[ckey])
		player_behavior[ckey] = new_behavior_record()
	var/list/behavior = player_behavior[ckey]
	behavior["compliance"] = clamp(behavior["compliance"] + amount, 0, 100)
	if(amount > 0)
		behavior["cooperation_streak"]++
		behavior["trust"] = min(100, behavior["trust"] + amount * 0.5)
	else
		behavior["cooperation_streak"] = 0
		behavior["defiance"] = min(100, behavior["defiance"] + abs(amount))
	behavior["last_action"] = world.time
	log_behavior(ckey, "compliance_adjust", amount, source)

/datum/controller/subsystem/dclass_behavior/proc/record_incident(ckey, incident_type, severity)
	if(!ckey)
		return
	if(!player_behavior[ckey])
		player_behavior[ckey] = new_behavior_record()
	var/list/behavior = player_behavior[ckey]
	behavior["incident_count"]++
	behavior["compliance"] = max(0, behavior["compliance"] - severity * 5)
	behavior["defiance"] = min(100, behavior["defiance"] + severity * 3)
	behavior["cooperation_streak"] = 0
	log_behavior(ckey, "incident_[incident_type]", severity, "recorded")

/datum/controller/subsystem/dclass_behavior/proc/get_behavior_label(ckey)
	var/list/behavior = get_behavior(ckey)
	var/compliance = behavior["compliance"]
	if(compliance >= 80)
		return "COOPERATIVE"
	if(compliance >= 60)
		return "COMPLIANT"
	if(compliance >= 40)
		return "NEUTRAL"
	if(compliance >= 20)
		return "UNCOOPERATIVE"
	return "DEFIANT"

/datum/controller/subsystem/dclass_behavior/proc/get_trust_modifier(ckey)
	var/list/behavior = get_behavior(ckey)
	return 1.0 + (behavior["trust"] / 200)

/datum/controller/subsystem/dclass_behavior/proc/get_escape_chance(ckey)
	var/list/behavior = get_behavior(ckey)
	return min(80, behavior["defiance"] + (behavior["incident_count"] * 5))

/datum/controller/subsystem/dclass_behavior/proc/log_behavior(ckey, action, amount, source)
	behavior_log += list(list(
		"ckey" = ckey,
		"action" = action,
		"amount" = amount,
		"source" = source || "unknown",
		"time" = time2text(world.time, "hh:mm:ss"),
	))
	if(length(behavior_log) > 200)
		behavior_log.Cut(1, 50)

/obj/machinery/dclass_behavior_console
	name = "D-Class behavior monitor"
	desc = "A console for monitoring and managing D-Class behavior and compliance."
	icon = 'icons/obj/computer.dmi'
	icon_state = "security"
	anchored = TRUE
	density = TRUE
	use_power = POWER_USE_IDLE
	idle_power_usage = 300
	active_power_usage = 500
	var/required_access = ACCESS_SECURITY_LVL2

/obj/machinery/dclass_behavior_console/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ScpDclassBehaviorProgram", "D-Class Behavior")
		ui.set_autoupdate(FALSE)
		ui.open()

/obj/machinery/dclass_behavior_console/tgui_state(mob/user)
	return GLOB.physical_tgui_state

/obj/machinery/dclass_behavior_console/tgui_data(mob/user)
	var/list/data = list()
	data["players"] = list()
	for(var/ckey in SSdclass_behavior.player_behavior)
		var/list/b = SSdclass_behavior.player_behavior[ckey]
		var/mob/M = null
		for(var/mob/P in GLOB.player_list)
			if(P.ckey == ckey && ishuman(P))
				M = P
				break
		if(M)
			data["players"] += list(list(
				"ckey" = ckey,
				"name" = M.real_name,
				"compliance" = b["compliance"],
				"defiance" = b["defiance"],
				"trust" = b["trust"],
				"incidents" = b["incident_count"],
				"streak" = b["cooperation_streak"],
				"label" = SSdclass_behavior.get_behavior_label(ckey),
			))
	var/list/log = SSdclass_behavior.behavior_log
	data["recent_log"] = log.Copy(max(1, length(log) - 14), 0)
	return data

/obj/machinery/dclass_behavior_console/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	var/mob/living/carbon/human/H = scp_systems_check_access(ui?.user || usr, required_access)
	if(!H)
		return
	switch(action)
		if("reward_compliance")
			SSdclass_behavior.adjust_compliance(params["ckey"], 10, "reward")
			return TRUE
		if("penalize")
			SSdclass_behavior.record_incident(params["ckey"], "disciplinary", 1)
			return TRUE
		if("reset_behavior")
			if(SSdclass_behavior.player_behavior[params["ckey"]])
				SSdclass_behavior.player_behavior[params["ckey"]] = SSdclass_behavior.new_behavior_record()
			return TRUE
	return FALSE

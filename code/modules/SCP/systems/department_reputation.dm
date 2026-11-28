// Department Reputation — tracks inter-department standing and drives
// cooperation multipliers. Ported from daedalusdock, adapted to F19.

SUBSYSTEM_DEF(department_reputation)
	name = "Department Reputation"
	wait = 60 SECONDS
	init_order = SS_INIT_MISC_LATE
	flags = SS_NO_FIRE

	var/list/department_reputation = list()
	var/list/reputation_log = list()
	var/list/interactions = list()

/datum/controller/subsystem/department_reputation/Initialize()
	department_reputation = list(
		"Science" = 50,
		"Security" = 50,
		"Medical" = 50,
		"Engineering" = 50,
		"Command" = 50,
		"Service" = 50,
		"Supply" = 50,
	)
	return ..()

/datum/controller/subsystem/department_reputation/proc/adjust_reputation(department, amount, source)
	if(!department_reputation[department])
		department_reputation[department] = 50
	department_reputation[department] = clamp(department_reputation[department] + amount, 0, 100)
	reputation_log += list(list(
		"department" = department,
		"amount" = amount,
		"source" = source || "unknown",
		"new_value" = department_reputation[department],
		"time" = time2text(world.time, "hh:mm:ss"),
	))
	if(length(reputation_log) > 200)
		reputation_log.Cut(1, 50)

/datum/controller/subsystem/department_reputation/proc/get_reputation(department)
	if(!department_reputation[department])
		return 50
	return department_reputation[department]

/datum/controller/subsystem/department_reputation/proc/get_cooperation_mult(dept1, dept2)
	var/rep1 = get_reputation(dept1)
	var/rep2 = get_reputation(dept2)
	var/avg = (rep1 + rep2) / 2
	if(avg >= 80)
		return 1.3
	if(avg >= 60)
		return 1.0
	if(avg >= 40)
		return 0.85
	return 0.7

/datum/controller/subsystem/department_reputation/proc/record_interaction(dept1, dept2, interaction_type, success)
	var/key = "[dept1]-[dept2]-[world.time]"
	interactions[key] = list(
		"dept1" = dept1,
		"dept2" = dept2,
		"type" = interaction_type,
		"success" = success,
		"time" = world.time,
	)
	if(length(interactions) > 200)
		for(var/k in interactions)
			interactions -= k
			break

/datum/controller/subsystem/department_reputation/proc/get_reputation_label(rep)
	if(rep >= 90)
		return "ALLIED"
	if(rep >= 70)
		return "FRIENDLY"
	if(rep >= 50)
		return "NEUTRAL"
	if(rep >= 30)
		return "TENSE"
	if(rep >= 15)
		return "HOSTILE"
	return "WAR"

/obj/machinery/department_reputation_console
	name = "Department relations console"
	desc = "A console for monitoring inter-department reputation and cooperation status."
	icon = 'icons/obj/computer.dmi'
	icon_state = "aiupload"
	anchored = TRUE
	density = TRUE
	use_power = POWER_USE_IDLE
	idle_power_usage = 300
	active_power_usage = 500

/obj/machinery/department_reputation_console/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ScpDeptReputationProgram", "Department Relations")
		ui.set_autoupdate(FALSE)
		ui.open()

/obj/machinery/department_reputation_console/tgui_state(mob/user)
	return GLOB.physical_tgui_state

/obj/machinery/department_reputation_console/tgui_data(mob/user)
	var/list/data = list()
	data["departments"] = list()
	for(var/dept in SSdepartment_reputation.department_reputation)
		var/rep = SSdepartment_reputation.department_reputation[dept]
		data["departments"] += list(list(
			"name" = dept,
			"reputation" = rep,
			"label" = SSdepartment_reputation.get_reputation_label(rep),
		))
	var/list/log = SSdepartment_reputation.reputation_log
	data["recent_log"] = log.Copy(max(1, length(log) - 19), 0)
	return data

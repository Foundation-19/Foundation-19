// D-Class Escapists core for Foundation-19.
// Ported from daedalusdock code/modules/dclass, adapted:
//  - per-ckey player datums with economy/trust/strikes/progression
//  - single JSON persistence (data/dclass_players.json)
//  - work assignments + contraband + escape routes systems trimmed to F19 map
//  - factions with treasury + reputation

// ===== DEFINES =====

#define DCLASS_TRUST_HOSTILE 0
#define DCLASS_TRUST_SUSPICIOUS 1
#define DCLASS_TRUST_NEUTRAL 2
#define DCLASS_TRUST_COOPERATIVE 3
#define DCLASS_TRUST_TRUSTED 4

#define DCLASS_STATUS_GENERAL 0
#define DCLASS_STATUS_TEST_SUBJECT 1
#define DCLASS_STATUS_MEDICAL_SUBJECT 2
#define DCLASS_STATUS_CONTAINMENT_ASSIST 3

#define DCLASS_FACTION_NONE 0
#define DCLASS_FACTION_REBELS 1
#define DCLASS_FACTION_COLLABORATORS 2
#define DCLASS_FACTION_SURVIVORS 3

#define DCLASS_SAVE_FILE "data/dclass_players.json"
#define DCLASS_SAVE_INTERVAL 3 MINUTES

GLOBAL_LIST_INIT(dclass_faction_names, list("0" = "Unaffiliated", "1" = "Rebels", "2" = "Collaborators", "3" = "Survivors"))

// ===== SUBSYSTEM =====

SUBSYSTEM_DEF(dclass)
	name = "D-Class Management"
	wait = 200
	flags = SS_BACKGROUND
	var/datum/dclass_manager/manager

/datum/controller/subsystem/dclass/Initialize()
	manager = new
	log_game("D-Class Management Subsystem: Initialized")
	return ..()

/datum/controller/subsystem/dclass/fire()
	if(manager)
		manager.process_dclass()

/datum/controller/subsystem/dclass/Shutdown()
	manager?.save_all()
	return ..()

// ===== MANAGER =====

/datum/dclass_manager
	var/list/datum/dclass_player/dclass_players = list() // ckey -> player
	var/list/work_assignments = list()
	var/list/escape_routes = list()
	var/current_security_level = 1 // 1-4
	var/current_time_slot = "morning"
	var/last_routine_update = 0
	var/routine_update_interval = 5 MINUTES
	var/datum/dclass_economy_manager/economy_manager

/datum/dclass_manager/New()
	initialize_escape_routes()
	economy_manager = new

/datum/dclass_manager/proc/process_dclass()
	update_time_slot()
	if(world.time > last_routine_update + routine_update_interval)
		last_routine_update = world.time
	// per-player processing
	for(var/ckey in dclass_players)
		var/datum/dclass_player/player = dclass_players[ckey]
		if(player)
			player.process_player()

/datum/dclass_manager/proc/update_time_slot()
	var/hh = text2num(time2text(world.time, "hh"))
	switch(hh)
		if(6 to 11) current_time_slot = "morning"
		if(12 to 17) current_time_slot = "afternoon"
		if(18 to 23) current_time_slot = "evening"
		else current_time_slot = "night"

/datum/dclass_manager/proc/get_or_create_player(ckey, mob/M)
	if(!ckey)
		return null
	if(!dclass_players[ckey])
		dclass_players[ckey] = new /datum/dclass_player(ckey)
	var/datum/dclass_player/P = dclass_players[ckey]
	if(M && istype(M, /mob/living/carbon/human))
		P.mob = M
	return P

/datum/dclass_manager/proc/save_all()
	var/list/out = list()
	for(var/ckey in dclass_players)
		var/datum/dclass_player/P = dclass_players[ckey]
		out[ckey] = P.save_to()
	var/result = rustg_file_write(json_encode(out), DCLASS_SAVE_FILE)
	if(result != "ok" && result != "true")
		log_game("D-Class: save error [result]")

/datum/dclass_manager/proc/load_all()
	if(!fexists(DCLASS_SAVE_FILE))
		return
	var/json_data = file2text(DCLASS_SAVE_FILE)
	if(!rustg_json_is_valid(json_data))
		return
	var/list/data = json_decode(json_data)
	for(var/ckey in data || list())
		var/datum/dclass_player/P = new /datum/dclass_player(ckey)
		P.load_from(data[ckey])
		dclass_players[ckey] = P
	log_game("D-Class: loaded [dclass_players.len] player records")

// Escape routes: F19 map generic routes (expanded by map placement later).
/datum/dclass_manager/proc/initialize_escape_routes()
	escape_routes = list(
		list("id" = "tram_tunnel", "name" = "Tram Tunnel Breach", "difficulty" = 3, "needs" = list("cutters", "stealth")),
		list("id" = "vent_crawl", "name" = "Ventilation Network", "difficulty" = 2, "needs" = list("crowbar", "small")),
		list("id" = "garbage_run", "name" = "Garbage Disposal Hitch", "difficulty" = 1, "needs" = list("timing")),
		list("id" = "gate_a_rush", "name" = "Gate A Blind Rush", "difficulty" = 4, "needs" = list("weapon", "armor", "numbers")),
	)

// Work assignments pool (generic site tasks).
/datum/dclass_manager/proc/get_work_assignments()
	if(!length(work_assignments))
		work_assignments = list(
			list("id" = "laundry", "name" = "Laundry Duty", "reward" = 15, "risk" = 0, "time" = 2 MINUTES),
			list("id" = "kitchen", "name" = "Kitchen Duty", "reward" = 20, "risk" = 1, "time" = 3 MINUTES),
			list("id" = "janitorial", "name" = "Janitorial Round", "reward" = 15, "risk" = 0, "time" = 2 MINUTES),
			list("id" = "testing_assist", "name" = "Testing Volunteer", "reward" = 45, "risk" = 3, "time" = 6 MINUTES),
			list("id" = "cargo_sort", "name" = "Cargo Sorting", "reward" = 25, "risk" = 1, "time" = 3 MINUTES),
			list("id" = "maint_scrape", "name" = "Maintenance Scrap Run", "reward" = 30, "risk" = 2, "time" = 4 MINUTES),
		)
	return work_assignments

// ===== PLAYER DATUM =====

/datum/dclass_player
	var/ckey
	var/dclass_number
	var/mob/living/carbon/human/mob

	// Progression
	var/level = 1
	var/experience = 0
	var/reputation = 0
	var/trust_level = DCLASS_TRUST_NEUTRAL
	var/trust_points = 50
	var/status = DCLASS_STATUS_GENERAL

	// Economy
	var/credits = 100
	var/credits_lifetime = 0

	// Sentence & Behavior
	var/strikes = 0
	var/warnings = 0
	var/good_behavior_points = 0

	// Testing
	var/tests_completed = 0
	var/tests_successful = 0

	// Escape
	var/escape_attempts = 0
	var/successful_escapes = 0

	// Informant
	var/informant = FALSE
	var/informant_reports = 0

	// Contraband & crafting
	var/list/contraband = list()
	var/list/known_routes = list()

	// Faction
	var/faction = DCLASS_FACTION_NONE

	// Current activity
	var/current_work_assignment = null
	var/current_work_progress = 0
	var/suspicion_level = 0

	// Persistence
	var/last_save_time = 0

/datum/dclass_player/New(player_ckey)
	ckey = player_ckey
	generate_dclass_number()

/datum/dclass_player/proc/generate_dclass_number()
	dclass_number = "D-[rand(1000, 9999)]"

/datum/dclass_player/proc/process_player()
	// Trust drifts toward neutral over time.
	if(trust_points < 50)
		trust_points = min(50, trust_points + 1)
	else if(trust_points > 50)
		trust_points = max(50, trust_points - 1)
	update_trust_level()

	// Work assignment progress.
	if(current_work_assignment)
		process_work()

/datum/dclass_player/proc/update_trust_level()
	switch(trust_points)
		if(0 to 19) trust_level = DCLASS_TRUST_HOSTILE
		if(20 to 39) trust_level = DCLASS_TRUST_SUSPICIOUS
		if(40 to 59) trust_level = DCLASS_TRUST_NEUTRAL
		if(60 to 79) trust_level = DCLASS_TRUST_COOPERATIVE
		else trust_level = DCLASS_TRUST_TRUSTED

/datum/dclass_player/proc/start_work(assignment_id)
	var/assignments = SSdclass.manager.get_work_assignments()
	for(var/list/A in assignments)
		if(A["id"] == assignment_id)
			current_work_assignment = A["id"]
			current_work_progress = 0
			return TRUE
	return FALSE

/datum/dclass_player/proc/process_work()
	var/assignments = SSdclass.manager.get_work_assignments()
	for(var/list/A in assignments)
		if(A["id"] == current_work_assignment)
			current_work_progress += 10 SECONDS
			if(current_work_progress >= A["time"])
				finish_work(A)
			break

/datum/dclass_player/proc/finish_work(list/A)
	earn_credits(A["reward"])
	experience += 10
	if(experience >= level * 100)
		experience -= level * 100
		level++
		to_chat(mob, SPAN_NOTICE("<b>Level up!</b> You are now level [level]."))
	current_work_assignment = null
	current_work_progress = 0
	if(mob)
		to_chat(mob, SPAN_NOTICE("Work complete: [A["name"]]. Paid [A["reward"]] credits."))

/datum/dclass_player/proc/earn_credits(amount)
	credits += amount
	credits_lifetime += amount

/datum/dclass_player/proc/spend_credits(amount)
	if(credits < amount)
		return FALSE
	credits -= amount
	return TRUE

/datum/dclass_player/proc/add_strike(reason)
	strikes++
	trust_points = max(0, trust_points - 15)
	suspicion_level = min(100, suspicion_level + 20)
	if(mob)
		to_chat(mob, SPAN_DANGER("Strike [strikes]: [reason]"))
	if(strikes >= 3 && mob)
		to_chat(mob, SPAN_USERDANGER("Three strikes. Termination review has been flagged."))

/datum/dclass_player/proc/record_escape_attempt(success)
	escape_attempts++
	if(success)
		successful_escapes++
		reputation += 25
		earn_credits(200)
	// In F19 terms: escaping = leaving D-class zones; the round system decides
	// what "escaped" means. Announce it.
	if(success)
		priority_announcement.Announce("Class-D personnel [dclass_number] has breached the site perimeter. All units respond.", "Security Alert")

/datum/dclass_player/proc/get_data()
	return list(
		"dclass_number" = dclass_number,
		"level" = level,
		"experience" = experience,
		"xp_next" = level * 100,
		"credits" = credits,
		"trust_points" = trust_points,
		"trust_level" = trust_level,
		"strikes" = strikes,
		"tests_completed" = tests_completed,
		"escape_attempts" = escape_attempts,
		"successful_escapes" = successful_escapes,
		"faction" = faction,
		"reputation" = reputation,
	)

/datum/dclass_player/proc/save_to()
	return list(
		"dclass_number" = dclass_number,
		"level" = level,
		"experience" = experience,
		"reputation" = reputation,
		"trust_points" = trust_points,
		"status" = status,
		"credits" = credits,
		"credits_lifetime" = credits_lifetime,
		"strikes" = strikes,
		"tests_completed" = tests_completed,
		"tests_successful" = tests_successful,
		"escape_attempts" = escape_attempts,
		"successful_escapes" = successful_escapes,
		"informant" = informant,
		"informant_reports" = informant_reports,
		"faction" = faction,
		"known_routes" = known_routes,
		"contraband" = contraband,
	)

/datum/dclass_player/proc/load_from(list/raw)
	dclass_number = raw["dclass_number"] || dclass_number
	level = raw["level"] || 1
	experience = raw["experience"] || 0
	reputation = raw["reputation"] || 0
	trust_points = raw["trust_points"] || 50
	status = raw["status"] || DCLASS_STATUS_GENERAL
	credits = raw["credits"] || 100
	credits_lifetime = raw["credits_lifetime"] || 0
	strikes = raw["strikes"] || 0
	tests_completed = raw["tests_completed"] || 0
	tests_successful = raw["tests_successful"] || 0
	escape_attempts = raw["escape_attempts"] || 0
	successful_escapes = raw["successful_escapes"] || 0
	informant = raw["informant"] || FALSE
	informant_reports = raw["informant_reports"] || 0
	faction = raw["faction"] || DCLASS_FACTION_NONE
	if(istype(raw["known_routes"], /list))
		known_routes = raw["known_routes"]
	if(istype(raw["contraband"], /list))
		contraband = raw["contraband"]
	update_trust_level()

// Job integration: called when a D-class job spawns.
/proc/dclass_register_spawn(mob/living/carbon/human/H)
	if(!istype(H) || !H.ckey || !SSdclass?.manager)
		return
	var/datum/job/job = SSjobs.get_by_title(H.job)
	if(!job || job.class != CLASS_D)
		return
	SSdclass.manager.get_or_create_player(H.ckey, H)
	H?.verbs |= /mob/living/carbon/human/proc/dclass_panel

// ===== PLAYER PANEL (verb + tgui) =====

/mob/living/carbon/human/proc/dclass_panel()
	set name = "D-Class Panel"
	set category = "IC"
	set desc = "View your D-Class status, work assignments and records."

	var/datum/dclass_player/P = SSdclass?.manager?.dclass_players[ckey]
	if(!P)
		to_chat(src, SPAN_WARNING("You are not registered as Class-D personnel."))
		return
	P.tgui_interact(src)

/datum/dclass_player/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "DclassPanel", "D-Class Personal Terminal")
		ui.open()

/datum/dclass_player/tgui_data(mob/user)
	var/list/data = get_data()
	var/list/assignments = SSdclass.manager.get_work_assignments()
	var/list/work_options = list()
	for(var/list/A in assignments)
		work_options += list(A)
	data["work_options"] = work_options
	data["current_work"] = current_work_assignment
	data["time_slot"] = SSdclass.manager.current_time_slot
	data["security_level"] = SSdclass.manager.current_security_level
	data["routes"] = SSdclass.manager.escape_routes
	data["known_routes"] = known_routes
	return data

/datum/dclass_player/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	switch(action)
		if("start_work")
			return start_work(params["start_work"])
		if("abandon_work")
			current_work_assignment = null
			current_work_progress = 0
			trust_points = max(0, trust_points - 5)
			return TRUE
		if("join_faction")
			var/f = text2num(params["join_faction"])
			if(f && f != DCLASS_FACTION_NONE)
				faction = f
				reputation += 10
				if(mob)
					to_chat(mob, SPAN_NOTICE("You have joined the [GLOB.dclass_faction_names[f]]."))
			return TRUE
		if("leave_faction")
			faction = DCLASS_FACTION_NONE
			return TRUE
	return FALSE

// ===== FACTION + ECONOMY MANAGER (light) =====

/datum/dclass_economy_manager
	var/list/faction_treasuries = list("1" = 500, "2" = 500, "3" = 500)

/datum/dclass_economy_manager/proc/deposit(faction, amount)
	var/key = "[faction]"
	if(!faction_treasuries[key])
		return
	faction_treasuries[key] += amount

/datum/dclass_economy_manager/proc/withdraw(faction, amount)
	var/key = "[faction]"
	if(!faction_treasuries[key] || faction_treasuries[key] < amount)
		return FALSE
	faction_treasuries[key] -= amount
	return TRUE

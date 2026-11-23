// SCP cross-round persistence for Foundation-19.
// Ported from daedalusdock's scp_persistence.dm, adapted:
//  - keyed by our /datum/scp designation ("035", "082", ...)
//  - no TG skill persistence (F19 has no /datum/skills)
//  - no /mob/living/scp base class; works off atom.SCP like the rest of F19
// Data file: data/scp_persistence.json via rustg_file_write / file2text.

SUBSYSTEM_DEF(scp_persistence)
	name = "SCP Persistence"
	wait = 300
	flags = SS_BACKGROUND
	var/datum/scp_persistence_manager/manager
	var/list/cached_scp_atoms = list()
	var/cache_dirty = TRUE

/datum/controller/subsystem/scp_persistence/Initialize()
	manager = new
	log_game("SCP Persistence Subsystem: Initialized")
	return ..()

/datum/controller/subsystem/scp_persistence/fire()
	if(!manager)
		return
	if(cache_dirty)
		rebuild_scp_cache()
	manager.process_round(cached_scp_atoms)

/datum/controller/subsystem/scp_persistence/proc/rebuild_scp_cache()
	cached_scp_atoms = list()
	for(var/atom/A in GLOB.SCP_list)
		if(A.SCP && A.SCP.designation)
			cached_scp_atoms[A.SCP.designation] = A
	cache_dirty = FALSE

/datum/controller/subsystem/scp_persistence/proc/mark_cache_dirty()
	cache_dirty = TRUE

// ---------------------------------------------------------------------------

/datum/scp_persistence_manager
	var/list/datum/scp_instance/scp_instances = list()
	var/global_containment_stability = 100
	var/active_breaches = 0
	var/last_auto_save = 0

	// Round management
	var/list/enabled_scps = list()
	var/list/disabled_scps = list()
	var/global_scp_management_mode = "standard" // standard, lockdown, research, emergency
	var/management_override = FALSE

/datum/scp_persistence_manager/proc/process_round(list/cached_atoms)
	update_scp_instances(cached_atoms)
	calculate_global_metrics()
	if(world.time - last_auto_save >= 6000)
		save_scp_data()
		last_auto_save = world.time

/datum/scp_persistence_manager/proc/update_scp_instances(list/cached_atoms)
	for(var/desg in cached_atoms)
		var/atom/A = cached_atoms[desg]
		var/datum/scp_instance/instance = scp_instances[desg]
		if(!instance)
			instance = new /datum/scp_instance(desg, A)
			scp_instances[desg] = instance
		else
			instance.update_status(A)

// ---------------------------------------------------------------------------

/datum/scp_instance
	var/scp_id
	var/containment_status = "contained"   // contained | breached | terminated | unknown
	var/containment_health = 100
	var/current_state = "normal"
	var/list/breach_history = list()        // list of list(time, zone, recontained)
	var/list/interaction_history = list()   // list of list(time, actor, summary)
	var/list/containment_protocols = list() // freeform notes/tiers unlocked
	var/last_breach = 0
	var/containment_class = "safe"
	var/containment_effectiveness = 1.0
	var/research_value = 100
	var/threat_level = 1
	var/times_breached_total = 0            // cross-round counter
	var/total_recontained = 0

/datum/scp_instance/New(id, atom/O)
	scp_id = id
	if(O)
		update_status(O)

/datum/scp_instance/proc/update_status(atom/O)
	if(!O)
		return
	if(istype(O, /mob/living))
		var/mob/living/L = O
		if(L.SCP)
			containment_class = L.SCP.classification
		containment_health = round((L.health / L.maxHealth) * 100)
		if(L.stat == DEAD)
			containment_status = "terminated"
			current_state = "dead"
			return
	var/area/A = get_area(O)
	var/in_containment = FALSE
	if(A)
		// reuse F19 zone sub-area matching when a zone exists
		var/datum/containment_zone/CZ = A.get_containment_zone()
		if(CZ && CZ.linked_scp && CZ.linked_scp.parent == O)
			in_containment = TRUE
		else
			var/area_name = lowertext(A.name)
			if(findtext(area_name, "contain") || findtext(area_name, "scp") || findtext(area_name, "chamber"))
				in_containment = TRUE
	if(in_containment)
		if(containment_status == "breached")
			total_recontained++
		containment_status = "contained"
		current_state = "normal"
	else
		if(containment_status != "breached")
			containment_status = "breached"
			times_breached_total++
			last_breach = world.time
			add_breach_record()
		current_state = "breached"

/datum/scp_instance/proc/add_breach_record(zone = "unknown")
	breach_history += list(list(
		"time" = world.time,
		"zone" = zone,
		"recontained" = FALSE
	))
	if(breach_history.len > 50)
		breach_history.Cut(1, 2)

/datum/scp_instance/proc/add_interaction_record(actor, summary)
	interaction_history += list(list(
		"time" = world.time,
		"actor" = actor,
		"summary" = summary
	))
	if(interaction_history.len > 100)
		interaction_history.Cut(1, 2)

/datum/scp_instance/proc/mark_recontained()
	if(containment_status == "breached")
		for(var/i = breach_history.len; i >= 1; i--)
			if(!breach_history[i]["recontained"])
				breach_history[i]["recontained"] = TRUE
				break
		containment_status = "contained"
		current_state = "normal"

/datum/scp_instance/proc/serialize()
	return list(
		"scp_id" = scp_id,
		"containment_status" = containment_status,
		"containment_health" = containment_health,
		"containment_class" = containment_class,
		"times_breached_total" = times_breached_total,
		"total_recontained" = total_recontained,
		"last_breach" = last_breach,
		"breach_history" = breach_history,
		"interaction_history" = interaction_history,
		"containment_protocols" = containment_protocols
	)

/datum/scp_instance/proc/deserialize(list/data)
	containment_status = data["containment_status"] || "contained"
	containment_health = data["containment_health"] || 100
	containment_class = data["containment_class"] || "safe"
	times_breached_total = data["times_breached_total"] || 0
	total_recontained = data["total_recontained"] || 0
	last_breach = data["last_breach"] || 0
	if(istype(data["breach_history"], /list))
		breach_history = data["breach_history"]
	if(istype(data["interaction_history"], /list))
		interaction_history = data["interaction_history"]
	if(istype(data["containment_protocols"], /list))
		containment_protocols = data["containment_protocols"]

// ---------------------------------------------------------------------------

/datum/scp_persistence_manager/proc/calculate_global_metrics()
	active_breaches = 0
	var/stability = 100
	for(var/desg in scp_instances)
		var/datum/scp_instance/instance = scp_instances[desg]
		if(instance.containment_status == "breached")
			active_breaches++
			stability -= 10
		else if(instance.containment_status == "terminated")
			stability -= 5
	global_containment_stability = clamp(stability, 0, 100)

/datum/scp_persistence_manager/proc/save_scp_data()
	var/list/data = list()
	var/list/serializable = list()
	for(var/desg in scp_instances)
		var/datum/scp_instance/instance = scp_instances[desg]
		serializable[desg] = instance.serialize()
	data["scp_instances"] = serializable
	data["global_containment_stability"] = global_containment_stability
	data["active_breaches"] = active_breaches
	data["enabled_scps"] = enabled_scps
	data["disabled_scps"] = disabled_scps
	data["global_scp_management_mode"] = global_scp_management_mode
	var/filename = "data/scp_persistence.json"
	var/result = rustg_file_write(json_encode(data), filename)
	if(result != "ok" && result != "true")
		log_game("SCP Persistence: save error [result]")

/datum/scp_persistence_manager/proc/load_scp_data()
	var/filename = "data/scp_persistence.json"
	if(!fexists(filename))
		return FALSE
	var/json_data = file2text(filename)
	if(!rustg_json_is_valid(json_data))
		log_game("SCP Persistence: invalid JSON in save file, skipping load")
		return FALSE
	var/list/data = json_decode(json_data)
	if(!data)
		return FALSE
	var/list/raw_instances = data["scp_instances"] || list()
	for(var/desg in raw_instances)
		if(!scp_instances[desg])
			scp_instances[desg] = new /datum/scp_instance(desg)
		scp_instances[desg].deserialize(raw_instances[desg])
	global_containment_stability = data["global_containment_stability"] || 100
	enabled_scps = data["enabled_scps"] || list()
	disabled_scps = data["disabled_scps"] || list()
	global_scp_management_mode = data["global_scp_management_mode"] || "standard"
	log_game("SCP Persistence: loaded [raw_instances.len] SCP records")
	return TRUE

/datum/scp_persistence_manager/proc/get_instance(designation)
	return scp_instances[designation]

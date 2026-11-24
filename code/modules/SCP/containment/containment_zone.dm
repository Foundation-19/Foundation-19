GLOBAL_LIST_EMPTY(containment_zones)

/datum/containment_zone
	var/area/zone_area
	var/scp_designation
	var/datum/scp/linked_scp
	var/containment_status = SCP_UNKNOWN
	var/integrity = 100
	var/alert_threshold = 50
	var/has_power = TRUE
	var/last_check_time = 0
	var/check_interval = 5 SECONDS
	var/obj/machinery/scp_containment_monitor/monitor
	var/last_verify_time = 0

/datum/containment_zone/New(area/A, scp_desg)
	zone_area = A
	scp_designation = scp_desg
	GLOB.containment_zones += src

/datum/containment_zone/Destroy()
	GLOB.containment_zones -= src
	if(linked_scp)
		linked_scp.containment_zone = null
	zone_area = null
	linked_scp = null
	monitor = null
	return ..()

/datum/containment_zone/proc/link_scp(datum/scp/scp_datum)
	if(!scp_datum)
		return
	linked_scp = scp_datum
	scp_datum.containment_zone = src
	if(scp_datum.research)
		scp_datum.research.set_containment_status(SCP_CONTAINED)

/datum/containment_zone/proc/process()
	if(world.time < last_check_time + check_interval)
		return
	last_check_time = world.time
	if(!linked_scp || !linked_scp.parent)
		return
	check_power()
	check_integrity()
	check_scp_presence()

/datum/containment_zone/proc/check_power()
	if(!zone_area)
		has_power = FALSE
		return
	var/obj/machinery/power/apc/apc = zone_area.get_apc()
	has_power = apc && apc.operating

/datum/containment_zone/proc/check_integrity()
	var/new_integrity = 100
	// Containment tech branch: reinforced zones never fall below the floor.
	var/floor = GLOB.scp_research_director ? GLOB.scp_research_director.tech_tree.get_containment_floor() : 0
	if(!has_power)
		new_integrity -= 30
	if(zone_area)
		for(var/obj/machinery/door/airlock/A in zone_area)
			if(A.welded || A.locked || !A.density)
				continue
			if(A.health < A.maxhealth * 0.5)
				new_integrity -= 5
		for(var/obj/machinery/light/L in zone_area)
			if(L.on)
				new_integrity += 1
	integrity = clamp(new_integrity, max(floor, 0), 100)
	if(integrity < alert_threshold && linked_scp && linked_scp.research)
		SEND_SIGNAL(linked_scp, COMSIG_CONTAINMENT_WARNING, src, integrity)

/datum/containment_zone/proc/check_scp_presence()
	if(!linked_scp || !linked_scp.parent)
		return
	var/atom/scp_atom = linked_scp.parent
	var/area/scp_area = get_area(scp_atom)
	var/is_in_zone = is_in_zone_area(scp_area)
	var/current_status = linked_scp.research ? linked_scp.research.containment_status : SCP_UNKNOWN
	if(is_in_zone && current_status == SCP_BREACHED)
		if(linked_scp.research)
			linked_scp.research.set_containment_status(SCP_CONTAINED)
		containment_status = SCP_CONTAINED
	else if(!is_in_zone && current_status == SCP_CONTAINED)
		if(linked_scp.research)
			linked_scp.research.set_containment_status(SCP_BREACHED)
		containment_status = SCP_BREACHED

/// A containment zone covers its base area AND any sub-areas derived from it
/// (e.g. /scp082 plus /scp082/bedroom, /scp082/throne ...). Without this,
/// SCPs whose chambers span suite sub-areas report phantom breaches.
/datum/containment_zone/proc/is_in_zone_area(area/A)
	if(!A || !zone_area)
		return FALSE
	if(A == zone_area)
		return TRUE
	// Walk the type hierarchy: sub-areas inherit their parent's path as a prefix.
	var/zone_path = "[zone_area.type]"
	var/check_path = "[A.type]"
	return copytext(check_path, 1, length(zone_path) + 1) == zone_path && \
		(length(check_path) > length(zone_path)) && \
		copytext(check_path, length(zone_path) + 1, length(zone_path) + 2) == "/"

/datum/containment_zone/proc/get_data()
	return list(
		"designation" = scp_designation,
		"area_name" = zone_area ? zone_area.name : "Unknown",
		"status" = containment_status,
		"integrity" = integrity,
		"has_power" = has_power,
		"alert_threshold" = alert_threshold
	)

/area/proc/get_containment_zone()
	for(var/datum/containment_zone/CZ in GLOB.containment_zones)
		if(CZ.zone_area == src)
			return CZ
	return null

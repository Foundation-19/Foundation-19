

#define CONTAINMENT_STATE_SECURE 0
#define CONTAINMENT_STATE_STABLE 1
#define CONTAINMENT_STATE_DEGRADING 2
#define CONTAINMENT_STATE_CRITICAL 3
#define CONTAINMENT_STATE_BREACHED 4

#define RESOURCE_TENSION "tension"
#define RESOURCE_CORROSION "corrosion"
#define RESOURCE_HACK_PROGRESS "hack_progress"
#define RESOURCE_ADAPTATION "adaptation"
#define RESOURCE_INFECTION "infection"
#define RESOURCE_FUEL "fuel"
#define RESOURCE_VOICE_DATA "voice_data"
#define RESOURCE_OFFSPRING "offspring"
#define RESOURCE_VISIBILITY "visibility"
#define RESOURCE_HUNGER "hunger"

/datum/scp_containment_system
	var/mob/living/owner
	var/containment_integrity = 100
	var/containment_state = CONTAINMENT_STATE_SECURE
	var/progression_rate = 0.1
	var/list/resources = list()
	var/list/interactions_log = list()
	var/last_interaction_time = 0
	var/observer_count = 0
	var/last_observer_check = 0
	var/containment_cell_type
	var/datum/containment_stress/stress

/datum/scp_containment_system/New(mob/living/new_owner)
	owner = new_owner
	setup_resources()
	setup_cell_type()
	stress = new /datum/containment_stress(owner)
	START_PROCESSING(SSprocessing, src)

/datum/scp_containment_system/Destroy()
	STOP_PROCESSING(SSprocessing, src)
	QDEL_NULL(stress)
	owner = null
	return ..()

/datum/scp_containment_system/Process()
	if(!owner || owner.stat == DEAD)
		return
	progress_containment()
	generate_resources()
	check_observers()
	stress?.process_stress()

/datum/scp_containment_system/proc/setup_resources()
	switch(get_scp_id())
		if("173")
			resources = list(RESOURCE_TENSION = 0)
			progression_rate = 0.15
		if("096")
			resources = list(RESOURCE_TENSION = 0)
			progression_rate = 0.05
		if("008")
			resources = list(RESOURCE_INFECTION = 0)
			progression_rate = 0.08
		if("035")
			resources = list(RESOURCE_CORROSION = 0)
			progression_rate = 0.2
		if("049")
			resources = list(RESOURCE_TENSION = 0)
			progression_rate = 0.05
		if("079")
			resources = list(RESOURCE_HACK_PROGRESS = 0)
			progression_rate = 0.12
		if("106")
			resources = list(RESOURCE_CORROSION = 0)
			progression_rate = 0.18
		if("457")
			resources = list(RESOURCE_FUEL = 30)
			progression_rate = 0.1
		if("939")
			resources = list(RESOURCE_VOICE_DATA = 0)
			progression_rate = 0.08
		if("682")
			resources = list(RESOURCE_ADAPTATION = 0, RESOURCE_TENSION = 0)
			progression_rate = 0.25
		if("347")
			resources = list(RESOURCE_VISIBILITY = 0, RESOURCE_TENSION = 0)
			progression_rate = 0.08
		if("966")
			resources = list(RESOURCE_VISIBILITY = 0, RESOURCE_TENSION = 0)
			progression_rate = 0.12
		if("082")
			resources = list(RESOURCE_HUNGER = 20, RESOURCE_TENSION = 0)
			progression_rate = 0.06
		if("3199")
			resources = list(RESOURCE_OFFSPRING = 0, RESOURCE_TENSION = 0)
			progression_rate = 0.2
		if("1048")
			resources = list(RESOURCE_OFFSPRING = 0, RESOURCE_TENSION = 0)
			progression_rate = 0.1
		if("1507")
			resources = list(RESOURCE_TENSION = 0, RESOURCE_OFFSPRING = 0)
			progression_rate = 0.12
		if("2427-3")
			resources = list(RESOURCE_HACK_PROGRESS = 0, RESOURCE_TENSION = 0)
			progression_rate = 0.15
		else
			resources = list(RESOURCE_TENSION = 0)
			progression_rate = 0.1

/datum/scp_containment_system/proc/setup_cell_type()
	switch(get_scp_id())
		if("173")
			containment_cell_type = "concrete"
		if("096")
			containment_cell_type = "padded"
		if("008")
			containment_cell_type = "cold_storage"
		if("035")
			containment_cell_type = "glass"
		if("079")
			containment_cell_type = "faraday"
		if("106")
			containment_cell_type = "corrosion_resistant"
		if("457")
			containment_cell_type = "fireproof"
		if("939")
			containment_cell_type = "soundproof"
		if("682")
			containment_cell_type = "reinforced"
		if("347")
			containment_cell_type = "observation"
		if("966")
			containment_cell_type = "infrared"
		if("1507")
			containment_cell_type = "open_air"
		if("2427-3")
			containment_cell_type = "faraday"
		else
			containment_cell_type = "standard"

// F19: designation straight off the SCP datum.
/datum/scp_containment_system/proc/get_scp_id()
	if(!owner?.SCP)
		return ""
	return "[owner.SCP.designation]"

// Inside own registered containment zone (or any zone when unregistered).
/datum/scp_containment_system/proc/in_containment()
	var/area/A = get_area(get_turf(owner))
	if(!A)
		return FALSE
	var/datum/containment_zone/CZ = A.get_containment_zone()
	if(!CZ)
		return FALSE
	// Generous: the SCP's zone, or any zone if ours isn't registered.
	if(!CZ.scp_designation || "[CZ.scp_designation]" == get_scp_id())
		return TRUE
	return FALSE

/datum/scp_containment_system/proc/progress_containment()
	if(containment_integrity <= 0)
		if(containment_state != CONTAINMENT_STATE_BREACHED)
			containment_state = CONTAINMENT_STATE_BREACHED
			on_breach()
		return

	if(in_containment())
		containment_integrity = min(100, containment_integrity + 0.02)
	else
		containment_integrity -= progression_rate

	if(observer_count > 0)
		containment_integrity -= observer_count * 0.05

	containment_integrity = clamp(containment_integrity, 0, 100)

	if(containment_integrity > 80)
		containment_state = CONTAINMENT_STATE_SECURE
	else if(containment_integrity > 50)
		containment_state = CONTAINMENT_STATE_STABLE
	else if(containment_integrity > 20)
		containment_state = CONTAINMENT_STATE_DEGRADING
	else
		containment_state = CONTAINMENT_STATE_CRITICAL

/datum/scp_containment_system/proc/generate_resources()
	switch(get_scp_id())
		if("173")
			if(observer_count == 0)
				resources[RESOURCE_TENSION] = min(100, resources[RESOURCE_TENSION] + 0.5)
			else
				resources[RESOURCE_TENSION] = max(0, resources[RESOURCE_TENSION] - 0.3)
		if("096")
			resources[RESOURCE_TENSION] = min(100, resources[RESOURCE_TENSION] + 0.1)
		if("008")
			resources[RESOURCE_INFECTION] = min(100, resources[RESOURCE_INFECTION] + 0.15)
		if("035")
			if(length(observers_in_range()) > 0)
				resources[RESOURCE_CORROSION] = min(100, resources[RESOURCE_CORROSION] + 0.3)
		if("049")
			var/nearby_humans = 0
			for(var/mob/living/carbon/human/H in range(7, owner))
				if(H.stat != DEAD)
					nearby_humans++
			if(nearby_humans > 0)
				resources[RESOURCE_TENSION] = min(100, resources[RESOURCE_TENSION] + nearby_humans * 0.1)
		if("079")
			resources[RESOURCE_HACK_PROGRESS] = min(100, resources[RESOURCE_HACK_PROGRESS] + 0.08)
		if("106")
			resources[RESOURCE_CORROSION] = min(100, resources[RESOURCE_CORROSION] + 0.2)
		if("457")
			var/obj/effect/scp457_fire/HS = locate() in range(3, owner)
			if(HS)
				resources[RESOURCE_FUEL] = min(100, resources[RESOURCE_FUEL] + 0.5)
			else
				resources[RESOURCE_FUEL] = max(0, resources[RESOURCE_FUEL] - 0.1)
		if("939")
			for(var/mob/living/carbon/human/H in range(7, owner))
				if(H.stat != DEAD && H.client)
					resources[RESOURCE_VOICE_DATA] = min(100, resources[RESOURCE_VOICE_DATA] + 0.05)
					break
		if("682")
			resources[RESOURCE_ADAPTATION] = min(100, resources[RESOURCE_ADAPTATION] + 0.05)
			resources[RESOURCE_TENSION] = min(100, resources[RESOURCE_TENSION] + 0.2)
		if("347")
			resources[RESOURCE_VISIBILITY] = max(0, resources[RESOURCE_VISIBILITY] - 0.3)
			if(observer_count > 0)
				resources[RESOURCE_TENSION] = min(100, resources[RESOURCE_TENSION] + 0.4)
		if("966")
			var/nearby_sleeping = 0
			for(var/mob/living/carbon/human/H in range(7, owner))
				if(H.stat == UNCONSCIOUS)
					nearby_sleeping++
			resources[RESOURCE_VISIBILITY] = min(100, resources[RESOURCE_VISIBILITY] + 0.15)
			if(nearby_sleeping > 0)
				resources[RESOURCE_TENSION] = min(100, resources[RESOURCE_TENSION] + nearby_sleeping * 0.2)
		if("082")
			resources[RESOURCE_HUNGER] = min(100, resources[RESOURCE_HUNGER] + 0.08)
			if(resources[RESOURCE_HUNGER] > 70)
				resources[RESOURCE_TENSION] = min(100, resources[RESOURCE_TENSION] + 0.15)
		if("3199")
			resources[RESOURCE_OFFSPRING] = min(100, resources[RESOURCE_OFFSPRING] + 0.1)
			resources[RESOURCE_TENSION] = min(100, resources[RESOURCE_TENSION] + 0.15)
		if("1048")
			var/nearby_corpses = 0
			for(var/mob/living/carbon/human/H in range(5, owner))
				if(H.stat == DEAD)
					nearby_corpses++
			if(nearby_corpses > 0)
				resources[RESOURCE_OFFSPRING] = min(100, resources[RESOURCE_OFFSPRING] + nearby_corpses * 0.2)
			resources[RESOURCE_TENSION] = min(100, resources[RESOURCE_TENSION] + 0.05)
		if("2427-3")
			resources[RESOURCE_HACK_PROGRESS] = min(100, resources[RESOURCE_HACK_PROGRESS] + 0.1)
			resources[RESOURCE_TENSION] = min(100, resources[RESOURCE_TENSION] + 0.12)

/datum/scp_containment_system/proc/check_observers()
	if(world.time < last_observer_check + 2 SECONDS)
		return
	last_observer_check = world.time
	observer_count = 0
	for(var/mob/living/carbon/human/H in viewers(9, owner))
		if(H.stat != DEAD && H.client && H.stat == CONSCIOUS && !H.has_status_effect(/datum/status_effect/grouped/blindness))
			observer_count++

/datum/scp_containment_system/proc/observers_in_range()
	. = list()
	for(var/mob/living/carbon/human/H in viewers(7, owner))
		if(H.stat != DEAD && H.client)
			. += H

/datum/scp_containment_system/proc/on_breach()
	if(!owner)
		return
	hook_scp_breach(get_scp_id(), owner)
	owner.visible_message(SPAN_DANGER("[owner] breaks free from containment!"), SPAN_USERDANGER("You have broken free!"))

/datum/scp_containment_system/proc/spend_resource(resource_type, amount)
	if(resources[resource_type] == null)
		return FALSE
	if(resources[resource_type] < amount)
		return FALSE
	resources[resource_type] -= amount
	return TRUE

/datum/scp_containment_system/proc/get_resource(resource_type)
	return resources[resource_type] || 0

/datum/scp_containment_system/proc/get_containment_state_name()
	switch(containment_state)
		if(CONTAINMENT_STATE_SECURE)
			return "Secure"
		if(CONTAINMENT_STATE_STABLE)
			return "Stable"
		if(CONTAINMENT_STATE_DEGRADING)
			return "Degrading"
		if(CONTAINMENT_STATE_CRITICAL)
			return "Critical"
		if(CONTAINMENT_STATE_BREACHED)
			return "Breached"

// F19 mob datum hook moved to scp_containment_mob.dm (parsed before
// scp.dm uses it).


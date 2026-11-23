GLOBAL_LIST_EMPTY(dclass_requests)

#define DCLASS_REQUEST_OPEN      1
#define DCLASS_REQUEST_ARRIVED   2
#define DCLASS_REQUEST_COMPLETED 3
#define DCLASS_REQUEST_CANCELLED 4
#define DCLASS_REQUEST_EXPIRED   5

#define DCLASS_REQUEST_DURATION  10 MINUTES
#define DCLASS_REQUEST_BONUS     15

var/next_dclass_request_id = 1

/datum/dclass_request
	var/id
	var/scp_designation
	var/test_type = "dclass"
	var/risk_level = "high"
	var/requested_by_name
	var/requested_by_key
	var/request_location
	var/area/zone_area
	var/status = DCLASS_REQUEST_OPEN
	var/time_requested
	var/time_expires
	var/datum/scp_research/linked_research
	var/mob/living/carbon/human/arrived_dclass

/datum/dclass_request/New(designation, datum/scp_research/research, mob/requester, new_test_type, new_risk)
	..()
	id = next_dclass_request_id++
	scp_designation = designation
	linked_research = research
	test_type = new_test_type
	risk_level = new_risk
	if(requester)
		requested_by_name = requester.name
		requested_by_key = requester.ckey
		request_location = get_area_name(get_turf(requester))
	time_requested = world.time
	time_expires = world.time + DCLASS_REQUEST_DURATION
	if(research && research.parent)
		var/atom/scp_atom = research.parent
		zone_area = get_area(scp_atom)
	GLOB.dclass_requests += src
	announce_request()
	begin_tracking()

/datum/dclass_request/Destroy()
	GLOB.dclass_requests -= src
	zone_area = null
	linked_research = null
	arrived_dclass = null
	return ..()

/datum/dclass_request/proc/announce_request()
	var/msg = "D-Class test request: SCP-[scp_designation] ([risk_level] risk). Escort a Class-D to [zone_area ? zone_area.name : "the containment chamber"]. Requested by [requested_by_name || "Research Staff"]."
	var/notified = 0
	for(var/mob/living/carbon/human/H in GLOB.human_mob_list)
		if(H.stat == DEAD || !H.client)
			continue
		var/datum/job/job = SSjobs.get_by_title(H.job)
		if(job && ((job.department_flag & SEC) || (job.department_flag & SCI)))
			to_chat(H, SPAN_CLASS("securityradio", "<b>D-Class Request:</b> [msg]"))
			notified++
	var/turf/alert_turf = linked_research && linked_research.parent ? get_turf(linked_research.parent) : null
	log_and_message_staff("D-Class request #[id] filed for SCP-[scp_designation] by [requested_by_key || "unknown"] ([notified] staff notified).", location = alert_turf)

/datum/dclass_request/proc/begin_tracking()
	spawn(0)
		while(status == DCLASS_REQUEST_OPEN || status == DCLASS_REQUEST_ARRIVED)
			if(world.time >= time_expires)
				expire()
				return
			if(status == DCLASS_REQUEST_OPEN)
				check_arrival()
			sleep(10 SECONDS)

/datum/dclass_request/proc/check_arrival()
	if(!zone_area)
		return
	for(var/mob/living/carbon/human/H in zone_area)
		if(H.stat == DEAD || !H.client)
			continue
		var/datum/job/job = SSjobs.get_by_title(H.job)
		if(job && job.class == CLASS_D)
			mark_arrived(H)
			return

/datum/dclass_request/proc/mark_arrived(mob/living/carbon/human/D)
	status = DCLASS_REQUEST_ARRIVED
	arrived_dclass = D
	var/msg = "Class-D subject has arrived at SCP-[scp_designation] containment chamber. Test may now be authorized."
	for(var/mob/living/carbon/human/H in GLOB.human_mob_list)
		if(H.stat == DEAD || !H.client)
			continue
		var/datum/job/job = SSjobs.get_by_title(H.job)
		if(job && ((job.department_flag & SEC) || (job.department_flag & SCI)))
			to_chat(H, SPAN_CLASS("securityradio", "<b>D-Class Request #[id]:</b> [msg]"))

/datum/dclass_request/proc/complete(mob/tester)
	if(status != DCLASS_REQUEST_OPEN && status != DCLASS_REQUEST_ARRIVED)
		return FALSE
	status = DCLASS_REQUEST_COMPLETED
	if(linked_research)
		linked_research.add_research_points(DCLASS_REQUEST_BONUS, "dclass_request")
		if(tester)
			to_chat(tester, SPAN_NOTICE("D-Class request #[id] fulfilled. +[DCLASS_REQUEST_BONUS] research points."))
	log_and_message_staff("D-Class request #[id] for SCP-[scp_designation] completed.")
	qdel(src)
	return TRUE

/datum/dclass_request/proc/cancel(mob/user)
	if(status != DCLASS_REQUEST_OPEN && status != DCLASS_REQUEST_ARRIVED)
		return FALSE
	status = DCLASS_REQUEST_CANCELLED
	log_and_message_staff("D-Class request #[id] for SCP-[scp_designation] cancelled by [user ? key_name(user) : "system"].")
	qdel(src)
	return TRUE

/datum/dclass_request/proc/expire()
	status = DCLASS_REQUEST_EXPIRED
	log_and_message_staff("D-Class request #[id] for SCP-[scp_designation] expired unfulfilled.")
	qdel(src)

/datum/dclass_request/proc/get_data()
	return list(
		"id" = id,
		"designation" = scp_designation,
		"test_type" = test_type,
		"risk" = risk_level,
		"requested_by" = requested_by_name || "Unknown",
		"location" = zone_area ? zone_area.name : "Unknown",
		"status" = get_status_text(),
		"minutes_left" = max(0, round((time_expires - world.time) / (1 MINUTES), 1))
	)

/datum/dclass_request/proc/get_status_text()
	switch(status)
		if(DCLASS_REQUEST_OPEN)
			return "Awaiting escort"
		if(DCLASS_REQUEST_ARRIVED)
			return "Subject ready"
		if(DCLASS_REQUEST_COMPLETED)
			return "Completed"
		if(DCLASS_REQUEST_CANCELLED)
			return "Cancelled"
		if(DCLASS_REQUEST_EXPIRED)
			return "Expired"
	return "Unknown"

/proc/get_open_dclass_request(designation)
	for(var/datum/dclass_request/R in GLOB.dclass_requests)
		if(R.scp_designation == designation && (R.status == DCLASS_REQUEST_OPEN || R.status == DCLASS_REQUEST_ARRIVED))
			return R
	return null

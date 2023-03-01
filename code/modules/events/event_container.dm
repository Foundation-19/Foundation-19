#define ASSIGNMENT_ANY "Any"
#define ASSIGNMENT_AIC "AIC"
#define ASSIGNMENT_CYBORG "Robot"
#define ASSIGNMENT_ENGINEER "Engineer"
#define ASSIGNMENT_JANITOR "Janitor"
#define ASSIGNMENT_MEDICAL "Medical"
#define ASSIGNMENT_SCIENTIST "Scientist"
#define ASSIGNMENT_SECURITY "Security"

var/global/list/severity_to_string = list(EVENT_LEVEL_MUNDANE = "Mundane", EVENT_LEVEL_MODERATE = "Moderate", EVENT_LEVEL_MAJOR = "Major")

/datum/event_container
	var/severity = -1
	var/delayed = 0
	var/delay_modifier = 1
	var/next_event_time = 0
	var/list/available_events
	var/list/last_event_time = list()
	var/datum/event_meta/next_event = null

	var/last_world_time = 0

/datum/event_container/proc/process()
	if(!next_event_time)
		set_event_delay()

	if(delayed || !config.allow_random_events)
		next_event_time += (world.time - last_world_time)
	else if(world.time > next_event_time)
		start_event()

	last_world_time = world.time

/datum/event_container/proc/start_event()
	if(!next_event)	// If non-one has explicitly set an event, randomly pick one
		next_event = acquire_event()

	// Has an event been acquired?
	if(next_event)
		// Set when the event of this type was last fired, and prepare the next event start
		last_event_time[next_event] = world.time
		set_event_delay()
		next_event.enabled = !next_event.one_shot	// This event will no longer be available in the random rotation if one shot

		new next_event.event_type(next_event)	// Events are added and removed from the processing queue in their New/kill procs

		log_debug("Starting event '[next_event.name]' of severity [severity_to_string[severity]].")
		next_event = null						// When set to null, a random event will be selected next time
	else
		// If not, wait for one minute, instead of one tick, before checking again.
		next_event_time += (60 * 10)


/datum/event_container/proc/acquire_event()
	if(available_events.len == 0)
		return
	var/active_with_role = number_active_with_role()

	var/list/possible_events = list()
	for(var/datum/event_meta/EM in available_events)
		var/event_weight = get_weight(EM, active_with_role)
		if(event_weight)
			possible_events[EM] = event_weight

	if(possible_events.len == 0)
		return null

	// Select an event and remove it from the pool of available events
	var/picked_event = pickweight(possible_events)
	available_events -= picked_event
	return picked_event

/datum/event_container/proc/get_weight(datum/event_meta/EM, list/active_with_role)
	if(!EM.enabled)
		return 0

	var/weight = EM.get_weight(active_with_role)
	var/last_time = last_event_time[EM]
	if(last_time)
		var/time_passed = world.time - last_time
		var/weight_modifier = max(0, round((config.expected_round_length - time_passed) / 300))
		weight = weight - weight_modifier

	return weight

/datum/event_container/proc/set_event_delay()
	// If the next event time has not yet been set and we have a custom first time start
	if(next_event_time == 0 && config.event_first_run[severity])
		var/lower = config.event_first_run[severity]["lower"]
		var/upper = config.event_first_run[severity]["upper"]
		var/event_delay = rand(lower, upper)
		next_event_time = world.time + event_delay
	// Otherwise, follow the standard setup process
	else
		var/playercount_modifier = max(2 - log((GLOB.player_list.len / 2) + 1), 0.7)

		playercount_modifier = playercount_modifier * delay_modifier

		var/event_delay = rand(config.event_delay_lower[severity], config.event_delay_upper[severity]) * playercount_modifier
		next_event_time = world.time + event_delay

	log_debug("Next event of severity [severity_to_string[severity]] in [(next_event_time - world.time)/600] minutes.")

/datum/event_container/proc/SelectEvent()
	var/datum/event_meta/EM = input("Select an event to queue up.", "Event Selection", null) as null|anything in available_events
	if(!EM)
		return
	if(next_event)
		available_events += next_event
	available_events -= EM
	next_event = EM
	return EM

/datum/event_container/mundane
	severity = EVENT_LEVEL_MUNDANE
	available_events = list(
		// Severity level, event name, event type, base weight, role weights, one shot, min weight, max weight. Last two only used if set and aren't nulls
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "APC Damage",							/datum/event/apc_damage,				20, 	list(ASSIGNMENT_ENGINEER = 10)),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Brand Intelligence",					/datum/event/brand_intelligence,		10, 	list(ASSIGNMENT_ENGINEER = 10, ASSIGNMENT_JANITOR = 10)),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Camera Damage",							/datum/event/camera_damage,				20, 	list(ASSIGNMENT_ENGINEER = 10)),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Economic News",							/datum/event/economic_event,			100),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "E-mail Spam",							/datum/event/email_spam,				100),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Money Hacker",							/datum/event/money_hacker, 				2, 		list(ASSIGNMENT_ANY = 4), 1, 10, 24),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Money Lotto",							/datum/event/money_lotto, 				0, 		list(ASSIGNMENT_ANY = 1), 1, 5, 15),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Mundane News", 							/datum/event/mundane_news, 				200),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Shipping Error",						/datum/event/shipping_error	, 			30, 	list(ASSIGNMENT_ANY = 2), 0),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Sensor Suit Jamming",					/datum/event/sensor_suit_jamming,		30,		list(ASSIGNMENT_MEDICAL = 20, ASSIGNMENT_AIC = 20), 1),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Trivial News",							/datum/event/trivial_news, 				200),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Vermin Infestation",					/datum/event/infestation, 				100,	list(ASSIGNMENT_JANITOR = 50)),
		new /datum/event_meta/no_overmap(EVENT_LEVEL_MUNDANE, "Electrical Storm",			/datum/event/electrical_storm, 			20,		list(ASSIGNMENT_ENGINEER = 20, ASSIGNMENT_JANITOR = 50)),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Drone Malfunction",						/datum/event/rogue_maint_drones,		10,		list(ASSIGNMENT_ENGINEER = 30, ASSIGNMENT_SECURITY = 50)),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Disposals Explosion",					/datum/event/disposals_explosion,		20,		list(ASSIGNMENT_ENGINEER = 40)),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Brain Expansion",						/datum/event/brain_expansion,			20,		list(ASSIGNMENT_SCIENTIST = 20)),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Mail Delivery",							/datum/event/mail,						0,		list(ASSIGNMENT_ANY = 5), 1),
	)

/datum/event_container/moderate
	severity = EVENT_LEVEL_MODERATE
	available_events = list(
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Nothing",								/datum/event/nothing,					100,	list(ASSIGNMENT_ANY = -5)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Appendicitis", 						/datum/event/spontaneous_appendicitis, 	0,		list(ASSIGNMENT_MEDICAL = 10), 1),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Communication Blackout",				/datum/event/communications_blackout,	50,		list(ASSIGNMENT_AIC = 100, ASSIGNMENT_ENGINEER = 20)),
		new /datum/event_meta/no_overmap(EVENT_LEVEL_MODERATE, "Electrical Storm",			/datum/event/electrical_storm, 			10,		list(ASSIGNMENT_ENGINEER = 15, ASSIGNMENT_JANITOR = 10)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Grid Check",							/datum/event/grid_check, 				40,		list(ASSIGNMENT_ENGINEER = 15, ASSIGNMENT_ANY = 5)),
		new /datum/event_meta/no_overmap(EVENT_LEVEL_MODERATE, "Ion Storm",					/datum/event/ionstorm, 					0,		list(ASSIGNMENT_AIC = 50, ASSIGNMENT_CYBORG = 50, ASSIGNMENT_ENGINEER = 15, ASSIGNMENT_SCIENTIST = 5)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Prison Break",							/datum/event/prison_break,				0,		list(ASSIGNMENT_SECURITY = 100)),
		new /datum/event_meta/extended_removed(EVENT_LEVEL_MODERATE, "Random Antagonist",	/datum/event/random_antag,				2,		list(ASSIGNMENT_SECURITY = 1), 1, 0, 5),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Sensor Suit Jamming",					/datum/event/sensor_suit_jamming,		10,		list(ASSIGNMENT_MEDICAL = 20, ASSIGNMENT_AIC = 20)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Spider Infestation",					/datum/event/spider_infestation, 		25,		list(ASSIGNMENT_SECURITY = 15), 1),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Wallrot",								/datum/event/wallrot, 					0,		list(ASSIGNMENT_ENGINEER = 40)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Drone Uprising",						/datum/event/rogue_maint_drones,		25,		list(ASSIGNMENT_ENGINEER = 30, ASSIGNMENT_SECURITY = 20)),
	)

/datum/event_container/major
	severity = EVENT_LEVEL_MAJOR
	available_events = list(
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Nothing",									/datum/event/nothing,					200,	list(ASSIGNMENT_ANY = -5)), // So higher pop will run events more often
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Blob",									/datum/event/blob, 						0,		list(ASSIGNMENT_ENGINEER = 20, ASSIGNMENT_MEDICAL = 10, ASSIGNMENT_SECURITY = 20), 1),
		new /datum/event_meta/no_overmap(EVENT_LEVEL_MAJOR, "Electrical Storm",				/datum/event/electrical_storm, 			0,		list(ASSIGNMENT_ENGINEER = 10, ASSIGNMENT_JANITOR = 5)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Drone Revolution",						/datum/event/rogue_maint_drones,		0,		list(ASSIGNMENT_ENGINEER = 10, ASSIGNMENT_MEDICAL = 10, ASSIGNMENT_SECURITY = 20)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Vines",									/datum/event/spacevine,					0,		list(ASSIGNMENT_ANY = 5, ASSIGNMENT_ENGINEER = 20, ASSIGNMENT_JANITOR = 10)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Wormholes",								/datum/event/wormholes,					10,		list(ASSIGNMENT_ENGINEER = 10, ASSIGNMENT_SECURITY = 25)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Memetic Spasm",							/datum/event/memetic_spasm,				10,		list(ASSIGNMENT_MEDICAL = 20, ASSIGNMENT_SECURITY = 20))
	)

// Returns how many characters are currently active(not logged out, not AFK for more than 10 minutes)
// with a specific role.
// Note that this isn't sorted by department, because e.g. having a roboticist shouldn't make meteors spawn.
/proc/number_active_with_role()
	var/list/active_with_role = list()
	active_with_role[ASSIGNMENT_ENGINEER] = 0
	active_with_role[ASSIGNMENT_MEDICAL] = 0
	active_with_role[ASSIGNMENT_SECURITY] = 0
	active_with_role[ASSIGNMENT_SCIENTIST] = 0
	active_with_role[ASSIGNMENT_AIC] = 0
	active_with_role[ASSIGNMENT_CYBORG] = 0
	active_with_role[ASSIGNMENT_JANITOR] = 0

	for(var/mob/M in GLOB.player_list)
		if(!M.mind || !M.client || M.client.is_afk(10 MINUTES)) // longer than 10 minutes AFK counts them as inactive
			continue

		active_with_role[ASSIGNMENT_ANY]++

		if(istype(M, /mob/living/silicon/robot))
			var/mob/living/silicon/robot/R = M
			if(R.module)
				if(istype(R.module, /obj/item/robot_module/engineering))
					active_with_role[ASSIGNMENT_ENGINEER]++
				else if(istype(R.module, /obj/item/robot_module/security))
					active_with_role[ASSIGNMENT_SECURITY]++
				else if(istype(R.module, /obj/item/robot_module/medical))
					active_with_role[ASSIGNMENT_MEDICAL]++
				else if(istype(R.module, /obj/item/robot_module/research))
					active_with_role[ASSIGNMENT_SCIENTIST]++

		if(M.mind.assigned_role in SSjobs.titles_by_department(ENG))
			active_with_role[ASSIGNMENT_ENGINEER]++

		if(M.mind.assigned_role in SSjobs.titles_by_department(MED))
			active_with_role[ASSIGNMENT_MEDICAL]++

		if(M.mind.assigned_role in SSjobs.titles_by_department(SEC))
			active_with_role[ASSIGNMENT_SECURITY]++

		if(M.mind.assigned_role in SSjobs.titles_by_department(SCI))
			active_with_role[ASSIGNMENT_SCIENTIST]++

		if(M.mind.assigned_role == ASSIGNMENT_AIC)
			active_with_role[ASSIGNMENT_AIC]++

		if(M.mind.assigned_role == ASSIGNMENT_CYBORG)
			active_with_role[ASSIGNMENT_CYBORG]++

		if(M.mind.assigned_role == ASSIGNMENT_JANITOR)
			active_with_role[ASSIGNMENT_JANITOR]++

	return active_with_role

#undef ASSIGNMENT_ANY
#undef ASSIGNMENT_AIC
#undef ASSIGNMENT_CYBORG
#undef ASSIGNMENT_ENGINEER
#undef ASSIGNMENT_JANITOR
#undef ASSIGNMENT_MEDICAL
#undef ASSIGNMENT_SCIENTIST
#undef ASSIGNMENT_SECURITY

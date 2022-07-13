/datum/station_trait/slow_shuttle
	name = "Slow Shuttle"
	trait_type = STATION_TRAIT_NEGATIVE
	weight = 2
	show_in_report = TRUE
	report_message = "Due to distance to our supply station, the supply drone will have a slower flight time to your cargo department."
	blacklist = list(/datum/station_trait/quick_shuttle)

/datum/station_trait/slow_shuttle/on_round_start()
	SSsupply.movetime = 1500

/datum/station_trait/disabled_lighting
	name = "Overloaded Lighting"
	trait_type = STATION_TRAIT_NEGATIVE
	weight = 3
	show_in_report = TRUE
	report_message = "The ship has been through a light electrical storm, and as such, some light bulbs might need replacement."

/datum/station_trait/disabled_lighting/on_round_start()
	for(var/obj/machinery/power/apc/C in SSmachines.machinery)
		if(!C.is_critical && (C.z in GLOB.using_map.station_levels))
			C.overload_lighting(25) // Every fourth light

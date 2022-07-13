/datum/station_trait/exploration_grant
	name = "Exploration Grant"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 3
	show_in_report = TRUE
	report_message = "Your ship has been selected for a special grant. Additional points will be sent to your supply office."

/datum/station_trait/exploration_grant/on_round_start()
	SSsupply.points *= 5 // Normally you have 50.

/datum/station_trait/quick_shuttle
	name = "Quick Shuttle"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 3
	show_in_report = TRUE
	report_message = "Due to proximity to our nearest supply outpost, your supply drone will have faster travel time."
	blacklist = list(/datum/station_trait/slow_shuttle)

/datum/station_trait/quick_shuttle/on_round_start()
	SSsupply.movetime = 900

/datum/station_trait/premium_crewbox
	name = "Premium Survival Boxes"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 3
	show_in_report = TRUE
	report_message = "Crew survival boxes are outfitted with additional equipment."

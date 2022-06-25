/datum/map_template/ruin/exoplanet/abandoned_church
	name = "abandoned church"
	id = "abandoned_church"
	description = "An abandoned church of ancient cult."
	suffixes = list("abandoned_church/abandoned_church.dmm")
	spawn_cost = 1
	template_flags = TEMPLATE_FLAG_CLEAR_CONTENTS|TEMPLATE_FLAG_NO_RUINS
	ruin_tags = RUIN_HUMAN
	apc_test_exempt_areas = list(
		/area/map_template/abandoned_church = NO_SCRUBBER|NO_VENT
	)

// Area //
/area/map_template/abandoned_church
	name = "\improper Abandoned Church"

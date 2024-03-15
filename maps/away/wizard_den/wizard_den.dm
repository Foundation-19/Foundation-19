#include "wizard_den_areas.dm"

/obj/effect/overmap/visitable/sector/shrouded_moon
	name = "shrouded moon"
	desc = "A shrouded tiny moon with an artificial structure taking most of its surface.<br><br>There are unknown power readings coming from the sensor."
	in_space = FALSE
	known = TRUE
	icon_state = "globe"
	color = "#783ca4"
	initial_generic_waypoints = list(
		"nav_wiz_den_1",
		"nav_wiz_den_2",
		"nav_wiz_den_3",
		"nav_wiz_den_antag"
	)

/obj/effect/overmap/visitable/sector/shrouded_moon/Initialize()
	. = ..()
	GLOB.number_of_planetoids++
	name = "[generate_planet_name()], \a [name]"
	var/matrix/M = new
	M.Turn(90)
	transform = M

/datum/map_template/ruin/away_site/wizard_den
	name = "Wizard Den"
	description = "Three z-level map on a shrouded planet with big wizard den."
	id = "wizard_den"
	spawn_cost = 4
	suffixes = list("wizard_den/wizard_den-1.dmm")
	generate_mining_by_z = 1
	area_usage_test_exempted_root_areas = list(/area/wizard_den_away)
	apc_test_exempt_areas = list(
		/area/wizard_den_away = NO_SCRUBBER|NO_VENT|NO_APC
	)

/obj/effect/shuttle_landmark/nav_wizard_den/nav1
	name = "Shrouded Moon Landing Point #1"
	landmark_tag = "nav_wiz_den_1"
	base_area = /area/wizard_den_away/outdoors

/obj/effect/shuttle_landmark/nav_wizard_den/nav2
	name = "Shrouded Moon Landing Point #2"
	landmark_tag = "nav_wiz_den_2"
	base_area = /area/wizard_den_away/outdoors

/obj/effect/shuttle_landmark/nav_wizard_den/nav3
	name = "Shrouded Moon Landing Point #3"
	landmark_tag = "nav_wiz_den_3"
	base_area = /area/wizard_den_away/outdoors

/obj/effect/shuttle_landmark/nav_wizard_den/nav4
	name = "Shrouded Moon Navpoint #4"
	landmark_tag = "nav_wiz_den_antag"
	base_area = /area/wizard_den_away/outdoors

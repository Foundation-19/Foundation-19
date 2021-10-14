//Some helpers because so much copypasta for pods
/datum/shuttle/autodock/ferry/escape_pod/torchpod
	category = /datum/shuttle/autodock/ferry/escape_pod/torchpod
	sound_takeoff = 'sound/effects/rocket.ogg'
	sound_landing = 'sound/effects/rocket_backwards.ogg'
	var/number

/datum/shuttle/autodock/ferry/escape_pod/torchpod/New()
	name = "Escape Pod [number]"
	dock_target = "escape_pod_[number]"
	arming_controller = "escape_pod_[number]_berth"
	waypoint_station = "escape_pod_[number]_start"
	landmark_transition = "escape_pod_[number]_internim"
	waypoint_offsite = "escape_pod_[number]_out"
	..()

/obj/effect/shuttle_landmark/escape_pod/
	var/number

/obj/effect/shuttle_landmark/escape_pod/start
	name = "Docked"

/obj/effect/shuttle_landmark/escape_pod/start/New()
	landmark_tag = "escape_pod_[number]_start"
	docking_controller = "escape_pod_[number]_berth"
	..()

/obj/effect/shuttle_landmark/escape_pod/transit
	name = "In transit"

/obj/effect/shuttle_landmark/escape_pod/transit/New()
	landmark_tag = "escape_pod_[number]_internim"
	..()

/obj/effect/shuttle_landmark/escape_pod/out
	name = "Escaped"

/obj/effect/shuttle_landmark/escape_pod/out/New()
	landmark_tag = "escape_pod_[number]_out"
	..()

//Pods

/datum/shuttle/autodock/ferry/escape_pod/torchpod/escape_pod6
	warmup_time = 10
	shuttle_area = /area/shuttle/escape_pod6/station
	number = 6
/obj/effect/shuttle_landmark/escape_pod/start/pod6
	number = 6
/obj/effect/shuttle_landmark/escape_pod/out/pod6
	number = 6
/obj/effect/shuttle_landmark/escape_pod/transit/pod6
	number = 6

/datum/shuttle/autodock/ferry/escape_pod/torchpod/escape_pod7
	warmup_time = 10
	shuttle_area = /area/shuttle/escape_pod7/station
	number = 7
/obj/effect/shuttle_landmark/escape_pod/start/pod7
	number = 7
/obj/effect/shuttle_landmark/escape_pod/out/pod7
	number = 7
/obj/effect/shuttle_landmark/escape_pod/transit/pod7
	number = 7

/datum/shuttle/autodock/ferry/escape_pod/torchpod/escape_pod8
	warmup_time = 10
	shuttle_area = /area/shuttle/escape_pod8/station
	number = 8
/obj/effect/shuttle_landmark/escape_pod/start/pod8
	number = 8
/obj/effect/shuttle_landmark/escape_pod/out/pod8
	number = 8
/obj/effect/shuttle_landmark/escape_pod/transit/pod8
	number = 8

/datum/shuttle/autodock/ferry/escape_pod/torchpod/escape_pod9
	warmup_time = 10
	shuttle_area = /area/shuttle/escape_pod9/station
	number = 9
/obj/effect/shuttle_landmark/escape_pod/start/pod9
	number = 9
/obj/effect/shuttle_landmark/escape_pod/out/pod9
	number = 9
/obj/effect/shuttle_landmark/escape_pod/transit/pod9
	number = 9

/datum/shuttle/autodock/ferry/escape_pod/torchpod/escape_pod10
	warmup_time = 10
	shuttle_area = /area/shuttle/escape_pod10/station
	number = 10
/obj/effect/shuttle_landmark/escape_pod/start/pod10
	base_turf = /turf/simulated/floor/reinforced
	number = 10
/obj/effect/shuttle_landmark/escape_pod/out/pod10
	number = 10
/obj/effect/shuttle_landmark/escape_pod/transit/pod10
	number = 10

/datum/shuttle/autodock/ferry/escape_pod/torchpod/escape_pod11
	warmup_time = 10
	shuttle_area = /area/shuttle/escape_pod11/station
	number = 11
/obj/effect/shuttle_landmark/escape_pod/start/pod11
	base_turf = /turf/simulated/floor/reinforced/airless
	number = 11
/obj/effect/shuttle_landmark/escape_pod/out/pod11
	number = 11
/obj/effect/shuttle_landmark/escape_pod/transit/pod11
	number = 11

//Smoll pods

/datum/shuttle/autodock/ferry/escape_pod/torchpod/escape_pod12
	shuttle_area = /area/shuttle/escape_pod12/station
	number = 12
/obj/effect/shuttle_landmark/escape_pod/start/pod12
	base_turf = /turf/simulated/floor/reinforced/airless
	number = 12
/obj/effect/shuttle_landmark/escape_pod/out/pod12
	number = 12
/obj/effect/shuttle_landmark/escape_pod/transit/pod12
	number = 12

/datum/shuttle/autodock/ferry/escape_pod/torchpod/escape_pod13
	shuttle_area = /area/shuttle/escape_pod13/station
	number = 13
/obj/effect/shuttle_landmark/escape_pod/start/pod13
	base_turf = /turf/simulated/floor/reinforced/airless
	number = 13
/obj/effect/shuttle_landmark/escape_pod/out/pod13
	number = 13
/obj/effect/shuttle_landmark/escape_pod/transit/pod13
	number = 13

/datum/shuttle/autodock/ferry/escape_pod/torchpod/escape_pod14
	shuttle_area = /area/shuttle/escape_pod14/station
	number = 14
/obj/effect/shuttle_landmark/escape_pod/start/pod14
	base_turf = /turf/simulated/floor/reinforced/airless
	number = 14
/obj/effect/shuttle_landmark/escape_pod/out/pod14
	number = 14
/obj/effect/shuttle_landmark/escape_pod/transit/pod14
	number = 14

/datum/shuttle/autodock/ferry/escape_pod/torchpod/escape_pod15
	shuttle_area = /area/shuttle/escape_pod15/station
	number = 15
/obj/effect/shuttle_landmark/escape_pod/start/pod15
	base_turf = /turf/simulated/floor/reinforced/airless
	number = 15
/obj/effect/shuttle_landmark/escape_pod/out/pod15
	number = 15
/obj/effect/shuttle_landmark/escape_pod/transit/pod15
	number = 15

/datum/shuttle/autodock/ferry/escape_pod/torchpod/escape_pod116
	shuttle_area = /area/shuttle/escape_pod16/station
	number = 16
/obj/effect/shuttle_landmark/escape_pod/start/pod16
	base_turf = /turf/simulated/floor/reinforced/airless
	number = 16
/obj/effect/shuttle_landmark/escape_pod/out/pod16
	number = 16
/obj/effect/shuttle_landmark/escape_pod/transit/pod16
	number = 16

/datum/shuttle/autodock/ferry/escape_pod/torchpod/escape_pod17
	shuttle_area = /area/shuttle/escape_pod17/station
	number = 17
/obj/effect/shuttle_landmark/escape_pod/start/pod17
	base_turf = /turf/simulated/floor/reinforced/airless
	number = 17
/obj/effect/shuttle_landmark/escape_pod/out/pod17
	number = 17
/obj/effect/shuttle_landmark/escape_pod/transit/pod17
	number = 17


/datum/shuttle/autodock/ferry/engineering
	name = "Engineering Tram"
	warmup_time = 10
	shuttle_area = list(/area/site53/tram/engineering)
	waypoint_station = "nav_engineering_start"
	waypoint_offsite = "nav_engineering_out"

/obj/effect/shuttle_landmark/engineering/start
	name = "Tram Hub"
	landmark_tag = "nav_engineering_start"
	base_turf = /turf/simulated/floor/reinforced

/obj/effect/shuttle_landmark/engineering/out
	name = "Engineering Department"
	landmark_tag = "nav_engineering_out"
	base_turf = /turf/simulated/floor/reinforced
	base_area = /area/site53/engineering/primaryhallway

/obj/effect/shuttle_landmark/engineering/internim
	name = "In transit"
	landmark_tag = "nav_engineering_transition"

/datum/shuttle/autodock/ferry/heli/mtf
	name = "MTF Helicopter"
	warmup_time = 40
	shuttle_area = list(/area/site53/tram/mtf)
	waypoint_station = "nav_mtf_start"
	waypoint_offsite = "nav_mtf_out"

/obj/effect/shuttle_landmark/heli/mtf/start
	name = "MTF Base"
	landmark_tag = "nav_mtf_start"
	base_turf = /turf/simulated/floor/tiled/dark

/obj/effect/shuttle_landmark/heli/mtf/out
	name = "Site 53"
	landmark_tag = "nav_mtf_out"
	base_turf = /turf/simulated/floor/reinforced

/obj/effect/shuttle_landmark/heli/mtf
	name = "In transit"
	landmark_tag = "nav_mtf_transition"

/datum/shuttle/autodock/ferry/hcz
	name = "Heavy Containment Tram"
	warmup_time = 10
	shuttle_area = list(/area/site53/tram/hcz)
	waypoint_station = "nav_hcz_start"
	waypoint_offsite = "nav_hcz_out"


/obj/effect/shuttle_landmark/hcz/start
	name = "Tram Hub"
	landmark_tag = "nav_hcz_start"
	base_turf = /turf/simulated/floor/reinforced

/obj/effect/shuttle_landmark/hcz/out
	name = "Heavy Containment Zone"
	landmark_tag = "nav_hcz_out"
	base_turf = /turf/simulated/floor/reinforced
	base_area = /area/site53/uhcz/tramstation

/datum/shuttle/autodock/ferry/lcz
	name = "Light Containment Tram"
	warmup_time = 10
	shuttle_area = list(/area/site53/tram/lcz)
	waypoint_station = "nav_lcz_start"
	waypoint_offsite = "nav_lcz_out"


/obj/effect/shuttle_landmark/lcz/start
	name = "Tram Hub"
	landmark_tag = "nav_lcz_start"
	base_turf = /turf/simulated/floor/reinforced

/obj/effect/shuttle_landmark/lcz/out
	name = "Light Containment Zone"
	landmark_tag = "nav_lcz_out"
	base_turf = /turf/simulated/floor/reinforced
	base_area = /area/site53/ulcz/tram

/datum/shuttle/autodock/multi/antag/rescue
	name = "Rescue"
	warmup_time = 0
	destination_tags = list(
		"nav_ert_deck1",
		"nav_ert_deck2",
		"nav_ert_deck3",
		"nav_ert_deck4",
		"nav_ert_deck5",
		"nav_away_4",
		"nav_derelict_4",
		"nav_cluster_4",
		"nav_ert_dock",
		"nav_ert_start",
		"nav_lost_supply_base_antag",
		"nav_marooned_antag",
		"nav_smugglers_antag",
		"nav_magshield_antag",
		"nav_casino_antag",
		"nav_yacht_antag",
		"nav_slavers_base_antag",
		)
	shuttle_area = /area/rescue_base/start
	dock_target = "rescue_shuttle"
	current_location = "nav_ert_start"
	landmark_transition = "nav_ert_transition"
	home_waypoint = "nav_ert_start"
	announcer = "SEV Torch Sensor Array"
	arrival_message = "Attention, vessel detected entering vessel proximity."
	departure_message = "Attention, vessel detected leaving vessel proximity."

/obj/effect/shuttle_landmark/ert/start
	name = "Response Team Base"
	landmark_tag = "nav_ert_start"
	docking_controller = "rescue_base"

/obj/effect/shuttle_landmark/ert/internim
	name = "In transit"
	landmark_tag = "nav_ert_transition"

/obj/effect/shuttle_landmark/ert/dock
	name = "Docking Port"
	landmark_tag = "nav_ert_dock"
	docking_controller = "rescue_shuttle_dock_airlock"

/obj/effect/shuttle_landmark/ert/deck1
	name =  "Southwest of Fourth deck"
	landmark_tag = "nav_ert_deck1"

//Merc

/datum/shuttle/autodock/multi/antag/mercenary
	name = "Mercenary"
	warmup_time = 0
	destination_tags = list(
		"nav_merc_deck1",
		"nav_merc_dock",
		"nav_merc_start",
		)
	shuttle_area = /area/syndicate_station/start
	dock_target = "merc_shuttle"
	current_location = "nav_merc_start"
	landmark_transition = "nav_merc_transition"
	announcer = "SEV Torch Sensor Array"
	home_waypoint = "nav_merc_start"
	arrival_message = "Attention, unknown vessel detected entering site proximity."
	departure_message = "Attention, unknown vessel detected leaving site proximity."

/obj/effect/shuttle_landmark/merc/start
	name = "Mercenary Base"
	landmark_tag = "nav_merc_start"
	docking_controller = "merc_base"

/obj/effect/shuttle_landmark/merc/internim
	name = "In transit"
	landmark_tag = "nav_merc_transition"

/obj/effect/shuttle_landmark/merc/dock
	name = "Docking Port"
	landmark_tag = "nav_merc_dock"
	docking_controller = "nuke_shuttle_dock_airlock"

/obj/effect/shuttle_landmark/merc/deck1
	name = "Site53"
	landmark_tag = "nav_merc_deck1"
	base_area = /area/site53/surface/surface

//

/datum/shuttle/autodock/ferry/supply/drone
	name = "Supply Drone"
	location = 1
	warmup_time = 10
	shuttle_area = /area/supply/dock
	waypoint_offsite = "nav_cargo_start"
	waypoint_station = "nav_cargo_station"

/obj/effect/shuttle_landmark/supply/centcom
	name = "Offsite"
	landmark_tag = "nav_cargo_start"

/obj/effect/shuttle_landmark/supply/station
	name = "Landing Pad"
	landmark_tag = "nav_cargo_station"
	base_area = /area/site53/logistics/logistics
	base_turf = /turf/simulated/floor/tiled/monotile
/datum/shuttle/autodock/ferry/heli
	name = "Mobile Task Force Helicopter"
	sound_takeoff = 'sounds/effects/helicopter.ogg'
	warmup_time = 14
	shuttle_area = list(/area/site53/tram/mtf)
	waypoint_station = "nav_mtf_start"
	landmark_transition = "nav_mtf_transition"
	waypoint_offsite = "nav_mtf_out"
	move_time = 15

/obj/effect/shuttle_landmark/heli/start
	name = "Mobile Task Force Base"
	landmark_tag = "nav_mtf_start"
	base_turf = /turf/simulated/floor/reinforced
	base_area = /area/site53/surface/surface/west // Where the helicopter goes, not where it starts - Terrytehtryhard

/obj/effect/shuttle_landmark/heli/out
	name = "Site 53"
	landmark_tag = "nav_mtf_out"
	base_turf = /turf/simulated/floor/reinforced
	base_area = /area/site53/surface/surface/west

/obj/effect/shuttle_landmark/transit/helitransit
	name = "In transit"
	landmark_tag = "nav_mtf_transition"
	base_turf = /turf/unsimulated/floor/plating
	base_area = /area/space

/datum/shuttle/autodock/ferry/ci_heli
	name = "Chaos Insurgency Helicopter"
	sound_takeoff = 'sounds/effects/helicopter.ogg'
	warmup_time = 14
	shuttle_area = list(/area/site53/tram/ci)
	waypoint_station = "nav_ci_start"
	landmark_transition = "nav_ci_transition"
	waypoint_offsite = "nav_ci_out"
	move_time = 15

/obj/effect/shuttle_landmark/ci_heli/start
	name = "Chaos Insurgency Base"
	landmark_tag = "nav_ci_start"
	base_turf = /turf/simulated/floor/reinforced
	base_area = /area/site53/surface/surface/east

/obj/effect/shuttle_landmark/ci_heli/out
	name = "Site 53"
	landmark_tag = "nav_ci_out"
	base_turf = /turf/simulated/floor/exoplanet/snow
	base_area = /area/site53/surface/surface/east

/obj/effect/shuttle_landmark/transit/ci_helitransit
	name = "In transit"
	landmark_tag = "nav_ci_transition"
	base_turf = /turf/unsimulated/floor/plating
	base_area = /area/space

/datum/shuttle/autodock/ferry/goc_heli
	name = "Global Occult Coalition Helicopter"
	sound_takeoff = 'sounds/effects/helicopter.ogg'
	warmup_time = 14
	shuttle_area = list(/area/site53/tram/goc2)
	waypoint_station = "nav_goc_start"
	landmark_transition = "nav_goc_transition"
	waypoint_offsite = "nav_goc_out"
	move_time = 15

/obj/effect/shuttle_landmark/goc_heli/start
	name = "Global Occult Coalition Headquarters"
	landmark_tag = "nav_goc_start"
	base_turf = /turf/simulated/floor/reinforced
	base_area = /area/site53/surface/surface/west

/obj/effect/shuttle_landmark/goc_heli/out
	name = "Site 53"
	landmark_tag = "nav_goc_out"
	base_turf = /turf/simulated/floor/exoplanet/snow
	base_area = /area/site53/surface/surface/west

/obj/effect/shuttle_landmark/transit/goc_helitransit
	name = "In transit"
	landmark_tag = "nav_goc_transition"
	base_turf = /turf/unsimulated/floor/plating
	base_area = /area/space

/datum/shuttle/autodock/ferry/emergency/train //The transfer/escape train
	name = "Foundation Main Train"
	sound_takeoff = 'sounds/effects/TrainLeavingSite.ogg'
	warmup_time = 10 //Low while I test it back and forth
	location = 1 //At area offsite
	shuttle_area = list(/area/site53/tram/maintrain)
	waypoint_station = "nav_train_onsite"
	landmark_transition = "nav_train_transition"
	waypoint_offsite = "nav_train_central"
	sound_landing = 'sounds/effects/TrainLeavingSite.ogg'
	landing_message = "A train whistle is heard in the distance. Clear the tunnel!"
	takeoff_message = "A train whistle is heard as the trains pistons kick into motion."


/obj/effect/shuttle_landmark/train/central
	name = "Central Command"
	landmark_tag = "nav_train_central"
	base_turf = /turf/simulated/floor
	base_area = /area/site53/lowertrams/escape

/obj/effect/shuttle_landmark/transit/trainsition
	name = "Train Tunnel"
	landmark_tag = "nav_train_transition"
	base_turf = /turf/unsimulated/floor/reinforced_animated
	base_area = /area/site53/tram/maintrain/Tunnel

/obj/effect/shuttle_landmark/train/onsite
	name = "Site-53"
	landmark_tag = "nav_train_onsite"
	base_turf = /turf/simulated/floor/reinforced
	base_area = /area/site53/lowertrams/escape

/obj/effect/shuttle_landmark/chaos1/start
	name = "Chaos Base"
	landmark_tag = "car1_start"
	base_turf = /turf/simulated/floor/exoplanet/snow
	base_area = /area/site53/surface/surface

/obj/effect/shuttle_landmark/chaos1/out
	name = "Site 53"
	landmark_tag = "car1_out"
	base_turf = /turf/simulated/floor/exoplanet/snow
	base_area = /area/site53/surface/surface

/datum/shuttle/autodock/ferry/goc1
	name = "Global Occult Coalition Truck"
	warmup_time = 20
	shuttle_area = list(/area/site53/tram/goc1)
	waypoint_station = "goc1_start"
	waypoint_offsite = "goc1_out"


/obj/effect/shuttle_landmark/goc1/start
	name = "GOC Base"
	landmark_tag = "goc1_start"
	base_turf = /turf/simulated/floor/exoplanet/snow
	base_area = /area/site53/surface/surface/east

/obj/effect/shuttle_landmark/goc1/out
	name = "Site 53"
	landmark_tag = "goc1_out"
	base_turf = /turf/simulated/floor/exoplanet/concrete/reinforced/road
	base_area = /area/site53/surface/surface/east
/*
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
*/
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
/* -- dont need this, but commenting out just incase it breaks shit
/datum/shuttle/autodock/multi/antag/mercenary
	name = "Mercenary"
	warmup_time = 0
	destination_tags = list(
		"nav_merc_deck1",
		"nav_merc_dock",
		"nav_merc_start",
		)
//	shuttle_area = /area/syndicate_station/start
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
*/
/obj/effect/shuttle_landmark/merc/internim
	name = "In transit"
	landmark_tag = "nav_merc_transition"
/*
/obj/effect/shuttle_landmark/merc/dock
	name = "Docking Port"
	landmark_tag = "nav_merc_dock"
	docking_controller = "nuke_shuttle_dock_airlock"

/obj/effect/shuttle_landmark/merc/deck1
	name = "Site53"
	landmark_tag = "nav_merc_deck1"
	base_area = /area/site53/surface/surface
*/
//

/datum/shuttle/autodock/ferry/supply/drone
	name = "Supply Truck"
	location = 1
	warmup_time = 10
	shuttle_area = /area/supply/dock
	waypoint_offsite = "nav_cargo_start"
	waypoint_station = "nav_cargo_station"

/obj/effect/shuttle_landmark/supply/centcom
	name = "Offsite"
	landmark_tag = "nav_cargo_start"
	base_turf = /turf/unsimulated/floor/reinforced

/obj/effect/shuttle_landmark/supply/station
	name = "Hangar"
	landmark_tag = "nav_cargo_station"
	base_area = /area/quartermaster/hangar
	base_turf = /turf/simulated/floor/plating

/datum/shuttle/autodock/ferry/exploring
	name = "Car 1"
	warmup_time = 20
	shuttle_area = list(/area/site53/tram/scpcar)
	waypoint_station = "scpcar1_start"
	waypoint_offsite = "scpcar1_out"


/obj/effect/shuttle_landmark/site/start
	name = "Site 53"
	landmark_tag = "scpcar1_start"
	base_turf = /turf/simulated/floor/reinforced

/obj/effect/shuttle_landmark/site/out
	name = "Village Checkpoint"
	landmark_tag = "scpcar1_out"
	base_turf = /turf/simulated/floor/exoplanet/concrete


//SCP-106 Access Lift

/datum/shuttle/autodock/ferry/lift106
	name = "SCP-106 Lift" //You put the name in the shuttle_tag on the shuttle control console.
	sound_takeoff = 'sounds/effects/lift_heavy_start.ogg'
	warmup_time = 5
	shuttle_area = list(/area/site404/shuttle/lift106)
	waypoint_station = "nav_lift106_start"
	waypoint_offsite = "nav_lift106_out"

/obj/effect/shuttle_landmark/lift106/start
	name = "SCP-106 Lower Access Lift"
	landmark_tag = "nav_lift106_start"
	base_turf = /turf/simulated/floor/plating
	base_area = /area/site404/containmentchambers/scp106/entrance

/obj/effect/shuttle_landmark/lift106/out
	name = "SCP-106 Upper Access Lift"
	landmark_tag = "nav_lift106_out"
	base_turf = /turf/simulated/open
	base_area = /area/site404/containmentchambers/scp106/entrance

//SCP-106 Containment Unit Shuttle

/datum/shuttle/autodock/ferry/containment106
	name = "SCP-106 Containment Chamber"
	sound_takeoff = 'sounds/effects/engine_startup.ogg'
	warmup_time = 10
	shuttle_area = list(/area/site404/shuttle/unit106)
	waypoint_station = "nav_containment106_start"
	waypoint_offsite = "nav_containment106_out"

/obj/effect/shuttle_landmark/containment106/start
	name = "SCP-106 Upper Containment Unit"
	landmark_tag = "nav_containment106_start"
	base_turf = /turf/simulated/floor/plating
	base_area = /area/site404/shuttle/unit106

/obj/effect/shuttle_landmark/containment106/out
	name = "SCP-106 Lower Containment Unit"
	landmark_tag = "nav_containment106_out"
	base_turf = /turf/simulated/open
	base_area = /area/site404/shuttle/unit106

// Supply Shuttle

/datum/shuttle/autodock/ferry/supply/shuttle //This shuttle datum is hardcoded into the supply program. You gotta use it.
	name = "Site 404 Logistics Transport Shuttle"  //The rest of the variables below can be changed freely though.
	sound_takeoff = 'sounds/effects/engine_startup.ogg'
	location = 6
	warmup_time = 10
	shuttle_area = list(/area/site404/shuttle/supply)
	waypoint_station = "nav_supply_station"
	waypoint_offsite = "nav_supply_offsite"

/obj/effect/shuttle_landmark/supply/shuttle/station
	name = "Supply Shuttle Start"
	landmark_tag = "nav_supply_station"
	base_turf = /turf/simulated/floor/plating
	base_area = /area/site404/entrancezone/dockingbay

/obj/effect/shuttle_landmark/supply/shuttle/offsite
	name = "Supply Shuttle Out"
	landmark_tag = "nav_supply_offsite"
	base_turf = /turf/simulated/floor/plating
	base_area = /area/site404/entrancezone/dockingbay

/datum/shuttle/autodock/ferry/emergency/shuttle
	name = "Site 404 Personnel Transfer Shuttle"
	sound_takeoff = 'sounds/effects/engine_startup.ogg'
	location = 1
	warmup_time = 5
	shuttle_area = list(/area/site404/shuttle/emergency)
	waypoint_station = "nav_emergencyshuttle_onsite"
	landmark_transition = "nav_emergencyshuttle_transition"
	waypoint_offsite = "nav_emergencyshuttle_central"
	sound_landing = 'sounds/effects/engine_landing.ogg'
	landing_message = "A reverb is felt through the station as the docking bay clamps engage."
	takeoff_message = "A loud clunk is heard as the docking bay clamps disengage."

/obj/effect/shuttle_landmark/emergency/onsite
	name = "Transfer Shuttle Station Docking Pad"
	landmark_tag = "nav_emergencyshuttle_onsite"
	base_turf = /turf/simulated/floor
	base_area = /area/site404/entrancezone/dockingbay

/obj/effect/shuttle_landmark/transition/emergency
	name = "Transfer Shuttle Transition"
	landmark_tag = "nav_emergencyshuttle_transition"
	base_turf = /turf/unsimulated/floor/plating
	base_area = /area/site404/shuttle/emergency/transition

/obj/effect/shuttle_landmark/emergency/central
	name = "Transfer Shuttle Central Command"
	landmark_tag = "nav_emergencyshuttle_central"
	base_turf = /turf/simulated/floor
	base_area = /area/site404/entrancezone/dockingbay

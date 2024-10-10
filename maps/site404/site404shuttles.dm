
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
	name = "SCP-106 Containment Unit"
	sound_takeoff = 'sounds/effects/engine_startup.ogg'
	warmup_time = 10
	shuttle_area = list(/area/site404/shuttle/lift106)
	waypoint_station = "nav_106_start"
	waypoint_offsite = "nav_106_out"

/obj/effect/shuttle_landmark/containment106/start
	name = "SCP-106 Upper Containment Unit"
	landmark_tag = "nav_106_start"
	base_turf = /turf/simulated/floor/plating
	base_area = /area/site404/containmentchambers/scp106/chamber/uppercontainment

/obj/effect/shuttle_landmark/containment106/out
	name = "SCP-106 Lower Containment Unit"
	landmark_tag = "nav_106_out"
	base_turf = /turf/simulated/open
	base_area = /area/site404/containmentchambers/scp106/chamber/uppercontainment

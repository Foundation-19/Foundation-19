/*

### This file contains a list of all the areas in your station. Format is as follows:

/area/CATEGORY/OR/DESCRIPTOR/NAME 	(you can make as many subdivisions as you want)
	name = "NICE NAME" 				(not required but makes things really nice)
	icon = "ICON FILENAME" 			(defaults to areas.dmi)
	icon_state = "NAME OF ICON" 	(defaults to "unknown" (blank))
	requires_power = 0 				(defaults to 1)

NOTE: there are two lists of areas in the end of this file: centcom and station itself. Please maintain these lists valid. --rastaf0

*/



/area
	var/fire = null
	var/atmos = 1
	var/atmosalm = 0
	var/poweralm = 1
	var/party = null
	level = null
	name = "Unknown"
	icon = 'icons/turf/areas.dmi'
	icon_state = "unknown"
	plane = DEFAULT_PLANE
	layer = BASE_AREA_LAYER
	luminosity = 0
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/lightswitch = 1

	var/eject = null

	var/debug = 0
	var/requires_power = 1
	var/always_unpowered = 0	//this gets overriden to 1 for space in area/New()

	var/power_equip = 1 // Status
	var/power_light = 1
	var/power_environ = 1
	var/used_equip = 0  // Continuous drain; don't mess with these directly.
	var/used_light = 0
	var/used_environ = 0
	var/oneoff_equip   = 0 //Used once and cleared each tick.
	var/oneoff_light   = 0
	var/oneoff_environ = 0

	var/has_gravity = 1
	var/obj/machinery/power/apc/apc = null
	var/no_air = null
//	var/list/lights				// list of all lights on this area
	var/list/all_doors = null		//Added by Strumpetplaya - Alarm Change - Contains a list of doors adjacent to this area
	var/air_doors_activated = 0
	var/list/ambience = list(/ambience/ambigen1.ogg's/ambience/ambigen3.oggds/ambience/ambigen4.ognds/ambience/ambigen5.ounds/ambience/ambigen6.ounds/ambience/ambigen7sounds/ambience/ambigen'sounds/ambience/ambige,'sounds/ambience/ambige','sounds/ambience/ambigg','sounds/ambience/ambigg','sounds/ambience/ambigen14.ogg')
	var/list/forced_ambience = null
	var/sound_env = STANDARD_STATION
	var/turf/base_turf //The base turf type of the area, which can be used to override the z-level's base turf
	var/planetary_surface = FALSE // true if the area belongs to a planet.

/*-----------------------------------------------------------------------------*/

/////////
//SPACE//
/////////

/area/space
	name = "\improper Space"
	icon_state = "space"
	requires_power = 1
	always_unpowered = 1
	dynamic_lighting = 1
	power_light = 0
	power_equip = 0
	power_environ = 0
	has_gravity = 0
	area_flags = AREA_FLAG_EXTERNAL | AREA_FLAG_IS_NOT_PERSISTENT
	ambience = list(/ambience/ambispace1.ogg's/ambience/ambispace2.oggds/ambience/ambispace3.ognds/ambience/ambispace4.ounds/ambience/ambispace5.ogg')
	secure = FALSE

/area/space/atmosalert()
	return

/area/space/fire_alert()
	return

/area/space/fire_reset()
	return

/area/space/readyalert()
	return

/area/space/partyalert()
	return

//////////////////////
//AREAS USED BY CODE//
//////////////////////
/area/centcom
	name = "\improper Centcom"
	icon_state = "centcom"
	requires_power = 0
	dynamic_lighting = 0
	req_access = list(ACCESS_CENT_GENERAL)

/area/centcom/holding
	name = "\improper Holding Facility"

/area/chapel
	name = "\improper Chapel"
	icon_state = "chapel"

/area/centcom/specops
	name = "\improper Centcom Special Ops"
	req_access = list(ACCESS_CENT_SPECOPS)

/area/hallway
	name = "hallway"

/area/medical
	req_access = list(ACCESS_MEDICAL)

/area/security
	req_access = list(ACCESS_SEC_DOORS)

/area/security/brig
	name = "\improper Security - Brig"
	icon_state = "brig"
	req_access = list(ACCESS_BRIG)

/area/security/prison
	name = "\improper Security - Prison Wing"
	icon_state = "sec_prison"
	req_access = list(ACCESS_BRIG)

/area/maintenance
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = TUNNEL_ENCLOSED
	turf_initializer = /decl/turf_initializer/maintenance
	forced_ambience = list(/ambience/maintambience.ogg')
	req_access = list(ACCESS_MAINT_TUNNELS)

/area/rnd
	req_access = list(ACCESS_RESEARCH)

/area/rnd/xenobiology
	name = "\improper Xenobiology Lab"
	icon_state = "xeno_lab"
	req_access = list(ACCESS_XENOBIOLOGY, ACCESS_RESEARCH)

/area/rnd/xenobiology/xenoflora
	name = "\improper Xenoflora Lab"
	icon_state = "xeno_f_lab"

/area/rnd/xenobiology/xenoflora_storage
	name = "\improper Xenoflora Storage"
	icon_state = "xeno_f_store"

/area/shuttle/escape/centcom
	name = "\improper Emergency Shuttle Centcom"
	icon_state = "shuttle"
	req_access = list(ACCESS_CENT_GENERAL)

/area/shuttle/specops/centcom
	icon_state = "shuttlered"
	req_access = list(ACCESS_CENT_SPECOPS)
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED

/area/shuttle/syndicate_elite/mothership
	icon_state = "shuttlered"
	req_access = list(ACCESS_SYNDICATE)

/area/shuttle/syndicate_elite/station
	icon_state = "shuttlered2"
	req_access = list(ACCESS_SYNDICATE)

/area/supply
	name = "Supply Shuttle"
	icon_state = "shuttle3"
	req_access = list(ACCESS_CARGO)
	area_flags = AREA_FLAG_HIDE_FROM_HOLOMAP

/area/syndicate_elite_squad
	name = "\improper Elite Mercenary Squad"
	icon_state = "syndie-elite"
	req_access = list(ACCESS_SYNDICATE)
	area_flags = AREA_FLAG_HIDE_FROM_HOLOMAP

////////////
//SHUTTLES//
////////////
//shuttles only need starting area, movement is handled by landmarks
//All shuttles should now be under shuttle since we have smooth-wall code.

/area/shuttle
	requires_power = 0
	sound_env = SMALL_ENCLOSED
	base_turf = /turf/space

/*
* Special Areas
*/
/area/beach
	name = "Keelin's private beach"
	icon_state = "null"
	luminosity = 1
	dynamic_lighting = 0
	requires_power = 0
	var/sound/mysound = null

/area/beach/New()
	..()
	var/sound/S = new/sound()
	mysound = S
	S.file = /ambience/shore.ogg'
	S.repeat = 1
	S.wait = 0
	S.channel = GLOB.sound_channels.RequestChannel(/area/beach)
	S.volume = 100
	S.priority = 255
	S.status = SOUND_UPDATE
	process()

/area/beach/Entered(atom/movable/Obj,atom/OldLoc)
	. = ..()
	if(ismob(Obj))
		var/mob/M = Obj
		if(M.client)
			mysound.status = SOUND_UPDATE
			sound_to(M, mysound)

/area/beach/Exited(atom/movable/Obj)
	. = ..()
	if(ismob(Obj))
		var/mob/M = Obj
		if(M.client)
			mysound.status = SOUND_PAUSED | SOUND_UPDATE
			sound_to(M, mysound)

/area/beach/proc/process()
	set background = 1

	var/sound/S = null
	var/sound_delay = 0
	if(prob(25))
		S = sound(file=pick(/ambience/seag1.ogg's/ambience/seag2.oggds/ambience/seag3.ogg'), volume=100)
		sound_delay = rand(0, 50)

	for(var/mob/living/carbon/human/H in src)
		if(H.client)
			mysound.status = SOUND_UPDATE
			to_chat(H, mysound)
			if(S)
				spawn(sound_delay)
					sound_to(H, S)

	spawn(60) .()

/datum/map/site53
	name = "Site 53"
	full_name = "Foundation Site 53"
	path = "site53"
	flags = MAP_HAS_BRANCH | MAP_HAS_RANK
	station_levels = list(1,2,3,4)
	contact_levels = list(1,2,3,4)
	player_levels = list(1,2,3,4)
	admin_levels = list(5,6,7)
	empty_levels = list()
	accessible_z_levels = list("1"=1,"2"=1,"3"=1,"4"=1)
	base_turf_by_z = list(
		"1" = /turf/simulated/floor/exoplanet/desert,
		"2" = /turf/simulated/floor/exoplanet/desert,
		"3" = /turf/simulated/floor/exoplanet/snow,
	)
	overmap_size = 35
	overmap_event_areas = 0
	usable_email_tlds = list("site53.foundation", "security.site53.foundation", "science.site53.foundation", "utility.site53.foundation")

	allowed_spawns = list("Cryogenic Storage", "D-Cells", "Light Containment Zone")
	default_spawn = "Cryogenic Storage"

	station_name  = "Foundation Site 53"
	station_short = "Site 53"
	dock_name     = "TBD"
	boss_name     = "O5 Foundation Council"
	boss_short    = "O5 Council"
	company_name  = "SCP Foundation"
	company_short = "Foundation"

	map_admin_faxes = list("Foundation Central Office", "UIU Central Office", "GOC Central Office", "Horizon Initiative Central Office ", "Marshall, Carter, and Dark Central Office")

	//These should probably be moved into the evac controller...
	shuttle_docked_message = "The outbound train is now boarding at the Train Station. It will depart in approximately %ETD%."
	shuttle_leaving_dock = "The outbound train for off-duty personnel is now departing, and will reach its first stop in %ETA%."
	shuttle_called_message = "The work shift is now ending. The next outbound train for off-duty personnel will begin boarding in %ETA%."
	shuttle_recall_message = "The work shift has been extended. Please return to your post."
	emergency_shuttle_docked_message = "The emergency train is now boarding at the Train Station. Evacuation is mandatory for all Foundation personnel. It will depart in %ETD%."
	emergency_shuttle_leaving_dock = "The emergency train is departing for Extraction Site 53-B and will arrive in %ETA%. Please cooperate with Responders upon arrival."
	emergency_shuttle_called_message = "An emergency evacuation has been ordered for this facility. All authorized evacuees must proceed to the outbound Train Station within %ETA%."
	emergency_shuttle_recall_message = "The emergency evacuation has been cancelled. Return to your post."

//	evac_controller_type = /datum/evacuation_controller/site

	default_law_type = /datum/ai_laws/foundation
	use_overmap = 0
	num_exoplanets = 0
	planet_size = list(129,129)
	apc_test_exempt_areas = list(
		/area/space = NO_APC,
		/area/site53/llcz/mine/unexplored = NO_APC,
		/area/site53/llcz/mine/explored = NO_APC,
		/area/site53/surface = NO_APC,
		/area/turbolift/site53/surface = NO_APC,
		/area/turbolift/site53/basement = NO_APC,
		/area/turbolift/site53/logistics = NO_APC,
		/area/turbolift/site53/logisticstorage = NO_APC,
		/area/turbolift/site53/scp106obs = NO_APC,
		/area/turbolift/site53/scp106obs = NO_APC,
		/area/turbolift/site53/uhcz = NO_APC,
		/area/turbolift/site53/lhcz = NO_APC,
		/area/shuttle/escape_pod = NO_APC,
		/area/site53/tram/scpcar = NO_APC,
		/area/turbolift/site53/commstower = NO_APC,
		/area/turbolift/site53/scp106cont = NO_APC,
		/area/centcom/goc = NO_APC,
	)

	away_site_budget = 3

	id_hud_icons = 'maps/site53/icons/assignment_hud.dmi'

	lobby_tracks = list(
		/decl/audio/track/dieinthedark,
		/decl/audio/track/perdition,
		/decl/audio/track/ajoura,
		/decl/audio/track/days,
		/decl/audio/track/hie
	)

	available_cultural_info = list(
		TAG_HOMEWORLD = list(HOME_SYSTEM_EARTH),
		TAG_FACTION = list(FACTION_SOL_CENTRAL),
		TAG_CULTURE = list(
			CULTURE_HUMAN_EARTH,
			CULTURE_HUMAN_ARABIC,
			CULTURE_HUMAN_BRITISH,
			CULTURE_HUMAN_CHINESE,
			CULTURE_HUMAN_EASTSLAVIC,
			CULTURE_HUMAN_FRENCH,
			CULTURE_HUMAN_GERMAN,
			CULTURE_HUMAN_GOIDELIC,
			CULTURE_HUMAN_ITALIAN,
			CULTURE_HUMAN_JAPANESE,
			CULTURE_HUMAN_LATINAMERICAN),
		TAG_RELIGION = list(
			RELIGION_OTHER,
			RELIGION_JUDAISM,
			RELIGION_HINDUISM,
			RELIGION_BUDDHISM,
			RELIGION_ISLAM,
			RELIGION_CHRISTIANITY,
			RELIGION_AGNOSTICISM,
			RELIGION_ATHEISM,
		),
	)

	default_cultural_info = list(
		TAG_HOMEWORLD = HOME_SYSTEM_EARTH,
		TAG_FACTION =   FACTION_SOL_CENTRAL,
		TAG_CULTURE =   CULTURE_HUMAN_EARTH,
		TAG_RELIGION =  RELIGION_AGNOSTICISM
	)

/*
/datum/map/torch/setup_map()
	..()
	system_name = generate_system_name()
	minor_announcement = new(new_sound = sound('sound/AI/torch/commandreport.ogg', volume = 45))

/datum/map/torch/send_welcome()
	var/welcome_text = "<center><img src = sollogo.png /><br /><font size = 3><b>SEV Torch</b> Sensor Readings:</font><hr />"
	welcome_text += "Report generated on [stationdate2text()] at [station_time_timestamp("hh:mm")]</center><br /><br />"
	welcome_text += "Current system:<br /><b>[system_name()]</b><br />"
	welcome_text += "Next system targeted for jump:<br /><b>[generate_system_name()]</b><br />"
	welcome_text += "Travel time to Sol:<br /><b>[rand(15,45)] days</b><br />"
	welcome_text += "Time since last port visit:<br /><b>[rand(60,180)] days</b><br />"
	welcome_text += "Scan results show the following points of interest:<br />"
	var/list/space_things = list()
	var/obj/effect/overmap/torch = map_sectors["1"]
	for(var/zlevel in map_sectors)
		var/obj/effect/overmap/O = map_sectors[zlevel]
		if(O.name == torch.name)
			continue
		space_things |= O

	for(var/obj/effect/overmap/O in space_things)
		var/location_desc = " at present co-ordinates."
		if (O.loc != torch.loc)
			var/bearing = round(90 - Atan2(O.x - torch.x, O.y - torch.y),5) //fucking triangles how do they work
			if(bearing < 0)
				bearing += 360
			location_desc = ", bearing [bearing]."
		welcome_text += "<li>\A <b>[O.name]</b>[location_desc]</li>"
	welcome_text += "<br>No distress calls logged.<br />"

	post_comm_message("SEV Torch Sensor Readings", welcome_text)
	minor_announcement.Announce(message = "New [GLOB.using_map.company_name] Update available at all communication consoles.")
*/

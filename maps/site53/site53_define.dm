/datum/map/site53
	name = "Site 53"
	full_name = "Foundation Site 53"
	path = "site53"
	flags = MAP_HAS_BRANCH | MAP_HAS_RANK
	station_levels = list(1,2,3,4)
	contact_levels = list(1,2,3,4)
	player_levels = list(1,2,3,4)
	sealed_levels = list(1,2,3,4)
	base_turf_by_z = list(
		"1" = /turf/simulated/floor/exoplanet/desert,
		"2" = /turf/simulated/floor/exoplanet/desert,
		"3" = /turf/simulated/floor/exoplanet/snow,
		"4" = /turf/simulated/floor/exoplanet/snow,
	)
	overmap_size = 35
	overmap_event_areas = 0
	usable_email_tlds = list("site53.foundation", "security.site53.foundation", "science.site53.foundation", "utility.site53.foundation")
	config_path = "config/site53_config.txt"

	allowed_spawns = list("Cryogenic Storage", "D-Cells")
	default_spawn = "Cryogenic Storage"

	station_name  = "Foundation Site 53"
	station_short = "Site 53"
	dock_name     = "Emergency Site-91"
	boss_name     = "Foundation North American Command"
	boss_short    = "Regional Command"
	company_name  = "SCP Foundation"
	company_short = "Foundation"

	//These should probably be moved into the evac controller...
	shuttle_docked_message = "The outbound train is now boarding at the Train Station. It will depart in approximately %ETD%."
	shuttle_leaving_dock = "The outbound train for off-duty personnel is now departing, and will reach its first stop in %ETA%."
	shuttle_called_message = "The work shift is now ending. The next outbound train for off-duty personnel will begin boarding in %ETA%."
	shuttle_recall_message = "The work shift has been extended. Please return to your post."
	emergency_shuttle_docked_message = "The emergency train is now boarding at the Train Station. Evacuation is mandatory for all Foundation personnel. It will depart in %ETD%."
	emergency_shuttle_leaving_dock = "The emergency train is departing for Extraction Site 53-B and will arrive in %ETA%. Please cooperate with Responders upon arrival."
	emergency_shuttle_called_message = "An emergency evacuation has been ordered for this facility. All authorized evacuees must proceed to the outbound Train Station within %ETA%."
	emergency_shuttle_recall_message = "The emergency evacuation has been cancelled. Return to your post."

	evac_controller_type = /datum/evacuation_controller/shuttle //The evacuation controller that the map uses, this MUST be defined else the train will not function.

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
		/area/turbolift/site53/scp106obs = NO_APC,
		/area/turbolift/site53/scp106obs = NO_APC,
		/area/turbolift/site53/uhcz = NO_APC,
		/area/turbolift/site53/lhcz = NO_APC,
		/area/site53/tram/scpcar = NO_APC,
		/area/turbolift/site53/commstower = NO_APC,
		/area/turbolift/site53/scp106cont = NO_APC,
		/area/turbolift/site53/robotlwr = NO_APC,
		/area/turbolift/site53/robotupr = NO_APC,
		/area/turbolift/site53/gatea = NO_APC,
		/area/turbolift/site53/hub = NO_APC,
		/area/centcom/goc = NO_APC,
		/area/turbolift/site53/up082 = NO_APC,
		/area/turbolift/site53/low82 = NO_APC

	)

	away_site_budget = 3

	id_hud_icons = 'maps/site53/icons/assignment_hud.dmi'

	lobby_tracks = list(
		/decl/audio/track/dieinthedark,
		/decl/audio/track/perdition,
		/decl/audio/track/ajoura,
		/decl/audio/track/days,
		/decl/audio/track/hie,
		/decl/audio/track/chaos,
		/decl/audio/track/bookburners,
		/decl/audio/track/dread,
		/decl/audio/track/animosity,
		/decl/audio/track/animosity_v2,
		/decl/audio/track/main_astowo,
		/decl/audio/track/final_flash,
		/decl/audio/track/duplicity_and_disillusion,
		/decl/audio/track/battle_for_ganzir,
		/decl/audio/track/purge_protocol,
		/decl/audio/track/uiu_spawn_theme,
		/decl/audio/track/surface_area,
		/decl/audio/track/goc_spawn_theme2,
		/decl/audio/track/fall_of_ganzir,
		/decl/audio/track/the_bookburners_v2
	)

	available_cultural_info = list(
		TAG_HOMEWORLD = list(HOME_SYSTEM_EARTH),
		TAG_FACTION = list(FACTION_SCP_FOUNDATION),
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
		TAG_FACTION =   FACTION_SCP_FOUNDATION,
		TAG_CULTURE =   CULTURE_HUMAN_EARTH,
		TAG_RELIGION =  RELIGION_AGNOSTICISM
	)

/*
/datum/map/torch/setup_map()
	..()
	system_name = generate_system_name()
	minor_announcement = new(new_sound = sound('sounds/AI/torch/commandreport.ogg', volume = 45))
*/

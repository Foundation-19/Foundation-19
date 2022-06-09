/datum/map/site13
	name = "Site 13"
	full_name = "Site 13"
	path = "site13"
	flags = MAP_HAS_BRANCH | MAP_HAS_RANK

	lobby_icon = 'icons/lobby.dmi'

	station_levels = list(1,2,3,4,5,6)
	contact_levels = list(1,2,3,4,5,6)
	player_levels = list(1,2,3,4,5)
	admin_levels = list(6)
	empty_levels = list()
	accessible_z_levels = list("1"=1,"2"=1,"3"=1,"4"=1,"5"=1,"6"=30)
	overmap_size = 35
	overmap_event_areas = 0
	usable_email_tlds = list("s13.foundation", "security.s13.foundation", "science.s13.foundation", "administration.s13.foundation")

	allowed_spawns = list("Cryogenic Storage", "D-Cells")
	default_spawn = "Cryogenic Storage"

	station_name  = "Site 13"
	station_short = "Site 13"
	dock_name     = "TBD"
	boss_name     = "O5 Foundation Council"
	boss_short    = "O5 Council"
	company_name  = "SCP Foundation"
	company_short = "Foundation"

	map_admin_faxes = list("Foundation Central Office")

	shuttle_docked_message = "Attention Site Personnel, Means of Evacuation have arrived and will start picking staff up from helipads, the Gate B outside and shelters in %ETD%."
	shuttle_leaving_dock = "Attention Site Personnel, Means of Evacuation will finish evacuating personnel in %ETA% , please wait in the designated spots."
	shuttle_called_message = "Attention Site Personnel, Means of Evacuation have been called and will arrive in %ETA%."
	shuttle_recall_message = "Attention Site Peronnel, Evacuation aborted, return to normal operating conditions."

	evac_controller_type = /datum/evacuation_controller/starship

	default_law_type = /datum/ai_laws/solgov
	use_overmap = 0
	num_exoplanets = 0
	planet_size = list(129,129)

	away_site_budget = 0

	id_hud_icons = 'maps/site13/icons/assignment_hud.dmi'
	lobby_screens = list("title","title2")

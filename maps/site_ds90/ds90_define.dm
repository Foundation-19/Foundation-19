/datum/map/ds90
	name = "DSS-90"
	full_name = "Deep Space Site-90"
	path = "site_ds90"
	flags = MAP_HAS_BRANCH | MAP_HAS_RANK

	lobby_icon = 'icons/lobby.dmi'

	station_levels = list(1,2,3,4,5,6)
	contact_levels = list(1,2,3,4,5,6)
	player_levels = list(1,2,3,4,5,6)
	admin_levels = list(7,8)
	empty_levels = list()
	accessible_z_levels = list("1"=1,"2"=1,"3"=1,"4"=1,"5"=1,"6"=1, "7"=30, "8"=30)
	overmap_size = 35
	overmap_event_areas = 0
	usable_email_tlds = list("ds90.foundation", "security.ds90.foundation", "science.ds90.foundation", "utility.ds90.foundation")

	allowed_spawns = list("Cryogenic Storage", "D-Cells", "Light Containment Zone", "Security Base")
	default_spawn = "Cryogenic Storage"

	station_name  = "Deep Space Site-90"
	station_short = "Site DS-90"
	dock_name     = "TBD"
	boss_name     = "O5 Foundation Council"
	boss_short    = "O5 Council"
	company_name  = "SCP Foundation"
	company_short = "Foundation"

	map_admin_faxes = list("Foundation Central Office")

	//These should probably be moved into the evac controller...
	shuttle_docked_message = "Attention all hands: Jump preparation complete. The bluespace drive is now spooling up, secure all stations for departure. Time to jump: approximately %ETD%."
	shuttle_leaving_dock = "Attention all hands: Jump initiated, exiting bluespace in %ETA%."
	shuttle_called_message = "Attention all hands: Jump sequence initiated. Transit procedures are now in effect. Jump in %ETA%."
	shuttle_recall_message = "Attention all hands: Jump sequence aborted, return to normal operating conditions."

	evac_controller_type = /datum/evacuation_controller/starship

	default_law_type = /datum/ai_laws/solgov
	use_overmap = 0
	num_exoplanets = 0
	planet_size = list(129,129)

	away_site_budget = 3

	id_hud_icons = 'maps/site_ds90/icons/assignment_hud.dmi'
	lobby_screens = list("title","title2")
/*
/datum/map/torch/setup_map()
	..()
	system_name = generate_system_name()
	minor_announcement = new(new_sound = sound('sound/AI/torch/commandreport.ogg', volume = 45))

/datum/map/torch/send_welcome()
	var/welcome_text = "<center><img src = sollogo.png /><br /><font size = 3><b>SEV Torch</b> Sensor Readings:</font><hr />"
	welcome_text += "Report generated on [stationdate2text()] at [stationtime2text()]</center><br /><br />"
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
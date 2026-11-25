/datum/computer_file/program/suit_sensors
	filename = "sensormonitor"
	filedesc = "Suit Sensors Monitoring"
	nanomodule_path = /datum/nano_module/crew_monitor
	ui_header = "crew_green.gif"
	program_icon_state = "crew"
	program_key_state = "med_key"
	program_menu_icon = "heart"
	extended_desc = "This program connects to life signs monitoring system to provide basic information on personnel health."
	required_access = ACCESS_MEDICAL_LVL1
	requires_ntnet = TRUE
	network_destination = "crew lifesigns monitoring system"
	size = 11
	var/has_alert = FALSE

/datum/computer_file/program/suit_sensors/process_tick()
	..()

	var/datum/nano_module/crew_monitor/NMC = NM
	if(istype(NMC) && (NMC.has_alerts() != has_alert))
		if(!has_alert)
			program_icon_state = "crew-red"
			ui_header = "crew_red.gif"
		else
			program_icon_state = "crew"
			ui_header = "crew_green.gif"
		update_computer_icon()
		has_alert = !has_alert

	return 1

/datum/nano_module/crew_monitor
	name = "Crew monitor"

/datum/nano_module/crew_monitor/proc/has_alerts()
	for(var/z_level in GLOB.using_map.map_levels)
		if (crew_repository.has_health_alert(z_level))
			return TRUE
	return FALSE

/datum/nano_module/crew_monitor/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..()) return 1

	if(action == "track")
		if(isAI(usr))
			var/mob/living/silicon/ai/AI = usr
			var/mob/living/carbon/human/H = locate(params["track"]) in SSmobs.mob_list
			if(hassensorlevel(H, SUIT_SENSOR_TRACKING))
				AI.ai_actual_track(H)
		return 1

/// Minimal station-map asset bundle for the crew monitor's map view.
/// Must NOT reuse /datum/asset/simple/nanoui: that bundle also ships the
/// legacy NanoUI JS/CSS, and the tgui frontend executes every .js in the
/// asset/mappings payload — which crashes the page with the BSOD.
/// Populated lazily: SSassets may instantiate this datum before the map
/// datum has map_levels ready, so registration happens on first use.
/datum/asset/simple/crew_monitor_maps
	keep_local_name = TRUE
	var/populated = FALSE

/datum/asset/simple/crew_monitor_maps/proc/populate()
	if(populated)
		return
	populated = TRUE
	for(var/z in GLOB.using_map.map_levels)
		var/filename = map_image_file_name(z)
		var/file_path = MAP_IMAGE_PATH + filename
		if(fexists(file_path))
			assets[filename] = fcopy_rsc(file_path)
	register()

/datum/nano_module/crew_monitor/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SuitSensors", "Crew Monitoring Computer")
		ui.open()

// The map view needs the station map images, keyed by filename so the
// frontend can resolveAsset("site53-N.png").
/datum/nano_module/crew_monitor/tgui_assets(mob/user)
	. = ..()
	var/datum/asset/simple/crew_monitor_maps/maps = get_asset_datum(/datum/asset/simple/crew_monitor_maps)
	maps.populate()
	. |= list(maps)

/datum/nano_module/crew_monitor/tgui_data(mob/user)
	var/list/data = host.initial_data()

	data["isAI"] = isAI(user)
	var/Z = get_host_z()
	data["crewmembers"] = crew_repository.health_data(Z)
	data["map_levels"] = GLOB.using_map.map_levels
	data["map_prefix"] = GLOB.using_map.path
	data["world_maxx"] = world.maxx
	data["world_maxy"] = world.maxy

	return data

/mob/living/silicon/ai
	hud_type = /datum/hud/ai

/datum/hud/ai/FinalizeInstantiation()

	if(!isAI(mymob))
		return

	var/mob/living/silicon/A = mymob

	adding = list()
	adding += new /atom/movable/screen/ai_button(null,
			ui_ai_core,
			"AIC Core",
			"ai_core",
			TYPE_PROC_REF(/mob/living/silicon/ai, core)
			)

	adding += new /atom/movable/screen/ai_button(null,
			ui_ai_announcement,
			"AIC Announcement",
			"announcement",
			TYPE_PROC_REF(/mob/living/silicon/ai, ai_announcement)
			)

	adding += new /atom/movable/screen/ai_button(null,
			ui_ai_cam_track,
			"Track With Camera",
			"track",
			TYPE_PROC_REF(/mob/living/silicon/ai, ai_camera_track),
			list(/mob/living/silicon/ai/proc/trackable_mobs = (AI_BUTTON_PROC_BELONGS_TO_CALLER|AI_BUTTON_INPUT_REQUIRES_SELECTION))
			)

	adding += new /atom/movable/screen/ai_button(null,
			ui_ai_cam_light,
			"Toggle Camera Lights",
			"camera_light",
			TYPE_PROC_REF(/mob/living/silicon/ai, toggle_camera_light)
			)

	adding += new /atom/movable/screen/ai_button(null,
			ui_ai_cam_change_network,
			"Jump to Network",
			"camera",
			TYPE_PROC_REF(/mob/living/silicon/ai, ai_network_change),
			list(/mob/living/silicon/ai/proc/get_camera_network_list = (AI_BUTTON_PROC_BELONGS_TO_CALLER|AI_BUTTON_INPUT_REQUIRES_SELECTION))
			)

	adding += new /atom/movable/screen/ai_button(null,
			ui_ai_sensor,
			"Set Sensor Mode",
			"ai_sensor",
			TYPE_PROC_REF(/mob/living/silicon/ai, sensor_mode)
			)

	adding += new /atom/movable/screen/ai_button(null,
			ui_ai_crew_manifest,
			"Show Crew Manifest",
			"manifest",
			TYPE_PROC_REF(/mob/living/silicon/ai, show_crew_manifest)
			)

	adding += new /atom/movable/screen/ai_button(null,
			ui_ai_take_image,
			"Toggle Camera Mode",
			"take_picture",
			TYPE_PROC_REF(/mob/living/silicon/ai, ai_take_image)
			)

	adding += new /atom/movable/screen/ai_button(null,
			ui_ai_view_images,
			"View Images",
			"view_images",
			TYPE_PROC_REF(/mob/living/silicon/ai, ai_view_images)
			)

	adding += new /atom/movable/screen/ai_button(null,
			ui_ai_state_laws,
			"State Laws",
			"state_laws",
			TYPE_PROC_REF(/mob/living/silicon/ai, ai_checklaws)
			)

	adding += new /atom/movable/screen/ai_button(null,
			ui_ai_call_shuttle,
			"Call Shuttle",
			"call_shuttle",
			TYPE_PROC_REF(/mob/living/silicon/ai, ai_call_shuttle)
			)

	adding += new /atom/movable/screen/ai_button(null,
			ui_ai_up,
			"Move Upwards",
			"ai_up",
			/mob/verb/up
			)

	adding += new /atom/movable/screen/ai_button(null,
			ui_ai_down,
			"Move Downwards",
			"ai_down",
			/mob/verb/down
			)

	adding += new /atom/movable/screen/ai_button(null,
			ui_ai_color,
			"Change Floor Color",
			"ai_floor",
			TYPE_PROC_REF(/mob/living/silicon/ai, change_floor)
			)

	adding += new /atom/movable/screen/ai_button(null,
			ui_ai_holo_change,
			"Change Hologram",
			"ai_holo_change",
			TYPE_PROC_REF(/mob/living/silicon/ai, ai_hologram_change)
			)

	adding += new /atom/movable/screen/ai_button(null,
			ui_ai_emergency_announc,
			"Emergency O5 Announcement",
			"emergency",
			TYPE_PROC_REF(/mob/living/silicon/ai, ai_emergency_message)
			)

	adding += new /atom/movable/screen/ai_button(null,
			ui_ai_crew_mon,
			"Personnel Monitor",
			"crew_monitor",
			TYPE_PROC_REF(/mob/living/silicon/ai, show_crew_monitor)
			)

	adding += new /atom/movable/screen/ai_button(null,
			ui_ai_power_override,
			"Toggle Power Override",
			"ai_p_override",
			TYPE_PROC_REF(/mob/living/silicon/ai, ai_power_override)
			)

	adding += new /atom/movable/screen/ai_button(null,
			ui_ai_shutdown,
			"Shutdown",
			"ai_shutdown",
			TYPE_PROC_REF(/mob/living/silicon/ai, ai_shutdown)
			)

	adding += new /atom/movable/screen/ai_button(null,
			ui_ai_holo_mov,
			"Toggle Hologram Movement",
			"ai_holo_mov",
			TYPE_PROC_REF(/mob/living/silicon/ai, toggle_hologram_movement)
			)

	adding += new /atom/movable/screen/ai_button(null,
			ui_ai_area_apc,
			"Access Area APC",
			"ai_area_apc",
			TYPE_PROC_REF(/mob/living/silicon/ai, access_area_apc)
			)

	adding += new /atom/movable/screen/ai_button(null,
			ui_ai_core_icon,
			"Pick Icon",
			"ai_core_pick",
			TYPE_PROC_REF(/mob/living/silicon/ai, pick_icon)
			)

	adding += new /atom/movable/screen/ai_button(null,
			ui_ai_status,
			"Pick Status",
			"ai_status",
			TYPE_PROC_REF(/mob/living/silicon/ai, ai_statuschange)
			)

	adding += new /atom/movable/screen/ai_button(null,
			ui_ai_crew_rec,
			"Crew Records",
			"ai_crew_rec",
			TYPE_PROC_REF(/mob/living/silicon/ai, show_crew_records)
			)

	A.client.screen = list()
	A.client.screen.Add(adding)

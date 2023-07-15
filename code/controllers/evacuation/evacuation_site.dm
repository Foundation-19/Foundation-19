#define EVAC_OPT_ABANDON_SITE "abandon_site"
#define EVAC_OPT_END_SHIFT "end_shift"
#define EVAC_OPT_CANCEL_ABANDON_SITE "cancel_abandon_site"
#define EVAC_OPT_CANCEL_END_SHIFT "cancel_end_shift"

// Apparently, emergency_evacuation --> "abandon site" and !emergency_evacuation --> "shift end"
// That stuff should be moved to the evacuation option datums but someone can do that later
/datum/evacuation_controller/site
	name = "site evacuation controller"

	evac_prep_delay    = 5 MINUTES
	evac_launch_delay  = 3 MINUTES
	evac_transit_delay = 2 MINUTES

	transfer_prep_additional_delay     = 15 MINUTES
	autotransfer_prep_additional_delay = 5 MINUTES
	emergency_prep_additional_delay    = 0 MINUTES

	evacuation_options = list(
		EVAC_OPT_ABANDON_SITE = new /datum/evacuation_option/abandon_site(),
		EVAC_OPT_END_SHIFT = new /datum/evacuation_option/end_shift(),
		EVAC_OPT_CANCEL_ABANDON_SITE = new /datum/evacuation_option/cancel_abandon_site(),
		EVAC_OPT_CANCEL_END_SHIFT = new /datum/evacuation_option/cancel_end_shift()
	)

/datum/evacuation_controller/site/finish_preparing_evac()
	. = ..()
	// Arm the tram regardless of evac type
	for (var/datum/shuttle/autodock/ferry/escape_pod/pod in escape_pods)
		if (pod.arming_controller)
			pod.arming_controller.arm()

/datum/evacuation_controller/site/launch_evacuation()

	state = EVAC_IN_TRANSIT

	for (var/datum/shuttle/autodock/ferry/escape_pod/pod in escape_pods) // Launch the tram regardless of evac type
		if (!pod.arming_controller || pod.arming_controller.armed)
			pod.move_time = (evac_transit_delay/10)
			pod.launch(src)

	if (emergency_evacuation)
		// Abandon Site
		priority_announcement.Announce(replacetext(replacetext(GLOB.using_map.emergency_shuttle_leaving_dock, "%dock_name%", "[GLOB.using_map.dock_name]"),  "%ETA%", "[round(get_eta()/60,1)] minute\s"))
	else
		// Shift Change
		priority_announcement.Announce(replacetext(replacetext(GLOB.using_map.shuttle_leaving_dock, "%dock_name%", "[GLOB.using_map.dock_name]"),  "%ETA%", "[round(get_eta()/60,1)] minute\s"))

/datum/evacuation_controller/site/finish_evacuation()
	..()

/datum/evacuation_controller/site/available_evac_options()
	if (is_on_cooldown())
		return list()
	if (is_idle())
		return list(evacuation_options[EVAC_OPT_END_SHIFT], evacuation_options[EVAC_OPT_ABANDON_SITE])
	if (is_evacuating())
		if (emergency_evacuation)
			return list(evacuation_options[EVAC_OPT_CANCEL_ABANDON_SITE])
		else
			return list(evacuation_options[EVAC_OPT_END_SHIFT])

/datum/evacuation_option/abandon_site
	option_text = "Evacuate site"
	option_desc = "abandon the site"
	option_target = EVAC_OPT_ABANDON_SITE
	needs_syscontrol = TRUE
	silicon_allowed = TRUE

/datum/evacuation_option/abandon_site/execute(mob/user)
	if (!ticker || !evacuation_controller)
		return
	if (evacuation_controller.deny)
		to_chat(user, "Unable to initiate evacuation procedures.")
		return
	if (evacuation_controller.is_on_cooldown())
		to_chat(user, evacuation_controller.get_cooldown_message())
		return
	if (evacuation_controller.is_evacuating())
		to_chat(user, "Evacuation procedures already in progress.")
		return
	if (evacuation_controller.call_evacuation(user, 1))
		log_and_message_staff("[user? key_name(user) : "Autotransfer"] has initiated abandonment of the site.")

/datum/evacuation_option/end_shift
	option_text = "End work shift"
	option_desc = "end the work shift"
	option_target = EVAC_OPT_END_SHIFT
	needs_syscontrol = TRUE
	silicon_allowed = TRUE

/datum/evacuation_option/end_shift/execute(mob/user)
	if (!ticker || !evacuation_controller)
		return
	if (evacuation_controller.deny)
		to_chat(user, "Unable to end work shift.")
		return
	if (evacuation_controller.is_on_cooldown())
		to_chat(user, evacuation_controller.get_cooldown_message())
		return
	if (evacuation_controller.is_evacuating())
		to_chat(user, "Standard shift change already in progress.")
		return
	if (evacuation_controller.call_evacuation(user, 0))
		log_and_message_staff("[user? key_name(user) : "Autotransfer"] has initiated a shift change.")

/datum/evacuation_option/cancel_abandon_site
	option_text = "Cancel abandonment"
	option_desc = "cancel abandonment of the site"
	option_target = EVAC_OPT_CANCEL_ABANDON_SITE
	needs_syscontrol = TRUE
	silicon_allowed = FALSE

/datum/evacuation_option/cancel_abandon_site/execute(mob/user)
	if (ticker && evacuation_controller && evacuation_controller.cancel_evacuation())
		log_and_message_staff("[key_name(user)] has cancelled abandonment of the site.")

/datum/evacuation_option/cancel_end_shift
	option_text = "Cancel shift change"
	option_desc = "cancel the the shift change"
	option_target = EVAC_OPT_CANCEL_END_SHIFT
	needs_syscontrol = TRUE
	silicon_allowed = FALSE

/datum/evacuation_option/cancel_end_shift/execute(mob/user)
	if (ticker && evacuation_controller && evacuation_controller.cancel_evacuation())
		log_and_message_staff("[key_name(user)] has cancelled the shift change.")

// /obj/screen/fullscreen/bluespace_overlay
// 	icon = 'icons/effects/effects.dmi'
// 	icon_state = "mfoam"
// 	screen_loc = "WEST,SOUTH to EAST,NORTH"
// 	color = "#ff9900"
// 	blend_mode = BLEND_SUBTRACT
// 	layer = FULLSCREEN_LAYER

#undef EVAC_OPT_ABANDON_SITE
#undef EVAC_OPT_END_SHIFT
#undef EVAC_OPT_CANCEL_ABANDON_SITE
#undef EVAC_OPT_CANCEL_END_SHIFT

#define PROGBAR_BOOSTER_FADEIN_TIME (0.5 SECONDS)

/datum/progbar_booster_manager
	/// The progressbar that created us
	var/datum/progressbar/linked_bar
	/// Clicking this makes the do_after faster.
	var/obj/effect/client_image_holder/progressbar_booster/booster
	/// Clicking this makes the do_after slower. Prevents autoclickers/macros from being an effective strategy.
	var/obj/effect/client_image_holder/progressbar_trap/trap
	/// How long it takes for focuses to re-appear after being clicked.
	var/focus_frequency

/datum/progbar_booster_manager/New(datum/progressbar/_linked_bar, bonus_percentage, _focus_frequency, focus_sound, focus_fail_sound)
	linked_bar = _linked_bar
	focus_frequency = _focus_frequency

	bonus_percentage *= 0.01	// converts from readable values (0-100) to internal values (0-1)
	var/fastest_possible_time = linked_bar.goal - (linked_bar.goal * bonus_percentage)

	var/max_uses = round(fastest_possible_time / focus_frequency)

	var/time_per_success
	if(max_uses <= 0)
		time_per_success = linked_bar.goal
	else
		time_per_success = (linked_bar.goal * bonus_percentage) / max_uses

	var/initial_x = rand(-12,12)
	var/initial_y = rand(-12,12)

	booster = new(get_turf(linked_bar.target), list(linked_bar.user), src, time_per_success, focus_sound, initial_x, initial_y)
	trap = new(get_turf(linked_bar.target), list(linked_bar.user), src, -0.75 * time_per_success, focus_fail_sound, initial_x, initial_y)
	. = ..()

/datum/progbar_booster_manager/Destroy(force)
	QDEL_NULL(booster)
	QDEL_NULL(trap)
	. = ..()

/datum/progbar_booster_manager/proc/randomize_location()
	var/x = rand(-12,12)
	var/y = rand(-12,12)

	booster.alpha = 0
	trap.alpha = 0

	booster.image_pixel_x = x
	booster.image_pixel_y = y

	trap.image_pixel_x = x
	trap.image_pixel_y = y

	booster.regenerate_image()
	trap.regenerate_image()

	addtimer(CALLBACK(src, PROC_REF(handle_fadein)), focus_frequency)

/datum/progbar_booster_manager/proc/handle_fadein()
	if(booster)
		animate(booster, alpha = 255, time = PROGBAR_BOOSTER_FADEIN_TIME)
	if(trap)	// theoretically there shouldn't be a case where one exists and the other one doesn't, but just in case we do two separate checks
		animate(trap, alpha = 255, time = PROGBAR_BOOSTER_FADEIN_TIME)

///Special object used to reward mouse accuracy with a slight speed bonus to progressbars. Only used on certain objects.
/obj/effect/client_image_holder/progressbar_booster
	name = "focus"
	desc = "If I focus, I might be able to speed up my progress a little bit."
	image_icon = 'icons/hud/progressbar_interactive.dmi'
	image_state = "progress_focus"
	image_plane = HUD_PLANE
	image_layer = HUD_PROGRESS_BOOSTER_LAYER
	/// The datum responsible for managing the system
	var/datum/progbar_booster_manager/manager
	/// Sound played when successfully triggered.
	var/focus_sound
	/// How much bonus time we give the do_after
	var/time_per_success

/obj/effect/client_image_holder/progressbar_booster/Initialize(mapload, list/mobs_which_see_us, _manager, _time_per_success, _focus_sound, initial_x, initial_y)
	image_pixel_x = initial_x
	image_pixel_y = initial_y

	manager = _manager
	time_per_success = _time_per_success
	focus_sound = _focus_sound

	. = ..()

/obj/effect/client_image_holder/progressbar_booster/Click(location, control, params)
	. = ..()
	sound_to(manager.linked_bar.user, focus_sound)
	manager.linked_bar.boost_progress(time_per_success)
	manager.randomize_location()

/obj/effect/client_image_holder/progressbar_trap
	name = ""
	desc = ""
	image_icon = 'icons/hud/progressbar_interactive.dmi'
	image_state = "progress_trap"
	image_plane = HUD_PLANE
	image_layer = HUD_PROGRESS_TRAP_LAYER
	/// The datum responsible for managing the system
	var/datum/progbar_booster_manager/manager
	/// Sound played when successfully triggered.
	var/focus_fail_sound
	/// How much bonus time we take from the do_after
	var/time_per_failure

/obj/effect/client_image_holder/progressbar_trap/Initialize(mapload, list/mobs_which_see_us, _manager, _time_per_failure, _focus_fail_sound, initial_x, initial_y)
	image_pixel_x = initial_x
	image_pixel_y = initial_y

	manager = _manager
	time_per_failure = _time_per_failure
	focus_fail_sound = _focus_fail_sound

	. = ..()

/obj/effect/client_image_holder/progressbar_trap/Click(location, control, params)
	. = ..()
	sound_to(manager.linked_bar.user, focus_fail_sound)
	manager.linked_bar.boost_progress(time_per_failure)

#undef PROGBAR_BOOSTER_FADEIN_TIME

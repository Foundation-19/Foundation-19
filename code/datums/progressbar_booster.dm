#define PROGBAR_BOOSTER_FADEIN_TIME 0.5 SECONDS

///Special object used to reward mouse accuracy with a slight speed bonus to progressbars. Only used on certain objects.
/obj/effect/client_image_holder/progressbar_booster
	name = "focus"
	desc = "If I focus, I might be able to speed up my progress a little bit."
	image_icon = 'icons/hud/progressbar_interactive.dmi'
	image_state = "progress_focus"
	image_plane = HUD_PLANE
	image_layer = UNDER_HUD_LAYER
	/// The progress bar that this booster is linked to.
	var/datum/progressbar/linked_bar
	/// Secondary object used to block clicks.
	var/obj/effect/client_image_holder/progressbar_trap/prog_trap
	/// How much this focus helps progressbar progress. Calculated in New().
	var/time_per_click
	/// Sound played when successfully triggered.
	var/focus_sound
	/// How often focuses show up
	var/focus_frequency

/obj/effect/client_image_holder/progressbar_booster/Initialize(mapload, list/mobs_which_see_us, datum/progressbar/target_bar, bonus_percentage, f_sound, f_frequency)
	. = ..()
	bonus_percentage *= 0.01	// converts from readable values (0-100) to internal values (0-1)
	var/fastest_possible_time = target_bar.goal - (target_bar.goal * bonus_percentage)

	var/max_uses = round(fastest_possible_time / f_frequency, 1)

	if(max_uses <= 0)
		time_per_click = target_bar.goal
	else
		time_per_click = (target_bar.goal * bonus_percentage) / max_uses

	linked_bar = target_bar
	focus_sound = f_sound
	focus_frequency = f_frequency

	target_bar.user?.client?.screen += src

	prog_trap = new /obj/effect/client_image_holder/progressbar_trap(get_turf(src), mobs_which_see_us, linked_bar, time_per_click)

/obj/effect/client_image_holder/progressbar_booster/Click(location, control, params)
	. = ..()
	sound_to(linked_bar.user, focus_sound)
	linked_bar.boost_progress(time_per_click)

	alpha = 0
	image_pixel_x = rand(-12,12)
	image_pixel_y = rand(-12,12)

	if(prog_trap)
		prog_trap.alpha = 0
		prog_trap.image_pixel_x = image_pixel_x
		prog_trap.image_pixel_y = image_pixel_y

	spawn()
		sleep(focus_frequency)
		animate(src, alpha = 255, time = PROGBAR_BOOSTER_FADEIN_TIME)
		if(prog_trap)
			animate(prog_trap, alpha = 255, time = PROGBAR_BOOSTER_FADEIN_TIME)

/obj/effect/client_image_holder/progressbar_booster/Destroy()
	. = ..()
	linked_bar.user?.client?.screen -= src
	QDEL_NULL(prog_trap)

/obj/effect/client_image_holder/progressbar_trap
	name = ""
	desc = ""
	image_icon = 'icons/hud/progressbar_interactive.dmi'
	image_state = "progress_trap"
	///The progress bar that this booster is linked to
	var/datum/progressbar/linked_bar
	///How much this focus hurts overall progress
	var/loss_per_click

/obj/effect/client_image_holder/progressbar_trap/Initialize(mapload, list/mobs_which_see_us, datum/progressbar/target_bar, time_per_click)
	. = ..()
	linked_bar = target_bar
	loss_per_click = -1 * time_per_click

	linked_bar.user?.client?.screen += src

/obj/effect/client_image_holder/progressbar_trap/Click(location, control, params)
	. = ..()
	sound_to(linked_bar.user, 'sounds/machines/buzz-sigh.ogg')
	linked_bar.boost_progress(loss_per_click)

/obj/effect/client_image_holder/progressbar_trap/Destroy()
	. = ..()
	linked_bar.user?.client?.screen -= src

#undef PROGBAR_BOOSTER_FADEIN_TIME

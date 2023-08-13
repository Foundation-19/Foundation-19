/atom/var/do_unique_target_user

/// List of progress bars this mob is currently seeing for actions, helpful in stacking do_after bars
/mob/var/list/progressbars = null

/// List of progress bars this atom is currently seeing from other people, helpful in stacking do_after bars
/atom/var/list/progressbars_recipient = null

/// For storing what do_after's someone has, key = string, value = amount of interactions of that type happening.
/mob/var/list/do_afters

/**
 * Timed action involving one mob user. Target is optional.
 *
 * Checks that `user` does not move, change hands, get stunned, etc. for the
 * given `delay`. Returns `TRUE` on success or `FALSE` on failure.
 * Interaction_key is the assoc key under which the do_after is capped, with max_interact_count being the cap. Interaction key will default to target if not set.
 */
/proc/do_after(mob/user, delay, atom/target, do_flags = DO_DEFAULT, incapacitation_flags = INCAPACITATION_DEFAULT, datum/callback/extra_checks, interaction_key, max_interact_count = 1)
	if(!isnum(delay))
		CRASH("do_after was passed a non-number delay: [delay || "null"].")

	if (!user)
		return FALSE

	if(!interaction_key && target)
		interaction_key = target //Use the direct ref to the target
	if(interaction_key) //Do we have a interaction_key now?
		var/current_interaction_count = LAZYACCESS(user.do_afters, interaction_key) || 0
		if(current_interaction_count >= max_interact_count) //We are at our peak
			return
		LAZYSET(user.do_afters, interaction_key, current_interaction_count + 1)

	if (target?.do_unique_target_user)
		return FALSE

	if ((do_flags & DO_TARGET_UNIQUE_ACT) && target)
		target.do_unique_target_user = user

	if(!(do_flags & IGNORE_SLOWDOWNS))
		delay *= user.cached_multiplicative_actions_slowdown

	var/atom/user_loc = user.loc
	var/user_dir = user.dir
	var/user_hand = user.hand
	var/holding = user.get_active_hand()
	var/target_zone = user.zone_sel?.selecting

	var/atom/target_loc = target?.loc
	var/target_dir = target?.dir
	var/target_type = target?.type

	var/datum/progressbar/bar
	if (do_flags & DO_SHOW_USER)
		bar = new /datum/progressbar(user, delay, target || user, (do_flags & DO_SHOW_USER))

	SEND_SIGNAL(user, COMSIG_DO_AFTER_BEGAN)

	var/start_time = world.time
	var/end_time = start_time + delay

	. = TRUE

	while (world.time < end_time)
		stoplag(1)
		if(!QDELETED(bar))
			bar.update(world.time - start_time)

		// non-target reliant
		if(QDELETED(user)\
			|| (target_type && QDELETED(target))\
			|| user.incapacitated(incapacitation_flags)\
			|| ((do_flags & DO_USER_CAN_MOVE) && (user_loc != user.loc))\
			|| ((do_flags & DO_USER_CAN_TURN) && (user_dir != user.dir))\
			|| (!(do_flags & DO_USER_IGNORE_ITEM) && user.get_active_hand() != holding)\
			|| ((do_flags & DO_USER_SAME_HAND) && user_hand != user.hand)\
			|| ((do_flags & DO_USER_SAME_ZONE) && user.zone_sel.selecting != target_zone)\
			|| (extra_checks && !extra_checks.Invoke()))
			. = FALSE
			break

		// target reliant
		if(target && (user != target) && (\
			((do_flags & DO_TARGET_CAN_MOVE) && (target_loc != target.loc))\
			|| ((do_flags & DO_TARGET_CAN_TURN) && target_dir != target.dir)))
			. = FALSE
			break

	if (!QDELETED(bar))
		bar.end_progress()
	if ((do_flags & DO_TARGET_UNIQUE_ACT) && target)
		target.do_unique_target_user = null
	SEND_SIGNAL(user, COMSIG_DO_AFTER_ENDED)

	if(interaction_key)
		LAZYREMOVE(user.do_afters, interaction_key)

/* TODO
/// Interactive form of do_after. Buggy; do not use on items inside of an inventory
/proc/do_after_interactive(mob/user, time = 3 SECONDS, atom/target, timed_action_flags = NONE, progress = TRUE, datum/callback/extra_checks, interaction_key, max_interact_count = 1, bonus_time = 0, focus_sound = null, type = /obj/effect/hallucination/simple/progress_focus)
	if(!user)
		return FALSE
	var/atom/target_loc = null
	if(target && !isturf(target))
		target_loc = target.loc

	if(!interaction_key && target)
		interaction_key = target //Use the direct ref to the target
	if(interaction_key) //Do we have a interaction_key now?
		var/current_interaction_count = LAZYACCESS(user.do_afters, interaction_key) || 0
		if(current_interaction_count >= max_interact_count) //We are at our peak
			return
		LAZYSET(user.do_afters, interaction_key, current_interaction_count + 1)

	var/atom/user_loc = user.loc

	var/drifting = FALSE
	if(SSmove_manager.processing_on(user, SSspacedrift))
		drifting = TRUE

	var/holding = user.get_active_hand()
	time -= bonus_time
	time *= user.cached_multiplicative_actions_slowdown

	var/datum/progressbar/progbar
	if(progress)
		progbar = new(user, time, target || user, bonus_time, focus_sound, type)

	var/endtime = world.time + time
	var/starttime = world.time
	. = TRUE
	while (world.time + progbar?.bonus_progress < endtime)
		stoplag(1)

		if(!QDELETED(progbar))
			progbar.update(world.time - starttime)

		if(drifting && !SSmove_manager.processing_on(user, SSspacedrift))
			drifting = FALSE
			user_loc = user.loc

		if(
			QDELETED(user) \
			|| (!(timed_action_flags & DO_USER_CAN_MOVE) && !drifting && user.loc != user_loc) \
			|| (!(timed_action_flags & DO_USER_IGNORE_ITEM) && user.get_active_hand() != holding) \
			|| (!(timed_action_flags & IGNORE_INCAPACITATED) && HAS_TRAIT(user, TRAIT_INCAPACITATED)) \
			|| (extra_checks && !extra_checks.Invoke()) \
		)
			. = FALSE
			break

		if(
			!(timed_action_flags & IGNORE_TARGET_LOC_CHANGE) \
			&& !drifting \
			&& !QDELETED(target_loc) \
			&& (QDELETED(target) || target_loc != target.loc) \
			&& ((user_loc != target_loc || target_loc != user)) \
			)
			. = FALSE
			break

	if(!QDELETED(progbar))
		progbar.end_progress()

	if(interaction_key)
		LAZYREMOVE(user.do_afters, interaction_key)

/obj/effect/hallucination/simple/progress_focus
	name = "focus"
	desc = "If I focus, I might be able to speed up my progress a little bit."
	image_icon = 'icons/effects/interactive.dmi'
	image_state = "progress_focus"
	image_plane = GAME_PLANE_UPPER
	///The progress bar that this booster is linked to
	var/datum/progressbar/linked_bar
	///How much this focus helps overall progress
	var/time_per_click
	///Sound played when clicked
	var/focus_sound = list('sound/machines/click.ogg' = 1)
	///Secondary object used to block clicks, provide special animation, etc.
	var/obj/effect/hallucination/simple/extra_effect
	///How many times this focus can be used
	var/max_uses
	///How many times this focus has been used
	var/uses = 0
	///The max frequency that this can be used per second
	var/max_use_frequency = 1.5

/obj/effect/hallucination/simple/progress_focus/Initialize(mapload, mob/target_mob, datum/progressbar/target_bar, bonus_time, f_sound)
	. = ..()
	target = target_mob
	linked_bar = target_bar
	time_per_click = bonus_time
	if (f_sound)
		focus_sound = pick(f_sound)
	if(type != /obj/effect/hallucination/simple/progress_focus/skillcheck)
		build_extra_effect() //called in progressbars.dm

/obj/effect/hallucination/simple/progress_focus/proc/build_extra_effect(targeted)
	extra_effect = new /obj/effect/hallucination/simple/progress_trap(get_turf(src), target, linked_bar, time_per_click)

/obj/effect/hallucination/simple/progress_focus/attackby(obj/item/I, mob/user, params)
	. = ..()
	on_boost(user)

/obj/effect/hallucination/simple/progress_focus/proc/on_boost(mob/user)
	user.playsound_local(user, focus_sound, 100, TRUE)
	linked_bar.boost_progress(time_per_click)
	var/new_x = rand(-12,12)
	var/new_y = rand(-12,12)
	update_icon(image_state, image_icon, new_px = new_x, new_py = new_y)
	extra_effect.update_icon(extra_effect.image_state, extra_effect.image_icon, new_px = new_x, new_py = new_y)

/obj/effect/hallucination/simple/progress_focus/Destroy()
	. = ..()
	QDEL_NULL(extra_effect)

/obj/effect/hallucination/simple/progress_trap
	name = ""
	desc = ""
	image_icon = 'icons/effects/interactive.dmi'
	image_state = "progress_trap"
	image_layer = ABOVE_HUD_PLANE
	///The progress bar that this booster is linked to
	var/datum/progressbar/linked_bar
	///How much this focus hurts overall progress
	var/loss_per_click

/obj/effect/hallucination/simple/progress_trap/Initialize(mapload, mob/target_mob, datum/progressbar/target_bar, time_delta)
	. = ..()
	target = target_mob
	linked_bar = target_bar
	loss_per_click = -1 * time_delta

/obj/effect/hallucination/simple/progress_trap/attackby(obj/item/I, mob/user, params)
	. = ..()
	linked_bar.boost_progress(loss_per_click)
	user.playsound_local(user, 'sound/machines/buzz-sigh.ogg', 20, TRUE)

/obj/effect/hallucination/simple/progress_focus/skillcheck
	name = "skill check"
	desc = "If I get my timing right, I could get my work done a little more efficiently."
	image_state = "skill_ring"
	max_use_frequency = 2.5
	image_layer = HUD_PLANE
	var/start_time
	var/spin_speed = 0.5 SECONDS

/obj/effect/hallucination/simple/progress_focus/skillcheck/Initialize(mapload, mob/target_mob, datum/progressbar/target_bar, bonus_time, f_sound)
	. = ..()
	start_time = REALTIMEOFDAY

/obj/effect/hallucination/simple/progress_focus/skillcheck/build_extra_effect(atom/targeted)
	extra_effect = new /obj/effect/hallucination/simple/skill_marker(targeted.loc, target)
	extra_effect.SpinAnimation(spin_speed, -1)
	if(isitem(targeted))
		extra_effect.pixel_x = targeted.pixel_x
		extra_effect.pixel_y = targeted.pixel_y + 40

/obj/effect/hallucination/simple/progress_focus/skillcheck/on_boost(mob/user)
	var/current_time = REALTIMEOFDAY

	var/time_diff = (current_time - start_time) % spin_speed
	var/degrees = time_diff * 360/spin_speed
	var/obj/effect/hallucination/simple/skill_marker/temp_effect = new(src.loc, target)
	temp_effect.pixel_y = src.pixel_y
	temp_effect.pixel_x = src.pixel_x
	temp_effect.transform = matrix().Turn(degrees)
	QDEL_IN(temp_effect, spin_speed)
	if (time_diff > (spin_speed/2 * 0.6) && time_diff < spin_speed - (spin_speed/2 * 0.6))
		linked_bar.boost_progress(time_per_click)
		playsound(user, focus_sound, 50, TRUE)
	else
		linked_bar.boost_progress(-1 * time_per_click)
		user.playsound_local(user, 'sound/machines/buzz-sigh.ogg', 20, TRUE)

/obj/effect/hallucination/simple/skill_marker
	name = ""
	desc = ""
	image_icon = 'icons/effects/interactive.dmi'
	image_state = "skill_arrow"
	image_plane = ABOVE_GAME_PLANE
	image_layer = ABOVE_HUD_PLANE
*/

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
 * Bonus percentage, if set to something other than 0, is the percentage of the delay that can be "skipped" with a progressbar_booster. Ranges from 0 (not created) to 100 (one booster will complete the do_after immediately).
 * Focus frequency allows you to have faster/slower progressbar_boosters.
 * Focus sound and Focus fail sound is played to the user on a successful/unsuccessful hit.
 */
/proc/do_after(mob/user, delay, atom/target, do_flags = DO_DEFAULT, incapacitation_flags = INCAPACITATION_DEFAULT, datum/callback/extra_checks, interaction_key, max_interact_count = 1, bonus_percentage = 0, focus_frequency = 1 SECOND, focus_sound = 'sounds/machines/click.ogg', focus_fail_sound = 'sounds/machines/buzz-sigh.ogg')
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
		bar = new /datum/progressbar(user, delay, target || user, (do_flags & DO_SHOW_TARGET), bonus_percentage, focus_frequency, focus_sound, focus_fail_sound)

	SEND_SIGNAL(user, COMSIG_DO_AFTER_BEGAN)

	var/start_time = world.time
	var/end_time = start_time + delay

	var/bonus_time = 0

	. = TRUE

	while (world.time + bonus_time < end_time)
		stoplag(1)
		if(!QDELETED(bar))
			bonus_time = bar.bonus_progress
			bar.update(world.time + bonus_time - start_time)

		// non-target reliant
		if(QDELETED(user)\
			|| (target_type && QDELETED(target))\
			|| user.incapacitated(incapacitation_flags)\
			|| (!(do_flags & DO_USER_CAN_MOVE) && (user_loc != user.loc))\
			|| (!(do_flags & DO_USER_CAN_TURN) && (user_dir != user.dir))\
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

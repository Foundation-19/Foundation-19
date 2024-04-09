#define PROGRESSBAR_HEIGHT 6
#define PROGRESSBAR_ANIMATION_TIME 5

/datum/progressbar
	///The progress bar visual element.
	var/image/bar
	///The progress bar visual element - but for the target.
	var/image/targetbar
	///The target where this progress bar is applied and where it is shown.
	var/atom/target
	///Whether the target should be shown a bar as well
	var/show_target
	///The target's client, if applicable. Only set if the target is intended to see the progress bar as well.
	var/client/target_client
	///The mob whose client sees the progress bar.
	var/mob/user
	///The client seeing the progress bar.
	var/client/user_client
	///Effectively the number of steps the progress bar will need to do before reaching completion.
	var/goal = 1
	///Control check to see if the progress was interrupted before reaching its goal.
	var/last_progress = 0
	///Variable to ensure smooth visual stacking on multiple progress bars.
	var/client_listindex = 0
	///Variable to ensure smooth visual stacking on multiple progress bars - but for the target.
	var/target_listindex = 0
	///An optional, clickable object that can be used to speed up progress bars
	var/datum/progbar_booster_manager/booster
	///How much bonus progress we've accured from a linked progress booster
	var/bonus_progress = 0

/datum/progressbar/New(mob/_user, goal_number, atom/_target, _show_target = FALSE, bonus_percentage, focus_frequency, focus_sound, focus_fail_sound)
	. = ..()
	if (!istype(_target))
		crash_with("Invalid target [_target] passed in")
		qdel(src)
		return
	if(QDELETED(_user) || !istype(_user))
		crash_with("a /datum/progressbar was created with [isnull(_user) ? "null" : "invalid"] user")
		qdel(src)
		return
	if(!isnum(goal_number))
		crash_with("a /datum/progressbar was created with [isnull(goal_number) ? "null" : "invalid"] goal_number")
		qdel(src)
		return
	goal = goal_number
	target = _target
	show_target = _show_target
	bar = image('icons/hud/progressbar.dmi', target, "prog_bar_0")
	bar.plane = ABOVE_HUD_PLANE
	bar.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA

	user = _user

	LAZYADDASSOCLIST(user.progressbars, target, src)
	var/list/bars = user.progressbars[target]
	client_listindex = bars.len

	if(user.client)
		user_client = user.client
		add_prog_bar_image_to_user()
	if(bonus_percentage)
		booster = new(src, bonus_percentage, focus_frequency, focus_sound, focus_fail_sound)

	RegisterSignal(user, COMSIG_PARENT_QDELETING, PROC_REF(on_user_delete))
	RegisterSignal(user, COMSIG_MOB_LOGOUT, PROC_REF(clean_user_client))
	RegisterSignal(user, COMSIG_MOB_LOGIN, PROC_REF(on_user_login))

	if(show_target && (target != user))
		targetbar = image('icons/hud/progressbar_target.dmi', target, "prog_bar_0")
		targetbar.plane = ABOVE_HUD_PLANE
		targetbar.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA

		LAZYADDASSOCLIST(target.progressbars_recipient, user, src)
		var/list/targ_bars = target.progressbars_recipient[user]
		target_listindex = targ_bars.len

		if(target.get_client())
			target_client = target.get_client()
			add_prog_bar_image_to_target()

		RegisterSignal(target, COMSIG_PARENT_QDELETING, PROC_REF(on_target_delete))
		RegisterSignal(target, COMSIG_MOB_LOGOUT, PROC_REF(clean_target_client))
		RegisterSignal(target, COMSIG_MOB_LOGIN, PROC_REF(on_target_login))


/datum/progressbar/Destroy()
	if(user)
		for(var/pb in user.progressbars[target])
			var/datum/progressbar/progress_bar = pb
			if(progress_bar == src || progress_bar.client_listindex <= client_listindex)
				continue
			progress_bar.client_listindex--

			progress_bar.bar.pixel_y = 32 + (PROGRESSBAR_HEIGHT * (progress_bar.client_listindex - 1))
			var/dist_to_travel = 32 + (PROGRESSBAR_HEIGHT * (progress_bar.client_listindex - 1)) - PROGRESSBAR_HEIGHT
			animate(progress_bar.bar, pixel_y = dist_to_travel, time = PROGRESSBAR_ANIMATION_TIME, easing = SINE_EASING)

		LAZYREMOVEASSOC(user.progressbars, target, src)

		if(show_target && (target != user))
			for(var/pb in target.progressbars_recipient[user])
				var/datum/progressbar/progress_bar = pb
				if(progress_bar == src || progress_bar.target_listindex <= target_listindex)
					continue
				progress_bar.target_listindex--

				progress_bar.targetbar.pixel_y = 32 + (PROGRESSBAR_HEIGHT * (progress_bar.target_listindex - 1))
				var/dist_to_travel = 32 + (PROGRESSBAR_HEIGHT * (progress_bar.target_listindex - 1)) - PROGRESSBAR_HEIGHT
				animate(progress_bar.targetbar, pixel_y = dist_to_travel, time = PROGRESSBAR_ANIMATION_TIME, easing = SINE_EASING)

			LAZYREMOVEASSOC(target.progressbars_recipient, target, src)
			target = null

		user = null

	if(user_client)
		clean_user_client()

	if(target_client)
		clean_target_client()

	target = null

	if(bar)
		QDEL_NULL(bar)

	QDEL_NULL(booster)

	return ..()

///Called right before the user's Destroy()
/datum/progressbar/proc/on_user_delete(datum/source)
	SIGNAL_HANDLER

	user.progressbars = null //We can simply nuke the list and stop worrying about updating other prog bars if the user itself is gone.
	user = null
	qdel(src)

///Removes the progress bar image from the user_client and nulls the variable, if it exists.
/datum/progressbar/proc/clean_user_client(datum/source)
	SIGNAL_HANDLER

	if(!user_client) //Disconnected, already gone.
		return
	user_client.images -= bar
	user_client = null

///Called by user's Login(), it transfers the progress bar image to the new client.
/datum/progressbar/proc/on_user_login(datum/source)
	SIGNAL_HANDLER

	if(user_client)
		if(user_client == user.client) //If this was not client handling I'd condemn this sanity check. But clients are fickle things.
			return
		clean_user_client()
	if(!user.client) //Clients can vanish at any time, the bastards.
		return
	user_client = user.client
	add_prog_bar_image_to_user()

///Called right before the target's Destroy()
/datum/progressbar/proc/on_target_delete(datum/source)
	SIGNAL_HANDLER

	target.progressbars_recipient = null //We can simply nuke the list and stop worrying about updating other prog bars if the user itself is gone.
	user = null
	qdel(src)

///Removes the progress bar image from the target_client and nulls the variable, if it exists.
/datum/progressbar/proc/clean_target_client(datum/source)
	SIGNAL_HANDLER

	if(!target_client) //Disconnected, already gone.
		return
	target_client.images -= targetbar
	target_client = null

///Called by target's Login(), it transfers the progress bar image to the new client.
/datum/progressbar/proc/on_target_login(datum/source)
	SIGNAL_HANDLER

	if(target_client)
		if(target_client == target.get_client()) //If this was not client handling I'd condemn this sanity check. But clients are fickle things.
			return
		clean_user_client()
	if(!target.get_client()) //Clients can vanish at any time, the bastards.
		return
	target_client = target.get_client()
	add_prog_bar_image_to_target()

///Adds a smoothly-appearing progress bar image to the user's screen.
/datum/progressbar/proc/add_prog_bar_image_to_user()
	bar.pixel_y = 0
	bar.alpha = 0
	user_client.images += bar
	animate(bar, pixel_y = 32 + (PROGRESSBAR_HEIGHT * (client_listindex - 1)), alpha = 255, time = PROGRESSBAR_ANIMATION_TIME, easing = SINE_EASING)

///Adds a smoothly-appearing progress bar image to the target's screen.
/datum/progressbar/proc/add_prog_bar_image_to_target()
	targetbar.pixel_y = 0
	targetbar.alpha = 0
	target_client.images += bar
	animate(targetbar, pixel_y = 32 + (PROGRESSBAR_HEIGHT * (client_listindex - 1)), alpha = 255, time = PROGRESSBAR_ANIMATION_TIME, easing = SINE_EASING)

///Updates the progress bar image visually.
/datum/progressbar/proc/update(progress)
	progress = clamp(progress, 0, goal)
	if(progress == last_progress)
		return
	last_progress = progress
	bar.icon_state = "prog_bar_[round(((progress / goal) * 100), 5)]"
	if(targetbar)
		targetbar.icon_state = bar.icon_state

///Boost the current progress by a specific amount
/datum/progressbar/proc/boost_progress(amount)
	bonus_progress += amount

///Called on progress end, be it successful or a failure. Wraps up things to delete the datum and bar.
/datum/progressbar/proc/end_progress()
	if(last_progress < goal)
		bar.icon_state = "[bar.icon_state]_fail"
	QDEL_NULL(booster)

	animate(bar, alpha = 0, time = PROGRESSBAR_ANIMATION_TIME)

	if(targetbar)
		targetbar.icon_state = bar.icon_state

		animate(targetbar, alpha = 0, time = PROGRESSBAR_ANIMATION_TIME)

	QDEL_IN(src, PROGRESSBAR_ANIMATION_TIME)


#undef PROGRESSBAR_ANIMATION_TIME
#undef PROGRESSBAR_HEIGHT

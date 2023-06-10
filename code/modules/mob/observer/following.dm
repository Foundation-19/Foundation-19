/mob/observer
	var/atom/following

/mob/observer/Destroy()
	. = ..()
	stop_following()

/mob/observer/proc/stop_following()
	if(!following)
		return
	UnregisterSignal(following, COMSIG_PARENT_QDELETING)
	UnregisterSignal(following, COMSIG_MOVED)
	GLOB.dir_set_event.unregister(following, src)
	following = null

/mob/observer/proc/start_following(atom/a)
	stop_following()
	following = a
	RegisterSignal(a, COMSIG_PARENT_QDELETING, .proc/stop_following)
	RegisterSignal(a, COMSIG_MOVED, .proc/keep_following)
	GLOB.dir_set_event.register(a, src, /atom/proc/recursive_dir_set)
	keep_following(new_loc = get_turf(following))

/mob/observer/proc/keep_following(atom/movable/moving_instance, atom/old_loc, atom/new_loc)
	forceMove(get_turf(new_loc))

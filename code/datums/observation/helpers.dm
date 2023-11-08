/atom/movable/proc/recursive_move(atom/movable/am, old_loc, new_loc)
	SEND_SIGNAL(src, COMSIG_MOVED, old_loc, new_loc)

/atom/movable/proc/move_to_turf(atom/movable/am, old_loc, new_loc)
	var/turf/T = get_turf(new_loc)
	if(T && T != loc)
		forceMove(T)

// Similar to above but we also follow into nullspace
/atom/movable/proc/move_to_turf_or_null(atom/movable/am, old_loc, new_loc)
	var/turf/T = get_turf(new_loc)
	if(T != loc)
		forceMove(T)

/atom/movable/proc/move_to_loc_or_null(atom/movable/am, old_loc, new_loc)
	if(new_loc != loc)
		forceMove(new_loc)

/atom/proc/recursive_dir_set(atom/a, old_dir, new_dir)
	set_dir(new_dir)

// Sometimes you just want to end yourself
/datum/proc/qdel_self()
	qdel(src)

/proc/register_all_movement(event_source, datum/listener)
	listener.RegisterSignal(event_source, COMSIG_MOVED, /atom/movable/proc/recursive_move)
	listener.RegisterSignal(event_source, COMSIG_DIR_SET, /atom/proc/recursive_dir_set)

/proc/unregister_all_movement(event_source, datum/listener)
	listener.UnregisterSignal(event_source, COMSIG_MOVED)
	listener.UnregisterSignal(event_source, COMSIG_DIR_SET)

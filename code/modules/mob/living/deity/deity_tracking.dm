/mob/living/deity/verb/jump_to_follower()
	set category = "Godhood"

	if(!minions)
		return

	var/list/could_follow = list()
	for(var/m in minions)
		var/datum/mind/M = m
		if(M.current && M.current.stat != DEAD)
			could_follow += M.current

	if(!could_follow.len)
		return

	var/choice = input(src, "Jump to follower", "Teleport") as null|anything in could_follow
	if(choice)
		follow_follower(choice)

/mob/living/deity/proc/follow_follower(mob/living/L)
	if(!L || L.stat == DEAD || !is_follower(L, silent=1))
		return
	if(following)
		stop_follow()
	eyeobj.setLoc(get_turf(L))
	to_chat(src, SPAN_NOTICE("You begin to follow \the [L]."))
	following = L
	RegisterSignal(L, COMSIG_MOVED, TYPE_PROC_REF(/mob/living/deity, keep_following))
	RegisterSignal(L, COMSIG_PARENT_QDELETING, TYPE_PROC_REF(/mob/living/deity, stop_follow))
	RegisterSignal(L, COMSIG_ADD_TO_DEAD_MOB_LIST, TYPE_PROC_REF(/mob/living/deity, stop_follow))

/mob/living/deity/proc/stop_follow()
	UnregisterSignal(following, COMSIG_MOVED)
	UnregisterSignal(following, COMSIG_PARENT_QDELETING)
	UnregisterSignal(following, COMSIG_ADD_TO_DEAD_MOB_LIST)
	to_chat(src, SPAN_NOTICE("You stop following \the [following]."))
	following = null

/mob/living/deity/proc/keep_following(atom/movable/moving_instance, atom/old_loc, atom/new_loc)
	eyeobj.setLoc(new_loc)

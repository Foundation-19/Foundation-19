/mob/observer/virtual/mob
	host_type = /mob

/mob/observer/virtual/mob/New(location, mob/host)
	..()

	RegisterSignal(host, COMSIG_SET_SIGHT, TYPE_PROC_REF(/mob/observer/virtual/mob, sync_sight))
	RegisterSignal(host, COMSIG_SET_SEE_INVISIBLE, TYPE_PROC_REF(/mob/observer/virtual/mob, sync_sight))
	RegisterSignal(host, COMSIG_SET_SEE_IN_DARK, TYPE_PROC_REF(/mob/observer/virtual/mob, sync_sight))

	sync_sight(host)

/mob/observer/virtual/mob/Destroy()
	UnregisterSignal(host, COMSIG_SET_SIGHT)
	UnregisterSignal(host, COMSIG_SET_SEE_INVISIBLE)
	UnregisterSignal(host, COMSIG_SET_SEE_IN_DARK)
	. = ..()

/mob/observer/virtual/mob/proc/sync_sight(mob/mob_host)
	sight = mob_host.sight
	see_invisible = mob_host.see_invisible
	see_in_dark = mob_host.see_in_dark

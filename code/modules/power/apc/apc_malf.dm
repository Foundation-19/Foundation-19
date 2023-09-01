// Malfunction: Transfers APC under AI's control
/obj/machinery/power/apc/proc/ai_hack(mob/living/silicon/ai/A = null)
	if(!A || !A.hacked_apcs || hacker || aidisabled || A.stat == DEAD)
		return 0
	src.hacker = A
	A.hacked_apcs += src
	locked = 1
	update_icon()
	return 1

/obj/machinery/power/apc/malf_upgrade(mob/living/silicon/ai/user)
	..()
	malf_upgraded = 1
	to_chat(user, "\The [src] has been upgraded. It is now protected against EMPs.")
	return 1

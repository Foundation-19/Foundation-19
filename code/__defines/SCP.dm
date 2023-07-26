#define SCP_096 "096"


/mob/proc/is_scp012_affected()
	if (ishuman(src) && locate(/obj/item/paper/scp012) in view(2, src))
		for (var/obj/item/paper/scp012/scp012 in view(2, src))
			if (scp012.can_affect(src))
				return TRUE
	return FALSE

#define SCP_096 "096"


/mob/proc/is_scp012_affected(turf/target)
	if (!target)
		target = get_turf(src)
	if (ishuman(src) && locate(/obj/item/paper/scp012) in view(2, src))
		for (var/obj/item/paper/scp012/scp012 in view(2, target))
			if (scp012.can_affect(src))
				return TRUE
	return FALSE



/mob/living
	var/datum/scp_containment_system/scp_containment_system

/mob/living/proc/setup_containment_system()
	if(!scp_containment_system && SCP)
		scp_containment_system = new /datum/scp_containment_system(src)
	return scp_containment_system

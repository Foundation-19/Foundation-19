/obj/machinery/merchant_pad
	name = "Teleportation Pad"
	desc = "Place things here to trade."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "tele0"
	anchored = TRUE
	density = FALSE

/obj/machinery/merchant_pad/proc/get_target()
	var/turf/T = get_turf(src)
	for(var/a in T)
		if(a == src || (!istype(a,/obj) && !istype(a,/mob/living)) || istype(a,/obj/effect) || istype(a,/turf))
			continue
		return a

/obj/machinery/merchant_pad/proc/get_targets()
	var/list/targets = list()
	var/turf/T = get_turf(src)
	for(var/a in T)
		if(a == src || (!istype(a,/obj) && !istype(a,/mob/living)) || istype(a,/obj/effect) || istype(a,/turf))
			continue
		if(istype(a,/obj))
			var/obj/O = a
			if(O.anchored)
				continue
		targets += a
	return targets
/obj/structure/anomaly_container
	name = "anomaly container"
	desc = "Used to safely contain and move anomalies."
	icon = 'icons/obj/xenoarchaeology.dmi'
	icon_state = "anomaly_container"
	density = TRUE

	var/obj/machinery/artifact/contained

/obj/structure/anomaly_container/Initialize()
	. = ..()

	var/obj/machinery/artifact/A = locate() in loc
	if(A)
		contain(A)

/obj/structure/anomaly_container/attack_hand(mob/user)
	release(user)

/obj/structure/anomaly_container/attack_robot(mob/user)
	if(Adjacent(user))
		release(user)

/obj/structure/anomaly_container/proc/contain(obj/machinery/artifact/artifact, mob/user)
	if(contained)
		return
	contained = artifact
	artifact.forceMove(src)
	underlays += image(artifact)
	desc = "Used to safely contain and move anomalies. \The [contained] is kept inside."
	playsound(loc, 'sound/machines/bolts_down.ogg', 50, 1)
	if(user)
		user.visible_message(SPAN_NOTICE("[user] puts [artifact] into \the [src]."), SPAN_NOTICE("You put [artifact] into \the [src]."))

/obj/structure/anomaly_container/proc/release(mob/user)
	if(!contained)
		return
	contained.dropInto(src)
	contained = null
	underlays.Cut()
	desc = initial(desc)
	playsound(loc, 'sound/machines/bolts_up.ogg', 50, 1)
	if(user)
		user.visible_message(SPAN_NOTICE("[user] opens \the [src]."), SPAN_NOTICE("You open \the [src]."))

/obj/machinery/artifact/MouseDrop(obj/structure/anomaly_container/over_object)
	if(istype(over_object) && Adjacent(over_object) && CanMouseDrop(over_object, usr))
		Bumped(usr)
		over_object.contain(src, usr)

/obj/structure/deity/trap
	density = FALSE
	health = 1
	var/triggered = 0

/obj/structure/deity/trap/New()
	..()
	RegisterSignal(get_turf(src), COMSIG_ENTERED, TYPE_PROC_REF(/obj/structure/deity/trap, trigger))

/obj/structure/deity/trap/Destroy()
	UnregisterSignal(get_turf(src), COMSIG_ENTERED)
	return ..()

/obj/structure/deity/trap/Move()
	UnregisterSignal(get_turf(src), COMSIG_ENTERED)
	. = ..()
	RegisterSignal(get_turf(src), COMSIG_ENTERED, TYPE_PROC_REF(/obj/structure/deity/trap, trigger))

/obj/structure/deity/trap/attackby(obj/item/W as obj, mob/user as mob)
	trigger(user)
	return ..()

/obj/structure/deity/trap/bullet_act()
	return

/obj/structure/deity/trap/proc/trigger(atom/entered, atom/movable/enterer)
	if(triggered > world.time || !istype(enterer, /mob/living))
		return

	triggered = world.time + 30 SECONDS

// Result of running a circuitboard through SCP-914 on Very Fine
/obj/item/machine_builder
	name = "automatic circuit board"
	desc = "An advanced and alien design resembling a normal circuit board. Seems like you should just touch the floor with it..?"
	icon = 'icons/obj/module.dmi'
	icon_state = "id_mod_electric"
	item_state = "electronic"
	origin_tech = list(TECH_ENGINEERING = 6, TECH_MAGNET = 4, TECH_DATA = 6)
	w_class = ITEM_SIZE_SMALL
	obj_flags = OBJ_FLAG_CONDUCTIBLE
	force = 5.0
	throwforce = 5.0
	throw_speed = 3
	throw_range = 15
	var/machine_type = null

/obj/item/machine_builder/examine(mob/user)
	. = ..()
	if(ispath(machine_type, /obj/machinery))
		var/obj/machinery/M = machine_type
		to_chat(user, SPAN_NOTICE("This circuit board is used for construction of \a <b>[initial(M.machine_name)]</b>."))

/obj/item/machine_builder/afterattack(turf/T, mob/user, proximity)
	if(!proximity)
		return
	if(!machine_type)
		to_chat(user, SPAN_WARNING("This particular [src] is unable to construct anything!"))
		return
	if(!istype(T) || T.density)
		to_chat(user, SPAN_WARNING("\The [src] must be used on an open floor!"))
		return
	var/obj/machinery/M = new machine_type(T)
	T.visible_message(SPAN_NOTICE("In a blink of an eye, \a [M.name] appears from \the [src]!"))
	playsound(src, 'sounds/items/rped.ogg', 50, TRUE)
	qdel(src)

// Coarse - Returns everything within the machine
// 1:1 - Just spawns the machine... Idiot.
/obj/item/machine_builder/Conversion914(mode = MODE_ONE_TO_ONE, mob/user = usr)
	switch(mode)
		if(MODE_COARSE)
			var/obj/machinery/M = new machine_type(src)
			for(var/atom/movable/A in M)
				A.forceMove(get_turf(src))
				A.pixel_x += rand(-8, 8)
				A.pixel_y += rand(-8, 8)
			qdel(M)
			return null
		if(MODE_ONE_TO_ONE)
			return machine_type
	return ..()

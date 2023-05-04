/obj/machinery/contraband_detector
	name = "contraband detector"
	desc = "A metal detector that reports any illicit items to security."
	icon = 'icons/obj/machines/contraband_detector.dmi'
	icon_state = "powered"
	anchored = TRUE
	density = FALSE
	idle_power_usage = 50
	active_power_usage = 150

	req_access = list(list(ACCESS_SECURITY_LVL2))
	var/id_locked = TRUE
	var/wrenching = FALSE
	var/obj/item/device/radio/intercom/announce

	wires = /datum/wires/contraband_detector
	var/power_wire_cut = FALSE				// if cut... no power. also electrifies cutter, so there's some danger here
	var/identifier_wire_cut = FALSE			// if cut, registers nothing as contraband. if pulsed, registers everything
	var/identifier_wire_pulsed_until = 0	// world time value, since it's only checked in 1 place we don't remove it when time has passed (more optimal than checking every tick)
	var/radio_wire_cut = FALSE				// if cut, removes ability to radio

/obj/machinery/contraband_detector/New()
	announce = new /obj/item/device/radio/intercom(src)
	announce.internal_channels = list(num2text(SEC_LCZ_FREQ) = list(ACCESS_SECURITY_LVL2))
	. = ..()
	if(anchored)
		RegisterSignal(loc, COMSIG_TURF_CROSSED, .proc/detect_contraband)

/obj/machinery/contraband_detector/Initialize()
	. = ..()
	announce.internal_channels = list(num2text(SEC_LCZ_FREQ) = list(ACCESS_SECURITY_LVL2))
	announce.set_frequency(SEC_LCZ_FREQ)

/obj/machinery/contraband_detector/set_broken()
	. = ..()
	announce_tampering()

/obj/machinery/contraband_detector/ex_act(severity)
	. = ..()
	if(prob(100 - (severity * 20)))
		src.set_broken(TRUE)


/obj/machinery/contraband_detector/proc/detect_contraband(turf/T, atom/movable/A)
	if(!identifier_wire_cut && (((identifier_wire_pulsed_until < world.time) && identifier_wire_pulsed_until != 0) || A.has_contraband()))
		flick("detected", src)
		visible_message(SPAN_WARNING("\The [src] detects contraband on \the [A.name]!"))
		if(!radio_wire_cut)
			var/area/AR = get_area(src)
			announce.autosay("Contraband detected on \the [A] at \the [AR.name]!", "Contraband Detection System")	// this function is costly as FUCK right now, please fix ASAP

/obj/machinery/contraband_detector/proc/announce_tampering()
	var/area/AR = get_area(src)
	announce.autosay("ALERT! Tampering detected on \the [src] at [AR.name]!", "Contraband Detection System")

/obj/machinery/contraband_detector/powered()
	if(power_wire_cut)
		return FALSE
	return ..()

/obj/machinery/contraband_detector/on_update_icon()
	if(stat & BROKEN)
		icon_state = "broken"
	else if(stat & NOPOWER)
		icon_state = "unpowered"
	else
		icon_state = "powered"

/obj/machinery/contraband_detector/attackby(obj/item/I, mob/user)
	if(isScrewdriver(I))
		if(id_locked && !panel_open)	// you can close it when ID locked, just not open it
			to_chat(user, SPAN_NOTICE("\The [src]'s panel is locked!"))
		else
			panel_open = !panel_open
			user.visible_message(SPAN_WARNING("[user] screws the camera's panel [panel_open ? "open" : "closed"]!"),
			SPAN_NOTICE("You screw the camera's panel [panel_open ? "open" : "closed"]."))
			playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
	if((isWirecutter(I) || isMultitool(I)) && panel_open)
		return wires.Interact(user)
	if(isWrench(I))
		if(id_locked)
			to_chat(user, SPAN_WARNING("You cannot unsecure a locked contraband detector!"))
			return
		if(wrenching)
			to_chat(user, SPAN_WARNING("Someone is already [anchored ? "un" : ""]securing the detector!"))
			return
		if(!anchored && isinspace())
			to_chat(user, SPAN_WARNING("Cannot secure detectors in space!"))
			return

		user.visible_message(SPAN_WARNING("[user] begins [anchored ? "un" : ""]securing the contraband detector."), \
			SPAN_NOTICE("You begin [anchored ? "un" : ""]securing the contraband detector."))

		wrenching = TRUE
		if(do_after(user, 10 SECONDS, src))
			if(!anchored)
				playsound(loc, 'sound/items/Ratchet.ogg', 100, 1)
				anchored = TRUE
				update_icon()
				to_chat(user, SPAN_NOTICE("You secure the exterior bolts on the contraband detector."))
				RegisterSignal(loc, COMSIG_TURF_CROSSED, .proc/detect_contraband)
			else if(anchored)
				playsound(loc, 'sound/items/Ratchet.ogg', 100, 1)
				anchored = FALSE
				to_chat(user, SPAN_NOTICE("You unsecure the exterior bolts on the contraband detector."))
				update_icon()
				UnregisterSignal(loc, COMSIG_TURF_CROSSED)
		wrenching = FALSE
	if(istype(I, /obj/item/card/id) || istype(I, /obj/item/modular_computer))
		if(emagged)
			to_chat(user, SPAN_NOTICE("You try to swipe your ID, but \the [src]'s slot seems to be... smoking?"))
		else
			if(src.allowed(usr))
				to_chat(user, SPAN_NOTICE("You [id_locked ? "disable" : "enable"] the ID lock on \the [src]."))
				id_locked = !id_locked
			else
				to_chat(user, SPAN_WARNING("\The [src] denies your ID!"))
	if(panel_open && isCrowbar(I))
		user.visible_message(SPAN_WARNING("[user] begins deconstructing the contraband detector!"), SPAN_NOTICE("You begin prying out the proximity sensor."))
		if(do_after(user, 15 SECONDS))
			var/obj/machinery/contraband_detector_construct/construct = new (loc)	// create the detector
			construct.build_step = 4
			construct.desc = "You can put a proximity sensor in \the [src], or cut the wires out with a wirecutter."
			qdel(src)	// qdel
			return
	return ..()

/obj/machinery/contraband_detector/emag_act(remaining_charges, mob/user)
	if(!emagged)
		to_chat(user, SPAN_WARNING("You short circuit [src]'s ID locking systems."))
		id_locked = FALSE
		emagged = TRUE
		return 1

// CONSTRUCTION

/obj/machinery/contraband_detector_construct
	name = "contraband detector shell"
	desc = "You can anchor the shell down with a wrench, or dismantle it with a crowbar."
	icon = 'icons/obj/machines/contraband_detector.dmi'
	icon_state = "shell"
	density = TRUE
	var/build_step = 0										// the current step in the building process

/obj/machinery/contraband_detector_construct/attackby(obj/item/I, mob/user)
	//this is a bit unwieldy but self-explanatory
	switch(build_step)
		if(0)	//first step
			if(isWrench(I) && !anchored)
				playsound(loc, 'sound/items/Ratchet.ogg', 100, 1)
				to_chat(user, SPAN_NOTICE("You secure the external bolts."))
				anchored = TRUE
				build_step = 1
				desc = "You can put some steel rods in \the [src], or unsecure it with a wrench."
				return

			else if(isCrowbar(I) && !anchored)
				playsound(loc, 'sound/items/Crowbar.ogg', 75, 1)
				to_chat(user, SPAN_NOTICE("You dismantle the construction."))
				new /obj/item/stack/material/steel(loc, 3)
				qdel(src)
				return
		if(1)
			if(istype(I, /obj/item/stack/material/rods) && I.get_material_name() == MATERIAL_STEEL)
				var/obj/item/stack/M = I
				if(M.use(2))
					to_chat(user, SPAN_NOTICE("You add some rods to the detectors frame."))
					build_step = 2
					desc = "You can wrench the rods into \the [src], or pull them out."
					icon_state = "shell_rodded"
				else
					to_chat(user, SPAN_WARNING("You need two rods to continue construction."))
				return
			else if(isWrench(I))
				playsound(loc, 'sound/items/Ratchet.ogg', 75, 1)
				to_chat(user, SPAN_NOTICE("You unfasten the external bolts."))
				anchored = FALSE
				build_step = 0
				desc = "You can anchor the shell down with a wrench, or dismantle it with a crowbar."
				return
		if(2)
			if(isWrench(I))
				playsound(loc, 'sound/items/Ratchet.ogg', 100, 1)
				to_chat(user, SPAN_NOTICE("You bolt the rods into place."))
				build_step = 3
				desc = "You can wire up \the [src], or unwrench the rods."
				return

			//attack_hand() removes the rods
		if(3)
			if(isCoil(I))
				var/obj/item/stack/M = I
				if(M.use(2))
					to_chat(user, SPAN_NOTICE("You add some wiring to the detectors frame."))
					build_step = 4
					desc = "You can put a proximity sensor in \the [src], or cut the wires out with a wirecutter."
				else
					to_chat(user, SPAN_WARNING("You need two lengths of wire to continue construction."))
				return
			else if(isWrench(I))
				playsound(loc, 'sound/items/Ratchet.ogg', 100, 1)
				to_chat(user, SPAN_NOTICE("You unbolt the rods."))
				build_step = 2
				desc = "You can wrench the rods into \the [src], or pull them out."
				return
		if(4)
			if(isprox(I))
				if(!user.unEquip(I))
					to_chat(user, SPAN_NOTICE("\the [I] is stuck to your hand, you cannot put it in \the [src]"))
					return
				to_chat(user, SPAN_NOTICE("You add the prox sensor to the turret."))
				build_step = 5
				desc = "You can screw the access hatch of \the [src], or pull out the proximity sensor."
				icon_state = "unpowered"
				qdel(I)
				return
			else if(isWirecutter(I))
				to_chat(user, SPAN_NOTICE("You cut the wiring out of the detector frame."))
				new /obj/item/stack/cable_coil(loc, length = 2)
				build_step = 3
				desc = "You can wire up \the [src], or unwrench the rods."
		if(5)
			if(isScrewdriver(I))
				playsound(loc, 'sound/items/Screwdriver.ogg', 100, 1)
				build_step = 6
				to_chat(user, SPAN_NOTICE("You screw in the access hatch."))

				new /obj/machinery/contraband_detector/(loc)	// create the detector
				qdel(src)	// qdel
				return

			//attack_hand() removes the prox sensor

/obj/machinery/contraband_detector_construct/attack_hand(mob/user)
	switch(build_step)
		if(2)
			to_chat(user, SPAN_NOTICE("You remove the metal rods from the detector frame."))
			new /obj/item/stack/material/rods(loc, amount = 2)
			build_step = 1
			desc = "You can put some steel rods in \the [src], or unsecure it with a wrench."
			icon_state = "shell"
			return
		if(5)
			to_chat(user, SPAN_NOTICE("You remove the prox sensor from the detector frame."))
			new /obj/item/device/assembly/prox_sensor(loc)
			build_step = 4
			desc = "You can put a proximity sensor in \the [src], or cut the wires out with a wirecutter."
			icon_state = "shell_rodded"
			return

// CONTRABAND ATOM PROC

/atom/proc/has_contraband() // called on the atom/movable that moved onto the detector's turf. should call recursively to get status of all items.
	if(contents)
		for(var/atom/thing in contents)
			if(thing.has_contraband())
				return TRUE
		return FALSE
	else
		return FALSE

/obj/item/gun/has_contraband()
	return TRUE

/obj/item/wrench/has_contraband()
	return TRUE

/obj/item/weldingtool/has_contraband()
	return TRUE

/obj/item/stack/cable_coil/has_contraband()
	return TRUE

/obj/item/wirecutters/has_contraband()
	return TRUE

/obj/item/screwdriver/has_contraband()
	return TRUE

/obj/item/device/multitool/has_contraband()
	return TRUE

/obj/item/crowbar/has_contraband()
	return TRUE

/obj/item/material/hatchet/has_contraband()
	return TRUE

/obj/item/material/knife/has_contraband()
	return TRUE

/obj/item/material/twohanded/has_contraband()
	return TRUE

/obj/item/material/star/has_contraband()
	return TRUE

/obj/item/material/sword/has_contraband()
	return TRUE

/obj/item/material/shard/has_contraband()
	return TRUE

/obj/item/material/scythe/has_contraband()
	return TRUE

/obj/item/material/hatchet/machete/has_contraband()
	return TRUE

/obj/item/material/harpoon/has_contraband()
	return TRUE

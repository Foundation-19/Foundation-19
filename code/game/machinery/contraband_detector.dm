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
	var/obj/item/device/radio/intercom/announce

	base_type = /obj/machinery/contraband_detector
	construct_state = /decl/machine_construction/default/panel_closed

	var/obj_cooldown = 0	// cooldown for triggering, kept separately so people can't abuse it
	var/mob_cooldown = 0

	wires = /datum/wires/contraband_detector
	var/identifier_wire_pulsed_until = 0	// world time value, since it's only checked in 1 place we don't remove it when time has passed (more optimal than checking every tick)

/obj/machinery/contraband_detector/Initialize()
	. = ..()
	AddElement(/datum/element/connect_loc, list(COMSIG_ENTERED = PROC_REF(detect_contraband)))

	announce = new /obj/item/device/radio/intercom(src)
	announce.internal_channels = list(num2text(SEC_LCZ_FREQ) = list(ACCESS_SECURITY_LVL2))
	announce.set_frequency(SEC_LCZ_FREQ)

/obj/machinery/contraband_detector/Destroy()
	QDEL_NULL(announce)
	return ..()

/obj/machinery/contraband_detector/set_broken(new_state)
	. = ..()
	if(new_state)
		announce_tampering()

/obj/machinery/contraband_detector/ex_act(severity)
	. = ..()
	if(prob(100 - (severity * 20)))
		set_broken(TRUE)

/obj/machinery/contraband_detector/proc/detect_contraband(turf/T, atom/movable/A)	// T isn't used, but it's passed by the signal as first argument
	if(!emagged && (!wires.is_cut(WIRE_CONTRADETECT_IDENTIFIER) && (((identifier_wire_pulsed_until > world.time) && identifier_wire_pulsed_until != 0) || (istype(A) && A.has_contraband()))))
		if(ismob(A))
			if(mob_cooldown < world.time)
				mob_cooldown = world.time + 1 SECOND
			else
				return
		else
			if(obj_cooldown < world.time)
				obj_cooldown = world.time + 2 SECONDS
			else
				return
		flick("detected", src)
		balloon_alert_to_viewers("Contraband detected!")
		if(!wires.is_cut(WIRE_CONTRADETECT_ALARM))
			var/area/AR = get_area(src)
			announce.autosay("Contraband detected on \the [A] at \the [AR.name]!", "Contraband Detection System")

/obj/machinery/contraband_detector/proc/announce_tampering()
	var/area/AR = get_area(src)
	announce.autosay("ALERT! Tampering detected on \the [src] at [AR.name]!", "Contraband Detection System")

/obj/machinery/contraband_detector/powered()
	if(wires.is_cut(WIRE_MAIN_POWER1) || wires.is_cut(WIRE_MAIN_POWER2))
		return FALSE
	return ..()

/obj/machinery/contraband_detector/on_update_icon()
	if(stat & BROKEN)
		icon_state = "broken"
	else if(stat & NOPOWER)
		icon_state = "unpowered"
	else
		icon_state = "powered"

/obj/machinery/contraband_detector/emag_act(remaining_charges, mob/user)
	if(!emagged)
		to_chat(user, SPAN_WARNING("You short circuit [src]'s contraband detection systems."))
		emagged = TRUE
		return 1

// CONTRABAND ATOM PROC

/atom/movable/proc/has_contraband() // called on the atom/movable that moved onto the detector's turf. should call recursively to get status of all items.
	if(contents)
		for(var/atom/movable/thing in contents)
			if(thing.has_contraband())
				return TRUE
		return FALSE
	else
		return FALSE

// NON-CONTRABAND MOBS : mobs that should be ignored (like robots)

/mob/living/silicon/has_contraband()
	return FALSE

// CONTRABAND ITEMS : shit that we count as contraband

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

// UNREAL ITEMS : shit that the scanner shouldn't look at (like ghosts)

/mob/observer/has_contraband()
	return FALSE

/atom/movable/screen/has_contraband()
	return FALSE

/obj/skybox/has_contraband()
	return FALSE

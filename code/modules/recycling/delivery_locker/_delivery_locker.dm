/**
 * A delivery locker. Items (not mobs) can be put into the locker storage.
 * When an ID card is swiped, the contents are scanned, things may happen to the ID card, and the contents are sent into the disposals unit
 * This is good for e.g. paying D-class automatically for materials or artifacts sent to Logistics or Research.
 */
/obj/machinery/delivery_locker
	abstract_type = /obj/machinery/delivery_locker
	base_type = /obj/machinery/delivery_locker	// god i LOVE machines having two different variables that contain base types
	name = "delivery locker"
	desc = "Someone forgot to write a description - contact a coder!"
	icon = 'icons/obj/pipes/delivery.dmi'	// TODO: create GOOD sprites for this
	icon_state = "template"
	anchored = TRUE
	density = TRUE
	/// The attached pipe trunk. Flushed contents get put in a disposalholder that starts here.
	var/obj/structure/disposalpipe/trunk/trunk = null
	/// Set to true while flushing.
	var/flushing = FALSE
	// A list of types. Items may only be stored if they're one of these types
	var/list/acceptable_items = list()

/obj/machinery/delivery_locker/Initialize()
	. = ..()
	if(!length(acceptable_items))
		log_debug("Delivery locker of type [type] has an empty acceptable_items list!")

	spawn(0.5 SECONDS)
		trunk = locate() in get_turf(src)
		if(!trunk)
			// TODO: disable here
		else
			trunk.linked = src	// link the pipe trunk to self

		update_icon()

/obj/machinery/delivery_locker/Destroy()
	eject()
	if(trunk)
		trunk.linked = null
	return ..()

/// Handles (de)construction as well as... putting items into the locker.
/obj/machinery/delivery_locker/attackby(obj/item/I, mob/user)
	if(stat & BROKEN || !I || !user)
		return

	add_fingerprint(user, FALSE, I)

	if(isid(I))
		if(flushing)
			balloon_alert(user, "busy!")
			return

		if(handle_id_card(I))
			flush()
		return

	/* TODO: construction code here
	if(mode<=0) // It's off
		if(isScrewdriver(I))
			if(contents.len > LAZYLEN(component_parts))
				to_chat(user, "Eject the items first!")
				return
			if(mode==0) // It's off but still not unscrewed
				mode=-1 // Set it to doubleoff l0l
				playsound(src, 'sounds/items/Screwdriver.ogg', 50, 1)
				to_chat(user, "You remove the screws around the power connection.")
				return
			else if(mode==-1)
				mode=0
				playsound(src, 'sounds/items/Screwdriver.ogg', 50, 1)
				to_chat(user, "You attach the screws around the power connection.")
				return
		else if(isWelder(I) && mode==-1)
			if(contents.len > LAZYLEN(component_parts))
				to_chat(user, "Eject the items first!")
				return
			var/obj/item/weldingtool/W = I
			if(W.remove_fuel(0,user))
				playsound(src, 'sounds/items/Welder2.ogg', 100, 1)
				to_chat(user, "You start slicing the floorweld off the disposal unit.")

				if(do_after(user, 2.5 SECONDS, src, bonus_percentage = 25))
					if(!src || !W.isOn()) return
					to_chat(user, "You sliced the floorweld off the disposal unit.")
					var/obj/structure/disposalconstruct/machine/C = new (loc, src)
					src.transfer_fingerprints_to(C)
					C.update()
					qdel(src)
				return
			else
				to_chat(user, "You need more welding fuel to complete this task.")
				return
	*/

	if(isrobot(user))
		return

	var/valid = FALSE
	for(var/type in acceptable_items)
		if(istype(I, type))
			valid = TRUE
			break

	if(!valid)
		display_error("invalid item!")
		return

	if(!user.unEquip(I, src))
		return

	user.visible_message("\The [user] places \the [I] into \the [src].", "You place \the [I] into \the [src].")

	update_icon()

/obj/machinery/delivery_locker/MouseDrop_T(atom/movable/AM, mob/user)
	if(istype(AM, /obj/item))
		attackby(AM, user)
		return

/// Ejects the contents of the locker.
/obj/machinery/delivery_locker/proc/eject()
	for(var/atom/movable/AM in (contents - component_parts))
		AM.forceMove(get_turf(src))
		AM.pipe_eject(0)
	update_icon()

/// Handles ID card behavior. Return TRUE if locker should flush. Subtypes must override this.
/obj/machinery/delivery_locker/proc/handle_id_card(obj/item/card/id/id_card)
	crash_with("Delivery locker of type [type] doesn't override handle_id_card().")

/// Flushes the contents of the locker. Called after ID card shenanigans
/obj/machinery/delivery_locker/proc/flush()

	flushing = 1
	flick("[icon_state]-flush", src)
	var/obj/structure/disposalholder/H = new()	// virtual holder object which actually
												// travels through the pipes.

	sleep(1 SECOND)
	playsound(src, 'sounds/machines/disposalflush.ogg', 50, 0, 0)	// TODO: unique sound?
	sleep(0.5 SECONDS) // wait for animation to finish

	H.init(contents - component_parts)	// copy the contents of disposer to holder

	if(!H.start(trunk))
		// we couldn't get started, error out and undo everything
		display_error("cannot send!")

		if(!H)
			return

		for(var/atom/movable/AM in H)
			AM.forceMove(src)

		qdel(H)

	flushing = 0

	update_icon()
	return

/// Flash an error icon and display a message.
/obj/machinery/delivery_locker/proc/display_error(error)
	playsound(src, 'sounds/machines/buzz-two.ogg', 50, 0, 0)
	flick("[icon_state]-error", src)
	if(error)
		balloon_alert_to_viewers(error)

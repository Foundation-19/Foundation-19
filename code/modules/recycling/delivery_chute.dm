/obj/machinery/disposal/delivery_chute
	name = "delivery chute"
	desc = "A chute for big and small packages alike!"
	density = TRUE
	icon_state = "intake"

	var/c_mode = 0

/obj/machinery/disposal/delivery_chute/New()
	..()
	spawn(5)
		trunk = locate() in loc
		if(trunk)
			trunk.linked = src	// link the pipe trunk to self

/obj/machinery/disposal/delivery_chute/interact()
	return

/obj/machinery/disposal/delivery_chute/on_update_icon()
	return

/obj/machinery/disposal/delivery_chute/Bumped(atom/movable/AM) //Go straight into the chute
	if(istype(AM, /obj/item/projectile) || istype(AM, /obj/effect))
		return
	if(!loc)
		return
	switch(dir)
		if(NORTH)
			if(AM.loc.y != loc.y + 1)
				return
		if(EAST)
			if(AM.loc.x != loc.x + 1)
				return
		if(SOUTH)
			if(AM.loc.y != loc.y - 1)
				return
		if(WEST)
			if(AM.loc.x != loc.x - 1)
				return

	if(istype(AM, /mob/living))
		var/mob/living/L = AM
		log_and_message_staff("has flushed themselves down \the [src].", L)

	AM.forceMove(src)
	flush()

/obj/machinery/disposal/delivery_chute/flush()
	flushing = 1
	flick("intake-payout-closing", src)
	var/obj/structure/disposalholder/H = new()	// virtual holder object which actually
												// travels through the pipes.
	air_contents = new()		// new empty gas resv.

	sleep(1 SECOND)
	playsound(src, 'sounds/machines/disposalflush.ogg', 50, 0, 0)
	sleep(0.5 SECONDS) // wait for animation to finish

	if(prob(35))
		for(var/mob/living/carbon/human/L in src)
			var/list/obj/item/organ/external/crush = L.get_damageable_organs()
			if(!crush.len)
				return

			var/obj/item/organ/external/E = pick(crush)

			E.take_external_damage(45, used_weapon = "Blunt Trauma")
			to_chat(L, "\The [src]'s mechanisms crush your [E.name]!")

	H.init(contents - component_parts)	// copy the contents of disposer to holder

	if(!H.start(trunk)) // start the holder processing movement
		expel(H)

	flushing = 0
	// now reset disposal state
	flush = 0
	if(mode == 2)	// if was ready,
		mode = 1	// switch to charging
	update_icon()
	return

/obj/machinery/disposal/delivery_chute/attackby(obj/item/I, mob/user)
	if(!I || !user)
		return

	if(isWelder(I))
		var/obj/item/weldingtool/W = I
		if(!W.isOn())
			balloon_alert(user, "welder is off!")
			return
		if(!W.remove_fuel(1, user))
			balloon_alert(user, "not enough fuel!")
			return

		balloon_alert(user, "unwelding...")
		if(!do_after(user, 2.5 SECONDS, src, bonus_percentage = 25))
			balloon_alert(user, "welding stopped!")

		playsound(loc, 'sounds/items/Welder2.ogg', 100, 1)
		if(!src)
			balloon_alert(user, "chute not found!")
			return
		if(!W.isOn())
			balloon_alert(user, "keep welder on!")
			return

		balloon_alert(user, "chute unwelded")
		var/obj/structure/disposalconstruct/C = new (loc, src)
		C.update()
		qdel(src)
		return

	return ..()

/obj/machinery/disposal/delivery_chute/Destroy()
	if(trunk)
		trunk.linked = null
	..()

//attack with an item - open/close cover, insert cell, or (un)lock interface
/obj/machinery/power/apc/attackby(obj/item/W, mob/user)
	if (istype(user, /mob/living/silicon) && get_dist(src,user)>1)
		return attack_robot(user)
	if(istype(W, /obj/item/inducer))
		return FALSE // inducer.dm afterattack handles this

	if(isCrowbar(W) && user.a_intent != I_HURT)//bypass when on harm intend to actually make use of the cover hammer off check further down.
		if(opened) // Closes or removes board.
			if (has_electronics == 1)
				if (terminal())
					to_chat(user, SPAN_WARNING("Disconnect the wires first."))
					return TRUE
				playsound(src.loc, 'sounds/items/Crowbar.ogg', 50, 1)
				to_chat(user, "You are trying to remove the power control board...")//lpeters - fixed grammar issues

				if(do_after(user, 50, src) && opened && (has_electronics == 1) && !terminal()) // redo all checks.
					has_electronics = 0
					if ((stat & BROKEN))
						user.visible_message(\
							SPAN_WARNING("\The [user] has broken the power control board inside \the [src]!"),\
							SPAN_NOTICE("You break the charred power control board and remove the remains."),\
							"You hear a crack!")
					else
						user.visible_message(\
							SPAN_WARNING("\The [user] has removed the power control board from \the [src]!"),\
							SPAN_NOTICE("You remove the power control board."))
						new /obj/item/module/power_control(loc)
				return TRUE

			else if (opened != 2) //cover isn't removed
				opened = 0 // Closes panel.
				user.visible_message(SPAN_NOTICE("\The [user] pries the cover shut on \the [src]."), SPAN_NOTICE("You pry the cover shut."))
				update_icon()
				return TRUE

		if((stat & BROKEN) || (hacker && !hacker.hacked_apcs_hidden))
			to_chat(user, SPAN_WARNING("The cover appears broken or stuck."))
			return TRUE
		if(coverlocked && !(stat & MAINT))
			to_chat(user, SPAN_WARNING("The cover is locked and cannot be opened."))
			return TRUE
		opened = 1
		user.visible_message(SPAN_NOTICE("\The [user] pries the cover open on \the [src]."), SPAN_NOTICE("You pry the cover open."))
		update_icon()
		return TRUE

	// Exposes wires for hacking and attaches/detaches the circuit.
	if(isScrewdriver(W))
		if(opened)
			if (get_cell())
				to_chat(user, SPAN_WARNING("Either close the cover or remove the cell first."))
				return TRUE
			switch(has_electronics)
				if(1)
					if(!terminal())
						to_chat(user, SPAN_WARNING("You must attach a wire connection first!"))
						return TRUE
					has_electronics = 2
					stat &= ~MAINT
					playsound(src.loc, 'sounds/items/Screwdriver.ogg', 50, 1)
					to_chat(user, "You screw the circuit electronics into place.")
					update_icon()
				if(2)
					has_electronics = 1
					stat |= MAINT
					playsound(src.loc, 'sounds/items/Screwdriver.ogg', 50, 1)
					to_chat(user, "You unfasten the electronics.")
					update_icon()
				if(0)
					to_chat(user, SPAN_WARNING("There is no power control board to secure!"))
			return TRUE
		// Otherwise, if not opened, expose the wires.
		wiresexposed = !wiresexposed
		to_chat(user, "The wires have been [wiresexposed ? "exposed" : "unexposed"]")
		update_icon()
		return TRUE

	// trying to unlock the interface with an ID card
	if (istype(W, /obj/item/card/id)||istype(W, /obj/item/modular_computer))
		if(emagged)
			to_chat(user, "The interface is broken.")
		else if(opened)
			to_chat(user, "You must close the cover to swipe an ID card.")
		else if(wiresexposed)
			to_chat(user, "You must close the panel")
		else if(stat & (BROKEN|MAINT))
			to_chat(user, "Nothing happens.")
		else if(hacker && !hacker.hacked_apcs_hidden)
			to_chat(user, SPAN_WARNING("Access denied."))
		else
			if(has_access(req_access, user.GetAccess()) && !isWireCut(WIRE_IDSCAN))
				locked = !locked
				to_chat(user, "You [ locked ? "lock" : "unlock"] the APC interface.")
				update_icon()
			else
				to_chat(user, SPAN_WARNING("Access denied."))
		return TRUE

	// Inserting board.
	if(istype(W, /obj/item/module/power_control))
		if(stat & BROKEN)
			to_chat(user, SPAN_WARNING("You cannot put the board inside, the frame is damaged."))
			return TRUE
		if(!opened)
			to_chat(user, SPAN_WARNING("You must first open the cover."))
			return TRUE
		if(has_electronics != 0)
			to_chat(user, SPAN_WARNING("There is already a power control board inside."))
			return TRUE
		user.visible_message(SPAN_WARNING("\The [user] inserts the power control board into \the [src]."), \
							"You start to insert the power control board into the frame...")
		playsound(src.loc, 'sounds/items/Deconstruct.ogg', 50, 1)
		if(do_after(user, 10, src) && has_electronics == 0 && opened && !(stat & BROKEN))
			has_electronics = 1
			reboot() //completely new electronics
			to_chat(user, SPAN_NOTICE("You place the power control board inside the frame."))
			qdel(W)

	// Deconstruction
	if(isWelder(W))
		if(!opened)
			to_chat(user, SPAN_WARNING("You must first open the cover."))
			return TRUE
		if(has_electronics != 0)
			to_chat(user, SPAN_WARNING("You must first remove the power control board inside."))
			return TRUE
		if(terminal())
			to_chat(user, SPAN_WARNING("The wire connection is in the way."))
			return TRUE
		var/obj/item/weldingtool/WT = W
		if (WT.get_fuel() < 3)
			to_chat(user, SPAN_WARNING("You need more welding fuel to complete this task."))
			return
		user.visible_message(SPAN_WARNING("\The [user] begins to weld \the [src]."), \
							"You start welding the APC frame...", \
							"You hear welding.")
		playsound(src.loc, 'sounds/items/Welder.ogg', 50, 1)
		if(do_after(user, 50, src) && opened && has_electronics == 0 && !terminal())
			if(!WT.remove_fuel(3, user))
				return TRUE
			if (emagged || (stat & BROKEN) || opened==2)
				new /obj/item/stack/material/steel(loc)
				user.visible_message(\
					SPAN_WARNING("\The [src] has been cut apart by \the [user] with \the [WT]."),\
					SPAN_NOTICE("You disassembled the broken APC frame."),\
					"You hear welding.")
			else
				new /obj/item/frame/apc(loc)
				user.visible_message(\
					SPAN_WARNING("\The [src] has been cut from the wall by \the [user] with \the [WT]."),\
					SPAN_NOTICE("You cut the APC frame from the wall."),\
					"You hear welding.")
			qdel(src)
			return TRUE

	// Panel and frame repair.
	if (istype(W, /obj/item/frame/apc))
		if(!opened)
			to_chat(user, SPAN_WARNING("You must first open the cover."))
			return TRUE
		if(emagged)
			emagged = FALSE
			if(opened==2)
				opened = 1
			user.visible_message(\
				SPAN_WARNING("[user.name] has replaced the damaged APC frontal panel with a new one."),\
				SPAN_NOTICE("You replace the damaged APC frontal panel with a new one."))
			qdel(W)
			update_icon()
			return TRUE

		if((stat & BROKEN) || (hacker && !hacker.hacked_apcs_hidden))
			if (has_electronics)
				to_chat(user, SPAN_WARNING("You cannot repair this APC until you remove the electronics still inside."))
				return TRUE

			user.visible_message(SPAN_WARNING("[user.name] replaces the damaged APC frame with a new one."),\
								"You begin to replace the damaged APC frame...")
			if(do_after(user, 50, src) && opened && !has_electronics && ((stat & BROKEN) || (hacker && !hacker.hacked_apcs_hidden)))
				user.visible_message(\
					SPAN_NOTICE("[user.name] has replaced the damaged APC frame with new one."),\
					"You replace the damaged APC frame with new one.")
				qdel(W)
				set_broken(FALSE)
				// Malf AI, removes the APC from AI's hacked APCs list.
				if(hacker && hacker.hacked_apcs && (src in hacker.hacked_apcs))
					hacker.hacked_apcs -= src
					hacker = null
				if (opened==2)
					opened = 1
				queue_icon_update()

	if((. = ..())) // Further interactions are low priority attack stuff.
		return

	if (((stat & BROKEN) || (hacker && !hacker.hacked_apcs_hidden)) \
			&& !opened \
			&& W.force >= 5 \
			&& W.w_class >= 3.0 \
			&& prob(W.force) )
		opened = 2
		user.visible_message(SPAN_DANGER("The APC cover was knocked down with the [W.name] by [user.name]!"), \
			SPAN_DANGER("You knock down the APC cover with your [W.name]!"), \
			"You hear a bang")
		update_icon()
	else
		if (istype(user, /mob/living/silicon))
			return attack_robot(user)
		if (!opened && wiresexposed && (isMultitool(W) || isWirecutter(W) || istype(W, /obj/item/device/assembly/signaller)))
			return wires.Interact(user)

		user.visible_message(SPAN_DANGER("The [src.name] has been hit with the [W.name] by [user.name]!"), \
			SPAN_DANGER("You hit the [src.name] with your [W.name]!"), \
			"You hear a bang")
		if(W.force >= 5 && W.w_class >= ITEM_SIZE_NORMAL && prob(W.force))
			var/roulette = rand(1,100)
			switch(roulette)
				if(1 to 10)
					locked = FALSE
					to_chat(user, SPAN_NOTICE("You manage to disable the lock on \the [src]!"))
				if(50 to 70)
					to_chat(user, SPAN_NOTICE("You manage to bash the lid open!"))
					opened = 1
				if(90 to 100)
					to_chat(user, SPAN_WARNING("There's a nasty sound and \the [src] goes cold..."))
					set_broken(TRUE)
			queue_icon_update()
	playsound(get_turf(src), 'sounds/weapons/smash.ogg', 75, 1)
	show_sound_effect(get_turf(src))

// attack with hand - remove cell (if cover open) or interact with the APC
/obj/machinery/power/apc/physical_attack_hand(mob/user)
	//Human mob special interaction goes here.
	if(istype(user,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = user

		if(H.species.can_shred(H))
			user.visible_message(SPAN_WARNING("\The [user] slashes at \the [src]!"), SPAN_NOTICE("You slash at \the [src]!"))
			playsound(src.loc, 'sounds/weapons/slash.ogg', 100, 1)

			var/allcut = wires.is_all_cut()

			if(beenhit >= pick(3, 4) && !wiresexposed)
				wiresexposed = TRUE
				src.update_icon()
				src.visible_message(SPAN_WARNING("\The The [src]'s cover flies open, exposing the wires!"))

			else if(wiresexposed && !allcut)
				wires.cut_all()
				src.update_icon()
				src.visible_message(SPAN_WARNING("\The [src]'s wires are shredded!"))
			else
				beenhit += 1
			return TRUE

// emag act
/obj/machinery/power/apc/emag_act(remaining_charges, mob/user)
	if (!(emagged || (hacker && !hacker.hacked_apcs_hidden)))		// trying to unlock with an emag card
		if(opened)
			to_chat(user, "You must close the cover to swipe an ID card.")
		else if(wiresexposed)
			to_chat(user, "You must close the panel first")
		else if(stat & (BROKEN|MAINT))
			to_chat(user, "Nothing happens.")
		else
			flick("apc-spark", src)
			if (do_after(user,6,src))
				emagged = TRUE
				req_access.Cut()
				locked = 0
				to_chat(user, SPAN_NOTICE("You emag the APC interface."))
				update_icon()
				return 1

// damage and destruction acts
/obj/machinery/power/apc/emp_act(severity)
	if(emp_hardened)
		return
	var/obj/item/cell/cell = get_cell()
	// Fail for 8-12 minutes (divided by severity)
	// Division by 2 is required, because machinery ticks are every two seconds. Without it we would fail for 16-24 minutes.
	if(is_critical)
		// Critical APCs are considered EMP shielded and will be offline only for about half minute. Prevents AIs being one-shot disabled by EMP strike.
		// Critical APCs are also more resilient to cell corruption/power drain.
		energy_fail(rand(240, 360) / severity / CRITICAL_APC_EMP_PROTECTION)
		if(cell)
			cell.emp_act(severity+2)
	else
		// Regular APCs fail for normal time.
		energy_fail(rand(240, 360) / severity)
		if(cell)
			cell.emp_act(severity+1)

	update_icon()
	..()

/obj/machinery/power/apc/ex_act(severity)
	var/obj/item/cell/C = get_cell()
	switch(severity)
		if(1.0)
			qdel(src)
			if (C)
				C.ex_act(1.0) // more lags woohoo
			return
		if(2.0)
			if (prob(50))
				set_broken(TRUE)
				if (C && prob(50))
					C.ex_act(2.0)
		if(3.0)
			if (prob(25))
				set_broken(TRUE)
				if (C && prob(25))
					C.ex_act(3.0)

/obj/machinery/power/apc/set_broken(new_state)
	if(!new_state || (stat & BROKEN))
		return ..()
	visible_message(SPAN_NOTICE("[src]'s screen flickers with warnings briefly!"))
	GLOB.power_alarm.triggerAlarm(loc, src)
	spawn(rand(2,5))
		..()
		visible_message(SPAN_NOTICE("[src]'s screen suddenly explodes in rain of sparks and small debris!"))
		operating = 0
		update()
	return TRUE

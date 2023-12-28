//attack with an item - open/close cover, insert cell, or (un)lock interface
/obj/machinery/power/apc/attackby(obj/item/W, mob/user)
	if (istype(user, /mob/living/silicon) && get_dist(src,user)>1)
		return attack_robot(user)
	if(istype(W, /obj/item/inducer))
		return FALSE // inducer.dm afterattack handles this

	if(isCrowbar(W) && user.a_intent != I_HURT)	//bypass when on harm intent to actually make use of the cover hammer off check further down.
		if(opened)	// equivalent to opened != APC_COVER_CLOSED
			if (has_electronics == APC_PCU_UNSCREWED)
				if (terminal())
					balloon_alert(user, "remove wire connection first!")
					return TRUE
				playsound(src.loc, 'sounds/items/Crowbar.ogg', 50, 1)
				balloon_alert(user, "removing PCU...")

				if(do_after(user, 7 SECONDS, src, bonus_percentage = 25) && opened && (has_electronics == APC_PCU_UNSCREWED) && !terminal()) // redo all checks.
					has_electronics = APC_PCU_NONE
					if ((stat & BROKEN))
						user.balloon_alert_to_viewers("removed broken PCU")
					else
						user.balloon_alert_to_viewers("removed PCU")
						new /obj/item/power_control_module(loc)
				return TRUE

			else if (opened != APC_COVER_REMOVED) //cover isn't removed
				opened = APC_COVER_CLOSED // Closes panel.
				user.balloon_alert_to_viewers("APC panel closed")
				update_icon()
				return TRUE

		if((stat & BROKEN) || (hacker && !hacker.hacked_apcs_hidden))
			playsound(src.loc, 'sounds/items/Crowbar.ogg', 50, 1)
			balloon_alert(user, "prying broken cover...")
			if(do_after(user, 12 SECONDS, src, bonus_percentage = 25))
				opened = APC_COVER_REMOVED
				user.balloon_alert_to_viewers("broken cover removed")
				update_icon()
				return TRUE

		if(coverlocked && !(stat & MAINT))
			balloon_alert(user, "cover is locked!")
			return TRUE
		opened = APC_COVER_OPENED
		user.balloon_alert_to_viewers("cover opened")
		update_icon()
		return TRUE

	// Exposes wires for hacking and attaches/detaches the circuit.
	if(isScrewdriver(W))
		if(opened)	// equivalent to opened != APC_COVER_CLOSED
			if (get_cell())
				balloon_alert(user, SPAN_WARNING("power cell in the way!"))
				return TRUE
			switch(has_electronics)
				if(APC_PCU_NONE)
					balloon_alert(user, "PCU missing!")
				if(APC_PCU_UNSCREWED)
					if(!terminal())
						balloon_alert(user, "wire connection missing!")
						return TRUE
					has_electronics = 2
					stat &= ~MAINT
					playsound(src.loc, 'sounds/items/Screwdriver.ogg', 50, 1)
					balloon_alert(user, "PCU screwed")
					update_icon()
				if(APC_PCU_SCREWED)
					has_electronics = 1
					stat |= MAINT
					playsound(src.loc, 'sounds/items/Screwdriver.ogg', 50, 1)
					balloon_alert(user, "PCU unscrewed")
					update_icon()
			return TRUE
		// Otherwise, if not opened, expose the wires.
		wiresexposed = !wiresexposed
		balloon_alert(user, "wires [wiresexposed ? "exposed" : "unexposed"]")
		update_icon()
		return TRUE

	// trying to unlock the interface with an ID card
	if (istype(W, /obj/item/card/id) || istype(W, /obj/item/modular_computer))
		if(emagged || (stat & (BROKEN|MAINT)))
			balloon_alert(user, "frame is broken!")
		else if(opened)	// equivalent to opened != APC_COVER_CLOSED
			balloon_alert(user, "close cover first!")
		else if(wiresexposed)
			balloon_alert(user, "close wire panel first!")
		else
			if(isWireCut(WIRE_IDSCAN) || (hacker && !hacker.hacked_apcs_hidden) || !has_access(req_access, user.GetAccess()))
				balloon_alert(user, "access denied!")
			else
				locked = !locked
				balloon_alert(user, "APC [locked ? "" : "un"]locked")
				update_icon()
		return TRUE

	// Inserting board.
	if(istype(W, /obj/item/power_control_module))
		if(stat & BROKEN)
			balloon_alert(user, "frame is broken!")
			return TRUE
		if(!opened)
			balloon_alert(user, "cover is closed!")
			return TRUE
		if(has_electronics)		// equivalent to has_electronics != APC_PCU_NONE
			balloon_alert(user, "already has a PCU!")
			return TRUE
		user.balloon_alert_to_viewers("placing PCU into APC...")
		playsound(src.loc, 'sounds/items/Deconstruct.ogg', 50, 1)
		if(do_after(user, 1 SECOND, src, bonus_percentage = 100) && has_electronics == 0 && opened && !(stat & BROKEN))
			has_electronics = APC_PCU_UNSCREWED
			reboot() //completely new electronics
			user.balloon_alert_to_viewers(user, "PCU placed in APC")
			qdel(W)

	// Deconstruction
	if(isWelder(W))
		if(!opened)	// equivalent to opened == APC_COVER_CLOSED
			balloon_alert(user, "open cover first!")
			return TRUE
		if(has_electronics)	// equivalent to has_electronics != APC_PCU_NONE
			balloon_alert(user, "remove PCU first!")
			return TRUE
		if(terminal())
			balloon_alert(user, "remove wire connection first!")
			return TRUE
		var/obj/item/weldingtool/WT = W
		if (WT.get_fuel() < 3)
			balloon_alert(user, "need more fuel!")
			return
		user.balloon_alert_to_viewers("welding APC...")
		playsound(src.loc, 'sounds/items/Welder.ogg', 50, 1)
		if(do_after(user, 7 SECONDS, src, bonus_percentage = 25) && opened && !has_electronics && !terminal())
			if(!WT.remove_fuel(3, user))
				return TRUE
			if (emagged || (stat & BROKEN) || opened == APC_COVER_CLOSED)
				new /obj/item/stack/material/steel(loc)
				user.balloon_alert_to_viewers("broken APC scrapped")
			else
				new /obj/item/frame/apc(loc)
				user.balloon_alert_to_viewers("APC detached from wall")
			qdel(src)
			return TRUE

	// Panel and frame repair.
	if (istype(W, /obj/item/frame/apc))
		if(!opened)	// equivalent to opened == APC_COVER_CLOSED
			balloon_alert(user, "open cover first!")
			return TRUE
		if(emagged)
			emagged = FALSE
			if(opened == APC_COVER_REMOVED)
				opened = APC_COVER_OPENED
			user.balloon_alert_to_viewers("APC panel replaced")
			qdel(W)
			update_icon()
			return TRUE

		if((stat & BROKEN) || (hacker && !hacker.hacked_apcs_hidden))
			if (has_electronics)
				balloon_alert(user, "remove PCU first!")
				return TRUE

			user.balloon_alert_to_viewers("replacing APC frame...")
			if(do_after(user, 7 SECONDS, src, bonus_percentage = 25) && opened && !has_electronics && ((stat & BROKEN) || (hacker && !hacker.hacked_apcs_hidden)))
				user.balloon_alert_to_viewers("APC frame replaced")
				qdel(W)
				set_broken(FALSE)
				// Malf AI, removes the APC from AI's hacked APCs list.
				if(hacker && hacker.hacked_apcs && (src in hacker.hacked_apcs))
					hacker.hacked_apcs -= src
					hacker = null
				if(opened == APC_COVER_REMOVED)
					opened = APC_COVER_OPENED
				queue_icon_update()

	if((. = ..())) // Further interactions are low priority attack stuff.
		return

	if (((stat & BROKEN) || (hacker && !hacker.hacked_apcs_hidden)) \
			&& !opened \
			&& W.force >= 5 \
			&& W.w_class >= 3.0 \
			&& prob(W.force) )
		opened = APC_COVER_REMOVED
		user.balloon_alert_to_viewers("APC cover forced open")
		update_icon()
	else
		if (istype(user, /mob/living/silicon))
			return attack_robot(user)
		if (!opened && wiresexposed && (isMultitool(W) || isWirecutter(W) || istype(W, /obj/item/device/assembly/signaller)))
			return wires.Interact(user)

		if(W.force >= 5 && W.w_class >= ITEM_SIZE_NORMAL && prob(W.force))
			var/roulette = rand(1,100)
			switch(roulette)
				if(1 to 10)
					locked = FALSE
					balloon_alert(user, "lock disabled")
				if(50 to 70)
					balloon_alert(user, "cover forced open")
					opened = APC_COVER_OPENED
				if(90 to 100)
					balloon_alert(user, "APC broken")
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
			user.balloon_alert_to_viewers("slashed at APC")
			playsound(src.loc, 'sounds/weapons/slash.ogg', 100, 1)

			var/allcut = wires.is_all_cut()

			if(beenhit >= pick(3, 4) && !wiresexposed)
				wiresexposed = TRUE
				update_icon()
				balloon_alert_to_viewers("wires exposed")

			else if(wiresexposed && !allcut)
				wires.cut_all()
				update_icon()
				balloon_alert_to_viewers("wires shredded")
			else
				beenhit += 1
			return TRUE

// emag act
/obj/machinery/power/apc/emag_act(remaining_charges, mob/user)
	if (!(emagged || (hacker && !hacker.hacked_apcs_hidden)))		// trying to unlock with an emag card
		if(opened)	// equivalent to opened != APC_COVER_CLOSED
			balloon_alert(user, "close cover first!!")
		else if(wiresexposed)
			balloon_alert(user, "close wire panel first!")
		else if(stat & (BROKEN|MAINT))
			balloon_alert(user, "APC is broken!")
		else
			flick("apc-spark", src)
			if (do_after(user, 0.75 SECONDS, src, bonus_percentage = 25))
				emagged = TRUE
				req_access.Cut()
				locked = 0
				balloon_alert(user, "APC emagged")
				update_icon()
				return 1

// damage and destruction acts
/obj/machinery/power/apc/emp_act(severity)
	if(malf_upgraded)
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
	balloon_alert_to_viewers("screen BSODing...")
	GLOB.power_alarm.triggerAlarm(loc, src)
	spawn(rand(2,5))
		..()
		balloon_alert_to_viewers("screen explodes")
		operating = 0
		update()
	return TRUE

// overload the lights in this APC area
/obj/machinery/power/apc/proc/overload_lighting(chance = 100)
	if(/* !get_connection() || */ !operating || shorted)
		return
	var/amount = use_power_oneoff(20, LOCAL)
	if(amount <= 0)
		spawn(0)
			for(var/obj/machinery/light/L in area)
				if(prob(chance))
					L.on = 1
					L.broken()
				sleep(1)

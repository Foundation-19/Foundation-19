/mob/living/exosuit/handle_disabilities()
	return

/mob/living/exosuit/Life()

	for(var/thing in pilots)
		var/mob/pilot = thing
		if(pilot.loc != src) // Admin jump or teleport/grab.
			if(pilot.client)
				pilot.client.screen -= hud_elements
				LAZYREMOVE(pilots, pilot)
				UNSETEMPTY(pilots)
		update_pilots()

	if(radio)
		radio.on = (head && head.radio && head.radio.is_functional() && get_cell(FALSE, ME_ANY_POWER))

	body.update_air(hatch_closed && use_air)

	var/powered = get_cell(FALSE, ME_ANY_POWER)?.drain_power(0, 0, calc_power_draw()) > 0

	if(!powered)
		//Shut down all systems
		if(head)
			head.active_sensors = FALSE
			hud_camera.queue_icon_update()
		for(var/hardpoint in hardpoints)
			var/obj/item/mech_equipment/M = hardpoints[hardpoint]
			if(istype(M) && M.active && M.passive_power_use)
				M.deactivate()
	else
		if(hardpoints[HARDPOINT_BACKUP_POWER])
			var/obj/item/mech_equipment/power_auxiliary/hungry = hardpoints[HARDPOINT_BACKUP_POWER]
			if((hungry.internal_cell.maxcharge - hungry.internal_cell.charge) > 10)
				hungry.internal_cell?.give(get_cell(FALSE, ME_ENGINE_POWERED | ME_CELL_POWERED)?.drain_power(0,0, 5 KILOWATTS))

	updatehealth()
	if(health <= 0 && stat != DEAD)
		death()

	if(emp_damage > 0)
		emp_damage -= min(1, emp_damage) //Reduce emp accumulation over time

	..() //Handles stuff like environment

	handle_hud_icons()
	update_hud_alerts()

	lying = FALSE // Fuck off, carp.
	handle_vision(powered)

/mob/living/exosuit/get_cell(force, power_flags)
	RETURN_TYPE(/obj/item/cell)
	if(power == MECH_POWER_ON || force) //For most intents we can assume that a powered off exosuit acts as if it lacked a cell
		if((power_flags & ME_CELL_POWERED && mech_flags & MF_CELL_POWERED) || force == 2)
			var/obj/item/mech_equipment/power_cell/provider = hardpoints[HARDPOINT_POWER]
			if(provider)
				return provider.internal_cell
		if((power_flags & ME_ENGINE_POWERED && mech_flags & MF_ENGINE_POWERED) || force == 2)
			var/obj/item/mech_equipment/engine/provider = hardpoints[HARDPOINT_POWER]
			if(provider)
				return provider.internal_cell
		if(power_flags & ME_AUXILIARY_POWERED && mech_flags & MF_AUXILIARY_POWERED)
			var/obj/item/mech_equipment/power_auxiliary/provider = hardpoints[HARDPOINT_BACKUP_POWER]
			return provider.internal_cell
	return null

/mob/living/exosuit/proc/calc_power_draw()
	//Passive power stuff here. You can also recharge cells or hardpoints if those make sense
	var/total_draw = 0
	for(var/hardpoint in hardpoints)
		var/obj/item/mech_equipment/I = hardpoints[hardpoint]
		if(!istype(I))
			continue
		total_draw += I.passive_power_use

	if(head && head.active_sensors)
		total_draw += head.power_use

	if(body)
		total_draw += body.power_use

	return total_draw

/mob/living/exosuit/handle_environment(datum/gas_mixture/environment)
	if(!environment) return
	//Mechs and vehicles in general can be assumed to just tend to whatever ambient temperature
	if(abs(environment.temperature - bodytemperature) > 0 )
		bodytemperature += ((environment.temperature - bodytemperature) / 6)

	if(bodytemperature > material.melting_point * 1.45 ) //A bit higher because I like to assume there's a difference between a mech and a wall
		var/damage = 5
		if(bodytemperature > material.melting_point * 1.75 )
			damage = 10
		if(bodytemperature > material.melting_point * 2.15 )
			damage = 15
		apply_damage(damage, BURN)
	//A possibility is to hook up interface icons here. But this works pretty well in my experience
		if(prob(damage))
			visible_message(SPAN_DANGER("\The [src]'s hull bends and buckles under the intense heat!"))


/mob/living/exosuit/death(gibbed)
	// Eject the pilot.
	if(LAZYLEN(pilots))
		hatch_locked = 0 // So they can get out.
		for(var/pilot in pilots)
			eject(pilot, silent=1)

	// Salvage moves into the wreck unless we're exploding violently.
	var/obj/wreck = new wreckage_path(get_turf(src), src, gibbed)
	wreck.name = "wreckage of \the [name]"
	if(!gibbed)
		if(arms.loc != src)
			arms = null
		if(legs.loc != src)
			legs = null
		if(head.loc != src)
			head = null
		if(body.loc != src)
			body = null

	// Handle the rest of things.
	..(gibbed, (gibbed ? "explodes!" : "grinds to a halt before collapsing!"))
	if(!gibbed) qdel(src)

/mob/living/exosuit/gib()
	death(1)

	// Get a turf to play with.
	var/turf/T = get_turf(src)
	if(!T)
		qdel(src)
		return

	// Hurl our component pieces about.
	var/list/stuff_to_throw = list()
	for(var/obj/item/thing in list(arms, legs, head, body))
		if(thing) stuff_to_throw += thing
	for(var/hardpoint in hardpoints)
		if(hardpoints[hardpoint])
			var/obj/item/thing = hardpoints[hardpoint]
			thing.screen_loc = null
			stuff_to_throw += thing
	for(var/obj/item/thing in stuff_to_throw)
		thing.forceMove(T)
		thing.throw_at(get_edge_target_turf(src,pick(GLOB.alldirs)),rand(3,6),40)
	explosion(T, -1, 0, 2)
	qdel(src)
	return

/mob/living/exosuit/handle_vision(powered)
	var/was_blind = sight & BLIND
	if(head)
		sight = head.get_sight(powered)
		see_invisible = head.get_invisible(powered)
	if(body && (body.pilot_coverage < 100 || body.transparent_cabin) || !hatch_closed)
		sight &= ~BLIND

	if(sight & BLIND && !was_blind)
		for(var/mob/pilot in pilots)
			to_chat(pilot, SPAN_WARNING("The sensors are not operational and you cannot see a thing!"))

/mob/living/exosuit/additional_sight_flags()
	return sight

/mob/living/exosuit/additional_see_invisible()
	return see_invisible

/mob/living/exosuit/proc/update_hud_alerts()
	for(var/mob/pilot as anything in pilots)

		var/obj/item/cell/cell = get_cell(TRUE, ME_ANY_POWER)

		if(cell)
			var/cellcharge = cell.charge/cell.maxcharge
			switch(cellcharge)
				if(0.75 to INFINITY)
					pilot.clear_alert(ALERT_CHARGE)
				if(0.5 to 0.75)
					pilot.throw_alert(ALERT_CHARGE, /atom/movable/screen/alert/lowcell/mech, 1)
				if(0.25 to 0.5)
					pilot.throw_alert(ALERT_CHARGE, /atom/movable/screen/alert/lowcell/mech, 2)
				if(0.01 to 0.25)
					pilot.throw_alert(ALERT_CHARGE, /atom/movable/screen/alert/lowcell/mech, 3)
				else
					pilot.throw_alert(ALERT_CHARGE, /atom/movable/screen/alert/emptycell/mech)
		else
			pilot.throw_alert(ALERT_CHARGE, /atom/movable/screen/alert/nocell/mech)

		var/integrity = health/maxHealth
		switch(integrity)
			if(0.30 to 0.45)
				pilot.throw_alert(ALERT_MECH_DAMAGE, /atom/movable/screen/alert/low_mech_integrity, 1)
			if(0.15 to 0.35)
				pilot.throw_alert(ALERT_MECH_DAMAGE, /atom/movable/screen/alert/low_mech_integrity, 2)
			if(-INFINITY to 0.15)
				pilot.throw_alert(ALERT_MECH_DAMAGE, /atom/movable/screen/alert/low_mech_integrity, 3)
			else
				pilot.clear_alert(ALERT_MECH_DAMAGE)

		var/atom/checking = pilot.loc
		// recursive check to handle all cases regarding very nested occupants,
		// such as brainmob inside brainitem inside MMI inside mecha
		while(!isnull(checking))
			if(isturf(checking))
				// hit a turf before hitting the mecha, seems like they have been moved out
				pilot.clear_alert(ALERT_CHARGE)
				pilot.clear_alert(ALERT_MECH_DAMAGE)
				pilot = null
				break
			else if (checking == src)
				break  // all good
			checking = checking.loc

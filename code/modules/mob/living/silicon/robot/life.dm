/mob/living/silicon/robot/Life()
	set invisibility = 0
	set background = 1

	if (HAS_TRANSFORMATION_MOVEMENT_HANDLER(src))
		return

	//Status updates, death etc.
	clamp_values()
	handle_regular_status_updates()
	handle_actions()

	if(client)
		handle_regular_hud_updates()
		update_items()
	if (stat != DEAD) //still using power
		use_power()
		process_queued_alarms()
	UpdateLyingBuckledAndVerbStatus()

	handle_robot_hud_alerts()

/mob/living/silicon/robot/proc/clamp_values()

//	SetStunned(min(stunned, 30))
	SetParalysis(min(paralysis, 30))
//	SetWeakened(min(weakened, 20))
	sleeping = 0
	adjustBruteLoss(0)
	adjustToxLoss(0)
	adjustOxyLoss(0)
	adjustFireLoss(0)

/mob/living/silicon/robot/proc/use_power()
	used_power_this_tick = 0
	for(var/V in components)
		var/datum/robot_component/C = components[V]
		C.update_power_state()

	if (cell && is_component_functioning("power cell") && cell.charge > 0)
		if(module_state_1)
			cell_use_power(50) // 50W load for every enabled tool TODO: tool-specific loads
		if(module_state_2)
			cell_use_power(50)
		if(module_state_3)
			cell_use_power(50)

		if(lights_on)
			if(intenselight)
				cell_use_power(100)	// Upgraded light. Double intensity, much larger power usage.
			else
				cell_use_power(30) 	// 30W light. Normal lights would use ~15W, but increased for balance reasons.

		has_power = TRUE
	else
		power_down()

/mob/living/silicon/robot/proc/power_down()
	if (has_power)
		visible_message("[src] beeps stridently as it begins to run on emergency backup power!", SPAN_WARNING("You beep stridently as you begin to run on emergency backup power!"))
		has_power = FALSE
		set_stat(UNCONSCIOUS)
	if(lights_on) // Light is on but there is no power!
		lights_on = FALSE
		set_light(0)

/mob/living/silicon/robot/handle_regular_status_updates()

	if(camera && !scrambledcodes)
		if(stat == 2 || wires.is_cut(WIRE_BORG_CAMERA))
			camera.set_status(0)
		else
			camera.set_status(1)

	updatehealth()

	if(sleeping)
		Paralyse(3)
		sleeping--

	if(resting)
		Weaken(5)

	if(health < config.health_threshold_dead && stat != 2) //die only once
		death()

	if (stat != DEAD) //Alive.
		if (paralysis || stunned || weakened || !has_power) //Stunned etc.
			set_stat(UNCONSCIOUS)
			if (stunned > 0)
				AdjustStunned(-1)
			if (weakened > 0)
				AdjustWeakened(-1)
			if (paralysis > 0)
				AdjustParalysis(-1)
				become_blind(STAT_TRAIT)
			else
				cure_blind(STAT_TRAIT)

		else	//Not stunned.
			set_stat(CONSCIOUS)

	else //Dead.
		become_blind(STAT_TRAIT)
		set_stat(DEAD)

	if (ear_deaf > 0)
		ear_deaf--

	if (ear_damage < 25)
		ear_damage -= 0.05
		ear_damage = max(ear_damage, 0)

	set_density(!lying)

	if ((sdisabilities & DEAFENED))
		ear_deaf = 1

	//update the state of modules and components here
	if (stat != CONSCIOUS)
		uneq_all()

	if(silicon_radio)
		if(!is_component_functioning("radio"))
			silicon_radio.on = 0
		else
			silicon_radio.on = 1

	if(isnull(components["camera"]) || is_component_functioning("camera"))
		cure_blind(MISSING_ORGAN_TRAIT)
	else
		become_blind(MISSING_ORGAN_TRAIT)

	return 1

/mob/living/silicon/robot/handle_regular_hud_updates()
	..()

	var/obj/item/borg/sight/hud/hud = (locate(/obj/item/borg/sight/hud) in src)
	if(hud && hud.hud)
		hud.hud.process_hud(src)
	else
		switch(sensor_mode)
			if (SEC_HUD)
				process_sec_hud(src,0)
			if (MED_HUD)
				process_med_hud(src,0)

	if (healths)
		if (stat != 2)
			if(istype(src,/mob/living/silicon/robot/drone))
				switch(health)
					if(35 to INFINITY)
						healths.icon_state = "health0"
					if(25 to 34)
						healths.icon_state = "health1"
					if(15 to 24)
						healths.icon_state = "health2"
					if(5 to 14)
						healths.icon_state = "health3"
					if(0 to 4)
						healths.icon_state = "health4"
					if(-35 to 0)
						healths.icon_state = "health5"
					else
						healths.icon_state = "health6"
			else
				switch(health)
					if(200 to INFINITY)
						healths.icon_state = "health0"
					if(150 to 200)
						healths.icon_state = "health1"
					if(100 to 150)
						healths.icon_state = "health2"
					if(50 to 100)
						healths.icon_state = "health3"
					if(0 to 50)
						healths.icon_state = "health4"
					if(-100 to 0)
						healths.icon_state = "health5"
					else
						healths.icon_state = "health6"
		else
			healths.icon_state = "health7"

	if (syndicate && client)
		for(var/datum/mind/tra in GLOB.traitors.current_antagonists)
			if(tra.current)
				// TODO: Update to new antagonist system.
				var/I = image('icons/mob/mob.dmi', loc = tra.current, icon_state = "traitor")
				client.images += I
		disconnect_from_ai()
		if(mind)
			// TODO: Update to new antagonist system.
			if(!mind.special_role)
				mind.special_role = "traitor"
				GLOB.traitors.current_antagonists |= mind

	if (cells)
		if (cell)
			var/chargeNum = Clamp(ceil(cell.percent()/25), 0, 4)	//0-100 maps to 0-4, but give it a paranoid clamp just in case.
			cells.icon_state = "charge[chargeNum]"
		else
			cells.icon_state = "charge-empty"

	if(bodytemp)
		switch(bodytemperature) //310.055 optimal body temp
			if(335 to INFINITY)
				bodytemp.icon_state = "temp2"
			if(320 to 335)
				bodytemp.icon_state = "temp1"
			if(300 to 320)
				bodytemp.icon_state = "temp0"
			if(260 to 300)
				bodytemp.icon_state = "temp-1"
			else
				bodytemp.icon_state = "temp-2"

	var/datum/gas_mixture/environment = loc?.return_air()
	if(fire && environment)
		switch(environment.temperature)
			if(-INFINITY to T100C)
				fire.icon_state = "fire0"
			else
				fire.icon_state = "fire1"
	if(oxygen && environment)
		var/datum/species/species = all_species[SPECIES_HUMAN]
		if(environment.gas[species.breath_type] >= species.breath_pressure)
			oxygen.icon_state = "oxy0"
			for(var/gas in species.poison_types)
				if(environment.gas[gas])
					oxygen.icon_state = "oxy1"
					break
		else
			oxygen.icon_state = "oxy1"

	if(stat != DEAD)

		if (machine)
			if (machine.check_eye(src) < 0)
				reset_view(null)
		else
			if(client && !client.adminobs)
				reset_view(null)

	return 1

/mob/living/silicon/robot/handle_vision()
	..()

	if (stat == DEAD || (MUTATION_XRAY in mutations) || (sight_mode & BORGXRAY))
		set_sight(sight|SEE_TURFS|SEE_MOBS|SEE_OBJS)
		set_see_in_dark(8)
		set_see_invisible(SEE_INVISIBLE_LEVEL_TWO)
	else if ((sight_mode & BORGMESON) && (sight_mode & BORGTHERM))
		set_sight(sight|SEE_TURFS|SEE_MOBS)
		set_see_in_dark(8)
		set_see_invisible(SEE_INVISIBLE_NOLIGHTING)
	else if (sight_mode & BORGMESON)
		set_sight(sight|SEE_TURFS)
		set_see_in_dark(8)
		set_see_invisible(SEE_INVISIBLE_NOLIGHTING)
	else if (sight_mode & BORGMATERIAL)
		set_sight(sight|SEE_OBJS)
		set_see_in_dark(8)
	else if (sight_mode & BORGTHERM)
		set_sight(sight|SEE_MOBS)
		set_see_in_dark(8)
		set_see_invisible(SEE_INVISIBLE_LEVEL_TWO)
	else if (stat != DEAD)
		set_sight(sight&(~SEE_TURFS)&(~SEE_MOBS)&(~SEE_OBJS))
		set_see_in_dark(8) 			 // see_in_dark means you can FAINTLY see in the dark, humans have a range of 3 or so
		set_see_invisible(SEE_INVISIBLE_LIVING) // This is normal vision (25), setting it lower for normal vision means you don't "see" things like darkness since darkness
							 // has a "invisible" value of 15


/mob/living/silicon/robot/proc/update_items()
	if (client)
		client.screen -= contents
		for(var/obj/I in contents)
			if(I && !(istype(I,/obj/item/cell) || istype(I,/obj/item/device/radio)  || istype(I,/obj/machinery/camera) || istype(I,/obj/item/device/mmi)))
				client.screen += I
	if(module_state_1)
		module_state_1:screen_loc = ui_inv1
	if(module_state_2)
		module_state_2:screen_loc = ui_inv2
	if(module_state_3)
		module_state_3:screen_loc = ui_inv3
	update_icon()

/mob/living/silicon/robot/update_fire()
	cut_overlay(image("icon"='icons/mob/OnFire.dmi', "icon_state"="Standing"))
	if(on_fire)
		add_overlay(image("icon"='icons/mob/OnFire.dmi', "icon_state"="Standing"))

/mob/living/silicon/robot/fire_act(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(status_flags & GODMODE)
		return

	if(!on_fire) //Silicons don't gain stacks from hotspots, but hotspots can ignite them
		IgniteMob()

/mob/living/silicon/robot/proc/handle_robot_hud_alerts()
	if(!client)
		return

	if(cell)
		var/cellcharge = cell.charge/cell.maxcharge
		switch(cellcharge)
			if(0.75 to INFINITY)
				clear_alert(ALERT_CHARGE)
			if(0.5 to 0.75)
				throw_alert(ALERT_CHARGE, /atom/movable/screen/alert/lowcell, 1)
			if(0.25 to 0.5)
				throw_alert(ALERT_CHARGE, /atom/movable/screen/alert/lowcell, 2)
			if(0.01 to 0.25)
				throw_alert(ALERT_CHARGE, /atom/movable/screen/alert/lowcell, 3)
			else
				throw_alert(ALERT_CHARGE, /atom/movable/screen/alert/emptycell)
	else
		throw_alert(ALERT_CHARGE, /atom/movable/screen/alert/nocell)

	if(emagged)
		throw_alert(ALERT_HACKED, /atom/movable/screen/alert/hacked)
	else
		clear_alert(ALERT_HACKED)

	if(locked)
		throw_alert(ALERT_LOCKED, /atom/movable/screen/alert/locked)
	else
		clear_alert(ALERT_LOCKED)

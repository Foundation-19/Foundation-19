/obj/machinery/power/apc/updateDialog()
	if(stat & (BROKEN|MAINT))
		return
	SStgui.update_uis(src)

/obj/machinery/power/apc/tgui_status(mob/user, datum/tgui_state/state)
	if(user.lying)
		balloon_alert(user, "can't reach!")
		return STATUS_CLOSE
	if(istype(user, /mob/living/silicon))
		var/permit = 0
		var/mob/living/silicon/ai/AI = user
		var/mob/living/silicon/robot/robot = user
		if(hacker && !hacker.hacked_apcs_hidden)
			if(hacker == AI)
				permit = 1
			else if(istype(robot) && robot.connected_ai && robot.connected_ai == hacker)
				permit = 1
		if(aidisabled && !permit)
			return STATUS_CLOSE
	. = ..()
	if(user.restrained())
		balloon_alert(user, "no free hands!")
		. = min(., STATUS_UPDATE)

/obj/machinery/power/apc/interface_interact(mob/user)
	tgui_interact(user)
	return TRUE

/obj/machinery/power/apc/tgui_interact(mob/user, datum/tgui/ui)
	if(!user)
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Apc", "[area.name] - APC")
		ui.open()

/obj/machinery/power/apc/tgui_data(mob/user)
	var/obj/item/cell/cell = get_cell()

	var/list/data = list(
		"locked" = (locked && !emagged) ? 1 : 0,
		"isOperating" = operating,
		"externalPower" = main_status,
		"powerCellStatus" = cell ? cell.percent() : null,
		"chargeMode" = chargemode,
		"chargingStatus" = charging,
		"totalLoad" = round(lastused_total),
		"totalCharging" = round(lastused_charging),
		"coverLocked" = coverlocked,
		"failTime" = failure_timer * 2,
		"siliconUser" = istype(user, /mob/living/silicon),
		"powerChannels" = list(
			list(
				"title" = "Equipment",
				"powerLoad" = lastused_equip,
				"status" = equipment
			),
			list(
				"title" = "Lighting",
				"powerLoad" = round(lastused_light),
				"status" = lighting
			),
			list(
				"title" = "Environment",
				"powerLoad" = round(lastused_environ),
				"status" = environ
			)
		)
	)
	return data

/obj/machinery/power/apc/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE

	if(action == "reboot")
		failure_timer = 0
		update_icon()
		update()
		return TRUE

	if(!istype(usr, /mob/living/silicon) && (locked && !emagged))
		balloon_alert(usr, "panel locked!")
		return TRUE

	switch(action)
		if("lock")
			coverlocked = !coverlocked
			return TRUE
		if("breaker")
			toggle_breaker()
			return TRUE
		if("cmode")
			set_chargemode(!chargemode)
			if(!chargemode)
				charging = 0
				update_icon()
			return TRUE
		if("eqp")
			var/val = text2num(params["eqp"])
			equipment = setsubsystem(val)
			force_update_channels()
			return TRUE
		if("lgt")
			var/val = text2num(params["lgt"])
			lighting = setsubsystem(val)
			force_update_channels()
			return TRUE
		if("env")
			var/val = text2num(params["env"])
			environ = setsubsystem(val)
			force_update_channels()
			return TRUE
		if("overload")
			if(istype(usr, /mob/living/silicon))
				overload_lighting()
			return TRUE
		if("toggleaccess")
			if(istype(usr, /mob/living/silicon))
				if(emagged || (stat & (BROKEN|MAINT)))
					to_chat(usr, "The APC does not respond to the command.")
				else
					locked = !locked
					update_icon()
			return TRUE

/obj/machinery/power/apc/updateDialog()
	if (stat & (BROKEN|MAINT))
		return
	..()

/obj/machinery/power/apc/CanUseTopicPhysical(mob/user)
	return GLOB.physical_state.can_use_topic(nano_host(), user)

/obj/machinery/power/apc/interface_interact(mob/user)
	ui_interact(user)
	return TRUE

/obj/machinery/power/apc/ui_interact(mob/user, ui_key = "main", datum/nanoui/ui = null, force_open = 1)
	if(!user)
		return
	var/obj/item/cell/cell = get_cell()

	var/list/data = list(
		"pChan_Off" = POWERCHAN_OFF,
		"pChan_Off_T" = POWERCHAN_OFF_TEMP,
		"pChan_Off_A" = POWERCHAN_OFF_AUTO,
		"pChan_On" = POWERCHAN_ON,
		"pChan_On_A" = POWERCHAN_ON_AUTO,
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
				"status" = equipment,
				"topicParams" = list(
					"auto" = list("eqp" = 2),
					"on"   = list("eqp" = 1),
					"off"  = list("eqp" = 0)
				)
			),
			list(
				"title" = "Lighting",
				"powerLoad" = round(lastused_light),
				"status" = lighting,
				"topicParams" = list(
					"auto" = list("lgt" = 2),
					"on"   = list("lgt" = 1),
					"off"  = list("lgt" = 0)
				)
			),
			list(
				"title" = "Environment",
				"powerLoad" = round(lastused_environ),
				"status" = environ,
				"topicParams" = list(
					"auto" = list("env" = 2),
					"on"   = list("env" = 1),
					"off"  = list("env" = 0)
				)
			)
		)
	)

	// update the ui if it exists, returns null if no ui is passed/found
	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		// the ui does not exist, so we'll create a new() one
		// for a list of parameters and their descriptions see the code docs in \code\modules\nano\nanoui.dm
		ui = new(user, src, ui_key, "apc.tmpl", "[area.name] - APC", 520, data["siliconUser"] ? 465 : 440)
		// when the ui is first opened this is the data it will use
		ui.set_initial_data(data)
		// open the new ui window
		ui.open()
		// auto update every Master Controller tick
		ui.set_auto_update(1)

/obj/machinery/power/apc/CanUseTopic(mob/user, datum/topic_state/state)
	if(user.lying)
		balloon_alert(user, "can't reach!")
		return STATUS_CLOSE
	if(istype(user, /mob/living/silicon))
		var/permit = 0 // Malfunction variable. If AI hacks APC it can control it even without AI control wire.
		var/mob/living/silicon/ai/AI = user
		var/mob/living/silicon/robot/robot = user
		if(hacker && !hacker.hacked_apcs_hidden)
			if(hacker == AI)
				permit = 1
			else if(istype(robot) && robot.connected_ai && robot.connected_ai == hacker) // Cyborgs can use APCs hacked by their AI
				permit = 1

		if(aidisabled && !permit)
			return STATUS_CLOSE
	. = ..()
	if(user.restrained())
		balloon_alert(user, "no free hands!")
		. = min(., STATUS_UPDATE)

/obj/machinery/power/apc/Topic(href, href_list)
	if(..())
		return 1

	// Rebooting doesn't require it to be unlocked
	if( href_list["reboot"] )
		failure_timer = 0
		update_icon()
		update()
		return 0

	if(!istype(usr, /mob/living/silicon) && (locked && !emagged))
		// Shouldn't happen, this is here to prevent href exploits
		balloon_alert(usr, "panel locked!")
		return 1

	if (href_list["lock"])
		coverlocked = !coverlocked

	else if (href_list["breaker"])
		toggle_breaker()

	else if (href_list["cmode"])
		set_chargemode(!chargemode)
		if(!chargemode)
			charging = 0
			update_icon()

	else if (href_list["eqp"])
		var/val = text2num(href_list["eqp"])
		equipment = setsubsystem(val)
		force_update_channels()

	else if (href_list["lgt"])
		var/val = text2num(href_list["lgt"])
		lighting = setsubsystem(val)
		force_update_channels()

	else if (href_list["env"])
		var/val = text2num(href_list["env"])
		environ = setsubsystem(val)
		force_update_channels()

	else if (href_list["overload"])
		if(istype(usr, /mob/living/silicon))
			src.overload_lighting()

	else if (href_list["toggleaccess"])
		if(istype(usr, /mob/living/silicon))
			if(emagged || (stat & (BROKEN|MAINT)))
				to_chat(usr, "The APC does not respond to the command.")
			else
				locked = !locked
				update_icon()

	return 0

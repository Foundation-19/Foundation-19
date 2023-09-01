// The Area Power Controller (APC)
// Controls and provides power to most electronics in an area
// Only one required per area
// Requires a wire connection to a power network through a terminal
// Generates a terminal based on the direction of the APC on spawn

// Main APC code
/obj/machinery/power/apc
	name = "area power controller"
	desc = "A control terminal for the area electrical systems."

	icon_state = "apc0"
	icon = 'icons/obj/apc.dmi'
	anchored = TRUE
	use_power = POWER_USE_IDLE // Has custom handling here.
	power_channel = LOCAL      // Do not manipulate this; you don't want to power the APC off itself.
	interact_offline = TRUE    // Can use UI even if unpowered
	uncreated_component_parts = list(
		/obj/item/stock_parts/power/terminal,
		/obj/item/stock_parts/power/apc,
		/obj/item/stock_parts/power/battery
		)
	req_access = list(ACCESS_ENGINEERING_LVL2)
	clicksound = SFX_MACHINE_SWITCH
	layer = ABOVE_WINDOW_LAYER
	var/needs_powerdown_sound
	var/area/area
	var/areastring = null
	var/cell_type = /obj/item/cell/standard
	var/opened = 0 //0=closed, 1=opened, 2=cover removed
	var/shorted = 0
	var/lighting = POWERCHAN_ON_AUTO
	var/equipment = POWERCHAN_ON_AUTO
	var/environ = POWERCHAN_ON_AUTO
	var/operating = 1       // Bool for main toggle.
	var/charging = 0        // Whether or not it's charging. 0 - not charging but not full, 1 - charging, 2 - full
	var/chargemode = 1      // Whether charging is toggled on or off.
	var/locked = 1
	var/coverlocked = 1     // Whether you can crowbar off the cover or need to swipe ID first.
	var/aidisabled = 0
	var/lastused_light = 0    // Internal stuff for UI and bookkeeping; can read off values but don't modify.
	var/lastused_equip = 0
	var/lastused_environ = 0
	var/lastused_charging = 0 // Not an actual channel, and not summed into total. How much battery was recharged, if any, last tick.
	var/lastused_total = 0
	var/main_status = 0     // UI var for whether we are getting external power. 0 = no external power at all, 1 = some, but not enough, 2 = getting enough.
	var/mob/living/silicon/ai/hacker = null // Malfunction var. If set AI hacked the APC and has full control.
	var/wiresexposed = FALSE // whether you can access the wires for hacking or not.
	powernet = 0		 // set so that APCs aren't found as powernet nodes //Hackish, Horrible, was like this before I changed it :(
	var/autoflag= 0		 // 0 = off, 1= eqp and lights off, 2 = eqp off, 3 = all on.
	var/has_electronics = 0 // 0 - none, 1 - plugged in, 2 - secured by screwdriver
	var/beenhit = 0 // used for counting how many times it has been hit, used for Aliens at the moment
	var/longtermpower = 10  // Counter to smooth out power state changes; do not modify.
	wires = /datum/wires/apc
	var/update_state = -1
	var/update_overlay = -1
	var/list/update_overlay_chan		// Used to determine if there is a change in channels
	var/is_critical = 0
	var/global/status_overlays = 0
	var/failure_timer = 0               // Cooldown thing for apc outage event
	var/force_update = 0
	var/global/list/status_overlays_lock
	var/global/list/status_overlays_charging
	var/global/list/status_overlays_equipment
	var/global/list/status_overlays_lighting
	var/global/list/status_overlays_environ
	var/auto_name = 1

/obj/machinery/power/apc/updateDialog()
	if (stat & (BROKEN|MAINT))
		return
	..()

/obj/machinery/power/apc/connect_to_network()
	//Override because the APC does not directly connect to the network; it goes through a terminal.
	//The terminal is what the power computer looks for anyway.
	var/obj/machinery/power/terminal/terminal = terminal()
	if(terminal)
		terminal.connect_to_network()

/obj/machinery/power/apc/drain_power(drain_check, surge, amount = 0)

	if(drain_check)
		return 1

	// Prevents APCs from being stuck on 0% cell charge while reporting "Fully Charged" status.
	charging = 0

	// If the APC's interface is locked, limit the charge rate to 25%.
	if(locked)
		amount /= 4

	return amount - use_power_oneoff(amount, LOCAL)

/obj/machinery/power/apc/Initialize(mapload, ndir, populate_parts = TRUE, building=0)
	// offset 22 pixels in direction of dir
	// this allows the APC to be embedded in a wall, yet still inside an area
	if (building)
		set_dir(ndir)

	if(areastring)
		area = get_area_name(areastring)
	else
		var/area/A = get_area(src)
		//if area isn't specified use current
		area = A
	if(auto_name)
		SetName("\improper [area.name] APC")

	if(area.apc)
		log_debug("Duplicate APC created at [AREACOORD(src)] [area.type]. Original at [AREACOORD(area.apc)] [area.type].")
	area.apc = src

	. = ..()

	if (building==0)
		init_round_start()
	else
		opened = 1
		operating = 0
		stat |= MAINT
		queue_icon_update()

	if(operating)
		force_update_channels()
	power_change()

/obj/machinery/power/apc/Destroy()
	src.update()
	area.apc = null
	area.power_light = 0
	area.power_equip = 0
	area.power_environ = 0
	area.power_change()

	// Malf AI, removes the APC from AI's hacked APCs list.
	if((hacker) && (hacker.hacked_apcs) && (src in hacker.hacked_apcs))
		hacker.hacked_apcs -= src

	return ..()

/obj/machinery/power/apc/get_req_access()
	if(!locked)
		return list()
	return ..()

/obj/machinery/power/apc/proc/energy_fail(duration)
	if(malf_upgraded)
		return
	failure_timer = max(failure_timer, round(duration))
	playsound(src, 'sounds/machines/apc_nopower.ogg', 75, 0)
	update()

/obj/machinery/power/apc/proc/init_round_start()
	has_electronics = 2 //installed and secured

	var/obj/item/stock_parts/power/battery/bat = get_component_of_type(/obj/item/stock_parts/power/battery)
	bat.add_cell(src, new cell_type(bat))
	var/obj/item/stock_parts/power/terminal/term = get_component_of_type(/obj/item/stock_parts/power/terminal)
	term.make_terminal(src)

	queue_icon_update()

/obj/machinery/power/apc/proc/terminal()
	var/obj/item/stock_parts/power/terminal/term = get_component_of_type(/obj/item/stock_parts/power/terminal)
	return term && term.terminal

/obj/machinery/power/apc/examine(mob/user, distance)
	. = ..()
	if(distance <= 1)
		if(stat & BROKEN)
			to_chat(user, "Looks broken.")
			return
		var/terminal = terminal()
		if(opened)
			if(has_electronics && terminal)
				to_chat(user, "The cover is [opened==2?"removed":"open"] and the power cell is [ get_cell() ? "installed" : "missing"].")
			else if (!has_electronics && terminal)
				to_chat(user, "There are some wires but no any electronics.")
			else if (has_electronics && !terminal)
				to_chat(user, "Electronics installed but not wired.")
			else /* if (!has_electronics && !terminal) */
				to_chat(user, "There is no electronics nor connected wires.")

		else
			if (stat & MAINT)
				to_chat(user, "The cover is closed. Something wrong with it: it doesn't work.")
			else if (hacker && !hacker.hacked_apcs_hidden)
				to_chat(user, "The cover is locked.")
			else
				to_chat(user, "The cover is closed.")

/obj/machinery/power/apc/components_are_accessible(path)
	. = opened
	if(ispath(path, /obj/item/stock_parts/power/terminal))
		. = min(., (has_electronics != 2))
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

/obj/machinery/power/apc/proc/report()
	var/obj/item/cell/cell = get_cell()
	return "[area.name] : [equipment]/[lighting]/[environ] ([lastused_equip+lastused_light+lastused_environ]) : [cell? cell.percent() : "N/C"] ([charging])"

/obj/machinery/power/apc/proc/update()
	if(operating && !shorted && !failure_timer)
		//prevent unnecessary updates to emergency lighting
		var/new_power_light = (lighting >= POWERCHAN_ON)
		if(area.power_light != new_power_light)
			area.power_light = new_power_light
			area.set_emergency_lighting(lighting == POWERCHAN_OFF_AUTO) //if lights go auto-off, emergency lights go on

		area.power_equip = (equipment >= POWERCHAN_ON)
		area.power_environ = (environ >= POWERCHAN_ON)
	else
		area.power_light = 0
		area.power_equip = 0
		area.power_environ = 0

	area.power_change()

	var/obj/item/cell/cell = get_cell()
	if(!cell || cell.charge <= 0)
		if(needs_powerdown_sound == TRUE)
			playsound(src, 'sounds/machines/apc_nopower.ogg', 75, 0)
			needs_powerdown_sound = FALSE
		else
			needs_powerdown_sound = TRUE

/obj/machinery/power/apc/proc/isWireCut(wire)
	return wires.is_cut(wire)

/obj/machinery/power/apc/proc/reset_wire(wire)
	switch(wire)
		if(WIRE_IDSCAN)
			locked = TRUE
		if(WIRE_MAIN_POWER1, WIRE_MAIN_POWER2)
			if(!wires.is_cut(WIRE_MAIN_POWER1) && !wires.is_cut(WIRE_MAIN_POWER2))
				shorted = FALSE
		if(WIRE_AI_CONTROL)
			if(!wires.is_cut(WIRE_AI_CONTROL))
				aidisabled = FALSE

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

/obj/machinery/power/apc/proc/force_update_channels()
	autoflag = -1 // This clears state, forcing a full recalculation
	update_channels(TRUE)
	update()
	queue_icon_update()

/obj/machinery/power/apc/proc/toggle_breaker()
	operating = !operating
	force_update_channels()

/obj/machinery/power/apc/get_power_usage()
	if(autoflag)
		return lastused_total // If not, we need to do something more sophisticated: compute how much power we would need in order to come back online.
	. = 0
	if(autoset(lighting, 2) >= POWERCHAN_ON)
		. += area.usage(LIGHT)
	if(autoset(equipment, 2) >= POWERCHAN_ON)
		. += area.usage(EQUIP)
	if(autoset(environ, 1) >= POWERCHAN_ON)
		. += area.usage(EQUIP)

/obj/machinery/power/apc/Process()
	if(!area.requires_power)
		return PROCESS_KILL

	if(stat & (BROKEN|MAINT))
		return

	if(failure_timer)
		queue_icon_update()
		failure_timer--
		force_update = 1
		return

	lastused_light = (lighting >= POWERCHAN_ON) ? area.usage(LIGHT) : 0
	lastused_equip = (equipment >= POWERCHAN_ON) ? area.usage(EQUIP) : 0
	lastused_environ = (environ >= POWERCHAN_ON) ? area.usage(ENVIRON) : 0
	area.clear_usage()

	lastused_total = lastused_light + lastused_equip + lastused_environ

	//store states to update icon if any change
	var/last_lt = lighting
	var/last_eq = equipment
	var/last_en = environ
	var/last_ch = charging

	var/obj/machinery/power/terminal/terminal = terminal()
	var/avail = (terminal && terminal.avail()) || 0
	var/excess = (terminal && terminal.surplus()) || 0

	if(!avail)
		main_status = 0
	else if(excess < 0)
		main_status = 1
	else
		main_status = 2

	var/obj/item/cell/cell = get_cell()
	if(!cell || shorted) // We aren't going to be doing any power processing in this case.
		charging = 0
	else
		..() // Actual processing happens in here.

		//update state
		var/obj/item/stock_parts/power/battery/power = get_component_of_type(/obj/item/stock_parts/power/battery)
		lastused_charging = max(power && power.cell && (power.cell.charge - power.last_cell_charge) * CELLRATE, 0)
		charging = lastused_charging ? 1 : 0
		if(cell.fully_charged())
			charging = 2

		if(stat & NOPOWER)
			power_change() // We are the ones responsible for triggering listeners once power returns, so we run this to detect possible changes.

	// Set channels depending on how much charge we have left
	update_channels()

	// update icon & area power if anything changed
	if(last_lt != lighting || last_eq != equipment || last_en != environ || force_update)
		force_update = 0
		queue_icon_update()
		update()
	else if (last_ch != charging)
		queue_icon_update()

/obj/machinery/power/apc/proc/update_channels(suppress_alarms = FALSE)
	// Allow the APC to operate as normal if the cell can charge
	if(charging && longtermpower < 10)
		longtermpower += 1
	else if(longtermpower > -10)
		longtermpower -= 2
	var/obj/item/cell/cell = get_cell()
	var/percent = cell && cell.percent()

	if(!cell || shorted || (stat & NOPOWER) || !operating)
		if(autoflag != 0)
			equipment = autoset(equipment, 0)
			lighting = autoset(lighting, 0)
			environ = autoset(environ, 0)
			if(!suppress_alarms)
				GLOB.power_alarm.triggerAlarm(loc, src)
			autoflag = 0
	else if((percent > AUTO_THRESHOLD_LIGHTING) || longtermpower >= 0)              // Put most likely at the top so we don't check it last, effeciency 101
		if(autoflag != 3)
			equipment = autoset(equipment, 1)
			lighting = autoset(lighting, 1)
			environ = autoset(environ, 1)
			autoflag = 3
			GLOB.power_alarm.clearAlarm(loc, src)
	else if((percent <= AUTO_THRESHOLD_LIGHTING) && (percent > AUTO_THRESHOLD_EQUIPMENT) && longtermpower < 0)                       // <50%, turn off lighting
		if(autoflag != 2)
			equipment = autoset(equipment, 1)
			lighting = autoset(lighting, 2)
			environ = autoset(environ, 1)
			if(!suppress_alarms)
				GLOB.power_alarm.triggerAlarm(loc, src)
			autoflag = 2
	else if(percent <= AUTO_THRESHOLD_EQUIPMENT)        // <25%, turn off lighting & equipment
		if(autoflag != 1)
			equipment = autoset(equipment, 2)
			lighting = autoset(lighting, 2)
			environ = autoset(environ, 1)
			if(!suppress_alarms)
				GLOB.power_alarm.triggerAlarm(loc, src)
			autoflag = 1

// val 0=off, 1=off(auto) 2=on 3=on(auto)
// on 0=off, 1=on, 2=autooff
// defines a state machine, returns the new state
/obj/machinery/power/apc/proc/autoset(cur_state, on)
	//autoset will never turn on a channel set to off
	switch(cur_state)
		if(POWERCHAN_OFF_TEMP)
			if(on == 1 || on == 2)
				return POWERCHAN_ON
		if(POWERCHAN_OFF_AUTO)
			if(on == 1)
				return POWERCHAN_ON_AUTO
		if(POWERCHAN_ON)
			if(on == 0)
				return POWERCHAN_OFF_TEMP
		if(POWERCHAN_ON_AUTO)
			if(on == 0 || on == 2)
				return POWERCHAN_OFF_AUTO

	return cur_state //leave unchanged

/obj/machinery/power/apc/proc/reboot()
	//reset various counters so that process() will start fresh
	charging = initial(charging)
	autoflag = initial(autoflag)
	longtermpower = initial(longtermpower)
	failure_timer = initial(failure_timer)

	//start with main breaker off, chargemode in the default state and all channels on auto upon reboot
	operating = 0

	set_chargemode(initial(chargemode))
	GLOB.power_alarm.clearAlarm(loc, src)

	lighting = POWERCHAN_ON_AUTO
	equipment = POWERCHAN_ON_AUTO
	environ = POWERCHAN_ON_AUTO

	force_update_channels()

/obj/machinery/power/apc/proc/set_chargemode(new_mode)
	chargemode = new_mode
	var/obj/item/stock_parts/power/battery/power = get_component_of_type(/obj/item/stock_parts/power/battery)
	if(power)
		power.can_charge = chargemode
		power.charge_wait_counter = initial(power.charge_wait_counter)

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

/obj/machinery/power/apc/proc/setsubsystem(val)
	switch(val)
		if(2)
			return POWERCHAN_OFF_AUTO
		if(1)
			return POWERCHAN_OFF_TEMP
		else
			return POWERCHAN_OFF

/obj/machinery/power/apc/proc/update_name(updates)
	if(auto_name)
		SetName("\improper [get_area_name(area, TRUE)] APC")

/obj/item/power_control_module
	name = "power control module"
	desc = "Heavy-duty switching circuits for power control."
	icon = 'icons/obj/module.dmi'
	icon_state = "power_mod"
	item_state = "electronic"
	matter = list(MATERIAL_STEEL = 50, MATERIAL_GLASS = 50)
	w_class = ITEM_SIZE_SMALL
	obj_flags = OBJ_FLAG_CONDUCTIBLE

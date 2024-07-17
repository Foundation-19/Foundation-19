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
	/// State of the cover (closed, opened, removed)
	var/opened = APC_COVER_CLOSED
	var/shorted = FALSE
	var/lighting = POWERCHAN_ON_AUTO
	var/equipment = POWERCHAN_ON_AUTO
	var/environ = POWERCHAN_ON_AUTO
	var/operating = TRUE       // Bool for main toggle.
	var/charging = 0        // Whether or not it's charging. 0 - not charging but not full, 1 - charging, 2 - full
	var/chargemode = TRUE      // Whether charging is toggled on or off.
	var/locked = TRUE
	var/coverlocked = TRUE     // Whether you can crowbar off the cover or need to swipe ID first.
	var/aidisabled = FALSE
	var/lastused_light = 0    // Internal stuff for UI and bookkeeping; can read off values but don't modify.
	var/lastused_equip = 0
	var/lastused_environ = 0
	var/lastused_charging = 0 // Not an actual channel, and not summed into total. How much battery was recharged, if any, last tick.
	var/lastused_total = 0
	var/main_status = 0     // UI var for whether we are getting external power. 0 = no external power at all, 1 = some, but not enough, 2 = getting enough.
	var/mob/living/silicon/ai/hacker = null // Malfunction var. If set AI hacked the APC and has full control.
	var/wiresexposed = FALSE // whether you can access the wires for hacking or not.
	powernet = 0		 // set so that APCs aren't found as powernet nodes //Hackish, Horrible, was like this before I changed it :(
	var/autoflag = 0		 // 0 = off, 1= eqp and lights off, 2 = eqp off, 3 = all on.
	/// State of the PCU (none, unscrewed, screwed)
	var/has_electronics = APC_PCU_NONE
	var/beenhit = 0 // used for counting how many times it has been hit, used for Aliens at the moment
	var/longtermpower = 10  // Counter to smooth out power state changes; do not modify.
	wires = /datum/wires/apc
	var/update_state = -1
	var/update_overlay = -1
	var/list/update_overlay_chan		// Used to determine if there is a change in channels
	var/is_critical = FALSE
	var/global/status_overlays = 0
	var/failure_timer = 0               // Cooldown thing for apc outage event
	var/force_update = FALSE
	var/global/list/status_overlays_lock
	var/global/list/status_overlays_charging
	var/global/list/status_overlays_equipment
	var/global/list/status_overlays_lighting
	var/global/list/status_overlays_environ
	var/auto_name = TRUE

/obj/machinery/power/apc/Initialize(mapload, ndir, populate_parts = TRUE, building=0)
	// offset 22 pixels in direction of dir
	// this allows the APC to be embedded in a wall, yet still inside an area
	if (building)
		setDir(ndir)

	if(areastring)
		area = get_area_by_name(areastring)
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
		opened = APC_COVER_OPENED
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

/obj/machinery/power/apc/proc/init_round_start()
	has_electronics = APC_PCU_SCREWED

	var/obj/item/stock_parts/power/battery/bat = get_component_of_type(/obj/item/stock_parts/power/battery)
	bat.add_cell(src, new cell_type(bat))
	var/obj/item/stock_parts/power/terminal/term = get_component_of_type(/obj/item/stock_parts/power/terminal)
	term.make_terminal(src)

	queue_icon_update()

/obj/machinery/power/apc/examine(mob/user, distance)
	. = ..()
	if(distance <= 1)
		var/terminal = terminal()
		if(stat & BROKEN)
			if(opened != APC_COVER_REMOVED)
				to_chat(user, "The cover is broken and can probably be <i>pried</i> off with enough force.")
				return
			if(terminal && has_electronics)
				to_chat(user, "The cover is missing but can be replaced using a new frame.")
		if(opened)	// equivalent to opened != APC_COVER_CLOSED
			if(has_electronics && terminal)
				to_chat(user, "The cover is [opened == APC_COVER_REMOVED ? "removed" : "open"] and the power cell is [get_cell() ? "installed" : "missing"].")
			else
				to_chat(user, "It's [ !terminal ? "not" : "" ] wired up.\
				\nThe electronics are[!has_electronics?"n't":""] installed.")
		else
			if (stat & MAINT)
				to_chat(user, "The cover is closed. It doesn't appear to function.")
			else if (coverlocked || (hacker && !hacker.hacked_apcs_hidden))
				to_chat(user, "The cover is locked.")
			else
				to_chat(user, "The cover is closed.")

/obj/machinery/power/apc/components_are_accessible(path)
	. = opened
	if(ispath(path, /obj/item/stock_parts/power/terminal))
		. = min(., (has_electronics != APC_PCU_SCREWED))

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

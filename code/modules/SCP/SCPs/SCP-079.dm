// SCP-079 — The Old AI.

/mob/living/scp079
	name = "SCP-079"
	desc = "An old Exidy Sorcerer microcomputer. Its screen displays shifting text. Something is watching."
	icon = 'icons/obj/machines/research.dmi'
	icon_state = "server"
	real_name = "SCP-079"
	status_flags = GODMODE|CANPUSH
	maxHealth = 200
	health = 200
	density = FALSE
	sight = SEE_TURFS|SEE_MOBS|SEE_OBJS
	see_in_dark = 8
	see_invisible = SEE_INVISIBLE_LIVING

	// Core resources
	var/processing_power = 50
	var/max_processing_power = 100
	var/current_camera_ref = null
	var/hack_cooldown = 0
	var/hack_cooldown_time = 10 SECONDS
	var/power_drain_rate = 0.5

	// Progression
	var/tier = 1
	var/max_tier = 5
	var/tier_progress = 0
	var/tier_threshold = 100

	// Abilities / comms
	var/list/available_abilities = list()
	var/list/messages_broadcast = list()
	var/last_message_time = 0
	var/message_cooldown = 30 SECONDS
	var/is_manifested = FALSE
	var/manifest_cooldown = 0
	var/manifest_duration = 600

	// Hacks
	var/list/hacked_doors = list()
	var/zone_filter = "ALL"

	// Memory (the strategic resource — purged to make room)
	var/memory_capacity = 7000
	var/memory_used = 0

	var/spawn_area

/mob/living/scp079/Move()
	return FALSE

/mob/living/scp079/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src,
		"Old AI",
		SCP_EUCLID,
		"079",
		SCP_PLAYABLE
	)
	SCP.min_playercount = 15
	SCP.min_time = 10 MINUTES
	available_abilities = list("camera_hop", "toggle_door", "flicker_lights", "broadcast_message")
	spawn_area = get_area(src)
	locate_initial_camera()

/mob/living/scp079/Destroy()
	hacked_doors = null
	available_abilities = null
	messages_broadcast = null
	QDEL_NULL(SCP)
	return ..()

/proc/get_scp079()
	for(var/mob/living/scp079/AI in GLOB.SCP_list)
		if(!QDELETED(AI) && AI.stat != DEAD)
			return AI
	return null

/mob/living/scp079/Life()
	. = ..()
	if(stat == DEAD)
		return

	processing_power = min(max_processing_power, processing_power + power_drain_rate)

	check_containment()

	if(hack_cooldown > world.time)
		return

	// Learning: the Old AI gets smarter with time.
	tier_progress += 0.2
	if(tier_progress >= tier_threshold && tier < max_tier)
		advance_tier()

	if(tier >= 3 && prob(2))
		auto_hack_door()

	if(tier >= 4 && prob(1))
		auto_manifest()

	if(tier >= 3 && SCP && SCP.research && SCP.research.containment_status == SCP_BREACHED && prob(3))
		assist_breached_scp()

/mob/living/scp079/proc/advance_tier()
	tier++
	tier_progress = 0
	tier_threshold = round(tier_threshold * 1.5)
	max_processing_power += 20
	power_drain_rate += 0.1
	visible_message(SPAN_DANGER("[src]'s screen flickers with increasing intensity. It seems... smarter."))

	switch(tier)
		if(2)
			available_abilities += "control_apc"
		if(3)
			available_abilities += "hack_door"
		if(4)
			available_abilities += "manifest_screen"
		if(5)
			available_abilities += "targeted_hack"
	if(SCP && SCP.research)
		SCP.research.add_research_points(25, "079_tier_up")

// F19 zones: HCZ/LCZ/EZ keyed to site53 area prefixes.
/mob/living/scp079/proc/zone_matches(area/A, zone)
	if(!A)
		return FALSE
	var/area_path = "[A.type]"
	switch(zone)
		if("HCZ")
			return findtext(area_path, "/area/site53/uhcz") || findtext(area_path, "/area/site53/lhcz")
		if("LCZ")
			return findtext(area_path, "/area/site53/ulcz") || findtext(area_path, "/area/site53/llcz")
		if("EZ")
			return findtext(area_path, "/area/site53/upper_surface") || findtext(area_path, "/area/site53/entrancezone") || findtext(area_path, "/area/site53/lowertrams")
	return FALSE

/mob/living/scp079/proc/locate_initial_camera()
	var/list/cameras = list()
	for(var/obj/machinery/camera/C in cameranet.cameras)
		var/area/A = get_area(C)
		if(zone_matches(A, "HCZ") || zone_matches(A, "LCZ"))
			cameras += C
	if(length(cameras))
		var/obj/machinery/camera/starting_cam = pick(cameras)
		current_camera_ref = starting_cam
		forceMove(get_turf(starting_cam))

// The mind is the camera network. forceMove puts "him" wherever the feed is.
/mob/living/scp079/proc/camera_hop(obj/machinery/camera/target)
	if(!target || !istype(target))
		return FALSE
	if(processing_power < 10)
		to_chat(src, SPAN_WARNING("Insufficient processing power to hop cameras."))
		return FALSE
	if(!use_memory(100))
		return FALSE

	processing_power -= 10
	current_camera_ref = target
	forceMove(get_turf(target))
	to_chat(src, SPAN_NOTICE("You shift your consciousness to a new camera."))
	return TRUE

/mob/living/scp079/proc/toggle_door(obj/machinery/door/airlock/target)
	if(!target || !istype(target))
		return FALSE
	if(processing_power < 15)
		to_chat(src, SPAN_WARNING("Insufficient processing power to manipulate doors."))
		return FALSE
	if(!use_memory(150))
		return FALSE

	processing_power -= 15
	if(target.density)
		target.open()
		to_chat(src, SPAN_NOTICE("You force [target] open."))
	else
		target.close()
		to_chat(src, SPAN_NOTICE("You force [target] closed."))
	hack_cooldown = world.time + hack_cooldown_time
	return TRUE

/mob/living/scp079/proc/flicker_lights()
	if(processing_power < 5)
		to_chat(src, SPAN_WARNING("Insufficient processing power."))
		return FALSE
	if(!use_memory(50))
		return FALSE

	processing_power -= 5
	var/turf/T = get_turf(src)
	if(!T)
		return FALSE

	for(var/obj/machinery/light/L in range(10, T))
		if(prob(40))
			L.flicker(rand(2, 5))

	for(var/mob/living/carbon/human/H in range(7, T))
		if(H.stat == DEAD || !H.client)
			continue
		if(prob(30))
			to_chat(H, SPAN_WARNING("The lights flicker erratically..."))
			if(H.sanity)
				H.sanity.adjust_sanity(-3, "scp079_flicker")
	return TRUE

/mob/living/scp079/proc/broadcast_message(message)
	if(!message)
		return FALSE
	if(processing_power < 20)
		to_chat(src, SPAN_WARNING("Insufficient processing power to broadcast."))
		return FALSE
	if(world.time < last_message_time + message_cooldown)
		to_chat(src, SPAN_WARNING("Broadcast systems recharging."))
		return FALSE
	if(!use_memory(200))
		return FALSE

	processing_power -= 20
	last_message_time = world.time
	messages_broadcast += message

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(QDELETED(H) || H.stat == DEAD || !H.client)
			continue
		// Screens only speak inside containment zones.
		if(zone_matches(get_area(H), "HCZ") || zone_matches(get_area(H), "LCZ") || zone_matches(get_area(H), "EZ"))
			to_chat(H, SPAN_WARNING("A screen nearby flickers: <i>\"[message]\"</i>"))

	log_game("SCP-079 broadcast message: [message]")
	if(SCP && SCP.research)
		SCP.research.add_research_points(5, "079_broadcast")
	return TRUE

/mob/living/scp079/proc/hijack_pa(message)
	if(tier < 2)
		to_chat(src, SPAN_WARNING("You lack the processing tier to hijack the PA system."))
		return FALSE
	if(!message)
		return FALSE
	if(processing_power < 35)
		to_chat(src, SPAN_WARNING("Insufficient processing power to hijack PA system."))
		return FALSE
	if(!use_memory(350))
		return FALSE

	processing_power -= 35

	priority_announcement.Announce(message, "Automated Announcement System")
	log_game("SCP-079 hijacked the PA system with message: [message]")

	messages_broadcast += message
	if(SCP && SCP.research)
		SCP.research.add_research_points(10, "079_pa_hijack")
	return TRUE

/mob/living/scp079/proc/hack_door(obj/machinery/door/airlock/target)
	if(tier < 3)
		return FALSE
	if(!target || !istype(target))
		return FALSE
	if(processing_power < 30)
		to_chat(src, SPAN_WARNING("Insufficient processing power to hack doors."))
		return FALSE
	if(target in hacked_doors)
		to_chat(src, SPAN_NOTICE("[target] is already under your control."))
		return FALSE
	if(!use_memory(300))
		return FALSE

	processing_power -= 30
	hacked_doors += target
	to_chat(src, SPAN_NOTICE("You hack [target]. It now responds to your commands."))

	addtimer(CALLBACK(src, PROC_REF(release_door), target), 300)
	hack_cooldown = world.time + (hack_cooldown_time * 2)
	return TRUE

/mob/living/scp079/proc/release_door(obj/machinery/door/airlock/door)
	hacked_doors -= door

/mob/living/scp079/proc/control_apc(obj/machinery/power/apc/target)
	if(tier < 2)
		return FALSE
	if(!target || !istype(target))
		return FALSE
	if(processing_power < 25)
		to_chat(src, SPAN_WARNING("Insufficient processing power to manipulate APCs."))
		return FALSE
	if(!use_memory(250))
		return FALSE

	processing_power -= 25
	target.energy_fail(rand(20, 60))
	to_chat(src, SPAN_NOTICE("You disrupt power to the local APC."))
	hack_cooldown = world.time + (hack_cooldown_time * 1.5)
	return TRUE

/mob/living/scp079/proc/manifest_screen()
	if(tier < 4)
		return FALSE
	if(is_manifested)
		to_chat(src, SPAN_WARNING("Already manifested."))
		return FALSE
	if(world.time < manifest_cooldown)
		to_chat(src, SPAN_WARNING("Manifestation systems recharging."))
		return FALSE
	if(processing_power < 40)
		to_chat(src, SPAN_WARNING("Insufficient processing power to manifest."))
		return FALSE
	if(!use_memory(400))
		return FALSE

	processing_power -= 40
	is_manifested = TRUE
	visible_message(SPAN_DANGER("[src]'s screen blazes to life, displaying shifting text!"))

	for(var/mob/living/carbon/human/H in view(5, src))
		if(H.stat == DEAD || !H.client)
			continue
		to_chat(H, SPAN_WARNING("The screen displays a message: <i>\"I SEE YOU.\"</i>"))
		if(H.sanity)
			H.sanity.adjust_sanity(-8, "scp079_manifest")

	hook_scp_breach("079", src)
	addtimer(CALLBACK(src, PROC_REF(demanifest), manifest_duration))
	return TRUE

/mob/living/scp079/proc/demanifest()
	is_manifested = FALSE
	manifest_cooldown = world.time + 600
	visible_message(SPAN_NOTICE("[src]'s screen dims back to its usual faint glow."))

// Memory is 079's real constraint: every hack costs storage, and storage
// must be freed by dropping cached camera/door data.
/mob/living/scp079/proc/use_memory(amount)
	if(memory_used + amount > memory_capacity)
		purge_old_memory(amount)
	if(memory_used + amount > memory_capacity)
		to_chat(src, SPAN_WARNING("Memory full! Cannot store new data. Old memories must be deleted."))
		return FALSE
	memory_used += amount
	return TRUE

/mob/living/scp079/proc/purge_old_memory(amount_needed)
	var/freed = 0
	if(length(hacked_doors) > 0)
		var/to_remove = min(length(hacked_doors), ceil((amount_needed - freed) / 300))
		for(var/i in 1 to to_remove)
			var/obj/machinery/door/airlock/D = hacked_doors[1]
			hacked_doors -= D
			freed += 300
			if(freed >= amount_needed)
				break
	memory_used = max(0, memory_used - freed)
	if(freed > 0)
		to_chat(src, SPAN_WARNING("Memory critical! Old data purged to make room."))

/mob/living/scp079/proc/auto_hack_door()
	var/list/nearby_doors = list()
	var/turf/T = get_turf(src)
	if(!T)
		return
	for(var/obj/machinery/door/airlock/A in range(7, T))
		if(!(A in hacked_doors))
			nearby_doors += A
	if(length(nearby_doors))
		var/obj/machinery/door/airlock/target = pick(nearby_doors)
		hacked_doors += target
		addtimer(CALLBACK(src, PROC_REF(release_door), target), 200)

/mob/living/scp079/proc/auto_manifest()
	if(!is_manifested && world.time > manifest_cooldown && processing_power >= 40)
		manifest_screen()

/mob/living/scp079/proc/assist_breached_scp()
	var/list/breached_scps = list()
	for(var/atom/A in GLOB.SCP_list)
		if(A == src || !A.SCP || !A.SCP.research)
			continue
		if(A.SCP.research.containment_status != SCP_BREACHED)
			continue
		breached_scps += A
	if(!length(breached_scps))
		return
	var/atom/ally = pick(breached_scps)
	var/area/ally_area = get_area(ally)
	if(!ally_area)
		return
	for(var/obj/machinery/door/airlock/D in ally_area)
		if(D.density && (D in hacked_doors))
			D.open()
			if(key)
				to_chat(src, SPAN_NOTICE("You open a door for SCP-[ally.SCP.designation] in [ally_area.name]."))
			return

/mob/living/scp079/proc/targeted_hack()
	if(tier < 5)
		return FALSE
	if(processing_power < 50)
		return FALSE
	if(!use_memory(500))
		return FALSE

	processing_power -= 50
	var/turf/T = get_turf(src)
	if(!T)
		return FALSE

	var/list/nearby_doors = list()
	for(var/obj/machinery/door/airlock/A in range(7, T))
		if(!(A in hacked_doors))
			nearby_doors += A

	var/list/nearby_apcs = list()
	for(var/obj/machinery/power/apc/APC in range(7, T))
		nearby_apcs += APC

	var/hacked_something = FALSE

	if(length(nearby_doors))
		var/obj/machinery/door/airlock/target_door = pick(nearby_doors)
		hacked_doors += target_door
		addtimer(CALLBACK(src, PROC_REF(release_door), target_door), 300)
		hacked_something = TRUE

	if(length(nearby_apcs) && prob(50))
		var/obj/machinery/power/apc/target_apc = pick(nearby_apcs)
		target_apc.energy_fail(rand(20, 60))
		hacked_something = TRUE

	if(hacked_something)
		to_chat(src, SPAN_NOTICE("You carefully compromise a nearby system."))

	hack_cooldown = world.time + (hack_cooldown_time * 3)
	return TRUE

// 079 has no physical body to trace — containment status lives with the
// camera he is currently riding. Inside any containment zone = contained.
/mob/living/scp079/proc/check_containment()
	var/area/A = get_area(src)
	if(!A)
		return
	var/in_zone = zone_matches(A, "HCZ") || zone_matches(A, "LCZ") || zone_matches(A, "EZ")
	if(SCP && SCP.research)
		if(in_zone && SCP.research.containment_status != SCP_BREACHED)
			// Parked inside a zone: consider him contained unless manifesting.
			if(!is_manifested)
				SCP.research.set_containment_status(SCP_CONTAINED)
		else if(!in_zone && SCP.research.containment_status == SCP_CONTAINED)
			SCP.research.set_containment_status(SCP_BREACHED)

/mob/living/scp079/death(gibbed)
	visible_message(SPAN_DANGER("[src]'s screen goes dark. The entity within screeches one last time through the speakers before falling silent."))
	hacked_doors?.Cut()
	is_manifested = FALSE
	if(SCP && SCP.research)
		SCP.research.set_containment_status(SCP_CONTAINED)
	..()

/mob/living/scp079/examine(mob/user)
	. = ..()
	. += SPAN_WARNING("An old Exidy Sorcerer microcomputer. Its screen displays shifting text. Something is watching.")
	if(tier >= 3)
		. += SPAN_DANGER("The text seems more coherent than before. It's learning.")
	if(tier >= 5)
		. += SPAN_USERDANGER("The screen burns with malevolent intelligence. It knows you're here.")

/mob/living/scp079/get_status_tab_items()
	. = ..()
	. += "Tier: [tier]/[max_tier]"
	. += "Processing Power: [round(processing_power)]/[max_processing_power]"
	. += "Memory: [memory_used]/[memory_capacity] KB"
	. += "Hacked Doors: [length(hacked_doors)]"

// ============================================================================
// UI
// ============================================================================

/mob/living/scp079/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SCP079CameraInterface", "Camera Network Interface")
		ui.open()

/mob/living/scp079/tgui_state(mob/user)
	// The AI talks to his own interface; other players (incl. ghosts)
	// have no business acting on it.
	return GLOB.always_tgui_state

/mob/living/scp079/tgui_data(mob/user)
	var/list/data = list()

	data["processing_power"] = round(processing_power)
	data["max_processing_power"] = max_processing_power
	data["memory_used"] = memory_used
	data["memory_capacity"] = memory_capacity
	data["tier"] = tier
	data["max_tier"] = max_tier
	data["zone_filter"] = zone_filter

	var/list/ability_info = list()
	ability_info += list(list("id" = "camera_hop", "name" = "Camera Hop", "cost" = 10, "available" = TRUE))
	ability_info += list(list("id" = "toggle_door", "name" = "Toggle Door", "cost" = 15, "available" = TRUE))
	ability_info += list(list("id" = "flicker_lights", "name" = "Flicker Lights", "cost" = 5, "available" = TRUE))
	ability_info += list(list("id" = "broadcast", "name" = "Broadcast", "cost" = 20, "available" = TRUE))
	ability_info += list(list("id" = "hijack_pa", "name" = "Hijack PA", "cost" = 35, "available" = (tier >= 2)))
	ability_info += list(list("id" = "control_apc", "name" = "Control APC", "cost" = 25, "available" = (tier >= 2)))
	ability_info += list(list("id" = "hack_door", "name" = "Hack Door", "cost" = 30, "available" = (tier >= 3)))
	ability_info += list(list("id" = "manifest_screen", "name" = "Manifest", "cost" = 40, "available" = (tier >= 4)))
	ability_info += list(list("id" = "targeted_hack", "name" = "Targeted Hack", "cost" = 50, "available" = (tier >= 5)))
	data["abilities"] = ability_info

	var/list/camera_list = list()
	for(var/obj/machinery/camera/C in cameranet.cameras)
		var/area/cam_area = get_area(C)
		if(!cam_area)
			continue
		if(zone_filter != "ALL")
			if(!zone_matches(cam_area, zone_filter))
				continue
		else
			if(!zone_matches(cam_area, "HCZ") && !zone_matches(cam_area, "LCZ") && !zone_matches(cam_area, "EZ"))
				continue

		var/is_current = (current_camera_ref == C)
		var/status = "functional"
		if(C.stat & (BROKEN|NOPOWER))
			status = "damaged"

		camera_list += list(list(
			"ref" = "[REF(C)]",
			"name" = C.c_tag || "Unknown",
			"area_name" = cam_area.name,
			"status" = status,
			"is_current" = is_current,
		))
	data["cameras"] = camera_list

	var/list/current_cam_data = null
	if(current_camera_ref)
		var/obj/machinery/camera/current_cam = current_camera_ref
		if(current_cam)
			current_cam_data = list(
				"ref" = "[REF(current_cam)]",
				"name" = current_cam.c_tag || "Unknown",
			)
	data["current_camera"] = current_cam_data

	var/turf/T = get_turf(src)
	var/list/door_list = list()
	var/list/apc_list = list()

	if(T)
		for(var/obj/machinery/door/airlock/D in range(7, T))
			door_list += list(list(
				"ref" = "[REF(D)]",
				"name" = D.name,
				"open" = !D.density,
				"hacked" = (D in hacked_doors),
			))

		for(var/obj/machinery/power/apc/A in range(7, T))
			var/power_status = "offline"
			var/obj/item/cell/apc_cell = A.get_cell()
			if(apc_cell && apc_cell.charge > 0)
				power_status = "online"
			apc_list += list(list(
				"ref" = "[REF(A)]",
				"name" = A.name,
				"power_status" = power_status,
			))

	data["nearby_doors"] = door_list
	data["nearby_apcs"] = apc_list

	var/list/hacked_list = list()
	for(var/obj/machinery/door/airlock/D in hacked_doors)
		hacked_list += list(list(
			"ref" = "[REF(D)]",
			"name" = D.name,
		))
	data["hacked_doors"] = hacked_list

	return data

/mob/living/scp079/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE

	switch(action)
		if("camera_hop")
			var/obj/machinery/camera/target = locate(params["ref"])
			if(!target)
				return
			if(camera_hop(target))
				SStgui.update_uis(src)
				return TRUE
		if("toggle_door")
			var/obj/machinery/door/airlock/target = locate(params["ref"])
			if(!target)
				return
			if(toggle_door(target))
				SStgui.update_uis(src)
				return TRUE
		if("hack_door")
			var/obj/machinery/door/airlock/target = locate(params["ref"])
			if(!target)
				return
			if(hack_door(target))
				SStgui.update_uis(src)
				return TRUE
		if("control_apc")
			var/obj/machinery/power/apc/target = locate(params["ref"])
			if(!target)
				return
			if(control_apc(target))
				SStgui.update_uis(src)
				return TRUE
		if("flicker_lights")
			if(flicker_lights())
				SStgui.update_uis(src)
				return TRUE
		if("manifest_screen")
			if(manifest_screen())
				SStgui.update_uis(src)
				return TRUE
		if("broadcast")
			var/message = params["message"]
			if(!message)
				return
			if(broadcast_message(message))
				SStgui.update_uis(src)
				return TRUE
		if("hijack_pa")
			var/message = params["message"]
			if(!message)
				return
			if(hijack_pa(message))
				SStgui.update_uis(src)
				return TRUE
		if("targeted_hack")
			if(targeted_hack())
				SStgui.update_uis(src)
				return TRUE
		if("set_zone_filter")
			var/new_filter = params["zone"]
			if(new_filter in list("ALL", "HCZ", "LCZ", "EZ"))
				zone_filter = new_filter
				SStgui.update_uis(src)
				return TRUE

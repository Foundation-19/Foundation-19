// Recontainment machinery suite for Foundation-19.
// Ported from daedalusdock scp_recontainment.dm, adapted:
//  - keyed to F19's designation-based SCP registry (GLOB.SCP_list + datum/scp)
//  - hooks call our hook_scp_recontained() so persistence/announcements fire
//  - machines: femur breaker (106), 049 cure station, 457 suppression,
//    939 dampener, 008 incinerator, 1507 speaker

/proc/find_scp_atom_by_designation(designation)
	for(var/atom/A in GLOB.SCP_list)
		if(A.SCP && A.SCP.designation == designation)
			return A
	return null

// Base for all recontainment devices: powered machinery with an activation
// cycle that ends in a recontainment hook.
/obj/machinery/scp_recontainment
	name = "recontainment device"
	icon = 'icons/obj/machines/research.dmi'
	density = TRUE
	anchored = TRUE
	use_power = POWER_USE_IDLE
	idle_power_usage = 100
	var/target_designation = ""
	var/active = FALSE
	var/active_until = 0
	var/activate_duration = 30 SECONDS
	var/requires_power = TRUE

/obj/machinery/scp_recontainment/Initialize()
	. = ..()
	register_recontainment_device(src)

GLOBAL_LIST_EMPTY(recontainment_devices)

/proc/register_recontainment_device(obj/machinery/scp_recontainment/R)
	GLOB.recontainment_devices |= R

/proc/find_recontainment_device_for(designation)
	for(var/obj/machinery/scp_recontainment/R in GLOB.recontainment_devices)
		if(R.target_designation == designation && !(R.stat & (BROKEN|NOPOWER)))
			return R
	return null

// Process for all devices: finish activation cycles.
/obj/machinery/scp_recontainment/Process()
	if(active && world.time >= active_until)
		finish_activation()

/obj/machinery/scp_recontainment/proc/start_activation(mob/user)
	if(active)
		to_chat(user, SPAN_WARNING("\The [src] is already running a cycle."))
		return
	if(requires_power && (stat & (BROKEN|NOPOWER)))
		to_chat(user, SPAN_WARNING("\The [src] is unpowered or broken."))
		return
	active = TRUE
	active_until = world.time + activate_duration
	on_activation(user)
	update_icon()

/obj/machinery/scp_recontainment/proc/on_activation(mob/user)
	return

/obj/machinery/scp_recontainment/proc/finish_activation()
	active = FALSE
	on_completion()
	update_icon()

/obj/machinery/scp_recontainment/proc/on_completion()
	return

/obj/machinery/scp_recontainment/proc/lure_scp(atom/scp_atom)
	// Pull the SCP toward this device over the activation window.
	if(!scp_atom)
		return
	var/turf/T = get_turf(src)
	var/atom/movable/AM = scp_atom
	if(istype(AM))
		AM.visible_message(SPAN_DANGER("\The [AM] is drawn toward \the [src]!"))
		var/turf/next = get_step_towards(AM, T)
		if(next && next != get_turf(AM))
			AM.forceMove(next)

// ============================================================================
// SCP-106 FEMUR BREAKER

/obj/machinery/scp_recontainment/femur_breaker
	name = "Femur Breaker"
	desc = "A containment device used to lure SCP-106 back to its cell. Requires a human subject."
	icon_state = "protolathe"
	target_designation = "106"
	activate_duration = 75 SECONDS
	var/occupied = FALSE
	var/mob/living/carbon/human/victim
	var/lure_pending = FALSE

/obj/machinery/scp_recontainment/femur_breaker/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ScpFemurBreaker", "SCP-106 FEMUR BREAKER")
		ui.open()

/obj/machinery/scp_recontainment/femur_breaker/tgui_data(mob/user)
	var/list/data = list()
	data["occupied"] = occupied
	data["active"] = active
	data["victim_name"] = victim ? victim.real_name : "None"
	data["victim_health"] = victim ? round((victim.health / victim.maxHealth) * 100) : 0
	var/atom/movable/scp106 = find_scp_atom_by_designation("106")
	var/status = "unknown"
	if(scp106 && scp106.SCP.research)
		status = scp106.SCP.research.containment_status
	data["scp106_status"] = status
	return data

/obj/machinery/scp_recontainment/femur_breaker/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	switch(action)
		if("enter")
			if(occupied || !ishuman(usr))
				return
			occupied = TRUE
			victim = usr
			usr.forceMove(src)
			usr.visible_message(SPAN_DANGER("[usr] enters the Femur Breaker!"))
			return TRUE
		if("activate")
			if(!occupied || !victim || active)
				return
			start_activation(usr)
			return TRUE
		if("exit")
			if(occupied && victim == usr && !active)
				victim.forceMove(get_turf(src))
				occupied = FALSE
				victim = null
				return TRUE

/obj/machinery/scp_recontainment/femur_breaker/on_activation(mob/user)
	if(!victim)
		return
	// The subject's sacrifice: massive blunt trauma + the lure broadcast.
	victim.apply_damage(80, BRUTE, pick(BP_L_LEG, BP_R_LEG))
	victim.emote("scream")
	visible_message(SPAN_DANGER("The Femur Breaker activates! [victim] screams in agony!"))
	var/atom/movable/scp106 = find_scp_atom_by_designation("106")
	if(scp106 && scp106.SCP && scp106.SCP.research && scp106.SCP.research.containment_status == "breached")
		priority_announcement.Announce("ATTENTION: Femur Breaker protocol activated. SCP-106 is being lured back to containment.", "Containment Protocol")
		lure_pending = TRUE
		lure_scp(scp106)

/obj/machinery/scp_recontainment/femur_breaker/Process()
	// Continuous lure: 106 is dragged toward the breaker while the cycle runs.
	if(active && lure_pending)
		var/atom/movable/scp106 = find_scp_atom_by_designation("106")
		if(scp106 && get_dist(scp106, src) > 1)
			lure_scp(scp106)
		else if(scp106)
			complete_recontainment(scp106)
	..()

/obj/machinery/scp_recontainment/femur_breaker/proc/complete_recontainment(atom/scp106)
	lure_pending = FALSE
	active = FALSE
	if(victim)
		victim.forceMove(get_turf(src))
		occupied = FALSE
		victim = null
	if(scp106 && scp106.SCP && scp106.SCP.research)
		scp106.SCP.research.set_containment_status(SCP_CONTAINED)
		// teleport 106 into its cell if the zone is known
		var/area/scp_area = get_area(scp106)
		var/datum/containment_zone/CZ = scp_area ? scp_area.get_containment_zone() : null
		if(CZ && CZ.zone_area)
			var/list/area_turfs = list()
			for(var/turf/T in CZ.zone_area)
				area_turfs += T
			if(length(area_turfs))
				var/atom/movable/M106 = scp106
				M106.forceMove(pick(area_turfs))
		hook_scp_recontained("106", scp106)
		visible_message(SPAN_NOTICE("SCP-106 has been recontained."))

/obj/machinery/scp_recontainment/femur_breaker/finish_activation()
	..()
	lure_pending = FALSE
	if(victim)
		victim.forceMove(get_turf(src))
		occupied = FALSE
		victim = null

// ============================================================================
// SCP-049 CURE STATION

/obj/machinery/scp_recontainment/cure_station
	name = "SCP-049 Cure Station"
	desc = "An apparatus that broadcasts a 'corrupted cure' signal, luring SCP-049 back for containment treatment."
	icon_state = "chem_disp"
	target_designation = "049"
	activate_duration = 45 SECONDS
	var/lure_pending = FALSE

/obj/machinery/scp_recontainment/cure_station/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ScpCureStation", "SCP-049 CURE STATION")
		ui.open()

/obj/machinery/scp_recontainment/cure_station/tgui_data(mob/user)
	var/list/data = list()
	data["active"] = active
	data["time_left"] = active ? max(0, round((active_until - world.time) / 10)) : 0
	var/atom/movable/scp049 = find_scp_atom_by_designation("049")
	var/status = "unknown"
	if(scp049 && scp049.SCP.research)
		status = scp049.SCP.research.containment_status
	data["scp049_status"] = status
	return data

/obj/machinery/scp_recontainment/cure_station/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if(action == "activate")
		start_activation(usr)
		return TRUE

/obj/machinery/scp_recontainment/cure_station/on_activation(mob/user)
	var/atom/movable/scp049 = find_scp_atom_by_designation("049")
	if(scp049 && scp049.SCP && scp049.SCP.research && scp049.SCP.research.containment_status == "breached")
		priority_announcement.Announce("Cure Station activated. SCP-049 is being lured for containment treatment.", "Containment Protocol")
		lure_pending = TRUE

/obj/machinery/scp_recontainment/cure_station/Process()
	if(active && lure_pending)
		var/atom/movable/scp049 = find_scp_atom_by_designation("049")
		if(scp049 && get_dist(scp049, src) > 1)
			lure_scp(scp049)
		else if(scp049)
			complete_recontainment(scp049)
	..()

/obj/machinery/scp_recontainment/cure_station/proc/complete_recontainment(atom/scp049)
	lure_pending = FALSE
	active = FALSE
	if(scp049 && scp049.SCP.research)
		scp049.SCP.research.set_containment_status(SCP_CONTAINED)
		hook_scp_recontained("049", scp049)
		visible_message(SPAN_NOTICE("SCP-049 has been recontained via curative treatment."))

// ============================================================================
// SCP-457 SUPPRESSION SYSTEM

/obj/machinery/scp_recontainment/suppression
	name = "SCP-457 Suppression System"
	desc = "A fuel-starvation system that forces SCP-457 to contract back to its containment wick."
	icon_state = "atmos_equipment"
	target_designation = "457"
	activate_duration = 40 SECONDS
	var/lure_pending = FALSE

/obj/machinery/scp_recontainment/suppression/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ScpSuppression", "SCP-457 SUPPRESSION SYSTEM")
		ui.open()

/obj/machinery/scp_recontainment/suppression/tgui_data(mob/user)
	var/list/data = list()
	data["active"] = active
	data["time_left"] = active ? max(0, round((active_until - world.time) / 10)) : 0
	var/atom/movable/scp457 = find_scp_atom_by_designation("457")
	var/status = "unknown"
	if(scp457 && scp457.SCP.research)
		status = scp457.SCP.research.containment_status
	data["scp457_status"] = status
	return data

/obj/machinery/scp_recontainment/suppression/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if(action == "activate")
		start_activation(usr)
		return TRUE

/obj/machinery/scp_recontainment/suppression/on_activation(mob/user)
	var/atom/movable/scp457 = find_scp_atom_by_designation("457")
	if(scp457 && scp457.SCP && scp457.SCP.research && scp457.SCP.research.containment_status == "breached")
		priority_announcement.Announce("Suppression system engaged. Fuel starvation protocol luring SCP-457 back.", "Containment Protocol")
		lure_pending = TRUE

/obj/machinery/scp_recontainment/suppression/Process()
	if(active && lure_pending)
		var/atom/movable/scp457 = find_scp_atom_by_designation("457")
		if(scp457 && get_dist(scp457, src) > 1)
			lure_scp(scp457)
		else if(scp457)
			complete_recontainment(scp457)
	..()

/obj/machinery/scp_recontainment/suppression/proc/complete_recontainment(atom/scp457)
	lure_pending = FALSE
	active = FALSE
	if(scp457 && scp457.SCP.research)
		scp457.SCP.research.set_containment_status(SCP_CONTAINED)
		hook_scp_recontained("457", scp457)
		visible_message(SPAN_NOTICE("SCP-457 has been suppressed and recontained."))

// ============================================================================
// SCP-939 SOUND DAMPENER

/obj/machinery/scp_recontainment/dampener
	name = "SCP-939 Sound Dampener"
	desc = "Broadcasts a mimicked pack-call that lures SCP-939 instances back to their pen."
	icon_state = "megaphone"
	target_designation = "939"
	activate_duration = 50 SECONDS
	var/lure_pending = FALSE

/obj/machinery/scp_recontainment/dampener/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ScpDampener", "SCP-939 SOUND DAMPENER")
		ui.open()

/obj/machinery/scp_recontainment/dampener/tgui_data(mob/user)
	var/list/data = list()
	data["active"] = active
	data["time_left"] = active ? max(0, round((active_until - world.time) / 10)) : 0
	var/atom/movable/scp939 = find_scp_atom_by_designation("939")
	var/status = "unknown"
	if(scp939 && scp939.SCP.research)
		status = scp939.SCP.research.containment_status
	data["scp939_status"] = status
	return data

/obj/machinery/scp_recontainment/dampener/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if(action == "activate")
		start_activation(usr)
		return TRUE

/obj/machinery/scp_recontainment/dampener/on_activation(mob/user)
	var/atom/movable/scp939 = find_scp_atom_by_designation("939")
	if(scp939 && scp939.SCP && scp939.SCP.research && scp939.SCP.research.containment_status == "breached")
		priority_announcement.Announce("Sound dampener active. SCP-939 instances are being lured back.", "Containment Protocol")
		lure_pending = TRUE

/obj/machinery/scp_recontainment/dampener/Process()
	if(active && lure_pending)
		var/atom/movable/scp939 = find_scp_atom_by_designation("939")
		if(scp939 && get_dist(scp939, src) > 1)
			lure_scp(scp939)
		else if(scp939)
			complete_recontainment(scp939)
	..()

/obj/machinery/scp_recontainment/dampener/proc/complete_recontainment(atom/scp939)
	lure_pending = FALSE
	active = FALSE
	if(scp939 && scp939.SCP.research)
		scp939.SCP.research.set_containment_status(SCP_CONTAINED)
		hook_scp_recontained("939", scp939)
		visible_message(SPAN_NOTICE("SCP-939 has returned to its pen."))

// ============================================================================
// SCP-008 INCINERATOR

/obj/machinery/scp_recontainment/incinerator
	name = "SCP-008 Decontamination Incinerator"
	desc = "A high-heat incinerator for destroying SCP-008 infected remains. Also functions as a cure-station lure for an active 008 vector."
	icon_state = "incinerator"
	target_designation = "008"
	activate_duration = 35 SECONDS

/obj/machinery/scp_recontainment/incinerator/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ScpIncinerator", "SCP-008 DECONTAMINATION INCINERATOR")
		ui.open()

/obj/machinery/scp_recontainment/incinerator/tgui_data(mob/user)
	var/list/data = list()
	data["active"] = active
	data["time_left"] = active ? max(0, round((active_until - world.time) / 10)) : 0
	return data

/obj/machinery/scp_recontainment/incinerator/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if(action == "activate")
		start_activation(usr)
		return TRUE

/obj/machinery/scp_recontainment/incinerator/on_activation(mob/user)
	visible_message(SPAN_WARNING("\The [src] rumbles to life, interior burners igniting."))
	// Burn anything inside.
	for(var/mob/living/L in src)
		L.adjust_fire_stacks(20)
		L.IgniteMob()

/obj/machinery/scp_recontainment/incinerator/on_completion()
	visible_message(SPAN_NOTICE("\The [src] cycle completes. Interior decontaminated."))

// ============================================================================
// SCP-1507 PACIFICATION SPEAKER

/obj/machinery/scp_recontainment/speaker
	name = "SCP-1507 Pacification Speaker"
	desc = "Broadcasts a predator call that scatters and herds pink flamingos back toward their enclosure."
	icon_state = "megaphone"
	target_designation = "1507"
	activate_duration = 30 SECONDS

/obj/machinery/scp_recontainment/speaker/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ScpSpeaker", "SCP-1507 PACIFICATION SPEAKER")
		ui.open()

/obj/machinery/scp_recontainment/speaker/tgui_data(mob/user)
	var/list/data = list()
	data["active"] = active
	data["time_left"] = active ? max(0, round((active_until - world.time) / 10)) : 0
	return data

/obj/machinery/scp_recontainment/speaker/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if(action == "activate")
		start_activation(usr)
		return TRUE

/obj/machinery/scp_recontainment/speaker/on_activation(mob/user)
	var/atom/movable/scp1507 = find_scp_atom_by_designation("1507")
	if(scp1507)
		lure_scp(scp1507)
		visible_message(SPAN_NOTICE("\The [src] blares a territorial squawk!"))

/obj/machinery/scp_recontainment/speaker/on_completion()
	var/atom/movable/scp1507 = find_scp_atom_by_designation("1507")
	if(scp1507 && get_dist(scp1507, src) <= 3 && scp1507.SCP.research)
		scp1507.SCP.research.set_containment_status(SCP_CONTAINED)
		hook_scp_recontained("1507", scp1507)

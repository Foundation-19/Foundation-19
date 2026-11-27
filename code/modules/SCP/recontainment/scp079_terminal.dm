// SCP-079 Recontainment Terminal.


/obj/machinery/scp_recontainment/oldai_terminal
	name = "SCP-079 Recontainment Program"
	desc = "A specialized program designed to force SCP-079 back into its containment shell through a series of network countermeasures."
	icon_state = "server"
	target_designation = "079"
	activate_duration = 0 // stage-driven; handled manually
	var/hack_progress = 0
	var/hack_threshold = 100
	var/hack_active = FALSE
	var/hack_speed = 1
	var/failure_chance = 15
	var/list/countermeasure_stages = list("isolate_network", "block_camera_feeds", "force_door_locks", "cut_power_loop", "initiate_shutdown")
	var/current_stage = 1
	var/completed = FALSE

/obj/machinery/scp_recontainment/oldai_terminal/Initialize()
	. = ..()
	// The suite's base Initialize registers us in GLOB.recontainment_devices
	// — but the generic lure (find_recontainment_device_for) is not used
	// for 079; keep the registration harmless.

/obj/machinery/scp_recontainment/oldai_terminal/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Scp079Recontainment", "SCP-079 RECONTAINMENT")
		ui.open()

/obj/machinery/scp_recontainment/oldai_terminal/tgui_data(mob/user)
	var/list/data = list()
	data["hack_progress"] = hack_progress
	data["hack_threshold"] = hack_threshold
	data["hack_active"] = hack_active
	data["completed"] = completed
	data["current_stage"] = current_stage
	data["failure_chance"] = failure_chance

	var/list/stages = list()
	for(var/i in 1 to length(countermeasure_stages))
		stages += list(list(
			"name" = countermeasure_stages[i],
			"index" = i,
			"completed" = (i < current_stage),
			"current" = (i == current_stage),
		))
	data["countermeasure_stages"] = stages

	var/mob/living/scp079/ai = get_scp079()
	if(ai)
		data["tier"] = ai.tier
		data["processing_power"] = round(ai.processing_power)
	else
		data["tier"] = 0
		data["processing_power"] = 0

	return data

/obj/machinery/scp_recontainment/oldai_terminal/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if(action == "initiate")
		if(!ishuman(usr))
			return
		var/mob/living/carbon/human/H = usr
		var/obj/item/card/id/id_card = H.GetIdCard()
		if(!id_card || !(ACCESS_SCIENCE_LVL3 in id_card.access))
			to_chat(H, SPAN_WARNING("Requires Researcher access (Level 3) to operate."))
			return
		if(completed)
			to_chat(H, SPAN_NOTICE("Recontainment protocol already completed this shift."))
			return
		if(hack_active)
			to_chat(H, SPAN_NOTICE("Countermeasure protocol in progress: [hack_progress]% - Stage [current_stage]/[length(countermeasure_stages)]"))
			return
		if(stat & (BROKEN|NOPOWER))
			to_chat(H, SPAN_WARNING("\The [src] is unpowered or broken."))
			return

		hack_active = TRUE
		hack_progress = 0
		current_stage = 1
		visible_message(SPAN_NOTICE("[src] begins the countermeasure sequence against SCP-079!"))
		log_game("SCP-079 recontainment countermeasures initiated by [key_name(H)].")
		return TRUE

/obj/machinery/scp_recontainment/oldai_terminal/Process()
	// Drive the counter-hack while active. Note: this overrides the suite's
	// cycle-timer Process (activate_duration is 0 — we never start_activation).
	if(!hack_active)
		return

	if(prob(failure_chance))
		hack_progress = max(0, hack_progress - rand(3, 8))
		visible_message(SPAN_WARNING("[src] encounters resistance! Progress pushed back!"))

		var/mob/living/scp079/ai = get_scp079()
		if(ai && ai.current_camera_ref)
			to_chat(ai, SPAN_DANGER("Someone is attempting to contain you! Counter-hack detected!"))

	hack_progress += hack_speed

	if(hack_progress >= (current_stage * (hack_threshold / length(countermeasure_stages))) && current_stage < length(countermeasure_stages))
		current_stage++
		visible_message(SPAN_NOTICE("[src] advances to countermeasure stage [current_stage]: [countermeasure_stages[current_stage]]"))

		var/mob/living/scp079/ai = get_scp079()
		if(ai)
			ai.processing_power = max(0, ai.processing_power - 15)
			ai.tier = max(1, ai.tier - 1)
			to_chat(ai, SPAN_DANGER("Your systems are being compromised! Processing power reduced!"))

	if(hack_progress >= hack_threshold)
		complete_recontainment()

/obj/machinery/scp_recontainment/oldai_terminal/proc/complete_recontainment()
	hack_active = FALSE
	completed = TRUE
	visible_message(SPAN_NOTICE("[src] completes all countermeasure stages!"))

	var/mob/living/scp079/ai = get_scp079()
	if(ai)
		ai.hacked_doors?.Cut()
		ai.is_manifested = FALSE
		ai.processing_power = 10
		ai.tier = 1
		ai.tier_progress = 0
		ai.available_abilities = list("camera_hop", "toggle_door", "flicker_lights", "broadcast_message")
		if(ai.SCP && ai.SCP.research && ai.SCP.research.containment_status == SCP_BREACHED)
			ai.SCP.research.set_containment_status(SCP_CONTAINED)

	var/atom/scp079_atom = find_scp_atom_by_designation("079")
	if(scp079_atom)
		hook_scp_recontained("079", scp079_atom)

	log_game("SCP-079 recontained via countermeasure protocol.")
	priority_announcement.Announce("SCP-079 has been successfully recontained via countermeasure protocol. Network stability restored.", "SCP-079 Recontainment Confirmed")

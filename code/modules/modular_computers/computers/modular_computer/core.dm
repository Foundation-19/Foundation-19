/obj/item/modular_computer/Process()
	if(!enabled) // The computer is turned off
		last_power_usage = 0
		return 0

	if(damage > broken_damage)
		shutdown_computer()
		return 0

	if(active_program && active_program.requires_ntnet && !get_ntnet_status(active_program.requires_ntnet_feature)) // Active program requires SCiPnet to run but we've just lost connection. Crash.
		active_program.event_networkfailure(0)

	for(var/datum/computer_file/program/P in idle_threads)
		if(P.requires_ntnet && !get_ntnet_status(P.requires_ntnet_feature))
			P.event_networkfailure(1)

	if(active_program)
		if(active_program.program_state != PROGRAM_STATE_KILLED)
			active_program.ntnet_status = get_ntnet_status()
			active_program.computer_emagged = computer_emagged
			active_program.process_tick()
		else
			active_program = null

	for(var/datum/computer_file/program/P in idle_threads)
		if(P.program_state != PROGRAM_STATE_KILLED)
			P.ntnet_status = get_ntnet_status()
			P.computer_emagged = computer_emagged
			P.process_tick()
		else
			idle_threads.Remove(P)

	handle_power() // Handles all computer power interaction
	check_update_ui_need()

	var/static/list/beepsounds = list('sound/effects/compbeep1.ogg','sound/effects/compbeep2.ogg','sound/effects/compbeep3.ogg','sound/effects/compbeep4.ogg','sound/effects/compbeep5.ogg')
	if(enabled && world.time > ambience_last_played + 60 SECONDS && prob(1))
		ambience_last_played = world.time
		playsound(src.loc, pick(beepsounds),15,1,10, is_ambiance = 1)

// Used to perform preset-specific hardware changes.
/obj/item/modular_computer/proc/install_default_hardware()
	return 1

// Used to install preset-specific programs
/obj/item/modular_computer/proc/install_default_programs()
	return 1

/obj/item/modular_computer/proc/install_default_programs_by_job(mob/living/carbon/human/H)
	var/datum/job/jb = SSjobs.get_by_title(H.job)
	if(!jb)
		return
	for(var/prog_type in jb.software_on_spawn)
		var/datum/computer_file/program/prog_file = prog_type
		if(initial(prog_file.usage_flags) & hardware_flag)
			prog_file = new prog_file
			hard_drive.store_file(prog_file)

/obj/item/modular_computer/Initialize()
	START_PROCESSING(SSobj, src)

	if(stores_pen && ispath(stored_pen))
		stored_pen = new stored_pen(src)

	install_default_hardware()
	if(hard_drive)
		install_default_programs()
	if(scanner)
		scanner.do_after_install(null, src)
	update_icon()
	update_verbs()
	update_name()
	. = ..()

/obj/item/modular_computer/Destroy()
	kill_program(1)
	//STOP_PROCESSING(SSobj, src) //The parent call will handle ending processing
	if(istype(stored_pen))
		QDEL_NULL(stored_pen)
	for(var/obj/item/stock_parts/computer/CH in src.get_all_components())
		uninstall_component(null, CH)
		qdel(CH)
	return ..()

/obj/item/modular_computer/emag_act(remaining_charges, mob/user)
	if(computer_emagged)
		to_chat(user, "\The [src] was already emagged.")
		return EMAG_NO_ACT
	else
		computer_emagged = TRUE
		to_chat(user, "You emag \the [src]. It's screen briefly shows a \"OVERRIDE ACCEPTED: New software downloads available.\" message.")
		return 1

/obj/item/modular_computer/update_icon()
	icon_state = icon_state_unpowered

	cut_overlays()
	if(bsod)
		add_overlay("bsod")
		return
	if(!enabled)
		if(icon_state_screensaver)
			add_overlay(icon_state_screensaver)
		set_light(0.2, 0.1, 0)
		return
	set_light(0.2, 0.1, light_strength)
	if(active_program)
		add_overlay(active_program.program_icon_state ? active_program.program_icon_state : icon_state_menu)
		if(active_program.program_key_state)
			add_overlay(active_program.program_key_state)
	else
		add_overlay(icon_state_menu)

/obj/item/modular_computer/proc/turn_on(mob/user)
	if(bsod)
		return
	if(tesla_link)
		tesla_link.enabled = 1
	var/issynth = issilicon(user) // Robots and AIs get different activation messages.
	if(damage > broken_damage)
		if(issynth)
			to_chat(user, "You send an activation signal to \the [src], but it responds with an error code. It must be damaged.")
		else
			to_chat(user, "You press the power button, but the computer fails to boot up, displaying variety of errors before shutting down again.")
		return
	if(processor_unit && (apc_power(0) || battery_power(0))) // Battery-run and charged or non-battery but powered by APC.
		if(issynth)
			to_chat(user, "You send an activation signal to \the [src], turning it on")
		else
			to_chat(user, "You press the power button and start up \the [src]")
		enable_computer(user)

	else // Unpowered
		if(issynth)
			to_chat(user, "You send an activation signal to \the [src] but it does not respond")
		else
			to_chat(user, "You press the power button but \the [src] does not respond")

// Relays kill program request to currently active program. Use this to quit current program.
/obj/item/modular_computer/proc/kill_program(forced = 0)
	if(active_program)
		active_program.kill_program(forced)
		active_program = null
	var/mob/user = usr
	if(user && istype(user))
		//Here to prevent programs sleeping in destroy
		INVOKE_ASYNC(src, /datum/proc/tgui_interact, usr) // Re-open the UI on this computer. It should show the main screen now.
	update_icon()

// Returns 0 for No Signal, 1 for Low Signal and 2 for Good Signal. 3 is for wired connection (always-on)
/obj/item/modular_computer/proc/get_ntnet_status(specific_action = 0)
	if(network_card)
		return network_card.get_signal(specific_action)
	else
		return 0

/obj/item/modular_computer/proc/add_log(text)
	if(!get_ntnet_status())
		return 0
	return ntnet_global.add_log(text, network_card)

/obj/item/modular_computer/proc/shutdown_computer(loud = 1)
	kill_program(1)
	for(var/datum/computer_file/program/P in idle_threads)
		P.kill_program(1)
		idle_threads.Remove(P)
	if(loud)
		visible_message("\The [src] shuts down.", range = 1)
	enabled = 0
	update_icon()

/obj/item/modular_computer/proc/enable_computer(mob/user = null)
	enabled = 1
	update_icon()

	// Autorun feature
	var/datum/computer_file/data/autorun = hard_drive ? hard_drive.find_file_by_name("autorun") : null
	if(istype(autorun))
		run_program(autorun.stored_data)

	if(user)
		tgui_interact(user)

/obj/item/modular_computer/proc/minimize_program(mob/user)
	if(!active_program || !processor_unit)
		return

	idle_threads.Add(active_program)
	active_program.program_state = PROGRAM_STATE_BACKGROUND // Should close any existing UIs
	SSnano.close_uis(active_program.NM ? active_program.NM : active_program)
	SStgui.close_uis(active_program.TM ? active_program.TM : active_program)
	active_program = null
	update_icon()
	if(istype(user))
		tgui_interact(user) // Re-open the UI on this computer. It should show the main screen now.


/obj/item/modular_computer/proc/run_program(prog)
	var/datum/computer_file/program/P = null
	var/mob/user = usr
	if(hard_drive)
		P = hard_drive.find_file_by_name(prog)

	if(!P || !istype(P)) // Program not found or it's not executable program.
		to_chat(user, SPAN_DANGER("\The [src]'s screen shows \"I/O ERROR - Unable to run [prog]\" warning."))
		return

	P.computer = src
	if(!P.is_supported_by_hardware(hardware_flag, 1, user))
		return
	if((P in idle_threads) && !(P.program_malicious))
		P.program_state = PROGRAM_STATE_ACTIVE
		active_program = P
		idle_threads.Remove(P)
		update_icon()
		return

	if(idle_threads.len >= processor_unit.processing_power+1)
		to_chat(user, SPAN_NOTICE("\The [src] displays a \"Maximal CPU load reached. Unable to run another program.\" error"))
		return

	if(P.requires_ntnet && !get_ntnet_status(P.requires_ntnet_feature)) // The program requires SCiPnet connection, but we are not connected to SCiPnet.
		to_chat(user, SPAN_DANGER("\The [src]'s screen shows \"NETWORK ERROR - Unable to connect to SCiPnet. Please retry. If problem persists contact your system administrator.\" warning."))
		return

	if(active_program)
		minimize_program(user)

	if(P.run_program(user))
		update_icon()
	return 1

/obj/item/modular_computer/proc/update_uis()
	if(active_program) //Should we update program ui or computer ui?
		SSnano.update_uis(active_program)
		if(active_program.NM)
			SSnano.update_uis(active_program.NM)
	else
		SSnano.update_uis(src)

/obj/item/modular_computer/proc/check_update_ui_need()
	var/ui_update_needed = 0
	if(battery_module)
		var/batery_percent = battery_module.battery.percent()
		if(last_battery_percent != batery_percent) //Let's update UI on percent change
			ui_update_needed = 1
			last_battery_percent = batery_percent

	if(station_time_timestamp() != last_world_time)
		last_world_time = station_time_timestamp()
		ui_update_needed = 1

	if(idle_threads.len)
		var/list/current_header_icons = list()
		for(var/datum/computer_file/program/P in idle_threads)
			if(!P.ui_header)
				continue
			current_header_icons[P.type] = P.ui_header
		if(!last_header_icons)
			last_header_icons = current_header_icons

		else if(!listequal(last_header_icons, current_header_icons))
			last_header_icons = current_header_icons
			ui_update_needed = 1
		else
			for(var/x in last_header_icons|current_header_icons)
				if(last_header_icons[x]!=current_header_icons[x])
					last_header_icons = current_header_icons
					ui_update_needed = 1
					break

	if(ui_update_needed)
		update_uis()

// Used by camera monitor program
/obj/item/modular_computer/check_eye(mob/user)
	if(active_program)
		return active_program.check_eye(user)
	else
		return ..()

/obj/item/modular_computer/proc/set_autorun(program)
	if(!hard_drive)
		return
	var/datum/computer_file/data/autorun = hard_drive.find_file_by_name("autorun")
	if(!istype(autorun))
		autorun = new/datum/computer_file/data()
		autorun.filename = "autorun"
		autorun.stored_data = "[program]"
		hard_drive.store_file(autorun)

/obj/item/modular_computer/GetIdCard()
	if(card_slot && card_slot.can_broadcast && istype(card_slot.stored_card))
		return card_slot.stored_card

/obj/item/modular_computer/proc/update_name()

/obj/item/modular_computer/get_cell()
	if(battery_module)
		return battery_module.get_cell()

/datum/nano_module
	var/name
	var/datum/host
	var/available_to_ai = TRUE
	var/datum/topic_manager/topic_manager
	var/list/using_access = list()

/datum/nano_module/New(datum/host, topic_manager)
	..()
	src.host = host.nano_host()
	src.topic_manager = topic_manager

/datum/nano_module/Destroy()
	host = null
	QDEL_NULL(topic_manager)
	. = ..()

/datum/nano_module/nano_host()
	return host ? host : src

// Nano modules are virtual UIs (programs, silicon subsystems) with no world
// location: the default state's distance checks cannot apply. Access control
// is enforced inside tgui_data/tgui_act via check_access().
/datum/nano_module/tgui_state(mob/user)
	return GLOB.always_tgui_state

/datum/nano_module/proc/can_still_topic(datum/topic_state/state = GLOB.default_state)
	return CanUseTopic(usr, state) == STATUS_INTERACTIVE

/datum/nano_module/proc/check_eye(mob/user)
	return -1

//returns a list.
/datum/nano_module/proc/get_access(mob/user)
	. = using_access
	if(istype(user))
		var/obj/item/card/id/I = user.GetIdCard()
		if(I)
			. |= I.access

/datum/nano_module/proc/check_access(mob/user, access)
	if(!access)
		return 1
	if(!islist(access))
		access = list(access) //listify a single access code.
	if(has_access(access, using_access))
		return 1 //This is faster, and often enough.
	return has_access(access, get_access(user)) //Also checks the mob's ID.

/datum/nano_module/Topic(href, href_list)
	if(topic_manager && topic_manager.Topic(href, href_list))
		return TRUE
	. = ..()

// tgui acts on nano-module-hosted UIs (src_object = the module). The newer
// /datum/tgui_module has its own PC_exit handling; the older nano_module
// base never got one, so the header's Exit/Minimize buttons did nothing on
// every NM-based program. Forward the PC_* actions to the host computer.
/datum/nano_module/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	var/obj/item/modular_computer/computer = nano_host()
	if(!istype(computer))
		return FALSE
	switch(action)
		if("PC_exit")
			computer.kill_program()
			return TRUE
		if("PC_shutdown")
			computer.shutdown_computer()
			return TRUE
		if("PC_minimize")
			computer.minimize_program(usr)
			return TRUE
	return FALSE

// If this module's UI is closed by the user while its program is still the
// computer's ACTIVE program, minimize the program (it would otherwise re-open
// its UI headless next tick). Identity-checked via active_program.NM so the
// main-menu switch close (which closes the computer's own UI) never triggers
// this. Machinery-hosted modules fall through to the default no-op.
/datum/nano_module/tgui_close(mob/user)
	var/obj/item/modular_computer/computer = nano_host()
	if(istype(computer) && computer.active_program \
		&& computer.active_program.NM == src \
		&& computer.active_program.program_state == PROGRAM_STATE_ACTIVE && istype(user))
		computer.minimize_program(user)
		return
	return ..()

// Mirror of /datum/tgui_module/tgui_static_data: give every nano-module UI
// the running computer's header data (PC_* fields). Frontends use
// PC_showexitprogram to show the Exit/Minimize buttons only when the module
// runs as a computer program; machinery-hosted consoles get no PC_* data.
/datum/nano_module/tgui_static_data(mob/user)
	. = ..()
	var/obj/item/modular_computer/computer = nano_host()
	if(istype(computer))
		. += computer.get_header_data()

/datum/nano_module/proc/get_host_z()
	return get_z(nano_host())

/datum/nano_module/proc/print_text(text, mob/user)
	var/obj/item/modular_computer/computer = nano_host()
	if(computer.nano_printer)
		computer.nano_printer.print_text(text)
	else
		to_chat(user, "Error: Unable to detect compatible printer interface. Are you running SCPOSv2 compatible system?")

/datum/proc/initial_data()
	return list()

/datum/proc/update_layout()
	return FALSE

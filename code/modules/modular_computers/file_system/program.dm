// /program/ files are executable programs that do things.
/datum/computer_file/program
	filetype = "PRG"
	filename = "UnknownProgram"						// File name. FILE NAME MUST BE UNIQUE IF YOU WANT THE PROGRAM TO BE DOWNLOADABLE FROM NTNET!
	var/required_access = null						// List of required accesses to run/download the program.
	var/requires_access_to_run = TRUE					// Whether the program checks for required_access when run.
	var/requires_access_to_download = TRUE				// Whether the program checks for required_access when downloading.
	var/datum/nano_module/NM = null					// If the program uses NanoModule, put it here and it will be automagically opened. Otherwise implement ui_interact.
	var/nanomodule_path = null						// Path to nanomodule, make sure to set this if implementing new program.
	var/program_state = PROGRAM_STATE_KILLED		// PROGRAM_STATE_KILLED or PROGRAM_STATE_BACKGROUND or PROGRAM_STATE_ACTIVE - specifies whether this program is running.
	var/datum/extension/interactive/ntos/computer	// OS that runs this program.
	var/filedesc = "Unknown Program"				// User-friendly name of this program.
	var/extended_desc = "N/A"						// Short description of this program's function.
	var/category = PROG_MISC
	var/program_icon_state = null					// Program-specific screen icon state
	var/program_key_state = "standby_key"			// Program-specific keyboard icon state
	var/program_menu_icon = "newwin"				// Icon to use for program's link in main menu
	var/requires_ntnet = FALSE							// Set to 1 for program to require nonstop NTNet connection to run. If NTNet connection is lost program crashes.
	var/requires_ntnet_feature = 0					// Optional, if above is set to 1 checks for specific function of NTNet (currently NTNET_SOFTWAREDOWNLOAD, NTNET_PEERTOPEER, NTNET_SYSTEMCONTROL and NTNET_COMMUNICATION)
	var/ntnet_status = 1							// NTNet status, updated every tick by computer running this program. Don't use this for checks if NTNet works, computers do that. Use this for calculations, etc.
	var/usage_flags = PROGRAM_ALL & ~PROGRAM_PDA	// Bitflags (PROGRAM_CONSOLE, PROGRAM_LAPTOP, PROGRAM_TABLET, PROGRAM_PDA combination) or PROGRAM_ALL
	var/network_destination = null					// Optional string that describes what NTNet server/system this program connects to. Used in default logging.
	var/available_on_ntnet = TRUE						// Whether the program can be downloaded from NTNet. Set to 0 to disable.
	var/available_on_syndinet = FALSE					// Whether the program can be downloaded from SyndiNet (accessible via emagging the computer). Set to 1 to enable.
	var/ui_header = null							// Example: "something.gif" - a header image that will be rendered in computer's UI when this program is running at background. Images are taken from /nano/images/status_icons. Be careful not to use too large images!
	var/ntnet_speed = 0								// GQ/s - current network connectivity transfer rate
	var/operator_skill = SKILL_MIN                  // Holder for skill value of current/recent operator for programs that tick.

/datum/computer_file/program/Destroy()
	if(computer && computer.active_program == src)
		computer.kill_program(src)
	computer = null
	. = ..()

/datum/computer_file/program/nano_host()
	return computer && computer.nano_host()

/datum/computer_file/program/clone()
	var/datum/computer_file/program/temp = ..()
	temp.required_access = required_access
	temp.nanomodule_path = nanomodule_path
	temp.filedesc = filedesc
	temp.program_icon_state = program_icon_state
	temp.requires_ntnet = requires_ntnet
	temp.requires_ntnet_feature = requires_ntnet_feature
	temp.usage_flags = usage_flags
	return temp

// Used by programs that manipulate files.
/datum/computer_file/program/proc/get_file(var/filename)
	return computer.get_file(filename)

/datum/computer_file/program/proc/create_file(var/newname, var/data = "", var/file_type = /datum/computer_file/data, var/list/metadata = null)
	return computer.create_file(newname, data, file_type, metadata)

// Relays icon update to the computer.
/datum/computer_file/program/proc/update_computer_icon()
	if(istype(computer))
		computer.update_host_icon()
		return

// Attempts to create a log in global ntnet datum. Returns 1 on success, 0 on fail.
/datum/computer_file/program/proc/generate_network_log(var/text)
	if(computer)
		return computer.add_log(text)
	return 0

/datum/computer_file/program/proc/is_supported_by_hardware(var/hardware_flag, var/mob/user, var/loud = FALSE)
	if(!(hardware_flag & usage_flags))
		if(loud && computer && user)
			computer.show_error(user, "Hardware Error - Incompatible software")
		return 0
	return 1

/datum/computer_file/program/proc/get_signal(var/specific_action = 0)
	if(computer)
		return computer.get_ntnet_status(specific_action)
	return 0

// Called by Process() on device that runs us, once every tick.
/datum/computer_file/program/proc/process_tick()
	update_netspeed()
	return 1

/datum/computer_file/program/proc/update_netspeed()
	ntnet_speed = 0
	switch(ntnet_status)
		if(1)
			ntnet_speed = NTNETSPEED_LOWSIGNAL
		if(2)
			ntnet_speed = NTNETSPEED_HIGHSIGNAL
		if(3)
			ntnet_speed = NTNETSPEED_ETHERNET

// Check if the user can run program. Only humans can operate computer. Automatically called in run_program()
// User has to wear their ID or have it inhand for ID Scan to work.
// Can also be called manually, with optional parameter being access_to_check to scan the user's ID
/datum/computer_file/program/proc/can_run(var/mob/living/user, var/loud = 0, var/access_to_check)
	if(!requires_access_to_run)
		return 1
	// Defaults to required_access
	if(!access_to_check)
		access_to_check = required_access
	if(!access_to_check) // No required_access, allow it.
		return 1

	// Admin override - allows operation of any computer as aghosted admin, as if you had any required access.
	if(isghost(user) && check_rights(R_ADMIN, 0, user))
		return 1

	if(!istype(user))
		return 0

	var/obj/item/card/id/I = user.GetIdCard()
	if(!I)
		if(loud)
			to_chat(user, "<span class='notice'>\The [computer] flashes an \"RFID Error - Unable to scan ID\" warning.</span>")
		return 0

	if(access_to_check in I.access)
		return 1
	else if(loud)
		to_chat(user, "<span class='notice'>\The [computer] flashes an \"Access Denied\" warning.</span>")

// This attempts to retrieve header data for NanoUIs. If implementing completely new device of different type than existing ones
// always include the device here in this proc. This proc basically relays the request to whatever is running the program.
/datum/computer_file/program/proc/get_header_data()
	if(computer)
		return computer.get_header_data()
	return list()

// This is performed on program startup. May be overriden to add extra logic. Remember to include ..() call.
// When implementing new program based device, use this to run the program.
/datum/computer_file/program/proc/on_startup(var/mob/living/user, var/datum/extension/interactive/ntos/new_host)
	program_state = PROGRAM_STATE_ACTIVE
	computer = new_host
	if(nanomodule_path)
		NM = new nanomodule_path(src, new /datum/topic_manager/program(src), src)
		if(user)
			NM.using_access = user.GetAccess()
	if(requires_ntnet && network_destination)
		generate_network_log("Connection opened to [network_destination].")
	return 1

// Use this proc to kill the program. Designed to be implemented by each program if it requires on-quit logic, such as the NTNRC client.
/datum/computer_file/program/proc/on_shutdown(var/forced = 0)
	program_state = PROGRAM_STATE_KILLED
	if(network_destination)
		generate_network_log("Connection to [network_destination] closed.")
	if(NM)
		qdel(NM)
		NM = null
	return 1

// This is called every tick when the program is enabled. Ensure you do parent call if you override it. If parent returns 1 continue with UI initialisation.
// It returns 0 if it can't run or if NanoModule was used instead. I suggest using NanoModules where applicable.
/datum/computer_file/program/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	if(program_state != PROGRAM_STATE_ACTIVE) // Our program was closed. Close the ui if it exists.
		if(ui)
			ui.close()
		return computer.ui_interact(user)
	if(istype(NM))
		NM.ui_interact(user, ui_key, null, force_open)
		return 0
	return 1


// CONVENTIONS, READ THIS WHEN CREATING NEW PROGRAM AND OVERRIDING THIS PROC:
// Topic calls are automagically forwarded from NanoModule this program contains.
// Calls beginning with "PRG_" are reserved for programs handling.
// Calls beginning with "PC_" are reserved for computer handling (by whatever runs the program)
// ALWAYS INCLUDE PARENT CALL ..() OR DIE IN FIRE.
/datum/computer_file/program/Topic(href, href_list)
	if(..())
		return 1
	if(computer)
		return computer.Topic(href, href_list)

// Relays the call to nano module, if we have one
/datum/computer_file/program/proc/check_eye(var/mob/user)
	if(NM)
		return NM.check_eye(user)
	else
		return -1

/datum/nano_module/program
	available_to_ai = FALSE
	var/datum/computer_file/program/program = null	// Program-Based computer program that runs this nano module. Defaults to null.

/datum/nano_module/program/New(var/host, var/topic_manager, var/program)
	..()
	src.program = program

/datum/topic_manager/program
	var/datum/program

/datum/topic_manager/program/New(var/datum/program)
	..()
	src.program = program

// Calls forwarded to PROGRAM itself should begin with "PRG_"
// Calls forwarded to COMPUTER running the program should begin with "PC_"
/datum/topic_manager/program/Topic(href, href_list)
	return program && program.Topic(href, href_list)

/datum/computer_file/program/apply_visual(mob/M)
	if(NM)
		NM.apply_visual(M)

/datum/computer_file/program/remove_visual(mob/M)
	if(NM)
		NM.remove_visual(M)

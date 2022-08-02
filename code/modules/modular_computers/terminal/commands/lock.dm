/// Toggles storage devices being read-only
/datum/terminal_command/lock
	name = "lock"
	man_entry = list(
		"Format: lock",
		"Lists storage devices."
	)
	pattern = "^lock"
	skill_needed = SKILL_TRAINED

/datum/terminal_command/lock/proper_input_entered(text, mob/user, datum/terminal/terminal)
	var/list/arguments = get_arguments(text)
	if(isnull(arguments))
		return syntax_error()
	var/list/drives = list(
		"C" = terminal.computer.get_component(PART_HDD),
		"R" = terminal.computer.get_component(PART_DRIVE)
	)
	if(!istype(drives["C"], /obj/item/stock_parts/computer/hard_drive))
		return "[name]: Error; hard drive not found."
	. = syntax_error()
	var/obj/item/stock_parts/computer/hard_drive/D
	if(!arguments.len)
		. = list()
		. += "[name]: Listing storage device status..."
		for(var/did in drives)
			D = drives[did]
			if(!istype(D))
				continue
			. += ""
			. += "** Device mounted on device id [did]: **"
			. += D.diagnostics()


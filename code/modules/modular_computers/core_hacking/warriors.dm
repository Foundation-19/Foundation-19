/datum/computer_file/warrior
	filetype = "WRR"
	/// 2D list of the instructions making up this warrior.
	/// Each instruction is a 6-value list: INSTRUCTION - INSTRUCTION MODIFIER - ADDRESS MODE A - VALUE A - ADDRESS MODE B - VALUE B
	var/list/stored_instructions = list()
	/// List of every process we have running (represented as an index value). Only useful when in battle. The process used next is decided by [/datum/computer_file/warrior/var/next_process]
	var/list/processes
	/// Index of [/datum/computer_file/warrior/var/processes], checked when we're called to take an action.
	var/next_process

/// Returns the address we're running next, without changing it.
/datum/computer_file/warrior/proc/get_next_process_address()
	return processes[next_process]

/// Creates a new process right after the current one, pointing to the address passed.
/// We also increment the index here to ensure the new process is skipped the first time around.
/datum/computer_file/warrior/proc/create_new_process(address)
	processes.Insert(next_process + 1, address)
	increment_process_index()

/**
 * Adds one to the current process's address pointer.
 *
 * Arguments:
 * * curr_field - The battlefield we're currently in. Used to properly clamp the value.
 */
/datum/computer_file/warrior/proc/increment_process_pointer(datum/battlefield/curr_field)
	processes[next_process] = curr_field.clamp_value(processes[next_process] + 1)

/// Moves the current process's pointer to the specified address.
/datum/computer_file/warrior/proc/move_process_pointer(new_address)
	processes[next_process] = new_address

/// Moves to the next process.
/datum/computer_file/warrior/proc/increment_process_index()
	next_process = (next_process + 1) % length(processes)

/// Kills our active process
/datum/computer_file/warrior/proc/kill_active_process()
	kill_process(next_process)

/**
 * Kills one of our processes.
 *
 * Arguments:
 * * del_process_index - The value of [/datum/computer_file/warrior/var/processes] that we're killing.
 */
/datum/computer_file/warrior/proc/kill_process(del_process_index)
	if(length(processes) == 1)
		// TODO: death here
		return
	if(next_process >= del_process_index)
		next_process -= 1
	processes.Cut(del_process_index, del_process_index + 1)

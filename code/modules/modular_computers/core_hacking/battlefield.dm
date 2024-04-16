/**
 * # Battlefields
 *
 * A fight between a few assembly programs. Used for Hacking
 *
 * In comes two warriors (SEE: [/datum/computer_file/warrior]), out comes a result.
 * Each value in [/datum/battlefield/var/core_array] is a list that represents a single cell.
 *
 */
/datum/battlefield
	/// 2D list of the entire memory of the battlefield. THIS SHOULD BE TREATED AS AN ARRAY! Do not expand the size of this list.
	/// Each core is a 6-value list: INSTRUCTION - INSTRUCTION MODIFIER - ADDRESS MODE A - VALUE A - ADDRESS MODE B - VALUE B
	var/list/core_array = list()

	/// List of every warrior that's currently alive
	var/list/datum/computer_file/warrior/live_warriors
	/// Index for which warrior is next in [/datum/battlefield/var/live_warriors].
	var/warrior_index = 1

	/// Current cycle
	var/current_cycle = 0
	/// Max cycles until a tie is declared
	var/max_cycles = CORE_MAX_CYCLES

/datum/battlefield/New(list/datum/computer_file/warrior/warriors_list, core_size = CORE_SIZE_DEFAULT, max_cycles = CORE_MAX_CYCLES)
	live_warriors = warriors_list
	src.max_cycles = max_cycles

/**
 * Runs one step of the battlefield.
 */
/datum/battlefield/proc/process_step()

	// PROCESS CALCULATION

	var/datum/computer_file/warrior/active_warrior = live_warriors[warrior_index]
	warrior_index = (warrior_index + 1) % length(live_warriors)

	var/cached_process_address = active_warrior.get_next_process_address()

	// INSTRUCTION CALCULATION

	apply_predec(cached_process_address, core_array[cached_process_address][3], core_array[cached_process_address][4])
	apply_predec(cached_process_address, core_array[cached_process_address][5], core_array[cached_process_address][6])

	var/instruction = core_array[cached_process_address][1]
	var/instruction_modifier = core_array[cached_process_address][2]

	var/addr_a = get_core_dest_from_instruction(cached_process_address, core_array[cached_process_address][3], core_array[cached_process_address][4])
	var/addr_b = get_core_dest_from_instruction(cached_process_address, core_array[cached_process_address][5], core_array[cached_process_address][6])

	// INSTRUCTION HANDLING

	switch(instruction)
		if(CORE_INSTRUCTION_DAT)
			active_warrior.kill_active_process()
		if(CORE_INSTRUCTION_MOV)
			switch(instruction_modifier)
				if(CORE_INSMOD_A)
					core_array[addr_b][3] = core_array[addr_a][3]
					core_array[addr_b][4] = core_array[addr_a][4]
				if(CORE_INSMOD_B)
					core_array[addr_b][5] = core_array[addr_a][5]
					core_array[addr_b][6] = core_array[addr_a][6]
				if(CORE_INSMOD_AB)
					core_array[addr_b][5] = core_array[addr_a][3]
					core_array[addr_b][6] = core_array[addr_a][4]
				if(CORE_INSMOD_BA)
					core_array[addr_b][3] = core_array[addr_a][5]
					core_array[addr_b][4] = core_array[addr_a][6]
				if(CORE_INSMOD_F)
					core_array[addr_b][3] = core_array[addr_a][3]
					core_array[addr_b][4] = core_array[addr_a][4]
					core_array[addr_b][5] = core_array[addr_a][5]
					core_array[addr_b][6] = core_array[addr_a][6]
				if(CORE_INSMOD_X)
					core_array[addr_b][5] = core_array[addr_a][3]
					core_array[addr_b][6] = core_array[addr_a][4]
					core_array[addr_b][3] = core_array[addr_a][5]
					core_array[addr_b][4] = core_array[addr_a][6]
				if(CORE_INSMOD_I)
					core_array[addr_b][1] = core_array[addr_a][1]
					core_array[addr_b][2] = core_array[addr_a][2]
					core_array[addr_b][3] = core_array[addr_a][3]
					core_array[addr_b][4] = core_array[addr_a][4]
					core_array[addr_b][5] = core_array[addr_a][5]
					core_array[addr_b][6] = core_array[addr_a][6]
		if(CORE_INSTRUCTION_ADD)
			switch(instruction_modifier)
				if(CORE_INSMOD_A)
					core_array[addr_b][4] = clamp_value(core_array[addr_b][4] + core_array[addr_a][4])
				if(CORE_INSMOD_B)
					core_array[addr_b][6] = clamp_value(core_array[addr_b][6] + core_array[addr_a][6])
				if(CORE_INSMOD_AB)
					core_array[addr_b][6] = clamp_value(core_array[addr_b][6] + core_array[addr_a][4])
				if(CORE_INSMOD_BA)
					core_array[addr_b][4] = clamp_value(core_array[addr_b][4] + core_array[addr_a][6])
				if(CORE_INSMOD_F, CORE_INSMOD_I)
					core_array[addr_b][4] = clamp_value(core_array[addr_b][4] + core_array[addr_a][4])
					core_array[addr_b][6] = clamp_value(core_array[addr_b][6] + core_array[addr_a][6])
				if(CORE_INSMOD_X)
					core_array[addr_b][6] = clamp_value(core_array[addr_b][6] + core_array[addr_a][4])
					core_array[addr_b][4] = clamp_value(core_array[addr_b][4] + core_array[addr_a][6])
		if(CORE_INSTRUCTION_SUB)
			switch(instruction_modifier)
				if(CORE_INSMOD_A)
					core_array[addr_b][4] = clamp_value(core_array[addr_b][4] - core_array[addr_a][4])
				if(CORE_INSMOD_B)
					core_array[addr_b][6] = clamp_value(core_array[addr_b][6] - core_array[addr_a][6])
				if(CORE_INSMOD_AB)
					core_array[addr_b][6] = clamp_value(core_array[addr_b][6] - core_array[addr_a][4])
				if(CORE_INSMOD_BA)
					core_array[addr_b][4] = clamp_value(core_array[addr_b][4] - core_array[addr_a][6])
				if(CORE_INSMOD_F, CORE_INSMOD_I)
					core_array[addr_b][4] = clamp_value(core_array[addr_b][4] - core_array[addr_a][4])
					core_array[addr_b][6] = clamp_value(core_array[addr_b][6] - core_array[addr_a][6])
				if(CORE_INSMOD_X)
					core_array[addr_b][6] = clamp_value(core_array[addr_b][6] - core_array[addr_a][4])
					core_array[addr_b][4] = clamp_value(core_array[addr_b][4] - core_array[addr_a][6])
		if(CORE_INSTRUCTION_MUL)
			switch(instruction_modifier)
				if(CORE_INSMOD_A)
					core_array[addr_b][4] = clamp_value(core_array[addr_b][4] * core_array[addr_a][4])
				if(CORE_INSMOD_B)
					core_array[addr_b][6] = clamp_value(core_array[addr_b][6] * core_array[addr_a][6])
				if(CORE_INSMOD_AB)
					core_array[addr_b][6] = clamp_value(core_array[addr_b][6] * core_array[addr_a][4])
				if(CORE_INSMOD_BA)
					core_array[addr_b][4] = clamp_value(core_array[addr_b][4] * core_array[addr_a][6])
				if(CORE_INSMOD_F, CORE_INSMOD_I)
					core_array[addr_b][4] = clamp_value(core_array[addr_b][4] * core_array[addr_a][4])
					core_array[addr_b][6] = clamp_value(core_array[addr_b][6] * core_array[addr_a][6])
				if(CORE_INSMOD_X)
					core_array[addr_b][6] = clamp_value(core_array[addr_b][6] * core_array[addr_a][4])
					core_array[addr_b][4] = clamp_value(core_array[addr_b][4] * core_array[addr_a][6])
		if(CORE_INSTRUCTION_DIV)
			var/kill_process = FALSE

			switch(instruction_modifier)
				if(CORE_INSMOD_A, CORE_INSMOD_AB)
					if(core_array[addr_a][4] == 0)
						instruction_modifier = CORE_INSMOD_DEAD
				if(CORE_INSMOD_B, CORE_INSMOD_BA)
					if(core_array[addr_a][6] == 0)
						instruction_modifier = CORE_INSMOD_DEAD
				if(CORE_INSMOD_F, CORE_INSMOD_I)
					if(core_array[addr_a][4] == 0 && core_array[addr_a][6] == 0)
						instruction_modifier = CORE_INSMOD_DEAD
					else if(core_array[addr_a][4] == 0)
						kill_process = TRUE
						instruction_modifier = CORE_INSMOD_B
					else if(core_array[addr_a][6] == 0)
						kill_process = TRUE
						instruction_modifier = CORE_INSMOD_A
				if(CORE_INSMOD_X)
					if(core_array[addr_a][4] == 0 && core_array[addr_a][6] == 0)
						instruction_modifier = CORE_INSMOD_DEAD
					else if(core_array[addr_a][4] == 0)
						kill_process = TRUE
						instruction_modifier = CORE_INSMOD_BA
					else if(core_array[addr_a][6] == 0)
						kill_process = TRUE
						instruction_modifier = CORE_INSMOD_AB

			switch(instruction_modifier)
				if(CORE_INSMOD_A)
					core_array[addr_b][4] = clamp_value(core_array[addr_b][4] / core_array[addr_a][4])
				if(CORE_INSMOD_B)
					core_array[addr_b][6] = clamp_value(core_array[addr_b][6] / core_array[addr_a][6])
				if(CORE_INSMOD_AB)
					core_array[addr_b][6] = clamp_value(core_array[addr_b][6] / core_array[addr_a][4])
				if(CORE_INSMOD_BA)
					core_array[addr_b][4] = clamp_value(core_array[addr_b][4] / core_array[addr_a][6])
				if(CORE_INSMOD_F, CORE_INSMOD_I)
					core_array[addr_b][4] = clamp_value(core_array[addr_b][4] / core_array[addr_a][4])
					core_array[addr_b][6] = clamp_value(core_array[addr_b][6] / core_array[addr_a][6])
				if(CORE_INSMOD_X)
					core_array[addr_b][6] = clamp_value(core_array[addr_b][6] / core_array[addr_a][4])
					core_array[addr_b][4] = clamp_value(core_array[addr_b][4] / core_array[addr_a][6])
				if(CORE_INSMOD_DEAD)
					kill_process = TRUE

			if(kill_process)
				active_warrior.kill_active_process()
		if(CORE_INSTRUCTION_MOD)
			var/kill_process = FALSE

			switch(instruction_modifier)
				if(CORE_INSMOD_A, CORE_INSMOD_AB)
					if(core_array[addr_a][4] == 0)
						instruction_modifier = CORE_INSMOD_DEAD
				if(CORE_INSMOD_B, CORE_INSMOD_BA)
					if(core_array[addr_a][6] == 0)
						instruction_modifier = CORE_INSMOD_DEAD
				if(CORE_INSMOD_F, CORE_INSMOD_I)
					if(core_array[addr_a][4] == 0 && core_array[addr_a][6] == 0)
						instruction_modifier = CORE_INSMOD_DEAD
					else if(core_array[addr_a][4] == 0)
						kill_process = TRUE
						instruction_modifier = CORE_INSMOD_B
					else if(core_array[addr_a][6] == 0)
						kill_process = TRUE
						instruction_modifier = CORE_INSMOD_A
				if(CORE_INSMOD_X)
					if(core_array[addr_a][4] == 0 && core_array[addr_a][6] == 0)
						instruction_modifier = CORE_INSMOD_DEAD
					else if(core_array[addr_a][4] == 0)
						kill_process = TRUE
						instruction_modifier = CORE_INSMOD_BA
					else if(core_array[addr_a][6] == 0)
						kill_process = TRUE
						instruction_modifier = CORE_INSMOD_AB

			switch(instruction_modifier)
				if(CORE_INSMOD_A)
					core_array[addr_b][4] = clamp_value(core_array[addr_b][4] % core_array[addr_a][4])
				if(CORE_INSMOD_B)
					core_array[addr_b][6] = clamp_value(core_array[addr_b][6] % core_array[addr_a][6])
				if(CORE_INSMOD_AB)
					core_array[addr_b][6] = clamp_value(core_array[addr_b][6] % core_array[addr_a][4])
				if(CORE_INSMOD_BA)
					core_array[addr_b][4] = clamp_value(core_array[addr_b][4] % core_array[addr_a][6])
				if(CORE_INSMOD_F, CORE_INSMOD_I)
					core_array[addr_b][4] = clamp_value(core_array[addr_b][4] % core_array[addr_a][4])
					core_array[addr_b][6] = clamp_value(core_array[addr_b][6] % core_array[addr_a][6])
				if(CORE_INSMOD_X)
					core_array[addr_b][6] = clamp_value(core_array[addr_b][6] % core_array[addr_a][4])
					core_array[addr_b][4] = clamp_value(core_array[addr_b][4] % core_array[addr_a][6])
				if(CORE_INSMOD_DEAD)
					kill_process = TRUE

			if(kill_process)
				active_warrior.kill_active_process()
		if(CORE_INSTRUCTION_JMP)
			active_warrior.move_process_pointer(addr_a)
		if(CORE_INSTRUCTION_JMZ)
			var/jump = FALSE
			switch(instruction_modifier)
				if(CORE_INSMOD_A, CORE_INSMOD_BA)
					if(core_array[addr_b][4] == 0)
						jump = TRUE
				if(CORE_INSMOD_B, CORE_INSMOD_AB)
					if(core_array[addr_b][6] == 0)
						jump = TRUE
				if(CORE_INSMOD_F, CORE_INSMOD_X, CORE_INSMOD_I)
					if(core_array[addr_b][4] == 0 && core_array[addr_b][6] == 0)
						jump = TRUE
			if(jump)
				active_warrior.move_process_pointer(addr_a)
		if(CORE_INSTRUCTION_JMN)
			var/jump = FALSE
			switch(instruction_modifier)
				if(CORE_INSMOD_A, CORE_INSMOD_BA)
					if(core_array[addr_b][4] != 0)
						jump = TRUE
				if(CORE_INSMOD_B, CORE_INSMOD_AB)
					if(core_array[addr_b][6] != 0)
						jump = TRUE
				if(CORE_INSMOD_F, CORE_INSMOD_X, CORE_INSMOD_I)
					if(core_array[addr_b][4] != 0 || core_array[addr_b][6] != 0)
						jump = TRUE
			if(jump)
				active_warrior.move_process_pointer(addr_a)
		if(CORE_INSTRUCTION_DJN)
			var/jump = FALSE
			switch(instruction_modifier)
				if(CORE_INSMOD_A, CORE_INSMOD_BA)
					core_array[addr_b][4] = clamp_value(core_array[addr_b][4] - 1)
					if(core_array[addr_b][4] != 0)
						jump = TRUE
				if(CORE_INSMOD_B, CORE_INSMOD_AB)
					core_array[addr_b][6] = clamp_value(core_array[addr_b][6] - 1)
					if(core_array[addr_b][6] != 0)
						jump = TRUE
				if(CORE_INSMOD_F, CORE_INSMOD_X, CORE_INSMOD_I)
					core_array[addr_b][4] = clamp_value(core_array[addr_b][4] - 1)
					core_array[addr_b][6] = clamp_value(core_array[addr_b][6] - 1)
					if(core_array[addr_b][4] != 0 || core_array[addr_b][6] != 0)
						jump = TRUE
			if(jump)
				active_warrior.move_process_pointer(addr_a)
		if(CORE_INSTRUCTION_SPL)
			active_warrior.create_new_process(addr_a)
		if(CORE_INSTRUCTION_SEQ)
			var/skip = FALSE

			switch(instruction_modifier)
				if(CORE_INSMOD_A)
					if(core_array[addr_a][4] == core_array[addr_b][4])
						skip = TRUE
				if(CORE_INSMOD_B)
					if(core_array[addr_a][6] == core_array[addr_b][6])
						skip = TRUE
				if(CORE_INSMOD_AB)
					if(core_array[addr_a][4] == core_array[addr_b][6])
						skip = TRUE
				if(CORE_INSMOD_BA)
					if(core_array[addr_a][6] == core_array[addr_b][4])
						skip = TRUE
				if(CORE_INSMOD_F)
					if(core_array[addr_a][4] == core_array[addr_b][4] && core_array[addr_a][6] == core_array[addr_b][6])
						skip = TRUE
				if(CORE_INSMOD_X)
					if(core_array[addr_a][4] == core_array[addr_b][6] && core_array[addr_a][6] == core_array[addr_b][4])
						skip = TRUE
				if(CORE_INSMOD_I)
					if (core_array[addr_a][1] == core_array[addr_b][1] && \
						core_array[addr_a][2] == core_array[addr_b][2] && \
						core_array[addr_a][4] == core_array[addr_b][4] && \
						core_array[addr_a][6] == core_array[addr_b][6])
						skip = TRUE

			if(skip)
				active_warrior.increment_process_index()
		if(CORE_INSTRUCTION_SNE)
			var/skip = FALSE

			switch(instruction_modifier)
				if(CORE_INSMOD_A)
					if(core_array[addr_a][4] != core_array[addr_b][4])
						skip = TRUE
				if(CORE_INSMOD_B)
					if(core_array[addr_a][6] != core_array[addr_b][6])
						skip = TRUE
				if(CORE_INSMOD_AB)
					if(core_array[addr_a][4] != core_array[addr_b][6])
						skip = TRUE
				if(CORE_INSMOD_BA)
					if(core_array[addr_a][6] != core_array[addr_b][4])
						skip = TRUE
				if(CORE_INSMOD_F)
					if(core_array[addr_a][4] != core_array[addr_b][4])
						skip = TRUE
					if(core_array[addr_a][6] != core_array[addr_b][6])
						skip = TRUE
				if(CORE_INSMOD_X)
					if(core_array[addr_a][4] != core_array[addr_b][6])
						skip = TRUE
					if(core_array[addr_a][6] != core_array[addr_b][4])
						skip = TRUE
				if(CORE_INSMOD_I)
					if(core_array[addr_a][1] != core_array[addr_b][1])
						skip = TRUE
					if(core_array[addr_a][2] != core_array[addr_b][2])
						skip = TRUE
					if(core_array[addr_a][4] != core_array[addr_b][4])
						skip = TRUE
					if(core_array[addr_a][6] != core_array[addr_b][6])
						skip = TRUE

			if(skip)
				active_warrior.increment_process_index()
		if(CORE_INSTRUCTION_SLT)
			var/skip = FALSE

			switch(instruction_modifier)
				if(CORE_INSMOD_A)
					if(core_array[addr_a][4] < core_array[addr_b][4])
						skip = TRUE
				if(CORE_INSMOD_B)
					if(core_array[addr_a][6] < core_array[addr_b][6])
						skip = TRUE
				if(CORE_INSMOD_AB)
					if(core_array[addr_a][4] < core_array[addr_b][6])
						skip = TRUE
				if(CORE_INSMOD_BA)
					if(core_array[addr_a][6] < core_array[addr_b][4])
						skip = TRUE
				if(CORE_INSMOD_F, CORE_INSMOD_I)
					if(core_array[addr_a][4] < core_array[addr_b][4] && core_array[addr_a][6] < core_array[addr_b][6])
						skip = TRUE
				if(CORE_INSMOD_X)
					if(core_array[addr_a][4] < core_array[addr_b][6] && core_array[addr_a][6] < core_array[addr_b][4])
						skip = TRUE

			if(skip)
				active_warrior.increment_process_index()
		// if(CORE_INSTRUCTION_NOP)
			// NOP does nothing, so this is skipped.

	// INSTRUCTION CALCULATION PART TWO

	apply_postin(cached_process_address, core_array[cached_process_address][3], core_array[cached_process_address][4])
	apply_postin(cached_process_address, core_array[cached_process_address][5], core_array[cached_process_address][6])

	// PROCESS CALCULATION PART TWO

	active_warrior.increment_process_pointer(src)
	active_warrior.increment_process_index()

	// END-GAME CALCLATION

	if(current_cycle >= max_cycles)
		// TODO: declare tie
	else
		current_cycle += 1

	if(length(live_warriors))
		if(length(live_warriors) == 1)
			// TODO: declare victory
	else
		// TODO: declare total loss

/**
 * This proc returns an address pointer for a core instruction. PREDEC/POSTIN IS NOT APPLIED HERE.
 *
 * Arguments:
 * * current_position - The position of the instruction currently being ran.
 * * address_mode - The mode of the address. Should be a CORE_ADDMODE value.
 * * address_value - The value of the address.
 */
/datum/battlefield/proc/get_core_dest_from_instruction(current_position, address_mode, address_value)
	switch(address_mode)
		if(CORE_ADDMODE_DIRECT)
			return clamp_value(current_position + address_value)
		if(CORE_ADDMODE_IMMEDIATE)
			return current_position // technically, immediate addresses are evaluated as an address of zero, not as a number containing their value.
		if(CORE_ADDMODE_A_INDIRECT, CORE_ADDMODE_A_INDIRECT_PREDEC, CORE_ADDMODE_A_INDIRECT_POSTIN)
			return core_array[clamp_value(current_position + address_value)][4]
		if(CORE_ADDMODE_B_INDIRECT, CORE_ADDMODE_B_INDIRECT_PREDEC, CORE_ADDMODE_B_INDIRECT_POSTIN)
			return core_array[clamp_value(current_position + address_value)][6]

/**
 * This proc applies predecrement for [CORE_ADDMODE_A_INDIRECT_PREDEC] and [CORE_ADDMODE_B_INDIRECT_PREDEC]. Won't do anything if address_mode is not either of those.
 *
 * Arguments:
 * * current_position - The position of the instruction currently being ran.
 * * address_mode - The mode of the address. Should be a CORE_ADDMODE value.
 * * address_value - The value of the address.
 */
/datum/battlefield/proc/apply_predec(current_position, address_mode, address_value)
	switch(address_mode)
		if(CORE_ADDMODE_A_INDIRECT_PREDEC)
			core_array[clamp_value(current_position + address_value)][4] = clamp_value(core_array[clamp_value(current_position + address_value)][4] - 1)
		if(CORE_ADDMODE_B_INDIRECT_PREDEC)
			core_array[clamp_value(current_position + address_value)][6] = clamp_value(core_array[clamp_value(current_position + address_value)][6] - 1)

/**
 * This proc applies postincrement for [CORE_ADDMODE_A_INDIRECT_POSTIN] and [CORE_ADDMODE_B_INDIRECT_POSTIN]. Won't do anything if address_mode is not either of those.
 *
 * Arguments:
 * * current_position - The position of the instruction currently being ran.
 * * address_mode - The mode of the address. Should be a CORE_ADDMODE value.
 * * address_value - The value of the address.
 */
/datum/battlefield/proc/apply_postin(current_position, address_mode, address_value)
	switch(address_mode)
		if(CORE_ADDMODE_A_INDIRECT_POSTIN)
			core_array[clamp_value(current_position + address_value)][4] = clamp_value(core_array[clamp_value(current_position + address_value)][4] + 1)
		if(CORE_ADDMODE_B_INDIRECT_POSTIN)
			core_array[clamp_value(current_position + address_value)][6] = clamp_value(core_array[clamp_value(current_position + address_value)][6] + 1)

/// Properly modulos a number to fit the core's size.
/datum/battlefield/proc/clamp_value(value)
	value = floor(value)
	var/modulod = value % length(core_array)
	if(modulod < 0)
		modulod += length(core_array)
	return modulod

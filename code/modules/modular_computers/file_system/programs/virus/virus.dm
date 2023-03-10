/*
	TODO more virus effects, custom-made viruses, more complex interaction in general
*/

/datum/computer_file/program/virus
	filename = "programfile"
	filedesc = "donotopen"		// this and extended_desc aren't likely to show up, so both should be more blantantly virus-like
	extended_desc = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
	size = 4
	usage_flags = PROGRAM_ALL
	available_on_ntnet = 0
	available_on_syndinet = 0
	program_malicious = 1
	network_destination = "Unknown computer"
	var/virus_stage = 1			// what stage is the virus at
	var/virus_runvar = 0		// variable used by stages to track things. each stage uses this differently. remember to reset when ramping up!
	var/virus_cooldown			// when should we do the bad stuff
	var/datum/computer_file/data/email_account/stolen_account	// email info stolen from email_client variables

/datum/computer_file/program/virus/process_tick()
	. = ..()

	if(isnull(virus_cooldown))
		virus_cooldown = world.time + 3 MINUTES	//delay action on first download

	if(virus_cooldown < world.time)
		switch(virus_stage)
			if(1)
			/*
				STAGE 1: sets up later actions by overwriting autorun and stealing email account, then making a bunch of bloat files before finally disabling non-critical hardware
				RUNVAR USE: keeps track of how many times we've run
			*/
				if(prob(15 * (virus_runvar - 2)))
					var/list/hardware = computer.get_all_components()
					for(var/obj/item/stock_parts/computer/part in hardware)
						if(part.critical)
							hardware -= part
					var/obj/item/stock_parts/computer/specific_part = pick(hardware)
					specific_part.enabled = 0

					virus_stage++
					virus_runvar = 0
					virus_cooldown = world.time + rand(2 MINUTES, 4 MINUTES)
				else if(virus_runvar == 0)
					var/datum/computer_file/data/autorun = get_data_file("autorun")
					if(autorun)
						autorun.stored_data = "programfile"
					else
						create_data_file("autorun", "programfile")

					virus_runvar++
					virus_cooldown = world.time + 1 MINUTE
				else if(virus_runvar == 1)
					var/obj/item/stock_parts/computer/hard_drive/HDD = computer.hard_drive
					if(!HDD)
						return
					var/datum/computer_file/program/email_client/email_c = HDD.find_file_by_name("emailc")	// since it's not a data file, we need to get it manually
					if(!istype(email_c))
						return

					if(email_c.stored_login && email_c.stored_password)
						for(var/datum/computer_file/data/email_account/account in ntnet_global.email_accounts)
							if(!account.can_login)
								continue
							if(account.login == email_c.stored_login)
								if(account.password == email_c.stored_password)
									stolen_account = account

					email_c.stored_login = "[rand(1111,9999)]"		// make stolen email more apparent by just shoving random numbers in storage
					email_c.stored_password = "[rand(1111,9999)]"

					virus_runvar++
					virus_cooldown = world.time + rand(3 MINUTES, 5 MINUTES)
				else
					var/data_string
					for(var/i = (BLOCK_SIZE_DATA * 3), i > 0, i--)	// file size of 3
						data_string += "[rand(0,9)]"
						if(prob(5))									// technically we could hit file sizes higher than 3 if this triggers more than 1/3 of the time
							data_string += "\n"
					if(create_data_file("debug[rand(111,999)]", data_string))
						virus_runvar++
						virus_cooldown = world.time + 30 SECONDS
					else											// ran out of room, skip to rampup
						virus_runvar = 100							// ghetto way to ensure we rampup
			if(2)
			/*
				STAGE 2: sends some spam emails before moving on, SKIPPED if we don't have an account stolen. suspends email if possible on exit
				RUNVAR USE: keeps track of how many emails we've sent
			*/
				if(stolen_account && (virus_runvar < 10))
					if(stolen_account.suspended)
						stolen_account = null
						return
					else
						var/datum/computer_file/data/email_message/message = new()
						message.title = "Important file"
						message.source = stolen_account.login
						message.stored_data = "important download, please run immediately"
						message.attachment = clone()
						var/datum/computer_file/data/email_account/recipient = pick(ntnet_global.email_accounts)
						stolen_account.send_mail(recipient.login, message)

						virus_runvar++
						virus_cooldown = world.time + 15 SECONDS
				else
					if(stolen_account)
						stolen_account.suspended = TRUE

					virus_stage++
					virus_runvar = 0
					virus_cooldown = world.time + rand(1 MINUTE, 3 MINUTES)
			if(3)
			/*
				STAGE 3: this is where the fun begins. do progressively worse things until deleted
				RUNVAR USE: keeps track of how bad things should be getting
			*/
				if((virus_runvar > 15) || prob(virus_runvar))		// delete a random program and replace it with an armed revelation. once this happens you're probably screwed
					var/obj/item/stock_parts/computer/hard_drive/HDD = computer.hard_drive
					if(!HDD)
						return
					var/list/datum/computer_file/program/programs = list()
					var/datum/computer_file/program/deleted
					for(var/datum/computer_file/file in HDD.stored_files)
						if(istype(file, /datum/computer_file/program) || !(file.undeletable))	// don't want to delete programs like file manager
							var/datum/computer_file/program/T = file
							programs += T
					if(LAZYLEN(programs))
						deleted = pick(programs)
						var/datum/computer_file/program/PRG = ntnet_global.find_ntnet_file_by_name("revelation")
						var/datum/computer_file/program/rev = PRG.clone()
						rev.filedesc = deleted.filedesc
						rev.size = deleted.size				// yes yes, this is kinda hacky. chances are if we've hit this stage there's almost no file-space
						rev.program_icon_state = deleted.program_icon_state
						rev.program_key_state = deleted.program_key_state		// EXTREME MIMICRY ACTION
						rev.program_menu_icon = deleted.program_menu_icon
						if(deleted.program_state == PROGRAM_STATE_BACKGROUND)
							deleted.kill_program(1)
							computer.idle_threads.Remove(deleted)
						HDD.remove_file(deleted)
						HDD.store_file(rev)

						virus_cooldown = world.time + rand(5 MINUTES, 10 MINUTES)
						virus_runvar -= 6			// majorly calm down, chances are the computer is gonna blow soon anyways
				else if((virus_runvar > 8) || prob(2.5 * virus_runvar))	// cause random component damage
					var/list/hardware = computer.get_all_components()
					for(var/obj/item/stock_parts/computer/part in hardware)
						if(prob(50))
							part.damage = max(part.max_damage, (part.damage + rand(10,30)))

						virus_cooldown = world.time + rand(3 MINUTES, 5 MINUTES)
						virus_runvar -= 2			// pretty serious, drop a little
				else if((virus_runvar > 4) || prob(5 * virus_runvar) || computer.card_slot?.stored_card)		// burn off access, if possible
					var/obj/item/card/id/id_card = computer.card_slot.stored_card
					pick_n_take(id_card.access)

					virus_cooldown = world.time + rand(2 MINUTES, 3 MINUTES)
					virus_runvar++		// not that bad unless you get unlucky, slight rise
				else if(prob(10 * virus_runvar))	// shuts down computer
					virus_cooldown = world.time + rand(1 MINUTE, 2 MINUTES)
					virus_runvar += 3
					computer.shutdown_computer(1)
				else	// kill active program
					virus_cooldown = world.time + 1 MINUTE
					computer.kill_program(1)
					virus_runvar += 4


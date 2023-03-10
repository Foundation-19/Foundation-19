/*
	TODO more virus effects, custom-made viruses, virus triggers (i.e. performing certain actions ramps up), more complex interaction in general
*/

/datum/computer_file/program/virus
	filename = "programfile"
	filedesc = "donotopen"		// this and extended_desc aren't likely to show up, so both should be more blantantly virus-like
	extended_desc = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
	size = 4
	usage_flags = PROGRAM_ALL
	available_on_ntnet = 1	//FOR DEBUGGING
	available_on_syndinet = 0
	program_invisible = 1
	network_destination = "Unknown computer"
	var/virus_rampup = 1		// how much bad stuff should the virus be doing
	var/virus_runcount = 0		// how many times we've ran during this rampup
	var/virus_timer				// when should we do the bad stuff
	var/stolen_login
	var/stolen_password			// email info stolen from email_client variables

/datum/computer_file/program/virus/process_tick()
	. = ..()

	if(isnull(virus_timer))
		virus_timer = world.time + 3 MINUTES	//delay action on first download

	if(virus_timer < world.time)
		switch(virus_rampup)
			if(1)
				if(prob(20 * virus_runcount))	// , disable a random non-vital component, then ramp up.
					var/list/hardware = computer.get_all_components()
					for(var/obj/item/stock_parts/computer/part in hardware)
						//var/obj/item/stock_parts/computer/part = thing
						if(part.critical)
							hardware -= part
					var/obj/item/stock_parts/computer/specific_part = pick(hardware)
					specific_part.enabled = 0

					virus_rampup++
					virus_runcount = 0
					virus_timer = world.time + 2 MINUTES + rand(1 MINUTE, 3 MINUTES)
				else if(prob(33))
					create_data_file("debug[rand(111,999)]","")	//need a way to throw in 5000 random chars as data

					virus_runcount++
					virus_timer = world.time + 1 MINUTE
				else if(prob(50))
					var/datum/computer_file/data/autorun = get_data_file("autorun")
					autorun.stored_data = "programfile"

					virus_runcount++
					virus_timer = world.time + 2 MINUTES
				else
					var/obj/item/stock_parts/computer/hard_drive/HDD = computer.hard_drive
					if(!HDD)
						return
					var/datum/computer_file/program/email_client/email_c = HDD.find_file_by_name("emailc")	// since it's not a data file, we need to get it manually
					if(!istype(email_c))
						return
					stolen_login = email_c.stored_login
					stolen_password = email_c.stored_password
					email_c.stored_login = "[rand(111,900)]"
					email_c.stored_password = "[rand(111,900)]"

					virus_runcount++
					virus_timer = world.time + 2 MINUTES
			if(2)
				if(stolen_login && stolen_password)
					var/datum/computer_file/data/email_account/stolen_account
					for(var/datum/computer_file/data/email_account/account in ntnet_global.email_accounts)
						if(!account.can_login)
							continue
						if(account.login == stolen_login)
							if(account.password == stolen_password)
								if(account.suspended)
									stolen_login = null
									stolen_password = null
									return
								stolen_account = account
							else
								stolen_login = null
								stolen_password = null
								return
					if(stolen_account)
						var/datum/computer_file/data/email_message/message = new()
						message.title = "Important file"
						message.source = stolen_login
						message.stored_data = "important download, please run immediately"
						message.attachment = clone()
						var/datum/computer_file/data/email_account/recipient = pick(ntnet_global.email_accounts)
						recipient.receive_mail(message, 0)
					else
						stolen_login = null
						stolen_password = null
						return

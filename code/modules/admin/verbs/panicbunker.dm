/client/proc/panicbunker()
	set category = "Server"
	set name = "Toggle Panic Bunker"

	if(!check_rights(R_SERVER))
		return

	if (!sqlenabled)
		to_chat(usr, SPAN_DANGER("The Database is not enabled!"))
		return

	var/newpb = !config.panic_bunker

	if (newpb)
		var/rejectmessage = input("What message should be sent when people attempt to join under the minimum day requirement?") as text
		var/rejectage = input("How many days old must a client be (on our server) to join?") as num

		config.panic_bunker_message = rejectmessage
		config.panic_bunker_age = rejectage

	message_admins("[key_name_admin(src)] has toggled the Panic Bunker, it is now [newpb ? "on and set to [config.panic_bunker_age] days with a message of [config.panic_bunker_message]" : "off"].")
	log_admin("[key_name(src)] has toggled the Panic Bunker, it is now [newpb ? "on and set to [config.panic_bunker_age] days with a message of [config.panic_bunker_message]" : "off"].")
	config.panic_bunker = newpb

/client/proc/panicbunker_ckey_bypass()
	set category = "Server"
	set name = "Add to Panic Bunker Bypass"

	if(!check_rights(R_SERVER))
		return

	var/ckeybypass = input("Which CKEY should be allowed to bypass the Panic Bunker?")
	message_admins("[key_name_admin(src)] has added [ckeybypass] to the Panic Bunker bypass list.")
	log_admin("[key_name(src)] has added [ckeybypass] to the Panic Bunker bypass list.")

	GLOB.panicbunker_bypass += ckeybypass

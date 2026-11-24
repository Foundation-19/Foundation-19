// Allows you to monitor messages that passes the server.

/obj/machinery/computer/message_monitor
	name = "messaging monitor console"
	desc = "Used to access and maintain data on messaging servers. Allows you to view request console messages."
	icon_screen = "comm_logs"
	light_color = "#00b000"
	machine_name = "message monitor console"
	machine_desc = "A console that allows the user to browse request console messages when a special encryption key is provided."
	var/hack_icon = "error"
	//Server linked to.
	var/obj/machinery/message_server/linkedServer = null
	//Sparks effect - For emag
	var/datum/effect/effect/system/spark_spread/spark_system = new /datum/effect/effect/system/spark_spread
	//Messages - Saves me time if I want to change something.
	var/noserver = "<span class='alert'>ALERT: No server detected.</span>"
	var/incorrectkey = "<span class='warning'>ALERT: Incorrect decryption key!</span>"
	var/defaultmsg = "<span class='notice'>Welcome. Please select an option.</span>"
	var/rebootmsg = "<span class='warning'>%$&(£: Critical %$$@ Error // !RestArting! <lOadiNg backUp iNput ouTput> - ?pLeaSe wAit!</span>"
	//Computer properties
	var/screen = 0 		// 0 = Main menu, 1 = Message Logs, 2 = Hacked screen, 3 = Custom Message
	var/hacking = 0		// Is it being hacked into by the AI/Cyborg
	var/emag = 0		// When it is emagged.
	var/message = "<span class='notice'>System bootup complete. Please select an option.</span>"	// The message that shows on the main menu.
	var/auth = 0 // Are they authenticated?

/obj/machinery/computer/message_monitor/attackby(obj/item/O as obj, mob/living/user as mob)
	if(stat & (NOPOWER|BROKEN))
		..()
		return
	if(!istype(user))
		return
	if(isScrewdriver(O) && emag)
		//Stops people from just unscrewing the monitor and putting it back to get the console working again.
		to_chat(user, SPAN_WARNING("It is too hot to mess with!"))
		return

	..()
	return

/obj/machinery/computer/message_monitor/emag_act(remaining_charges, mob/user)
	// Will create sparks and print out the console's password. You will then have to wait a while for the console to be back online.
	// It'll take more time if there's more characters in the password..
	if(!emag && operable())
		if(src.linkedServer)
			emag = 1
			screen = 2
			spark_system.set_up(5, 0, src)
			src.spark_system.start()
			var/obj/item/paper/monitorkey/MK = new/obj/item/paper/monitorkey(src.linkedServer)
			MK.dropInto(loc)
			// Will help make emagging the console not so easy to get away with.
			MK.info += "<br><br><font color='red'>£%@%(*$%&(£&?*(%&£/{}</font>"
			addtimer(CALLBACK(src, PROC_REF(UnmagConsole)), 1 SECOND * length(src.linkedServer.decryptkey))
			message = rebootmsg
			update_icon()
			return 1
		else
			to_chat(user, SPAN_NOTICE("A no server error appears on the screen."))

/obj/machinery/computer/message_monitor/on_update_icon()
	if(emag || hacking)
		icon_screen = hack_icon
	else
		icon_screen = initial(icon_screen)
	..()

/obj/machinery/computer/message_monitor/Initialize()
	//Is the server isn't linked to a server, and there's a server available, default it to the first one in the list.
	if(!linkedServer)
		if(message_servers && message_servers.len > 0)
			linkedServer = message_servers[1]
	return ..()

/obj/machinery/computer/message_monitor/interface_interact(user)
	tgui_interact(user)
	return TRUE

/obj/machinery/computer/message_monitor/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "MessageMonitor", "Message Monitoring Console")
		ui.open()

/obj/machinery/computer/message_monitor/tgui_data(mob/user)
	if(hacking || emag)
		message = rebootmsg
		screen = 2
	else if(!auth || !linkedServer || (linkedServer.stat & (NOPOWER|BROKEN)))
		if(!linkedServer || (linkedServer.stat & (NOPOWER|BROKEN)))
			message = noserver
		screen = 0

	var/list/data = list()
	data["message"] = message
	data["authorized"] = auth ? TRUE : FALSE
	data["screen"] = screen
	data["server_active"] = (linkedServer && linkedServer.active) ? TRUE : FALSE
	data["server_online"] = (linkedServer && !(linkedServer.stat & (NOPOWER|BROKEN))) ? TRUE : FALSE
	data["silicon"] = (istype(user, /mob/living/silicon/ai) || istype(user, /mob/living/silicon/robot)) ? TRUE : FALSE
	data["can_hack"] = (istype(user, /mob/living/silicon/ai) || istype(user, /mob/living/silicon/robot)) && (user.mind && user.mind.special_role && user.mind.original == user)
	if(screen == 4)
		var/list/logs = list()
		var/index = 0
		for(var/datum/data_rc_msg/rc in linkedServer.rc_msgs)
			index++
			if(index > 3000)
				break
			logs += list(list(
				"send_dpt" = rc.send_dpt,
				"rec_dpt" = rc.rec_dpt,
				"message" = rc.message,
				"stamp" = rc.stamp,
				"id_auth" = rc.id_auth,
				"priority" = rc.priority,
				"ref" = "\ref[rc]",
			))
		data["logs"] = logs
	message = defaultmsg
	return data

/obj/machinery/computer/message_monitor/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	switch(action)
		if("auth")
			if(auth)
				auth = 0
				screen = 0
			else
				var/dkey = trim(input(usr, "Please enter the decryption key.") as text|null)
				if(dkey && dkey != "")
					if(linkedServer && linkedServer.decryptkey == dkey)
						auth = 1
					else
						message = incorrectkey
			return TRUE
		if("active")
			if(auth && linkedServer)
				linkedServer.active = !linkedServer.active
			return TRUE
		if("find")
			if(message_servers && message_servers.len > 1)
				linkedServer = input(usr, "Please select a server.", "Select a server.", null) as null|anything in message_servers
				message = SPAN_ALERT("NOTICE: Server selected.")
			else if(message_servers && message_servers.len > 0)
				linkedServer = message_servers[1]
				message = SPAN_NOTICE("NOTICE: Only Single Server Detected - Server selected.")
			else
				message = noserver
			return TRUE
		if("clearr")
			if(!linkedServer || (linkedServer.stat & (NOPOWER|BROKEN)))
				message = noserver
			else if(auth)
				linkedServer.rc_msgs = list()
				message = SPAN_NOTICE("NOTICE: Logs cleared.")
			return TRUE
		if("pass")
			if(!linkedServer || (linkedServer.stat & (NOPOWER|BROKEN)))
				message = noserver
			else if(auth)
				var/dkey = trim(input(usr, "Please enter the decryption key.") as text|null)
				if(dkey && dkey != "")
					if(linkedServer.decryptkey == dkey)
						var/newkey = trim(input(usr, "Please enter the new key (3 - 16 characters max):"))
						if(length(newkey) <= 3)
							message = SPAN_NOTICE("NOTICE: Decryption key too short!")
						else if(length(newkey) > 16)
							message = SPAN_NOTICE("NOTICE: Decryption key too long!")
						else if(newkey && newkey != "")
							linkedServer.decryptkey = newkey
						message = SPAN_NOTICE("NOTICE: Decryption key set.")
					else
						message = incorrectkey
			return TRUE
		if("hack")
			if((istype(usr, /mob/living/silicon/ai) || istype(usr, /mob/living/silicon/robot)) && (usr.mind && usr.mind.special_role && usr.mind.original == usr))
				hacking = 1
				screen = 2
				update_icon()
				spawn(100*length(linkedServer.decryptkey))
					if(src && src.linkedServer && usr)
						BruteForce(usr)
			return TRUE
		if("deleter")
			if(screen == 4)
				if(!linkedServer || (linkedServer.stat & (NOPOWER|BROKEN)))
					message = noserver
				else
					linkedServer.rc_msgs -= locate(params["ref"])
					message = SPAN_NOTICE("NOTICE: Log Deleted!")
			return TRUE
		if("viewr")
			if(!linkedServer || (linkedServer.stat & (NOPOWER|BROKEN)))
				message = noserver
			else if(auth)
				screen = 4
			return TRUE
		if("back")
			screen = 0
			return TRUE
		if("refresh")
			return TRUE
	return FALSE

/obj/machinery/computer/message_monitor/proc/BruteForce(mob/user as mob)
	if(isnull(linkedServer))
		to_chat(user, SPAN_WARNING("Could not complete brute-force: Linked Server Disconnected!"))
	else
		var/currentKey = src.linkedServer.decryptkey
		to_chat(user, SPAN_WARNING("Brute-force completed! The key is '[currentKey]'."))
	src.hacking = 0
	update_icon()
	src.screen = 0 // Return the screen back to normal

/obj/machinery/computer/message_monitor/proc/UnmagConsole()
	src.emag = 0
	update_icon()


/obj/item/paper/monitorkey
	//..()
	name = "Monitor Decryption Key"

/obj/item/paper/monitorkey/proc/print(obj/machinery/message_server/server)
	set_content("<center><h2>Daily Key Reset</h2></center><br>The new message monitor key is '[server.decryptkey]'.<br>This key is only intended for personnel granted access to the messaging server. Keep it safe.<br>If necessary, change the password to a more secure one.")

/obj/item/paper/monitorkey/Initialize(mapload, obj/machinery/message_server/server)
	. = ..()
	if(server)
		print(server)
		return INITIALIZE_HINT_NORMAL
	return INITIALIZE_HINT_LATELOAD

/obj/item/paper/monitorkey/LateInitialize()
	. = ..()
	if(message_servers)
		for(var/obj/machinery/message_server/server in message_servers)
			if(server.decryptkey)
				print(server)
				break

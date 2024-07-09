GLOBAL_LIST_EMPTY(allfaxes)
GLOBAL_LIST_EMPTY(alldepartments)

GLOBAL_LIST_EMPTY(adminfaxes)	//cache for faxes that have been sent to admins

/obj/machinery/photocopier/faxmachine
	name = "fax machine"
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "fax"
	insert_anim = "faxsend"
	var/send_access = list()

	idle_power_usage = 30
	active_power_usage = 200

	var/obj/item/card/id/scan = null // identification
	var/authenticated = 0
	var/department = null // our department
	var/destination = null // the department we're sending to

/obj/machinery/photocopier/faxmachine/Initialize()
	. = ..()

	if(!destination)
		var/datum/offsite/initialOffsite = SSoffsites.offsites[SSoffsites.default_offsite]
		if(initialOffsite)
			destination = initialOffsite.name
		else if(length(GLOB.alldepartments))
			destination = pick(GLOB.alldepartments)

	GLOB.allfaxes += src

	if(department && !(("[department]" in GLOB.alldepartments) || SSoffsites.offsites_by_name["[department]"]))
		GLOB.alldepartments |= department

/obj/machinery/photocopier/faxmachine/attackby(obj/item/O as obj, mob/user as mob)
	if(istype(O, /obj/item/card/id))
		if(!user.unEquip(O, src))
			return
		scan = O
		to_chat(user, SPAN_NOTICE("You insert \the [O] into \the [src]."))
	if(isMultitool(O))
		to_chat(user, SPAN_NOTICE("\The [src]'s department tag is set to [department]."))
		if(!emagged)
			to_chat(user, SPAN_WARNING("\The [src]'s department configuration is vendor locked."))
			return
		var/list/option_list = GLOB.alldepartments.Copy() + "(Custom)"
		var/new_department = tgui_input_list(user, "Which department do you want to tag this fax machine as? Choose '(Custom)' to enter a custom department.", "Fax Machine Department Tag", option_list, department)
		if(!new_department || new_department == department || !CanUseTopic(user) || !Adjacent(user))
			return
		if(new_department == "(Custom)")
			new_department = tgui_input_text(user, "Which department do you want to tag this fax machine as?", "Fax Machine Department Tag", department)
			if(!new_department || new_department == department || !CanUseTopic(user) || !Adjacent(user))
				return
		if(new_department == "Unknown" || new_department == "(Custom)")
			to_chat(user, SPAN_WARNING("Invalid department tag selected."))
			return
		department = new_department
		to_chat(user, SPAN_NOTICE("You reconfigure \the [src]'s department tag to [department]."))
	else
		..()

/obj/machinery/photocopier/faxmachine/emag_act(remaining_charges, mob/user, emag_source)
	if(emagged)
		to_chat(user, SPAN_WARNING("\The [src]'s systems have already been hacked."))
		return
	to_chat(user, SPAN_NOTICE("You unlock \the [src]'s department tagger. You can now modify its department tag to disguise faxes as being from another department or even off-site using a multitool."))
	emagged = TRUE
	return TRUE

/obj/machinery/photocopier/faxmachine/interface_interact(mob/user)
	interact(user)
	return TRUE

/obj/machinery/photocopier/faxmachine/interact(mob/user)
	user.set_machine(src)

	var/scan_name
	if(scan)
		scan_name = scan.name
	else
		scan_name = "--------"

	var/dat = "Confirm Identity: <a href='byond://?src=\ref[src];scan=1'>[scan_name]</a><br>"

	if(authenticated)
		dat += "<a href='byond://?src=\ref[src];logout=1'>Log Out</a>"
	else
		dat += "<a href='byond://?src=\ref[src];auth=1'>Log In</a>"

	dat += "<hr>"

	if(authenticated)
		dat += "<b>Logged in to:</b> [GLOB.using_map.boss_name] Quantum Entanglement Network<br><br>"

		if(copyitem)
			dat += "<a href='byond://?src=\ref[src];remove=1'>Remove Item</a><br><br>"
			dat += "<a href='byond://?src=\ref[src];send=1'>Send</a><br>"
			dat += "<b>Currently sending:</b> [copyitem.name]<br>"
			dat += "<b>Sending to:</b> <a href='byond://?src=\ref[src];dept=1'>[destination ? destination : "Nobody"]</a><br>"

		else
			dat += "Please insert paper to send via secure connection.<br><br>"

	else
		dat += "Proper authentication is required to use this device.<br><br>"

		if(copyitem)
			dat += "<a href ='byond://?src=\ref[src];remove=1'>Remove Item</a><br>"

	var/datum/browser/popup = new(user, "copier", "Fax Machine")
	popup.set_content(dat)
	popup.open()
	onclose(user, "copier")

/obj/machinery/photocopier/faxmachine/OnTopic(mob/user, href_list, state)
	if(href_list["send"])
		if(copyitem)
			if(SSoffsites.offsites_by_name[destination])
				send_admin_fax(user, destination)
			else
				sendfax(destination)

		return TOPIC_REFRESH

	if(href_list["remove"])
		OnRemove(user)
		return TOPIC_REFRESH

	if(href_list["scan"])
		if (scan)
			if(ishuman(user))
				user.put_in_hands(scan)
			else
				scan.dropInto(loc)
			scan = null
		else
			var/obj/item/I = user.get_active_hand()
			if (istype(I, /obj/item/card/id) && user.unEquip(I, src))
				scan = I
		authenticated = 0
		return TOPIC_REFRESH

	if(href_list["dept"])
		var/list/allTargets = list()
		allTargets |= GLOB.alldepartments
		for(var/D in SSoffsites.offsites_by_name)
			if(!is_abstract(SSoffsites.offsites_by_name[D]))
				allTargets |= D

		var/desired_destination = tgui_input_list(user, "Which department?", "Choose a department", allTargets, destination)
		if(desired_destination && CanInteract(user, state))
			destination = desired_destination
		return TOPIC_REFRESH

	if(href_list["auth"])
		if ( (!( authenticated ) && (scan)) )
			if (has_access(send_access, scan.GetAccess()))
				authenticated = 1
		return TOPIC_REFRESH

	if(href_list["logout"])
		authenticated = 0
		return TOPIC_REFRESH

/obj/machinery/photocopier/faxmachine/proc/sendfax(destination)
	if(stat & (BROKEN|NOPOWER))
		return

	use_power_oneoff(200)

	var/success = send_fax_loop(copyitem, destination, department)

	if(success)
		visible_message("[src] beeps, \"Message transmitted successfully.\"")
	else
		visible_message("[src] beeps, \"Error transmitting message.\"")

/// Whether or not the fax machine is in a state capable of receiving faxes. Returns boolean.
/obj/machinery/photocopier/faxmachine/proc/can_receive_fax()
	if(inoperable())
		return FALSE
	if(!department)
		return FALSE
	return TRUE


/obj/machinery/photocopier/faxmachine/proc/recievefax(obj/item/incoming, origin_department = "Unknown")
	flick("faxreceive", src)
	playsound(loc, "sounds/machines/dotprinter.ogg", 50, 1)
	visible_message(SPAN_NOTICE("\The [src] pings, \"New fax received from [origin_department].\""))

	// give the sprite some time to flick
	sleep(20)

	if(istype(incoming, /obj/item/paper))
		var/obj/item/paper/newcopy = copy(incoming, FALSE)
		newcopy.SetName("[origin_department] - [newcopy.name]")
	else if(istype(incoming, /obj/item/photo))
		var/obj/item/photo/newcopy = photocopy(incoming, FALSE)
		newcopy.SetName("[origin_department] - [newcopy.name]")
	else if(istype(incoming, /obj/item/paper_bundle))
		var/obj/item/paper_bundle/newcopy = bundlecopy(incoming, FALSE)
		newcopy.SetName("[origin_department] - [newcopy.name]")
	else
		return

	use_power_oneoff(active_power_usage)
	return

/obj/machinery/photocopier/faxmachine/proc/send_admin_fax(mob/sender, destination)
	if(stat & (BROKEN|NOPOWER))
		return

	var/datum/offsite/destinationOffsite = SSoffsites.offsites_by_name[destination]
	if(!destinationOffsite)
		return

	use_power_oneoff(200)

	//recieved copies should not use toner since it's being used by admins only.
	var/obj/item/rcvdcopy
	if (istype(copyitem, /obj/item/paper))
		rcvdcopy = copy(copyitem, FALSE)
	else if (istype(copyitem, /obj/item/photo))
		rcvdcopy = photocopy(copyitem, FALSE)
	else if (istype(copyitem, /obj/item/paper_bundle))
		rcvdcopy = bundlecopy(copyitem, FALSE)
	else
		visible_message("[src] beeps, \"Error transmitting message.\"")
		return

	rcvdcopy.forceMove(null) //hopefully this shouldn't cause trouble

	if(!fax_offsite(rcvdcopy, sender, destinationOffsite, department))
		// interception!
		visible_message("[src] beeps, \"Message transmitted successfully.\"")
		return

	send_fax_loop(copyitem, destination, department) // Forward to any listening fax machines
	visible_message("[src] beeps, \"Message transmitted successfully.\"")

/// Retrieves a list of all fax machines matching the given department tag.
/proc/get_fax_machines_by_department(department)
	if(!department)
		department = "Unknown"
	var/list/faxes = list()
	for(var/obj/machinery/photocopier/faxmachine/fax in GLOB.allfaxes)
		if(fax.department == department)
			faxes += fax
	return faxes


/// Handles the loop of sending a fax to all machines matching the department tag. Returns `TRUE` if at least one fax machine successfully received the fax. Does not include sending faxes to admins.
/proc/send_fax_loop(copyitem, department, origin = "Unknown")
	var/success = FALSE
	for(var/obj/machinery/photocopier/faxmachine/fax in get_fax_machines_by_department(department))
		if(fax.can_receive_fax())
			success = TRUE
			fax.recievefax(copyitem, origin)
	return success

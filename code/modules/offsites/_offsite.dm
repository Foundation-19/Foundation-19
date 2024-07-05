// This represents an entity (a group, location, person, etc) not physically represented on the map.

/datum/offsite
	abstract_type = /datum/offsite

	var/name = "Unset - contact a coder!"

	/// A list of lists. Each list represents a fax we received. (time received, received copy, origin department)
	var/list/received_faxes = list()
	/// A list of lists. Each list represents a fax we sent. (time sent, sending copy, destination department)
	var/list/sent_faxes = list()

	/// A list of lists. Each list represents a message we received. (time received, received message, sending mob)
	var/list/received_messages = list()
	/// A list of lists. Each list represents a message we sent. (time sent, sent message, receiving mob)
	var/list/sent_messages = list()

// TODO: use alerts to notify admins

/datum/offsite/proc/recieve_fax(obj/item/ref, origin_department = "Unknown")
	received_faxes += list(world.time, ref, origin_department)
	var/adjusted_message = SPAN_NOTICE("<b><font color=darkgreen>FAX TO [uppertext(name)] FROM [origin_department]</b></font> - <a href='?_src_=holder;AdminFaxView=\ref[ref]'>View</a>")

	for(var/client/C in GLOB.admins)
		if(R_MOD & C.holder.rights)
			to_chat(C, adjusted_message)
			sound_to(C, 'sounds/machines/dotprinter.ogg')

// TODO
/datum/offsite/proc/send_fax(client/admin)
	var/datum/admins/admin_datum = admin.holder

	if (!istype(admin_datum, /datum/admins))
		to_chat(admin, "Error: you are not an admin!")
		return

	// Destination
	var/department = tgui_input_list(admin, "Choose a destination fax", "Fax Target", GLOB.alldepartments)

	// Generate the fax
	var/obj/item/paper/admin/P = new /obj/item/paper/admin( null ) //hopefully the null loc won't cause trouble for us
	admin_datum.faxreply = P
	P.admindatum = admin_datum
	P.origin = name
	P.department = department
	P.destinations = get_fax_machines_by_department(department)
	P.adminbrowse()

	sent_faxes += list(world.time, weakref(P), department)

	log_admin("[admin] sent a fax to [department].")

/datum/offsite/proc/receive_message(message, mob/sender)
	received_messages += list(world.time, message, sender)

	var/adjusted_message = SPAN_NOTICE("<b><font color=orange>MESSAGE TO [uppertext(name)] FROM [key_name(sender, 1)] [ADMIN_FULLMONTY(sender)] <a href='?src=\ref[src];send_message=\ref[sender]'>Reply</a></b></font>: [message]")

	for(var/client/C in GLOB.admins)
		if(R_MOD & C.holder.rights)
			to_chat(C, adjusted_message)
			sound_to(C, 'sounds/machines/dotprinter.ogg')

/datum/offsite/proc/send_message(client/admin, mob/living/recipient = null)
	var/datum/admins/admin_datum = admin.holder

	if (!istype(admin_datum, /datum/admins))
		to_chat(admin, "Error: you are not an admin!")
		return

	if(!recipient)
		recipient = input(admin, "Choose the recipient of your message.", "Choose Recipient") in GLOB.living_mob_list_

	if(recipient.can_centcom_reply())
		var/message = tgui_input_text(admin, message = "Enter a message to be sent to the recipient.", title = "Message Input", multiline = TRUE)

		sent_messages += list(world.time, message, recipient)

		log_admin("[admin] sent a message to [key_name(recipient)]: \"[message]\".")

		if(!isAI(recipient))
			to_chat(recipient, SPAN_INFO("You hear something crackle in your headset for a moment before a voice speaks."))
		to_chat(recipient, SPAN_INFO("Please stand by for a message from [name]."))
		to_chat(recipient, SPAN_INFO("Message as follows."))
		to_chat(recipient, SPAN_NOTICE("[message]"))
		to_chat(recipient, SPAN_INFO("Message ends."))
	else
		to_chat(admin, "The person you are trying to contact does not have functional radio equipment.")

/datum/offsite/Topic(href, href_list)
	if(href_list["send_message"] && usr)
		var/client/C = usr.client
		if(C && C.holder)
			// send_message already checks it, but we shouldn't rely on other procs not being changed
			if(!istype(C.holder, /datum/admins))
				to_chat(C, "Error: you are not an admin!")
				return
			send_message(C, locate(href_list["send_message"]))

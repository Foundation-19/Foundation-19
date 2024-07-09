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

	/// Current ID being added to any of the offsite history lists. Shared between the lists.
	var/current_history_id = 0;

/datum/offsite/New()
	. = ..()
	RegisterSignal(src, COMSIG_OFFSITE_FAX_SENT, PROC_REF(add_sent_fax))

/datum/offsite/Destroy()
	UnregisterSignal(src, COMSIG_OFFSITE_FAX_SENT)
	. = ..()

/datum/offsite/proc/add_sent_fax(datum/source, obj/item/copy, obj/item/paper/admin/original)
	var/client/admin = original.admindatum.owner
	current_history_id++
	sent_faxes += list(list(
		"id" = current_history_id,
		"time" = world.time,
		"time_pretty" = gameTimestamp("hh:mm:ss", world.time),
		"ref" = copy,
		"dept" = (original.department || "Unknown"),
		"user" = admin.ckey
	))

/datum/offsite/proc/receive_fax(obj/item/ref, origin_department = "Unknown", mob/sender)
	origin_department = (origin_department || "Unknown")
	current_history_id++
	received_faxes += list(list(
		"id" = current_history_id,
		"time" = world.time,
		"time_pretty" = gameTimestamp("hh:mm:ss", world.time),
		"ref" = ref,
		"dept" = origin_department,
		"user" = key_name(sender),
		"user_key" = sender.ckey
	))

	var/fax_reply_message = origin_department == "Unknown" ? "" : ", <a href='?src=\ref[src];send_fax=[origin_department]'>Reply with Fax</a>"
	var/adjusted_message = SPAN_NOTICE("<b><font color=darkgreen>FAX TO [name] FROM [origin_department] BY [ADMIN_FULLMONTY(sender)]</b></font> - <a href='?_src_=holder;AdminFaxView=\ref[ref]'>View</a>, <a href='?src=\ref[src];send_message=\ref[sender]'>Reply with Message</a>[fax_reply_message]")
	for(var/client/C in GLOB.admins)
		if(R_MOD & C.holder.rights)
			to_chat(C, adjusted_message)
			sound_to(C, 'sounds/machines/dotprinter.ogg')

/datum/offsite/proc/send_fax(client/admin, department)
	var/datum/admins/admin_datum = admin.holder

	if (!istype(admin_datum, /datum/admins))
		to_chat(admin, "Error: you are not an admin!")
		return

	// Destination
	if(!department)
		department = tgui_input_list(admin, "Choose a destination fax", "Fax Target", GLOB.alldepartments)

	// Generate the fax
	var/obj/item/paper/admin/P = new /obj/item/paper/admin( null ) //hopefully the null loc won't cause trouble for us
	admin_datum.faxreply = P
	P.admindatum = admin_datum
	P.origin = name
	P.origin_offsite = src
	P.department = department
	P.destinations = get_fax_machines_by_department(department)
	P.adminbrowse()

	// We don't add the fax to the logs here; because the admin has to confirm the fax in the adminpaper.
	// See `/datum/offsite/proc/add_sent_fax` and relevant signal.

	log_admin("[admin] sent a fax to [department].")

/datum/offsite/proc/receive_message(message, mob/sender)
	current_history_id++
	received_messages += list(list(
		"id" = current_history_id,
		"time" = world.time,
		"time_pretty" = gameTimestamp("hh:mm:ss", world.time),
		"ref" = message,
		"user" = key_name(sender),
		"user_key" = sender.ckey
	))

	var/adjusted_message = SPAN_NOTICE("<b><font color=orange>MESSAGE TO [name] FROM [ADMIN_FULLMONTY(sender)] <a href='?src=\ref[src];send_message=\ref[sender]'>Reply</a></b></font>: [message]")

	for(var/client/C in GLOB.admins)
		if(R_MOD & C.holder.rights)
			to_chat(C, adjusted_message)
			sound_to(C, 'sounds/machines/dotprinter.ogg')

/datum/offsite/proc/send_message(client/admin, mob/living/recipient = null)
	if (!check_rights(R_ADMIN|R_MOD, TRUE, admin))
		return

	if(!recipient)
		recipient = tgui_input_list(admin, "Choose the recipient of your message.", "Choose Recipient", GLOB.player_list & GLOB.living_mob_list_)
	if(!istype(recipient))
		return

	if(!recipient.can_centcom_reply())
		to_chat(admin, SPAN_WARNING("The person you are trying to contact does not have functional radio equipment."))
		return

	var/message = tgui_input_text(admin, message = "Enter a message to be sent to the recipient.", title = "Message Input", multiline = TRUE)
	if(!message)
		return

	current_history_id++
	sent_messages += list(list(
		"id" = current_history_id,
		"time" = world.time,
		"time_pretty" = gameTimestamp("hh:mm:ss", world.time),
		"ref" = message,
		"user" = key_name(recipient),
		"admin" = admin.ckey
	))

	log_admin("[admin] sent a message to [key_name(recipient)]: \"[message]\"")
	message_staff("[key_name_admin(admin)] has sent a message to [key_name(recipient)]: \"[message]\"")

	if(!isAI(recipient))
		to_chat(recipient, SPAN_INFO("You hear something crackle in your headset for a moment before a voice speaks."))
	to_chat(recipient, SPAN_INFO("Please stand by for a message from [name]."))
	to_chat(recipient, SPAN_INFO("Message as follows."))
	to_chat(recipient, SPAN_NOTICE("[message]"))
	to_chat(recipient, SPAN_INFO("Message ends."))

/datum/offsite/Topic(href, href_list)
	if((. = ..()))
		return

	var/client/admin = usr.client
	if(!check_rights(R_ADMIN|R_MOD, TRUE, admin))
		return

	if(href_list["send_message"])
		var/mob/living/target = locate(href_list["send_message"])
		if(istype(target))
			send_message(admin, target)
		else
			to_chat(admin, SPAN_WARNING("That mob no longer exists!"))
		return
	if(href_list["send_fax"])
		var/fax_target = href_list["send_fax"]
		if(fax_target in GLOB.alldepartments)
			send_fax(admin, fax_target)
		else
			to_chat(admin, SPAN_WARNING("That fax came from an invalid department!"))
		return

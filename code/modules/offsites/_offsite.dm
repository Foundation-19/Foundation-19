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

/datum/offsite/proc/send_fax(obj/item/ref, recieving_department = "Unknown")
	sent_faxes += list(world.time, ref, recieving_department)

/datum/offsite/proc/receive_message(message, mob/sender)
	received_messages += list(world.time, message, sender)

	// TODO: replace ADMIN_CENTCOM_REPLY with a send_message ref
	var/adjusted_message = SPAN_NOTICE("<b><font color=orange>MESSAGE TO [uppertext(name)] FROM [key_name(sender, 1)] [ADMIN_FULLMONTY(sender)] [ADMIN_CENTCOM_REPLY(sender)]</b></font>: [message]")

	for(var/client/C in GLOB.admins)
		if(R_MOD & C.holder.rights)
			to_chat(C, adjusted_message)
			sound_to(C, 'sounds/machines/signal.ogg')

/datum/offsite/proc/send_message(message, mob/living/recipient, client/admin)
	if(recipient.can_centcom_reply())
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

// This represents an entity (a group, location, person, etc) not physically represented on the map.

/datum/offsite
	abstract_type = /datum/offsite

	var/name = "Unset - contact a coder!"

	/// A list of lists. Each list represents a fax we received. (received copy, origin department, time received)
	var/list/received_faxes = list()
	/// A list of lists. Each list represents a fax we sent. (sending copy, destination department, time sent)
	var/list/sent_faxes = list()

	/// A list of lists. Each list represents a message we received. (received message, sending mob, time received)
	var/list/received_messages = list()
	/// A list of lists. Each list represents a message we sent. (sent message, receiving mob, sending admin, time received)
	var/list/sent_messages = list()

/datum/offsite/proc/recieve_fax(obj/item/ref, origin_department = "Unknown")
	received_faxes += list(ref, origin_department, world.time)

/datum/offsite/proc/send_fax(obj/item/ref, recieving_department = "Unknown")
	sent_faxes += list(ref, recieving_department, world.time)

/datum/offsite/proc/receive_message(message, mob/sender)
	received_messages += list(message, sender, world.time)

	var/adjusted_message = SPAN_NOTICE("<b><font color=orange>MESSAGE TO [uppertext(name)] FROM [key_name(sender, 1)] [ADMIN_FULLMONTY(sender)] [ADMIN_CENTCOM_REPLY(sender)]</b></font>: [message]")

	for(var/client/C in GLOB.admins)
		if(R_MOD & C.holder.rights)
			to_chat(C, adjusted_message)
			sound_to(C, 'sounds/machines/signal.ogg')

/datum/offsite/proc/send_message(message, mob/living/recipient, client/admin)
	if(recipient.can_centcom_reply())
		sent_messages += list(message, recipient, admin, world.time)

		log_admin("[admin] sent a message to [key_name(recipient)]: \"[message]\".")

		if(!isAI(recipient))
			to_chat(recipient, SPAN_INFO("You hear something crackle in your headset for a moment before a voice speaks."))
		to_chat(recipient, SPAN_INFO("Please stand by for a message from [name]."))
		to_chat(recipient, SPAN_INFO("Message as follows."))
		to_chat(recipient, SPAN_NOTICE("[message]"))
		to_chat(recipient, SPAN_INFO("Message ends."))
	else
		to_chat(admin, "The person you are trying to contact does not have functional radio equipment.")

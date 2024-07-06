/*
* This subsystem populates and manages offsite singletons.
*/

SUBSYSTEM_DEF(offsites)
	name = "Offsites"
	flags = SS_NO_FIRE
	/// Associative list. Key is the offsite type, value is the offsite ref
	var/list/offsites = list()

	/// Associative list. Key is the offsite name, value is the offsite ref
	var/list/offsites_by_name = list()

/datum/controller/subsystem/offsites/Initialize(timeofday)
	initialize_offsites()
	return ..()

///Ran on initialize, populates the addiction dictionary
/datum/controller/subsystem/offsites/proc/initialize_offsites()
	for(var/type in subtypesof(/datum/offsite))
		if(is_abstract(type))
			continue

		var/datum/offsite/ref = new type
		offsites[type] = ref
		offsites_by_name[ref.name] = ref

/datum/controller/subsystem/offsites/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "OffsitePanel", "Offsites")
		ui.open()

/datum/controller/subsystem/offsites/tgui_data(mob/user)
	var/list/data = list()

	for(var/key in offsites)
		var/datum/offsite/OS = offsites[key]

		// TODO: timesort instead of type categories
		var/list/timesorted_data = list()

		for(var/thing in OS.received_faxes)
			var/list/rec_fax = thing
			rec_fax += "Received fax from"
			BINARY_INSERT_DEFINE(thing, timesorted_data, SORT_VAR_NO_TYPE, thing, SORT_FIRST_INDEX, COMPARE_VALUE)

		for(var/thing in OS.sent_faxes)
			var/list/sent_fax = thing
			var/weakref/paper_ref = sent_fax[2]
			sent_fax += "Sent fax to"
			sent_fax[2] = paper_ref?.resolve()
			BINARY_INSERT_DEFINE(thing, timesorted_data, SORT_VAR_NO_TYPE, thing, SORT_FIRST_INDEX, COMPARE_VALUE)

		for(var/thing in OS.received_messages)
			var/list/received_message = thing
			received_message += "Received message from"
			BINARY_INSERT_DEFINE(thing, timesorted_data, SORT_VAR_NO_TYPE, thing, SORT_FIRST_INDEX, COMPARE_VALUE)

		for(var/thing in OS.sent_messages)
			var/list/sent_message = thing
			sent_message += "Sent message to"
			BINARY_INSERT_DEFINE(thing, timesorted_data, SORT_VAR_NO_TYPE, thing, SORT_FIRST_INDEX, COMPARE_VALUE)

		data["offsites"] += list(list(OS.name, OS.type, timesorted_data))

	return data

/datum/controller/subsystem/offsites/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return

	switch(action)
		if("send_fax")
			var/datum/offsite/cur_os = offsites[params["id"]]
			cur_os.send_fax() // TODO
		if("send_msg")
			var/datum/offsite/cur_os = offsites[params["id"]]
			cur_os.send_message(usr)


/datum/controller/subsystem/offsites/tgui_state(mob/user)
	return GLOB.admin_tgui_state

// TODO: track interception separately for each offsite + methods that bypass interception?
/proc/message_offsite(msg, mob/sender, offsite_type)
	var/list/mob/living/silicon/ai/intercepters = check_for_interception()

	if(intercepters.len)
		for(var/thing in intercepters)
			var/mob/living/silicon/ai/ai = thing

			var/action = tgui_alert(ai, "Outgoing message from [sender]:\n", "Message Intercepted", list("Modify", "Block", "Allow"), timeout = 30 SECONDS)

			switch(action)
				if("Modify")
					msg = tgui_input_text(ai, "Set new message (from [sender]):", "Modify Message", default = msg)
				if("Block")
					return

	var/datum/offsite/os = SSoffsites.offsites[offsite_type]
	os.receive_message(msg, sender)

/proc/fax_offsite(obj/item/rcvdcopy, mob/sender, offsite_type, department)
	var/datum/offsite/os = SSoffsites.offsites[offsite_type]
	if(!os)
		// we can still forward to other fax machines with the dept tag
		return TRUE

	var/list/mob/living/silicon/ai/intercepters = check_for_interception()
	if(intercepters.len)
		for(var/thing in intercepters)
			var/mob/living/silicon/ai/ai = thing

			if(tgui_alert(ai, "Outgoing fax from [department] to [os.name]!", "Fax intercepted", list("Intercept", "Allow"), timeout = 30 SECONDS) == "Intercept")

				if(istype(rcvdcopy, /obj/item/paper))
					var/obj/item/paper/paper_copy = rcvdcopy
					paper_copy.show_content(ai, TRUE)
					var/action = tgui_alert(ai, "Modify, block, or allow fax?", "Choose action", list("Modify", "Block", "Allow"))

					switch(action)
						if("Modify")
							var/t =  sanitize(input(ai, "Enter what you want to write:", "Write", html2pencode(paper_copy.info), null) as message, MAX_PAPER_MESSAGE_LEN, extra = 0)

							if(!t)
								continue

							var/old_fields_value = paper_copy.fields
							paper_copy.fields = 0
							t = replacetext(t, "\n", "<BR>")
							t = paper_copy.parsepencode(t) // Encode everything from pencode to html

							if(paper_copy.fields > 50)//large amount of fields creates a heavy load on the server, see updateinfolinks() and addtofield()
								to_chat(usr, SPAN_WARNING("Too many fields. Sorry, you can't do this."))
								paper_copy.fields = old_fields_value
								continue

							paper_copy.info = t // set the file to the new text
							paper_copy.updateinfolinks()

							//manualy set freespace
							paper_copy.free_space = MAX_PAPER_MESSAGE_LEN - length(strip_html_properly(t))
							paper_copy.update_icon()

						if("Block")
							paper_copy = null
							QDEL_NULL(rcvdcopy)
							return FALSE
				else if(istype(rcvdcopy, /obj/item/photo))
					var/obj/item/photo/photo_copy = rcvdcopy
					photo_copy.show(ai)

					if(tgui_alert(ai, "Block or allow fax?", "Choose action", list("Block", "Allow")) == "Block")
						photo_copy = null
						QDEL_NULL(rcvdcopy)
						return FALSE
				else // paper bundle
					var/obj/item/paper_bundle/bundle_copy = rcvdcopy
					bundle_copy.show_content(ai)

					if(tgui_alert(ai, "Block or allow fax?", "Choose action", list("Block", "Allow")) == "Block")
						bundle_copy = null
						QDEL_NULL(rcvdcopy)
						return FALSE

	os.receive_fax(rcvdcopy, department, sender)
	return TRUE

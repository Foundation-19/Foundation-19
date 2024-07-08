/*
* This subsystem populates and manages offsite singletons.
*/

SUBSYSTEM_DEF(offsites)
	name = "Offsites"
	init_order = SS_INIT_OFFSITES
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

	data["offsites"] = list()
	for(var/key in offsites)
		var/datum/offsite/OS = offsites[key]

		// TODO: timesort instead of type categories
		var/list/timesorted_data = list()

		for(var/thing in OS.received_faxes)
			var/list/rec_fax = list()
			rec_fax += thing
			rec_fax += "Received fax from"
			rec_fax += gameTimestamp("hh:mm:ss", rec_fax[1])
			BINARY_INSERT_DEFINE(list(rec_fax), timesorted_data, SORT_VAR_NO_TYPE, thing, SORT_FIRST_INDEX, COMPARE_KEY)

		for(var/thing in OS.sent_faxes)
			var/list/sent_fax = list()
			sent_fax += thing
			sent_fax += "Sent fax to"
			sent_fax += gameTimestamp("hh:mm:ss", sent_fax[1])
			BINARY_INSERT_DEFINE(list(sent_fax), timesorted_data, SORT_VAR_NO_TYPE, thing, SORT_FIRST_INDEX, COMPARE_KEY)

		for(var/thing in OS.received_messages)
			var/list/received_message = list()
			received_message += thing
			received_message += "Received message from"
			received_message += gameTimestamp("hh:mm:ss", received_message[1])
			BINARY_INSERT_DEFINE(list(received_message), timesorted_data, SORT_VAR_NO_TYPE, thing, SORT_FIRST_INDEX, COMPARE_KEY)

		for(var/thing in OS.sent_messages)
			var/list/sent_message = list()
			sent_message += thing
			sent_message += "Sent message to"
			sent_message += gameTimestamp("hh:mm:ss", sent_message[1])
			BINARY_INSERT_DEFINE(list(sent_message), timesorted_data, SORT_VAR_NO_TYPE, thing, SORT_FIRST_INDEX, COMPARE_KEY)

		data["offsites"] += list(list(OS.name, OS.type, timesorted_data))

	return data

/datum/controller/subsystem/offsites/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return

	var/mob/admin = usr
	if(!check_rights(R_ADMIN|R_MOD, TRUE, admin))
		return

	var/datum/offsite/cur_os = offsites[text2path(params["id"])]
	if(!cur_os)
		return

	switch(action)
		if("send_fax")
			cur_os.send_fax(admin.client)
		if("send_msg")
			cur_os.send_message(admin.client)
		if("read_fax")
			var/fax_type = params["fax_type"]
			var/fax_time = text2num(params["fax"])

			var/obj/item/fax
			var/list/target_list = findtext(fax_type, "Sent fax") ? cur_os.sent_faxes : cur_os.received_faxes
			for(var/F in target_list)
				if(F[1] == fax_time)
					fax = F[2]
					break

			if(isnull(fax))
				to_chat(admin, SPAN_WARNING("The fax you're trying to view has been deleted!"))

			if (istype(fax, /obj/item/paper))
				var/obj/item/paper/P = fax
				P.show_content(admin, TRUE)
			else if (istype(fax, /obj/item/photo))
				var/obj/item/photo/H = fax
				H.show(admin)
			else if (istype(fax, /obj/item/paper_bundle))
				//having multiple people turning pages on a paper_bundle can cause issues
				//open a browse window listing the contents instead
				var/data = ""
				var/obj/item/paper_bundle/B = fax

				for (var/page = 1, page <= B.pages.len, page++)
					var/obj/pageobj = B.pages[page]
					data += "<A href='?_src_=holder;AdminFaxViewPage=[page];paper_bundle=\ref[B]'>Page [page] - [pageobj.name]</A><BR>"

				show_browser(admin, data, "window=[B.name]")
			else
				to_chat(admin, SPAN_WARNING("The faxed item is not viewable. This is probably a bug, and should be reported on the tracker. Fax type: [fax ? fax.type : "null"]"))

/datum/controller/subsystem/offsites/tgui_state(mob/user)
	return GLOB.admin_tgui_state

// TODO: track interception separately for each offsite + methods that bypass interception?
/proc/message_offsite(msg, mob/sender, offsite_type)
	var/datum/offsite/os
	if(isdatum(offsite_type))
		os = offsite_type
	else
		os = SSoffsites.offsites[offsite_type]
	if(!os)
		return

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

	os.receive_message(msg, sender)

/proc/fax_offsite(obj/item/rcvdcopy, mob/sender, offsite_type, department)
	var/datum/offsite/os
	if(isdatum(offsite_type))
		os = offsite_type
	else
		os = SSoffsites.offsites[offsite_type]
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
							var/t = tgui_input_text(ai, "Enter what you want to write:", "Write", html2pencode(paper_copy.info), MAX_PAPER_MESSAGE_LEN, TRUE)
							if(!t)
								continue

							var/old_fields_value = paper_copy.fields
							paper_copy.fields = 0
							t = replacetext(t, "\n", "\[br\]")
							t = paper_copy.parsepencode(t) // Encode everything from pencode to html

							if(paper_copy.fields > 50)//large amount of fields creates a heavy load on the server, see updateinfolinks() and addtofield()
								to_chat(sender, SPAN_WARNING("Too many fields. Sorry, you can't do this."))
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

/*
* This subsystem populates and manages offsite singletons.
*/

SUBSYSTEM_DEF(offsites)
	name = "Offsites"
	flags = SS_NO_FIRE
	/// Associative list. Key is the offsite type, value is the offsite ref
	var/list/offsites = list()

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
			sent_fax += "Sent fax to"
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
		if("send_msg")
			var/datum/offsite/cur_os = offsites[params["id"]]


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

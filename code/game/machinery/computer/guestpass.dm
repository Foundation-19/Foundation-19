/////////////////////////////////////////////
//Guest pass ////////////////////////////////
/////////////////////////////////////////////
/obj/item/card/id/guest
	name = "temporary access pass"
	desc = "Allows temporary access to restricted areas."
	color = COLOR_PALE_GREEN_GRAY
	detail_color = COLOR_GREEN

	var/list/temp_access = list() //to prevent agent cards stealing access as permanent
	var/expiration_time = 0
	var/expired = FALSE
	var/reason = "NOT SPECIFIED"

/obj/item/card/id/guest/GetAccess()
	return temp_access

/obj/item/card/id/guest/examine(mob/user)
	. = ..()
	if (!expired)
		to_chat(user, SPAN_NOTICE("This pass expires at [time2text(SSticker.round_start_time + expiration_time, "hh:mm")]."))
	else
		to_chat(user, SPAN_WARNING("It expired at [time2text(SSticker.round_start_time + expiration_time, "hh:mm")]."))

/obj/item/card/id/guest/read()
	if (expired)
		to_chat(usr, SPAN_NOTICE("This pass expired at [time2text(SSticker.round_start_time + expiration_time, "hh:mm")]."))
	else
		to_chat(usr, SPAN_NOTICE("This pass expires at [time2text(SSticker.round_start_time + expiration_time, "hh:mm")]."))

	to_chat(usr, SPAN_NOTICE("It grants access to following areas:"))
	for (var/A in temp_access)
		to_chat(usr, SPAN_NOTICE("[get_access_desc(A)]."))
	to_chat(usr, SPAN_NOTICE("Issuing reason: [reason]."))

/obj/item/card/id/guest/proc/expire()
	color = COLOR_BLACK
	detail_color = COLOR_BLACK
	update_icon()

	expired = TRUE
	temp_access = initial(temp_access)

/////////////////////////////////////////////
//Guest pass terminal////////////////////////
/////////////////////////////////////////////

#define GUESTPASS_MIN_DURATION 1
#define GUESTPASS_MAX_DURATION 60
#define GUESTPASS_STRING_UNSPECIFIED "NOT SPECIFIED"
/obj/machinery/computer/guestpass
	name = "temporary access terminal"
	icon_state = "guest"
	icon_keyboard = null
	icon_screen = "pass"
	density = FALSE
	machine_name = "temporary access terminal"
	machine_desc = "Temporary access passes are limited-time access passes that can be used to enter areas that would otherwise be inaccessible. This terminal allows them to be configured and created."

	var/obj/item/card/id/giver
	var/list/accesses = list()
	var/operating_access_types = ACCESS_TYPE_NONE | ACCESS_TYPE_STATION
	var/special_access_types = ACCESS_TYPE_CONTAINMENT
	var/giv_name = "NOT SPECIFIED"
	var/reason = "NOT SPECIFIED"

	var/area_code

	var/min_duration = GUESTPASS_MIN_DURATION
	var/max_duration = GUESTPASS_MAX_DURATION
	var/duration = 5

	var/list/internal_log = list()
	var/mode = 0  // 0 - making pass, 1 - viewing logs

/obj/machinery/computer/guestpass/New()
	..()
	uid = "[random_id("guestpass_serial_number",100,999)]-G[rand(10,99)]"

/obj/machinery/computer/guestpass/proc/guestpass_access_check(acc)
	var/datum/access/acc_datum = get_access_by_id(acc)

	// See if they meet any of the access prerequisite requirements
	for(var/prereq_acc in acc_datum?.guestpass_access_prerequisites)
		if(prereq_acc in giver.access)
			. = TRUE
			break

	// Make sure the access is one we actually dispense
	return . && (special_access_types & acc_datum.access_type)

/obj/machinery/computer/guestpass/attackby(obj/O, mob/user)
	if(istype(O, /obj/item/card/id))
		if(!giver && user.unEquip(O))
			O.forceMove(src)
			giver = O
			updateUsrDialog()
		else if(giver)
			to_chat(user, SPAN_WARNING("There is already ID card inside."))
		return
	..()

/obj/machinery/computer/guestpass/interface_interact(mob/user)
	tgui_interact(user)
	return TRUE

/obj/machinery/computer/guestpass/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "GuestPass", "Temporary Access Terminal")
		ui.open()

/obj/machinery/computer/guestpass/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("set_mode")
			mode = params["new_mode"]
			. = TRUE
			SStgui.update_user_uis(ui.user)

		if("give_name")
			var/name = tgui_input_text(ui.user, "Input a name for the TAP.", "Name")
			if(name)
				giv_name = sanitize(name)
			. = TRUE
			SStgui.update_user_uis(ui.user)

		if("set_reason")
			var/reas = tgui_input_text(ui.user, "Input a reason for the TAP.", "Reason", (reason == initial(reason) ? null : reason))
			if(reas)
				reason = sanitize(reas)
			. = TRUE
			SStgui.update_user_uis(ui.user)

		if("set_duration")
			var/dur = clamp(text2num(params["duration"]), min_duration, max_duration)
			if(dur)
				duration = dur
			. = TRUE
			SStgui.update_user_uis(ui.user)

		if("set_access")
			var/A = params["access"]
			var/datum/access/acc = get_access_by_id(A)
			if (A in accesses)
				accesses.Remove(A)
			else if (((A in giver?.access) || guestpass_access_check(acc)) && ((operating_access_types | special_access_types) & acc.access_type))
				accesses.Add(A)
			. = TRUE
			SStgui.update_user_uis(ui.user)

		if("id") // insert / take out giver id
			if (giver)
				giver.dropInto(ui.user.loc)
				if(ishuman(ui.user))
					ui.user.put_in_hands(giver)
				giver = null
				accesses.Cut()
			else
				var/obj/item/I = ui.user.get_active_hand()
				if (istype(I, /obj/item/card/id) && ui.user.unEquip(I))
					I.forceMove(src)
					giver = I

			. = TRUE
			SStgui.update_user_uis(ui.user)

		if("print")
			var/dat = "<h3>Activity log of guest pass terminal #[uid]</h3><br>"
			for (var/entry in internal_log)
				dat += "[entry]<br><hr>"
			var/obj/item/paper/P = new (loc)
			P.SetName("activity log")
			P.info = dat
			. = TRUE
			SStgui.update_user_uis(ui.user)

		if ("issue_id") // issue guest ID
			if (giver && accesses.len)
				var/number = add_zero(random_id("guestpass_id_number",1000,9999), 4)
				var/entry = "\[[station_time_timestamp("hh:mm")]\] Pass #[number] issued by [giver.registered_name] ([giver.assignment]) to [giv_name]. Reason: [reason]. Granted access to following areas: "
				var/list/access_descriptors = list()
				for (var/A in accesses)
					var/datum/access/acc = get_access_by_id(A)
					if (((A in giver.access) || guestpass_access_check(acc)) && (acc.access_type in operating_access_types))
						access_descriptors += get_access_desc(A)
				entry += english_list(access_descriptors, and_text = ", ")
				entry += ". Expires at [time2text(SSticker.round_start_time + duration MINUTES, "hh:mm")]."
				internal_log.Add(entry)

				var/obj/item/card/id/guest/pass = new(src.loc)
				pass.temp_access = accesses.Copy()
				pass.registered_name = giv_name
				pass.expiration_time = world.time + duration MINUTES
				pass.reason = reason
				pass.SetName("temporary access pass #[number]")
				pass.assignment = "Guest"
				addtimer(CALLBACK(pass, /obj/item/card/id/guest/proc/expire), duration MINUTES, TIMER_UNIQUE)
				playsound(src.loc, 'sound/machines/ping.ogg', 25, 0)
				giv_name = GUESTPASS_STRING_UNSPECIFIED
				reason = GUESTPASS_STRING_UNSPECIFIED
				accesses.Cut()
			else if(!giver)
				to_chat(ui.user, SPAN_WARNING("Cannot issue pass without issuing ID."))
			else if(!accesses.len)
				to_chat(ui.user, SPAN_WARNING("Cannot issue pass without at least one granted access permission."))

			. = TRUE
			SStgui.update_user_uis(ui.user)


/obj/machinery/computer/guestpass/tgui_data(mob/user)
	. = list()
	.["mode"] = mode
	.["internal_log"] = internal_log
	.["reason"] = reason
	.["duration"] = duration
	.["min_duration"] = min_duration
	.["max_duration"] = max_duration
	.["area_code"] = area_code

	.["area_access"] = list()
	.["special_access"] = list()
	.["giver"] = FALSE
	.["giver_name"] = "No ID Inserted!"
	.["guestpass_name"] = "NOT SPECIFIED"

	if(giver)
		.["giver"] = !!giver
		.["giver_name"] = giver.rank || giver.assignment || SSjobs.get_by_path(giver.job_access_type).title
		.["guestpass_name"] = giv_name

		// operating (area) access
		var/list/operating_access = list()
		for(var/A in giver.access)
			var/datum/access/acc = get_access_by_id(A)
			if(operating_access_types & acc.access_type)
				operating_access.Add(list(list(
					"desc" = acc.desc,
					"access" = A,
					"selected" = (A in accesses)
				)))
		// special access
		var/list/special_access = list()
		for(var/A in get_access_ids(special_access_types))
			var/datum/access/acc = get_access_by_id(A)
			if(guestpass_access_check(acc) && (special_access_types & acc.access_type))
				special_access.Add(list(list(
					"desc" = acc.desc,
					"access" = A,
					"selected" = (A in accesses)
				)))

		.["area_access"] = operating_access
		.["special_access"] = special_access

#undef GUESTPASS_MIN_DURATION
#undef GUESTPASS_MAX_DURATION
#undef GUESTPASS_STRING_UNSPECIFIED

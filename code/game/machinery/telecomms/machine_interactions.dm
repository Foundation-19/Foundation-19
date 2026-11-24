/*

	All telecommunications interactions:

*/

#define STATION_Z 1
#define TELECOMM_Z 3

/obj/machinery/telecomms
	var/temp = "" // output message
	construct_state = /decl/machine_construction/tcomms/panel_closed
	uncreated_component_parts = null
	stat_immune = 0
	maximum_component_parts = list(/obj/item/stock_parts = 15)

/obj/machinery/telecomms/attackby(obj/item/P as obj, mob/user as mob)

	// Using a multitool lets you access the receiver's interface
	if(isMultitool(P))
		interface_interact(user)
		return TRUE

	// REPAIRING: Use Nanopaste to repair 10-20 integrity points.
	if(istype(P, /obj/item/stack/nanopaste))
		var/obj/item/stack/nanopaste/T = P
		if (integrity < 100)               								//Damaged, let's repair!
			if (T.use(1))
				integrity = between(0, integrity + rand(10,20), 100)
				to_chat(usr, "You apply the Nanopaste to [src], repairing some of the damage.")
		else
			to_chat(usr, "This machine is already in perfect condition.")
		return

	return component_attackby(P, user)

/obj/machinery/telecomms/cannot_transition_to(state_path, mob/user)
	. = ..()
	if(. != MCS_CHANGE)
		return

	if(state_path == /decl/machine_construction/default/deconstructed)
		to_chat(user, "You begin prying out the circuit board other components...")
		playsound(src.loc, 'sounds/items/Crowbar.ogg', 50, 1)
		if(do_after(user, 8 SECONDS, src, bonus_percentage = 25))
			to_chat(user, "You finish prying out the components.")
			return
		return MCS_BLOCK

/obj/machinery/telecomms/dismantle()
	for(var/obj/x in (contents - component_parts))
		x.dropInto(loc)
	. = ..()

// This should all be a multitool extension, but outside the scope of current rework.
/obj/machinery/telecomms/CanUseTopic(mob/user)
	// You need a multitool to use this, or be silicon
	if(!issilicon(user))
		// istype returns false if the value is null
		if(!istype(user.get_active_hand(), /obj/item/device/multitool))
			return STATUS_CLOSE
	return ..()

/obj/machinery/telecomms/interface_interact(mob/user)
	tgui_interact(user)
	return TRUE

/obj/machinery/telecomms/tgui_interact(mob/user, datum/tgui/ui)
	user.set_machine(src)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TelecommsLink", "[src.name] Access")
		ui.open()

/obj/machinery/telecomms/tgui_data(mob/user)
	var/list/data = list()
	data["name"] = src.name
	data["toggled"] = src.toggled
	data["temp"] = temp
	temp = ""
	data["overloaded"] = overloaded_for ? overloaded_for * 2 : 0
	data["active"] = (on && toggled) ? 1 : 0
	data["id"] = id
	data["network"] = network
	data["prefab"] = autolinkers.len ? 1 : 0
	data["hide"] = hide

	var/list/linked = list()
	var/i = 0
	for(var/obj/machinery/telecomms/T in links)
		i++
		if(T.hide && !src.hide)
			continue
		linked += list(list("index" = i, "name" = T.name, "id" = T.id))
	data["links"] = linked

	var/list/frequencies = list()
	for(var/x in freq_listening)
		frequencies += list(list("freq" = x, "display" = format_frequency(x)))
	data["frequencies"] = frequencies

	var/list/tag_rules = list()
	for(var/list/rule in channel_tags)
		tag_rules += list(list("freq" = rule[1], "display" = format_frequency(rule[1]), "tag" = rule[2], "color" = rule[3]))
	data["channel_tags"] = tag_rules

	var/obj/item/device/multitool/P = get_multitool(user)
	if(P)
		data["multitool"] = 1
		var/obj/machinery/telecomms/device = P.get_buffer()
		if(istype(device))
			data["buffer"] = list("name" = device.name, "id" = device.id)
		else
			data["buffer"] = null
	else
		data["multitool"] = 0
		data["buffer"] = null

	data["options"] = Options_Data()
	return data

/obj/machinery/telecomms/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if(!issilicon(usr))
		if(!istype(usr.get_active_hand(), /obj/item/device/multitool))
			return TRUE
	if(stat & (BROKEN|NOPOWER))
		return TRUE

	var/obj/item/device/multitool/P = get_multitool(usr)

	switch(action)
		if("toggle")
			src.toggled = !src.toggled
			temp = "<font color = #666633>-% [src] has been [src.toggled ? "activated" : "deactivated"].</font>"
			update_power()
			return TRUE

		if("resetoverload")
			overloaded_for = 0
			temp = "<font color = #666633>-% Manual override accepted. \The [src] has been reset.</font>"
			return TRUE

		if("id")
			var/newid = copytext(reject_bad_text(input(usr, "Specify the new ID for this machine", src, id) as null|text),1,MAX_MESSAGE_LEN)
			if(newid && canAccess(usr))
				id = newid
				temp = "<font color = #666633>-% New ID assigned: \"[id]\" %-</font>"
			return TRUE

		if("network")
			var/newnet = input(usr, "Specify the new network for this machine. This will break all current links.", src, network) as null|text
			if(newnet && canAccess(usr))
				if(length(newnet) > 15)
					temp = "<font color = #666633>-% Too many characters in new network tag %-</font>"
				else
					for(var/obj/machinery/telecomms/T in links)
						T.links.Remove(src)
					network = newnet
					links = list()
					temp = "<font color = #666633>-% New network tag assigned: \"[network]\" %-</font>"
			return TRUE

		if("freq")
			var/newfreq = input(usr, "Specify a new frequency to filter (GHz). Decimals assigned automatically.", src, network) as null|num
			if(newfreq && canAccess(usr))
				if(findtext(num2text(newfreq), "."))
					newfreq *= 10 // shift the decimal one place
				if(!(newfreq in freq_listening) && newfreq < 10000)
					freq_listening.Add(newfreq)
					temp = "<font color = #666633>-% New frequency filter assigned: \"[newfreq] GHz\" %-</font>"
			return TRUE

		if("tagrule")
			var/freq = input(usr, "Specify frequency to tag (GHz). Decimals assigned automatically.", src, network) as null|num
			if(freq && canAccess(usr))
				if(findtext(num2text(freq), "."))
					freq *= 10

				if(!(freq in freq_listening))
					temp = "<font color = #660000>-% Not filtering specified frequency %-</font>"
					return TRUE

				for(var/list/rule in channel_tags)
					if(rule[1] == freq)
						temp = "<font color = #660000>-% Tagging rule already defined %-</font>"
						return TRUE

				var/tag = input(usr, "Specify tag.", src, "") as null|text
				var/color = input(usr, "Select color.", src, "") as null|anything in (channel_color_presets + "Custom color")

				if(color == "Custom color")
					color = input("Select color.", src, rgb(0, 128, 0)) as null|color
				else
					color = channel_color_presets[color]

				if(freq < 10000)
					channel_tags.Add(list(list(freq, tag, color)))
					temp = "<font color = #666633>-% New tagging rule assigned:[freq] GHz -> \"[tag]\" ([color]) %-</font>"
			return TRUE

		if("delete")
			var/x = text2num(params["freq"])
			temp = "<font color = #666633>-% Removed frequency filter [x] %-</font>"
			freq_listening.Remove(x)
			return TRUE

		if("deletetagrule")
			var/freq = text2num(params["freq"])
			var/rule_delete
			for(var/list/rule in channel_tags)
				if(rule[1] == freq)
					rule_delete = rule
			temp = "<font color = #666633>-% Removed tagging rule: [rule_delete[1]] -> [rule_delete[2]] %-</font>"
			channel_tags.Remove(list(rule_delete))
			return TRUE

		if("unlink")
			var/index = text2num(params["index"])
			if(index <= length(links))
				var/obj/machinery/telecomms/T = links[index]
				temp = "<font color = #666633>-% Removed \ref[T] [T.name] from linked entities. %-</font>"
				if(src in T.links)
					T.links.Remove(src)
				links.Remove(T)
			return TRUE

		if("link")
			if(P)
				var/obj/machinery/telecomms/device = P.get_buffer()
				if(istype(device) && device != src)
					if(!(src in device.links))
						device.links.Add(src)
					if(!(device in src.links))
						src.links.Add(device)
					temp = "<font color = #666633>-% Successfully linked with \ref[device] [device.name] %-</font>"
				else
					temp = "<font color = #666633>-% Unable to acquire buffer %-</font>"
			return TRUE

		if("buffer")
			P.set_buffer(src)
			var/atom/buffer = P.get_buffer()
			temp = "<font color = #666633>-% Successfully stored \ref[buffer] [buffer.name] in buffer %-</font>"
			return TRUE

		if("flush")
			temp = "<font color = #666633>-% Buffer successfully flushed. %-</font>"
			P.set_buffer(null)
			return TRUE

	if(Options_Act(action, params))
		return TRUE
	return FALSE

// Returns a multitool from a user depending on their mobtype.

/obj/machinery/telecomms/proc/get_multitool(mob/user as mob)

	var/obj/item/device/multitool/P = null
	// Let's double check
	if(!issilicon(user) && istype(user.get_active_hand(), /obj/item/device/multitool))
		P = user.get_active_hand()
	else if(isAI(user))
		var/mob/living/silicon/ai/U = user
		P = U.aiMulti
	else if(isrobot(user) && in_range(user, src))
		if(istype(user.get_active_hand(), /obj/item/device/multitool))
			P = user.get_active_hand()
	return P

// Additional Options for certain machines. Use this when you want to add an option to a specific machine.
// Example of how to use below.

/obj/machinery/telecomms/proc/Options_Data()
	return null

/*
// Add an option to the processor to switch processing mode. (COMPRESS -> UNCOMPRESS or UNCOMPRESS -> COMPRESS)
/obj/machinery/telecomms/processor/Options_Data()
	return list("process_mode" = process_mode)
*/
// Handle the actions for Additional Options. Use this for your specific option.
/obj/machinery/telecomms/proc/Options_Act(action, list/params)
	return FALSE

/*
/obj/machinery/telecomms/processor/Options_Act(action, list/params)
	if(action == "process")
		temp = "<font color = #666633>-% Processing mode changed. %-</font>"
		src.process_mode = !src.process_mode
		return TRUE
	return FALSE
*/

// BUS

/obj/machinery/telecomms/bus/Options_Data()
	return list("change_frequency" = change_frequency)

/obj/machinery/telecomms/bus/Options_Act(action, list/params)
	if(action == "change_freq")
		var/newfreq = input(usr, "Specify a new frequency for new signals to change to. Enter null to turn off frequency changing. Decimals assigned automatically.", src, network) as null|num
		if(canAccess(usr))
			if(newfreq)
				if(findtext(num2text(newfreq), "."))
					newfreq *= 10 // shift the decimal one place
				if(newfreq < 10000)
					change_frequency = newfreq
					temp = "<font color = #666633>-% New frequency to change to assigned: \"[newfreq] GHz\" %-</font>"
			else
				change_frequency = 0
				temp = "<font color = #666633>-% Frequency changing deactivated %-</font>"
		return TRUE
	return FALSE


/obj/machinery/telecomms/proc/canAccess(mob/user)
	if(issilicon(user) || in_range(user, src))
		return 1
	return 0

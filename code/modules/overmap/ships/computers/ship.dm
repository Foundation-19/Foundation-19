/*
While these computers can be placed anywhere, they will only function if placed on either a non-space, non-shuttle turf
with an /obj/effect/overmap/visitable/ship present elsewhere on that z level, or else placed in a shuttle area with an /obj/effect/overmap/visitable/ship
somewhere on that shuttle. Subtypes of these can be then used to perform ship overmap movement functions.
*/
/obj/machinery/computer/ship
	var/obj/effect/overmap/visitable/ship/linked
	var/list/viewers // Weakrefs to mobs in direct-view mode.
	var/extra_view = 0 // how much the view is increased by when the mob is in overmap mode.
	var/reconnect_flavor = ""
	var/datum/ship_reconnect/reconnect_dialog

// A late init operation called in SSshuttle, used to attach the thing to the right ship.
/obj/machinery/computer/ship/proc/attempt_hook_up(obj/effect/overmap/visitable/ship/sector)
	if(!istype(sector))
		return
	if(sector.check_ownership(src))
		linked = sector
		return 1

/obj/machinery/computer/ship/proc/sync_linked()
	var/obj/effect/overmap/visitable/ship/sector = map_sectors["[z]"]
	if(!sector)
		return
	return attempt_hook_up_recursive(sector)

/obj/machinery/computer/ship/proc/attempt_hook_up_recursive(obj/effect/overmap/visitable/ship/sector)
	if(attempt_hook_up(sector))
		return sector
	for(var/obj/effect/overmap/visitable/ship/candidate in sector)
		if((. = .(candidate)))
			return

/obj/machinery/computer/ship/proc/display_reconnect_dialog(mob/user, flavor)
	reconnect_flavor = flavor
	if(type == /obj/machinery/computer/ship)
		tgui_interact(user)
		return
	var/datum/ship_reconnect/reconnect = get_reconnect_dialog()
	reconnect.flavor = flavor
	reconnect.tgui_interact(user)

/obj/machinery/computer/ship/proc/get_reconnect_dialog()
	if(!reconnect_dialog)
		reconnect_dialog = new(src)
	return reconnect_dialog

/obj/machinery/computer/ship/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ShipReconnect", "Connection Error")
		ui.open()

/obj/machinery/computer/ship/tgui_data(mob/user)
	var/list/data = list()
	data["flavor"] = reconnect_flavor
	return data

/obj/machinery/computer/ship/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if(action == "sync")
		sync_linked()
		SStgui.close_uis(src)
		return TRUE
	return FALSE

/datum/ship_reconnect
	var/obj/machinery/computer/ship/ship_ref
	var/flavor = "the vessel"

/datum/ship_reconnect/New(obj/machinery/computer/ship/ship)
	. = ..()
	ship_ref = ship

/datum/ship_reconnect/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ShipReconnect", "Connection Error")
		ui.open()

/datum/ship_reconnect/tgui_data(mob/user)
	var/list/data = list()
	data["flavor"] = flavor
	return data

/datum/ship_reconnect/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if(action == "sync")
		var/obj/machinery/computer/ship/ship = ship_ref
		if(!ship)
			return TRUE
		ship.sync_linked()
		SStgui.close_uis(src)
		if(ship.linked)
			ship.tgui_interact(usr)
		return TRUE
	return FALSE

/obj/machinery/computer/ship/interface_interact(mob/user)
	ui_interact(user)
	return TRUE

/obj/machinery/computer/ship/OnTopic(mob/user, list/href_list)
	if(..())
		return TOPIC_HANDLED
	if(href_list["sync"])
		sync_linked()
		return TOPIC_REFRESH
	if(href_list["close"])
		unlook(user)
		user.unset_machine()
		return TOPIC_HANDLED
	return TOPIC_NOACTION

// Management of mob view displacement. look to shift view to the ship on the overmap; unlook to shift back.

/obj/machinery/computer/ship/proc/look(mob/user)
	if(linked)
		user.reset_view(linked)
	if(user.client)
		var/default_view = getviewsize(config.default_view_square)
		user.client.change_view(max(default_view[1], default_view[2]) + extra_view)
	RegisterSignal(user, COMSIG_MOVED, TYPE_PROC_REF(/obj/machinery/computer/ship, unlook))
	RegisterSignal(user, COMSIG_SET_STAT, TYPE_PROC_REF(/obj/machinery/computer/ship, unlook))
	LAZYOR(viewers, weakref(user))

/obj/machinery/computer/ship/proc/unlook(mob/user)
	user.reset_view(null, FALSE)
	if(user.client)
		user.client.change_view(user.client.get_default_view())
	UnregisterSignal(user, COMSIG_MOVED)
	UnregisterSignal(user, COMSIG_SET_STAT)
	LAZYREMOVE(viewers, weakref(user))

/obj/machinery/computer/ship/proc/viewing_overmap(mob/user)
	return (weakref(user) in viewers)

/obj/machinery/computer/ship/CouldNotUseTopic(mob/user)
	. = ..()
	unlook(user)

/obj/machinery/computer/ship/CouldUseTopic(mob/user)
	. = ..()
	if(viewing_overmap(user))
		look(user)

/obj/machinery/computer/ship/check_eye(mob/user)
	if (!get_dist(user, src) > 1 || user.is_blind() || !linked )
		unlook(user)
		return -1
	else
		return 0

/obj/machinery/computer/ship/sensors/Destroy()
	sensors = null
	if(LAZYLEN(viewers))
		for(var/weakref/W in viewers)
			var/M = W.resolve()
			if(M)
				unlook(M)
	. = ..()

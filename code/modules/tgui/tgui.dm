/*!
 * Copyright (c) 2020 Aleksej Komarov
 * SPDX-License-Identifier: MIT
 */

/**
 * tgui datum (represents a UI).
 */
/datum/tgui
	/// The mob who opened/is using the UI.
	var/mob/user
	/// The object which owns the UI.
	var/datum/src_object
	/// The title of te UI.
	var/title
	/// The window_id for browse() and onclose().
	var/datum/tgui_window/window
	/// Key that is used for remembering the window geometry.
	var/window_key
	/// The interface (template) to be used for this UI.
	var/interface
	/// Update the UI every MC tick.
	var/autoupdate = TRUE
	/// If the UI has been initialized yet.
	var/initialized = FALSE
	/// Time of opening the window.
	var/opened_at
	/// Stops further updates when close() was called.
	var/closing = FALSE
	/// The status/visibility of the UI.
	var/status = UI_INTERACTIVE
	/// Timed refreshing state
	var/refreshing = FALSE
	/// Topic state used to determine status/interactability.
	var/datum/tgui_state/state = null
	/// Are byond mouse events beyond the window passed in to the ui
	var/mouse_hooked = FALSE
	/// Rate limit client refreshes to prevent DoS.
	COOLDOWN_DECLARE(refresh_cooldown)
	/// Rate limit partial updates (act bursts coalesce into one trailing
	/// update; see TGUI_SEND_UPDATE_COOLDOWN).
	COOLDOWN_DECLARE(send_cooldown)

/**
 * public
 *
 * Create a new UI.
 *
 * required user mob The mob who opened/is using the UI.
 * required src_object datum The object or datum which owns the UI.
 * required interface string The interface used to render the UI.
 * optional title string The title of the UI.
 * optional ui_x int Deprecated: Window width.
 * optional ui_y int Deprecated: Window height.
 * optional state datum/tgui_state The topic state to use, falls back to src_object.tgui_state().
 *
 * return datum/tgui The requested UI.
 */
/datum/tgui/New(mob/user, datum/src_object, interface, title, ui_x, ui_y, datum/tgui_state/state)
	log_tgui(user,
		"new [interface] fancy [user?.client?.get_preference_value(/datum/client_preference/fancy_tgui) == GLOB.PREF_YES]",
		src_object = src_object)
	src.user = user
	src.src_object = src_object
	src.window_key = "[REF(src_object)]-main"
	src.interface = interface
	if(title)
		src.title = title
	src.state = state || src_object.tgui_state(user)

/datum/tgui/Destroy()
	SStgui.on_close(src)
	if(window)
		if(window.locked_by == src)
			window.release_lock()
		if(window.subscriber_object == src)
			window.unsubscribe(src)
		window = null
	state = null
	user = null
	src_object = null
	return ..()

/**
 * public
 *
 * Open this UI (and initialize it with data).
 *
 * return bool - TRUE if a new pooled window is opened, FALSE in all other situations including if a new pooled window didn't open because one already exists.
 */
/datum/tgui/proc/open()
	if(!user || !user.client || !src_object)
		return FALSE
	if(window)
		return FALSE
	process_status()
	if(status < UI_UPDATE)
		return FALSE
	window = SStgui.request_pooled_window(user)
	if(!window)
		return FALSE
	opened_at = world.time
	window.acquire_lock(src)
	if(!window.is_ready() || window.needs_fresh_page)
		window.initialize(
			strict_mode = TRUE,
			fancy = user.client.get_preference_value(/datum/client_preference/fancy_tgui) == GLOB.PREF_YES,
			assets = list(
				get_asset_datum(/datum/asset/simple/tgui_v3),
			))
	else
		window.send_message("ping")
	// Each send_asset can outlive the window (suspend Topic racing the
	// asset loop) — bail cleanly instead of runtime on a nulled window.
	if(!window || !window.client || QDELETED(window.client))
		return FALSE
	var/flush_queue = window.send_asset(get_asset_datum(/datum/asset/simple/namespaced/fontawesome))
	flush_queue |= window.send_asset(get_asset_datum(/datum/asset/simple/namespaced/tgfont))
	for(var/datum/asset/asset in src_object.tgui_assets(user))
		flush_queue |= window.send_asset(asset)
	if (flush_queue)
		// browse_queue_flush blocks up to 50 ticks waiting for the client's
		// asset-verify page to confirm. During that window the user can
		// close the UI (or log out), qdel'ing this datum — its Destroy
		// nulls `window`. Re-validate before using it again.
		user.client.browse_queue_flush()
		if(!window || closing || !user.client)
			return FALSE
	window.send_message("update", get_payload(
		with_data = TRUE,
		with_static_data = TRUE))
	if(mouse_hooked)
		window.set_mouse_macro()
	SStgui.on_open(src)

	return TRUE

/**
 * public
 *
 * Close the UI.
 *
 * optional can_be_suspended bool
 */
/datum/tgui/proc/close(can_be_suspended = TRUE)
	if(closing)
		return
	closing = TRUE
	if(window)
		// Only tear the window down if this UI still owns it. A dead
		// src_object (killed program, qdel'd host) leaves a zombie UI that
		// closes up to a tick later — by then the pooled window may have
		// been reclaimed by another UI (e.g. the main menu re-opened into
		// it), and closing the window here would destroy THAT UI's page.
		if(window.locked_by == src)
			window.release_lock()
			window.close(can_be_suspended)
			if(src_object)
				src_object.tgui_close(user)
		SStgui.on_close(src)
	state = null
	qdel(src)

/**
 * public
 *
 * Enable/disable auto-updating of the UI.
 *
 * required value bool Enable/disable auto-updating.
 */
/datum/tgui/proc/set_autoupdate(autoupdate)
	src.autoupdate = autoupdate

/**
 * public
 *
 * Enable/disable passing through byond mouse events to the window
 *
 * required value bool Enable/disable hooking.
 */
/datum/tgui/proc/set_mouse_hook(value)
	src.mouse_hooked = value
	//Handle unhooking/hooking on already open windows ?


/**
 * public
 *
 * Replace current ui.state with a new one.
 *
 * required state datum/tgui_state/state Next state
 */
/datum/tgui/proc/set_state(datum/tgui_state/state)
	src.state = state

/**
 * public
 *
 * Makes an asset available to use in tgui.
 *
 * required asset datum/asset
 *
 * return bool - true if an asset was actually sent
 */
/datum/tgui/proc/send_asset(datum/asset/asset)
	if(!window)
		CRASH("send_asset() was called either without calling open() first or when open() did not return TRUE.")
	return window.send_asset(asset)

/**
 * public
 *
 * Send a full update to the client (includes static data).
 *
 * optional custom_data list Custom data to send instead of ui_data.
 * optional force bool Send an update even if UI is not interactive.
 */
/datum/tgui/proc/send_full_update(custom_data, force)
	if(!user.client || !initialized || closing)
		return
	if(!COOLDOWN_FINISHED(src, refresh_cooldown))
		refreshing = TRUE
		addtimer(CALLBACK(src, PROC_REF(send_full_update)), TGUI_REFRESH_FULL_UPDATE_COOLDOWN, TIMER_UNIQUE)
		return
	refreshing = FALSE
	var/should_update_data = force || status >= UI_UPDATE
	window.send_message("update", get_payload(
		custom_data,
		with_data = should_update_data,
		with_static_data = TRUE))
	COOLDOWN_START(src, refresh_cooldown, TGUI_REFRESH_FULL_UPDATE_COOLDOWN)

/**
 * public
 *
 * Send a partial update to the client (excludes static data).
 *
 * optional custom_data list Custom data to send instead of ui_data.
 * optional force bool Send an update even if UI is not interactive.
 */
/datum/tgui/proc/send_update(custom_data, force)
	if(!user.client)
		return
	if(!initialized || closing)
		return
	// Coalesce act bursts: while the cooldown is active, remember that a
	// fresher update is pending and schedule exactly one trailing send so
	// the UI always converges on the latest state. Without this, every
	// click in a burst triggers a full tgui_data rebuild + JSON encode +
	// round trip, which makes each click feel dead and invites re-clicks.
	if(!force && !COOLDOWN_FINISHED(src, send_cooldown))
		if(!refreshing)
			refreshing = TRUE
			addtimer(CALLBACK(src, PROC_REF(send_update)), TGUI_SEND_UPDATE_COOLDOWN, TIMER_UNIQUE)
		return
	refreshing = FALSE
	var/should_update_data = force || status >= UI_UPDATE
	window.send_message("update", get_payload(
		custom_data,
		with_data = should_update_data))
	COOLDOWN_START(src, send_cooldown, TGUI_SEND_UPDATE_COOLDOWN)

/**
 * private
 *
 * Package the data to send to the UI, as JSON.
 *
 * return list
 */
/datum/tgui/proc/get_payload(custom_data, with_data, with_static_data)
	if(!user || !user.client)
		return
	var/list/json_data = list()
	json_data["config"] = list(
		"title" = title,
		"status" = status,
		"interface" = interface,
		"refreshing" = refreshing,
		"window" = list(
			"key" = window_key,
			"fancy" = user.client ? (user.client.get_preference_value(/datum/client_preference/fancy_tgui) == GLOB.PREF_YES) : FALSE,
			"locked" = user.client ? (user.client.get_preference_value(/datum/client_preference/lock_tgui) == GLOB.PREF_YES) : FALSE,
		),
	)
	json_data["client"] = list(
		"ckey" = user.client.ckey,
		"address" = user.client.address,
		"computer_id" = user.client.computer_id,
	)
	json_data["user"] = list(
		"name" = "[user]",
		"observer" = isobserver(user),
	)
	var/data = custom_data || with_data && src_object.tgui_data(user)
	if(data)
		json_data["data"] = data
	var/static_data = with_static_data && src_object.tgui_static_data(user)
	if(static_data)
		json_data["static_data"] = static_data
	if(src_object.tgui_shared_states)
		json_data["shared"] = src_object.tgui_shared_states
	return json_data

/**
 * private
 *
 * Run an update cycle for this UI. Called internally by SStgui
 * every second or so.
 */
/datum/tgui/Process(delta_time, force = FALSE)
	if(closing)
		return
	// If the object or user died (or something else), abort.
	if(QDELETED(src_object) || QDELETED(user) || QDELETED(window))
		close(can_be_suspended = FALSE)
		return
	var/datum/host = src_object.tgui_host(user)
	if(QDELETED(host))
		close(can_be_suspended = FALSE)
		return
	// Validate ping
	// The zombie margin is doubled for windows on their first ready after
	// re-initialization: 516 Chromium starts throttled-ish right after a
	// suspended page was hidden, and 4s can expire before a live page
	// manages to send 'ready' (observed in tgui.log: CharacterSetup killed
	// as a zombie right after two logged acts).
	if(!initialized && world.time - opened_at > TGUI_PING_TIMEOUT * 2)
		log_tgui(user, "Error: Zombie window detected, closing.",
			window = window,
			src_object = src_object)
		close(can_be_suspended = FALSE)
		return
	// Update through a normal call to ui_interact
	if(status != UI_DISABLED && (autoupdate || force))
		src_object.tgui_interact(user, src)
		return
	// Update status only
	var/needs_update = process_status()
	if(status <= UI_CLOSE)
		close()
		return
	if(needs_update)
		window.send_message("update", get_payload())

/**
 * private
 *
 * Updates the status, and returns TRUE if status has changed.
 */
/datum/tgui/proc/process_status()
	var/prev_status = status
	status = src_object.tgui_status(user, state)
	return prev_status != status

/**
 * private
 *
 * Callback for handling incoming tgui messages.
 */
/datum/tgui/proc/on_message(type, list/payload, list/href_list)
	if(type && copytext(type, 1, 5) == "act/")
		var/act_type = copytext(type, 5)
		log_tgui(user, "Action: [act_type] [href_list["payload"]]",
			window = window,
			src_object = src_object)
		if(!src_object)
			return FALSE
		process_status()
		if(!user || !user.client)
			return FALSE
		var/act_result = src_object.tgui_act(act_type, payload, src, state)
		if(act_result)
			SStgui.update_uis(src_object)
		return FALSE
	switch(type)
		if("ready")
			// Send a full update when the user manually refreshes the UI
			if(initialized)
				send_full_update()
			initialized = TRUE
		if("ping/reply")
			initialized = TRUE
		if("suspend")
			close(can_be_suspended = TRUE)
		if("close")
			close(can_be_suspended = FALSE)
		if("log")
			if(href_list["fatal"])
				close(can_be_suspended = FALSE)
		if("setSharedState")
			if(status != UI_INTERACTIVE || !src_object)
				return
			LAZYINITLIST(src_object.tgui_shared_states)
			src_object.tgui_shared_states[href_list["key"]] = href_list["value"]
			SStgui.update_uis(src_object)

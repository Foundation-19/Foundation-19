/datum/scp_select_menu
	var/mob/observer/ghost/owner

/datum/scp_select_menu/New(mob/observer/ghost/G)
	if(!istype(G))
		qdel(src)
		return
	owner = G

/datum/scp_select_menu/Destroy()
	owner = null
	return ..()

/datum/scp_select_menu/tgui_interact(mob/user, datum/tgui/ui)
	if(user != owner)
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ScpSelectMenu", "Become an SCP")
		// List is built fresh on open / Refresh; no polling.
		ui.set_autoupdate(FALSE)
		ui.open()

// Personal ghost utility: interactive for every ghost.
/datum/scp_select_menu/tgui_state(mob/user)
	return GLOB.input_modal_tgui_state

/datum/scp_select_menu/tgui_static_data(mob/user)
	if(!owner)
		return list()
	var/list/data = list()
	data["categories"] = list()

	var/list/by_class = list()   // classification name -> entry list
	for(var/atom/PossibleSCP in GLOB.SCP_list)
		if(!owner.canBecomeSCP(PossibleSCP))
			continue
		var/datum/scp/PSCP = PossibleSCP.SCP
		var/class_key = "[PSCP.classification]"
		var/entry = list(
			"name" = "SCP-[PSCP.designation]",
			"ref" = "[REF(PossibleSCP)]",
			"icon" = owner ? costly_icon2html(PossibleSCP, owner) : null,
			"roleplay" = (PSCP.metaFlags & SCP_ROLEPLAY) ? TRUE : FALSE,
		)
		if(!by_class[class_key])
			by_class[class_key] = list()
		by_class[class_key] += list(entry)

	// Order categories: Keter, Euclid, Safe, then anything else.
	var/static/list/order = list(
		"[SCP_KETER]",
		"[SCP_EUCLID]",
		"[SCP_SAFE]",
	)
	var/list/class_names = list()
	for(var/key in by_class)
		class_names += key
	var/sorted = list()
	for(var/key in order)
		if(key in class_names)
			sorted += key
			class_names -= key
	for(var/key in class_names)
		sorted += key

	for(var/key in sorted)
		data["categories"] += list(list(
			"name" = key,
			"entries" = by_class[key],
		))

	data["available"] = length(GLOB.SCP_list) > 0
	return data

/datum/scp_select_menu/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	var/mob/user = ui?.user || usr
	if(!owner || user != owner)
		return
	switch(action)
		if("select")
			var/atom/selected = locate(params["atom"])
			if(!istype(selected) || !owner.canBecomeSCP(selected))
				to_chat(owner, SPAN_WARNING("SCP-[selected?.SCP?.designation || "?"] is no longer available!"))
				return
			// Hand off to the verb's existing confirm + possession flow.
			owner.confirm_scp_possession(selected)
			if(ui)
				ui.close()
			return TRUE
		if("refresh")
			if(ui)
				ui.close()
			tgui_interact(owner)
			return TRUE

/mob/observer/ghost
	var/datum/scp_select_menu/scp_select_menu_datum

/mob/observer/ghost/proc/scp_select_menu()
	if(!scp_select_menu_datum || QDELETED(scp_select_menu_datum))
		scp_select_menu_datum = new(src)
	scp_select_menu_datum.tgui_interact(src)

/mob/observer/ghost/Destroy()
	if(scp_select_menu_datum)
		qdel(scp_select_menu_datum)
		scp_select_menu_datum = null
	return ..()

// The possession-confirm tail of the old verb, callable from the menu.
/mob/observer/ghost/proc/confirm_scp_possession(atom/selected_scp)
	if(!istype(selected_scp) || !selected_scp.SCP)
		return
	var/roleplay_note = (selected_scp.SCP.metaFlags & SCP_ROLEPLAY) ? " Additionally, this is a roleplay oriented SCP. That means you are expected to behave like the SCP would in lore, and failing to do so would result in ban from playing roleplay SCPs." : ""
	var/agreement = tgui_alert(src, "Warning! SCPs are likely to spend a long amount of time within their containment chamber and are not guaranteed to be let out![roleplay_note]", "Are you sure?", list("Yes","No"))
	if(!LAZYLEN(agreement) || (agreement == "No"))
		return
	if(!canBecomeSCP(selected_scp))
		to_chat(src, SPAN_WARNING("SCP-[selected_scp.SCP.designation] is no longer available!"))
		return
	// Count as a round participant for population checks. Recorded
	// before do_possession because the ghost datum is consumed by the
	// ckey transfer (and several overrides don't return success).
	selected_scp.SCP.record_possession_join(src)
	selected_scp.do_possession(src)

// Ghost orbit menu — categorized target picker replacing the old flat
// tgui_input_list on the orbit HUD button. Categories: Crew, Antagonists,
// SCPs, Simple Mobs, Silicons, Ghosts. Static data is rebuilt on open /
// explicit refresh; dynamic "following" highlight arrives via tgui_data.

/datum/orbit_menu
	var/mob/observer/ghost/owner

/datum/orbit_menu/New(mob/observer/ghost/G)
	if(!istype(G))
		qdel(src)
		return
	owner = G

/datum/orbit_menu/Destroy()
	owner = null
	return ..()

/datum/orbit_menu/tgui_interact(mob/user, datum/tgui/ui)
	if(user != owner)
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "OrbitMenu", "Orbit")
		// Target list is rebuilt on open or Refresh; following-status
		// changes are pushed via tgui_data instead of polling.
		ui.set_autoupdate(FALSE)
		ui.open()

// Personal ghost utility: interactive for every ghost, not just admins.
/datum/orbit_menu/tgui_state(mob/user)
	return GLOB.input_modal_tgui_state

/datum/orbit_menu/tgui_data(mob/user)
	return list(
		"following" = owner?.following ? "[REF(owner.following)]" : null,
	)

/datum/orbit_menu/tgui_static_data(mob/user)
	if(!owner)
		return list()
	var/list/data = list()
	data["categories"] = list()

	// --- Crew: living humans with clients ---
	var/list/crew = list()
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(H.stat == DEAD)
			continue
		crew += list(build_entry(H, H.real_name ? H.real_name : H.name, H.job))
	add_category(data, "Crew", crew)

	// --- Antagonists: minds registered in the antag system ---
	var/list/antags = list()
	var/list/seen = list()
	for(var/antag_type in GLOB.all_antag_types_)
		var/datum/antagonist/antag = GLOB.all_antag_types_[antag_type]
		if(!antag)
			continue
		var/list/minds = antag.current_antagonists | antag.pending_antagonists
		for(var/datum/mind/M in minds)
			var/mob/body = M.current
			if(!body || seen["[REF(body)]"])
				continue
			seen["[REF(body)]"] = TRUE
			antags += list(build_entry(body, body.name, antag.faction ? antag.faction : antag.id))
	add_category(data, "Antagonists", antags)

	// --- SCPs: anything in the SCP registry, client or not ---
	var/list/scps = list()
	for(var/atom/A in GLOB.SCP_list)
		if(!ismob(A) || !A.SCP)
			continue
		var/mob/M = A
		if(M.stat == DEAD)
			continue
		scps += list(build_entry(M, "[A.SCP.designation ? "SCP-[A.SCP.designation]" : A.SCP.name]", A.SCP.classification ? "[A.SCP.classification]" : null))
	add_category(data, "SCP", scps)

	// --- Simple mobs: other living cliented mobs ---
	var/list/simple = list()
	for(var/mob/living/L in GLOB.player_list)
		if(istype(L, /mob/living/carbon/human) || istype(L, /mob/living/silicon))
			continue
		if(L.SCP)
			continue
		if(L.stat == DEAD)
			continue
		simple += list(build_entry(L, L.name, null))
	add_category(data, "Simple Mobs", simple)

	// --- Silicons ---
	var/list/silicons = list()
	for(var/mob/living/silicon/S in GLOB.player_list)
		if(S.stat == DEAD)
			continue
		silicons += list(build_entry(S, S.name, null))
	add_category(data, "Silicons", silicons)

	// --- Ghosts ---
	var/list/ghosts = list()
	for(var/mob/observer/ghost/G in GLOB.ghost_mob_list)
		if(!G.client || G == owner)
			continue
		ghosts += list(build_entry(G, G.name, null))
	add_category(data, "Ghosts", ghosts)

	return data

/datum/orbit_menu/proc/build_entry(mob/target, display_name, status)
	var/icon_html = null
	if(owner)
		// Humans wear their clothes as overlays; plain icon2html would show
		// the bare body sprite. getFlatIcon composites the full appearance.
		icon_html = costly_icon2html(target, owner)
	return list(
		"name" = display_name || target.name,
		"ref" = "[REF(target)]",
		"icon" = icon_html,
		"status" = status || null,
	)

/datum/orbit_menu/proc/add_category(list/data, name, entries)
	if(length(entries))
		data["categories"] += list(list(
			"name" = name,
			"entries" = entries,
		))

/datum/orbit_menu/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	var/mob/user = ui?.user || usr
	if(!owner || user != owner)
		return
	switch(action)
		if("orbit")
			var/mob/target = locate(params["atom"])
			if(!istype(target) || target == owner)
				return
			// Ghosts can't enter holy turf; keep_following refuses it anyway.
			owner.start_following(target)
			SStgui.update_uis(src)
			return TRUE
		if("stop")
			owner.stop_following()
			SStgui.update_uis(src)
			return TRUE
		if("refresh")
			// Static data is cached per UI; a fresh open rebuilds it.
			if(ui)
				ui.close()
			tgui_interact(owner)
			return TRUE

/mob/observer/ghost
	var/datum/orbit_menu/orbit_menu_datum

/mob/observer/ghost/proc/orbit_menu()
	if(!orbit_menu_datum || QDELETED(orbit_menu_datum))
		orbit_menu_datum = new(src)
	orbit_menu_datum.tgui_interact(src)

/mob/observer/ghost/Destroy()
	if(orbit_menu_datum)
		qdel(orbit_menu_datum)
		orbit_menu_datum = null
	return ..()

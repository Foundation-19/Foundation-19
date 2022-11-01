/client/proc/BCCM_WhitelistPanel()
	set category = "Server"
	set name = "BCCM WL Panel"

	if(!SSdbcore.Connect())
		to_chat(usr, SPAN_WARNING("Failed to establish database connection"))
		return

	if(!check_rights(R_BAN))
		return

	new /datum/bccm_wl_panel(src)

/datum/bccm_wl_panel
	var/client/holder // client of who is holding this

/datum/bccm_wl_panel/New(user)
	if(user)
		setup(user)
	else
		qdel(src)
		return

/datum/bccm_wl_panel/proc/setup(user) // client or mob
	if(!SSdbcore.Connect())
		to_chat(holder, SPAN_WARNING("Failed to establish database connection"))
		qdel(src)
		return

	if(istype(user, /client))
		var/client/user_client = user
		holder = user_client
	else
		var/mob/user_mob = user
		holder = user_mob.client

	if(!check_rights(R_BAN, TRUE, holder))
		qdel(src)
		return

	tgui_interact(holder.mob)

/datum/bccm_wl_panel/tgui_state(mob/user)
	return GLOB.admin_tgui_state // admin only

/datum/bccm_wl_panel/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "BCCMWhitelistPanel")
		ui.open()

/datum/bccm_wl_panel/tgui_data(mob/user, ui_key)
	. = SSbccm.tgui_panel_wl_data

/datum/bccm_wl_panel/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return
	switch(action)
		if("wl_remove_entry")
			if(!params["ckey"])
				return TRUE
			if(SSbccm.RemoveFromWhitelist(params["ckey"], holder))
				SStgui.update_uis(src)
			else
				return TRUE
		if("wl_add_ckey")
			if(!params["ckey"])
				return TRUE
			if(SSbccm.AddToWhitelist(params["ckey"], holder))
				SStgui.update_uis(src)
			else
				return TRUE

	if(!length(SSbccm.tgui_panel_wl_data))
		qdel(src) //Same as ASN. ~Tsuru
		return

	SStgui.update_user_uis(holder.mob)
	return TRUE

/datum/bccm_wl_panel/tgui_close(mob/user)
	qdel(src)

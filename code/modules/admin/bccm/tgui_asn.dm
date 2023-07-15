/client/proc/BCCM_ASNPanel()
	set category = "Server"
	set name = "BCCM ASN Panel"

	if(!SSdbcore.Connect())
		to_chat(usr, SPAN_WARNING("Failed to establish database connection"))
		return

	if(!check_rights(R_SERVER))
		return

	new /datum/bccm_asn_panel(src)

/datum/bccm_asn_panel
	var/client/holder // client of who is holding this

/datum/bccm_asn_panel/New(user)
	if(user)
		setup(user)
	else
		qdel(src)
		return

/datum/bccm_asn_panel/proc/setup(user) // client or mob
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

	if(!check_rights(R_SERVER, TRUE, holder))
		qdel(src)
		return

	tgui_interact(holder.mob)

/datum/bccm_asn_panel/tgui_state(mob/user)
	return GLOB.admin_tgui_state // admin only

/datum/bccm_asn_panel/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "BCCMASNPanel")
		ui.open()

/datum/bccm_asn_panel/tgui_data(mob/user, ui_key)
	. = SSbccm.tgui_panel_asn_data

/datum/bccm_asn_panel/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return
	switch(action)
		if("asn_remove_entry")
			if(!params["asn"])
				return TRUE
			if(SSbccm.RemoveASNban(params["asn"], holder))
				SStgui.update_uis(src)
			else
				return TRUE
		if("asn_add_entry")
			if(!params["ip"])
				return TRUE
			if(SSbccm.AddASNban(params["ip"], holder))
				SStgui.update_uis(src)
			else
				return TRUE

	if(!length(SSbccm.tgui_panel_asn_data))
		qdel(src) //For some unknown reason it refuses to update UI when it goes from 1 to 0 entries, so last item gets stuck. I can't fix it now, maybe later. ~Tsuru
		return

	SStgui.update_user_uis(holder.mob)
	return TRUE

/datum/bccm_asn_panel/tgui_close(mob/user)
	qdel(src)

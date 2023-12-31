/datum/admin_secret_item/admin_secret/offsite_panel
	name = "Offsite Panel"

/datum/admin_secret_item/admin_secret/offsite_panel/can_execute(mob/user)
	return (isnull(SSoffsites) || !length(SSoffsites.offsites)) ? FALSE : ..()

/datum/admin_secret_item/admin_secret/offsite_panel/execute(mob/user)
	. = ..()
	if(!.)
		return

	SSoffsites.tgui_interact(user)

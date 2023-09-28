/*
* This subsystem populates and manages offsite singletons.
*/

SUBSYSTEM_DEF(offsite)
	name = "Offsites"
	flags = SS_NO_FIRE
	/// Associative list. Key is the offsite type, value is the offsite ref
	var/list/offsites = list()

/datum/controller/subsystem/offsite/Initialize(timeofday)
	initialize_offsites()
	return ..()

///Ran on initialize, populates the addiction dictionary
/datum/controller/subsystem/offsite/proc/initialize_offsites()
	for(var/type in subtypesof(/datum/offsite))
		if(is_abstract(type))
			continue

		var/datum/offsite/ref = new type
		offsites[type] = ref

/datum/controller/subsystem/offsite/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "OffsitePanel", "Offsites")
		ui.open()

/datum/controller/subsystem/offsite/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return

	switch(action)

/datum/controller/subsystem/offsite/tgui_state(mob/user)
	return GLOB.admin_tgui_state

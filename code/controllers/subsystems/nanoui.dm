SUBSYSTEM_DEF(nanoui)
	name = "nanoUI"
	priority = SS_PRIORITY_NANOUI
	init_order = SS_INIT_NANOUI
	flags = SS_NO_INIT|SS_BACKGROUND
	wait = 2 SECONDS
	var/list/processing_uis = list()

/datum/controller/subsystem/nanoui/fire()
	for(var/last_object in processing_uis)
		var/datum/nanoui/NUI = last_object
		if(istype(NUI) && !QDELETED(NUI))
			try
				NUI.process()
			catch(var/exception/e)
				world.Error(e)
		else
			processing_uis -= NUI

/datum/controller/subsystem/nanoui/stat_entry()
	..("[processing_uis.len] UIs")
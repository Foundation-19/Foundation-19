/datum/extension/appearance
	base_type = /datum/extension/appearance
	expected_type = /atom
	flags = EXTENSION_FLAG_IMMEDIATE // | EXTENSION_FLAG_MULTIPLE_INSTANCES
	var/appearance_handler_type
	var/item_equipment_proc
	var/item_removal_proc

/datum/extension/appearance/New(holder)
	var/datum/appearance_handler = appearance_manager.get_appearance_handler(appearance_handler_type)
	if(!appearance_handler)
		CRASH("Unable to acquire the [appearance_handler_type] appearance handler.")

	appearance_handler.RegisterSignal(holder, COMSIG_ITEM_EQUIPPED, item_equipment_proc)
	appearance_handler.RegisterSignal(holder, COMSIG_DROPPED_ITEM, item_removal_proc)
	..()

/datum/extension/appearance/Destroy()
	var/datum/appearance_handler = appearance_manager.get_appearance_handler(appearance_handler_type)
	appearance_handler.UnregisterSignal(holder, COMSIG_ITEM_EQUIPPED)
	appearance_handler.UnregisterSignal(holder, COMSIG_DROPPED_ITEM)
	. = ..()

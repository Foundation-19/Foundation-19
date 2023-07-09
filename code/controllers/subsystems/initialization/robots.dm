SUBSYSTEM_DEF(robots)
	name = "Robots"
	init_order = SS_INIT_MISC
	flags = SS_NO_FIRE

	var/list/modules_by_category         = list()
	var/list/crisis_modules_by_category  = list()
	var/list/upgrade_modules_by_category = list()
	var/list/all_module_names            = list()
	var/list/robot_alt_titles            = list()

/datum/controller/subsystem/robots/Initialize()
	. = ..()

	// This is done via loop instead of just assignment in order to trim associations.
	sortTim(robot_alt_titles, /proc/cmp_text_asc)

	for(var/module_type in subtypesof(/obj/item/robot_module))
		var/obj/item/robot_module/module = module_type
		var/module_category = initial(module.module_category)
		var/module_name = initial(module.display_name)
		if(module_name && module_category)
			if(initial(module.upgrade_locked))
				LAZYINITLIST(upgrade_modules_by_category[module_category])
				LAZYSET(upgrade_modules_by_category[module_category], module_name, module)
			else if(initial(module.crisis_locked))
				LAZYINITLIST(crisis_modules_by_category[module_category])
				LAZYSET(crisis_modules_by_category[module_category], module_name, module)
			else
				LAZYINITLIST(modules_by_category[module_category])
				LAZYSET(modules_by_category[module_category], module_name, module)
			all_module_names |= module_name
	all_module_names = sortTim(all_module_names, /proc/cmp_text_asc)

/datum/controller/subsystem/robots/proc/get_available_modules(module_category, crisis_mode, include_override)
	. = list()
	if(modules_by_category[module_category])
		. += modules_by_category[module_category]
	if(crisis_mode && crisis_modules_by_category[module_category])
		. |= crisis_modules_by_category[module_category]
	if(include_override && upgrade_modules_by_category[module_category])
		var/list/modules = upgrade_modules_by_category[module_category]
		if(modules[include_override])
			.[include_override] = modules[include_override]

/datum/controller/subsystem/robots/proc/get_mmi_type_by_title(check_title) //this is a lazy ass fix but i dont know how else to do this without breaking everything
	. = /obj/item/device/mmi

/datum/controller/subsystem/robots/proc/get_mob_type_by_title(check_title)
	. = /mob/living/silicon/robot

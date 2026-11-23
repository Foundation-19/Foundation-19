/obj/item/airlock_electronics
	name = "airlock electronics"
	icon = 'icons/obj/doors/door_assembly.dmi'
	icon_state = "door_electronics"
	w_class = ITEM_SIZE_SMALL //It should be tiny! -Agouri

	matter = list(MATERIAL_STEEL = 50,MATERIAL_GLASS = 50)

	req_access = list(ACCESS_ENGINEERING_LVL2)

	var/secure = 0 //if set, then wires will be randomized and bolts will drop if the door is broken
	var/list/conf_access = list()
	var/one_access = 0 //if set to 1, door would receive OR instead of AND on the access restrictions.
	var/last_configurator = null
	var/locked = 1
	var/lockable = 1
	var/autoset = TRUE // Whether the door should inherit access from surrounding areas

/obj/item/airlock_electronics/attack_self(mob/user)
	if(ishuman(user) || issilicon(user))
		tgui_interact(user)
		return
	return ..(user)

/obj/item/airlock_electronics/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AirlockElectronics", name)
		ui.open()

/obj/item/airlock_electronics/tgui_data(mob/user)
	var/list/data = list()
	var/list/regions = list()

	for(var/i in ACCESS_REGION_MIN to ACCESS_REGION_MAX)
		var/list/region = list()
		var/list/accesses = list()
		for(var/j in get_region_accesses(i))
			var/list/access = list()
			access["name"] = get_access_desc(j)
			access["id"] = j
			access["req"] = (j in conf_access)
			accesses += list(access)
		region["name"] = get_region_accesses_name(i)
		region["accesses"] = accesses
		regions += list(region)
	data["regions"] = regions
	data["oneAccess"] = one_access
	data["locked"] = locked
	data["lockable"] = lockable
	data["autoset"] = autoset
	return data

/obj/item/airlock_electronics/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE

	if(lockable)
		if(action == "unlock")
			if(!req_access || istype(usr, /mob/living/silicon))
				locked = FALSE
				last_configurator = usr.name
			else
				var/obj/item/card/id/I = usr.get_active_hand()
				I = I ? I.GetIdCard() : null
				if(!istype(I, /obj/item/card/id))
					to_chat(usr, SPAN_WARNING("[src] flashes a yellow LED near the ID scanner. Did you remember to scan your ID or PDA?"))
					return TRUE
				if(check_access(I))
					locked = FALSE
					last_configurator = I.registered_name
				else
					to_chat(usr, SPAN_WARNING("[src] flashes a red LED near the ID scanner, indicating your access has been denied."))
					return TRUE
			return TRUE
		if(action == "lock")
			locked = TRUE
			return TRUE

	switch(action)
		if("clear")
			conf_access = list()
			one_access = FALSE
			return TRUE
		if("one_access")
			one_access = !one_access
			return TRUE
		if("autoset")
			autoset = !autoset
			return TRUE
		if("access")
			var/access = params["access"]
			if(!(access in conf_access))
				conf_access += access
			else
				conf_access -= access
			return TRUE


/obj/item/airlock_electronics/secure
	name = "secure airlock electronics"
	desc = "designed to be somewhat more resistant to hacking than standard electronics."
	origin_tech = list(TECH_DATA = 2)
	secure = TRUE

/obj/item/airlock_electronics/brace
	name = "airlock brace access circuit"
	req_access = list()
	locked = FALSE
	lockable = FALSE

/obj/item/airlock_electronics/brace/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AirlockElectronics", name)
		ui.open()

/obj/item/airlock_electronics/proc/set_access(obj/object)
	if(!object.req_access)
		object.check_access()
	if(object.req_access.len)
		conf_access = list()
		for(var/entry in object.req_access)
			conf_access |= entry // This flattens the list, turning everything into AND
			// Can be reworked to have the electronics inherit a precise access set, but requires UI changes.

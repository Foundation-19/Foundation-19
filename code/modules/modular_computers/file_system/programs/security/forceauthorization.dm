/datum/computer_file/program/forceauthorization
	filename = "forceauthorization"
	filedesc = "Use of Force Authorization Manager"
	extended_desc = "Control console used to activate the NT1019 authorization chip."
	size = 4
	usage_flags = PROGRAM_CONSOLE | PROGRAM_LAPTOP
	program_icon_state = "security"
	program_menu_icon = "lock"
	requires_ntnet = TRUE
	available_on_ntnet = TRUE
	required_access = ACCESS_SECURITY_LVL4
	nanomodule_path = /datum/nano_module/forceauthorization

/datum/nano_module/forceauthorization/
	name = "Use of Force Authorization Manager"

/datum/nano_module/forceauthorization/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "ForceAuthorization", name)
		ui.open()

/datum/nano_module/forceauthorization/tgui_data(mob/user)
	var/list/data = host.initial_data()

	data["registered_guns"] = list()
	data["unregistered_guns"] = list()
	var/atom/movable/AM = nano_host()
	if(!istype(AM))
		return data
	var/list/zlevels = GetConnectedZlevels(AM.z)
	for(var/obj/item/gun/G in GLOB.secure_weapons)
		var/out_of_range = FALSE
		var/area_name = "OUT OF RANGE"
		var/turf/T = get_turf(G)
		if(!T || !(T.z in zlevels))
			out_of_range = TRUE
		else
			var/area/A = get_area(T)
			area_name = sanitize(A.name)

		var/list/modes = list()
		for(var/i = 1 to G.firemodes.len)
			if(G.authorized_modes[i] == ALWAYS_AUTHORIZED)
				continue
			var/datum/firemode/firemode = G.firemodes[i]
			modes += list(list("index" = i, "mode_name" = firemode.name, "authorized" = G.authorized_modes[i]))

		if(!isnull(G.registered_owner))
			data["registered_guns"] += list(list("name" = "[G]", "ref" = "\ref[G]", "owner" = G.registered_owner, "modes" = modes, "area" = area_name, "out_of_range" = out_of_range))
		else
			data["unregistered_guns"] += list(list("name" = "[G]", "ref" = "\ref[G]", "modes" = modes, "area" = area_name, "out_of_range" = out_of_range))

	return data

/datum/nano_module/forceauthorization/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE

	if(action == "authorize" && params["gun"] && params["mode"])
		var/obj/item/gun/G = locate(params["gun"]) in GLOB.secure_weapons
		var/do_authorize = text2num(params["authorize"])
		var/mode = text2num(params["mode"])
		return isnum(do_authorize) && isnum(mode) && G?.authorize(mode, do_authorize)

	return FALSE

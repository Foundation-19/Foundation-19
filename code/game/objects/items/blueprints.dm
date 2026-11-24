/obj/item/blueprints
	name = "blueprints"
	desc = "Blueprints..."
	icon = 'icons/obj/items.dmi'
	icon_state = "blueprints"
	attack_verb = list("attacked", "bapped", "hit")
	var/const/AREA_ERRNONE = 0
	var/const/AREA_STATION = 1
	var/const/AREA_SPACE =   2
	var/const/AREA_SPECIAL = 3

	var/const/BORDER_ERROR = 0
	var/const/BORDER_NONE = 1
	var/const/BORDER_BETWEEN =   2
	var/const/BORDER_2NDTILE = 3
	var/const/BORDER_SPACE = 4

	var/const/ROOM_ERR_LOLWAT = 0
	var/const/ROOM_ERR_SPACE = -1
	var/const/ROOM_ERR_TOOLARGE = -2

/obj/item/blueprints/Initialize()
	. = ..()
	desc = "Blueprints of \the [station_name()]. There is a \"Classified\" stamp and several coffee stains on it."

/obj/item/blueprints/attack_self(mob/M as mob)
	if (!istype(M,/mob/living/carbon/human) || !check_rights(R_ADMIN, FALSE, C = M.client))
		to_chat(M, "This stack of blue paper means nothing to you.")//monkeys cannot into projecting

		return
	tgui_interact(M)

/obj/item/blueprints/DefaultTopicState()
	return GLOB.physical_state

/obj/item/blueprints/tgui_state(mob/user)
	return GLOB.physical_tgui_state

/obj/item/blueprints/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Blueprints", name)
		ui.open()

/obj/item/blueprints/tgui_data(mob/user)
	var/area/A = get_area(src)
	var/area_type = get_area_type(A)
	var/list/data = list()
	data["station_name"] = station_name()
	data["company_name"] = GLOB.using_map.company_name
	data["outpost"] = istype(src, /obj/item/blueprints/outpost) ? TRUE : FALSE
	data["is_space"] = (area_type == AREA_SPACE) ? TRUE : FALSE
	data["is_station"] = (area_type == AREA_STATION) ? TRUE : FALSE
	data["area_name"] = A ? A.name : ""
	data["has_apc"] = (A && A.apc) ? TRUE : FALSE
	return data

/obj/item/blueprints/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	switch(action)
		if ("create_area")
			if (get_area_type()!=AREA_SPACE)
				return TRUE
			create_area()
			return TRUE
		if ("edit_area")
			if (get_area_type()!=AREA_STATION)
				return TRUE
			edit_area()
			return TRUE
		if ("delete_area")
			//skip the sanity checking, delete_area() does it anyway
			delete_area()
			return TRUE
	return FALSE

/obj/item/blueprints/proc/get_header()
	return "<h2>[station_name()] blueprints</h2><small>Property of [GLOB.using_map.company_name]. For heads of staff only. Store in high-secure storage.</small><hr>"

/obj/item/blueprints/proc/get_area_type(area/A = get_area(src))
	if(istype(A, /area/space))
		return AREA_SPACE

	if(A.z in GLOB.using_map.station_levels)
		return AREA_STATION

	return AREA_SPECIAL

/obj/item/blueprints/proc/create_area()
//	log_debug("create_area")

	var/res = detect_room(get_turf(usr))
	if(!istype(res,/list))
		switch(res)
			if(ROOM_ERR_SPACE)
				to_chat(usr, SPAN_WARNING("The new area must be completely airtight!"))
				return
			if(ROOM_ERR_TOOLARGE)
				to_chat(usr, SPAN_WARNING("The new area too large!"))
				return
			else
				to_chat(usr, SPAN_WARNING("Error! Please notify administration!"))
				return
	var/list/turf/turfs = res
	var/str = sanitizeSafe(input("New area name:","Blueprint Editing", ""), MAX_NAME_LEN)
	if(!str || !length(str)) //cancel
		return
	if(length(str) > 50)
		to_chat(usr, SPAN_WARNING("Name too long."))
		return
	var/area/A = new
	A.SetName(str)
	A.power_equip = 0
	A.power_light = 0
	A.power_environ = 0
	A.always_unpowered = 0
	for(var/T in turfs)
		ChangeArea(T, A)
	A.always_unpowered = 0
	SStgui.update_uis(src)

/obj/item/blueprints/proc/edit_area()
	var/area/A = get_area(src)

	var/prevname = A.name
	var/str = sanitizeSafe(input("New area name:","Blueprint Editing", prevname), MAX_NAME_LEN)
	if(!str || !length(str) || str==prevname) //cancel
		return
	if(length(str) > 50)
		to_chat(usr, SPAN_WARNING("Text too long."))
		return
	set_area_machinery_title(A,str,prevname)
	A.SetName(str)
	to_chat(usr, SPAN_NOTICE("You set the area '[prevname]' title to '[str]'."))
	SStgui.update_uis(src)

/obj/item/blueprints/proc/delete_area()
	var/area/A = get_area(src)
	if (get_area_type(A)!=AREA_STATION || A.apc) //let's just check this one last time, just in case
		SStgui.update_uis(src)
		return
	to_chat(usr, SPAN_NOTICE("You scrub [A.name] off the blueprint."))
	log_and_message_staff("deleted area [A.name] via station blueprints.")
	qdel(A)
	SStgui.update_uis(src)

/obj/item/blueprints/proc/set_area_machinery_title(area/A,title,oldtitle)
	if (!oldtitle) // or replacetext goes to infinite loop
		return

	for(var/obj/machinery/alarm/M in A)
		M.SetName(replacetext(M.name,oldtitle,title))
	for(var/obj/machinery/power/apc/M in A)
		M.SetName(replacetext(M.name,oldtitle,title))
	for(var/obj/machinery/atmospherics/unary/vent_scrubber/M in A)
		M.SetName(replacetext(M.name,oldtitle,title))
	for(var/obj/machinery/atmospherics/unary/vent_pump/M in A)
		M.SetName(replacetext(M.name,oldtitle,title))
	for(var/obj/machinery/door/M in A)
		M.SetName(replacetext(M.name,oldtitle,title))
	//TODO: much much more. Unnamed airlocks, cameras, etc.

/obj/item/blueprints/proc/check_tile_is_border(turf/T2,dir)
	if (isspaceturf(T2))
		return BORDER_SPACE //omg hull breach we all going to die here
	if (istype(T2, /turf/simulated/shuttle))
		return BORDER_SPACE
	if (get_area_type(T2.loc)!=AREA_SPACE)
		return BORDER_BETWEEN
	if (istype(T2, /turf/simulated/wall))
		return BORDER_2NDTILE
	if (!istype(T2, /turf/simulated))
		return BORDER_BETWEEN

	for (var/obj/structure/window/W in T2)
		if(turn(dir,180) == W.dir)
			return BORDER_BETWEEN
		if (W.dir in list(NORTHEAST,SOUTHEAST,NORTHWEST,SOUTHWEST))
			return BORDER_2NDTILE
	for(var/obj/machinery/door/window/D in T2)
		if(turn(dir,180) == D.dir)
			return BORDER_BETWEEN
	if (locate(/obj/machinery/door) in T2)
		return BORDER_2NDTILE

	return BORDER_NONE

/obj/item/blueprints/proc/detect_room(turf/first)
	var/list/turf/found = new
	var/list/turf/pending = list(first)
	while(pending.len)
		if (found.len+pending.len > 300)
			return ROOM_ERR_TOOLARGE
		var/turf/T = pending[1] //why byond havent list::pop()?
		pending -= T
		for (var/dir in GLOB.cardinal)
			var/skip = 0
			for (var/obj/structure/window/W in T)
				if(dir == W.dir || (W.dir in list(NORTHEAST,SOUTHEAST,NORTHWEST,SOUTHWEST)))
					skip = 1; break
			if (skip) continue
			for(var/obj/machinery/door/window/D in T)
				if(dir == D.dir)
					skip = 1; break
			if (skip) continue

			var/turf/NT = get_step(T,dir)
			if (!isturf(NT) || (NT in found) || (NT in pending))
				continue

			switch(check_tile_is_border(NT,dir))
				if(BORDER_NONE)
					pending+=NT
				if(BORDER_BETWEEN)
					//do nothing, may be later i'll add 'rejected' list as optimization
				if(BORDER_2NDTILE)
					found+=NT //tile included to new area, but we dont seek more
				if(BORDER_SPACE)
					return ROOM_ERR_SPACE
		found+=T
	return found

//For use on exoplanets
/obj/item/blueprints/outpost
	name = "outpost blueprints"
	icon_state = "blueprints2"

/obj/item/blueprints/outpost/Initialize()
	. = ..()
	desc = "Blueprints for the daring souls wanting to establish a planetary outpost. Has some sketchy looking stains and what appears to be bite holes."

/obj/item/blueprints/outpost/get_header()
	return "<h2>Exoplanetary outpost blueprints</h2><small>Property of [GLOB.using_map.company_name].</small><hr>"

/obj/item/blueprints/outpost/check_tile_is_border(turf/T2,dir)
	if (istype(T2, /turf/simulated/floor/exoplanet/))
		return BORDER_SPACE
	. = ..()

/obj/item/blueprints/outpost/get_area_type(area/A = get_area(src))
	if(istype(A, /area/exoplanet))
		return AREA_SPACE
	var/obj/effect/overmap/visitable/sector/exoplanet/E = map_sectors["[z]"]
	if(istype(E))
		return AREA_STATION
	return AREA_SPECIAL

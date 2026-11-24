/obj/item/device/gps
	name = "relay positioning device"
	desc = "Triangulates the approximate co-ordinates using a nearby satellite network."
	icon = 'icons/obj/device.dmi'
	icon_state = "locator"
	item_state = "locator"
	origin_tech = list(TECH_MATERIAL = 2, TECH_DATA = 2, TECH_BLUESPACE = 1)
	matter = list(MATERIAL_ALUMINIUM = 250, MATERIAL_STEEL = 250, MATERIAL_GLASS = 50)
	w_class = ITEM_SIZE_SMALL

/obj/item/device/gps/attack_self(mob/user as mob)
	to_chat(user, SPAN_NOTICE("[icon2html(src, user)] \The [src] flashes <i>[get_coordinates()]</i>."))

/obj/item/device/gps/examine(mob/user)
	. = ..()
	to_chat(user, SPAN_NOTICE("\The [src]'s screen shows: <i>[get_coordinates()]</i>."))

/obj/item/device/gps/proc/get_coordinates()
	var/turf/T = get_turf(src)
	return T ? "[T.x]:[T.y]:[T.z]" : "N/A"

/mob/living/carbon/human/get_status_tab_items()
	.=..()
	var/obj/item/device/gps/L = locate() in src
	if(L)
		. += "Coordinates: [L.get_coordinates()]"

/mob/living/silicon/robot/get_status_tab_items()
	.=..()
	if(istype(module_state_1, /obj/item/device/gps) || istype(module_state_2, /obj/item/device/gps) || istype(module_state_3, /obj/item/device/gps))
		var/obj/item/device/gps/L = locate() in src
		if(L)
			. += "Coordinates: [L.get_coordinates()]"

/obj/item/device/measuring_tape
	name = "measuring tape"
	desc = "A coiled metallic tape used to check dimensions and lengths."
	icon = 'icons/obj/xenoarchaeology.dmi'
	icon_state = "measuring"
	origin_tech = list(TECH_MATERIAL = 1)
	matter = list(MATERIAL_STEEL = 100)
	w_class = ITEM_SIZE_SMALL

/obj/item/storage/bag/fossils
	name = "fossil satchel"
	desc = "Transports delicate fossils in suspension so they don't break during transit."
	icon = 'icons/obj/mining.dmi'
	icon_state = "satchel"
	slot_flags = SLOT_BELT | SLOT_POCKET
	w_class = ITEM_SIZE_NORMAL
	storage_slots = 50
	max_storage_space = 200
	max_w_class = ITEM_SIZE_NORMAL
	can_hold = list(/obj/item/fossil)

/obj/item/storage/box/samplebags
	name = "sample bag box"
	desc = "A box claiming to contain sample bags."

/obj/item/storage/box/samplebags/New()
	..()
	for(var/i = 1 to 7)
		var/obj/item/evidencebag/S = new(src)
		S.SetName("sample bag")
		S.desc = "a bag for holding research samples."

/obj/item/device/ano_scanner
	name = "\improper Alden-Saraspova counter"
	desc = "A device which aids in triangulation of exotic particles."
	icon = 'icons/obj/xenoarchaeology.dmi'
	icon_state = "flashgun"
	item_state = "lampgreen"
	origin_tech = list(TECH_BLUESPACE = 3, TECH_MAGNET = 3)
	matter = list(MATERIAL_STEEL = 5000, MATERIAL_ALUMINIUM = 5000, MATERIAL_GLASS = 5000)
	w_class = ITEM_SIZE_SMALL
	slot_flags = SLOT_BELT

	var/last_scan_time = 0
	var/scan_delay = 25

/obj/item/device/ano_scanner/attack_self(mob/living/user)
	interact(user)

/obj/item/device/ano_scanner/interact(mob/living/user)
	if(world.time - last_scan_time >= scan_delay)
		last_scan_time = world.time

		var/nearestTargetDist = -1
		var/nearestTargetId

		var/nearestSimpleTargetDist = -1
		var/turf/cur_turf = get_turf(src)

		for(var/A in SSxenoarch.artifact_spawning_turfs)
			var/turf/simulated/mineral/T = A
			if(T.density && T.artifact_find)
				if(T.z == cur_turf.z)
					var/cur_dist = get_dist(cur_turf, T) * 2
					if(nearestTargetDist < 0 || cur_dist < nearestTargetDist)
						nearestTargetDist = cur_dist + rand() * 2 - 1
						nearestTargetId = T.artifact_find.artifact_id
			else
				SSxenoarch.artifact_spawning_turfs.Remove(T)

		for(var/A in SSxenoarch.digsite_spawning_turfs)
			var/turf/simulated/mineral/T = A
			if(T.density && T.finds && T.finds.len)
				if(T.z == cur_turf.z)
					var/cur_dist = get_dist(cur_turf, T) * 2
					if(nearestSimpleTargetDist < 0 || cur_dist < nearestSimpleTargetDist)
						nearestSimpleTargetDist = cur_dist + rand() * 2 - 1
			else
				SSxenoarch.digsite_spawning_turfs.Remove(T)

		if(nearestTargetDist >= 0)
			to_chat(user, "Exotic energy detected on wavelength '[nearestTargetId]' in a radius of [nearestTargetDist]m[nearestSimpleTargetDist > 0 ? "; small anomaly detected in a radius of [nearestSimpleTargetDist]m" : ""]")
		else if(nearestSimpleTargetDist >= 0)
			to_chat(user, "Small anomaly detected in a radius of [nearestSimpleTargetDist]m.")
		else
			to_chat(user, "Background radiation levels detected.")
	else
		to_chat(user, "Scanning array is recharging.")

/obj/item/device/depth_scanner
	name = "depth analysis scanner"
	desc = "A device used to check spatial depth and density of rock outcroppings."
	icon = 'icons/obj/pda.dmi'
	icon_state = "crap"
	item_state = "analyzer"
	origin_tech = list(TECH_MAGNET = 2, TECH_ENGINEERING = 2, TECH_BLUESPACE = 2)
	matter = list(MATERIAL_STEEL = 1000, MATERIAL_GLASS = 500, MATERIAL_ALUMINIUM = 150)
	w_class = ITEM_SIZE_SMALL
	slot_flags = SLOT_BELT
	var/list/positive_locations = list()
	var/datum/depth_scan/current

/datum/depth_scan
	var/time = ""
	var/coords = ""
	var/depth = ""
	var/clearance = 0
	var/record_index = 1
	var/dissonance_spread = 1
	var/material = "unknown"

/obj/item/device/depth_scanner/proc/scan_atom(mob/user, atom/A)
	user.visible_message(SPAN_NOTICE("\The [user] scans \the [A], the air around them humming gently."))

	if(istype(A, /turf/simulated/mineral))
		var/turf/simulated/mineral/M = A
		if((M.finds && M.finds.len) || M.artifact_find)

			//create a new scanlog entry
			var/datum/depth_scan/D = new()
			D.coords = "[M.x]:[M.y]:[M.z]"
			D.time = station_time_timestamp("hh:mm")
			D.record_index = positive_locations.len + 1
			D.material = M.mineral ? M.mineral.ore_name : "Rock"

			//find the first artifact and store it
			if(M.finds.len)
				var/datum/find/F = M.finds[1]
				D.depth = "[F.excavation_required - F.clearance_range] - [F.excavation_required]"
				D.clearance = F.clearance_range
				D.material = get_responsive_reagent(F.find_type)

			positive_locations.Add(D)

			to_chat(user, SPAN_NOTICE("[icon2html(src, user)] [src] pings."))

	else if(istype(A, /obj/structure/boulder))
		var/obj/structure/boulder/B = A
		if(B.artifact_find)
			//create a new scanlog entry
			var/datum/depth_scan/D = new()
			D.coords = "[B.x]:[B.y]:[B.z]"
			D.time = station_time_timestamp("hh:mm")
			D.record_index = positive_locations.len + 1

			//these values are arbitrary
			D.depth = rand(150, 200)
			D.clearance = rand(10, 50)
			D.dissonance_spread = rand(750, 2500) / 100

			positive_locations.Add(D)

			to_chat(user, SPAN_NOTICE("[icon2html(src, user)] [src] pings [pick("madly","wildly","excitedly","crazily")]!"))

	SStgui.update_uis(src)

/obj/item/device/depth_scanner/attack_self(mob/living/user)
	tgui_interact(user)

/obj/item/device/depth_scanner/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "DepthScanner", name)
		ui.open()

/obj/item/device/depth_scanner/tgui_data(mob/user)
	var/list/data = list()
	if(current)
		var/list/entry = list(
			"time" = current.time,
			"coords" = current.coords,
			"depth" = current.depth,
			"clearance" = current.clearance,
			"dissonance_spread" = current.dissonance_spread,
			"record_index" = current.record_index,
		)
		var/material_index = list_find(responsive_carriers, current.material)
		if(material_index > 0 && material_index <= finds_as_strings.len)
			entry["material"] = finds_as_strings[material_index]
		else
			entry["material"] = "Unknown"
		data["current"] = entry
	else
		data["current"] = null
	var/list/locations = list()
	for(var/i = 1 to positive_locations.len)
		var/datum/depth_scan/D = positive_locations[i]
		locations += list(list("index" = i, "time" = D.time, "coords" = D.coords))
	data["locations"] = locations
	return data

/obj/item/device/depth_scanner/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	switch(action)
		if("select")
			var/select_index = text2num(params["index"])
			if(select_index && select_index <= positive_locations.len)
				current = positive_locations[select_index]
			return TRUE
		if("clear")
			var/clear_index = text2num(params["index"])
			if(clear_index)
				if(clear_index <= positive_locations.len)
					var/datum/depth_scan/D = positive_locations[clear_index]
					positive_locations.Remove(D)
					qdel(D)
			else
				//GC will hopefully pick them up before too long
				positive_locations = list()
				QDEL_NULL(current)
			return TRUE
	return FALSE

//Radio beacon locator
/obj/item/pinpointer/radio
	name = "locator device"
	desc = "Used to scan and locate signals on a particular frequency."
	var/tracking_freq = PUB_FREQ
	matter = list(MATERIAL_ALUMINIUM = 1000, MATERIAL_GLASS = 500)

/obj/item/pinpointer/radio/acquire_target()
	var/turf/T = get_turf(src)
	var/zlevels = GetConnectedZlevels(T.z)
	var/cur_dist = world.maxx+world.maxy
	for(var/obj/machinery/tele_beacon/R in world)
		if(!R.functioning())
			continue
		if(R.z in zlevels)
			var/check_dist = get_dist(src,R)
			if(check_dist < cur_dist)
				cur_dist = check_dist
				. = weakref(R)

/obj/item/pinpointer/radio/attack_self(mob/user as mob)
	tgui_interact(user)

/obj/item/pinpointer/radio/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "RadioPinpointer", name)
		ui.open()

/obj/item/pinpointer/radio/tgui_data(mob/user)
	var/list/data = list()
	data["active"] = active ? TRUE : FALSE
	data["freq"] = format_frequency(tracking_freq)
	return data

/obj/item/pinpointer/radio/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	switch(action)
		if("toggle")
			toggle(usr)
			return TRUE
		if("reset_tracking")
			target = acquire_target()
			return TRUE
		if("freq")
			var/new_frequency = (tracking_freq + text2num(params["amount"]))
			tracking_freq = sanitize_frequency(new_frequency, RADIO_LOW_FREQ, RADIO_HIGH_FREQ)
			return TRUE
	return FALSE

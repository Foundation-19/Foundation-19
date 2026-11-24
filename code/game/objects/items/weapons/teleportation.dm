/* Teleportation devices.
 * Contains:
 *		Locator
 *		Hand-tele
 */

/*
 * Locator
 */
/obj/item/locator
	name = "locator"
	desc = "Used to track those with locater implants."
	icon = 'icons/obj/device.dmi'
	icon_state = "locator"
	var/temp = null
	var/frequency = 1451
	var/broadcasting = null
	var/listening = 1.0
	obj_flags = OBJ_FLAG_CONDUCTIBLE
	w_class = ITEM_SIZE_SMALL
	item_state = "electronic"
	throw_speed = 4
	throw_range = 20
	origin_tech = list(TECH_MAGNET = 1)
	matter = list(MATERIAL_ALUMINIUM = 400)

/obj/item/locator/attack_self(mob/user as mob)
	tgui_interact(user)

/obj/item/locator/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "Locator", "Persistent Signal Locator")
		ui.open()

/obj/item/locator/tgui_data(mob/user)
	var/list/data = list()
	data["frequency"] = format_frequency(frequency)
	data["show_results"] = temp ? TRUE : FALSE
	if(temp)
		var/turf/sr = get_turf(src)
		if(sr)
			var/list/beacons = list()
			for(var/obj/machinery/tele_beacon/W in world)
				if(!W.functioning())
					continue
				var/turf/tr = get_turf(W)
				if (tr.z == sr.z && tr)
					var/direct = max(abs(tr.x - sr.x), abs(tr.y - sr.y))
					if (direct < 5)
						direct = "very strong"
					else
						if (direct < 10)
							direct = "strong"
						else
							if (direct < 20)
								direct = "weak"
							else
								direct = "very weak"
					beacons += list(list("name" = W.beacon_name, "direction" = dir2text(get_dir(sr, tr)), "strength" = direct))
			data["beacons"] = beacons

			var/list/signals = list()
			for (var/obj/item/implant/tracking/W in world)
				if (!W.implanted || !(istype(W.loc,/obj/item/organ/external) || ismob(W.loc)))
					continue
				else
					var/mob/M = W.loc
					if (M.stat == 2)
						if (M.timeofdeath + 6000 < world.time)
							continue

				var/turf/tr = get_turf(W)
				if (tr.z == sr.z && tr)
					var/direct = max(abs(tr.x - sr.x), abs(tr.y - sr.y))
					if (direct < 20)
						if (direct < 5)
							direct = "very strong"
						else
							if (direct < 10)
								direct = "strong"
							else
								direct = "weak"
						signals += list(list("name" = W.id, "direction" = dir2text(get_dir(sr, tr)), "strength" = direct))
			data["signals"] = signals

			data["position"] = "[sr.x], [sr.y], [sr.z]"
		else
			data["error"] = "Unable to locate orbital position."
	return data

/obj/item/locator/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if (usr.stat || usr.restrained())
		return TRUE
	var/turf/current_location = get_turf(usr)
	if(!current_location||current_location.z==2)
		to_chat(usr, "The [src] is malfunctioning.")
		return TRUE
	if (!(list_find(usr.contents, src) || (in_range(src, usr) && istype(src.loc, /turf))))
		return TRUE
	switch(action)
		if("refresh")
			temp = "1"
			return TRUE
		if("freq")
			frequency += text2num(params["value"])
			frequency = sanitize_frequency(frequency)
			return TRUE
		if("temp")
			temp = null
			return TRUE
	return FALSE

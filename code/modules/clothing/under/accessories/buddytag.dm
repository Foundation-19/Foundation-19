
/obj/item/clothing/accessory/buddytag
	name = "buddy tag"
	desc = "A tiny device, paired up with a counterpart set to same code. When devices are taken apart too far, they start beeping."
	icon_state = "buddytag0"
	slot_flags = SLOT_TIE
	high_visibility = 1
	var/next_search = 0
	var/on = 0
	var/id = 1

/obj/item/clothing/accessory/buddytag/on_update_icon()
	icon_state = "buddytag[on]"

/obj/item/clothing/accessory/buddytag/attack_self(mob/user)
	if(!CanPhysicallyInteract(user))
		return
	tgui_interact(user)

/obj/item/clothing/accessory/buddytag/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "BuddyTag", "Buddy Tag")
		ui.open()

/obj/item/clothing/accessory/buddytag/tgui_data(mob/user)
	var/list/data = list()
	data["on"] = on
	data["id"] = id
	return data

/obj/item/clothing/accessory/buddytag/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	switch(action)
		if("toggle")
			on = !on
			if(on)
				next_search = world.time
				START_PROCESSING(SSobj, src)
			update_icon()
			return TRUE
		if("setcode")
			var/newcode = input("Set new buddy ID number." , "Buddy Tag ID" , "") as num|null
			if(newcode == null)
				return TRUE
			id = newcode
			return TRUE
	return FALSE

/obj/item/clothing/accessory/buddytag/Process()
	if(!on)
		return PROCESS_KILL
	if(world.time < next_search)
		return
	next_search = world.time + 30 SECONDS
	var/has_friend
	for(var/obj/item/clothing/accessory/buddytag/buddy in SSobj.processing)
		if(buddy == src)
			continue
		if(!buddy.on)
			continue
		if(buddy.id != id)
			continue
		if(get_z(buddy) != get_z(src))
			continue
		if(get_dist(get_turf(src), get_turf(buddy)) <= 10)
			has_friend = TRUE
			break
	if(!has_friend)
		playsound(src, 'sounds/machines/chime.ogg', 10)
		var/turf/T = get_turf(src)
		if(T)
			T.visible_message(SPAN_WARNING("[src] beeps anxiously."), range = 3)

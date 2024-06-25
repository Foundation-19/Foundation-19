/*
	The hud datum
	Used to show and hide huds for all the different mob types,
	including inventories and item quick actions.
*/

/mob
	var/hud_type = null
	var/datum/hud/hud_used = null
	var/list/effects_planemasters = list()

/mob/proc/InitializeHud()
	if(hud_used)
		qdel(hud_used)
	if(hud_type)
		hud_used = new hud_type(src)
	else
		hud_used = new /datum/hud
	InitializePlanes()

/mob/proc/InitializePlanes()
	if(length(effects_planemasters))
		for(var/i in effects_planemasters)
			client.screen += effects_planemasters["[i]"]
		return
	var/list/plane_index = list(DEFAULT_PLANE, OBJ_PLANE, MOB_PLANE, OBSERVER_PLANE, EFFECTS_ABOVE_LIGHTING_PLANE, FULLSCREEN_PLANE)
	effects_planemasters = list()

	for(var/index in plane_index)
		var/atom/movable/screen/plane_master/effects_planemaster/generated_plane = new
		generated_plane.plane = index
		client.screen += generated_plane
		effects_planemasters["[index]"] = generated_plane

	for(var/os_plane_index = OPENTURF_MAX_PLANE-OPENTURF_MAX_DEPTH to OPENTURF_MAX_PLANE)
		var/atom/movable/screen/plane_master/effects_planemaster/openspace/os_pm = new
		os_pm.plane = os_plane_index
		client.screen += os_pm
		effects_planemasters["[os_plane_index]"] = os_pm
	InitializeAo()


/mob/proc/InitializeAo()
	var/atom/movable/screen/plane_master/effects_planemaster/object_pm = effects_planemasters["[OBJ_PLANE]"]
	if(object_pm)
		object_pm.add_filter("ao", 1, list(type = "drop_shadow", x = 0, y = -2, size = 4, color = "#04080FAA"))


/mob/proc/DeletePlanes()
	for(var/y in effects_planemasters)
		client.screen -= effects_planemasters["[y]"]
	QDEL_LIST_ASSOC_VAL(effects_planemasters)
	return TRUE

/mob/Destroy()
	QDEL_LIST_ASSOC_VAL(effects_planemasters)
	return ..()

/datum/hud
	var/mob/mymob

	var/hud_shown = 1			//Used for the HUD toggle (F12)
	var/inventory_shown = 1		//the inventory
	var/show_intent_icons = 0
	var/hotkey_ui_hidden = 0	//This is to hide the buttons that can be used via hotkeys. (hotkeybuttons list of buttons)

	var/atom/movable/screen/lingchemdisplay
	var/atom/movable/screen/r_hand_hud_object
	var/atom/movable/screen/l_hand_hud_object
	var/atom/movable/screen/action_intent
	var/atom/movable/screen/move_intent
	var/atom/movable/screen/stamina/stamina_bar
	var/atom/movable/screen/rest_button
	var/atom/movable/screen/facedir_button = null

	var/list/adding
	var/list/other
	var/list/atom/movable/screen/hotkeybuttons

	var/atom/movable/screen/movable/action_button/hide_toggle/hide_actions_toggle
	var/action_buttons_hidden = 0

/datum/hud/New(mob/owner)
	mymob = owner
	instantiate()
	return ..()

/datum/hud/Destroy()
	. = ..()
	stamina_bar = null
	lingchemdisplay = null
	r_hand_hud_object = null
	l_hand_hud_object = null
	action_intent = null
	move_intent = null
	adding = null
	other = null
	hotkeybuttons = null
	rest_button = null
	facedir_button = null
	mymob = null

/datum/hud/proc/update_stamina()
	if(mymob && stamina_bar)
		stamina_bar.invisibility = INVISIBILITY_MAXIMUM
		var/stamina = mymob.get_stamina()
		if(stamina < 100)
			stamina_bar.invisibility = 0
			stamina_bar.icon_state = "prog_bar_[Floor(stamina/5)*5]"

/datum/hud/proc/hidden_inventory_update()
	if(!mymob) return
	if(ishuman(mymob))
		var/mob/living/carbon/human/H = mymob
		for(var/gear_slot in H.species.hud.gear)
			var/list/hud_data = H.species.hud.gear[gear_slot]
			if(inventory_shown && hud_shown)
				switch(hud_data["slot"])
					if(slot_head)
						if(H.head)      H.head.screen_loc =      hud_data["loc"]
					if(slot_shoes)
						if(H.shoes)     H.shoes.screen_loc =     hud_data["loc"]
					if(slot_l_ear)
						if(H.l_ear)     H.l_ear.screen_loc =     hud_data["loc"]
					if(slot_r_ear)
						if(H.r_ear)     H.r_ear.screen_loc =     hud_data["loc"]
					if(slot_gloves)
						if(H.gloves)    H.gloves.screen_loc =    hud_data["loc"]
					if(slot_glasses)
						if(H.glasses)   H.glasses.screen_loc =   hud_data["loc"]
					if(slot_w_uniform)
						if(H.w_uniform) H.w_uniform.screen_loc = hud_data["loc"]
					if(slot_wear_suit)
						if(H.wear_suit) H.wear_suit.screen_loc = hud_data["loc"]
					if(slot_wear_mask)
						if(H.wear_mask) H.wear_mask.screen_loc = hud_data["loc"]
			else
				switch(hud_data["slot"])
					if(slot_head)
						if(H.head)      H.head.screen_loc =      null
					if(slot_shoes)
						if(H.shoes)     H.shoes.screen_loc =     null
					if(slot_l_ear)
						if(H.l_ear)     H.l_ear.screen_loc =     null
					if(slot_r_ear)
						if(H.r_ear)     H.r_ear.screen_loc =     null
					if(slot_gloves)
						if(H.gloves)    H.gloves.screen_loc =    null
					if(slot_glasses)
						if(H.glasses)   H.glasses.screen_loc =   null
					if(slot_w_uniform)
						if(H.w_uniform) H.w_uniform.screen_loc = null
					if(slot_wear_suit)
						if(H.wear_suit) H.wear_suit.screen_loc = null
					if(slot_wear_mask)
						if(H.wear_mask) H.wear_mask.screen_loc = null


/datum/hud/proc/persistant_inventory_update()
	if(!mymob)
		return

	if(ishuman(mymob))
		var/mob/living/carbon/human/H = mymob
		for(var/gear_slot in H.species.hud.gear)
			var/list/hud_data = H.species.hud.gear[gear_slot]
			if(hud_shown)
				switch(hud_data["slot"])
					if(slot_s_store)
						if(H.s_store) H.s_store.screen_loc = hud_data["loc"]
					if(slot_wear_id)
						if(H.wear_id) H.wear_id.screen_loc = hud_data["loc"]
					if(slot_belt)
						if(H.belt)    H.belt.screen_loc =    hud_data["loc"]
					if(slot_back)
						if(H.back)    H.back.screen_loc =    hud_data["loc"]
					if(slot_l_store)
						if(H.l_store) H.l_store.screen_loc = hud_data["loc"]
					if(slot_r_store)
						if(H.r_store) H.r_store.screen_loc = hud_data["loc"]
			else
				switch(hud_data["slot"])
					if(slot_s_store)
						if(H.s_store) H.s_store.screen_loc = null
					if(slot_wear_id)
						if(H.wear_id) H.wear_id.screen_loc = null
					if(slot_belt)
						if(H.belt)    H.belt.screen_loc =    null
					if(slot_back)
						if(H.back)    H.back.screen_loc =    null
					if(slot_l_store)
						if(H.l_store) H.l_store.screen_loc = null
					if(slot_r_store)
						if(H.r_store) H.r_store.screen_loc = null


/datum/hud/proc/instantiate()
	if(!ismob(mymob)) return 0
	if(!mymob.client) return 0
	var/ui_style = ui_style2icon(mymob.client.prefs.UI_style)
	var/ui_color = mymob.client.prefs.UI_style_color
	var/ui_alpha = mymob.client.prefs.UI_style_alpha


	FinalizeInstantiation(ui_style, ui_color, ui_alpha)

/datum/hud/proc/FinalizeInstantiation(ui_style, ui_color, ui_alpha)
	return

//Triggered when F12 is pressed (Unless someone changed something in the DMF)
/mob/verb/button_pressed_F12(full = 0 as null)
	set name = "F12"
	set hidden = 1

	if(!hud_used)
		to_chat(usr, SPAN_WARNING("This mob type does not use a HUD."))
		return

	if(!ishuman(src))
		to_chat(usr, SPAN_WARNING("Inventory hiding is currently only supported for human mobs, sorry."))
		return

	if(!client) return
	if(client.view != world.view)
		return
	if(hud_used.hud_shown)
		hud_used.hud_shown = 0
		if(src.hud_used.adding)
			src.client.screen -= src.hud_used.adding
		if(src.hud_used.other)
			src.client.screen -= src.hud_used.other
		if(src.hud_used.hotkeybuttons)
			src.client.screen -= src.hud_used.hotkeybuttons

		//Due to some poor coding some things need special treatment:
		//These ones are a part of 'adding', 'other' or 'hotkeybuttons' but we want them to stay
		if(!full)
			src.client.screen += src.hud_used.l_hand_hud_object	//we want the hands to be visible
			src.client.screen += src.hud_used.r_hand_hud_object	//we want the hands to be visible
			src.client.screen += src.hud_used.action_intent		//we want the intent swticher visible
			src.hud_used.action_intent.screen_loc = ui_acti_alt	//move this to the alternative position, where zone_select usually is.
		else
			src.client.screen -= src.healths
			src.client.screen -= src.internals
			src.client.screen -= src.gun_setting_icon

		//These ones are not a part of 'adding', 'other' or 'hotkeybuttons' but we want them gone.
		src.client.screen -= src.zone_sel	//zone_sel is a mob variable for some reason.

	else
		hud_used.hud_shown = 1
		if(src.hud_used.adding)
			src.client.screen += src.hud_used.adding
		if(src.hud_used.other && src.hud_used.inventory_shown)
			src.client.screen += src.hud_used.other
		if(src.hud_used.hotkeybuttons && !src.hud_used.hotkey_ui_hidden)
			src.client.screen += src.hud_used.hotkeybuttons
		if(src.healths)
			src.client.screen |= src.healths
		if(src.internals)
			src.client.screen |= src.internals
		if(src.gun_setting_icon)
			src.client.screen |= src.gun_setting_icon

		src.hud_used.action_intent.screen_loc = ui_acti //Restore intent selection to the original position
		src.client.screen += src.zone_sel				//This one is a special snowflake

	hud_used.hidden_inventory_update()
	hud_used.persistant_inventory_update()
	update_action_buttons()

//Similar to button_pressed_F12() but keeps zone_sel, gun_setting_icon, and healths.
/mob/proc/toggle_zoom_hud()
	if(!hud_used)
		return
	if(!ishuman(src))
		return
	if(!client)
		return
	if(client.view != world.view)
		return

	if(hud_used.hud_shown)
		hud_used.hud_shown = 0
		if(src.hud_used.adding)
			src.client.screen -= src.hud_used.adding
		if(src.hud_used.other)
			src.client.screen -= src.hud_used.other
		if(src.hud_used.hotkeybuttons)
			src.client.screen -= src.hud_used.hotkeybuttons
		src.client.screen -= src.internals
		src.client.screen += src.hud_used.action_intent		//we want the intent swticher visible
	else
		hud_used.hud_shown = 1
		if(src.hud_used.adding)
			src.client.screen += src.hud_used.adding
		if(src.hud_used.other && src.hud_used.inventory_shown)
			src.client.screen += src.hud_used.other
		if(src.hud_used.hotkeybuttons && !src.hud_used.hotkey_ui_hidden)
			src.client.screen += src.hud_used.hotkeybuttons
		if(src.internals)
			src.client.screen |= src.internals
		src.hud_used.action_intent.screen_loc = ui_acti //Restore intent selection to the original position

	hud_used.hidden_inventory_update()
	hud_used.persistant_inventory_update()
	update_action_buttons()

/mob/proc/add_click_catcher()
	client.screen |= GLOB.click_catchers

/mob/new_player/add_click_catcher()
	return

/atom/movable/screen/stamina
	name = "stamina"
	icon = 'icons/hud/progressbar.dmi'
	icon_state = "prog_bar_100"
	invisibility = INVISIBILITY_MAXIMUM
	screen_loc = ui_stamina

/datum/hud/show_hud(version = 0, mob/viewmob)
	. = ..()
	if(!.)
		return
	var/mob/screenmob = viewmob || mymob
	if(!screenmob.client)
		return FALSE
	hidden_inventory_update(screenmob)

//Version denotes which style should be displayed. blank or 0 means "next version"
/datum/hud/proc/show_hud(version = 0, mob/viewmob)
	if(!ismob(mymob))
		return FALSE
// if(!mymob.client)
// return FALSE
	var/mob/screenmob = viewmob || mymob
	if(!screenmob.client)
		return FALSE

	screenmob.client.clear_screen()
	screenmob.client.apply_clickcatcher()

	var/display_hud_version = version
	if(!display_hud_version) //If 0 or blank, display the next hud version
		display_hud_version = hud_version + 1
	if(display_hud_version > HUD_VERSIONS) //If the requested version number is greater than the available versions, reset back to the first version
		display_hud_version = 1

	switch(display_hud_version)
		if(HUD_STYLE_STANDARD) //Default HUD
			hud_shown = 1 //Governs behavior of other procs
			if(static_inventory.len)
				screenmob.client.add_to_screen(static_inventory)
			if(toggleable_inventory.len && inventory_shown)
				screenmob.client.add_to_screen(toggleable_inventory)
			if(hotkeybuttons.len && !hotkey_ui_hidden)
				screenmob.client.add_to_screen(hotkeybuttons)
			if(infodisplay.len)
				screenmob.client.add_to_screen(infodisplay)

		if(HUD_STYLE_REDUCED) //Reduced HUD
			hud_shown = 0 //Governs behavior of other procs
			if(static_inventory.len)
				screenmob.client.remove_from_screen(static_inventory)
			if(toggleable_inventory.len)
				screenmob.client.remove_from_screen(toggleable_inventory)
			if(hotkeybuttons.len)
				screenmob.client.remove_from_screen(hotkeybuttons)
			if(infodisplay.len)
				screenmob.client.add_to_screen(infodisplay)

			//These ones are a part of 'static_inventory', 'toggleable_inventory' or 'hotkeybuttons' but we want them to stay
			if(l_hand_hud_object)
				screenmob.client.add_to_screen(l_hand_hud_object) //we want the hands to be visible
			if(r_hand_hud_object)
				screenmob.client.add_to_screen(r_hand_hud_object) //we want the hands to be visible
			if(action_intent)
				screenmob.client.add_to_screen(action_intent) //we want the intent switcher visible

		if(HUD_STYLE_NOHUD) //No HUD
			hud_shown = 0 //Governs behavior of other procs
			if(static_inventory.len)
				screenmob.client.remove_from_screen(static_inventory)
			if(toggleable_inventory.len)
				screenmob.client.remove_from_screen(toggleable_inventory)
			if(hotkeybuttons.len)
				screenmob.client.remove_from_screen(hotkeybuttons)
			if(infodisplay.len)
				screenmob.client.remove_from_screen(infodisplay)

	hud_version = display_hud_version
	persistent_inventory_update(screenmob)
	mymob.update_action_buttons(TRUE)
	reorganize_alerts(screenmob)
	mymob.reload_fullscreens()

	// ensure observers get an accurate and up-to-date view
	if(!viewmob)
		plane_masters_update()
		for(var/M in mymob.observers)
			show_hud(hud_version, M)
	else if(viewmob.hud_used)
		viewmob.hud_used.plane_masters_update()

	return TRUE

/// Wrapper for adding anything to a client's screen
/client/proc/add_to_screen(screen_add)
	screen += screen_add
	SEND_SIGNAL(src, COMSIG_CLIENT_SCREEN_ADD, screen_add)

/// Wrapper for removing anything from a client's screen
/client/proc/remove_from_screen(screen_remove)
	screen -= screen_remove
	SEND_SIGNAL(src, COMSIG_CLIENT_SCREEN_REMOVE, screen_remove)

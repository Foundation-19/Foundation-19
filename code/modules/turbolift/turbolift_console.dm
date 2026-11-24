// Base type, do not use.
/obj/structure/lift
	name = "turbolift control component"
	icon = 'icons/obj/turbolift.dmi'
	anchored = TRUE
	density = FALSE
	layer = ABOVE_OBJ_LAYER

	var/datum/turbolift/lift

/obj/structure/lift/setDir(newdir)
	. = ..()
	pixel_x = 0
	pixel_y = 0
	if(dir & NORTH)
		pixel_y = -32
	else if(dir & SOUTH)
		pixel_y = 32
	else if(dir & EAST)
		pixel_x = -32
	else if(dir & WEST)
		pixel_x = 32

/obj/structure/lift/proc/pressed(mob/user)
	if(!istype(user, /mob/living/silicon))
		if(user.a_intent == I_HURT)
			user.visible_message(SPAN_DANGER("\The [user] hammers on the lift button!"))
		else
			user.visible_message(SPAN_NOTICE("\The [user] presses the lift button."))


/obj/structure/lift/New(newloc, datum/turbolift/_lift)
	lift = _lift
	return ..(newloc)

/obj/structure/lift/attack_ai(mob/user)
	return attack_hand(user)

/obj/structure/lift/attack_generic(mob/user)
	return attack_hand(user)

/obj/structure/lift/attack_hand(mob/user)
	return interact(user)

/obj/structure/lift/interact(mob/user)
	if(!lift.is_functional())
		return 0
	return 1
// End base.

// Button. No HTML interface, just calls the associated lift to its floor.
/obj/structure/lift/button
	name = "elevator button"
	desc = "A call button for an elevator. Be sure to hit it three hundred times."
	icon_state = "button"
	var/light_up = FALSE
	var/datum/turbolift_floor/floor
	mouse_opacity = MOUSE_OPACITY_OPAQUE //No more eyestrain aiming at tiny pixels

/obj/structure/lift/button/Destroy()
	if(floor && floor.ext_panel == src)
		floor.ext_panel = null
	floor = null
	return ..()

/obj/structure/lift/button/proc/reset()
	light_up = FALSE
	update_icon()

/obj/structure/lift/button/interact(mob/user)
	if(!..())
		return
	light_up()
	pressed(user)
	if(floor == lift.current_floor)
		lift.open_doors()
		spawn(3)
			reset()
		return
	lift.queue_move_to(floor)

/obj/structure/lift/button/proc/light_up()
	light_up = TRUE
	update_icon()

/obj/structure/lift/button/on_update_icon()
	if(light_up)
		icon_state = "button_lit"
	else
		icon_state = initial(icon_state)

// End button.

// Panel. Lists floors (TGUI), moves with the elevator, schedules a move to a given floor.
/obj/structure/lift/panel
	name = "elevator control panel"
	icon_state = "panel"
	mouse_opacity = MOUSE_OPACITY_OPAQUE //No more eyestrain aiming at tiny pixels


/obj/structure/lift/panel/attack_ghost(mob/user)
	return interact(user)

/obj/structure/lift/panel/interact(mob/user)
	tgui_interact(user)

/obj/structure/lift/panel/tgui_interact(mob/user, datum/tgui/ui)
	if(!lift.is_functional())
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TurboliftConsole", "Lift Panel")
		ui.open()

/obj/structure/lift/panel/tgui_data(mob/user)
	var/list/data = list()
	var/list/floors = list()
	//the floors list stores levels in order of increasing Z
	//therefore, to display upper levels at the top of the menu and
	//lower levels at the bottom, we need to go through the list in reverse
	for(var/i in lift.floors.len to 1 step -1)
		var/datum/turbolift_floor/floor = lift.floors[i]
		floors += list(list(
			"ref" = "\ref[floor]",
			"label" = floor.label ? floor.label : "Level #[i]",
			"name" = floor.name,
			"queued" = (floor in lift.queued_floors) ? TRUE : FALSE,
		))
	data["floors"] = floors
	data["doors_open"] = lift.doors_are_open() ? TRUE : FALSE
	return data

/obj/structure/lift/panel/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	switch(action)
		if("move_to_floor")
			lift.queue_move_to(locate(params["ref"]))
		if("open_doors")
			lift.open_doors()
		if("close_doors")
			lift.close_doors()
		if("emergency_stop")
			lift.emergency_stop()
		else
			return FALSE

	pressed(usr)
	return TRUE

// End panel.

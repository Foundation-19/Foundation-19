/obj/machinery/floodlight
	name = "emergency floodlight"
	desc = "A high-intensity flood lamp on a wheeled platform. It runs on a replaceable power cell."
	icon = 'icons/obj/machines/floodlight.dmi'
	icon_state = "floodlight"
	density = TRUE
	obj_flags = OBJ_FLAG_ROTATABLE
	construct_state = /decl/machine_construction/default/panel_closed
	uncreated_component_parts = null

	active_power_usage = 200
	power_channel = LIGHT
	use_power = POWER_USE_OFF

	machine_name = "emergency floodlight"
	machine_desc = "A portable, battery-powered LED flood lamp used to illuminate large areas."

	/// Brightness of the light when on. Can be negative.
	var/lamp_brightness = 0.8
	/// Inner range of the light when on. Can be negative
	var/lamp_inner_range = 0
	/// Outer range of the light when on. Can be negative.
	var/lamp_outer_range = 4.5

/obj/machinery/floodlight/on_update_icon()
	cut_overlays()
	// We build the floodlight's appearance using overlays based on its status
	if (use_power == POWER_USE_ACTIVE)
		add_overlay("floodlight_on")
	if (panel_open)
		add_overlay("floodlight_open")
		if (get_cell())
			add_overlay("floodlight_open_cell")

/obj/machinery/floodlight/power_change()
	. = ..()
	if (!. || !use_power)
		return
	if (stat & NOPOWER)
		turn_off()
		return

/// Turns on the floodlight, returning TRUE on a success or FALSE otherwise. If loud is defined, it will show a message and play a sound.
/obj/machinery/floodlight/proc/turn_on(loud = TRUE)
	if (!operable())
		return
	set_light(lamp_brightness, lamp_inner_range, lamp_outer_range)
	update_use_power(POWER_USE_ACTIVE)
	use_power_oneoff(active_power_usage) //so we drain cell if they keep trying to use it
	update_icon()
	if (loud)
		visible_message(SPAN_NOTICE("\The [src] turns on."))
		playsound(src, 'sound/effects/flashlight.ogg', 50)
	return TRUE

/// Turns off the floodlight. Doesn't return anything. If loud is defined, it will show a message and play a sound.
/obj/machinery/floodlight/proc/turn_off(loud = TRUE)
	set_light(0, 0)
	update_use_power(POWER_USE_OFF)
	update_icon()
	if (loud)
		visible_message(SPAN_NOTICE("\The [src] shuts down."))
		playsound(src, 'sound/effects/flashlight.ogg', 50)

/obj/machinery/floodlight/interface_interact(mob/user)
	if (!CanInteract(user, DefaultTopicState()))
		return FALSE
	if (use_power)
		turn_off()
	else
		if (!turn_on())
			to_chat(user, SPAN_WARNING("You try to turn on \the [src], but nothing happens."))
			playsound(loc, 'sound/effects/flashlight.ogg', 50)

	update_icon()
	return TRUE

/obj/machinery/floodlight/RefreshParts() //if they're insane enough to modify a floodlight, let them
	..()
	var/light_mod = Clamp(total_component_rating_of_type(/obj/item/stock_parts/capacitor), 0, 10)
	lamp_brightness = light_mod ? light_mod * 0.01 + initial(lamp_brightness) : initial(lamp_brightness) / 2 //gives us between 0.8-0.9 with capacitor, or 0.4 without one
	lamp_inner_range = light_mod + initial(lamp_inner_range)
	lamp_outer_range = light_mod * 1.5 + initial(lamp_outer_range)
	change_power_consumption(initial(active_power_usage) * light_mod, POWER_USE_ACTIVE)
	if (use_power)
		set_light(lamp_brightness, lamp_inner_range, lamp_outer_range)

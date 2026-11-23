/obj/item/device/floodlight
	name = "portable floodlight"
	desc = "A high-intensity portable floodlight. Can be deployed to illuminate large areas. Essential for containing light-sensitive anomalies."
	icon = 'icons/obj/lighting.dmi'
	icon_state = "floodlight"
	w_class = ITEM_SIZE_LARGE
	slot_flags = SLOT_BELT
	var/on = FALSE
	var/lum_power = 8
	var/battery_level = 100
	var/battery_drain_rate = 0.05
	var/deployed = FALSE

/obj/item/device/floodlight/attack_self(mob/user)
	if(deployed)
		undeploy(user)
		return
	on = !on
	update_icon()
	if(on)
		set_light(lum_power)
		START_PROCESSING(SSobj, src)
		to_chat(user, SPAN_NOTICE("You turn on \the [src]."))
	else
		set_light(0)
		STOP_PROCESSING(SSobj, src)
		to_chat(user, SPAN_NOTICE("You turn off \the [src]."))

/obj/item/device/floodlight/proc/deploy(mob/user)
	if(!isturf(user.loc))
		return
	user.unEquip(src, user.loc)
	anchored = TRUE
	density = TRUE
	deployed = TRUE
	icon_state = "floodlight_deployed"
	to_chat(user, SPAN_NOTICE("You deploy \the [src]."))

/obj/item/device/floodlight/proc/undeploy(mob/user)
	anchored = FALSE
	density = FALSE
	deployed = FALSE
	on = FALSE
	set_light(0)
	STOP_PROCESSING(SSobj, src)
	icon_state = "floodlight"
	user.put_in_hands(src)
	to_chat(user, SPAN_NOTICE("You pick up \the [src]."))

/obj/item/device/floodlight/Process()
	if(!on)
		STOP_PROCESSING(SSobj, src)
		return
	battery_level -= battery_drain_rate
	if(battery_level <= 0)
		battery_level = 0
		on = FALSE
		set_light(0)
		STOP_PROCESSING(SSobj, src)
		visible_message(SPAN_WARNING("\The [src] flickers and dies!"))
		update_icon()

/obj/item/device/floodlight/on_update_icon()
	if(deployed)
		icon_state = on ? "floodlight_deployed_on" : "floodlight_deployed"
	else
		icon_state = on ? "floodlight_on" : "floodlight"

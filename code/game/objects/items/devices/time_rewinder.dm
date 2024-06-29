/obj/item/device/time_rewinder
	name = "time rewinder"
	desc = "A strange device. You can see a clock on the display... that's 10 seconds slow."
	icon_state = "time_rewinder"
	obj_flags = OBJ_FLAG_CONDUCTIBLE
	item_state = "electronic"
	throwforce = 5.0
	throw_speed = 1
	throw_range = 5
	w_class = ITEM_SIZE_SMALL
	origin_tech = list(TECH_ESOTERIC = 4)
	var/on_cooldown = FALSE

/obj/item/device/time_rewinder/attack_self(mob/user)
	if(on_cooldown)
		balloon_alert(user, "on cooldown!")
		return

	flick("[initial(icon_state)]_use", src)

	user.AddComponent(/datum/component/timeloop_individual)

	icon_state = "[initial(icon_state)]_cooldown"
	on_cooldown = TRUE
	addtimer(CALLBACK(src, PROC_REF(finish_cooldown)), 3 MINUTES)

/obj/item/device/time_rewinder/proc/finish_cooldown()
	icon_state = initial(icon_state)
	on_cooldown = FALSE

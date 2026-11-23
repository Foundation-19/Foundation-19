/obj/structure/scp_soundproof_locker
	name = "soundproof containment locker"
	desc = "A heavily insulated containment locker designed to block all sound from its contents. Essential for containing auditory anomalies."
	icon = 'icons/obj/closet.dmi'
	icon_state = "acloset"
	anchored = TRUE
	density = TRUE
	var/locked = TRUE
	var/required_access = ACCESS_SCIENCE_LVL2
	var/scp_designation = ""
	var/open = FALSE
	var/soundproof = TRUE
	var/stored_item_type

/obj/structure/scp_soundproof_locker/Initialize()
	. = ..()
	if(scp_designation)
		name = "SCP-[scp_designation] soundproof containment locker"
	if(stored_item_type)
		new stored_item_type(src)

/obj/structure/scp_soundproof_locker/on_update_icon()
	if(open)
		icon_state = "acloset_open"
	else
		icon_state = "acloset"

/obj/structure/scp_soundproof_locker/attack_hand(mob/user)
	if(locked)
		var/has_access = check_user_access(user)
		if(!has_access)
			to_chat(user, SPAN_WARNING("\The [src] is locked. Swipe your ID card to unlock it."))
			return
		locked = FALSE
		audible_message(SPAN_NOTICE("\The [src] clicks unlocked."))
		return
	toggle_open(user)

/obj/structure/scp_soundproof_locker/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/card/id))
		if(locked)
			var/obj/item/card/id/id = W
			if(id.check_access(required_access))
				locked = !locked
				to_chat(user, SPAN_NOTICE("You [locked ? "lock" : "unlock"] \the [src]."))
			else
				to_chat(user, SPAN_WARNING("Access denied."))
		else
			toggle_open(user)
		return
	. = ..()

/obj/structure/scp_soundproof_locker/proc/toggle_open(mob/user)
	open = !open
	soundproof = !open
	update_icon()
	if(open)
		dump_contents()
		if(scp_designation)
			log_and_message_staff("SCP-[scp_designation] soundproof containment locker opened by [key_name(user)] at [get_area(src)]")
	else
		locked = TRUE

/obj/structure/scp_soundproof_locker/proc/dump_contents()
	for(var/atom/movable/A in src)
		A.forceMove(get_turf(src))

/obj/structure/scp_soundproof_locker/proc/check_user_access(mob/user)
	var/obj/item/card/id/id = user.GetIdCard()
	if(!id)
		return FALSE
	return id.check_access(required_access)

/obj/structure/scp_soundproof_locker/scp066
	name = "SCP-066 soundproof containment locker"
	scp_designation = "066"
	required_access = ACCESS_SCIENCE_LVL2

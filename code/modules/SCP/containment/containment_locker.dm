/obj/structure/scp_containment_locker
	name = "anomalous object locker"
	desc = "A reinforced containment locker with a lined interior for safe storage of anomalous items. Requires keycard authorization."
	icon = 'icons/obj/closet.dmi'
	icon_state = "secure1"
	anchored = TRUE
	density = TRUE
	var/locked = TRUE
	var/required_access = ACCESS_SCIENCE_LVL2
	var/scp_designation = ""
	var/open = FALSE

/obj/structure/scp_containment_locker/Initialize()
	. = ..()
	if(scp_designation)
		name = "SCP-[scp_designation] containment locker"

/obj/structure/scp_containment_locker/on_update_icon()
	if(open)
		icon_state = "secureopen"
	else if(locked)
		icon_state = "secure1"
	else
		icon_state = "secure1"

/obj/structure/scp_containment_locker/attack_hand(mob/user)
	if(locked)
		var/has_access = check_user_access(user)
		if(!has_access)
			to_chat(user, SPAN_WARNING("\The [src] is locked. Swipe your ID card to unlock it."))
			return
		locked = FALSE
		audible_message(SPAN_NOTICE("\The [src] clicks unlocked."))
		return
	toggle_open(user)

/obj/structure/scp_containment_locker/attackby(obj/item/W, mob/user)
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

/obj/structure/scp_containment_locker/proc/toggle_open(mob/user)
	open = !open
	update_icon()
	if(open)
		dump_contents()
	else
		locked = TRUE

/obj/structure/scp_containment_locker/proc/dump_contents()
	for(var/atom/movable/A in src)
		A.forceMove(get_turf(src))

/obj/structure/scp_containment_locker/proc/check_user_access(mob/user)
	var/obj/item/card/id/id = user.GetIdCard()
	if(!id)
		return FALSE
	return id.check_access(required_access)

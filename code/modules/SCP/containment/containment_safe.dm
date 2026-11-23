/obj/structure/scp_containment_safe
	name = "anomalous object safe"
	desc = "A reinforced containment safe for storing anomalous objects. Requires keycard authorization to open."
	icon = 'icons/obj/closet.dmi'
	icon_state = "secure1"
	anchored = TRUE
	density = TRUE
	opacity = TRUE
	var/locked = TRUE
	var/locked_icon_state = "safe"
	var/unlocked_icon_state = "safe_open"
	var/required_access = ACCESS_SCIENCE_LVL2
	var/obj/item/stored_item
	var/stored_item_type
	var/scp_designation = ""
	var/open = FALSE

/obj/structure/scp_containment_safe/Initialize()
	. = ..()
	if(scp_designation)
		name = "SCP-[scp_designation] containment safe"
	if(stored_item_type && !stored_item)
		stored_item = new stored_item_type(src)
	if(stored_item)
		stored_item.forceMove(src)

/obj/structure/scp_containment_safe/Destroy()
	if(stored_item)
		QDEL_NULL(stored_item)
	return ..()

/obj/structure/scp_containment_safe/on_update_icon()
	if(open)
		icon_state = unlocked_icon_state
	else
		icon_state = locked_icon_state

/obj/structure/scp_containment_safe/attack_hand(mob/user)
	if(locked)
		var/has_access = check_user_access(user)
		if(!has_access)
			to_chat(user, SPAN_WARNING("\The [src] is locked. Swipe your ID card to unlock it."))
			return
		locked = FALSE
		audible_message(SPAN_NOTICE("\The [src] clicks unlocked."))
		return
	toggle_open(user)

/obj/structure/scp_containment_safe/attackby(obj/item/W, mob/user)
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
	if(open && !stored_item && user.unEquip(W, src))
		stored_item = W
		to_chat(user, SPAN_NOTICE("You place \the [W] into \the [src]."))
		if(W.SCP && scp_designation)
			log_scp_containment(W.SCP.designation, "stored", user)
		return
	. = ..()

/obj/structure/scp_containment_safe/proc/toggle_open(mob/user)
	if(open)
		close(user)
	else
		open_safe(user)

/obj/structure/scp_containment_safe/proc/open_safe(mob/user)
	if(open)
		return
	open = TRUE
	update_icon()
	if(stored_item)
		stored_item.forceMove(get_turf(src))
		user.put_in_hands(stored_item)
		if(stored_item.SCP && scp_designation)
			log_scp_containment(stored_item.SCP.designation, "removed", user)
		stored_item = null

/obj/structure/scp_containment_safe/proc/close(mob/user)
	if(!open)
		return
	open = FALSE
	update_icon()
	locked = TRUE

/obj/structure/scp_containment_safe/proc/check_user_access(mob/user)
	var/obj/item/card/id/id = user.GetIdCard()
	if(!id)
		return FALSE
	return id.check_access(required_access)

/obj/structure/scp_containment_safe/proc/log_scp_containment(designation, action, mob/user)
	if(!user)
		return
	var/message = "[key_name(user)] has [action] SCP-[designation] from \the [src] at [get_area(src)]"
	log_and_message_staff(message)

/obj/structure/scp_containment_safe/scp012
	name = "SCP-012 containment safe"
	scp_designation = "012"
	required_access = ACCESS_SCIENCE_LVL2

/obj/structure/scp_containment_safe/scp113
	name = "SCP-113 containment safe"
	scp_designation = "113"
	required_access = ACCESS_SCIENCE_LVL2

/obj/structure/scp_containment_safe/scp513
	name = "SCP-513 containment safe"
	scp_designation = "513"
	required_access = ACCESS_SCIENCE_LVL2

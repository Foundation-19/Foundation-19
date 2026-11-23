/obj/item/scp151_cover
	name = "anomalous object cover"
	desc = "A heavy canvas cover designed to block line of sight to anomalous objects. Essential for containing visual cognitohazards."
	icon = 'icons/obj/items.dmi'
	icon_state = "scp_cover"
	w_class = ITEM_SIZE_LARGE
	var/obj/structure/covered_target

/obj/item/scp151_cover/afterattack(atom/target, mob/user, proximity)
	if(!proximity)
		return
	if(istype(target, /obj/structure/scp151))
		user.unEquip(src, get_turf(target))
		covered_target = target
		apply_cover(target)
		to_chat(user, SPAN_NOTICE("You cover \the [target] with \the [src]."))
		return
	. = ..()

/obj/item/scp151_cover/proc/apply_cover(obj/structure/target)
	forceMove(get_turf(target))
	layer = target.layer + 0.1
	anchored = TRUE
	icon_state = "scp_cover_placed"
	name = "covered [target.name]"
	target.visible_message(SPAN_NOTICE("\The [target] is now covered."))

/obj/item/scp151_cover/attack_hand(mob/user)
	if(anchored && covered_target)
		to_chat(user, SPAN_NOTICE("You remove the cover from \the [covered_target]."))
		remove_cover()
		user.put_in_hands(src)
		return
	. = ..()

/obj/item/scp151_cover/proc/remove_cover()
	if(covered_target)
		covered_target.visible_message(SPAN_WARNING("\The [covered_target] is now uncovered!"))
		covered_target = null
	anchored = FALSE
	layer = initial(layer)
	icon_state = initial(icon_state)
	name = initial(name)

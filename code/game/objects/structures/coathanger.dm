/obj/structure/coatrack
	name = "coat rack"
	desc = "Its a rack that can hold coats, and hats!"
	icon = 'icons/obj/coatrack.dmi'
	icon_state = "coatrack"
	var/obj/item/clothing/suit/coat
	var/obj/item/clothing/head/hat

/obj/structure/coatrack/attack_hand(mob/user as mob)
	if(coat)
		user.visible_message(SPAN_NOTICE("[user] takes [coat] off \the [src]."), SPAN_NOTICE("You take [coat] off the \the [src]"))
		if(!user.put_in_active_hand(coat))
			coat.dropInto(user.loc)
		coat = null
		update_icon()
	else if(hat)
		user.visible_message(SPAN_NOTICE("[user] takes [hat] off \the [src]."), SPAN_NOTICE("You take [hat] off the \the [src]"))
		if(!user.put_in_active_hand(hat))
			hat.dropInto(user.loc)
		hat = null
		update_icon()

/obj/structure/coatrack/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/clothing/suit) && user.unEquip(W, src))
		user.visible_message(SPAN_NOTICE("[user] puts \the [W] on \the [src]."), SPAN_NOTICE("You put \the [W] on \the [src]"))
		coat = W
		W.forceMove(src)
		update_icon()
	else if(istype(W, /obj/item/clothing/head) && user.unEquip(W, src))
		user.visible_message(SPAN_NOTICE("[user] puts \the [W] on \the [src]."), SPAN_NOTICE("You put \the [W] on \the [src]"))
		hat = W
		W.forceMove(src)
		update_icon()
	else
		return ..()

/obj/structure/coatrack/on_update_icon()
	overlays.Cut()
	if(coat)
		overlays += image(icon, icon_state = "coat_lab")
	if(hat)
		overlays += image(icon, icon_state = "hat")

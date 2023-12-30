/obj/structure/coatrack
	name = "coat rack"
	desc = "Its a rack that can hold coats, and hats!"
	icon = 'icons/obj/coatrack.dmi'
	icon_state = "coatrack"
	var/obj/item/clothing/suit/coat
	var/obj/item/clothing/head/hat

/obj/structure/coatrack/attack_hand(mob/user as mob)
	switch(user.zone_sel.selecting)
		if(BP_HEAD)
			if(hat)
				user.visible_message(SPAN_NOTICE("[user] grabs \the [hat] off of \the [src]."))
				if(!user.put_in_active_hand(hat))
					hat.dropInto(user.loc)
				hat = null
				update_icon()
		else
			if(coat)
				user.visible_message(SPAN_NOTICE("[user] grabs \the [coat] off of \the [src]."))
				if(!user.put_in_active_hand(coat))
					coat.dropInto(user.loc)
				coat = null
				update_icon()

/obj/structure/coatrack/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/clothing/suit) && user.unEquip(W, src))
		if(!coat)
			user.visible_message(SPAN_NOTICE("[user] puts \the [W] on \the [src]."), SPAN_NOTICE("You put \the [W] on \the [src]"))
			coat = W
			update_icon()
		return
	if(istype(W, /obj/item/clothing/head) && user.unEquip(W, src))
		if(!hat)
			user.visible_message(SPAN_NOTICE("[user] puts \the [W] on \the [src]."), SPAN_NOTICE("You put \the [W] on \the [src]"))
			hat = W
			update_icon()
		return
	return ..()

/obj/structure/coatrack/on_update_icon()
	overlays.Cut()
	if(coat)
		switch(coat)
			if(istype(/obj/item/clothing/suit/storage/toggle/labcoat))
				overlays += image(icon, icon_state = "coat_lab")
			if(istype(/obj/item/clothing/suit/storage/det_trench))
				overlays += image(icon, icon_state = "coat_det")
			if(istype(/obj/item/clothing/suit/storage/toggle/labcoat/cmo))
				overlays += image(icon, icon_state = "coat_cmo")
			else
				overlays += image(icon, icon_state = "coat_lab")
	if(hat)
		overlays += image(icon, icon_state = "hat")

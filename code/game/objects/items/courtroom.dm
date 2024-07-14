// Contains:
// Gavel Hammer
// Gavel Block

/obj/item/gavelhammer
	name = "gavel hammer"
	desc = "Order, order! No bombs in my courthouse."
	icon = 'icons/obj/weapons/hammer.dmi'
	icon_state = "gavelhammer"
	force = 5
	throwforce = 6
	w_class = ITEM_SIZE_SMALL
	attack_verb = list("bashed", "battered", "judged", "whacked")

/obj/item/gavelblock
	name = "gavel block"
	desc = "Smack it with a gavel hammer when the junior researchers get rowdy."
	icon = 'icons/obj/weapons/hammer.dmi'
	icon_state = "gavelblock"
	force = 2
	throwforce = 2
	w_class = ITEM_SIZE_TINY

/obj/item/gavelblock/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/gavelhammer))
		playsound(loc, 'sounds/items/gavel.ogg', 100, TRUE)
		user.visible_message(SPAN_WARNING("[user] strikes \the [src] with \the [I]."))
		user.setClickCooldown(CLICK_CD_ATTACK)
	else
		return ..()

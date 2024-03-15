/obj/item/gun/projectile/scp/revolver/doublebarrel_shotgun
	name = "double-barreled shotgun"
	desc = "A true classic."
	icon = 'icons/SCP/guns/shotguns/doublebarrel.dmi'
	icon_state = "doublebarrel"
	item_state = "doublebarrel"
	foreend_icon = "fore-end"
	stock_icon = "stock"
	foreend_offset = 12
	caliber = "12g"
	max_shells = 2
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	fire_sound = 'sounds/weapons/guns/shotguns/shoot.ogg'
	bolt_back_sound = 'sounds/weapons/guns/double_barrel/double_open.ogg'
	bolt_forward_sound = 'sounds/weapons/guns/double_barrel/double_close.ogg'
	w_class = ITEM_SIZE_HUGE
	obj_flags =  OBJ_FLAG_CONDUCTIBLE
	slot_flags = SLOT_BACK
	one_hand_penalty = 2
	load_sound = SFX_SHELL_INSERT
	fire_delay = 0

/obj/item/gun/projectile/scp/revolver/doublebarrel_shotgun/attack_self()
	. = ..()
	if(.)
		update_icon()

/obj/item/gun/projectile/scp/revolver/doublebarrel_shotgun/bolt_back(mob/user, manual)
	..()
	foreend_icon = "fore-end_open"
	stock_icon = "stock_open"

/obj/item/gun/projectile/scp/revolver/doublebarrel_shotgun/bolt_forward(mob/user, manual)
	..()
	foreend_icon = "fore-end"
	stock_icon = "stock"

/obj/item/gun/projectile/scp/revolver/doublebarrel_shotgun/AltClick(mob/user)
	rotate_cylinder()
	to_chat(user, SPAN_NOTICE("You switch the barrel."))
	return TRUE

/obj/item/gun/projectile/scp/revolver/doublebarrel_shotgun/MiddleClick(mob/user)
	rotate_cylinder()
	to_chat(user, SPAN_NOTICE("You switch the barrel."))
	return TRUE

/obj/item/gun/projectile/scp/revolver/doublebarrel_shotgun/sawnoff
	name = "sawn-off shotgun"
	desc = "Omar's coming!"
	icon_state = "sawnoff"
	item_state = "sawnshotgun"
	foreend_icon = "fore-end-sawn"
	stock_icon = null
	w_class = ITEM_SIZE_NORMAL
	slot_flags = SLOT_BELT|SLOT_HOLSTER
	bulk = 2

/obj/item/gun/projectile/scp/revolver/doublebarrel_shotgun/sawnoff/bolt_back(manual)
	..()
	foreend_icon = "fore-end-sawn_open"
	stock_icon = null

/obj/item/gun/projectile/scp/revolver/doublebarrel_shotgun/sawnoff/bolt_forward(manual)
	..()
	foreend_icon = "fore-end-sawn"
	stock_icon = null

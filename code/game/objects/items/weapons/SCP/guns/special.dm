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

/obj/item/gun/projectile/automatic/scp/rpk
	name = "RPK-74"
	desc = "This is a modification of the traditional AK-47 to be a machinegun."
	icon_state = "rpk"
	item_state = "rpk"
	w_class = ITEM_SIZE_HUGE
	force = 10
	slot_flags = SLOT_BACK
	caliber = "7.62x39mm"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/scp/ak
	allowed_magazines = /obj/item/ammo_magazine/scp/ak

	firemodes = list(
		list(mode_name="short bursts",	burst=5, move_delay=12, one_hand_penalty=8, burst_accuracy = list(0,-1,-1,-2,-2),          dispersion = list(0.6, 1.0, 1.0, 1.0, 1.2)),
		list(mode_name="long bursts",	burst=8, move_delay=15, one_hand_penalty=9, burst_accuracy = list(0,-1,-1,-2,-2,-2,-3,-3), dispersion = list(1.0, 1.0, 1.0, 1.0, 1.2)),
		)

/obj/item/gun/projectile/automatic/scp/rpk/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "rpk"
	else
		icon_state = "rpk-empty"
	return

/obj/item/gun/projectile/automatic/scp/svd
	name = "SVD"
	desc = "A Russian Made Sniper-Rifle."
	icon_state = "svd"
	item_state = "svd"
	w_class = ITEM_SIZE_HUGE
	force = 10
	slot_flags = SLOT_BACK
	caliber = "7.62x54mmR"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/scp/svd
	allowed_magazines = /obj/item/ammo_magazine/scp/svd
	var/use_launcher = 0

	firemodes = list(
		list(mode_name="semiauto",       burst=1,    fire_delay=0,    move_delay=null, use_launcher=null, one_hand_penalty=5, burst_accuracy=null, dispersion=null)
		)

/obj/item/gun/projectile/automatic/scp/svd/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "svd"
	else
		icon_state = "svd-empty"
	return
/*
/obj/item/gun/projectile/automatic/scp/svd/verb/scope()
	set category = "Object"
	set name = "Use Scope"
	set popup_menu = 1

	toggle_scope(usr, 2.0)
*/

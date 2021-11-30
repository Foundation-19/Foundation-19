/obj/item/gun/projectile/automatic/scp/p90
	name = "P90 SMG"
	desc = "A submachine gun sample of the 2010s, with a scope mounted on top"
	icon_state = "p90"
	item_state = "p90"
	w_class = ITEM_SIZE_HUGE
	force = 10
	caliber = "10mm"
	slot_flags = SLOT_BELT|SLOT_BACK
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ILLEGAL = 5)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/scp/p90_mag
	allowed_magazines = /obj/item/ammo_magazine/scp/p90_mag

	//Assault rifle, burst fire degrades quicker than SMG, worse one-handing penalty, slightly increased move delay
	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0,    move_delay=null, one_hand_penalty=2, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=null, move_delay=4,    one_hand_penalty=3, burst_accuracy=list(0,-1,-1),       dispersion=list(0.0, 0.5, 0.7)),
		list(mode_name="short bursts",   burst=5, fire_delay=null, move_delay=4,    one_hand_penalty=4, burst_accuracy=list(0,-1,-1,-1,-2), dispersion=list(0.5, 0.5, 0.7, 0.9, 1.0)),
		)

/obj/item/gun/projectile/automatic/scp/p90/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "p90"
	else
		icon_state = "p90-empty"
	return
/*
/obj/item/gun/projectile/automatic/scp/p90/verb/scope()
	set category = "Object"
	set name = "Use Scope"
	set popup_menu = 1

	toggle_scope(usr, 1.0)
*/
/obj/item/gun/projectile/automatic/scp/p90
	magazine_type = /obj/item/ammo_magazine/scp/p90_mag/rubber

/obj/item/gun/projectile/automatic/scp/m16
	name = "M16"
	desc = "A automatic rifle sample of the 1960s, with a scope mounted on top"
	icon_state = "m16"
	item_state = "m16"
	w_class = ITEM_SIZE_HUGE
	force = 10
	slot_flags = SLOT_BACK
	caliber = "a556"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ILLEGAL = 5)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/scp/m16_mag
	allowed_magazines = /obj/item/ammo_magazine/scp/m16_mag

	//Assault rifle, burst fire degrades quicker than SMG, worse one-handing penalty, slightly increased move delay
	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0,    move_delay=null, one_hand_penalty=2, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=null, move_delay=4,    one_hand_penalty=3, burst_accuracy=list(0,-1,-1), dispersion=list(0.0, 0.5, 0.8)),
		)

/obj/item/gun/projectile/automatic/scp/m16/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "m16"
	else
		icon_state = "m16-empty"
	return

/obj/item/gun/projectile/automatic/scp/donor/ak74
	name = "AK-103"
	desc = "Автомат Калашникова сотой серии под патрон 7,62х39."
	icon_state = "ak74"
	item_state = "ak74"
	w_class = ITEM_SIZE_HUGE
	force = 10
	slot_flags = SLOT_BACK
	caliber = "a762"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ILLEGAL = 5)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/scp/ak
	allowed_magazines = /obj/item/ammo_magazine/scp/ak

	//Assault rifle, burst fire degrades quicker than SMG, worse one-handing penalty, slightly increased move delay
	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0,    move_delay=null, one_hand_penalty=2, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=null, move_delay=4,    one_hand_penalty=3, burst_accuracy=list(0,-1,-1), dispersion=list(0.0, 0.6, 1.0)),
		)

/obj/item/gun/projectile/automatic/scp/donor/ak74/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "ak74"
	else
		icon_state = "ak74-empty"
	return
/*
/obj/item/gun/projectile/automatic/scp/donor/ak74/verb/scope()
	set category = "Object"
	set name = "Use Scope"
	set popup_menu = 1

	toggle_scope(usr, 1.0)
*/
/obj/item/gun/projectile/automatic/scp/donor/ak742
	name = "AK-19"
	desc = "Модификация АК-12. На нижней планке установлена вертикальная рукоять."
	icon_state = "ak742"
	item_state = "ak742"
	w_class = ITEM_SIZE_HUGE
	force = 10
	slot_flags = SLOT_BACK
	caliber = "a762"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ILLEGAL = 5)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/scp/ak
	allowed_magazines = /obj/item/ammo_magazine/scp/ak

	//Assault rifle, burst fire degrades quicker than SMG, worse one-handing penalty, slightly increased move delay
	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0,    move_delay=null, one_hand_penalty=2, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=null, move_delay=4,    one_hand_penalty=3, burst_accuracy=list(0,-1,-1), dispersion=list(0.0, 0.6, 1.0)),
		)

/obj/item/gun/projectile/automatic/scp/donor/ak742/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "ak742"
	else
		icon_state = "ak742-empty"
	return

/obj/item/gun/projectile/automatic/scp/donor/ierichon
	name = "Jericho-114 Pistol "
	desc = "Jericho-114 Pistol, a boss of a pistol"
	icon_state = "ierichon"
	item_state = "ierichon"
	w_class = ITEM_SIZE_NORMAL
	load_method = MAGAZINE
	caliber = ".45"
	origin_tech = list(TECH_COMBAT = 5, TECH_MATERIAL = 2, TECH_ILLEGAL = 3)
	slot_flags = SLOT_BELT
	ammo_type = /obj/item/ammo_casing/c45
	magazine_type = /obj/item/ammo_magazine/scp/ierichon
	allowed_magazines = /obj/item/ammo_magazine/scp/ierichon //more damage compared to the wt550, smaller mag size

	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0,    move_delay=null, one_hand_penalty=0, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=null, move_delay=4,    one_hand_penalty=1, burst_accuracy=list(0,-1,-1),       dispersion=list(0.0, 0.6, 1.0)),
		)

/obj/item/gun/projectile/automatic/scp/donor/ierichon/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "ierichon"
	else
		icon_state = "ierichon-empty"

/obj/item/gun/projectile/automatic/scp/donor/rpk
	name = "RPK-74"
	desc = "This is a modification of the traditional AK-47 to be a machinegun."
	icon_state = "rpk"
	item_state = "rpk"
	w_class = ITEM_SIZE_HUGE
	force = 10
	slot_flags = SLOT_BACK
	caliber = "a762"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ILLEGAL = 5)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/scp/ak
	allowed_magazines = /obj/item/ammo_magazine/scp/ak

	firemodes = list(
		list(mode_name="short bursts",	burst=5, move_delay=12, one_hand_penalty=8, burst_accuracy = list(0,-1,-1,-2,-2),          dispersion = list(0.6, 1.0, 1.0, 1.0, 1.2)),
		list(mode_name="long bursts",	burst=8, move_delay=15, one_hand_penalty=9, burst_accuracy = list(0,-1,-1,-2,-2,-2,-3,-3), dispersion = list(1.0, 1.0, 1.0, 1.0, 1.2)),
		)

/obj/item/gun/projectile/automatic/scp/donor/rpk/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "rpk"
	else
		icon_state = "rpk-empty"
	return

/obj/item/gun/projectile/automatic/scp/donor/svd
	name = "SVD"
	desc = "A Russian Made Sniper-Rifle."
	icon_state = "svd"
	item_state = "svd"
	w_class = ITEM_SIZE_HUGE
	force = 10
	slot_flags = SLOT_BACK
	caliber = "a762"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ILLEGAL = 5)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/scp/svd
	allowed_magazines = /obj/item/ammo_magazine/scp/svd

	firemodes = list(
		list(mode_name="semiauto",       burst=1,    fire_delay=0,    move_delay=null, use_launcher=null, one_hand_penalty=5, burst_accuracy=null, dispersion=null)
		)

/obj/item/gun/projectile/automatic/scp/donor/svd/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "svd"
	else
		icon_state = "svd-empty"
	return
/*
/obj/item/gun/projectile/automatic/scp/donor/svd/verb/scope()
	set category = "Object"
	set name = "Use Scope"
	set popup_menu = 1

	toggle_scope(usr, 2.0)
*/

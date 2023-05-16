/obj/item/gun/projectile/automatic/scp
	var/bolt_open = FALSE
	var/bolt_back_sound = 'sound/weapons/guns/interaction/ltrifle_magin.ogg'
	var/bolt_forward_sound = 'sound/weapons/guns/interaction/ltrifle_magin.ogg'
	var/has_bolt_icon = 1
	var/stock_icon
	var/foreend_icon
	var/stock_offset = -4
	var/foreend_offset = 20
	appearance_flags = KEEP_TOGETHER
	item_icons = list(
		slot_l_hand_str = 'icons/SCP/guns/onmob/lefthand_guns.dmi',
		slot_r_hand_str = 'icons/SCP/guns/onmob/righthand_guns.dmi',
		)



/obj/item/gun/projectile/proc/handle_mousedrop_unload(obj/over_object)
	var/mob/living/carbon/human/user = usr
	if (!over_object || !(ishuman(user)))
		return
	if (loc != user)
		return
	if(user.incapacitated())
		return
	if(!ammo_magazine)
		return

	switch(over_object.name)
		if("r_hand")
			if(!user.put_in_r_hand(ammo_magazine))
				unload_ammo(user, allow_dump = TRUE)
				return
		if("l_hand")
			if(!user.put_in_l_hand(ammo_magazine))
				unload_ammo(user, allow_dump = TRUE)
				return
		else
			return

	user.visible_message("[user] removes [ammo_magazine] from [src].",
	SPAN_NOTICE("You remove [ammo_magazine] from [src]."))
	playsound(src.loc, mag_remove_sound, 75)
	ammo_magazine.update_icon()
	ammo_magazine = null
	update_icon()
	return 1

/obj/item/gun/projectile/automatic/scp/MouseDrop(obj/over_object)
	handle_mousedrop_unload(over_object)

/obj/item/gun/projectile/automatic/scp/update_icon()
	..()
	if(stock_icon)
		var/image/stock = image(icon, stock_icon)
		stock.pixel_x = stock_offset
		add_overlay(stock)

	if(foreend_icon)
		var/image/foreend = image(icon, foreend_icon)
		foreend.pixel_x = foreend_offset
		add_overlay(foreend)

	if(ammo_magazine && ammo_magazine.gun_mag_icon)
		add_overlay(image(icon, generate_mag_icon_state()))

	if(has_bolt_icon)
		add_overlay(image(icon, "bolt_[bolt_open ? "open" : "closed"]"))


/obj/item/gun/projectile/automatic/scp/proc/generate_mag_icon_state()
	return ammo_magazine.gun_mag_icon

/*
	Rifles
*/

/obj/item/gun/projectile/automatic/scp/m4a1
	name = "M4A1"
	desc = "A Foundation-standard service carbine that takes 5.56x45mm straight magazines. Like many reliable firearms of old, the Foundation has found a use for them in the hands of Security Department guards."
	icon = 'icons/SCP/guns/rifles/m4carbine.dmi'
	icon_state = "m4carbine"
	item_state = "m4"
	force = 13
	slot_flags = SLOT_BACK
	caliber = "5.56x45mm"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/scp/m16_mag
	allowed_magazines = /obj/item/ammo_magazine/scp/m16_mag
	stock_icon = "stock"
	foreend_icon = "fore-end"

	//Assault rifle, burst fire degrades quicker than SMG, worse one-handing penalty
	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0, one_hand_penalty=2, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=1, one_hand_penalty=3, burst_accuracy=list(0,-1,-2), dispersion=list(0.0, 0.5, 0.8)),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=4, burst_accuracy=list(0,-1,-1,-2), dispersion=list(0.1, 0.6, 0.9), autofire_enabled=1),
		)

/obj/item/gun/projectile/automatic/scp/t12
	name = "T12 rifle"
	desc = "An assault rifle produced and used by the Global Occult Coalition, rarely seen loaned to high-intensity Foundation units. Highly lethal and capable of holding up to 50 rounds in its standard magazines."
	icon = 'icons/SCP/guns/rifles/g36c.dmi'
	icon_state = "g36c"
	item_state = "t12"
	force = 14
	caliber = CALIBER_T12
	origin_tech = list(TECH_COMBAT = 7, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	slot_flags = SLOT_BACK
	handle_casings = CLEAR_CASINGS
	magazine_type = /obj/item/ammo_magazine/t12
	allowed_magazines = /obj/item/ammo_magazine/t12
	one_hand_penalty = 6
	accuracy_power = 7
	accuracy = 2
	bulk = GUN_BULK_RIFLE
	wielded_item_state = "t12-wielded"
	mag_insert_sound = 'sound/weapons/guns/interaction/ltrifle_magin.ogg'
	mag_remove_sound = 'sound/weapons/guns/interaction/ltrifle_magout.ogg'
	stock_icon = "stock"
	foreend_icon = "fore-end"

	firemodes = list(
		list(mode_name="semi auto",      burst=1,    fire_delay=null, one_hand_penalty=8,  burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3,    fire_delay=null, burst_delay=1.4,     one_hand_penalty=9,  burst_accuracy=list(0,-1),    dispersion=list(0.0, 0.4, 0.8)),
		list(mode_name="full auto",      burst=1,    fire_delay=0,    burst_delay=0.5,     one_hand_penalty=11, burst_accuracy=list(0,-1,-2), dispersion=list(0.1, 0.5, 0.9), autofire_enabled=1)
		)

/obj/item/gun/projectile/automatic/scp/ak12
	name = "AK-12"
	desc = "A 5.45x39mm modernized variant of the AK-74M, exported from Russia."
	icon = 'icons/SCP/guns/rifles/ak12.dmi'
	icon_state = "ak12"
	item_state = "ak74"
	force = 10
	slot_flags = SLOT_BACK
	caliber = "5.45x39mm"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	magazine_type = /obj/item/ammo_magazine/scp/ak
	allowed_magazines = /obj/item/ammo_magazine/scp/ak
	stock_icon = "stock"
	foreend_icon = "fore-end"
	foreend_offset = 18

	//Assault rifle, burst fire degrades quicker than SMG, worse one-handing penalty
	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0, one_hand_penalty=2, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=null, one_hand_penalty=3, burst_accuracy=list(0,-1,-1), dispersion=list(0.0, 0.6, 1.0)),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=4, burst_accuracy=list(0,-1,-2), dispersion=list(0.1, 0.7, 1.1), autofire_enabled=1),
		)

/obj/item/gun/projectile/automatic/scp/galil
	name = "IWI Galil ACE"
	desc = "An intermediate cartridge infantry assault rifle first produced by and for Israeli Forces. The Foundation found a use for these reliable rifles in the hands of Foundation operatives and guards."
	icon_state = "galil"
	item_state = "galil-empty"
	force = 10
	slot_flags = SLOT_BACK
	caliber = "5.56x45mm"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	magazine_type = /obj/item/ammo_magazine/scp/m16_mag
	allowed_magazines = /obj/item/ammo_magazine/scp/m16_mag

	//Assault rifle, burst fire degrades quicker than SMG, worse one-handing penalty
	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0, one_hand_penalty=2, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=1, one_hand_penalty=3, burst_accuracy=list(0,-1,-1), dispersion=list(0.0, 0.5, 0.8)),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=4, burst_accuracy=list(0,-1,-1,-2), dispersion=list(0.1, 0.6, 0.9), autofire_enabled=1),
		)

/obj/item/gun/projectile/automatic/scp/galil/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "galil"
	else
		icon_state = "galil-empty"
	return

/obj/item/gun/projectile/automatic/scp/svd
	name = "SVD"
	desc = "Yet another spin on the AK platform, this SVD is a scoped sniper rifle with far greater range thanks to it's longer barrel and updated rifling and profile."
	icon_state = "svd"
	item_state = "svd"
	force = 10
	slot_flags = SLOT_BACK
	caliber = "7.62x54mmR"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	magazine_type = /obj/item/ammo_magazine/scp/svd
	allowed_magazines = /obj/item/ammo_magazine/scp/svd

	firemodes = list(
		list(mode_name="semiauto", burst=1, fire_delay=0, move_delay=null, one_hand_penalty=5, burst_accuracy=null, dispersion=null)
		)

/obj/item/gun/projectile/automatic/scp/svd/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "svd"
	else
		icon_state = "svd-empty"
	return

/obj/item/gun/projectile/automatic/scp/fnfal
	name = "FN FAL"
	desc = "'The Right Arm Of Freedom', the standard issue firearm for the UNGOC and some other countries. This weapon has seen mutliple big conflicts."
	icon_state = "fnfal"
	item_state = "fnfal"
	force = 10
	slot_flags = SLOT_BACK
	caliber = "a762nato"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	magazine_type = /obj/item/ammo_magazine/scp/fnfal
	allowed_magazines = /obj/item/ammo_magazine/scp/fnfal

	firemodes = list(
		list(mode_name="semiauto",       burst=1,    fire_delay=0,    move_delay=null, one_hand_penalty=5, burst_accuracy=null, dispersion=null),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=4, burst_accuracy=list(0,-1,-1,-2), dispersion=list(0.1, 0.6, 0.9), autofire_enabled=1),
		)

/obj/item/gun/projectile/automatic/scp/fnfal/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "fnfal"
	else
		icon_state = "fnfal-empty"
	return

/*
	SMGs
*/

/obj/item/gun/projectile/automatic/scp/p90
	name = "P90 SMG"
	desc = "A submachine gun sample of the 2010s, with a scope mounted on top"
	icon = 'icons/SCP/guns/smgs/p90.dmi'
	icon_state = "p90"
	item_state = "p90"
	force = 10
	caliber = "5.7x28mm"
	slot_flags = SLOT_BELT|SLOT_BACK
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	magazine_type = /obj/item/ammo_magazine/scp/p90_mag/rubber
	allowed_magazines = /obj/item/ammo_magazine/scp/p90_mag
	has_bolt_icon = FALSE

	//Assault rifle, burst fire degrades quicker than SMG, worse one-handing penalty, slightly increased move delay
	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0,    move_delay=null, one_hand_penalty=2, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=null, move_delay=4,    one_hand_penalty=3, burst_accuracy=list(0,-1,-1),       dispersion=list(0.0, 0.5, 0.7)),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=4, burst_accuracy=list(0,-1,-2), dispersion=list(0.0, 0.5, 0.7), autofire_enabled=1),
		)

/obj/item/gun/projectile/automatic/scp/p90/generate_mag_icon_state()
	return "[ammo_magazine.gun_mag_icon]-[round(length(ammo_magazine.stored_ammo), 10)]"

/obj/item/gun/projectile/automatic/scp/mp5
	name = "MP5 SMG"
	desc = "A submachine gun sample of the 2010s"
	icon = 'icons/SCP/guns/smgs/mp5.dmi'
	icon_state = "mp5"
	item_state = "mp5"
	force = 10
	caliber = "9mm"
	slot_flags = SLOT_BELT|SLOT_BACK
	magazine_type = /obj/item/ammo_magazine/scp/mp5_mag
	allowed_magazines = /obj/item/ammo_magazine/scp/mp5_mag
	has_bolt_icon = FALSE

	//Assault rifle, burst fire degrades quicker than SMG, worse one-handing penalty, slightly increased move delay
	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0,    move_delay=null, one_hand_penalty=2, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=null, move_delay=4,    one_hand_penalty=3, burst_accuracy=list(0,-1,-1),       dispersion=list(0.0, 0.5, 0.7)),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=4, burst_accuracy=list(0,-1,-2), dispersion=list(0.0, 0.5, 0.7), autofire_enabled=1),
		)

/obj/item/ammo_magazine/scp/mp5_mag
	name = "mp5 magazine (9mm)"
	icon = 'icons/SCP/guns/smgs/mp5.dmi'
	icon_state = "mp5-mag"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = "9mm"
	matter = list(DEFAULT_WALL_MATERIAL = 1500)
	ammo_type = /obj/item/ammo_casing/pistol/c9mm
	max_ammo = 30
	multiple_sprites = 1

/obj/item/gun/projectile/automatic/scp/ierichon
	name = "Jericho-114 Pistol "
	desc = "A strange Brazillian export pistol sporting automatic fire and a lightweight .45 caliber frame."
	icon_state = "ierichon"
	item_state = "ierichon"
	w_class = ITEM_SIZE_NORMAL
	load_method = MAGAZINE
	caliber = ".45"
	origin_tech = list(TECH_COMBAT = 5, TECH_MATERIAL = 2, TECH_ESOTERIC = 3)
	slot_flags = SLOT_BELT
	ammo_type = /obj/item/ammo_casing/pistol/c45
	magazine_type = /obj/item/ammo_magazine/scp/ierichon
	allowed_magazines = /obj/item/ammo_magazine/scp/ierichon //more damage compared to the wt550, smaller mag size

	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0, one_hand_penalty=0, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=null, one_hand_penalty=1, burst_accuracy=list(0,-1,-1),       dispersion=list(0.0, 0.6, 1.0)),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=2, burst_accuracy=list(0,-1,-2), dispersion=list(0.1, 0.7, 1.1), autofire_enabled=1),
		)

/obj/item/gun/projectile/automatic/scp/ierichon/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "ierichon"
	else
		icon_state = "ierichon-empty"

/obj/item/gun/projectile/automatic/scp/vector
	name = "Kriss Vector"
	desc = "A powerful, high stopping power SMG assigned to MTF operatives and certain SD agents."
	icon_state = "vector-45"
	item_state = "vector-45"
	w_class = ITEM_SIZE_HUGE
	force = 10
	caliber = ".45"
	slot_flags = SLOT_BELT|SLOT_BACK
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/scp/vectormag
	allowed_magazines = /obj/item/ammo_magazine/scp/vectormag
	wielded_item_state = "p90-wielded"

	//Assault rifle, burst fire degrades quicker than SMG, worse one-handing penalty
	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0, one_hand_penalty=2, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=0, one_hand_penalty=3, burst_accuracy=list(0,-1,-1),       dispersion=list(0.0, 0.5, 0.7)),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=4, burst_accuracy=list(0,-1,-1,-2), dispersion=list(0.2, 0.6, 0.8), autofire_enabled=1),
		)

/obj/item/gun/projectile/automatic/scp/vector/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "vector-45"
	else
		icon_state = "vector-45-empty"
	return

//WHO THE FUCK ADDED A KNIFE HERE WTF
/obj/item/material/hatchet/tacknife
	name = "tactical knife"
	desc = "You'd be killing loads of people if this was 'Medal of Honor'."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "tacknife"
	item_state = "knife"
	attack_verb = list("stabbed", "chopped", "cut")
	applies_material_colour = 1
//	drawsound = 'sound/items/unholster_knife.ogg'

/*
	Automatic
*/

/obj/item/gun/projectile/scp/automatic
	bulk = -1
	load_method = MAGAZINE
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 3)
	slot_flags = SLOT_BACK
	multi_aim = 1
	burst_delay = 2
	mag_insert_sound = 'sound/weapons/guns/interaction/smg_magin.ogg'
	mag_remove_sound = 'sound/weapons/guns/interaction/smg_magout.ogg'

	//machine pistol, easier to one-hand with
	firemodes = list(
		list(mode_name="3-round bursts", burst=3, fire_delay=null, one_hand_penalty=4, burst_accuracy=list(0,-1,-1),       dispersion=list(0.0, 1.6, 2.4, 2.4)),
		list(mode_name="short bursts",   burst=5, fire_delay=null, one_hand_penalty=5, burst_accuracy=list(0,-1,-1,-1,-2), dispersion=list(1.6, 1.6, 2.0, 2.0, 2.4)),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=5, burst_accuracy=list(0,-1,-1,-1,-2), dispersion=list(1.0, 1.0, 1.2, 1.4, 1.6), autofire_enabled=1)
	)

/*
	Rifles
*/
/obj/item/gun/projectile/scp/automatic/m4a1
	name = "M4A1"
	desc = "A Foundation-standard service carbine that takes 5.56x45mm magazines."
	icon = 'icons/SCP/guns/rifles/m4carbine.dmi'
	icon_state = "m4carbine"
	item_state = "m4"
	force = 13
	slot_flags = SLOT_BACK
	w_class = ITEM_SIZE_HUGE
	caliber = "5.56x45mm"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	magazine_type = /obj/item/ammo_magazine/scp/m16_mag
	allowed_magazines = /obj/item/ammo_magazine/scp/m16_mag
	stock_icon = "stock"
	foreend_icon = "fore-end"

	bolt_back_sound = 'sound/weapons/guns/m4a1/m4a1_back.ogg'
	bolt_forward_sound = 'sound/weapons/guns/m4a1/m4a1_forward.ogg'
	mag_insert_sound = 'sound/weapons/guns/m4a1/m4a1_load.ogg'
	mag_remove_sound = 'sound/weapons/guns/m4a1/m4a1_unload.ogg'
	fire_sound = 'sound/weapons/guns/m4a1/shoot.ogg'
	has_bolt_icon = TRUE
	bolt_hold = TRUE
	bolt_hold_on_empty_mag = TRUE

	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0, one_hand_penalty=2, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=1, one_hand_penalty=3, burst_accuracy=list(0,-1,-2), dispersion=list(0.0, 0.5, 0.8)),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=4, burst_accuracy=list(0,-1,-1,-2), dispersion=list(0.1, 0.6, 0.9), autofire_enabled=1),
		)

/obj/item/gun/projectile/scp/automatic/t12
	name = "T12 rifle"
	desc = "An assault rifle produced and used by the Global Occult Coalition, rarely seen loaned to high-intensity Foundation units. Highly lethal and capable of holding up to 50 rounds in its standard magazines."
	icon = 'icons/SCP/guns/rifles/g36c.dmi'
	icon_state = "g36c"
	item_state = "t12"
	force = 14
	caliber = CALIBER_T12
	origin_tech = list(TECH_COMBAT = 7, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	slot_flags = SLOT_BACK
	w_class = ITEM_SIZE_HUGE
	handle_casings = CLEAR_CASINGS
	magazine_type = /obj/item/ammo_magazine/t12
	allowed_magazines = /obj/item/ammo_magazine/t12
	one_hand_penalty = 6
	accuracy_power = 7
	accuracy = 2
	bulk = GUN_BULK_RIFLE
	wielded_item_state = "t12-wielded"
	stock_icon = "stock"
	foreend_icon = "fore-end"
	has_bolt_icon = TRUE
	bolt_hold = TRUE
	bolt_hold_on_empty_mag = TRUE
	bolt_back_sound = 'sound/weapons/guns/t12/bolt_back.ogg'
	bolt_forward_sound = 'sound/weapons/guns/t12/bolt_forward.ogg'
	mag_insert_sound = 'sound/weapons/guns/t12/m4a1_load.ogg'
	mag_remove_sound = 'sound/weapons/guns/t12/m4a1_unload.ogg'
	fire_sound = 'sound/weapons/guns/t12/fire1.ogg'

	firemodes = list(
		list(mode_name="semi auto",      burst=1,    fire_delay=null, one_hand_penalty=8,  burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3,    fire_delay=null, burst_delay=1.4,     one_hand_penalty=9,  burst_accuracy=list(0,-1),    dispersion=list(0.0, 0.4, 0.8)),
		list(mode_name="full auto",      burst=1,    fire_delay=0,    burst_delay=0.5,     one_hand_penalty=11, burst_accuracy=list(0,-1,-2), dispersion=list(0.1, 0.5, 0.9), autofire_enabled=1)
		)

/obj/item/gun/projectile/scp/automatic/ak12
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
	foreend_offset = 17
	bolt_hold = FALSE
	bolt_hold_on_empty_mag = FALSE
	has_bolt_icon = TRUE
	mag_insert_sound = 'sound/weapons/guns/ak12/mag_in.ogg'
	mag_remove_sound = 'sound/weapons/guns/ak12/mag_out.ogg'
	fire_sound = 'sound/weapons/guns/ak12/shoot.ogg'
	bolt_back_sound = 'sound/weapons/guns/ak12/ak74_back.ogg'
	bolt_forward_sound = 'sound/weapons/guns/ak12/ak74_forward.ogg'

	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0, one_hand_penalty=2, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=null, one_hand_penalty=3, burst_accuracy=list(0,-1,-1), dispersion=list(0.0, 0.6, 1.0)),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=4, burst_accuracy=list(0,-1,-2), dispersion=list(0.1, 0.7, 1.1), autofire_enabled=1),
		)


// TODO update to new system

/obj/item/gun/projectile/automatic/galil
	name = "IWI Galil ACE"
	desc = "An intermediate cartridge infantry assault rifle first produced by and for Israeli Forces. The Foundation found a use for these reliable rifles in the hands of Foundation operatives and guards."
	icon_state = "galil"
	item_state = "galil-empty"
	icon = 'icons/obj/gun.dmi'
	force = 10
	slot_flags = SLOT_BACK
	w_class = ITEM_SIZE_HUGE
	caliber = "5.56x45mm"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	magazine_type = /obj/item/ammo_magazine/scp/m16_mag
	allowed_magazines = /obj/item/ammo_magazine/scp/m16_mag

	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0, one_hand_penalty=2, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=1, one_hand_penalty=3, burst_accuracy=list(0,-1,-1), dispersion=list(0.0, 0.5, 0.8)),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=4, burst_accuracy=list(0,-1,-1,-2), dispersion=list(0.1, 0.6, 0.9), autofire_enabled=1),
		)

/obj/item/gun/projectile/automatic/galil/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "galil"
	else
		icon_state = "galil-empty"
	return

//TODO remove it?? Replace with PKM??

/obj/item/gun/projectile/automatic/svd
	name = "SVD"
	desc = "Yet another spin on the AK platform, this SVD is a scoped sniper rifle with far greater range thanks to it's longer barrel and updated rifling and profile."
	icon_state = "svd"
	item_state = "svd"
	icon = 'icons/obj/gun.dmi'
	force = 10
	slot_flags = SLOT_BACK
	w_class = ITEM_SIZE_HUGE
	caliber = "7.62x54mmR"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	magazine_type = /obj/item/ammo_magazine/scp/svd
	allowed_magazines = /obj/item/ammo_magazine/scp/svd

	firemodes = list(
		list(mode_name="semiauto", burst=1, fire_delay=0, move_delay=null, one_hand_penalty=5, burst_accuracy=null, dispersion=null)
		)

/obj/item/gun/projectile/automatic/svd/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "svd"
	else
		icon_state = "svd-empty"
	return


// TODO replace with G3 or update

/obj/item/gun/projectile/automatic/fnfal
	name = "FN FAL"
	desc = "'The Right Arm Of Freedom', the standard issue firearm for the UNGOC and some other countries. This weapon has seen mutliple big conflicts."
	icon_state = "fnfal"
	item_state = "fnfal"
	icon = 'icons/obj/gun.dmi'
	force = 10
	slot_flags = SLOT_BACK
	w_class = ITEM_SIZE_HUGE
	caliber = "a762nato"
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	magazine_type = /obj/item/ammo_magazine/scp/fnfal
	allowed_magazines = /obj/item/ammo_magazine/scp/fnfal

	firemodes = list(
		list(mode_name="semiauto",       burst=1,    fire_delay=0,    move_delay=null, one_hand_penalty=5, burst_accuracy=null, dispersion=null),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=4, burst_accuracy=list(0,-1,-1,-2), dispersion=list(0.1, 0.6, 0.9), autofire_enabled=1),
		)

/obj/item/gun/projectile/automatic/fnfal/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "fnfal"
	else
		icon_state = "fnfal-empty"
	return

/*
	SMGs
*/

/obj/item/gun/projectile/scp/automatic/p90
	name = "P90 SMG"
	desc = "A submachine gun sample of the 2010s, with a scope mounted on top"
	icon = 'icons/SCP/guns/smgs/p90.dmi'
	icon_state = "p90"
	item_state = "p90"
	force = 10
	caliber = "5.7x28mm"
	slot_flags = SLOT_BELT|SLOT_BACK
	w_class = ITEM_SIZE_LARGE
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	magazine_type = /obj/item/ammo_magazine/scp/p90_mag/rubber
	allowed_magazines = /obj/item/ammo_magazine/scp/p90_mag
	has_bolt_icon = FALSE
	ejection_side = GUN_CASING_EJECTION_DOWN
	fire_sound = 'sound/weapons/guns/p90/shoot.ogg'

	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0,    move_delay=null, one_hand_penalty=2, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=null, move_delay=4,    one_hand_penalty=3, burst_accuracy=list(0,-1,-1),       dispersion=list(0.0, 0.5, 0.7)),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=4, burst_accuracy=list(0,-1,-2), dispersion=list(0.0, 0.5, 0.7), autofire_enabled=1),
		)

/obj/item/gun/projectile/scp/automatic/p90/generate_mag_icon_state()
	return "[ammo_magazine.gun_mag_icon]-[round(length(ammo_magazine.stored_ammo), 10)]"

/obj/item/gun/projectile/scp/automatic/mp5
	name = "MP5 SMG"
	desc = "A submachine gun sample of the 2010s"
	icon = 'icons/SCP/guns/smgs/mp5.dmi'
	icon_state = "mp5"
	item_state = "mp5"
	force = 10
	caliber = "9mm"
	fire_sound = 'sound/weapons/guns/mp5/shoot.ogg'
	slot_flags = SLOT_BELT|SLOT_BACK
	w_class = ITEM_SIZE_LARGE
	magazine_type = /obj/item/ammo_magazine/scp/mp5_mag
	allowed_magazines = /obj/item/ammo_magazine/scp/mp5_mag
	has_bolt_icon = TRUE
	bolt_hold = TRUE

	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0, move_delay=null, one_hand_penalty=2, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=0, move_delay=4, one_hand_penalty=3, burst_accuracy=list(0,-1,-1), dispersion=list(0.0, 0.3, 0.5)),
		list(mode_name="full auto",      burst=1, fire_delay=0, burst_delay=1, one_hand_penalty=4, burst_accuracy=list(0,-1,-2), dispersion=list(0.0, 0.3, 0.5), autofire_enabled=1),
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


//TODO finish + update vector
/obj/item/gun/projectile/automatic/vector
	name = "Kriss Vector"
	desc = "A powerful, high stopping power SMG assigned to MTF operatives and certain SD agents."
	icon = 'icons/obj/gun.dmi'
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

/obj/item/gun/projectile/automatic/vector/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "vector-45"
	else
		icon_state = "vector-45-empty"
	return

//WHO THE FUCK ADDED A KNIFE HERE WTF
// TODO move fucking knife to other place
/obj/item/material/hatchet/tacknife
	name = "tactical knife"
	desc = "You'd be killing loads of people if this was 'Medal of Honor'."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "tacknife"
	item_state = "knife"
	attack_verb = list("stabbed", "chopped", "cut")
	applies_material_colour = 1
//	drawsound = 'sound/items/unholster_knife.ogg'



/obj/item/gun/projectile/scp/automatic/saiga12
	name = "Saiga12 Tactical Shotgun"
	desc = "A reliable russian-made semi automatic shotgun often used by Foundation strike and security forces."
	icon = 'icons/SCP/guns/shotguns/saiga12.dmi'
	icon_state = "saiga12"
	item_state = "saiga12"
	w_class = ITEM_SIZE_HUGE
	force = 10
	slot_flags = SLOT_BACK
	caliber = CALIBER_SHOTGUN
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/scp/saiga12
	allowed_magazines = /obj/item/ammo_magazine/scp/saiga12
	screen_shake = 2.5

	stock_icon = "stock"
	foreend_icon = "fore-end"
	foreend_offset = 18
	bolt_hold = TRUE
	bolt_hold_on_empty_mag = TRUE
	has_bolt_icon = TRUE
	mag_insert_sound = 'sound/weapons/guns/saiga12/mag_in.ogg'
	mag_remove_sound = 'sound/weapons/guns/saiga12/mag_out.ogg'
	fire_sound = 'sound/weapons/guns/saiga12/shoot.ogg'
	bolt_back_sound = 'sound/weapons/guns/ak12/ak74_back.ogg'
	bolt_forward_sound = 'sound/weapons/guns/ak12/ak74_forward.ogg'

	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0, one_hand_penalty=2, burst_accuracy=null, dispersion=null))

/obj/item/gun/projectile/scp/automatic/saiga12/beanbag
	magazine_type = /obj/item/ammo_magazine/scp/saiga12/beanbag

/obj/item/gun/projectile/scp/automatic/saiga12/buckshot
	magazine_type = /obj/item/ammo_magazine/scp/saiga12/buckshot

/obj/item/gun/projectile/scp/automatic/saiga12/stunshell
	magazine_type = /obj/item/ammo_magazine/scp/saiga12/stunshell

/obj/item/gun/projectile/scp/automatic/saiga12/rubbershot
	magazine_type = /obj/item/ammo_magazine/scp/saiga12/rubbershot

/obj/item/gun/projectile/scp/automatic/saiga12/flash
	magazine_type = /obj/item/ammo_magazine/scp/saiga12/flash

/obj/item/gun/projectile/scp/automatic/saiga12/emp
	magazine_type = /obj/item/ammo_magazine/scp/saiga12/emp

/obj/item/gun/projectile/scp/pistol/
	w_class = ITEM_SIZE_NORMAL
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)
	load_method = MAGAZINE
	action_type = GUN_DOUBLE_ACTION
	bolt_back_sound = 'sound/weapons/guns/pistol/grach_bolt_back.ogg'
	bolt_forward_sound = 'sound/weapons/guns/pistol/grach_bolt_forward.ogg'
	has_bolt_icon = TRUE

/obj/item/gun/projectile/scp/pistol/mk9
	name = "MK9 Foundation pistol"
	desc = "Standard issue 9mm pistol of the SCP Foundation. Based on the HK VP9."
	icon = 'icons/SCP/guns/pistols/mk9.dmi'
	icon_state = "mk9"
	caliber = "9mm"
	fire_delay = 2
	magazine_type = /obj/item/ammo_magazine/scp/mk9
	allowed_magazines = list(/obj/item/ammo_magazine/scp/mk9)
	bolt_hold = TRUE
	bolt_hold_on_empty_mag = TRUE

/obj/item/gun/projectile/scp/pistol/m1911
	name = "M1911"
	desc = "A classic Model 1911 pistol. Still effective even today, generally used as a surplus sidearm for Foundation security staff."
	icon = 'icons/SCP/guns/pistols/m1911.dmi'
	icon_state = "colt"
	caliber = ".45"
	fire_delay = 3
	magazine_type = /obj/item/ammo_magazine/scp/m1911
	allowed_magazines = list(/obj/item/ammo_magazine/scp/m1911)
	action_type = GUN_SINGLE_ACTION
	fire_sound = 'sound/weapons/guns/pistol/m1911.ogg'
	bolt_hold = TRUE
	bolt_hold_on_empty_mag = TRUE

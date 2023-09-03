/obj/item/gun/projectile/scp/pistol
	abstract_type = /obj/item/gun/projectile/scp/pistol
	w_class = ITEM_SIZE_NORMAL
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)
	load_method = MAGAZINE
	action_type = GUN_DOUBLE_ACTION
	bolt_back_sound = 'sounds/weapons/guns/pistol/grach_bolt_back.ogg'
	bolt_forward_sound = 'sounds/weapons/guns/pistol/grach_bolt_forward.ogg'
	has_bolt_icon = TRUE
	bolt_hold = TRUE
	bolt_hold_on_empty_mag = TRUE

/obj/item/gun/projectile/scp/pistol/mk9
	name = "\improper MK9 Foundation pistol"
	desc = "Standard issue 9mm pistol of the SCP Foundation. Based on the HK VP9."
	icon = 'icons/SCP/guns/pistols/mk9.dmi'
	icon_state = "mk9"
	caliber = "9mm"
	fire_delay = 2
	magazine_type = /obj/item/ammo_magazine/scp/mk9
	allowed_magazines = list(/obj/item/ammo_magazine/scp/mk9)

/obj/item/gun/projectile/scp/pistol/m1911
	name = "\improper M1911 pistol"
	desc = "A classic Model 1911 pistol. Still effective even today, generally used as a surplus sidearm for Foundation security staff."
	icon = 'icons/SCP/guns/pistols/m1911.dmi'
	icon_state = "colt"
	caliber = ".45 ACP"
	fire_delay = 3
	magazine_type = /obj/item/ammo_magazine/scp/m1911
	allowed_magazines = list(/obj/item/ammo_magazine/scp/m1911)
	action_type = GUN_SINGLE_ACTION
	fire_sound = 'sounds/weapons/guns/pistol/m1911.ogg'

/obj/item/gun/projectile/scp/pistol/usp45tac
	name = "\improper MK45 Tactical pistol"
	desc = "Sidearm assigned to certain operatives and guards of the Foundation. Chambered in .45ACP, based on the HK USP45 Tactical."
	icon = 'icons/SCP/guns/pistols/usp45.dmi'
	icon_state = "usp45-tactical"
	caliber = ".45 ACP"
	fire_delay = 3
	magazine_type = /obj/item/ammo_magazine/scp/usp45
	allowed_magazines = list(/obj/item/ammo_magazine/scp/usp45)
	bolt_hold = TRUE
	bolt_hold_on_empty_mag = TRUE
	fire_sound = 'sounds/weapons/guns/pistol/m1911.ogg'

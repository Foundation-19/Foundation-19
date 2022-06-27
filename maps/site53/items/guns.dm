/obj/item/gun/projectile/silenced
	name = "silenced pistol"
	desc = "A handgun with an integral silencer. Uses .45 rounds."
	icon_state = "silenced_pistol"
	w_class = ITEM_SIZE_NORMAL
	caliber = ".45"
	silenced = 1
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2, TECH_ILLEGAL = 8)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/c45m
	allowed_magazines = /obj/item/ammo_magazine/c45m

/obj/item/gun/projectile/pistol/gyropistol
	name = "prototype pistol"
	desc = "A bulky foundation prototype pistol designed to fire self propelled rounds."
	icon = 'icons/obj/gun.dmi'
	icon_state = "gyropistol"
	max_shells = 8
	caliber = "20mmG"
	origin_tech = list(TECH_COMBAT = 3)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/gyro
	allowed_magazines = /obj/item/ammo_magazine/gyro
	fire_delay = 25
	slot_flags = SLOT_BELT
	auto_eject = 1
	auto_eject_sound = 'sound/weapons/smg_empty_alarm.ogg'

/obj/item/gun/projectile/pistol/gyropistol/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "gyropistolloaded"
	else
		icon_state = "gyropistol"

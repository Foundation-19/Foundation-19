/obj/item/gun/projectile/shotgun/tactical
	name = "combat shotgun"
	desc = "A pump action shotgun"
	icon_state = "tac_shotgun"
	item_state = "cshotgun"
	caliber = CALIBER_SHOTGUN
	load_method = SINGLE_CASING|SPEEDLOADER
	max_shells = 7
	w_class = ITEM_SIZE_HUGE
	force = 10
	obj_flags =  OBJ_FLAG_CONDUCTIBLE
	slot_flags = SLOT_BACK
	origin_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 1)
	ammo_type = /obj/item/ammo_casing/shotgun
	one_hand_penalty = 2
	wielded_item_state = "gun_wielded"

	burst_delay = 0

/obj/item/gun/projectile/shotgun/tactical/beanbag
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag

/obj/item/gun/projectile/revolver/mateba
	name = "mateba"
	desc = "Standard issue Foundation revolver based on the Mateba Unica. Chambered in .44 Magnum"
	icon = 'icons/obj/gun.dmi'
	icon_state = "mateba"
	caliber = ".44"
	fire_delay = 6
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)
	ammo_type = /obj/item/ammo_casing/pistol/a50
	handle_casings = CYCLE_CASINGS

/obj/item/gun/projectile/revolver/rhino
	name = "rhino"
	desc = "Standard issue Foundation revolver based on the Chiappa Rhino. Chambered in .357 magnum"
	icon = 'icons/obj/gun.dmi'
	icon_state = "rhino"
	caliber = ".357"
	fire_delay = 4
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)
	ammo_type = /obj/item/ammo_casing/pistol/a357
	handle_casings = CYCLE_CASINGS

/obj/item/gun/projectile/silenced
	name = "silenced pistol"
	desc = "A handgun with an integral silencer. Uses .45 rounds."
	icon = 'icons/obj/gun.dmi'
	icon_state = "silenced_pistol"
	w_class = ITEM_SIZE_NORMAL
	caliber = ".45 ACP"
	silenced = 1
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2, TECH_ESOTERIC = 8)
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
	magazine_type = /obj/item/ammo_magazine/gyrojet
	allowed_magazines = /obj/item/ammo_magazine/gyrojet
	fire_delay = 25
	slot_flags = SLOT_BELT
	auto_eject = 1
	auto_eject_sound = 'sounds/weapons/smg_empty_alarm.ogg'

/obj/item/gun/projectile/pistol/gyropistol/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "gyropistolloaded"
	else
		icon_state = "gyropistol"

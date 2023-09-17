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

/obj/item/gun/projectile/pistol/mk9
	name = "MK9 Foundation pistol"
	desc = "Standard issue 9mm pistol of the SCP Foundation. Based on the HK VP9."
	icon = 'icons/obj/gun.dmi'
	icon_state = "MK9"
	w_class = ITEM_SIZE_NORMAL
	caliber = "9mm"
	silenced = 0
	fire_delay = 2
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2, TECH_ESOTERIC = 2)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/scp/mk9
	allowed_magazines = list(/obj/item/ammo_magazine/scp/mk9, /obj/item/ammo_magazine/scp/mk9/rubber)

/obj/item/gun/projectile/pistol/mk9/on_update_icon()
	..()
	if(ammo_magazine)
		icon_state = "[initial(icon_state)][length(ammo_magazine.stored_ammo) ? "" : "_0"]"
	else
		icon_state = "[initial(icon_state)]-e"


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
	caliber = ".45"
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

/obj/item/gun/projectile/pistol/m1911
	name = "M1911"
	desc = "A classic Model 1911 pistol. Still effective even today, generally used as a surplus sidearm for Foundation security staff."
	icon = 'icons/obj/gun.dmi'
	icon_state = "colt"
	w_class = ITEM_SIZE_NORMAL
	caliber = ".45"
	silenced = 0
	fire_delay = 3
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2, TECH_ESOTERIC = 2)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/scp/m1911
	allowed_magazines = list(/obj/item/ammo_magazine/scp/m1911)

/obj/item/gun/projectile/pistol/usp45
	name = "USP45"
	desc = "Sidearm assigned to certain operatives and guards of the Foundation. Chambered in .45ACP."
	icon = 'icons/obj/gun.dmi'
	icon_state = "usp"
	w_class = ITEM_SIZE_NORMAL
	caliber = ".45"
	silenced = 0
	fire_delay = 3
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2, TECH_ESOTERIC = 2)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/scp/usp45
	allowed_magazines = list(/obj/item/ammo_magazine/scp/usp45)

/obj/item/gun/projectile/automatic/scp/saiga12
	name = "Saiga12 Tactical Shotgun"
	desc = "A reliable russian-made semi automatic shotgun often used by Foundation strike and security forces."
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

	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0, one_hand_penalty=2, burst_accuracy=null, dispersion=null))


/obj/item/gun/projectile/automatic/scp/saiga12/beanbag
	magazine_type = /obj/item/ammo_magazine/scp/saiga12/beanbag


/obj/item/gun/projectile/automatic/scp/saiga12/buckshot
	magazine_type = /obj/item/ammo_magazine/scp/saiga12/buckshot

/obj/item/gun/projectile/automatic/scp/saiga12/stunshell
	magazine_type = /obj/item/ammo_magazine/scp/saiga12/stunshell

/obj/item/gun/projectile/automatic/scp/saiga12/rubbershot
	magazine_type = /obj/item/ammo_magazine/scp/saiga12/rubbershot

/obj/item/gun/projectile/automatic/scp/saiga12/flash
	magazine_type = /obj/item/ammo_magazine/scp/saiga12/flash

/obj/item/gun/projectile/automatic/scp/saiga12/emp
	magazine_type = /obj/item/ammo_magazine/scp/saiga12/emp


/obj/item/gun/projectile/automatic/scp/saiga12/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "saiga12"
	else
		icon_state = "saiga12-empty"
	return

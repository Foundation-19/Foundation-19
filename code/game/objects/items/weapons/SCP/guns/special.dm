/obj/item/gun/projectile/scp/revolver/doublebarrel_shotgun
	name = "double-barreled shotgun"
	desc = "A true classic."
	icon = 'icons/SCP/guns/pistols/sw27.dmi'
	icon_state = "s&w27"
	item_state = "revolver"
	caliber = "12g"
	max_shells = 2
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	fire_sound = 'sound/weapons/guns/revolvers/fire_revolver1.ogg'
	w_class = ITEM_SIZE_HUGE
	obj_flags =  OBJ_FLAG_CONDUCTIBLE
	slot_flags = SLOT_BACK
	one_hand_penalty = 2

/obj/item/gun/projectile/shotgun/doublebarrel

	//SPEEDLOADER because rapid unloading.
	//In principle someone could make a speedloader for it, so it makes sense.
	load_method = SINGLE_CASING|SPEEDLOADER
	handle_casings = CYCLE_CASINGS
	max_shells = 2
	w_class = ITEM_SIZE_HUGE
	force = 10
	obj_flags =  OBJ_FLAG_CONDUCTIBLE
	slot_flags = SLOT_BACK
	caliber = CALIBER_SHOTGUN
	origin_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 1)
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag
	one_hand_penalty = 2
	wielded_item_state = "gun_wielded"

	burst_delay = 0
	firemodes = list(
		list(mode_name="fire one barrel at a time", burst=1),
		list(mode_name="fire both barrels at once", burst=2),
		)

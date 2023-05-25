/obj/item/gun/projectile/scp/shotgun
	w_class = ITEM_SIZE_HUGE
	force = 10
	obj_flags =  OBJ_FLAG_CONDUCTIBLE
	slot_flags = SLOT_BACK
	caliber = CALIBER_SHOTGUN
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 2)
	load_method = SINGLE_CASING
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	handle_casings = HOLD_CASINGS
	one_hand_penalty = 8
	bulk = 6

	bolt_back_sound = 'sound/weapons/guns/shotguns/pump_back.ogg'
	bolt_forward_sound = 'sound/weapons/guns/shotguns/pump_forward.ogg'
	fire_sound = 'sound/weapons/guns/shotguns/shoot.ogg'
	has_bolt_icon = TRUE
	stock_icon = "stock"
	foreend_icon = "fore-end"
	foreend_offset = 18
	bolt_hold = TRUE
	manual_action = TRUE

/obj/item/gun/projectile/scp/shotgun/rem870
	name = "\improper Remington 870"
	desc = "The mass-produced Remington 870 shotgun is a favourite of police and security forces. Useful for sweeping alleys."
	icon = 'icons/SCP/guns/shotguns/rem870.dmi'
	icon_state = "rem870"
	item_state = "shotgun"
	max_shells = 4
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag
	load_sound = SFX_REM870_SHELL_INSERT

/obj/item/gun/projectile/scp/shotgun/spas12
	name = "\improper SPAS-12"
	desc = "An automatic combat shotgun, manufactured by Italian firearms company Franchi. This one has stock detached."
	icon = 'icons/SCP/guns/shotguns/spas12.dmi'
	icon_state = "spas12"
	item_state = "spas12"
	max_shells = 7
	bolt_back_sound = 'sound/weapons/guns/shotguns/spas12_back.ogg'
	bolt_forward_sound = 'sound/weapons/guns/shotguns/spas12_forward.ogg'
	ammo_type = /obj/item/ammo_casing/shotgun
	load_sound = SFX_SPAS12_SHELL_INSERT
	manual_action = FALSE
	stock_icon = null
	foreend_icon = null

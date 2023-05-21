/obj/item/gun/projectile/scp/pistol/mk9
	name = "MK9 Foundation pistol"
	desc = "Standard issue 9mm pistol of the SCP Foundation. Based on the HK VP9."
	icon = 'icons/SCP/guns/pistols/mk9.dmi'
	icon_state = "mk9"
	w_class = ITEM_SIZE_NORMAL
	caliber = "9mm"
	silenced = 0
	fire_delay = 2
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2, TECH_ESOTERIC = 2)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/scp/mk9
	allowed_magazines = list(/obj/item/ammo_magazine/scp/mk9)

	action_type = GUN_DOUBLE_ACTION
	bolt_back_sound = 'sound/weapons/guns/pistol/grach_bolt_back.ogg'
	bolt_forward_sound = 'sound/weapons/guns/pistol/grach_bolt_forward.ogg'
	has_bolt_icon = TRUE
	bolt_hold = TRUE
	bolt_hold_on_empty_mag = TRUE

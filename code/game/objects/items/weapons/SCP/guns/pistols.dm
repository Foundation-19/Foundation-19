/obj/item/gun/projectile/pistol/mk9
	name = "MK9 Foundation pistol"
	desc = "Standard issue 9mm pistol of the SCP Foundation. Based on the HK VP9."
	icon = 'icons/SCP/guns/pistols/mk9.dmi'
	icon_state = "MK9"
	w_class = ITEM_SIZE_NORMAL
	caliber = "9mm"
	silenced = 0
	fire_delay = 2
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2, TECH_ESOTERIC = 2)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/scp/mk9
	allowed_magazines = list(/obj/item/ammo_magazine/scp/mk9)

/obj/item/gun/projectile/pistol/mk9/on_update_icon()
	..()
	if(ammo_magazine)
		icon_state = "[initial(icon_state)][length(ammo_magazine.stored_ammo) ? "" : "_0"]"
	else
		icon_state = "[initial(icon_state)]-e"

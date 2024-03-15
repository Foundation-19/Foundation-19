/obj/item/gun/projectile/rocket_launcher
	name = "rocket launcher"
	desc = "A fairly simple rocket launcher capable of holding one rocket at a time."
	icon = 'icons/obj/guns/launchers.dmi'
	icon_state = "m5"
	item_state = "m5"
	w_class = ITEM_SIZE_LARGE
	slot_flags = SLOT_BACK
	obj_flags = 0

	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 4)
	matter = list(MATERIAL_STEEL = 4000)

	ammo_type = /obj/item/ammo_casing/rocket
	caliber = CALIBER_ROCKET
	load_method = SINGLE_CASING
	max_shells = 1
	starts_loaded = FALSE
	load_sound = 'sounds/weapons/guns/interaction/launcher_reload.ogg'

/obj/item/gun/projectile/rocket_launcher/handle_click_empty()
	. = ..()
	playsound(loc, 'sounds/weapons/gunshot/launcher_empty.ogg', 50, 1)

/obj/item/gun/projectile/rocket_launcher/examine(mob/user, distance)
	. = ..()
	if(distance <= 2 && loaded.len)
		to_chat(user, "\A [loaded[1]] is chambered.")

/obj/item/gun/projectile/rocket_launcher/loaded
	starts_loaded = TRUE

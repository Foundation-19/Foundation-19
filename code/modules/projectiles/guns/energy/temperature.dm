/obj/item/gun/energy/temperature
	name = "temperature gun"
	icon = 'icons/obj/guns/freezegun.dmi'
	icon_state = "freezegun"
	item_state = "freezegun"
	fire_sound = 'sound/weapons/pulse3.ogg'
	desc = "A gun that fires projectiles that can adjust target's temperature. Can fire heat and freeze beams."
	charge_cost = 20
	origin_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 4, TECH_POWER = 3, TECH_MAGNET = 2)
	slot_flags = SLOT_BELT|SLOT_BACK
	one_hand_penalty = 2
	fire_delay = 4
	wielded_item_state = "gun_wielded"

	projectile_type = /obj/item/projectile/temp
	cell_type = /obj/item/cell/high
	combustion = 0

	firemodes = list(
		list(mode_name="freeze",   projectile_type = /obj/item/projectile/temp),
		list(mode_name="heat",  projectile_type = /obj/item/projectile/temp/heat)
		)

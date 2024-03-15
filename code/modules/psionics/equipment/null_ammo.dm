/obj/item/projectile/revolver/medium/nullglass
	name = "nullglass bullet"
	shrapnel_type = /obj/item/material/shard/nullglass

/obj/item/projectile/revolver/medium/nullglass/on_hit(atom/target, blocked = 0, def_zone = null)
	. = ..()
	var/mob/living/L = target
	if(L.psi)
		L.psi.stamina = max(0, L.psi.stamina - rand(15,20))
		to_chat(L, SPAN_DANGER("You feel your psi-power leeched away by \the [src]..."))

/obj/item/ammo_casing/revolver/medium/nullglass
	desc = "A revolver bullet casing with a nullglass coating."
	projectile_type = /obj/item/projectile/revolver/medium/nullglass

/obj/item/ammo_casing/revolver/medium/nullglass/disrupts_psionics()
	return src

/obj/item/ammo_magazine/speedloader/medium/nullglass
	ammo_type = /obj/item/ammo_casing/revolver/medium/nullglass



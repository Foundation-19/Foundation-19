// Rod for railguns. Slightly less nasty than the sniper round.
/obj/item/projectile/bullet/magnetic
	name = "rod"
	icon_state = "rod"
	damage = 65
	penetrating = 5
	armor_penetration = 85
	penetration_modifier = 1.1
	fire_sound = 'sounds/weapons/railgun.ogg'
	distance_falloff = 1

/obj/item/projectile/bullet/magnetic/slug
	name = "slug"
	icon_state = "gauss_silenced"
	stun = 1
	damage = 100
	armor_penetration = 90

/obj/item/projectile/bullet/magnetic/flechette
	name = "flechette"
	icon_state = "flechette"
	damage = 50
	armor_penetration = 100
	fire_sound = 'sounds/weapons/rapidslice.ogg'
	distance_falloff = 0.5

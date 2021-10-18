/obj/item/ammo_magazine/scp/ierichon
	name = "Jericho-114 magazine (.45)"
	icon_state = "9mmds"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/c45
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = ".45"
	max_ammo = 20
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/ierichon/rubber
	name = "Jericho-114 rubber magazine (.45)"
	icon_state = "R9mmds"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/c45/rubber
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = ".45"
	max_ammo = 20
	multiple_sprites = 1

	/obj/item/ammo_magazine/scp/p90_mag
	name = "magazine (5.7x28mm)"
	icon_state = "p90"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = "10mm"
	matter = list(DEFAULT_WALL_MATERIAL = 1500)
	ammo_type = /obj/item/ammo_casing/a10mm
	max_ammo = 50
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/p90_mag/empty
	initial_ammo = 0

/obj/item/ammo_magazine/scp/p90_mag/ap
	name = "magazine (5.7x28mm AP)"
	icon_state = "p90ap"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = "10mm"
	matter = list(DEFAULT_WALL_MATERIAL = 1500)
	ammo_type = /obj/item/ammo_casing/ap10mm
	max_ammo = 50
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/p90_mag/rubber
	name = "magazine (5.7x28mm rubber)"
	icon_state = "p90r"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = "10mm"
	matter = list(DEFAULT_WALL_MATERIAL = 1500)
	ammo_type = /obj/item/ammo_casing/rub10mm
	max_ammo = 50
	multiple_sprites = 1
	
/obj/item/ammo_magazine/scp/m16_mag
	name = "magazine (5.56)"
	icon_state = "m16"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = "a556"
	matter = list(DEFAULT_WALL_MATERIAL = 1500)
	ammo_type = /obj/item/ammo_casing/a556
	max_ammo = 30
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/m16_mag/empty
	initial_ammo = 0

/obj/item/ammo_magazine/scp/ak
	name = "magazine (7.62)"
	icon_state = "7.62x39mm"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = "a762"
	matter = list(DEFAULT_WALL_MATERIAL = 1500)
	ammo_type = /obj/item/ammo_casing/a762
	max_ammo = 30
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/ak/big
	name = "big magazine (7.62)"
	icon_state = "7.62x39mm2"
	max_ammo = 45
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/svd
	name = "magazine (7.62)"
	icon_state = "7.62x54s"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = "a762"
	matter = list(DEFAULT_WALL_MATERIAL = 1500)
	ammo_type = /obj/item/ammo_casing/a762
	max_ammo = 10
	multiple_sprites = 1

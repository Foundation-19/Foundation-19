/obj/item/ammo_magazine/scp
	icon = 'icons/obj/ammo.dmi'

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

/obj/item/ammo_magazine/scp
	name = "MK3 magazine"
	icon_state = "45"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/c9mm
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = "9mm"
	max_ammo = 10
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/mk9
	name = "MK9 magazine"
	icon_state = "9mmds"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/c45
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = "9mm"
	max_ammo = 14
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/mk9/rubber
	name = "MK9 rubber magazine"
	icon_state = "R9mmds"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/c45/rubber
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = "9mm"
	max_ammo = 14
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


/obj/item/ammo_magazine/a762
	name = "magazine (7.62mm)"
	icon_state = "5.56"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = "a762"
	matter = list(DEFAULT_WALL_MATERIAL = 1800)
	ammo_type = /obj/item/ammo_casing/a762
	max_ammo = 15 //if we lived in a world where normal mags had 30 rounds, this would be a 20 round mag
	multiple_sprites = 1

/obj/item/ammo_magazine/a762/empty
	initial_ammo = 0

/obj/item/ammo_magazine/a762/practice
	name = "magazine (7.62mm, practice)"
	ammo_type = /obj/item/ammo_casing/a762/practice

// BOXES //

// 9mm
/obj/item/ammo_magazine/box/mk9
	name = "ammunition box"
	icon_state = "9mm"
	origin_tech = list(TECH_COMBAT = 2)
	caliber = "9mm"
	matter = list(DEFAULT_WALL_MATERIAL = 2250)
	ammo_type = /obj/item/ammo_casing/c9mm
	max_ammo = 100


// 10mm
/obj/item/ammo_magazine/box/a10mm
	name = "ammunition box (5.7 x 28 mm)"
	icon_state = "usmc_box"
	origin_tech = list(TECH_COMBAT = 2)
	caliber = "10mm"
	matter = list(DEFAULT_WALL_MATERIAL = 2250)
	ammo_type = /obj/item/ammo_casing/a10mm
	max_ammo = 50
	multiple_sprites = 1

// 5.56
/obj/item/ammo_magazine/box/a556
	name = "magazine box (5.56mm)"
	icon_state = "a762"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = "a556"
	matter = list(DEFAULT_WALL_MATERIAL = 4500)
	ammo_type = /obj/item/ammo_casing/a556
	max_ammo = 100
	multiple_sprites = 1

// 7.62
/obj/item/ammo_magazine/box/a762
	name = "ammunition box (7.62)"
	icon_state = "csla_box"
	origin_tech = list(TECH_COMBAT = 2)
	caliber = "a762"
	matter = list(DEFAULT_WALL_MATERIAL = 2250)
	ammo_type = /obj/item/ammo_casing/a762
	max_ammo = 100
	multiple_sprites = 1



/* MTF AMMO STUFFS */
/obj/item/storage/box/mtf/pelletammo
	name = "pellet ammunition"
	desc = "Contains pellet ammunition for a shotgun."
	startswith = list(/obj/item/ammo_casing/shotgun/pellet = 7)

/obj/item/storage/box/mtf/empammo
	name = "emp ammunition"
	desc = "Contains EMP ammunition for a shotgun."
	startswith = list(/obj/item/ammo_casing/shotgun/emp = 7)

/obj/item/storage/box/mtf/beanbag
	name = "non-lethal ammunition"
	desc = "Contains beanbag ammunition for a shotgun."
	startswith = list(/obj/item/ammo_casing/shotgun/beanbag = 7)

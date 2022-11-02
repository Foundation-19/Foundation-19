/obj/item/ammo_magazine/a10mm/empty
	initial_ammo = 0

/obj/item/ammo_magazine/a10mm/rubber
	name = "magazine (10mm rubber)"
	icon_state = "10mm"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = "10mm"
	matter = list(DEFAULT_WALL_MATERIAL = 1500)
	ammo_type = /obj/item/ammo_casing/rub10mm
	max_ammo = 20
	multiple_sprites = 1

/obj/item/ammo_magazine/a10mm/ap10mm
	name = "magazine (10mm armor piercing)"
	icon_state = "10mm"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = "10mm"
	matter = list(DEFAULT_WALL_MATERIAL = 1500)
	ammo_type = /obj/item/ammo_casing/ap10mm
	max_ammo = 20
	multiple_sprites = 1

/obj/item/ammo_magazine/a10mm/hp10mm
	name = "magazine (10mm hollowpoint)"
	icon_state = "10mm"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = "10mm"
	matter = list(DEFAULT_WALL_MATERIAL = 1500)
	ammo_type = /obj/item/ammo_casing/h10mm
	max_ammo = 20
	multiple_sprites = 1

/obj/item/ammo_magazine/a10mm/sc10mm
	name = "magazine (10mm silver crescent)"
	icon_state = "10mm"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = "10mm"
	matter = list(DEFAULT_WALL_MATERIAL = 1500)
	ammo_type = /obj/item/ammo_casing/sc10mm
	max_ammo = 20
	multiple_sprites = 1

/obj/item/ammo_magazine/scp
	name = "MK3 magazine"
	icon_state = "9x19p"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/c9mm
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = "9mm"
	max_ammo = 10
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/glock17
	name = "G17 magazine"
	icon_state = "glock17"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/c9mm
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = "9mm"
	max_ammo = 17
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/mk9
	name = "MK9 magazine"
	icon_state = "9mmds"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/c9mm
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = "9mm"
	max_ammo = 17
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/mk9/rubber
	name = "MK9 rubber magazine"
	icon_state = "R9mmds"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/c9mm/rubber
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = "9mm"
	max_ammo = 17
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

/obj/item/ammo_magazine/scp/m16_magext
	name = "magazine (5.56)"
	icon_state = "m16"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = "a556"
	matter = list(DEFAULT_WALL_MATERIAL = 1500)
	ammo_type = /obj/item/ammo_casing/a556
	max_ammo = 60
	multiple_sprites = 1

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

/obj/item/ammo_magazine/scp/fnfal
	name = "magazine (7.62x51 NATO)"
	icon_state = "7.62x54s"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = "a762nato"
	matter = list(DEFAULT_WALL_MATERIAL = 1500)
	ammo_type = /obj/item/ammo_casing/a762nato
	max_ammo = 20
	multiple_sprites = 1


/obj/item/ammo_magazine/scp/vectormag
	name = "magazine (Extended .45ACP)"
	icon_state = "4mm"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = ".45"
	matter = list(DEFAULT_WALL_MATERIAL = 1500)
	ammo_type = /obj/item/ammo_casing/c45
	max_ammo = 30
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/usp45
	name = "USP .45ACP Magazine"
	icon_state = "magnum"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/c45
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = ".45"
	max_ammo = 12
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/m1911
	name = "M1911 Colt Magazine (.45ACP)"
	icon_state = "45"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/c45
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = ".45"
	max_ammo = 7
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/mp5mag
	name = "MP5 Magazine"
	icon_state = "mp5"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/c9mm
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = "9mm"
	max_ammo = 30
	multiple_sprites = 1


/obj/item/ammo_magazine/scp/ar12
	name = "AR12 Magazine (Slug)"
	icon_state = "fal-0"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/shotgun
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = CALIBER_SHOTGUN
	max_ammo = 12


/obj/item/ammo_magazine/scp/ar12/beanbag
	name = "AR12 Magazine (Beanbag)"
	icon_state = "fal-0"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = CALIBER_SHOTGUN
	max_ammo = 12


/obj/item/ammo_magazine/scp/ar12/buckshot
	name = "AR12 Magazine (Buckshot)"
	icon_state = "fal-0"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/shotgun/pellet
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = CALIBER_SHOTGUN
	max_ammo = 12


/obj/item/ammo_magazine/scp/m60
	name = "LMG Box Magazine (5.56)"
	icon_state = "b762x54"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = "a556"
	matter = list(DEFAULT_WALL_MATERIAL = 1500)
	ammo_type = /obj/item/ammo_casing/a556
	max_ammo = 100
	multiple_sprites = 1
	w_class = ITEM_SIZE_LARGE

/obj/item/ammo_magazine/scp/m60/empty
	initial_ammo = 0




/obj/item/ammo_magazine/scp/saiga12
	name = "Saiga12 Magazine (Slug)"
	icon_state = "saiga12"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/shotgun
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = CALIBER_SHOTGUN
	max_ammo = 8


/obj/item/ammo_magazine/scp/saiga12/beanbag
	name = "Saiga12 Magazine (Beanbag)"
	icon_state = "saiga12-beanbag"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = CALIBER_SHOTGUN
	max_ammo = 8

/obj/item/ammo_magazine/scp/saiga12/buckshot
	name = "Saiga12 Magazine (Buckshot)"
	icon_state = "saiga12-buckshot"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/shotgun/pellet
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = CALIBER_SHOTGUN
	max_ammo = 8

/obj/item/ammo_magazine/scp/saiga12/stunshell
	name = "Saiga12 Magazine (Stunshell)"
	icon_state = "saiga12-stunshell"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/shotgun/stunshell
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = CALIBER_SHOTGUN
	max_ammo = 8


/obj/item/ammo_magazine/scp/saiga12/flash
	name = "Saiga12 Magazine (Crowd Dispersing Flash)"
	icon_state = "saiga12-flash"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/shotgun/flash
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = CALIBER_SHOTGUN
	max_ammo = 8

/obj/item/ammo_magazine/scp/saiga12/rubbershot
	name = "Saiga12 Magazine (Rubbershot)"
	icon_state = "saiga12-rubbershot"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/shotgun/rubbershot
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = CALIBER_SHOTGUN
	max_ammo = 8

/obj/item/ammo_magazine/scp/saiga12/emp
	name = "Saiga12 Magazine (EMP Haywire)"
	icon_state = "saiga12-emp"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/shotgun/emp
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = CALIBER_SHOTGUN
	max_ammo = 8

/obj/item/ammo_magazine/scp/saiga12/empty
	initial_ammo = 0


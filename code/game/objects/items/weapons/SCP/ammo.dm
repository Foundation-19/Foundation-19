/obj/item/ammo_magazine/scp
	icon = 'icons/obj/ammo.dmi'
	name = "MK3 magazine"
	icon_state = "45"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/pistol/c9mm
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = "9mm"
	max_ammo = 10
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/ierichon
	name = "Jericho-114 magazine (.45)"
	icon_state = "9mmds"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/pistol/c45
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = ".45"
	max_ammo = 20
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/ierichon/rubber
	name = "Jericho-114 magazine (.45 rubber)"
	icon_state = "R9mmds"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/pistol/c45/rubber
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = ".45"
	max_ammo = 20
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/mk9
	name = "MK9 magazine (9mm)"
	icon_state = "9mmds"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/pistol/c9mm
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = "9mm"
	max_ammo = 17
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/mk9/rubber
	name = "MK9 magazine (9mm rubber)"
	icon_state = "R9mmds"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/pistol/c9mm/rubber
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = "9mm"
	max_ammo = 17
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/p90_mag
	name = "magazine (5.7x28mm)"
	icon_state = "p90"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = "5.7x28mm"
	matter = list(DEFAULT_WALL_MATERIAL = 1500)
	ammo_type = /obj/item/ammo_casing/pistol/a57
	max_ammo = 50
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/p90_mag/empty
	initial_ammo = 0

/obj/item/ammo_magazine/scp/p90_mag/ap
	name = "magazine (5.7x28mm AP)"
	icon_state = "p90ap"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = "5.7x28mm"
	matter = list(DEFAULT_WALL_MATERIAL = 1500)
	ammo_type = /obj/item/ammo_casing/pistol/a57/ap
	max_ammo = 50
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/p90_mag/rubber
	name = "magazine (5.7x28mm rubber)"
	icon_state = "p90r"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = "5.7x28mm"
	matter = list(DEFAULT_WALL_MATERIAL = 1500)
	ammo_type = /obj/item/ammo_casing/pistol/a57/rubber
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

/obj/item/ammo_magazine/scp/m16_mag/ext
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
	name = "ammunition box (9mm)"
	icon_state = "9mm"
	origin_tech = list(TECH_COMBAT = 2)
	caliber = "9mm"
	matter = list(DEFAULT_WALL_MATERIAL = 2250)
	ammo_type = /obj/item/ammo_casing/pistol/c9mm
	max_ammo = 100


// .357
/obj/item/ammo_magazine/box/a357
	name = "ammunition box (357)"
	icon_state = "357"
	origin_tech = list(TECH_COMBAT = 2)
	caliber = ".357"
	matter = list(DEFAULT_WALL_MATERIAL = 2250)
	ammo_type = /obj/item/ammo_casing/pistol/a357
	max_ammo = 60

// 45acp
/obj/item/ammo_magazine/box/a45
	name = "ammunition box (.45acp)"
	icon_state = "ammobox"
	origin_tech = list(TECH_COMBAT = 2)
	caliber = ".45"
	matter = list(DEFAULT_WALL_MATERIAL = 2250)
	ammo_type = /obj/item/ammo_casing/pistol/c45
	max_ammo = 100

/obj/item/ammo_magazine/box/a50
	name = "ammunition box (.44 magnum)"
	icon_state = "357"
	origin_tech = list(TECH_COMBAT = 2)
	caliber = ".44"
	matter = list(DEFAULT_WALL_MATERIAL = 2250)
	ammo_type = /obj/item/ammo_casing/pistol/a50
	max_ammo = 60

// 10mm
/obj/item/ammo_magazine/box/a10mm
	name = "ammunition box (5.7x28mm)"
	icon_state = "usmc_box"
	origin_tech = list(TECH_COMBAT = 2)
	caliber = "10mm"
	matter = list(DEFAULT_WALL_MATERIAL = 2250)
	ammo_type = /obj/item/ammo_casing/pistol/a57
	max_ammo = 200
	multiple_sprites = 1

// 5.56
/obj/item/ammo_magazine/box/a556
	name = "magazine box (5.56mm)"
	icon_state = "usmc_box"
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

// shotgun
/obj/item/ammo_magazine/box/buckshot
	name = "ammunition box (Buckshot)"
	icon_state = "ammobox"
	origin_tech = list(TECH_COMBAT = 2)
	caliber = CALIBER_SHOTGUN
	matter = list(DEFAULT_WALL_MATERIAL = 2250)
	ammo_type = /obj/item/ammo_casing/shotgun/pellet
	max_ammo = 30


/obj/item/ammo_magazine/box/slug
	name = "ammunition box (Slug)"
	icon_state = "ammobox"
	origin_tech = list(TECH_COMBAT = 2)
	caliber = CALIBER_SHOTGUN
	matter = list(DEFAULT_WALL_MATERIAL = 2250)
	ammo_type = /obj/item/ammo_casing/shotgun
	max_ammo = 30


/obj/item/ammo_magazine/box/beanbag
	name = "ammunition box (Beanbag)"
	icon_state = "ammobox"
	origin_tech = list(TECH_COMBAT = 2)
	caliber = CALIBER_SHOTGUN
	matter = list(DEFAULT_WALL_MATERIAL = 2250)
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag
	max_ammo = 30

/obj/item/ammo_magazine/box/rubbershot
	name = "ammunition box (Rubbershot)"
	icon_state = "ammobox"
	origin_tech = list(TECH_COMBAT = 2)
	caliber = CALIBER_SHOTGUN
	matter = list(DEFAULT_WALL_MATERIAL = 2250)
	ammo_type = /obj/item/ammo_casing/shotgun/rubbershot
	max_ammo = 30

/obj/item/ammo_magazine/box/stunshell
	name = "ammunition box (Stunshell)"
	icon_state = "ammobox"
	origin_tech = list(TECH_COMBAT = 2)
	caliber = CALIBER_SHOTGUN
	matter = list(DEFAULT_WALL_MATERIAL = 2250)
	ammo_type = /obj/item/ammo_casing/shotgun/stunshell
	max_ammo = 30

/obj/item/ammo_magazine/box/flash
	name = "ammunition box (Flash)"
	icon_state = "ammobox"
	origin_tech = list(TECH_COMBAT = 2)
	caliber = CALIBER_SHOTGUN
	matter = list(DEFAULT_WALL_MATERIAL = 2250)
	ammo_type = /obj/item/ammo_casing/shotgun/flash
	max_ammo = 30

/obj/item/ammo_magazine/box/emp
	name = "ammunition box (EMP)"
	icon_state = "ammobox"
	origin_tech = list(TECH_COMBAT = 2)
	caliber = CALIBER_SHOTGUN
	matter = list(DEFAULT_WALL_MATERIAL = 2250)
	ammo_type = /obj/item/ammo_casing/shotgun/emp
	max_ammo = 30


// 45acp
/obj/item/ammo_magazine/box/acp45
	name = "ammunition box (.45)"
	icon_state = "ammobox"
	origin_tech = list(TECH_COMBAT = 2)
	caliber = ".45"
	matter = list(DEFAULT_WALL_MATERIAL = 2250)
	ammo_type = /obj/item/ammo_casing/pistol/c45
	max_ammo = 100



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

/obj/item/ammo_magazine/scp/vectormag
	name = "magazine (Extended .45ACP)"
	icon_state = "4mm"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = ".45"
	matter = list(DEFAULT_WALL_MATERIAL = 1500)
	ammo_type = /obj/item/ammo_casing/pistol/c45
	max_ammo = 30
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/usp45
	name = "USP .45ACP Magazine"
	icon_state = "magnum"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/pistol/c45
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = ".45"
	max_ammo = 12
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/m1911
	name = "M1911 Colt Magazine (.45ACP)"
	icon_state = "45"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/pistol/c45
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = ".45"
	max_ammo = 7
	multiple_sprites = 1

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


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


/* AMMO 7.62 ROUNDS*/
/obj/item/ammo_magazine/box/a762
	name = "ammunition box (7.62)"
	icon_state = "csla_box"
	origin_tech = list(TECH_COMBAT = 2)
	caliber = "a762"
	matter = list(DEFAULT_WALL_MATERIAL = 2250)
	ammo_type = /obj/item/ammo_casing/a762
	max_ammo = 150
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

/* Ammo Casing */

/obj/item/ammo_casing/a762
	desc = "A 7.62mm bullet casing."
	caliber = "a762"
	projectile_type = /obj/item/projectile/bullet/rifle/a762
	icon_state = "rifle-casing"
	spent_icon = "rifle-casing-spent"

/obj/item/ammo_casing/a762/practice
	desc = "A 7.62mm practice bullet casing."
	projectile_type = /obj/item/projectile/bullet/rifle/a762/practice

/obj/item/ammo_casing/a556
	desc = "A 5.56mm bullet casing."
	caliber = "a556"
	projectile_type = /obj/item/projectile/bullet/rifle/a556
	icon_state = "rifle-casing"
	spent_icon = "rifle-casing-spent"

/obj/item/ammo_casing/a10mm
	desc = "A 5.7x28mm bullet casing."
	caliber = "10mm"
	projectile_type = /obj/item/projectile/bullet/pistol/medium/smg

/obj/item/ammo_casing/rub10mm
	desc = "A rubber 10mm bullet casing."
	caliber = "10mm"
	projectile_type = /obj/item/projectile/bullet/pistol/medium/smg/rubber
	icon_state = "10mm-hollowpoint"
	spent_icon = "r-casing-spent"

/obj/item/ammo_casing/ap10mm
	desc = "A armor piercing 10mm bullet casing."
	caliber = "10mm"
	projectile_type = /obj/item/projectile/bullet/pistol/medium/smg/ap
	icon_state = "10mm-hardentry"
	spent_icon = "r-casing-spent" //temporary until the spriters make a better spent case

/obj/item/ammo_casing/c45
	desc = "A .45 bullet casing."
	caliber = ".45"
	projectile_type = /obj/item/projectile/bullet/pistol/medium

/obj/item/ammo_casing/c45/practice
	desc = "A .45 practice bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/practice

/obj/item/ammo_casing/c45/rubber
	desc = "A .45 rubber bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/rubber
	icon_state = "r-casing"
	spent_icon = "r-casing-spent"

/obj/item/ammo_casing/c45/flash
	desc = "A .45 flash shell casing."
	projectile_type = /obj/item/projectile/energy/flash


/* Bullets */

/obj/item/projectile/bullet/rifle/a556
	fire_sound = 'sound/weapons/gunshot/gunshot3.ogg'
	damage = 50
	armor_penetration = 35
	agony = 25

/obj/item/projectile/bullet/rifle/a762
	fire_sound = 'sound/weapons/gunshot/gunshot2.ogg'
	damage = 60
	armor_penetration = 40
	agony = 25

/obj/item/projectile/bullet/pistol/medium/smg
	fire_sound = 'sound/weapons/gunshot/gunshot_smg.ogg'
	damage = 30 //10mm/5.7x28
	armor_penetration = 35
	agony = 15

/obj/item/projectile/bullet/pistol/medium/smg/rubber
	fire_sound = 'sound/weapons/gunshot/gunshot_smg.ogg'
	damage = 0.5 //10mm rubber
	armor_penetration = 12
	agony = 35
	embed = 0
	sharp = 0

/obj/item/projectile/bullet/pistol/medium/smg/hollowpoint
	fire_sound = 'sound/weapons/gunshot/gunshot_smg.ogg'
	damage = 45 //10mm hollowpoint
	armor_penetration = 5
	agony = 20

/obj/item/projectile/bullet/pistol/medium/smg/ap
	fire_sound = 'sound/weapons/gunshot/gunshot_smg.ogg'
	damage = 22.5 //10mm AP
	armor_penetration = 65
	agony = 10

/obj/item/projectile/bullet/rifle/a762/practice
	damage = 5

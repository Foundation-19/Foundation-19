

/obj/item/ammo_magazine/c38
	name = "speed loader (.38)"
	desc = "A speed loader for revolvers."
	icon_state = "38"
	caliber = "38"
	matter = list(DEFAULT_WALL_MATERIAL = 360)
	ammo_type = /obj/item/ammo_casing/pistol/c38
	max_ammo = 6
	multiple_sprites = 1

/obj/item/ammo_magazine/c38/rubber
	name = "speed loader (.38, rubber)"
	icon_state = "R38"
	ammo_type = /obj/item/ammo_casing/pistol/c38/rubber

/obj/item/ammo_magazine/c44
	name = "speed loader (.44 magnum)"
	desc = "A speed loader for revolvers."
	icon_state = "38"
	ammo_type = /obj/item/ammo_casing/pistol/c44
	matter = list(DEFAULT_WALL_MATERIAL = 450)
	caliber = ".44"
	max_ammo = 6
	multiple_sprites = 1

/obj/item/ammo_magazine/c44/rubber
	name = "speed loader (.44 magnum, rubber)"
	icon_state = "R38"
	ammo_type = /obj/item/ammo_casing/pistol/c44/rubber

/obj/item/ammo_magazine/c45m
	name = "magazine (.45)"
	icon_state = "45"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/pistol/c45
	matter = list(DEFAULT_WALL_MATERIAL = 525) //metal costs are very roughly based around 1 .45 casing = 75 metal
	caliber = ".45"
	max_ammo = 10
	multiple_sprites = 1

/obj/item/ammo_magazine/c45m/empty
	initial_ammo = 0

/obj/item/ammo_magazine/c45m/rubber
	name = "magazine (.45, rubber)"
	ammo_type = /obj/item/ammo_casing/pistol/c45/rubber

/obj/item/ammo_magazine/c45m/practice
	name = "magazine (.45, practice)"
	ammo_type = /obj/item/ammo_casing/pistol/c45/practice

/obj/item/ammo_magazine/c45m/flash
	name = "magazine (.45, flash)"
	ammo_type = /obj/item/ammo_casing/pistol/c45/flash

/obj/item/ammo_magazine/c45uzi
	name = "stick magazine (.45)"
	icon_state = "uzi45"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/pistol/c45
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = ".45"
	max_ammo = 25
	multiple_sprites = 1

/obj/item/ammo_magazine/c45uzi/empty
	initial_ammo = 0

/obj/item/ammo_magazine/tac50
	name = "tactical speedloader"
	desc = "a speedloader custom made for the tactical revolver."
	icon_state = "50"
	caliber = ".500 Magnum"
	ammo_type = /obj/item/ammo_casing/pistol/m500
	matter = list(DEFAULT_WALL_MATERIAL = 1260)
	max_ammo = 5
	multiple_sprites = 1

/obj/item/ammo_magazine/a50
	name = "magazine (.44 Magnum)"
	icon_state = "50ae"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = ".44"
	matter = list(DEFAULT_WALL_MATERIAL = 1260)
	ammo_type = /obj/item/ammo_casing/pistol/a50
	max_ammo = 7
	multiple_sprites = 1

/obj/item/ammo_magazine/a50/empty
	initial_ammo = 0

/obj/item/ammo_magazine/a127
	//name = "ammo box (.357)"
	//desc = "A box of .357 ammo"
	//icon_state = "357"
	name = "speed loader (12,7x50mm)"
	desc = "A speed loader for revolvers."
	icon_state = "127"
	caliber = "12,7x50"
	ammo_type = /obj/item/ammo_casing/a127
	matter = list(DEFAULT_WALL_MATERIAL = 1260)
	max_ammo = 5
	multiple_sprites = 1

/obj/item/ammo_magazine/c50
	name = "speed loader (.44 magnum)"
	desc = "A speed loader for revolvers."
	icon_state = "38"
	caliber = ".44"
	ammo_type = /obj/item/ammo_casing/pistol/a50
	matter = list(DEFAULT_WALL_MATERIAL = 1260)
	max_ammo = 6
	multiple_sprites = 1

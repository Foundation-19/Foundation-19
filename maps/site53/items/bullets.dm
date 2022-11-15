//////////////////////////Bullets////////////////

/obj/item/projectile/bullet/pistol
	fire_sound = 'sound/weapons/gunshot/gunshot_pistol.ogg'
	damage = 37 //9mm, .38, etc
	armor_penetration = 0

/obj/item/projectile/bullet/pistol/rubber
	damage = 3 //Pistol rubber
	agony = 30
	embed = 0
	sharp = 0
	armor_penetration = 0

/obj/item/projectile/bullet/pistol/medium
	damage = 45 //.45
	armor_penetration = 0

/obj/item/projectile/bullet/pistol/medium/revolver
	fire_sound = 'sound/weapons/gunshot/gunshot_strong.ogg'
	damage = 50 //.44 magnum or something
	armor_penetration = 0

/obj/item/projectile/bullet/pistol/strong //matebas
	fire_sound = 'sound/weapons/gunshot/gunshot_strong.ogg'
	damage = 52 //.50AE
	armor_penetration = 0

/obj/item/projectile/bullet/pistol/vstrong //tacrevolver
	fire_sound = 'sound/weapons/gunshot/gunshot_strong.ogg'
	damage = 60 //.500 S&W Magnum
	armor_penetration = 0

/obj/item/projectile/bullet/pistol/strong/revolver //revolvers
	damage = 50 //Revolvers get snowflake bullets, to keep them relevant
	armor_penetration = 0

/obj/item/projectile/bullet/pistol/medium/smg //P90
	fire_sound = 'sound/weapons/gunshot/gunshot_smg.ogg'
	damage = 35 //10mm
	armor_penetration = 10

/obj/item/projectile/bullet/pistol/medium/smg/rubber
	fire_sound = 'sound/weapons/gunshot/gunshot_smg.ogg'
	damage = 3 //10mm rubber
	armor_penetration = 0
	agony = 30
	embed = 0
	sharp = 0

/obj/item/projectile/bullet/pistol/medium/smg/hollowpoint
	fire_sound = 'sound/weapons/gunshot/gunshot_smg.ogg'
	damage = 45 //10mm hollowpoint
	armor_penetration = 0
	embed = 1

/obj/item/projectile/bullet/pistol/medium/smg/ap
	fire_sound = 'sound/weapons/gunshot/gunshot_smg.ogg'
	damage = 35 //10mm AP
	armor_penetration = 20

/obj/item/projectile/bullet/pistol/medium/smg/silver
	fire_sound = 'sound/weapons/gunshot/gunshot_smg.ogg'
	damage = 45 //10mm but i have no idea what bimmer wanted for classifaction, so i made it just better normal ammo
	armor_penetration = 0

/* shotgun projectiles */

/obj/item/projectile/bullet/shotgun
	name = "slug"
	fire_sound = 'sound/weapons/gunshot/shotgun.ogg'
	damage = 60
	armor_penetration = 0

/obj/item/projectile/bullet/shotgun/beanbag		//because beanbags are not bullets
	name = "beanbag"
	damage = 3
	agony = 70
	embed = 0
	sharp = 0

//Should do about 80 damage at 1 tile distance (adjacent), and 50 damage at 3 tiles distance.
//Overall less damage than slugs in exchange for more damage at very close range and more embedding
/obj/item/projectile/bullet/pellet/shotgun
	name = "shrapnel"
	fire_sound = 'sound/weapons/gunshot/shotgun.ogg'
	damage = 22
	pellets = 6
	range_step = 1
	spread_step = 10

/obj/item/projectile/bullet/pellet/shotgun/rubbershot
	name = "rubbershot"
	damage = 1
	pellets = 8
	range_step = 1
	spread_step = 10
	agony = 25
	embed = 0
	sharp = 0


/* "Rifle" rounds */

/obj/item/projectile/bullet/rifle
	armor_penetration = 0
	penetrating = 1

/obj/item/projectile/bullet/rifle/a556
	fire_sound = 'sound/weapons/gunshot/gunshot3.ogg'
	damage = 45
	armor_penetration = 10

/obj/item/projectile/bullet/rifle/a762
	fire_sound = 'sound/weapons/gunshot/gunshot2.ogg'
	damage = 50
	armor_penetration = 5

/obj/item/projectile/bullet/rifle/a762x54
	fire_sound = 'sound/weapons/gunshot/gunshot2.ogg'
	damage = 55
	armor_penetration = 15

/obj/item/projectile/bullet/rifle/a762nato
	fire_sound = 'sound/weapons/gunshot/gunshot2.ogg'
	damage = 55
	armor_penetration = 15

/obj/item/projectile/bullet/rifle/a145
	fire_sound = 'sound/weapons/gunshot/sniper.ogg'
	damage = 150
	stun = 3
	weaken = 3
	penetrating = 5
	armor_penetration = 100
	hitscan = 1 //so the PTR isn't useless as a sniper weapon
	penetration_modifier = 1.25

/obj/item/projectile/bullet/rifle/a145/apds
	damage = 125
	penetrating = 6
	armor_penetration = 120
	penetration_modifier = 1.5

/* Miscellaneous */

/obj/item/projectile/bullet/suffocationbullet//How does this even work?
	name = "co bullet"
	damage = 45
	damage_type = OXY
	agony = 11.25

/obj/item/projectile/bullet/cyanideround
	name = "poison bullet"
	damage = 45
	damage_type = TOX
	agony = 11.25

/obj/item/projectile/bullet/burstbullet
	name = "exploding bullet"
	damage = 45
	embed = 0
	edge = 1
	agony = 11.25

/obj/item/projectile/bullet/gyro
	fire_sound = 'sound/effects/Explosion1.ogg'

/obj/item/projectile/bullet/gyro/on_hit(atom/target, blocked = 0)
	if(isturf(target))
		explosion(target, -1, 0, 2)
	..()

/obj/item/projectile/bullet/blank
	invisibility = 101
	damage = 1
	embed = 0

/* Practice */

/obj/item/projectile/bullet/pistol/practice
	damage = 5

/obj/item/projectile/bullet/rifle/a762/practice
	damage = 5

/obj/item/projectile/bullet/shotgun/practice
	name = "practice"
	damage = 5

/obj/item/projectile/bullet/pistol/cap
	name = "cap"
	invisibility = 101
	fire_sound = null
	damage_type = PAIN
	damage = 0
	nodamage = 1
	embed = 0
	sharp = 0

/obj/item/projectile/bullet/pistol/cap/Process()
	loc = null
	qdel(src)

/obj/item/projectile/bullet/rock //spess dust
	name = "micrometeor"
	icon_state = "rock"
	damage = 40
	armor_penetration = 25
//	kill_count = 255

/obj/item/projectile/bullet/rock/New()
	icon_state = "rock[rand(1,3)]"
	pixel_x = rand(-10,10)
	pixel_y = rand(-10,10)
	..()

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

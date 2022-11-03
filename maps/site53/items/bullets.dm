/obj/item/ammo_casing/a357
	desc = "A .357 bullet casing."
	caliber = "357"
	projectile_type = /obj/item/projectile/bullet/pistol/strong/revolver
	icon_state = "pistol-casing"
	spent_icon = "pistol-casing-spent"

/obj/item/ammo_casing/a50
	desc = "A .44 magnum bullet casing."
	caliber = ".44"
	projectile_type = /obj/item/projectile/bullet/pistol/strong
	icon_state = "pistol-casing"
	spent_icon = "pistol-casing-spent"

/obj/item/ammo_casing/a127
	desc = "A 12,7x50mm bullet casing."
	caliber = "12,7x50"
	projectile_type = /obj/item/projectile/bullet/pistol/strong

/obj/item/ammo_casing/m500
	desc = "A .500 S&W Magnum bullet casing."
	caliber = ".500 Magnum"
	projectile_type = /obj/item/projectile/bullet/pistol/vstrong
	icon_state = "pistol-casing"
	spent_icon = "pistol-casing-spent"

/obj/item/ammo_casing/gyro
	desc = "A 20mm bullet casing."
	caliber = "20mmG"
	projectile_type = /obj/item/projectile/bullet/gyro
	icon_state = "lcasing"
	spent_icon = "lcasing-spent"

/obj/item/ammo_casing/c38
	desc = "A .38 bullet casing."
	caliber = "38"
	projectile_type = /obj/item/projectile/bullet/pistol
	icon_state = "pistol-casing"
	spent_icon = "pistol-casing-spent"

/obj/item/ammo_casing/c38/rubber
	desc = "A .38 rubber bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/rubber
	icon_state = "pistol-casing-rubber"
	spent_icon = "pistol-casing-spent"

/obj/item/ammo_casing/c9mm
	desc = "A 9mm bullet casing."
	caliber = "9mm"
	projectile_type = /obj/item/projectile/bullet/pistol
	icon_state = "pistol-casing"
	spent_icon = "pistol-casing-spent"

/obj/item/ammo_casing/c9mm/rubber
	desc = "A 9mm rubber bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/rubber
	icon_state = "pistol-casing-rubber"
	spent_icon = "pistol-casing-spent"

/obj/item/ammo_casing/c9mm/flash
	desc = "A 9mm flash shell casing."
	projectile_type = /obj/item/projectile/energy/flash
	icon_state = "pistol-casing"
	spent_icon = "pistol-casing-spent"

/obj/item/ammo_casing/c9mm/practice
	desc = "A 9mm practice bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/practice
	icon_state = "pistol-casing"
	spent_icon = "pistol-casing-spent"

/obj/item/ammo_casing/c44
	desc = "A .44 magnum bullet casing."
	caliber = ".44"
	projectile_type = /obj/item/projectile/bullet/pistol/medium/revolver
	icon_state = "pistol-casing"
	spent_icon = "pistol-casing-spent"

/obj/item/ammo_casing/c44/rubber
	desc = "A .44 magnum rubber bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/rubber
	icon_state = "pistol-casing-rubber"
	spent_icon = "pistol-casing-spent"

/obj/item/ammo_casing/c45
	desc = "A .45 bullet casing."
	caliber = ".45"
	projectile_type = /obj/item/projectile/bullet/pistol/medium
	icon_state = "pistol-casing"
	spent_icon = "pistol-casing-spent"

/obj/item/ammo_casing/c45/practice
	desc = "A .45 practice bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/practice
	icon_state = "pistol-casing"
	spent_icon = "pistol-casing-spent"

/obj/item/ammo_casing/c45/rubber
	desc = "A .45 rubber bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/rubber
	icon_state = "pistol-casing-rubber"
	spent_icon = "pistol-casing-spent"

/obj/item/ammo_casing/c45/flash
	desc = "A .45 flash shell casing."
	projectile_type = /obj/item/projectile/energy/flash
	icon_state = "pistol-casing"
	spent_icon = "pistol-casing-spent"

/obj/item/ammo_casing/a10mm
	desc = "A 5.7x28mm bullet casing."
	caliber = "10mm"
	projectile_type = /obj/item/projectile/bullet/pistol/medium/smg
	icon_state = "pistol-casing"
	spent_icon = "pistol-casing-spent"

/obj/item/ammo_casing/rub10mm
	desc = "A rubber 10mm bullet casing."
	caliber = "10mm"
	projectile_type = /obj/item/projectile/bullet/pistol/medium/smg/rubber
	icon_state = "pistol-casing-rubber"
	spent_icon = "pistol-casing-spent"

/obj/item/ammo_casing/ap10mm
	desc = "A armor piercing 10mm bullet casing."
	caliber = "10mm"
	projectile_type = /obj/item/projectile/bullet/pistol/medium/smg/ap
	icon_state = "pistol-casing"
	spent_icon = "pistol-casing-spent"

/obj/item/ammo_casing/h10mm
	desc = "A hollowpoint 10mm bullet casing."
	caliber = "10mm"
	projectile_type = /obj/item/projectile/bullet/pistol/medium/smg/hollowpoint
	icon_state = "pistol-casing"
	spent_icon = "pistol-casing-spent"

/obj/item/ammo_casing/sc10mm
	desc = "A Silver Crescent 10mm bullet casing."
	caliber = "10mm"
	projectile_type = /obj/item/projectile/bullet/pistol/medium/smg/silver
	icon_state = "pistol-casing"
	spent_icon = "pistol-casing-spent"

/obj/item/ammo_casing/shotgun
	name = "shotgun slug"
	desc = "A 12 gauge slug."
	icon_state = "shell-slug"
	spent_icon = "shell-slug-spent"
	caliber = CALIBER_SHOTGUN
	projectile_type = /obj/item/projectile/bullet/shotgun
	matter = list(DEFAULT_WALL_MATERIAL = 360)

/obj/item/ammo_casing/shotgun/pellet
	name = "shotgun buckshot"
	desc = "A 12 gauge shell."
	icon_state = "shell-pellet"
	spent_icon = "shell-pellet-spent"
	projectile_type = /obj/item/projectile/bullet/pellet/shotgun
	matter = list(DEFAULT_WALL_MATERIAL = 360)

/obj/item/ammo_casing/shotgun/rubbershot
	name = "shotgun rubbershot"
	desc = "A 12 gauge shell."
	icon_state = "shell-rubbershot"
	spent_icon = "shell-rubbershot-spent"
	projectile_type = /obj/item/projectile/bullet/pellet/shotgun/rubbershot
	matter = list(DEFAULT_WALL_MATERIAL = 360)

/obj/item/ammo_casing/shotgun/blank
	name = "shotgun shell"
	desc = "A blank shell."
	icon_state = "shell-blank"
	spent_icon = "shell-blank-spent"
	projectile_type = /obj/item/projectile/bullet/blank
	matter = list(DEFAULT_WALL_MATERIAL = 90)

/obj/item/ammo_casing/shotgun/practice
	name = "shotgun shell"
	desc = "A practice shell."
	icon_state = "shell-practise"
	spent_icon = "shell-practise-spent"
	projectile_type = /obj/item/projectile/bullet/shotgun/practice
	matter = list("metal" = 90)

/obj/item/ammo_casing/shotgun/beanbag
	name = "beanbag shell"
	desc = "A beanbag shell."
	icon_state = "shell-beanbag"
	spent_icon = "shell-beanbag-spent"
	projectile_type = /obj/item/projectile/bullet/shotgun/beanbag
	matter = list(DEFAULT_WALL_MATERIAL = 180)

//Can stun in one hit if aimed at the head, but
//is blocked by clothing that stops tasers and is vulnerable to EMP
/obj/item/ammo_casing/shotgun/stunshell
	name = "stun shell"
	desc = "A 12 gauge taser cartridge."
	icon_state = "shell-stun"
	spent_icon = "shell-stun-spent"
	projectile_type = /obj/item/projectile/energy/electrode/stunshot
	leaves_residue = 0
	matter = list(DEFAULT_WALL_MATERIAL = 360, "glass" = 720)

/obj/item/ammo_casing/shotgun/stunshell/emp_act(severity)
	if(prob(100/severity)) BB = null
	update_icon()

//Does not stun, only blinds, but has area of effect.
/obj/item/ammo_casing/shotgun/flash
	name = "flash shell"
	desc = "A chemical shell used to signal distress or provide illumination."
	icon_state = "shell-flash"
	spent_icon = "shell-flash-spent"
	projectile_type = /obj/item/projectile/energy/flash/flare
	matter = list(DEFAULT_WALL_MATERIAL = 90, "glass" = 90)

/obj/item/ammo_casing/a556
	desc = "A 5.56mm bullet casing."
	caliber = "a556"
	projectile_type = /obj/item/projectile/bullet/rifle/a556
	icon_state = "rifle-casing"
	spent_icon = "rifle-casing-spent"

/obj/item/ammo_casing/a145
	name = "shell casing"
	desc = "A 14.5mm shell."
	icon_state = "lcasing"
	spent_icon = "lcasing-spent"
	caliber = "14.5mm"
	projectile_type = /obj/item/projectile/bullet/rifle/a145
	matter = list(DEFAULT_WALL_MATERIAL = 1250)

/obj/item/ammo_casing/a145/apds
	name = "APDS shell casing"
	desc = "A 14.5mm Armour Piercing Discarding Sabot shell."
	projectile_type = /obj/item/projectile/bullet/rifle/a145/apds

/obj/item/ammo_casing/a762
	desc = "A 7.62mm bullet casing."
	caliber = "a762"
	projectile_type = /obj/item/projectile/bullet/rifle/a762
	icon_state = "rifle-casing"
	spent_icon = "rifle-casing-spent"

/obj/item/ammo_casing/a762/practice
	desc = "A 7.62mm practice bullet casing."
	projectile_type = /obj/item/projectile/bullet/rifle/a762/practice

/obj/item/ammo_casing/a762nato
	desc = "A 7.62x51mm NATO bullet casing."
	caliber = "a762nato"
	projectile_type = /obj/item/projectile/bullet/rifle/a762nato
	icon_state = "rifle-casing"
	spent_icon = "rifle-casing-spent"

/obj/item/ammo_casing/rocket
	name = "rocket shell"
	desc = "A high explosive designed to be fired from a launcher."
	icon_state = "rocketshell"
	projectile_type = /obj/item/missile
	caliber = "rocket"

/obj/item/ammo_casing/cap
	name = "cap"
	desc = "A cap for children toys."
	caliber = "caps"
	color = "#ff0000"
	projectile_type = /obj/item/projectile/bullet/pistol/cap

// EMP ammo.
/obj/item/ammo_casing/c38/emp
	name = ".38 haywire round"
	desc = "A .38 bullet casing fitted with a single-use ion pulse generator."
	icon_state = "pistol-casing-emp"
	projectile_type = /obj/item/projectile/ion/small
	matter = list(DEFAULT_WALL_MATERIAL = 130, "uranium" = 100)

/obj/item/ammo_casing/c45/emp
	name = ".45 haywire round"
	desc = "A .45 bullet casing fitted with a single-use ion pulse generator."
	projectile_type = /obj/item/projectile/ion/small
	icon_state = "pistol-casing-emp"
	matter = list(DEFAULT_WALL_MATERIAL = 130, "uranium" = 100)

/obj/item/ammo_casing/a10mm/emp
	name = "10mm haywire round"
	desc = "A 10mm bullet casing fitted with a single-use ion pulse generator."
	projectile_type = /obj/item/projectile/ion/small
	icon_state = "pistol-casing-emp"
	matter = list(DEFAULT_WALL_MATERIAL = 130, "uranium" = 100)

/obj/item/ammo_casing/shotgun/emp
	name = "haywire slug"
	desc = "A 12-gauge shotgun slug fitted with a single-use ion pulse generator."
	icon_state = "shell-emp"
	spent_icon = "shell-emp-spent"
	projectile_type  = /obj/item/projectile/ion
	matter = list(DEFAULT_WALL_MATERIAL = 260, "uranium" = 200)
//////////////////////////Bullets////////////////

/obj/item/projectile/bullet/pistol
	fire_sound = 'sound/weapons/gunshot/gunshot_pistol.ogg'
	damage = 40 //9mm, .38, etc
	armor_penetration = 0
	agony = 0

/obj/item/projectile/bullet/pistol/rubber
	damage = 3 //Pistol rubber
	agony = 30
	embed = 0
	sharp = 0
	armor_penetration = 0

/obj/item/projectile/bullet/pistol/medium
	damage = 45 //.45
	armor_penetration = 0
	agony = 0

/obj/item/projectile/bullet/pistol/medium/revolver
	fire_sound = 'sound/weapons/gunshot/gunshot_strong.ogg'
	damage = 50 //.44 magnum or something
	armor_penetration = 0
	agony = 0

/obj/item/projectile/bullet/pistol/strong //matebas
	fire_sound = 'sound/weapons/gunshot/gunshot_strong.ogg'
	damage = 55 //.50AE
	armor_penetration = 0
	agony = 0

/obj/item/projectile/bullet/pistol/vstrong //tacrevolver
	fire_sound = 'sound/weapons/gunshot/gunshot_strong.ogg'
	damage = 60 //.500 S&W Magnum
	armor_penetration = 0
	agony = 0

/obj/item/projectile/bullet/pistol/strong/revolver //revolvers
	damage = 50 //Revolvers get snowflake bullets, to keep them relevant
	armor_penetration = 0
	agony = 0

/obj/item/projectile/bullet/pistol/medium/smg //P90
	fire_sound = 'sound/weapons/gunshot/gunshot_smg.ogg'
	damage = 45 //10mm
	armor_penetration = 10
	agony = 0

/obj/item/projectile/bullet/pistol/medium/smg/rubber
	fire_sound = 'sound/weapons/gunshot/gunshot_smg.ogg'
	damage = 3 //10mm rubber
	armor_penetration = 0
	agony = 30
	embed = 0
	sharp = 0

/obj/item/projectile/bullet/pistol/medium/smg/hollowpoint
	fire_sound = 'sound/weapons/gunshot/gunshot_smg.ogg'
	damage = 50 //10mm hollowpoint
	armor_penetration = 0
	agony = 0
	embed = 1

/obj/item/projectile/bullet/pistol/medium/smg/ap
	fire_sound = 'sound/weapons/gunshot/gunshot_smg.ogg'
	damage = 40 //10mm AP
	armor_penetration = 20
	agony = 0

/obj/item/projectile/bullet/pistol/medium/smg/silver
	fire_sound = 'sound/weapons/gunshot/gunshot_smg.ogg'
	damage = 45 //10mm but i have no idea what bimmer wanted for classifaction, so i made it just better normal ammo
	armor_penetration = 0
	agony = 0


/* shotgun projectiles */

/obj/item/projectile/bullet/shotgun
	name = "slug"
	fire_sound = 'sound/weapons/gunshot/shotgun.ogg'
	damage = 80
	armor_penetration = 0
	agony = 0

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
	damage = 35
	pellets = 6
	range_step = 1
	spread_step = 10
	agony = 0

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
	agony = 35

/obj/item/projectile/bullet/rifle/a556
	fire_sound = 'sound/weapons/gunshot/gunshot3.ogg'
	damage = 50
	armor_penetration = 10
	agony = 0

/obj/item/projectile/bullet/rifle/a762
	fire_sound = 'sound/weapons/gunshot/gunshot2.ogg'
	damage = 55
	armor_penetration = 5
	agony = 0

/obj/item/projectile/bullet/rifle/a762nato
	fire_sound = 'sound/weapons/gunshot/gunshot2.ogg'
	damage = 55
	armor_penetration = 15
	agony = 0

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
	agony = 0

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

/obj/item/projectile/bullet/gyro/on_hit(var/atom/target, var/blocked = 0)
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
	ammo_type = /obj/item/ammo_casing/c38
	max_ammo = 6
	multiple_sprites = 1

/obj/item/ammo_magazine/c38/rubber
	name = "speed loader (.38, rubber)"
	icon_state = "R38"
	ammo_type = /obj/item/ammo_casing/c38/rubber

/obj/item/ammo_magazine/c44
	name = "speed loader (.44 magnum)"
	desc = "A speed loader for revolvers."
	icon_state = "38"
	ammo_type = /obj/item/ammo_casing/c44
	matter = list(DEFAULT_WALL_MATERIAL = 450)
	caliber = ".44"
	max_ammo = 6
	multiple_sprites = 1

/obj/item/ammo_magazine/c44/rubber
	name = "speed loader (.44 magnum, rubber)"
	icon_state = "R38"
	ammo_type = /obj/item/ammo_casing/c44/rubber

/obj/item/ammo_magazine/c45m
	name = "magazine (.45)"
	icon_state = "45"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/c45
	matter = list(DEFAULT_WALL_MATERIAL = 525) //metal costs are very roughly based around 1 .45 casing = 75 metal
	caliber = ".45"
	max_ammo = 10
	multiple_sprites = 1

/obj/item/ammo_magazine/c45m/empty
	initial_ammo = 0

/obj/item/ammo_magazine/c45m/rubber
	name = "magazine (.45, rubber)"
	ammo_type = /obj/item/ammo_casing/c45/rubber

/obj/item/ammo_magazine/c45m/practice
	name = "magazine (.45, practice)"
	ammo_type = /obj/item/ammo_casing/c45/practice

/obj/item/ammo_magazine/c45m/flash
	name = "magazine (.45, flash)"
	ammo_type = /obj/item/ammo_casing/c45/flash

/obj/item/ammo_magazine/c45uzi
	name = "stick magazine (.45)"
	icon_state = "uzi45"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/c45
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
	ammo_type = /obj/item/ammo_casing/m500
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
	ammo_type = /obj/item/ammo_casing/a50
	max_ammo = 7
	multiple_sprites = 1

/obj/item/ammo_magazine/a50/empty
	initial_ammo = 0

/obj/item/ammo_magazine/gyro
	name = "gyropistol magazine (20mm)"
	icon_state = "75"
	mag_type = MAGAZINE
	caliber = "20mmG"
	ammo_type = /obj/item/ammo_casing/gyro
	multiple_sprites = 1
	max_ammo = 4

/obj/item/ammo_magazine/gyro/empty
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
	ammo_type = /obj/item/ammo_casing/a50
	matter = list(DEFAULT_WALL_MATERIAL = 1260)
	max_ammo = 6
	multiple_sprites = 1

/obj/item/ammo_casing/pistol
	desc = "A pistol bullet casing."
	caliber = CALIBER_PISTOL
	projectile_type = /obj/item/projectile/bullet/pistol
	icon_state = "pistol-casing"
	spent_icon = "pistol-casing-spent"

/obj/item/ammo_casing/pistol/rubber
	desc = "A rubber pistol bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/rubber
	icon_state = "pistol-casing-rubber"

/obj/item/ammo_casing/pistol/practice
	desc = "A practice pistol bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/practice
	icon_state = "pistol-casing-rubber"

/obj/item/ammo_casing/pistol/small
	desc = "A small pistol bullet casing."
	caliber = CALIBER_PISTOL_SMALL
	projectile_type = /obj/item/projectile/bullet/pistol/holdout
	icon_state = "pistol-casing"
	spent_icon = "pistol-casing-spent"

/obj/item/ammo_casing/pistol/small/rubber
	desc = "A small pistol rubber bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/rubber/holdout
	icon_state = "pistol-casing-rubber"

/obj/item/ammo_casing/pistol/small/practice
	desc = "A small pistol practice bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/practice
	icon_state = "pistol-casing-rubber"

/obj/item/ammo_casing/pistol/magnum
	desc = "A high-power pistol bullet casing."
	caliber = CALIBER_PISTOL_MAGNUM
	projectile_type = /obj/item/projectile/bullet/pistol/strong
	icon_state = "10mm-casing"
	spent_icon = "10mm-casing-spent"

/obj/item/ammo_casing/pistol/throwback
	desc = "An antique pistol bullet casing. Somewhere between 9 and 11 mm in caliber."
	caliber = CALIBER_PISTOL_ANTIQUE

/obj/item/ammo_casing/gyrojet
	desc = "A minirocket casing."
	caliber = CALIBER_GYROJET
	projectile_type = /obj/item/projectile/bullet/gyro
	icon_state = "lcasing"
	spent_icon = "lcasing-spent"

/obj/item/ammo_casing/flechette
	desc = "A flechette casing."
	caliber = CALIBER_PISTOL_FLECHETTE
	projectile_type = /obj/item/projectile/bullet/flechette
	icon_state = "flechette-casing"
	spent_icon = "flechette-casing-spent"

/obj/item/ammo_casing/flechette/hp
	projectile_type = /obj/item/projectile/bullet/flechette/hp

/obj/item/ammo_casing/shotgun
	name = "shotgun slug"
	desc = "A shotgun slug."
	icon_state = "shell-slug"
	spent_icon = "shell-slug-spent"
	caliber = CALIBER_SHOTGUN
	projectile_type = /obj/item/projectile/bullet/shotgun
	matter = list(MATERIAL_STEEL = 360)
	fall_sounds = list('sound/weapons/guns/shotgun_fall.ogg')

/obj/item/ammo_casing/shotgun/pellet
	name = "shotgun shell"
	desc = "A shotshell."
	icon_state = "shell-pellet"
	spent_icon = "shell-pellet-spent"
	projectile_type = /obj/item/projectile/bullet/pellet/shotgun
	matter = list(MATERIAL_STEEL = 360)

/obj/item/ammo_casing/shotgun/blank
	name = "shotgun shell"
	desc = "A blank shell."
	icon_state = "shell-blank"
	spent_icon = "shell-blank-spent"
	projectile_type = /obj/item/projectile/bullet/blank
	matter = list(MATERIAL_STEEL = 90)

/obj/item/ammo_casing/shotgun/practice
	name = "shotgun shell"
	desc = "A practice shell."
	icon_state = "shell-practice"
	spent_icon = "shell-practise-spent"
	projectile_type = /obj/item/projectile/bullet/shotgun/practice
	matter = list(MATERIAL_STEEL = 90)

/obj/item/ammo_casing/shotgun/beanbag
	name = "beanbag shell"
	desc = "A beanbag shell."
	icon_state = "shell-beanbag"
	spent_icon = "shell-beanbag-spent"
	projectile_type = /obj/item/projectile/bullet/shotgun/beanbag
	matter = list(MATERIAL_STEEL = 180)

//Can stun in one hit if aimed at the head, but
//is blocked by clothing that stops tasers and is vulnerable to EMP
/obj/item/ammo_casing/shotgun/stunshell
	name = "stun shell"
	desc = "An energy stun cartridge."
	icon_state = "shell-stun"
	spent_icon = "shell-stun-spent"
	projectile_type = /obj/item/projectile/energy/electrode/stunshot
	leaves_residue = FALSE
	matter = list(MATERIAL_STEEL = 360, MATERIAL_GLASS = 720)

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
	matter = list(MATERIAL_STEEL = 90, MATERIAL_GLASS = 90)

/obj/item/ammo_casing/rifle
	desc = "A rifle bullet casing."
	caliber = CALIBER_RIFLE
	projectile_type = /obj/item/projectile/bullet/rifle
	icon_state = "rifle-casing"
	spent_icon = "rifle-casing-spent"

/obj/item/ammo_casing/shell
	name = "shell casing"
	desc = "An antimaterial shell casing."
	icon_state = "lcasing"
	spent_icon = "lcasing-spent"
	caliber = CALIBER_ANTIMATERIAL
	projectile_type = /obj/item/projectile/bullet/rifle/shell
	matter = list(MATERIAL_STEEL = 1250)

/obj/item/ammo_casing/shell/apds
	name = "\improper APDS shell casing"
	desc = "An Armour Piercing Discarding Sabot shell."
	projectile_type = /obj/item/projectile/bullet/rifle/shell/apds

/obj/item/ammo_casing/rifle/military
	desc = "A military rifle bullet casing."
	caliber = CALIBER_RIFLE_MILITARY
	projectile_type = /obj/item/projectile/bullet/rifle/military
	icon_state = "rifle-casing"
	spent_icon = "rifle-casing-spent"

/obj/item/ammo_casing/rifle/military/practice
	desc = "A military rifle practice bullet casing."
	projectile_type = /obj/item/projectile/bullet/rifle/military/practice
	icon_state = "rifle-casing-rubber"

/obj/item/ammo_casing/rifle/t12
	caliber = CALIBER_T12
	projectile_type = /obj/item/projectile/bullet/rifle/t12

/obj/item/ammo_casing/rocket
	name = "rocket shell"
	desc = "A high explosive designed to be fired from a launcher."
	icon_state = "rocketshell"
	projectile_type = /obj/item/missile
	caliber = "rocket"

/obj/item/ammo_casing/cap
	name = "cap"
	desc = "A cap for children toys."
	caliber = CALIBER_CAPS
	color = "#ff0000"
	projectile_type = /obj/item/projectile/bullet/pistol/cap

// EMP ammo.
/obj/item/ammo_casing/pistol/emp
	name = "haywire round"
	desc = "A pistol bullet casing fitted with a single-use ion pulse generator."
	projectile_type = /obj/item/projectile/ion/small
	icon_state = "pistol-casing-emp"
	matter = list(MATERIAL_STEEL = 130, MATERIAL_URANIUM = 100)

/obj/item/ammo_casing/pistol/small/emp
	name = "small haywire round"
	desc = "A small bullet casing fitted with a single-use ion pulse generator."
	projectile_type = /obj/item/projectile/ion/tiny
	icon_state = "pistol-casing-emp"

/obj/item/ammo_casing/shotgun/emp
	name = "haywire slug"
	desc = "A 12-gauge shotgun slug fitted with a single-use ion pulse generator."
	icon_state = "shell-emp"
	spent_icon = "shell-emp-spent"
	projectile_type  = /obj/item/projectile/ion
	matter = list(MATERIAL_STEEL = 260, MATERIAL_URANIUM = 200)

/obj/item/ammo_casing/pistol/a357
	desc = "A .357 bullet casing."
	caliber = ".357"
	projectile_type = /obj/item/projectile/bullet/pistol/strong/revolver

/obj/item/ammo_casing/pistol/a50
	desc = "A .44 magnum bullet casing."
	caliber = ".44"
	projectile_type = /obj/item/projectile/bullet/pistol/strong

/obj/item/ammo_casing/a127
	desc = "A 12,7x50mm bullet casing."
	caliber = "12,7x50"
	projectile_type = /obj/item/projectile/bullet/pistol/strong

/obj/item/ammo_casing/pistol/m500
	desc = "A .500 S&W Magnum bullet casing."
	caliber = ".500 Magnum"
	projectile_type = /obj/item/projectile/bullet/pistol/vstrong

/obj/item/ammo_casing/pistol/c38
	desc = "A .38 bullet casing."
	caliber = "38"
	projectile_type = /obj/item/projectile/bullet/pistol

/obj/item/ammo_casing/pistol/c38/rubber
	desc = "A .38 rubber bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/rubber
	icon_state = "pistol-casing-rubber"

/obj/item/ammo_casing/pistol/c9mm
	desc = "A 9mm bullet casing."
	caliber = "9mm"
	projectile_type = /obj/item/projectile/bullet/pistol

/obj/item/ammo_casing/pistol/c9mm/rubber
	desc = "A 9mm rubber bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/rubber
	icon_state = "pistol-casing-rubber"

/obj/item/ammo_casing/pistol/c9mm/flash
	desc = "A 9mm flash shell casing."
	projectile_type = /obj/item/projectile/energy/flash

/obj/item/ammo_casing/pistol/c9mm/practice
	desc = "A 9mm practice bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/practice

/obj/item/ammo_casing/pistol/c44
	desc = "A .44 magnum bullet casing."
	caliber = ".44"
	projectile_type = /obj/item/projectile/bullet/pistol/medium/revolver

/obj/item/ammo_casing/pistol/c44/rubber
	desc = "A .44 magnum rubber bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/rubber
	icon_state = "pistol-casing-rubber"

/obj/item/ammo_casing/pistol/c45
	desc = "A .45 bullet casing."
	caliber = ".45"
	projectile_type = /obj/item/projectile/bullet/pistol/medium

/obj/item/ammo_casing/pistol/c45/practice
	desc = "A .45 practice bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/practice

/obj/item/ammo_casing/pistol/c45/rubber
	desc = "A .45 rubber bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/rubber
	icon_state = "pistol-casing-rubber"

/obj/item/ammo_casing/pistol/c45/flash
	desc = "A .45 flash shell casing."
	projectile_type = /obj/item/projectile/energy/flash

/obj/item/ammo_casing/pistol/a57
	desc = "A 5.7x28mm bullet casing."
	caliber = "5.7x28mm"
	projectile_type = /obj/item/projectile/bullet/pistol/medium/smg
/obj/item/ammo_casing/pistol/a57/rubber
	desc = "A rubber 5.7x28mm bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/medium/smg/rubber
	icon_state = "pistol-casing-rubber"

/obj/item/ammo_casing/pistol/a57/ap
	desc = "A armor piercing 5.7x28mm bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/medium/smg/ap

/obj/item/ammo_casing/pistol/a57/hp
	desc = "A hollowpoint 5.7x28mm bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/medium/smg/hollowpoint

/obj/item/ammo_casing/a57/sc
	desc = "A Silver Crescent 5.7x28mm bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/medium/smg/silver

/obj/item/ammo_casing/shotgun
	name = "slug shell"
	desc = "A 12 gauge slug."
	icon_state = "shell-slug"
	spent_icon = "shell-slug-spent"
	caliber = CALIBER_SHOTGUN
	projectile_type = /obj/item/projectile/bullet/shotgun
	matter = list(DEFAULT_WALL_MATERIAL = 360)

/obj/item/ammo_casing/shotgun/pellet
	name = "buckshot shell"
	desc = "A 12 gauge 00 buck shell."
	icon_state = "shell-pellet"
	spent_icon = "shell-pellet-spent"
	projectile_type = /obj/item/projectile/bullet/pellet/shotgun
	matter = list(DEFAULT_WALL_MATERIAL = 360)

/obj/item/ammo_casing/shotgun/rubbershot
	name = "rubbershot shell"
	desc = "A 12 gauge rubbershot shell."
	icon_state = "shell-rubbershot"
	spent_icon = "shell-rubbershot-spent"
	projectile_type = /obj/item/projectile/bullet/pellet/shotgun/rubbershot
	matter = list(DEFAULT_WALL_MATERIAL = 360)

/obj/item/ammo_casing/shotgun/blank
	name = "blank shell"
	desc = "A blank shell."
	icon_state = "shell-blank"
	spent_icon = "shell-blank-spent"
	projectile_type = /obj/item/projectile/bullet/blank
	matter = list(DEFAULT_WALL_MATERIAL = 90)

/obj/item/ammo_casing/shotgun/practice
	name = "practice shell"
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

/obj/item/ammo_casing/rifle
	icon_state = "rifle-casing"
	spent_icon = "rifle-casing-spent"

/obj/item/ammo_casing/rifle/a556
	desc = "A 5.56mm NATO bullet casing."
	caliber = "5.56x45mm"
	projectile_type = /obj/item/projectile/bullet/rifle/a556

/obj/item/ammo_casing/rifle/a762
	desc = "A 7.62x39mm bullet casing."
	caliber = "7.62x39mm"
	projectile_type = /obj/item/projectile/bullet/rifle/a762

/obj/item/ammo_casing/rifle/a762/practice
	desc = "A 7.62mm practice bullet casing."
	projectile_type = /obj/item/projectile/bullet/rifle/a762/practice

/obj/item/ammo_casing/rifle/a762x54
	desc = "A 7.62x54mmR bullet casing."
	caliber = "7.62x54mmR"
	projectile_type = /obj/item/projectile/bullet/rifle/a762x54

/obj/item/ammo_casing/rifle/a762nato
	desc = "A 7.62x51mm NATO bullet casing."
	caliber = "a762nato"
	projectile_type = /obj/item/projectile/bullet/rifle/a762nato
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
/obj/item/ammo_casing/pistol/c38/emp
	name = ".38 haywire round"
	desc = "A .38 bullet casing fitted with a single-use ion pulse generator."
	icon_state = "pistol-casing-emp"
	projectile_type = /obj/item/projectile/ion/small
	matter = list(DEFAULT_WALL_MATERIAL = 130, "uranium" = 100)

/obj/item/ammo_casing/pistol/c45/emp
	name = ".45 haywire round"
	desc = "A .45 bullet casing fitted with a single-use ion pulse generator."
	projectile_type = /obj/item/projectile/ion/small
	icon_state = "pistol-casing-emp"
	matter = list(DEFAULT_WALL_MATERIAL = 130, "uranium" = 100)

/obj/item/ammo_casing/pistol/a10mm/emp
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

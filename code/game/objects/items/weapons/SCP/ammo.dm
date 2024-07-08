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

/obj/item/ammo_magazine/scp/stanag_mag
	name = "magazine (5.56)"
	icon_state = "magi"
	icon = 'icons/SCP/guns/rifles/m4carbine.dmi'
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = "5.56x45mm"
	matter = list(DEFAULT_WALL_MATERIAL = 1500)
	ammo_type = /obj/item/ammo_casing/rifle/a556
	max_ammo = 30
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/stanag_mag/empty
	initial_ammo = 0

/obj/item/ammo_magazine/scp/stanag_mag/ext
	name = "extended magazine (5.56)"
	//icon_state = "m16"
	max_ammo = 60

/obj/item/ammo_magazine/t12
	name = "T12 magazine"
	icon_state = "magi"
	icon = 'icons/SCP/guns/rifles/g36c.dmi'
	mag_type = MAGAZINE
	caliber = CALIBER_T12
	matter = list(MATERIAL_STEEL = 2400)
	ammo_type = /obj/item/ammo_casing/rifle/t12
	max_ammo = 50
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/ak
	name = "magazine (5.45)"
	icon_state = "7.62x39mm"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = "5.45x39mm"
	matter = list(DEFAULT_WALL_MATERIAL = 1500)
	ammo_type = /obj/item/ammo_casing/rifle/a545
	max_ammo = 30
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/ak/big
	name = "big magazine (5.45)"
	icon_state = "7.62x39mm2"
	max_ammo = 45
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/ak/drum
	name = "drum magazine (5.45)"
	icon = 'icons/SCP/guns/rifles/rpk16.dmi'
	icon_state = "magi-drum"
	gun_mag_icon = "mag-drum"
	max_ammo = 60
	multiple_sprites = 1
	w_class = ITEM_SIZE_NORMAL

/obj/item/ammo_magazine/scp/svd
	name = "magazine (7.62x54mmR)"
	icon_state = "7.62x54s"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = "7.62x54mmR"
	matter = list(DEFAULT_WALL_MATERIAL = 1500)
	ammo_type = /obj/item/ammo_casing/rifle/a762x54
	max_ammo = 10
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/fnfal
	name = "magazine (7.62x51 NATO)"
	icon_state = "7.62x54s"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = "a762nato"
	matter = list(DEFAULT_WALL_MATERIAL = 1500)
	ammo_type = /obj/item/ammo_casing/rifle/a762nato
	max_ammo = 20
	multiple_sprites = 1

/obj/item/ammo_magazine/a762
	name = "magazine (7.62mm)"
	icon_state = "5.56"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = "7.62x39mm"
	matter = list(DEFAULT_WALL_MATERIAL = 1800)
	ammo_type = /obj/item/ammo_casing/rifle/a762
	max_ammo = 15 //if we lived in a world where normal mags had 30 rounds, this would be a 20 round mag
	multiple_sprites = 1

/obj/item/ammo_magazine/a762/empty
	initial_ammo = 0

/obj/item/ammo_magazine/a762/practice
	name = "magazine (7.62mm, practice)"
	ammo_type = /obj/item/ammo_casing/rifle/a762/practice

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

// 9mm
/obj/item/ammo_magazine/box/a9mm
	name = "ammunition box (9x19mm)"
	desc = "A hefty militarized ammunition cartridge. It's green, and says ``9x19`` on the cartridge. You can only guess what's in it."
	icon_state = "box_9mm"
	origin_tech = list(TECH_COMBAT = 2)
	caliber = "9mm"
	matter = list(DEFAULT_WALL_MATERIAL = 2250)
	ammo_type = /obj/item/ammo_casing/pistol/c9mm
	max_ammo = 100

/obj/item/ammo_magazine/box/a9mm/rubber
	name = "ammunition box (9x19mm Rubber)"
	desc = "A hefty militarized ammunition cartridge. It's green, and says ``9x19`` on the cartridge. It has a blue line for Rubber bullets. You can only guess what's in it."
	icon_state = "box_9mmr"
	ammo_type = /obj/item/ammo_casing/pistol/c9mm/rubber

/obj/item/ammo_magazine/box/a9mm/ap
	name = "ammunition box (9x19mm Armor-Piercing)"
	desc = "A hefty militarized ammunition cartridge. It's green, and says ``9x19`` on the cartridge. It has a white line for AP bullets. You can only guess what's in it."
	icon_state = "box_9mmap"
	ammo_type = /obj/item/ammo_casing/pistol/c9mm/ap

/obj/item/ammo_magazine/box/a9mm/hp
	name = "ammunition box (9x19mm Hollow-Point)"
	desc = "A hefty militarized ammunition cartridge. It's green, and says ``9x19`` on the cartridge. It has a red line for HP bullets. You can only guess what's in it."
	icon_state = "box_9mmhp"
	ammo_type = /obj/item/ammo_casing/pistol/c9mm/hp


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
	caliber = ".45 ACP"
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

// 5.7x28mm
/obj/item/ammo_magazine/box/a57
	name = "ammunition box (5.7x28mm)"
	icon_state = "fn_box"
	origin_tech = list(TECH_COMBAT = 2)
	caliber = "5.7x28mm"
	matter = list(DEFAULT_WALL_MATERIAL = 2250)
	ammo_type = /obj/item/ammo_casing/pistol/a57
	max_ammo = 200
	multiple_sprites = 1

/obj/item/ammo_magazine/box/a57/rubber
	name = "ammunition box (5.7x28mm rubber)"
	ammo_type = /obj/item/ammo_casing/pistol/a57/rubber

// 5.56
/obj/item/ammo_magazine/box/a556
	name = "magazine box (5.56mm)"
	icon_state = "usmc_box"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = "5.56x45mm"
	matter = list(DEFAULT_WALL_MATERIAL = 4500)
	ammo_type = /obj/item/ammo_casing/rifle/a556
	max_ammo = 100
	multiple_sprites = 1

// 7.62
/obj/item/ammo_magazine/box/a762
	name = "ammunition box (7.62)"
	icon_state = "csla_box"
	origin_tech = list(TECH_COMBAT = 2)
	caliber = "7.62x39mm"
	matter = list(DEFAULT_WALL_MATERIAL = 2250)
	ammo_type = /obj/item/ammo_casing/rifle/a762
	max_ammo = 100
	multiple_sprites = 1

// shotgun
/obj/item/ammo_magazine/box/buckshot
	name = "ammunition box (Buckshot)"
	icon_state = "ammobox"
	origin_tech = list(TECH_COMBAT = 2)
	caliber = CALIBER_SHOTGUN
	matter = list(DEFAULT_WALL_MATERIAL = 2250)
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
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
	caliber = ".45 ACP"
	matter = list(DEFAULT_WALL_MATERIAL = 2250)
	ammo_type = /obj/item/ammo_casing/pistol/c45
	max_ammo = 100



/* MTF AMMO STUFFS */
/obj/item/storage/box/mtf/pelletammo
	name = "pellet ammunition"
	desc = "Contains pellet ammunition for a shotgun."
	startswith = list(/obj/item/ammo_casing/shotgun/buckshot = 7)

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
	caliber = ".45 ACP"
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
	caliber = ".45 ACP"
	max_ammo = 12
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/m1911
	name = "M1911 Colt Magazine (.45ACP)"
	icon_state = "45"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/pistol/c45
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = ".45 ACP"
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
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
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


/obj/item/ammo_casing/shotgun/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_MOVED, TYPE_PROC_REF(/atom, update_icon))

/obj/item/ammo_casing/shotgun/on_update_icon()
	if(spent_icon && is_spent)
		icon_state = spent_icon
	else
		icon_state = initial(icon_state)
	icon_state = "[icon_state][isturf(loc)? "-world" : ""]"

/obj/item/ammo_magazine/scp/a9mm
	name = "pistol magazine (9mm)"
	icon_state = "9x19p"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/pistol/c9mm
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = "9mm"
	max_ammo = 7
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/a380
	name = "pistol magazine (.380 ACP)"
	icon_state = "9x19p"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/pistol/c380
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = ".380"
	max_ammo = 12
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/a380
	name = "pistol magazine (.380 ACP)"
	icon_state = "9x19p"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/pistol/c380
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = ".380"
	max_ammo = 7
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/a380/rubber
	name = "pistol magazine (.380 ACP Rubber)"
	icon_state = "9x19pr"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/pistol/c380/rubber
	matter = list(DEFAULT_WALL_MATERIAL = 1200)
	caliber = ".380"
	max_ammo = 12
	multiple_sprites = 1

/obj/item/ammo_magazine/scp/uzim9mm
	name = "UZI magazine (9mm)"
	desc = "A thin, 32-round magazine for the Uzi SMG. These rounds do okay damage, but struggle against armor."
	icon_state = "uzi9mm"
	caliber = "9mm"
	ammo_type = /obj/item/ammo_casing/pistol/c9mm
	matter = list(DEFAULT_WALL_MATERIAL = 1260)
	max_ammo = 32
	multiple_sprites = 1

/obj/item/ammo_magazine/box/a57/ap
	name = "ammunition box (5.7x28mm Armor-Piercing)"
	desc = "A quite heavy militarized ammunition box. It's green, and says ``5.7x28`` on the box. It has a white line for AP bullets. You can only guess what's in it."
	icon_state = "box_57x28mmap"
	ammo_type = /obj/item/ammo_casing/pistol/a57/ap

/obj/item/ammo_magazine/box/a57/hp
	name = "ammunition box (5.7x28mm Hollow-Point)"
	desc = "A quite heavy militarized ammunition box. It's green, and says ``5.7x28`` on the box. It has a red line for HP bullets. You can only guess what's in it."
	icon_state = "box_57x28mmhp"
	ammo_type = /obj/item/ammo_casing/pistol/a57/hp

/obj/item/ammo_magazine/scp/p90_mag/hp
	name = "P90 magazine (5.7x28mm Hollow-Point)"
	icon_state = "p90hp"
	origin_tech = list(TECH_COMBAT = 2)
	mag_type = MAGAZINE
	caliber = "5.7x28mm"
	matter = list(DEFAULT_WALL_MATERIAL = 1500)
	ammo_type = /obj/item/ammo_casing/pistol/a57/hp
	max_ammo = 50
	multiple_sprites = 1

/obj/item/ammo_magazine/box/a454
	name = "ammunition box (.454 Casull)"
	icon_state = "ammobox_454"
	origin_tech = list(TECH_COMBAT = 2)
	caliber = CALIBER_REVOLVER_HEAVY
	matter = list(DEFAULT_WALL_MATERIAL = 2250)
	ammo_type = /obj/item/ammo_casing/revolver/heavy
	max_ammo = 60

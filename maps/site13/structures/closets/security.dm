/*
 * Site13
 */

// MTF LOCKERS

/obj/structure/closet/secure_closet/mtf/enlisted
	name = "MTF Enlisted Locker"
	req_access = list(access_mtflvl1)
	icon_state = "enlistedlocked"
	icon_closed = "enlistedunlocked"
	icon_locked = "enlistedlocked"
	icon_opened = "enlistedopen"
	icon_off = "enlistedoff"

/obj/structure/closet/secure_closet/mtf/enlisted/WillContain()
	return list(
		/obj/item/clothing/under/scp/whiteuniform,
		/obj/item/clothing/head/helmet/bgtactical,
		/obj/item/clothing/suit/armor/vest/bgguard,
		/obj/item/weapon/storage/belt/security,
		/obj/item/weapon/gun/energy/taser,
		/obj/item/clothing/accessory/holster/thigh,
		/obj/item/weapon/melee/classic_baton,
		/obj/item/weapon/handcuffs,
		/obj/item/device/radio,
		/obj/item/clothing/gloves/thick,
		/obj/item/weapon/storage/box/handcuffs,
		/obj/item/clothing/accessory/kneepads,
		/obj/item/device/flashlight/maglight,
	)

/obj/structure/closet/secure_closet/mtf/commander
	name = "MTF Commander Locker"
	req_access = list(access_mtflvl5)
	icon_state = "cmlocked"
	icon_closed = "cmunlocked"
	icon_locked = "cmlocked"
	icon_opened = "cmopen"
	icon_off = "cmoff"

/obj/structure/closet/secure_closet/mtf/commander/WillContain()
	return list(
		/obj/item/clothing/under/scp/whiteuniform,
		/obj/item/clothing/head/helmet/bgtactical,
		/obj/item/clothing/suit/armor/vest/bgguard,
		/obj/item/weapon/storage/belt/security,
		/obj/item/weapon/gun/projectile/pistol,
		/obj/item/ammo_magazine/mc9mm,
		/obj/item/ammo_magazine/mc9mm,
		/obj/item/clothing/accessory/holster/thigh,
		/obj/item/weapon/melee/telebaton,
		/obj/item/weapon/handcuffs,
		/obj/item/device/radio,
		/obj/item/weapon/gun/projectile/automatic/tactical,
		/obj/item/ammo_magazine/tac9mm,
		/obj/item/ammo_magazine/tac9mm,
		/obj/item/clothing/gloves/thick,
		/obj/item/weapon/storage/box/handcuffs,
		/obj/item/clothing/accessory/kneepads,
		/obj/item/device/flashlight/maglight,
	)

/obj/structure/closet/secure_closet/mtf/nco
	name = "MTF NCO Locker"
	req_access = list(access_mtflvl2)
	icon_state = "nlocked"
	icon_closed = "nunlocked"
	icon_locked = "nlocked"
	icon_opened = "nopen"
	icon_off = "noff"

/obj/structure/closet/secure_closet/mtf/nco/WillContain()
	return list(
		/obj/item/clothing/under/scp/whiteuniform,
		/obj/item/clothing/head/helmet/bgtactical,
		/obj/item/clothing/suit/armor/vest/bgguard,
		/obj/item/weapon/storage/belt/security,
		/obj/item/weapon/gun/projectile/pistol,
		/obj/item/ammo_magazine/mc9mm,
		/obj/item/ammo_magazine/mc9mm,
		/obj/item/clothing/accessory/holster/thigh,
		/obj/item/weapon/melee/classic_baton,
		/obj/item/weapon/handcuffs,
		/obj/item/device/radio,
		/obj/item/clothing/gloves/thick,
		/obj/item/weapon/storage/box/handcuffs,
		/obj/item/clothing/accessory/kneepads,
		/obj/item/device/flashlight/maglight,
	)

/obj/structure/closet/secure_closet/mtf/co
	name = "MTF CO Locker"
	req_access = list(access_mtflvl4)
	icon_state = "colocked"
	icon_closed = "counlocked"
	icon_locked = "colocked"
	icon_opened = "coopen"
	icon_off = "cooff"

/obj/structure/closet/secure_closet/mtf/co/WillContain()
	return list(
		/obj/item/clothing/under/scp/whiteuniform,
		/obj/item/clothing/head/helmet/bgtactical,
		/obj/item/clothing/suit/armor/vest/bgguard,
		/obj/item/weapon/storage/belt/security,
		/obj/item/weapon/gun/projectile/pistol,
		/obj/item/ammo_magazine/mc9mm,
		/obj/item/ammo_magazine/mc9mm,
		/obj/item/clothing/accessory/holster/thigh,
		/obj/item/weapon/melee/classic_baton,
		/obj/item/weapon/handcuffs,
		/obj/item/device/radio,
		/obj/item/weapon/gun/projectile/automatic/tactical,
		/obj/item/ammo_magazine/tac9mm,
		/obj/item/ammo_magazine/tac9mm,
		/obj/item/clothing/gloves/thick,
		/obj/item/weapon/storage/box/handcuffs,
		/obj/item/clothing/accessory/kneepads,
		/obj/item/device/flashlight/maglight,
	)

/obj/structure/closet/secure_closet/mtf/breachautomatics
	name = "automatic weapons locker"
	req_access = list(access_mtflvl2)
	icon_state = "sec1"
	icon_closed = "sec"
	icon_locked = "sec1"
	icon_opened = "secopen"
	icon_off = "secoff"

/obj/structure/closet/secure_closet/mtf/breachautomatics/WillContain()
	return list(
		/obj/item/weapon/gun/projectile/automatic/z8,
		/obj/item/weapon/gun/projectile/automatic/z8,
		/obj/item/weapon/gun/projectile/automatic/z8,
		/obj/item/ammo_magazine/a762,
		/obj/item/ammo_magazine/a762,
		/obj/item/ammo_magazine/a762,
		/obj/item/ammo_magazine/a762,
		/obj/item/ammo_magazine/a762,
		/obj/item/ammo_magazine/a762,
		/obj/item/ammo_magazine/a762,
		/obj/item/ammo_magazine/a762,
		/obj/item/ammo_magazine/a762,
	)


/obj/structure/closet/secure_closet/mtf/breachshotguns
	name = "tactical shotgun locker"
	req_access = list(access_mtflvl2)
	icon_state = "sec1"
	icon_closed = "sec"
	icon_locked = "sec1"
	icon_opened = "secopen"
	icon_off = "secoff"

/obj/structure/closet/secure_closet/mtf/breachshotguns/WillContain()
	return list(
		/obj/item/weapon/gun/projectile/shotgun/tactical,
		/obj/item/weapon/gun/projectile/shotgun/tactical,
		/obj/item/weapon/gun/projectile/shotgun/tactical,
		/obj/item/weapon/storage/box/mtf/pelletammo,
		/obj/item/weapon/storage/box/mtf/pelletammo,
		/obj/item/weapon/storage/box/mtf/pelletammo,
		/obj/item/weapon/storage/box/mtf/pelletammo,
		/obj/item/weapon/storage/box/mtf/pelletammo,
		/obj/item/weapon/storage/box/mtf/pelletammo,
	)
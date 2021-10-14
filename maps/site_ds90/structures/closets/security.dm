/*
 * Torch Security
 */

/obj/structure/closet/secure_closet/security_torch
	name = "master at arms' locker"
	req_access = list(access_brig)
	icon_state = "sec1"
	icon_closed = "sec"
	icon_locked = "sec1"
	icon_opened = "secopen"
	icon_off = "secoff"

/obj/structure/closet/secure_closet/security_torch/WillContain()
	return list(
		/obj/item/clothing/suit/armor/pcarrier/medium/security,
		/obj/item/clothing/head/helmet/solgov/security,
		/obj/item/weapon/cartridge/security,
		/obj/item/device/radio/headset/headset_sec,
		/obj/item/weapon/storage/belt/security,
		/obj/item/device/flash,
		/obj/item/weapon/reagent_containers/spray/pepper,
		/obj/item/weapon/grenade/chem_grenade/teargas,
		/obj/item/weapon/melee/baton/loaded,
		/obj/item/clothing/glasses/sunglasses/sechud/goggles,
		/obj/item/taperoll/police,
		/obj/item/device/hailer,
		/obj/item/clothing/accessory/storage/black_vest,
		/obj/item/weapon/gun/energy/taser,
		/obj/item/device/megaphone,
		/obj/item/clothing/gloves/thick,
		/obj/item/clothing/accessory/holster/thigh,
		/obj/item/device/holowarrant,
		/obj/item/device/flashlight/maglight,
		new /datum/atom_creator/weighted(list(/obj/item/weapon/storage/backpack/security, /obj/item/weapon/storage/backpack/satchel_sec)),
		new /datum/atom_creator/weighted(list(/obj/item/weapon/storage/backpack/dufflebag/sec, /obj/item/weapon/storage/backpack/messenger/sec))
	)


/obj/structure/closet/secure_closet/seccomm
	name = "Security Commander's locker"
	req_access = list(access_hos)
	icon_state = "hossecure1"
	icon_closed = "hossecure"
	icon_locked = "hossecure1"
	icon_opened = "hossecureopen"
	icon_off = "hossecureoff"
/* AWAITING OVERHAUL
/obj/structure/closet/secure_closet/cos/WillContain()
	return list(
		/obj/item/clothing/suit/armor/pcarrier/medium/command/security,
		/obj/item/clothing/head/helmet/solgov/command,
		/obj/item/clothing/head/HoS/dermal,
		/obj/item/weapon/cartridge/hos,
		/obj/item/device/radio/headset/heads/cos,
		/obj/item/clothing/glasses/sunglasses/sechud/goggles,
		/obj/item/taperoll/police,
		/obj/item/weapon/handcuffs,
		/obj/item/weapon/storage/belt/security,
		/obj/item/device/flash,
		/obj/item/device/megaphone,
		/obj/item/weapon/melee/baton/loaded,
		/obj/item/weapon/gun/energy/gun,
		/obj/item/clothing/accessory/holster/thigh,
		/obj/item/weapon/melee/telebaton,
		/obj/item/weapon/reagent_containers/spray/pepper,
		/obj/item/clothing/accessory/storage/black_vest,
		/obj/item/weapon/gun/energy/taser,
		/obj/item/device/hailer,
		/obj/item/weapon/clipboard,
		/obj/item/weapon/folder/red,
		/obj/item/device/holowarrant,
		/obj/item/clothing/gloves/thick,
		/obj/item/device/flashlight/maglight,
		new /datum/atom_creator/weighted(list(/obj/item/weapon/storage/backpack/security, /obj/item/weapon/storage/backpack/satchel_sec)),
		new /datum/atom_creator/weighted(list(/obj/item/weapon/storage/backpack/dufflebag/sec, /obj/item/weapon/storage/backpack/messenger/sec))
	)
*/
/obj/structure/closet/secure_closet/brigofficer
	name = "brig officer's locker"
	req_access = list(access_armory)
	icon_state = "wardensecure1"
	icon_closed = "wardensecure"
	icon_locked = "wardensecure1"
	icon_opened = "wardensecureopen"
	icon_off = "wardensecureoff"

/obj/structure/closet/secure_closet/brigofficer/WillContain()
	return list(
		/obj/item/clothing/suit/armor/pcarrier/medium/security,
		/obj/item/clothing/head/helmet/solgov/security,
		/obj/item/weapon/cartridge/hos,
		/obj/item/device/radio/headset/headset_sec,
		/obj/item/clothing/glasses/sunglasses/sechud/goggles,
		/obj/item/taperoll/police,
		/obj/item/weapon/storage/belt/security,
		/obj/item/weapon/reagent_containers/spray/pepper,
		/obj/item/weapon/melee/baton/loaded,
		/obj/item/weapon/gun/energy/gun,
		/obj/item/clothing/accessory/holster/thigh,
		/obj/item/clothing/accessory/storage/black_vest,
		/obj/item/weapon/gun/energy/taser,
		/obj/item/weapon/handcuffs,
		/obj/item/device/hailer,
		/obj/item/device/flash,
		/obj/item/device/megaphone,
		/obj/item/weapon/hand_labeler,
		/obj/item/device/holowarrant,
		/obj/item/clothing/gloves/thick,
		/obj/item/device/flashlight/maglight,
		new /datum/atom_creator/weighted(list(/obj/item/weapon/storage/backpack/security, /obj/item/weapon/storage/backpack/satchel_sec)),
		new /datum/atom_creator/weighted(list(/obj/item/weapon/storage/backpack/dufflebag/sec, /obj/item/weapon/storage/backpack/messenger/sec))
	)

/obj/structure/closet/secure_closet/forensics
	name = "forensics technician's locker"
	req_access = list(access_forensics_lockers)
	icon_state = "sec1"
	icon_closed = "sec"
	icon_locked = "sec1"
	icon_opened = "secopen"
	icon_off = "secoff"

/obj/structure/closet/secure_closet/forensics/WillContain()
	return list(
		/obj/item/clothing/gloves/forensic,
		/obj/item/device/radio/headset/headset_sec,
		/obj/item/clothing/suit/armor/vest/detective,
		/obj/item/clothing/head/helmet/solgov/security,
		/obj/item/clothing/suit/armor/pcarrier/medium/security,
		/obj/item/weapon/gun/energy/taser,
		/obj/item/clothing/accessory/holster/thigh,
		/obj/item/device/flash,
		/obj/item/weapon/melee/baton/loaded,
		/obj/item/weapon/reagent_containers/spray/pepper,
		/obj/item/weapon/storage/belt/security,
		/obj/item/taperoll/police,
		/obj/item/weapon/storage/box/evidence,
		/obj/item/weapon/storage/box/swabs,
		/obj/item/weapon/storage/box/gloves,
		/obj/item/weapon/storage/briefcase/crimekit,
		/obj/item/weapon/folder/red,
		/obj/item/device/taperecorder,
		/obj/item/device/tape/random = 3,
		/obj/item/weapon/forensics/sample_kit/powder,
		/obj/item/weapon/forensics/sample_kit,
		/obj/item/device/uv_light,
		/obj/item/weapon/reagent_containers/spray/luminol,
		/obj/item/weapon/reagent_containers/syringe,
		/obj/item/clothing/suit/storage/toggle/labcoat,
		/obj/item/clothing/glasses/sunglasses/sechud/toggle,
		/obj/item/device/holowarrant,
		/obj/item/device/flashlight/maglight,
		new /datum/atom_creator/weighted(list(/obj/item/weapon/storage/backpack/security, /obj/item/weapon/storage/backpack/satchel_sec)),
		new /datum/atom_creator/weighted(list(/obj/item/weapon/storage/backpack/dufflebag/sec, /obj/item/weapon/storage/backpack/messenger/sec))
	)

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
		/obj/item/weapon/storage/box/handcuffs
	)

/obj/structure/closet/secure_closet/mtf/commander
	name = "MTF Commander Locker"
	req_access = list(access_forensics_lockers)
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
		/obj/item/weapon/storage/box/handcuffs
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
		/obj/item/weapon/storage/box/handcuffs
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
		/obj/item/weapon/storage/box/handcuffs
	)

/obj/structure/closet/secure_closet/administration/facilityadmin
	name = "facility director's locker"
	req_access = list(access_adminlvl5)
	icon_state = "flocked"
	icon_closed = "funlocked"
	icon_locked = "flocked"
	icon_opened = "fopen"
	icon_off = "foff"

/obj/structure/closet/secure_closet/administration/facilityadmin/WillContain()
	return list(
		/obj/item/clothing/under/scp/suittie,
		/obj/item/clothing/shoes/dress,
		/obj/item/device/radio,
		/obj/item/clothing/suit/storage/toggle/suit/black,
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
		/obj/item/weapon/storage/box/mtf/empammo,
		/obj/item/weapon/storage/box/mtf/empammo,
		/obj/item/weapon/storage/box/mtf/empammo,
		/obj/item/weapon/storage/box/mtf/pelletammo,
		/obj/item/weapon/storage/box/mtf/pelletammo,
		/obj/item/weapon/storage/box/mtf/pelletammo,
		/obj/item/weapon/storage/box/mtf/pelletammo,
	)
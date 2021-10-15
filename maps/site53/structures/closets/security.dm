/*
 * Site 53 Security
 */

// MTF LOCKERS

/*
 * Torch Security
 */

// MTF LOCKERS

/obj/structure/closet/secure_closet/mtf
	name = "MTF Locker - NO USE, ONLY FOR CODE."
	req_access = list(access_mtflvl1)
	icon_state = "enlistedlocked"
	var/registered_name = null

/obj/structure/closet/secure_closet/mtf/WillContain()
	return list(
	)

/obj/structure/closet/secure_closet/mtf/enlisted
	name = "Junior Guard's Locker"
	req_access = list(access_mtflvl1)
	icon_state = "enlistedlocked"

/obj/structure/closet/secure_closet/mtf/enlisted/WillContain()
	return list(
		/obj/item/clothing/under/scp/utility/security,
//		/obj/item/clothing/head/helmet/scp/security,
		/obj/item/device/flashlight/maglight,
		/obj/item/clothing/accessory/storage/black_vest,
//		/obj/item/clothing/suit/armor/vest/scp/medarmor,
		/obj/item/clothing/glasses/sunglasses/sechud/goggles,
//		/obj/item/storage/belt/security/tactical,
//		/obj/item/gun/projectile/automatic/scp/p90,
		/obj/item/ammo_magazine/scp/p90_mag = 2,
		/obj/item/ammo_magazine/scp/p90_mag/rubber = 4,
//		/obj/item/ammo_magazine/box/a10mm,
		/obj/item/melee/telebaton,
		/obj/item/handcuffs = 2,
		/obj/item/reagent_containers/spray/pepper,
//		/obj/item/clothing/gloves/tactical/scp,
//		/obj/item/clothing/accessory/holster/thigh,
		/obj/item/device/flash,
		/obj/item/clothing/accessory/solgov/department/security/marine,
		/obj/item/clothing/mask/balaclava,
//		/obj/item/storage/box/bloodtypes,
//		/obj/item/ammo_magazine/box/c9mm,
		/obj/item/gun/projectile/pistol,
//		/obj/item/ammo_magazine/mc9mm = 4
	)

/obj/structure/closet/secure_closet/mtf/commander
	name = "Guard Commander Locker"
	req_access = list(access_mtflvl5)
	icon_state = "cmlocked"

/obj/structure/closet/secure_closet/mtf/commander/WillContain()
	return list(
		/obj/item/clothing/under/scp/utility/security/gc,
//		/obj/item/clothing/head/helmet/scp/security,
//		/obj/item/clothing/suit/armor/vest/scp/pizdeckakoyarmor,
		/obj/item/clothing/glasses/sunglasses/sechud/goggles,
//		/obj/item/storage/belt/security/tactical,
//		/obj/item/gun/projectile/automatic/scp/p90,
		/obj/item/ammo_magazine/scp/p90_mag = 2,
		/obj/item/ammo_magazine/scp/p90_mag/rubber = 4,
//		/obj/item/ammo_magazine/box/a10mm,
		/obj/item/melee/telebaton,
		/obj/item/handcuffs = 2,
		/obj/item/device/flashlight/maglight,
//		/obj/item/clothing/gloves/tactical/scp,
		/obj/item/device/flash,
		/obj/item/clothing/accessory/storage/black_vest,
//		/obj/item/clothing/accessory/holster/thigh,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/clothing/accessory/solgov/department/security/marine,
		/obj/item/clothing/mask/balaclava,
//		/obj/item/storage/box/bloodtypes,
//		/obj/item/gun/projectile/revolver/mateba,
//		/obj/item/ammo_magazine/box/a50donor,
//		/obj/item/ammo_magazine/c50 = 2,
//		/obj/item/ammo_magazine/box/c9mm,
		/obj/item/gun/projectile/pistol,
//		/obj/item/ammo_magazine/mc9mm = 2
	)

/obj/structure/closet/secure_closet/mtf/nco
	name = "Guard's Locker"
	req_access = list(access_mtflvl3)
	icon_state = "nlocked"

/obj/structure/closet/secure_closet/mtf/nco/WillContain()
	return list(
		/obj/item/clothing/under/scp/utility/security,
//		/obj/item/clothing/head/helmet/scp/security,
//		/obj/item/clothing/suit/armor/vest/scp/medarmor,
		/obj/item/clothing/glasses/sunglasses/sechud/goggles,
//		/obj/item/storage/belt/security/tactical,
//		/obj/item/gun/projectile/sec/sec,
//		/obj/item/ammo_magazine/c45m = 4,
//		/obj/item/gun/projectile/automatic/scp/p90,
		/obj/item/ammo_magazine/scp/p90_mag = 2,
		/obj/item/ammo_magazine/scp/p90_mag/rubber = 4,
//		/obj/item/ammo_magazine/box/a10mm,
		/obj/item/melee/telebaton,
		/obj/item/handcuffs = 2,
//		/obj/item/ammo_magazine/box/c45donor,
//		/obj/item/ammo_magazine/box/c45donor/rubber,
//		/obj/item/storage/box/ifak,
//		/obj/item/clothing/gloves/tactical/scp,
		/obj/item/device/flash,
		/obj/item/device/flashlight/maglight,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/clothing/accessory/storage/black_vest,
		/obj/item/clothing/accessory/solgov/department/security/marine,
//		/obj/item/clothing/accessory/holster/thigh,
		/obj/item/clothing/mask/balaclava,
//		/obj/item/storage/box/bloodtypes,
		/obj/item/gun/projectile/pistol,
//		/obj/item/ammo_magazine/mc9mm = 2
	)

/obj/structure/closet/secure_closet/mtf/co
	name = "Zone Commander's Locker"
	req_access = list(access_mtflvl4)
	icon_state = "colocked"

/obj/structure/closet/secure_closet/mtf/co/WillContain()
	return list(
		/obj/item/clothing/under/scp/utility/security/zc,
//		/obj/item/clothing/head/helmet/scp/security,
//		/obj/item/clothing/suit/armor/vest/scp/pizdeckakoyarmor,
//		/obj/item/storage/belt/security/tactical,
//		/obj/item/gun/projectile/automatic/scp/m16,
		/obj/item/clothing/glasses/sunglasses/sechud/goggles,
		/obj/item/ammo_magazine/scp/m16_mag = 3,
//		/obj/item/gun/projectile/automatic/scp/p90,
		/obj/item/ammo_magazine/scp/p90_mag = 2,
		/obj/item/ammo_magazine/scp/p90_mag/rubber = 4,
//		/obj/item/ammo_magazine/box/a10mm,
		/obj/item/clothing/accessory/storage/webbing_large,
		/obj/item/melee/telebaton,
		/obj/item/clothing/accessory/solgov/department/security/marine,
		/obj/item/handcuffs = 2,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/device/flash,
		/obj/item/device/flashlight/maglight,
//		/obj/item/clothing/gloves/tactical/scp,
//		/obj/item/clothing/accessory/holster/thigh,
		/obj/item/clothing/mask/balaclava,
//		/obj/item/storage/box/bloodtypes,
//		/obj/item/gun/projectile/revolver/mateba,
//		/obj/item/ammo_magazine/box/a50donor,
//		/obj/item/ammo_magazine/c50 = 4,
		/obj/item/gun/projectile/pistol,
//		/obj/item/ammo_magazine/mc9mm = 2
	)

/obj/structure/closet/secure_closet/mtf/breachautomatics
	name = "automatic weapons locker"
	req_access = list(access_mtflvl2)
	icon_state = "sec1"

/obj/structure/closet/secure_closet/mtf/breachautomatics/WillContain()
	return list(
//		/obj/item/gun/projectile/automatic/scp/m16,
//		/obj/item/gun/projectile/automatic/scp/m16,
//		/obj/item/gun/projectile/automatic/scp/m16,
		/obj/item/ammo_magazine/scp/m16_mag = 9
	)


/obj/structure/closet/secure_closet/mtf/breachshotguns
	name = "tactical shotgun locker"
	req_access = list(access_mtflvl2)
	icon_state = "sec1"

/obj/structure/closet/secure_closet/mtf/breachshotguns/WillContain()
	return list(
//		/obj/item/gun/projectile/shotgun/tactical,
//		/obj/item/gun/projectile/shotgun/tactical,
//		/obj/item/gun/projectile/shotgun/tactical,
//		/obj/item/storage/box/mtf/empammo = 6,
//		/obj/item/storage/box/mtf/pelletammo = 6
	)

/obj/structure/closet/secure_closet/mtf/riotshotguns
	name = "riot shotgun locker"
	req_access = list(access_mtflvl1)
	icon_state = "sec1"

/obj/structure/closet/secure_closet/mtf/riotshotguns/WillContain()
	return list(
//		/obj/item/gun/projectile/shotgun/tactical/beanbag = 3,
//		/obj/item/storage/box/mtf/beanbag = 6,
//		/obj/item/clothing/accessory/storage/bandolier/beanbag = 3
	)

/obj/structure/closet/secure_closet/mtf/attackby(var/obj/item/W, var/mob/user)
	if (src.opened)
		..()
	else if(W.GetIdCard())
		var/obj/item/card/id/I = W.GetIdCard()

		if(!I || !I.registered_name)
			return
		if(togglelock(user, I))
			if(!src.registered_name)
				src.registered_name = I.registered_name
				src.name += " ([I.registered_name])"
				src.desc = "Owned by [I.registered_name]."
		else
			to_chat(user, "<span class='warning'>Access Denied</span>")
	else
		..()

/obj/structure/closet/secure_closet/mtf/CanToggleLock(var/mob/user, var/obj/item/card/id/id_card)
	return ..() || (istype(id_card) && id_card.registered_name && (!registered_name || (registered_name == id_card.registered_name)))

/obj/structure/closet/secure_closet/mtf/verb/reset()
	set src in oview(1) // One square distance
	set category = "Object"
	set name = "Reset Lock"
	if(!CanPhysicallyInteract(usr)) // Don't use it if you're not able to! Checks for stuns, ghost and restrain
		return
	if(ishuman(usr))
		src.add_fingerprint(usr)
		if (src.locked || !src.registered_name)
			to_chat(usr, "<span class='warning'>You need to unlock it first.</span>")
		else if (src.broken)
			to_chat(usr, "<span class='warning'>It appears to be broken.</span>")
		else
			if (src.opened)
				if(!src.close())
					return
			src.locked = 1
//			src.icon_state = src.icon_locked
			src.registered_name = null
			src.SetName(initial(name))
			src.desc = initial(desc)

/obj/structure/closet/secure_closet/mtf/exp
	name = "Scout's Locker"
	req_access = list(access_mtflvl3)
	icon_state = "nlocked"

/obj/structure/closet/secure_closet/mtf/exp/WillContain()
	return list(
		/obj/item/clothing/suit/bio_suit/security,
		/obj/item/clothing/head/bio_hood/security,
//		/obj/item/storage/belt/security/tactical,
		/obj/item/storage/backpack/satchel,
		/obj/item/storage/backpack/dufflebag,
		/obj/item/grenade/frag = 2,
		/obj/item/crowbar/prybar,
		/obj/item/taperoll/research,
		/obj/item/device/tape/random = 4,
		/obj/item/device/radio,
		/obj/item/device/taperecorder,
		/obj/item/device/flashlight/maglight,
//		/obj/item/gun/projectile/colt/officer,
//		/obj/item/gun/projectile/automatic/tactical,
//		/obj/item/ammo_magazine/tac9mm = 6,
//		/obj/item/storage/pill_bottle/amnesticsb,
		/obj/item/storage/box/freezer
	)

/obj/structure/closet/secure_closet/mtf/expl
	name = "Scout's Leader Locker"
	req_access = list(access_mtflvl5)
	icon_state = "cmlocked"

/obj/structure/closet/secure_closet/mtf/expl/WillContain()
	return list(
		/obj/item/clothing/suit/bio_suit/security,
		/obj/item/clothing/head/bio_hood/security,
//		/obj/item/storage/belt/security/tactical,
		/obj/item/material/hatchet/machete = 5,
//		/obj/item/storage/pill_bottle/amnesticsb,
		/obj/item/storage/backpack/satchel,
		/obj/item/storage/backpack/dufflebag,
		/obj/item/grenade/frag = 2,
		/obj/item/device/tape/random = 4,
		/obj/item/device/radio,
		/obj/item/device/taperecorder,
		/obj/item/crowbar/prybar,
		/obj/item/device/flashlight/maglight,
//		/obj/item/gun/projectile/revolver/tactical,
//		/obj/item/gun/projectile/automatic/hcrifle,
//		/obj/item/ammo_magazine/a762 = 6,
		/obj/item/material/hatchet/machete/deluxe
	)
